package Mesos;
use strict;
use warnings;

=head1 NAME

Mesos

=head1 VERSION

Version 1.00

=head1 AUTHOR

Mark Flickinger E<lt>maf@cpan.orgE<gt>

=cut

use XSLoader;
use Exporter 5.57 'import';

our $VERSION = '1.00';
our %EXPORT_TAGS = ( 'all' => [] );
our @EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } );

XSLoader::load('Mesos', $VERSION);

1;
