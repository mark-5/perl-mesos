package Mesos::Test::Executor;
use Moo;
use strict;
use warnings;

use Mesos::Channel;
extends 'Mesos::Executor';
with 'Mesos::Test::Role::Process';


1;
