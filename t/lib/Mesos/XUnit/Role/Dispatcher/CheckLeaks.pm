package Mesos::XUnit::Role::Dispatcher::CheckLeaks;
use Test::LeakTrace;
use Test::Class::Moose::Role;
requires qw(new_dispatcher);

sub test_dispatcher_constructor_leaks {
    my ($test) = @_;

    no_leaks_ok {
        my $dispatcher = $test->new_dispatcher;
    } 'dispatcher constructor does not leak';
}

1;
