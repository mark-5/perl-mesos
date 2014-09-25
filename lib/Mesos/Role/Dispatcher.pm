package Mesos::Role::Dispatcher;
use Moo::Role;
use AnyEvent;

=head1 NAME

 Mesos::Role::Dispatcher - role to dispatch events in an AnyEvent loop

=cut

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

=head1 METHODS

=over 4

=item dispatch_events()

    Instantiates the channel's initial IO watcher.

=cut

sub dispatch_events {
    my ($self) = @_;
    my $w = AnyEvent->io(
        fh   => $self->channel->fd,
        poll => 'r',
        cb   => sub {
            $self->clear_watcher;
            $self->dispatch_event;
            $self->dispatch_events;
        },
    );
    $self->watcher($w);
}

=item dispatch_event()

    Dispatch the next event in the channel. Returns undef if no events are queued.

=cut

sub dispatch_event {
    my ($self) = @_;
    my ($event, @args) = $self->channel->recv;
    my $process = $self->process;
    $process->$event($self, @args);
}

=item dispatch_loop()

    Enter into the AnyEvent loop. The loop can be broke by calling stop_dispatch.

=cut

sub dispatch_loop {
    my ($self) = @_;
    my $condvar = AnyEvent->condvar;
    $self->loop_condvar($condvar);
    $condvar->recv;
}

=item stop_dispatch()

    If in the middle of a dispatch loop, this will delete the condvar used, and break the loop.

=cut

sub stop_dispatch {
    my ($self) = @_;
    $self->clear_watcher;
    $self->loop_condvar->send if $self->has_loop_condvar;
}

=back

=cut

1;
