package Mesos::XT::Role::Scheduler;
use File::Spec::Functions qw(catfile);
use Mesos::Test::Scheduler;
use Mesos::Test::Utils qw(
    test_framework
    test_master
    xt_root
);
use Test::Class::Moose::Role;
requires qw(new_driver);

sub test_scheduler_without_executor {
    my ($test) = @_;

    my $scheduler = Mesos::Test::Scheduler->new;
    my $driver    = $test->new_driver(
        framework => test_framework,
        master    => test_master,
        scheduler => $scheduler,
    );

    {
        $driver->run_once;
        my $last = $scheduler->last_event;
        my ($event, $frameworkId, $masterInfo) = @$last;

        is $event, 'registered';
        is ref($frameworkId), 'Mesos::FrameworkID';
        is ref($masterInfo),  'Mesos::MasterInfo';
    }

    {
        $driver->run_once;
        my $last = $scheduler->last_event;
        my ($event, $resourceOffers) = @$last;

        is $event, 'resourceOffers';
        is ref($resourceOffers), 'ARRAY';
        is ref($_), 'Mesos::Offer' for @$resourceOffers;
    }

    $driver->stop;
}

1;
