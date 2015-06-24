package Mesos::Dispatcher::Interrupt;
use Async::Interrupt;
use Scalar::Util qw(weaken);
use Moo;
extends 'Mesos::Dispatcher';

has interrupt => (
    is      => 'ro',
    builder => '_build_interrupt',
);

sub _build_interrupt {
    my ($self) = @_;
    my $interrupt = Async::Interrupt->new(cb => sub { $self->dispatch_cb->() });

    weaken($self);
    return $interrupt;
}

sub xs_init {
    my ($self) = @_;
    my ($func, $arg) = $self->interrupt->signal_func;
    $self->_xs_init($self->channel, $func, $arg);
}

1;
