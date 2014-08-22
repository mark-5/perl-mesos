#!/usr/bin/perl
use strict;
use warnings;
use FindBin::libs;
use Test::More;
use Net::Mesos::Channel;

my $channel = Net::Mesos::Channel->new;
like(fileno($channel), qr/^\d+$/, 'channel fileno returned int');

is($channel->recv, undef, 'returned undef on empty recv');

my $sent_command = "test command";
my @sent_args = qw(some test args);
$channel->send($sent_command, @sent_args);
my ($command, @args) = $channel->recv;
is($command, $sent_command, 'received sent command');
is_deeply(\@args, \@sent_args, 'received sent args');

is($channel->recv, undef, 'cleared queue');
done_testing;
