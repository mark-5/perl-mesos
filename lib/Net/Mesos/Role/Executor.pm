package Net::Mesos::Role::Executor;
use Moo::Role;
use strict;
use warnings;

use Net::Mesos::Channel;

has channel => (
    is      => 'ro',
    default => sub { Net::Mesos::Channel->new },
);

requires qw(
    registered
    reregistered
    disconnected
    launchTask
    killTask
    frameworkMessage
    shutdown
    error
);


1;
