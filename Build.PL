use strict;
use Module::Build::WithXSpp;

my $build = Module::Build::WithXSpp->new(
    dist_abstract   => 'lib/Net/Mesos.pm',
    module_name     => 'Net::Mesos',
    license         => 'perl',
    recommends      => {
        'Test::LeakTrace' => 0,
    },
    requires        => {
        'AnyEvent'        => 0,
        'Data::Rmap'      => 0,
        'Exporter'        => 0,
        'Moo'             => 0,
        'Try::Tiny'       => 0,
        'Types::Standard' => 0,
        'ExtUtils::ParseXS' => 3.18,
        'Class::Method::Modifiers' => 0,
        'Google::ProtocolBuffers'  => 0,
    },
    configure_requires => {
        'Devel::CheckLib' => 0,
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
    include_dirs         => [qw(include)],
    early_includes       => [qw(mesos/scheduler.hpp mesos/executor.hpp)],
    extra_compiler_flags => [qw(-std=c++11)],
    extra_linker_flags   => [qw(-lmesos)],
);

if (eval {require Devel::CheckLib}) {
    Devel::CheckLib::check_lib_or_exit(
        lib => 'mesos',
    );
}


$build->args('mesos-install', find_mesos_install_path())
    if not $build->args('mesos-install');
push @{$build->include_dirs}, $build->args('mesos-install') if $build->args('mesos-install');

if (lc $^O eq 'darwin' and lc $build->config->{cc} eq 'cc') {
    push @{$build->extra_compiler_flags}, '-Wno-reserved-user-defined-literal';
}

$build->create_build_script;


sub find_mesos_install_path {
    my ($path) = grep {-d} map {"$_/mesos"} qw(/usr/include /usr/local/include);
    $path ||= Module::Build->prompt("Please enter path to mesos install", "/usr/local/include/mesos");
    return $path;
}
