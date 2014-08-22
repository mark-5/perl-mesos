package Net::Mesos::Dispatcher;
use strict;
use warnings;
use Moo::Role;
use AE;

requires 'channel';

sub dispatch_events {
    my ($self) = @_;
}


1;
