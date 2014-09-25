package Mesos::Test::Scheduler;
use Moo;
use strict;
use warnings;

use Mesos::Channel;
extends 'Mesos::Scheduler';
with 'Mesos::Test::Role::Process';


1;
