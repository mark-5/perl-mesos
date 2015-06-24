package Mesos::Role::HasDispatcher;
use Mesos::Types qw(Dispatcher);
use Module::Runtime qw(require_module);
use Scalar::Util qw(weaken);
use Moo::Role;
requires 'event_handler';

has dispatcher => (
    is      => 'ro',
    isa     => Dispatcher,
    coerce  => 1,
    default => sub { 'AnyEvent' },
);

sub dispatch_event {
    my ($self) = @_;
    my $dispatcher = $self->dispatcher;
    my $handler    = $self->event_handler;

    my ($event, @args) = $dispatcher->recv;
    if ($handler->can($event)) {
        $handler->$event($self, @args);
    } else {
        warn "Event handler can't process event type $event";
    }
}

after BUILD => sub {
    weaken(my $self = shift);
    my $dispatcher = $self->dispatcher;
    $dispatcher->set_cb(sub { $self->dispatch_event });
};

1;
