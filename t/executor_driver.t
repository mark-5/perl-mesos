use strict;
use warnings;
use FindBin::libs;
use Test::More;
use Net::Mesos::Test::Utils;

use_ok('Net::Mesos::ExecutorDriver');

my $driver = Net::Mesos::ExecutorDriver->new(
    executor => test_executor,
);
isa_ok($driver, 'Net::Mesos::ExecutorDriver');

ok($driver->does('Net::Mesos::Role::Dispatcher'), 'driver does Net::Mesos::Role::Dispatcher');

my $channel = $driver->channel;
isa_ok($channel, 'Net::Mesos::Channel');


done_testing;
