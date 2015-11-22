package DBGp::Client::Response::Simple;

use strict;
use warnings;

sub make_accessors {
    my ($class, @accessors) = @_;

    for my $accessor (@accessors) {
        no strict 'refs';

        *{"${class}::${accessor}"} = sub {
            $_[0]->{$accessor};
        };
    }
}

1;
