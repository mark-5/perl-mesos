package Mesos::Utils;
use parent 'Exporter';
use Package::Stash;

our @EXPORT_OK = qw(import_methods);

sub import_methods {
    my $to_class = caller;
    my ($from_class) = @_;
    my ($to_stash, $from_stash) = map {Package::Stash->new($_)} $to_class, $from_class;
    my $from_methods = $from_stash->get_all_symbols("CODE") || {};
    $to_stash->add_symbol("&$_", $from_methods->{$_}) for keys %$from_methods;
}

1;
