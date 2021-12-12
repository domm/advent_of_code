use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my %nodes;
for (<>) {
    chomp;
    my ( $from, $to ) = split(/-/);
    push( $nodes{$from}->@*, $to ) unless $to eq 'start';;
    push( $nodes{$to}->@*,   $from ) unless $to eq 'end' || $from eq 'start';
}

say walk('start',0 );

sub walk ( $node, $seen_one_small_cave, %seen ) {
    return 1 if $node eq 'end';

    $seen_one_small_cave = 1 if $node =~ /[a-z]/ && ++$seen{$node} == 2;

    my $paths = 0;
    foreach my $next ( $nodes{$node}->@* ) {
        next if $seen{$next} && $seen_one_small_cave;
        $paths += walk( $next, $seen_one_small_cave, %seen );
    }
    return $paths;
}

