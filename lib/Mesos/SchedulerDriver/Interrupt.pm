package Mesos::SchedulerDriver::Interrupt;
use Mesos::Channel::Interrupt;
use Mesos::Types qw(Channel);
use Mesos::Messages;
use Moo;

has channel => (
    is       => 'ro',
    isa      => Channel,
    builder  => 1,
    # this needs to be lazy so that BUILD runs xs_init first
    lazy     => 1,
);

sub _build_channel {
    my ($self) = @_;
    return Mesos::Channel::Interrupt->new(callback => sub { $self->dispatch_events });
}

with 'Mesos::Role::SchedulerDriver';


sub xs_init {
    my ($self) = @_;
    return $self->_xs_init(grep {$_} map {$self->$_} qw(framework master channel credential));
}

sub join {
    my ($self) = @_;
    sleep 1 while $self->status == Mesos::Status::DRIVER_RUNNING;
}

sub dispatch_events {
    my ($self) = @_;
    my $channel = $self->channel;
    while (my ($event, @args) = $channel->recv) {
        $self->scheduler->$event($self, @args);
    }
}

1;
