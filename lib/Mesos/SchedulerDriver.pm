package Mesos::SchedulerDriver;
use Mesos;
use Mesos::Messages;
use Mesos::Channel;
use Moo;
use Types::Standard qw(:all);
use Type::Params qw(validate);
use Mesos::Types qw(:all);
use strict;
use warnings;

=head1 NAME

Mesos::SchedulerDriver - perl driver for Mesos schedulers

=cut

sub BUILD {
    my ($self) = @_;
    return $self->xs_init(grep {$_} map {$self->$_} qw(framework master credential));
}

has scheduler => (
    is       => 'ro',
    isa      => Scheduler,
    required => 1,
);

has framework => (
    is       => 'ro',
    isa      => FrameworkInfo,
    coerce   => 1,
    required => 1,
);

has master => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has credential => (
    is     => 'ro',
    isa    => Credential,
    coerce => 1,
);

has channel => (
    is       => 'ro',
    isa      => Channel,
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
with 'Mesos::Role::Dispatcher';

after start => sub {
    my ($self) = @_;
    $self->dispatch_events;
};

after $_ => sub {
    my ($self) = @_;
    $self->stop_dispatch;
} for qw(stop abort);

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

around requestResources => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, ArrayRef[Request]));
};

around launchTasks => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, ArrayRef[OfferID], ArrayRef[TaskInfo], Optional[Filters]));
};

around launchTask => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, OfferID, ArrayRef[TaskInfo], Optional[Filters]));
};

around killTask => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, TaskID));
};

around declineOffer => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, OfferID, Optional[Filters]));
};

around sendFrameworkMessage => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, ExecutorID, SlaveID, Str));
};

around reconcileTasks => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, ArrayRef[TaskStatus]));
};

=head1 METHODS

=over 4

=item new(scheduler => $scheduler, framework => $frameworkInfo, master => $master, credentials => $credentials)

=item start()

=item stop($failover)

=item abort()

=item join()

=item run()

=item requestResources($requests)

=item launchTasks($offerIds, $tasks, $filters)

=item launchTask($offerId, $tasks, $filters)

=item killTask($taskId)

=item declineOffer($offerId, $filters)

=item reviveOffers()

=item sendFrameworkMessage($executorId, $slaveId, $data)

=item reconcileTasks($statuses)

=back

=cut

1;
