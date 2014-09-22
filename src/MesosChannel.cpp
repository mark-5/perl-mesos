#include <MesosChannel.hpp>
#include <cstdio>
#include <unistd.h>

namespace mesos {
namespace perl {

CommandArg::CommandArg()
: scalar_data_(std::string("")), array_data_(std::vector<std::string>()),
  type_(std::string("String")), context_(context::SCALAR)
{

}

CommandArg::CommandArg(const std::string& data, const std::string type)
: scalar_data_(data), array_data_(std::vector<std::string>()), type_(type), context_(context::SCALAR)
{

}

CommandArg::CommandArg(const std::vector<std::string>& data, const std::string type)
: scalar_data_(std::string("")), array_data_(data), type_(type), context_(context::ARRAY)
{

}

MesosCommand::MesosCommand(const std::string& name, const CommandArgs& args)
: name_(name), args_(args)
{

}

MesosCommand::MesosCommand()
: name_(std::string("")), args_(CommandArgs())
{

}

MesosChannel::MesosChannel()
: pending_(new CommandQueue), count_(new int(1)),
  mutex_(new std::mutex)
{
    int fds[2];
    pipe(fds);
    in_ = fdopen(fds[0], "r");
    out_ = fdopen(fds[1], "w");
    setvbuf(in_, NULL, _IONBF, 0);
    setvbuf(out_, NULL, _IONBF, 0);
}

MesosChannel::~MesosChannel()
{
    if (--*count_ == 0) {
        fclose(in_);
        fclose(out_);
        delete pending_;
        delete count_;
        delete mutex_;
    }
}

MesosChannel* MesosChannel::share()
{
    ++*count_;
    MesosChannel* to_share = new MesosChannel(*this);
    return to_share;
}

void MesosChannel::send(const MesosCommand& command)
{
    std::lock_guard<std::mutex> lock (*mutex_);
    pending_->push(command);
    fprintf(out_, "%s\n", command.name_.c_str());
}

const MesosCommand MesosChannel::recv()
{
    std::lock_guard<std::mutex> lock (*mutex_);
    char str[100];
    if (fgets(str, 100, in_)) {
        const MesosCommand command = pending_->front();
        pending_->pop();
        return command;
    } else {
        return MesosCommand(std::string(), CommandArgs());
    }
}

} // namespace perl {
} // namespace mesos {
