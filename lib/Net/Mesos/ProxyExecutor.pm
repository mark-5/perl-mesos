package Net::Mesos::ProxyExecutor;
use Moo;
use strict;
use warnings;

use Net::Mesos;

sub BUILD {
    my ($self) = @_;
    $self->xs_init;
}


1;
