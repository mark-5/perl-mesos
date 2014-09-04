package Net::Mesos::Channel;
use Class::Method::Modifiers;
use Data::Dumper;
use Carp;
use strict;
use warnings;

use Net::Mesos;
use Net::Mesos::Utils qw(encode_protobufs);

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

around recv => sub {
    my ($orig, $self, @input_args) = @_;
    my ($command, @output_args) = $self->$orig(@input_args);
    return wantarray ? () : undef if !$command and !@output_args;
    return ($command, deserialize_channel_args(@output_args));
};

around send => sub {
    my ($orig, $self, @args) = @_;
    return $self->$orig(encode_protobufs @args);
};


1;
