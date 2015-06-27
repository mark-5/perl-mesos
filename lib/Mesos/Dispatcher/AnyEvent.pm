package Mesos::Dispatcher::AnyEvent;
use AnyEvent;
use Scalar::Util qw(weaken);
use Moo;
extends 'Mesos::Dispatcher::Pipe';

has ae_watcher => (
    is => 'rw',
);

sub setup_ae_watcher {
    weaken(my $self = shift);
    my $w = AnyEvent->io(
        fh   => $self->fd,
        poll => 'r',
        cb   => sub { $self->call },
    );
    $self->ae_watcher($w);
}

sub BUILD {
    my ($self) = @_;
    $self->setup_ae_watcher;
}

1;
