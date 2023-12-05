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

for my $val (@seeds) {
    for my $map (@maps) {
        MAP: for my $entry ($map->@*) {
            if ($entry->[0] <= $val <= $entry->[1]) {
                my $offset = $val - $entry->[0];
                $val = $entry->[2] + $offset;
                last MAP;
            }
        }
    }
    $lowest = $val if $val < $lowest;
}

say $lowest;
