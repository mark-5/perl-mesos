package Mesos::Dispatcher::Interrupt;
use AnyEvent;
use Async::Interrupt;
use Scalar::Util qw(weaken);
use Scope::Guard qw(guard);
use Moo;
extends 'Mesos::Dispatcher';

has interrupt => (
    is      => 'ro',
    builder => '_build_interrupt',
);

sub _build_interrupt {
    weaken(my $self = shift);
    return Async::Interrupt->new(cb => sub { $self->call });
}

sub xs_init {
    my ($self) = @_;
    my ($func, $arg) = $self->interrupt->signal_func;
    $self->_xs_init($self->channel, $func, $arg);
}

sub ticker {
    my ($self, $tick) = @_;
    $tick ||= 0.1;
    return AnyEvent->timer(
        after    => $tick,
        interval => $tick,
        cb       => sub { },
    );
}

around wait => sub {
    my ($orig, $self, @args) = @_;
    my $ticker = $self->ticker;
    $self->$orig(@args);
};

1;
