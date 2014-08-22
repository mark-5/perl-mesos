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
    isa      => sub {shift->isa('Net::Mesos::SchedulerChannel')},
    builder  => 1,
    # this needs to be lazy so that BUILD runs xs_init first
    lazy     => 1,
);

sub _build_channel {
    my ($self) = @_;
    return $self->_channel;
}

# need to apply this after declaring channel
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

sub run {
    my ($self) = @_;
    $self->start;
    $self->join;
}

sub join {
    my ($self) = @_;
    $self->dispatch_loop;
}

1;
