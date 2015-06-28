package Mesos::Test::Scheduler;
use Mesos::Messages;
use Moo;
extends 'Mesos::Scheduler';

has events => (
    is      => 'ro',
    default => sub { [] },
);
sub add_event  { push @{$_[0]->events}, $_[1] }
sub last_event { shift->events->[-1] }

has tasks => (
    is      => 'ro',
    default => sub { [] },
);

sub registered {
    my ($self, $driver, $frameworkId, $masterInfo) = @_;
    $self->add_event(['registered', $frameworkId, $masterInfo]);
}

sub resourceOffers {
    my ($self, $driver, $offers) = @_;
    $self->add_event(['resourceOffers', $offers]);

    for my $offer (@$offers) {
        my $tasks = $self->tasks;
        for my $task (@$tasks) {
            $task->{slave_id} //= $offer->{slave_id};
        }
        $driver->launchTasks([$offer->{id}], $tasks);
    }
}

1;
