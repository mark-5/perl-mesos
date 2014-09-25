package Mesos::ExecutorDriver;
use Mesos;
use Mesos::Messages;
use Mesos::Channel;
use Moo;
use Types::Standard qw(Str);
use Type::Params qw(validate);
use Mesos::Types qw(:all);
use strict;
use warnings;

=head1 NAME

Mesos::ExecutorDriver - perl driver for Mesos executors

=cut

sub BUILD {
    my ($self) = @_;
    return $self->xs_init;
}

has executor => (
    is       => 'ro',
    isa      => Executor,
    required => 1,
);

has channel => (
    is       => 'ro',
    isa      => Channel,
    builder  => 1,
    # this needs to be lazy so that BUILD runs xs_init first
    lazy     => 1,
);

sub _build_channel {
    my ($self) = @_;
    return $self->_channel;
}


has process => (
    is      => 'ro',
    builder => 1,
    lazy    => 1,
);

sub _build_process {
    my ($self) = @_;
    return $self->executor;
}
# need to apply this after declaring channel and process
with 'Mesos::Role::Dispatcher';

after start => sub {
    my ($self) = @_;
    $self->dispatch_events;
};

after $_ => sub {
    my ($self) = @_;
    $self->stop_dispatch;
} for qw(stop abort);

sub run {
    my ($self) = @_;
    $self->start;
    $self->join;
}

sub join {
    my ($self) = @_;
    $self->dispatch_loop;
    return $self->status;
}

around sendStatusUpdate => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, TaskStatus));
};

around sendFrameworkMessage => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate(\@args, Str));
};

=head1 METHODS

=over 4

=item new(executor => $executor)

=item Status start()

=item Status stop()

=item Status abort()

=item Status join()

=item Status run()

=item Status sendStatusUpdate($status)

=item Status sendFrameworkMessage($data)

=back

=cut

1;
