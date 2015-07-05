package Mesos::Dispatcher;
use Mesos::XS;
use AnyEvent;
use Mesos::Channel;
use Scalar::Util qw(weaken);
use Scope::Guard qw(guard);
use Moo;

=head1 NAME

Mesos::Dispatcher

=head1 DESCRIPTION

A parent class for event dispatchers to inherit from.

=head1 ATTRIBUTES

=head2 channel

=head2 cb

=head1 METHODS

=head2 new

    my $dispatcher = Mesos::Dispatcher->new(%args)

        %args
            REQUIRED cb
            OPTIONAL channel

=head2 call

=head2 notify

=head2 recv

=head2 send

=head2 wait

=cut

has channel => (
    is      => 'ro',
    handles => [qw(recv send)],
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
