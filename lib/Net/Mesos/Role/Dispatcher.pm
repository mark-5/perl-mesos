package Net::Mesos::Role::Dispatcher;
use Moo::Role;
use AnyEvent;

requires 'channel';
requires 'process';

has watcher => (
    is        => 'rw',
    clearer   => 1,
    predicate => 1,
);

has loop_condvar => (
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
    my $process = $self->process;
    $process->$event($self, @args);
}

around dispatch_event => sub {
    my ($orig, $self, @args) = @_;
    $self->clear_watcher;
    $self->$orig(@args);
    $self->dispatch_events;
};

sub dispatch_loop {
    my ($self) = @_;
    my $condvar = AnyEvent->condvar;
    $self->loop_condvar($condvar);
    $condvar->recv;
}

sub stop_dispatch {
    my ($self) = @_;
    $self->clear_watcher;
    $self->loop_condvar->send if $self->has_loop_condvar;
}


1;
