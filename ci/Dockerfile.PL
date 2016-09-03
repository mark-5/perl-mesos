#!/usr/bin/env perl
use strict;
use warnings;
use IO::File;
my $path = substr($0, 0, -3);

my @missing = grep { not exists $ENV{$_} } qw(
    MESOS_VERSION
    PERL_VERSION
    PROTOBUF_VERSION
);
if (@missing) {
    my $msg = "Missing required env vars:\n";
    $msg   .= "  $_\n" for @missing;
    die "$msg\n";
}

my $mesos_version    = $ENV{MESOS_VERSION};
my $perl_version     = $ENV{PERL_VERSION};
my $protobuf_version = $ENV{PROTOBUF_VERSION};

my @system_packages = qw(
    curl
    g++
);

my $file = IO::File->new($path, 'w')
    or die "cannot open $path for writing: !";
print $file <<"__END__";

FROM perl:$perl_version

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \\
  apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \\
  apt-get -y update && \\
  apt-get -y install mesos=$mesos_version @system_packages && \\
  apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/google/protobuf/releases/download/v$protobuf_version/protobuf-$protobuf_version.tar.gz | tar -C /tmp -zxf - && \\
    cd /tmp/protobuf-$protobuf_version && \\
    ./configure --prefix=/usr && \\
    make install && \\
    rm -rf /tmp/protobuf-$protobuf_version

ENV MESOS_CONTAINERIZERS mesos
ENV MESOS_SYSTEMD_ENABLE_SUPPORT false
ENV MESOS_WORK_DIR /tmp/mesos

WORKDIR /tmp/perl
COPY cpanfile .
RUN cpanm --quiet --notest --with-develop --with-all-features --installdeps .

WORKDIR /code
COPY . /code

__END__
