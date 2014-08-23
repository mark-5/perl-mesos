use strict;
use warnings;
use FindBin::libs;
use Test::More;
use Net::Mesos::Test::Utils;

use_ok('Net::Mesos::SchedulerDriver');

my $driver = Net::Mesos::SchedulerDriver->new(
    scheduler => test_scheduler,
    master    => test_master,
    framework => test_framework
);
isa_ok($driver, 'Net::Mesos::SchedulerDriver');

ok($driver->does('Net::Mesos::Role::Dispatcher'), 'driver does Net::Mesos::Role::Dispatcher');

my $channel = $driver->channel;
isa_ok($channel, 'Net::Mesos::Channel');


done_testing;
