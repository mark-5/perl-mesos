package Mesos::Channel::Pipe;
use Moo;
use Mesos;
use Mesos::Utils qw(import_methods);
import_methods('Mesos::XS::PipeChannel');
with 'Mesos::Role::Channel';

sub xs_init {
    my ($self) = @_;
    $self->_xs_init;
}

1;
