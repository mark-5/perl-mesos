package Mesos::XUnit::Role::Dispatcher::CheckWait;
use Mesos::Test::Utils qw(timeout);
use Test::Class::Moose::Role;
requires qw(new_delay new_dispatcher);
sub test_wait {
    my ($self) = @_;
    my $dispatcher = $self->new_dispatcher;

    my $timedout = timeout { $dispatcher->wait };
    ok $timedout, 'timed out waiting before event trigger';

    $timedout = timeout { $dispatcher->wait(2) } 1;
    ok $timedout, 'timed out when passed long wait';

    $timedout = timeout { $dispatcher->wait(1) } 2;
    ok !$timedout, 'returned when passed short wait';

    my @rv; timeout { @rv = $dispatcher->wait(1) } 2;
    is scalar(@rv), 0, 'returned empty list when no events';

    my @command = qw(some command and args);
    $dispatcher->set_cb(sub { $dispatcher->recv });
    my $delay = $self->new_delay(1, sub {
        $dispatcher->send(@command);
    });
    timeout { @rv = $dispatcher->wait } 5;
    is_deeply \@rv, \@command, 'wait returned triggered event';
}

1;
