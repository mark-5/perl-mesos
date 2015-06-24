package Mesos::XS;
use strict;
use warnings;
use version;
use Exporter 5.57 'import';
use Mesos;
use XSLoader;

XSLoader::load('Mesos', $Mesos::VERSION);

1;
