package Mesos::Dispatcher::Pipe;
use Moo;
extends 'Mesos::Dispatcher';

after recv => sub { shift->read_pipe };

1;
