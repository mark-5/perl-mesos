use strict;
use Module::Build::WithXSpp;

my @my_cpp_headers = glob q(src/*.hpp);
my $build = Module::Build::WithXSpp->new(
    dist_abstract   => 'lib/Net/Mesos.pm',
    module_name     => 'Net::Mesos',
    license         => 'perl',
    requires        => {
        'Exporter'       => '5.57',
    },
    test_requires => {
        'Test::Most'     => 0,
    },
# Provides useful extra C typemaps for opaque objects:
    extra_typemap_modules => {
        'ExtUtils::Typemaps::ObjectMap' => '0',
        'ExtUtils::Typemaps::STL::String' => '0',
    },
    include_dirs => [qw(include /usr/local/include/mesos)],
    early_includes => [@my_cpp_headers, 'mesos/scheduler.hpp'],
    extra_linker_flags => [qw(-lmesos)],
);

$build->create_build_script;
