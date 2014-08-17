#include <SchedulerDriver.hpp>

namespace mesos {
namespace perl {

SchedulerDriver::SchedulerDriver(const FrameworkInfo& framework,
                    const std::string& master)
{
    proxyScheduler_ = new ProxyScheduler();
    driver_ = new MesosSchedulerDriver(proxyScheduler_, framework, master);
}

SchedulerDriver::SchedulerDriver(const FrameworkInfo& framework,
                    const std::string& master,
                    const Credential& credential)
{
    proxyScheduler_ = new ProxyScheduler();
    driver_ = new MesosSchedulerDriver(proxyScheduler_, framework, master, credential);
}

SchedulerDriver::~SchedulerDriver()
{
    delete driver_;
    delete proxyScheduler_;
}

Status SchedulerDriver::start()
{
    return driver_->run();
}

Status SchedulerDriver::stop(bool failover)
{
    return driver_->stop(failover);
}

Status SchedulerDriver::abort()
{
    return driver_->abort();
}

Status SchedulerDriver::join()
{
    return driver_->join();
}

Status SchedulerDriver::run()
{
    return driver_->run();
}

Status SchedulerDriver::requestResources(const std::vector<Request>& requests)
{
    return driver_->requestResources(requests);
}

Status SchedulerDriver::launchTasks(const std::vector<OfferID>& offerIds,
                           const std::vector<TaskInfo>& tasks,
                           const Filters& filters)
{
    return driver_->launchTasks(offerIds, tasks, filters);
}

Status SchedulerDriver::launchTasks(const OfferID& offerId,
                           const std::vector<TaskInfo>& tasks,
                           const Filters& filters)
{
    return driver_->launchTasks(offerId, tasks, filters);
}

Status SchedulerDriver::killTask(const TaskID& taskId)
{
    return driver_->killTask(taskId);
}

Status SchedulerDriver::declineOffer(const OfferID& offerId,
                            const Filters& filters)
{
    return driver_->declineOffer(offerId, filters);
}

Status SchedulerDriver::reviveOffers()
{
    return driver_->reviveOffers();
}

Status SchedulerDriver::sendFrameworkMessage(const ExecutorID& executorId,
                                    const SlaveID& slaveId,
                                    const std::string& data)
{
    return driver_->sendFrameworkMessage(executorId, slaveId, data);
}

Status SchedulerDriver::reconcileTasks(const std::vector<TaskStatus>& statuses)
{
    return driver_->reconcileTasks(statuses);
}

} // namespace perl {
} // namespace mesos {
