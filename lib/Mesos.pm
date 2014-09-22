package Mesos;
use strict;
use warnings;

=head1 NAME

Mesos

=head1 DESCRIPTION

Perl bindings for Apache Mesos.

=head2 Protobuf Messages

Frameworks, masters, and slaves all communicate using google protocol buffers. The Mesos module handles protobuf messages using the Google::ProtocolBuffers library, which is what's used to generate the message classes in Mesos::Messages from resources/mesos.proto. It is encouraged to look over Google::ProtocolBuffers documentation before using Mesos.

=head2 Internal POSIX Threads

The internal Mesos drivers create multiple threads during construction, and only exec and POSIX::_exit can be guaranteed to work safely in the child process after forking. One should definitely not call any driver code in the child process after forking.

=head1 SYNOPSIS

package MyScheduler {
    use Moo;
    extends 'Mesos::Scheduler';
    use Mesos::Messages; # load protobuf messages

    sub resourceOffers {
            my ($self, $driver, $offers) = @_;
            for my $offer (@$offers) {
                my $task = Mesos::TaskInfo->new({
                    # task_id is a Mesos::TaskID message
                    task_id   => Mesos::TaskID->new({value => "a unique id"}),
                    slave_id  => $offer->slave_id,
                    name      => "does something cool",
                    # executor is a Mesos::ExecutorInfo message
                    # Google::ProtocolBuffers will let you pass the constructor args
                    #  and will instantiate the message for you
                    executor  => {
                        executor_id => {value => "does cool tasks"},
                        command     => {value => "/path/to/executor"},
                    },
                    resources => [
                        {name => "cpus", type => Mesos::Value::Type::SCALAR, scalar => {value => 1}},
                        {name => "mem",  type => Mesos::Value::Type::SCALAR, scalar => {value => 32}},
                    ],
                });
                $driver->launchTasks([$offer->{id}], [$task]);
            }
    }
};

use Mesos::SchedulerDriver;
my $driver = Mesos::SchedulerDriver->new(
    master    => "mesoshost:5050",
    framework => {user => "mesos user", name => "awesome framework"},
    scheduler => MyScheduler->new,
);
$driver->run;

=head1 AUTHOR

Mark Flickinger E<lt>maf@cpan.orgE<gt>

=cut

use XSLoader;
use Exporter 5.57 'import';

our $VERSION = '1.00';
our %EXPORT_TAGS = ( 'all' => [] );
our @EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } );

XSLoader::load('Mesos', $VERSION);

1;
