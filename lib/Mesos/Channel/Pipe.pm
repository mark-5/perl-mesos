package Mesos::Channel::Pipe;
use Moo;
with 'Mesos::Role::Channel';

sub init {
    my ($self) = @_;
    $self->xs_init('pipe');
}

1;
