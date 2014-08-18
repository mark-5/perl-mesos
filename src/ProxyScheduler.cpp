#include <ProxyScheduler.hpp>

#define PUSH_MSG(VEC, MSG) VEC.push_back(MSG.SerializeAsString())

namespace mesos {
namespace perl {

ProxyScheduler::ProxyScheduler(SharedChannel channel)
: channel_(channel)
{

}

void ProxyScheduler::registered(SchedulerDriver* driver,
                const FrameworkID& frameworkId,
                const MasterInfo& masterInfo)
{
    CommandArgs args;
    PUSH_MSG(args, frameworkId);
    PUSH_MSG(args, masterInfo);
    
    channel_->send( SchedulerCommand("registered", args) );
}

void ProxyScheduler::reregistered(SchedulerDriver* driver,
                  const MasterInfo& masterInfo)
{
    CommandArgs args;
    PUSH_MSG(args, masterInfo);
    
    channel_->send( SchedulerCommand("reregistered", args) );
}

void ProxyScheduler::disconnected(SchedulerDriver* driver)
{
    CommandArgs args;
    channel_->send( SchedulerCommand("disconnected", args) );
}

void ProxyScheduler::resourceOffers(SchedulerDriver* driver,
                    const std::vector<Offer>& offers)
{
    CommandArgs args(offers.size());
    for (std::vector<Offer>::const_iterator it = offers.begin(); it != offers.end(); ++it) {
        const Offer offer = *it;
        PUSH_MSG(args, offer);
    }

    channel_->send( SchedulerCommand("resourceOffers", args) );
}

void ProxyScheduler::offerRescinded(SchedulerDriver* driver, const OfferID& offerId)
{
    CommandArgs args;
    PUSH_MSG(args, offerId);

    channel_->send( SchedulerCommand("offerRescinded", args) );
}

void ProxyScheduler::statusUpdate(SchedulerDriver* driver, const TaskStatus& status)
{
    CommandArgs args;
    PUSH_MSG(args, status);

    channel_->send( SchedulerCommand("statusUpdate", args) );
}

void ProxyScheduler::frameworkMessage(SchedulerDriver* driver,
                      const ExecutorID& executorId,
                      const SlaveID& slaveId,
                      const std::string& data)
{
    CommandArgs args;
    PUSH_MSG(args, executorId);
    PUSH_MSG(args, slaveId);
    args.push_back(data);

    channel_->send( SchedulerCommand("frameworkMessage", args) );
}

void ProxyScheduler::slaveLost(SchedulerDriver* driver, const SlaveID& slaveId)
{
    CommandArgs args;
    PUSH_MSG(args, slaveId);

    channel_->send( SchedulerCommand("slaveLost", args) );
}

void ProxyScheduler::executorLost(SchedulerDriver* driver,
                  const ExecutorID& executorId,
                  const SlaveID& slaveId,
                  int status)
{
    CommandArgs args;
    PUSH_MSG(args, executorId);
    PUSH_MSG(args, slaveId);
    args.push_back(std::to_string(status));

    channel_->send( SchedulerCommand("executorLost", args) );
}

void ProxyScheduler::error(SchedulerDriver* driver, const std::string& message)
{
    CommandArgs args;
    args.push_back(message);

    channel_->send( SchedulerCommand("error", args) );
}

} // namespace perl {
} // namespace mesos {
