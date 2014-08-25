use strict;
use Module::Build::WithXSpp;
use Devel::CheckLib;

check_lib_or_exit(
    lib    => 'mesos',
);

my @my_cpp_headers = glob q(src/*.hpp);
my $build = Module::Build::WithXSpp->new(
    dist_abstract   => 'lib/Net/Mesos.pm',
    module_name     => 'Net::Mesos',
    license         => 'perl',
    recommends      => {
        'Test::LeakTrace' => 0,
    },
    requires        => {
        'Moo'             => 0,
        'Try::Tiny'       => 0,
        'Exporter'        => '5.57',
        'AnyEvent'        => 0,
        'Types::Standard' => 0,
        'Google::ProtocolBuffers' => 0,
    },
    test_requires => {
        'Test::Most'     => 0,
        'FindBin::libs'  => 0,
    },
# Provides useful extra C typemaps for opaque objects:
    extra_typemap_modules => {
        'ExtUtils::Typemaps::ObjectMap' => '0',
        'ExtUtils::Typemaps::STL'       => '0',
    },
    include_dirs         => [qw(include /usr/local/include/mesos)],
    early_includes       => [@my_cpp_headers, 'mesos/scheduler.hpp', 'mesos/executor.hpp'],
    extra_compiler_flags => [qw(-std=c++11)],
    extra_linker_flags   => [qw(-lmesos)],
);

$build->create_build_script;
