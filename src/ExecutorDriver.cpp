#include <ExecutorDriver.hpp>

namespace mesos {
namespace perl {

ExecutorDriver::ExecutorDriver()
{
    channel_ = SharedChannel(new MesosChannel);
    proxyExecutor_ = new ProxyExecutor(channel_);
    driver_ = new MesosExecutorDriver(proxyExecutor_);
}

ExecutorDriver::~ExecutorDriver()
{
    delete driver_;
    delete proxyExecutor_;
}

Status ExecutorDriver::start()
{
    return driver_->start();
}

Status ExecutorDriver::stop()
{
    return driver_->stop();
}

Status ExecutorDriver::abort()
{
    return driver_->abort();
}

Status ExecutorDriver::join()
{
    return driver_->join();
}

Status ExecutorDriver::run()
{
    return driver_->run();
}

Status ExecutorDriver::sendStatusUpdate(const TaskStatus& status)
{
    return driver_->sendStatusUpdate(status);
}

Status ExecutorDriver::sendFrameworkMessage(const std::string& data)
{
    return driver_->sendFrameworkMessage(data);
}

} // namespace perl {
} // namespace mesos {
