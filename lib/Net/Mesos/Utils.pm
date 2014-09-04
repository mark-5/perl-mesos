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

use Data::Rmap;
sub encode_protobufs {
    my @args = @_;
    my ($encoded) = rmap_all {
        my $ref = ref $_;
        if ($ref eq 'HASH') {
            $_ = {%$_};
        } elsif ($ref eq 'ARRAY') {
            $_ = [@$_];
        } elsif ($ref) {
            $_ = $_->encode if $_->can('encode');
        }
        $_;
    } \@args;
    return @$encoded;
};


1;
