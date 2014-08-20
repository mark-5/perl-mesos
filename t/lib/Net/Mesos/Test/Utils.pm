package Net::Mesos::Test::Utils;
use strict;
use warnings;
use Mesos::Messages;
use parent 'Exporter';
our @EXPORT = qw(test_master test_framework test_scheduler);
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
    return undef;
}


1;
