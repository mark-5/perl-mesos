on develop => sub {
    requires 'Async::Interrupt';
    requires 'ExtUtils::CppGuess';
    requires 'ExtUtils::ParseXS', '3.18';
    requires 'ExtUtils::Typemaps';
    requires 'ExtUtils::Typemaps::ObjectMap';
    requires 'ExtUtils::Typemaps::STL';
    requires 'FindBin';
    requires 'Future::Mojo';
    requires 'IO::Async::Handle';
    requires 'List::Util';
    requires 'Module::Install::AuthorTests';
    requires 'Module::Install::CPANfile';
    requires 'Module::Install::ReadmePodFromPod';
    requires 'Module::Install::XSUtil';
    requires 'Mojolicious';
    requires 'POE';
    requires 'POE::Future';
};

on configure => sub {
    requires 'ExtUtils::CppGuess';
    requires 'ExtUtils::ParseXS', '3.18';
    requires 'ExtUtils::Typemaps::ObjectMap';
    requires 'ExtUtils::Typemaps::STL';
    requires 'File::Temp';
    requires 'List::Util';
};

feature 'async-interrupt', 'Async::Interrupt support' => sub {
    recommends 'Async::Interrupt';
};
feature 'io-async', 'IO::Async support' => sub {
    recommends 'IO::Async::Handle';
};
feature 'mojo', 'Mojolicious support' => sub {
    recommends 'Mojolicious';
    recommends 'Future::Mojo';
};
feature 'poe', 'POE support' => sub {
    recommends 'POE';
    recommends 'POE::Future';
};

requires 'namespace::autoclean', '0.16';
requires 'AnyEvent';
requires 'Carp';
requires 'Digest::SHA';
requires 'Google::ProtocolBuffers';
requires 'Module::Runtime';
requires 'Moo';
requires 'Scalar::Util';
requires 'Scope::Guard';
requires 'Type::Tiny';
requires 'XSLoader';

on test => sub {
    requires 'AnyEvent::Future';
    requires 'Test::Class::Moose', '0.55';
    requires 'Test::LeakTrace';
    requires 'Test::More';
    requires 'Test::Pod';
    requires 'Test::Strict';
    requires 'Try::Tiny';
};
