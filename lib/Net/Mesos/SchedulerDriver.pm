package Net::Mesos::SchedulerDriver;
use Net::Mesos;
use Mesos::Messages;
use Net::Mesos::Utils qw(encode_protobufs);
use Moo;
use Types::Standard qw(Str);
use strict;
use warnings;

extends 'Net::Mesos::SchedulerDriver::XS';


sub FOREIGNBUILDARGS {
    my ($class, %params) = @_;
    return encode_protobufs grep {$_} @params{qw(framework master credentials)};
}

has scheduler => (
    is       => 'ro',
    required => 1,
);

has framework => (
    is       => 'ro',
    isa      => sub {shift->isa('Mesos::FrameworkInfo')},
    required => 1,
);

has master => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);

has credentials => (
    is => 'ro',
    isa => sub {shift->isa('Mesos::Credential')},
);


my @needs_wrapped = qw(
    start
    stop
    abort
    join
    run
    requestResources
    launchTasks
    killTask
    declineOffer
    reviveOffers
    sendFrameworkMessage
    reconcileTasks
);


my $wrap_protobufs = sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(encode_protobufs @args);
};

around $_ => $wrap_protobufs for @needs_wrapped;


1;
