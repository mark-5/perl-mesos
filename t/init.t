use Test::More;
use Carp::Always;

use_ok($_) for qw(
    Mesos
    Mesos::Types
    Mesos::SchedulerDriver
    Mesos::SchedulerDriver::Interrupt
    Mesos::ExecutorDriver
    Mesos::ExecutorDriver::Interrupt
    Mesos::Channel
    Mesos::Channel::Pipe
    Mesos::Channel::Interrupt
);

done_testing;
