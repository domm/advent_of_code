use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my %nodes;
for (<>) {
    chomp;
    my ( $from, $to ) = split(/-/);
    push( $nodes{$from}->@*, $to );
    push( $nodes{$to}->@*,   $from ) unless $to eq 'end';
}

say walk('start');

sub walk ( $node, %seen ) {
    return 1 if $node eq 'end';
    return 0 if $node =~ /[a-z]/ && $seen{$node}++;

    my $paths = 0;
    foreach my $next ( $nodes{$node}->@* ) {
        next if $seen{$next};
        $paths += walk( $next, %seen );
    }
    return $paths;
}

