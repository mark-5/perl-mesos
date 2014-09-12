#!/usr/bin/perl
use strict;
use warnings;
use FindBin::libs;
use Test::More;
use Net::Mesos::Test::Utils;

BEGIN {
    plan skip_all => 'require Test::LeakTrace'
        unless eval{ require Test::LeakTrace };
}
use Test::LeakTrace;

use Net::Mesos::SchedulerDriver;
no_leaks_ok {
    my $driver = Net::Mesos::SchedulerDriver->new(
        scheduler => test_scheduler,
        master    => test_master,
        framework => test_framework,
    );
} 'Net::Mesos::SchedulerDriver construction does not leak';

use Net::Mesos::Channel;
no_leaks_ok {
    my $channel = Net::Mesos::Channel->new;
} 'Net::Mesos::Channel construction does not leak';

use Mesos::Messages;
my $channel = Net::Mesos::Channel->new;
no_leaks_ok {
    my $sent_command = "test command";
    my @sent_args = ('string',
                     [qw(array of strings)],
                     Mesos::FrameworkID->new({value => 'single'}),
                     [Mesos::FrameworkID->new({value => 'an'}), Mesos::FrameworkID->new({value => 'array'})]
                  );
    $channel->send($sent_command, @sent_args);
    $channel->recv;
} 'Net::Mesos::Channel sent data without leak';

no_leaks_ok {
    my $driver = Net::Mesos::SchedulerDriver->new(
        scheduler => test_scheduler,
        master    => test_master,
        framework => test_framework,
    );
    my $channel = $driver->channel;
} 'Net::Mesos::Channel construction from driver does not leak';

done_testing();
