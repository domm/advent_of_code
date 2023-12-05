use 5.034;
use strict;
use warnings;
use List::Util qw(min max);

my @blocks = split(/\n\n/,join('',<>));
my %seeds = grep { /^\d+$/ } split(/\s+/,shift @blocks);
my @maps;
for my $def (@blocks) {
    my @def = split(/\n/,$def);
    shift(@def); # remove label
    my @map;
    for my $line (@def) {
        my ($dest_start, $source_start, $length) = split(/\s+/, $line);
        push(@map, { map_start => $source_start, map_stop => $source_start + $length -1, dest_start => $dest_start, dest_stop =>$dest_start + $length -1, length=>$length });
    }
    push(@maps, \@map);
}
my $lowest=999999999999999999999;

my @ranges;
for my $seed_start (sort keys %seeds) {
    my $seed_length = $seeds{$seed_start};
    say "$seed_start -> $seed_length";

    push (@ranges,{ check_start => $seed_start, check_stop => $seed_start + $seed_length - 1, length=>$seed_length });
}
use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@ranges;
my $c=1;
for my $map (@maps) {
    say "in MAP ".$c++;
    my @nextnext;
    for my $entry ($map->@*) {
        my @next;
        while (@ranges) {
            my $check = shift @ranges;
            printf("check overlap of check %i-%i with map %i->%i \n", $check->{check_start},$check->{check_stop}, $entry->{map_start},$entry->{map_stop});
            if (($check->{check_stop} < $entry->{map_start}) || ($check->{check_start} > $entry->{map_stop})) {
                say "\tbefore/after this map";
                push(@next, $check);
            }
            elsif ($check->{check_stop} >= $entry->{map_start} || $check->{check_start} <= $entry->{map_stop}) {
                say "\toverlap with map, split and pass to next map";
                if ($check->{check_start} < $entry->{map_start}) {
                    say "\t\tchop of before to check further with this map: ".sprintf("%i-%i",$check->{check_start},$entry->{map_start}-1 );
                    push(@ranges, {check_start=>$check->{check_start}, check_stop=>$entry->{map_start}-1});
                }
                if ($check->{check_stop} > $entry->{map_stop}) {
                    say "\t\tchop of after to check further with this map: ".sprintf("%i-%i",$check->{map_stop}+1, check_stop=>$entry->{check_stop});
                    push(@ranges, {check_start=>$check->{map_stop}+1, check_stop=>$entry->{check_stop}});
                }
                my $overlap_start = max($check->{check_start}, $entry->{map_start});
                my $overlap_stop = min($check->{check_stop}, $entry->{map_stop});
                my $offset = $entry->{dest_start} - $entry->{map_start};
                say "\t\toverlap $overlap_start $overlap_stop  offset $offset";

                push(@nextnext, {check_start => $overlap_start + $offset, check_stop=>$overlap_stop + $offset});
                @ranges=();
            }
        }
        push(@ranges,@next);
    use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@ranges;
    }
    push(@ranges,@nextnext);
    use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@ranges;
}

    use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@ranges;
for (@ranges) {
     $lowest = $_->{check_start} if $_->{check_start} < $lowest;
}

say $lowest;
