#ifndef SCHEDULER_CHANNEL_
#define SCHEDULER_CHANNEL_

#include <mesos/scheduler.hpp>
#include <string>
#include <vector>
#include <queue>
#include <cstdio>

namespace mesos {
namespace perl {

class SchedulerCommand
{
public:
    const std::string name;
    std::vector<const void*> args;
};

class SchedulerChannel
{
public:
    FILE* in_;
    FILE* out_;
    SchedulerChannel();
    ~SchedulerChannel();
    std::queue<const SchedulerCommand*> pending_;
    void send(const SchedulerCommand* command);
    const SchedulerCommand* recv();
};

} // namespace perl {
} // namespace mesos {

#endif // SCHEDULER_CHANNEL_
