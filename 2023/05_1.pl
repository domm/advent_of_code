use 5.034;
use strict;
use warnings;

my @blocks = split(/\n\n/,join('',<>));
my @seeds = grep { /^\d+$/ } split(/\s+/,shift @blocks);
my @maps;
for my $def (@blocks) {
    my @def = split(/\n/,$def);
    shift(@def); # remove label
    my @map;
    for my $line (@def) {
        my ($dest_start, $source_start, $range) = split(/\s+/, $line);
        push(@map, [$source_start, $source_start + $range -1,$dest_start]);
    }
    push(@maps, \@map);
}

my $lowest=999999999999999999999;

for my $seed (@seeds) {
    for my $map (@maps) {
        my $next = $seed;
        MAP: for my $entry ($map->@*) {
            if ($entry->[0] <= $seed <= $entry->[1]) {
                #        say "mapped $seed";
                my $offset = $seed - $entry->[0];
                $next = $entry->[2] + $offset;
                last MAP;
            }
        }
        # say "next: $next";
        $seed = $next;
    }
    $lowest = $seed if $seed < $lowest;
}

say $lowest;

