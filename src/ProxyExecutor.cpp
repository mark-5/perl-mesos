#include <ProxyExecutor.hpp>

#define PUSH_MSG(VEC, MSG) VEC.push_back(MSG.SerializeAsString())

namespace mesos {
namespace perl {

ProxyExecutor::ProxyExecutor(SharedChannel channel)
: channel_(channel)
{

}

void ProxyExecutor::registered(ExecutorDriver* driver,
                               const ExecutorInfo& executorInfo,
                               const FrameworkInfo& frameworkInfo,
                               const SlaveInfo& slaveInfo)
{
    CommandArgs args;
    PUSH_MSG(args, executorInfo);
    PUSH_MSG(args, frameworkInfo);
    PUSH_MSG(args, slaveInfo);
    channel_->send( SchedulerCommand("registered", args) );
}

void ProxyExecutor::reregistered(ExecutorDriver* driver,
                                 const SlaveInfo& slaveInfo)
{
    CommandArgs args;
    PUSH_MSG(args, slaveInfo);
    channel_->send( SchedulerCommand("reregistered", args) );
}

void ProxyExecutor::disconnected(ExecutorDriver* driver)
{
    CommandArgs args;
    channel_->send( SchedulerCommand("disconnected", args) );
}

void ProxyExecutor::launchTask(ExecutorDriver* driver,
                              const TaskInfo& task)
{
    CommandArgs args;
    PUSH_MSG(args, task);
    channel_->send( SchedulerCommand("launchTask", args) );

}

void ProxyExecutor::killTask(ExecutorDriver* driver, const TaskID& taskId)
{
    CommandArgs args;
    PUSH_MSG(args, taskId);
    channel_->send( SchedulerCommand("killTask", args) );
}

void ProxyExecutor::frameworkMessage(ExecutorDriver* driver,
                                     const std::string& data)
{
    CommandArgs args;
    args.push_back(data);
    channel_->send( SchedulerCommand("frameworkMessage", args) );
}

void ProxyExecutor::shutdown(ExecutorDriver* driver)
{
    CommandArgs args;
    channel_->send( SchedulerCommand("shutdown", args) );
}

void ProxyExecutor::error(ExecutorDriver* driver, const std::string& message)
{
    CommandArgs args;
    args.push_back(message);
    channel_->send( SchedulerCommand("error", args) );
}


} // namespace perl {
} // namespace mesos {
