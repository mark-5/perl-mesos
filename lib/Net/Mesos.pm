package Net::Mesos;
use strict;
use warnings;

=head1 NAME

Net::Mesos

=head1 VERSION

Version 1.00

=cut

use XSLoader;
use Exporter 5.57 'import';

our $VERSION = '1.00';
our %EXPORT_TAGS = ( 'all' => [] );
our @EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } );

XSLoader::load('Net::Mesos', $VERSION);

1;
