use strict;
use warnings;
use Test::More;
use Net::Mesos::Test::Utils;

use_ok('Net::Mesos::ProxyScheduler');

my $proxy = Net::Mesos::ProxyScheduler->new;
isa_ok($proxy, 'Net::Mesos::ProxyScheduler');


done_testing;
