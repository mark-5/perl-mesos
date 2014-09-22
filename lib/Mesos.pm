package Mesos;
use strict;
use warnings;

=head1 NAME

Mesos

=head1 DESCRIPTION

Perl bindings for Apache Mesos.

=head1 AUTHOR

Mark Flickinger E<lt>maf@cpan.orgE<gt>

=cut

use XSLoader;
use Exporter 5.57 'import';

our $VERSION = '1.01';
our %EXPORT_TAGS = ( 'all' => [] );
our @EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } );

XSLoader::load('Mesos', $VERSION);

1;
