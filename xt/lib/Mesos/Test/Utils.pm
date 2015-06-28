package Mesos::Test::Utils;
use strict;
use warnings;
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use Mesos::Types qw(ExecutorInfo FrameworkInfo);
use parent 'Exporter';
our @EXPORT = qw(
    test_executor
    test_framework
    test_master
    xt_root
);

sub test_executor {
    my ($command) = @_;
    $command //= "/bin/echo perl test executor";
    return ExecutorInfo->new({
        executor_id => {value => 'default'},
        command     => {value => $command},
    });
}

sub test_framework {
    FrameworkInfo->new({
        user => $ENV{USER},
        name => 'Test Framework (Perl)',
    });
}

sub test_master {
    $ENV{MESOS_TEST_MASTER} // 'localhost:5050';
}

our $_XT_ROOT;
sub xt_root {
    $_XT_ROOT //= do {
        my $current_dir = abs_path(dirname __FILE__);
        (my $xt_root = $current_dir) =~ s#/xt/.*?$#/xt#;
        $xt_root;
    };
}

1;
