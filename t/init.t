#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use_ok('Net::Mesos');

use_ok('Net::Mesos::SchedulerDriver');
can_ok('Net::Mesos::SchedulerDriver', 'new');
my $driver = Net::Mesos::SchedulerDriver->new;
isa_ok($driver, 'Net::Mesos::SchedulerDriver');

use_ok('Net::Mesos::SchedulerChannel');
my $channel = Net::Mesos::SchedulerChannel->new;
isa_ok($channel, 'Net::Mesos::SchedulerChannel');

done_testing();
