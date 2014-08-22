package Net::Mesos::Role::Dispatcher;
use Moo::Role;
use AnyEvent;

requires 'channel';
requires 'scheduler';

has watcher => (
    is        => 'rw',
    clearer   => 1,
    predicate => 1,
);

sub dispatch_events {
    my ($self) = @_;
    my $w = AnyEvent->io(
        fh   => $self->channel,
        poll => 'r',
        cb   => sub { $self->dispatch_event },
    );
    $self->watcher($w);
}

sub dispatch_event {
    my ($self) = @_;
    my ($event, @args) = $self->channel->recv;
    my $scheduler = $self->scheduler;
    $scheduler->$event($self, @args);
}

around dispatch_event => sub {
    my ($orig, $self, @args) = @_;
    $self->clear_watcher;
    $self->$orig(@args);
    $self->dispatch_events;
};

sub dispatch_loop { AnyEvent->condvar->recv }


1;
