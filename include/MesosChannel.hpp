#ifndef SCHEDULER_CHANNEL_
#define SCHEDULER_CHANNEL_

#include <mesos/scheduler.hpp>
#include <string>
#include <vector>
#include <queue>
#include <cstdio>
#include <memory>

#define PUSH_MSG(VEC, MSG, MSG_TYPE) VEC.push_back(CommandArg(MSG.SerializeAsString(), MSG_TYPE))

namespace mesos {
namespace perl {

class CommandArg {
public:
    const std::string data_;
    const std::string type_;
    CommandArg(const std::string& data = std::string(""), const std::string& type = std::string("String"));
};

typedef std::vector<CommandArg> CommandArgs;
class MesosCommand
{
public:
    const std::string name_;
    const CommandArgs args_;
    MesosCommand(const std::string& name, const CommandArgs& args);
};

class MesosChannel
{
public:
    typedef std::queue<MesosCommand> CommandQueue;

    FILE* in_;
    FILE* out_;
    MesosChannel();
    ~MesosChannel();
    CommandQueue* pending_;
    void send(const MesosCommand& command);
    const MesosCommand recv();
};
typedef std::shared_ptr<MesosChannel> SharedChannel;

} // namespace perl {
} // namespace mesos {

#endif // SCHEDULER_CHANNEL_
