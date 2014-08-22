#ifndef SCHEDULER_CHANNEL_
#define SCHEDULER_CHANNEL_

#include <mesos/scheduler.hpp>
#include <string>
#include <vector>
#include <queue>
#include <cstdio>
#include <memory>

namespace mesos {
namespace perl {

typedef std::vector<std::string> CommandArgs;
class SchedulerCommand
{
public:
    const std::string name_;
    const CommandArgs args_;
    SchedulerCommand(const std::string& name, const CommandArgs& args);
};

class MesosChannel
{
public:
    typedef std::queue<SchedulerCommand> CommandQueue;

    FILE* in_;
    FILE* out_;
    MesosChannel();
    ~MesosChannel();
    CommandQueue* pending_;
    void send(const SchedulerCommand& command);
    const SchedulerCommand recv();
};
typedef std::shared_ptr<MesosChannel> SharedChannel;

} // namespace perl {
} // namespace mesos {

#endif // SCHEDULER_CHANNEL_
