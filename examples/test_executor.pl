#!/usr/bin/perl
package TestExecutor;
use Mesos::Types qw(TaskStatus);
use Moo;
extends 'Mesos::Executor';

sub launchTask {
    my ($self, $driver, $task) = @_;
    printf "Running task %s\n", $task->{task_id}{value};
    my $update = TaskStatus->new({
        task_id => $task->{task_id},
        state   => Mesos::TaskState::TASK_RUNNING,
        data    => "data with a \0 byte",    
    });
    $driver->sendStatusUpdate($update);

    print "Sending status update...\n";
    $update = TaskStatus->new({
        task_id => $task->{task_id},
        state   => Mesos::TaskState::TASK_FINISHED,
        data    => "data with a \0 byte",    
    });
    $driver->sendStatusUpdate($update);
    print "Sent status update\n";
}

sub frameworkMessage {
    my ($self, $driver, $message) = @_;
    $driver->sendFrameworkMessage($message);
}

package main;
use Mesos::Messages;
use Mesos::ExecutorDriver;
print "Starting executor\n";
my $driver = Mesos::ExecutorDriver->new(executor => TestExecutor->new);
exit( ($driver->run == Mesos::Status::DRIVER_STOPPED) ? 0 : 1 );
