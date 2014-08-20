use strict;
use warnings;
use Test::More;
use Net::Mesos::Test::Utils;

use_ok('Net::Mesos::SchedulerDriver');

my $driver = Net::Mesos::SchedulerDriver->new(
    scheduler => test_scheduler,
    master    => test_master,
    framework => test_framework
);
isa_ok($driver, 'Net::Mesos::SchedulerDriver');

my $channel = $driver->channel;
isa_ok($channel, 'Net::Mesos::SchedulerChannel');

done_testing;
