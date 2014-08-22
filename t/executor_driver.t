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

my $proxy = $driver->proxy_executor;
isa_ok($proxy, 'Net::Mesos::ProxyExecutor');


done_testing;
