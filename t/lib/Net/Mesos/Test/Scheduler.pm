package Net::Mesos::Test::Scheduler;
use Moo;
use strict;
use warnings;

use Net::Mesos::SchedulerChannel;

has channel => (
    is      => 'ro',
    default => sub { Net::Mesos::SchedulerChannel->new },
);

has return => (
    is      => 'rw',
    default => sub { {} },
);

has event_1 => (
    is  => 'rw',
    isa => sub { ref shift eq 'CODE' },
);

sub call_event_1 {
    my ($self, @args) = @_;
    $self->event_1->($self, @args);
}

has event_2 => (
    is => 'rw',
    isa => sub { ref shift eq 'CODE' },
);

sub call_event_2 {
    my ($self, @args) = @_;
    $self->event_2->($self, @args);
}

1;
