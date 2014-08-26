package Net::Mesos::Utils;
use strict;
use warnings;
use Carp;
use parent 'Exporter';
our @EXPORT = qw(load_messages encode_protobufs);
our @EXPORT_OK = @EXPORT;

sub load_messages {
    require Google::ProtocolBuffers;
    my (@protos) = @_;
    for my $proto (@protos) {
        my ($without_suffix) = split /\.proto$/, $proto;
        my $opts = {
            generate_code    => "$without_suffix.pm",
            create_accessors => 1,
        };
        Google::ProtocolBuffers->parsefile($proto, $opts);
    }
}

sub encode_protobufs {
    my @args = @_;
    my @encoded = map {
        my $arg = $_;
        my $retval = $arg;
        if (ref $arg eq 'ARRAY') {
            $retval = [map {$_->encode} @$arg] if grep {$_->can('encode')} @$arg;
        } elsif (ref $arg and $arg->can('encode')) {
            $retval = $arg->encode;
        }
        $retval;
    } @args;
    return @encoded;
};


1;
