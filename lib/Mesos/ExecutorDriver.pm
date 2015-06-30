package Mesos::ExecutorDriver;
use Mesos::XS;
use Mesos::Types qw(:all);
use Type::Params qw(validate);
use Types::Standard qw(Str);
use Moo;
with 'Mesos::Role::HasDispatcher';

=head1 NAME

Mesos::ExecutorDriver - perl interface to MesosExecutorDriver

=head1 ATTRIBUTES

=head2 dispatcher

Either a Mesos::Dispatcher instance, or the short name of a dispatcher to instantiate(such as AnyEvent). The short name cannot be used if the dispatcher has required arguments.

Defaults to AnyEvent

=head2 executor

A Mesos::Executor instance

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

=item new(%args)

    my $driver = Mesos::ExecutorDriver->new(%args);

        %args
            REQUIRED executor
            OPTIONAL dispatcher


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
