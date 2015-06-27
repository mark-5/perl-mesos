package Mesos::Dispatcher;
use Mesos::XS;
use AnyEvent;
use Mesos::Channel;
use Scalar::Util qw(weaken);
use Scope::Guard qw(guard);
use Moo;

has channel => (
    is      => 'ro',
    handles => [qw(recv send)],
    lazy    => 1,
    default => sub { Mesos::Channel->new },
);

has cb => (
    is      => 'ro',
    writer  => 'set_cb',
    default => sub { sub{} },
);

sub call { shift->cb->() }

sub xs_init {
    my ($self) = @_;
    $self->_xs_init($self->channel);
}

after send => sub { shift->notify };

sub wait {
    my ($self, $time) = @_;

    my $cv = AnyEvent->condvar;
    my $w  = $time && do {
        AnyEvent->timer(after => $time, cb => sub { $cv->send })
    };

    my $old_cb = $self->cb;
    my $guard  = guard { $self->set_cb($old_cb) };
    $self->set_cb(sub {
        my @return = $old_cb->();
        $cv->send(@return);
    });
    my @return = $cv->recv;

    weaken($self);
    return @return;
}

sub BUILD { shift->xs_init }

1;
