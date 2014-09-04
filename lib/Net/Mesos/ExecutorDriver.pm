package Net::Mesos::ExecutorDriver;
use Net::Mesos;
use Mesos::Messages;
use Net::Mesos::Channel;
use Net::Mesos::Utils qw(encode_protobufs);
use Moo;
use Types::Standard qw(Str);
use strict;
use warnings;

=head1 Name

Net::Mesos::ExecutorDriver - perl driver for Mesos executors

=cut

sub BUILD {
    my ($self) = @_;
    return $self->xs_init;
}

has executor => (
    is       => 'ro',
    required => 1,
);

has channel => (
    is       => 'ro',
    isa      => sub {shift->isa('Net::Mesos::Channel')},
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
with 'Net::Mesos::Role::Dispatcher';


my @needs_wrapped = qw(
    sendStatusUpdate
);


my $wrap_protobufs = sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(encode_protobufs @args);
};

around $_ => $wrap_protobufs for @needs_wrapped;


after start => sub {
    my ($self) = @_;
    $self->dispatch_events;
};

after stop => sub {
    my ($self) = @_;
    $self->stop_dispatch;
};

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


=head1 Methods

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
