package Mesos::Channel;
use Moo;
use Data::Dumper;
use Carp;
use strict;
use warnings;

use Mesos::Channel::Pipe;
sub new { Mesos::Channel::Pipe->new( splice(@_, 1) ) }

1;
