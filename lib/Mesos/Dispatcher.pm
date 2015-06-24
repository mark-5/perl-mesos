package Mesos::Dispatcher;
use Mesos::XS;
use Mesos::Channel;
use Scalar::Util qw(weaken);
use Moo;

has channel => (
    is      => 'ro',
    lazy    => 1,
    default => sub { Mesos::Channel->new },
);

has cb => (
    is      => 'ro',
    writer  => 'set_cb',
    default => sub { },
);

sub xs_init {
    my ($self) = @_;
    $self->_xs_init($self->channel);
}

sub BUILD { shift->xs_init }

1;
