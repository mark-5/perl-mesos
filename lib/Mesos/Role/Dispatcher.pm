package Mesos::Role::Dispatcher;
use Moo::Role;

requires 'channel';
requires 'process';

sub dispatch_event {
    my ($self) = @_;
    my ($event, @args) = $self->channel->recv;
    $self->process->$event($self, @args);
}

sub dispatch_events {
    my ($self) = @_;
    my $channel = $self->channel;
    $self->dispatch_event while $channel->size;
}


1;
