package Mesos::ExecutorDriver;
use Mesos::XS;
use Mesos::Types qw(:all);
use Type::Params qw(validate);
use Types::Standard qw(Str);
use Moo;
with 'Mesos::Role::HasDispatcher';

=head1 NAME

Mesos::ExecutorDriver - base class for Mesos executor drivers

=cut

has executor => (
    is       => 'ro',
    isa      => Executor,
    required => 1,
);
sub event_handler { shift->executor }

around sendStatusUpdate => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate \@args, TaskStatus);
};

around sendFrameworkMessage => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(validate \@args, Str);
};

sub BUILD {
    my ($self) = @_;
    $self->_xs_init($self->dispatcher);
}

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
