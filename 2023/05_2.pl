use 5.034;
use strict;
use warnings;
use List::Util qw(min max);

my $debug = 0;
my @blocks = split(/\n\n/,join('',<>));

my %seeds = grep { /^\d+$/ } split(/\s+/,shift @blocks);
my @ranges = map { { start=>$_, stop => $_ + $seeds{$_} - 1  } } keys %seeds; ;

my @maps;
for my $def (@blocks) {
    my @def = split(/\n/,$def);
    shift(@def); # remove label
    my @map;
    for my $line (@def) {
        my ($dest_start, $source_start, $length) = split(/\s+/, $line);
        push(@map, { start => $source_start, stop => $source_start + $length -1, dest_start => $dest_start, dest_stop =>$dest_start + $length -1 });
    }
    push(@maps, \@map);
}

for my $map (@maps) {
    my @next_set;
    for my $entry ($map->@*) {
        my @next_entry;
        for my $check (@ranges) {
            printf("check overlap of check %i-%i with mapentry %i->%i \n", $check->{start},$check->{stop}, $entry->{start},$entry->{stop}) if $debug;
            if (($check->{stop} < $entry->{start}) || ($check->{start} > $entry->{stop})) {
                say "\tbefore/after this map, so pass to next entry" if $debug;
                push(@next_entry, $check);
            }
            elsif ($check->{stop} >= $entry->{start} || $check->{start} <= $entry->{stop}) {
                say "\toverlap with map, split and pass to next map" if $debug;
                if ($check->{start} < $entry->{start}) {
                    say "\t\tchop of before to check further with this map: ".sprintf("%i-%i",$check->{start},$entry->{start}-1 ) if $debug;
                    push(@next_entry, {start=>$check->{start}, stop=>$entry->{start}-1});
                }
                if ($check->{stop} > $entry->{stop}) {
                    say "\t\tchop of after to check further with this map: ".sprintf("%i-%i",$entry->{stop}+1, $check->{stop}) if $debug;
                    push(@next_entry, {start=>$entry->{stop}+1, stop=>$check->{stop}});
                }
                my $overlap_start = max($check->{start}, $entry->{start});
                my $overlap_stop = min($check->{stop}, $entry->{stop});
                my $offset = $entry->{dest_start} - $entry->{start};
                say "\t\toverlap $overlap_start $overlap_stop offset $offset" if $debug;

                push(@next_set, {start => $overlap_start + $offset, stop=>$overlap_stop + $offset});
            }
        }
        @ranges = @next_entry;
    }
    push(@ranges, @next_set);
}

say min(map { $_->{start} } @ranges);
