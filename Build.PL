use strict;
use Module::Build::WithXSpp;

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
        'ExtUtils::Typemaps::ObjectMap' => '0.01',
    },
    include_dirs => ['include'],
);

$build->create_build_script;
