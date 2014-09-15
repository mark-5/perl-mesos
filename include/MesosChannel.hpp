#ifndef SCHEDULER_CHANNEL_
#define SCHEDULER_CHANNEL_

#include <mesos/scheduler.hpp>
#include <string>
#include <vector>
#include <queue>
#include <cstdio>
#include <memory>
#include <mutex>

#define PUSH_MSG(VEC, MSG, MSG_TYPE) VEC.push_back(CommandArg(MSG.SerializeAsString(), MSG_TYPE))

namespace mesos {
namespace perl {

enum class context : int { SCALAR, ARRAY };

class CommandArg {
public:
    std::string scalar_data_;
    std::vector<std::string> array_data_;
    std::string type_;
    context context_;
    CommandArg();
    CommandArg(const std::string& data, const std::string type = std::string("String"));
    CommandArg(const std::vector<std::string>& data, const std::string type = std::string("String"));
};

typedef std::vector<CommandArg> CommandArgs;
class MesosCommand
{
public:
    std::string name_;
    CommandArgs args_;

    MesosCommand();
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
    MesosChannel* share();

private:
    int* count_;
    std::mutex* mutex_;
};

} // namespace perl {
} // namespace mesos {

#endif // SCHEDULER_CHANNEL_
