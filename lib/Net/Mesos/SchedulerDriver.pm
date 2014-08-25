package Net::Mesos::SchedulerDriver;
use Net::Mesos;
use Mesos::Messages;
use Net::Mesos::Utils qw(encode_protobufs);
use Moo;
use Types::Standard qw(Str);
use strict;
use warnings;

sub BUILD {
    my ($self) = @_;
    my @encoded = encode_protobufs grep {$_} map {$self->$_} qw(framework master credentials);
    return $self->xs_init(@encoded);
}

has scheduler => (
    is       => 'ro',
    required => 1,
);

has framework => (
    is       => 'ro',
    isa      => sub {shift->isa('Mesos::FrameworkInfo')},
    required => 1,
);

has master => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has credentials => (
    is => 'ro',
    isa => sub {shift->isa('Mesos::Credential')},
);

has channel => (
    is       => 'ro',
    isa      => sub {shift->isa('Net::Mesos::Channel')},
    builder  => 1,
    # this needs to be lazy so that BUILD runs xs_init first
    lazy     => 1,
);

sub _build_channel {
    my ($self) = @_;
    return $self->_channel;
}


has process => (
    is      => 'ro',
    builder => 1,
    lazy    => 1,
);

sub _build_process {
    my ($self) = @_;
    return $self->scheduler;
}

# need to apply this after declaring channel and process
with 'Net::Mesos::Role::Dispatcher';


my @needs_wrapped = qw(
    stop
    requestResources
    launchTasks
    killTask
    declineOffer
    reviveOffers
    sendFrameworkMessage
    reconcileTasks
);


my $wrap_protobufs = sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(encode_protobufs @args);
};

around $_ => $wrap_protobufs for @needs_wrapped;


after start => sub {
    my ($self) = @_;
    $self->dispatch_events;
};

after stop => sub {
    my ($self) = @_;
    $self->stop_dispatch;
};

sub run {
    my ($self) = @_;
    $self->start;
    $self->join;
}

sub join {
    my ($self) = @_;
    $self->dispatch_loop;
    return $self->status;
}

1;
