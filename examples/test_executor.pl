#!/usr/bin/perl

package TestExecutor;
use Moo;
use strict;
use warnings;
extends 'Net::Mesos::Executor';
use Mesos::Messages;

sub launchTask {
    my ($self, $driver, $task) = @_;
    printf "Running task %s\n", $task->task_id->value;
    my $update = Mesos::TaskStatus->new;
    $update->task_id($task->task_id);
    $update->state(Mesos::TaskState::TASK_RUNNING);
    $update->data("data with a \0 byte");
    $driver->sendStatusUpdate($update);

    print "Sending status update...\n";
    $update = Mesos::TaskStatus->new;
    $update->task_id($task->task_id);
    $update->state(Mesos::TaskState::TASK_FINISHED);
    $update->data("data with a \0 byte");
    $driver->sendStatusUpdate($update);
    print "Sent status update\n";
}

sub frameworkMessage {
    my ($self, $driver, $message) = @_;
    $driver->sendFrameworkMessage($message);
}

package main;
use Mesos::Messages;
use Net::Mesos::ExecutorDriver;
print "Starting executor\n";
my $driver = Net::Mesos::ExecutorDriver->new(executor => TestExecutor->new);
exit( ($driver->run == Mesos::Status::DRIVER_STOPPED) ? 0 : 1 );
