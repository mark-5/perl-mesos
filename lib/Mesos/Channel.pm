package Mesos::Channel;
use Moo;
use Data::Dumper;
use Carp;
use strict;
use warnings;

=head1 Name

Mesos::Channel - perl interface to the channel proxy schedulers and executors write events to

=head1 Synopsis

Mesos channels are blessed filehandles, so can be passed directly to IO::Select, AnyEvent->io, or any other function expecting a filehandle.

=cut

use Mesos;

sub BUILD {
    my ($self) = @_;
    return $self->xs_init;
}

sub deserialize_channel_args {
    my (@in) = @_;
    return map {
        my $from_xs = $_;
        croak("Received unknown ref from channel: " . Dumper $from_xs) unless ref $from_xs eq 'ARRAY'; 
        my ($data, $type) = @$from_xs;
        my $deserialized = $data;
        if ($type and $type ne 'String') {
            require Class::Load;            
            if (not Class::Load::is_class_loaded($type)) {
                $type = "Mesos::$type";
                croak "$type is not loaded" unless Class::Load::is_class_loaded($type);
            }
            croak("$type must provide a decode method") unless $type->can('decode');
            $deserialized = ref $data eq 'ARRAY' ? [map {$type->decode($_)} @$data] : $type->decode($data);
        }
        $deserialized;
    } @in;
}

=head1 Methods

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
