use inc::Module::Install;
use Config;
use ExtUtils::CppGuess;
use ExtUtils::Typemaps;
use ExtUtils::Typemaps::ObjectMap;
use ExtUtils::Typemaps::STL;

all_from 'lib/Mesos.pm';
readme_pod_from 'lib/Mesos.pm';

homepage   'https://github.com/mark-5/perl-mesos';
bugtracker 'https://github.com/mark-5/perl-mesos/issues';
repository 'https://github.com/mark-5/perl-mesos.git';

assert_mesos_libs();
assert_protobuf_headers(2005000);

requires_cplusplus;
cc_append_to_ccflags '-std=c++11';
cc_include_paths 'include';
cc_libs '-lmesos';
cc_src_paths 'src';
clean_files 'src/typemap';
create_typemap('src/typemap');
makemaker_args XSOPT => "-hiertype";
use_ppport;

author_tests 'xt';

no_index directory => 'bin';
cpanfile;
WriteAll;


sub create_typemap {
    my ($file) = @_;
    my $map = ExtUtils::Typemaps->new;
    $map->merge(typemap => $_->new) for qw(
        ExtUtils::Typemaps::ObjectMap
        ExtUtils::Typemaps::STL
    );
    $map->merge(typemap => ExtUtils::Typemaps->new(file => $_))
        for glob "src/*.map";
    $map->write(file => $file);
}

sub assert_mesos_libs {
    my $src = write_cpp(headers => ["mesos/mesos.hpp"]);
    (my $bin = $src) =~ s/\.cpp$//;

    my $cmd = sprintf "%s -lmesos -o $bin $src", cpp_compiler();
    my $output = `$cmd 2>&1`;
    my $failed = $?;
    -e $_ and unlink $_ for $bin, $src;

    if ($failed) {
        my $message = "Can't link/include mesos C++ library:\n";
        $message .= "$cmd\n\n";
        $message .= "$output\n";
        warn $message;
        exit 0;
    }
}

sub assert_protobuf_headers {
    my ($need_version) = @_;
    my $code = q|printf("%d", GOOGLE_PROTOBUF_VERSION);|;
    my $src = write_cpp(
        code    => $code,
        headers => ["google/protobuf/message.h", "cstdio"],
    );
    (my $bin = $src) =~ s/\.cpp$//;
    my $cmd = sprintf "%s -o $bin $src", cpp_compiler();
    my $output = `$cmd 2>&1`;
    my $failed = $?;

    if ($failed) {
        my $message = "Can't link/include protobuf C++ library\n";
        $message .= "$cmd\n\n";
        $message .= "$output\n";
        warn $message;
        exit 0;
    }

    my $version = qx|$bin|;
    unless ($version and $version >= $need_version) {
        warn "Protobuf version must $need_version or above. Detected $version";
        exit 0;
    }

    -e $_ and unlink $_ for $bin, $src;
}

sub write_cpp {
    my (%args) = @_;
    my($fh, $path) = File::Temp::tempfile(SUFFIX => '.cpp');
    print $fh "#include <$_>\n" for @{$args{headers}||[]};
    print $fh "int main(void) { $args{code} return 0; }\n";
    close $fh;
    return $path;
}

our $_cpp_compiler;
sub cpp_compiler {
    $_cpp_compiler ||= do {
        my $guess = ExtUtils::CppGuess->new->guess_compiler;
        sprintf join " ", $Config{cc}, @{$guess}{qw(extra_cflags extra_lflags)};
    };
}
