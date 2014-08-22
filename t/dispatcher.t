use strict;
use warnings;
use FindBin::libs;
use Test::More;
use Net::Mesos::Test::Utils;
use Try::Tiny;
use AE;

use Net::Mesos::Test::Scheduler;
use Net::Mesos::Test::SchedulerDriver;

my $scheduler = Net::Mesos::Test::Scheduler->new;
my $schedulerDriver = Net::Mesos::Test::SchedulerDriver->new(scheduler => $scheduler);
test_dispatcher($scheduler, $schedulerDriver, 'scheduler');

use Net::Mesos::Test::Executor;
use Net::Mesos::Test::ExecutorDriver;
my $executor = Net::Mesos::Test::Executor->new;
my $executorDriver = Net::Mesos::Test::ExecutorDriver->new(executor => $executor);
test_dispatcher($executor, $executorDriver, 'executor');



done_testing;


sub no_timeout {
    my (%args) = @_;
    my $timedout;
    my $timeout = "timeout\n";
    try {
        local $SIG{ALRM} = sub { die $timeout };
        alarm($args{timeout} || 1);
        $args{cb}->();
        alarm 0;
    } catch {
        $timedout++ if $_ eq $timeout;
    };
    return !$timedout;
}

sub test_dispatcher {
    my ($process, $driver, $test_name) = @_;

    ok no_timeout(cb => sub {$driver->dispatch_event}), "$test_name dispatch_event does not block";
    ok !no_timeout(cb => sub {$driver->dispatch_loop}), "$test_name dispatch_loop blocks";

    $driver->dispatch_events;
    my $ev1_cv = AE::cv;
    my @ev1 = qw(call_event_1 return_value_1);
    $process->event_1(sub {
        my ($self, $ev1_driver, @args) = @_;
        $self->return->{event_1} = [$ev1_driver, @args];
        $ev1_cv->send;
    });
    $driver->channel->send(@ev1);
    ok no_timeout(cb => sub {$ev1_cv->recv}), "successfully recv'd $test_name event_1";
    is_deeply($process->return->{event_1}, [$driver, $ev1[1]], "$test_name event_1 passed expected args");
    undef $ev1_cv;


    ok !no_timeout(cb => sub {$driver->dispatch_loop}), "no pending $test_name events after recv";


    my $ev2_cv = AE::cv;
    my @ev2 = qw(call_event_2 return_value_2);
    $process->event_2(sub {
        my ($self, $ev2_driver, @args) = @_;
        $self->return->{event_2} = [$ev2_driver, @args];
        $ev2_cv->send;
    });
    $driver->channel->send(@ev2);
    ok no_timeout(cb => sub {$ev2_cv->recv}), "successfully recv'd $test_name event_2";
    is_deeply($process->return->{event_2}, [$driver, $ev2[1]], "$test_name event_2 passed expected args");
    undef $ev2_cv;

}

