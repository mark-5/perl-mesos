package Mesos::Types;
use strict;
use warnings;

use Type::Library
   -base;
use Type::Utils -all;
use Types::Standard -types;
use Mesos::Messages;

my @messages = qw(
    Credential
    ExecutorID
    Filters
    FrameworkInfo
    OfferID
    Request
    SlaveID
    TaskID
    TaskInfo
    TaskStatus
);

for my $message (@messages) {
    my $protobuf_class = "Mesos::$message";
    class_type $message, {class => $protobuf_class};
    coerce $message,
        from HashRef, via { $protobuf_class->new($_) };
}

role_type  $_, {role => "Mesos::Role::$_"} for qw(Scheduler       Executor);
class_type $_, {class => "Mesos::$_"}      for qw(SchedulerDriver ExecutorDriver Channel);


__PACKAGE__->meta->make_immutable;

1;
