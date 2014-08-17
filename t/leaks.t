#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

BEGIN {
    plan skip_all => 'require Test::LeakTrace'
        unless eval{ require Test::LeakTrace };
}
use Test::LeakTrace;

use Net::Mesos::SchedulerDriver;
no_leaks_ok {
    my $driver = Net::Mesos::SchedulerDriver->new;
} 'Net::Mesos::SchedulerDriver construction does not leak';

use Net::Mesos::SchedulerChannel;
no_leaks_ok {
    my $channel = Net::Mesos::SchedulerChannel->new;
} 'Net::Mesos::SchedulerChannel construction does not leak';

done_testing();
