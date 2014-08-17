#!/usr/bin/perl
use Test::More;
use Net::Mesos::SchedulerChannel;

my $channel = Net::Mesos::SchedulerChannel->new;
like(fileno($channel), qr/^\d+$/, 'channel fileno returned int');

done_testing;
