package Net::Mesos::Role::Scheduler;
use Moo::Role;
use strict;
use warnings;
use Net::Mesos::Channel;
use Net::Mesos::Utils qw(as_message);
use Mesos::Messages;

has channel => (
    is      => 'ro',
    default => sub { Net::Mesos::Channel->new },
);

requires qw(
    registered
    reregistered
    disconnected
    resourceOffers
    offerRescinded
    statusUpdate
    frameworkMessage
    slaveLost
    executorLost
    error
);


1;
