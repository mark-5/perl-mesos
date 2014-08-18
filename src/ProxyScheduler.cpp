#include <ProxyScheduler.hpp>

namespace mesos {
namespace perl {

ProxyScheduler::ProxyScheduler(std::shared_ptr<SchedulerChannel> channel)
: channel_(channel)
{

}

void ProxyScheduler::registered(SchedulerDriver* driver,
                const FrameworkID& frameworkId,
                const MasterInfo& masterInfo)
{

}

void ProxyScheduler::reregistered(SchedulerDriver* driver,
                  const MasterInfo& masterInfo)
{

}

void ProxyScheduler::disconnected(SchedulerDriver* driver)
{

}

void ProxyScheduler::resourceOffers(SchedulerDriver* driver,
                    const std::vector<Offer>& offers)
{

}

void ProxyScheduler::offerRescinded(SchedulerDriver* driver, const OfferID& offerId)
{

}

void ProxyScheduler::statusUpdate(SchedulerDriver* driver, const TaskStatus& status)
{

}

void ProxyScheduler::frameworkMessage(SchedulerDriver* driver,
                      const ExecutorID& executorId,
                      const SlaveID& slaveId,
                      const std::string& data)
{

}

void ProxyScheduler::slaveLost(SchedulerDriver* driver, const SlaveID& slaveId)
{

}

void ProxyScheduler::executorLost(SchedulerDriver* driver,
                  const ExecutorID& executorId,
                  const SlaveID& slaveId,
                  int status)
{

}

void ProxyScheduler::error(SchedulerDriver* driver, const std::string& message)
{

}

} // namespace perl {
} // namespace mesos {
