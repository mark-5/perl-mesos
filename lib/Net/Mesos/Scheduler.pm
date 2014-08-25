package Net::Mesos::Scheduler;
use Moo;
use strict;
use warnings;

with 'Net::Mesos::Role::Scheduler';

sub registered {}
sub reregistered {}
sub disconnected {}
sub resourceOffers {}
sub offerRescinded {}
sub statusUpdate {}
sub frameworkMessage {}
sub slaveLost {}
sub executorLost {}
sub error {}

1;
