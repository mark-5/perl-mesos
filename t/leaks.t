#!/usr/bin/perl
use strict;
use warnings;
use FindBin::libs;
use Mesos::SchedulerDriver;
use Mesos::Test::Utils;
use Test::More;
use Test::LeakTrace;

no_leaks_ok {
    my $driver = Mesos::SchedulerDriver->new(
        scheduler => test_scheduler,
        master    => test_master,
        framework => test_framework,
    );
} 'Mesos::SchedulerDriver construction does not leak';

use Mesos::Channel;
no_leaks_ok {
    my $channel = Mesos::Channel->new;
} 'Mesos::Channel construction does not leak';

use Mesos::Messages;
no_leaks_ok {
    my $channel = Mesos::Channel->new;
    my $sent_command = "test command";
    my @sent_args = (
        'string',
        [qw(array of strings)],
        Mesos::FrameworkID->new({value => 'single'}),
        [Mesos::FrameworkID->new({value => 'an'}), Mesos::FrameworkID->new({value => 'array'})]
    );
    $channel->send($sent_command, @sent_args);
    $channel->recv;
} 'Mesos::Channel sent data without leak';

use Mesos::Dispatcher::AnyEvent;
no_leaks_ok {
    my $channel = Mesos::Dispatcher::AnyEvent->new;
} 'Mesos::Dispatcher::AnyEvent does not leak';

use Mesos::Dispatcher::Interrupt;
no_leaks_ok {
    my $channel = Mesos::Dispatcher::Interrupt->new;
} 'Meso::Dispatcher::Interrupt does not leak';


done_testing();
