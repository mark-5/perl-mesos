package Mesos;
use strict;
use warnings;

=head1 NAME

Mesos

=head1 VERSION

Version 1.00

=head1 DESCRIPTION

Perl bindings for Apache Mesos.

=head1 SYNOPSIS

    package MyScheduler {
        use Moo;
        extends 'Mesos::Scheduler';
        use Mesos::Messages; # load protobuf messages

        sub resourceOffers {
                my ($self, $driver, $offers) = @_;
                for my $offer (@$offers) {
                    my $task = Mesos::TaskInfo->new({
                        task_id   => {value => "a unique id"},
                        slave_id  => $offer->slave_id,
                        name      => "does something cool",
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
    }

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
