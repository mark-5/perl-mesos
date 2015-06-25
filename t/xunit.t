use Test::Class::Moose::Load 't/lib';
use Test::Class::Moose::Runner;
Test::Class::Moose::Runner->new(test_classes => \@ARGV)->runtests;
