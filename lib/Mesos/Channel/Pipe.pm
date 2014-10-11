package Mesos::Channel::Pipe;
use Moo;
with 'Mesos::Role::Channel';

sub xs_init {
    my ($self) = @_;
    $self->_xs_init('pipe');
}

1;
