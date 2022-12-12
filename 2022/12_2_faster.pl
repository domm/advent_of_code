use 5.030;
use strict;
use warnings;
use Heap::Simple;

my @in = map { chomp; $_ } <>;
my %map;
my @start;
my $end;
for my $r (0 .. $#in) {
    my @row = split(//,$in[$r]);
    for my $c (0 .. $#row) {
        $row[$c] = 'a' if $row[$c] eq 'S';
        my $ord = ord($row[$c]);
        if ($row[$c] eq 'a') {
            push(@start,$r.':'.$c);
        }
        elsif ($row[$c] eq 'E') {
            $ord = ord('z') + 1;
            $end=$r.':'.$c ;
        }
        $map{$r.':'.$c} = $ord;
    }
}

my %visited;
my $todo = Heap::Simple->new( order => "<", elements => [ Array => 0 ] );
for my $s (@start) {
    $todo->insert( [ 0, split(/:/,$s), {} ] );
    $visited{$s}=0;
}
while ( $todo->count ) {
    my ( undef, $r, $c ) = $todo->extract_top->@*;
    for my $look ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
        my $lr  = $r + $look->[0];
        my $lc  = $c + $look->[1];
        my $target = "$lr:$lc";
        next unless $map{$target} && $map{$target} <= $map{$r.':'.$c} + 1;
        my $cost = $visited{"$r:$c"} + 1;
        if ( !defined $visited{$target} || $visited{$target} > $cost ) {
            $visited{$target} = $cost;
            $todo->insert( [ $visited{$target}, $lr, $lc ] );
        }
    }
}

say $visited{$end};
