package Net::Mesos::Test::SchedulerDriver;
use Moo;
use strict;
use warnings;

use Net::Mesos::Test::Channel;

has scheduler => (
    is       => 'ro',
    required => 1,
);

has channel => (
    is => 'rw',
);

sub BUILD {
    my ($self) = @_;
    $self->channel($self->scheduler->channel);
}

with 'Net::Mesos::Role::Dispatcher';


1;
