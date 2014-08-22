package Net::Mesos::Test::Utils;
use strict;
use warnings;
use Mesos::Messages;
use Net::Mesos::Test::Scheduler;
use Net::Mesos::Test::Executor;
use parent 'Exporter';
our @EXPORT = qw(test_master test_framework test_scheduler test_executor);
our @EXPORT_OK = @EXPORT;


sub test_master {
    return $ENV{TEST_MESOS_MASTER} || '127.0.0.1:5050';
}

sub test_framework {
    return Mesos::FrameworkInfo->new({
        user => 'Net_Mesos_test_user',
        name => 'Net_Mesos_test_name',    
    });
}

sub test_scheduler {
    return Net::Mesos::Test::Scheduler->new;
}

sub test_executor {
    return Net::Mesos::Test::Executor->new;
}

1;
