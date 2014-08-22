use strict;
use warnings;
use FindBin::libs;
use Test::More;
use Net::Mesos::Test::Utils;

use_ok('Net::Mesos::ProxyExecutor');

my $proxy = Net::Mesos::ProxyExecutor->new;
isa_ok($proxy, 'Net::Mesos::ProxyExecutor');


done_testing;
