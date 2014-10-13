package Mesos::Role::Channel;
use strict;
use warnings;
use Data::Dumper;
use Carp;

use Moo::Role;


requires qw(
    xs_init
    recv
    send
);
sub BUILD { shift->xs_init(@_) }


sub is_message_class_loaded {
    my ($type) = @_;
    return eval { $type->can('decode') };
}

sub deserialize_channel_args {
    my (@in) = @_;
    return map {
        my $from_xs = $_;
        croak("Received unknown ref from channel: " . Dumper $from_xs) unless ref $from_xs eq 'ARRAY';
        my ($data, $type) = @$from_xs;
        my $deserialized = $data;
        if ($type and $type ne 'String') {
            unless (is_message_class_loaded($type)) {
                $type = "Mesos::$type";
                croak "$type is either not a message class or is not loaded"
                    unless is_message_class_loaded($type);
            }
            $deserialized = ref $data eq 'ARRAY' ? [map {$type->decode($_)} @$data] : $type->decode($data);
        }
        $deserialized;
    } @in;
}

=head1 METHODS

=over 4

=item recv()

    Main entry point to this class. Returns and deserializes any events logged by proxy schedulers or drivers.
    This is non-blocking and will immediately return undef if no events are queued.

    The first argument returned is the name of the event logged.
    The remaining return values are the arguments received from MesosSchedulerDriver.

=item fd()

    Return the underlying file descriptor for the read end of the channel.
    Mainly used for passing to IO::Select or AnyEvent.

=back

=cut

around recv => sub {
    my ($orig, $self, @input_args) = @_;
    my ($command, @output_args) = @{$self->$orig(@input_args)||[]};
    return wantarray ? () : undef if !$command and !@output_args;
    return ($command, deserialize_channel_args(@output_args));
};

around send => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(\@args);
};


1;