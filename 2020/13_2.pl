use strict;
use warnings;
use 5.030;
no strict 'refs';

my $ts = shift;
my $ignore = <>;
my @buses = split(',',<>);
my @b;
for(my $i=0;$i<@buses;$i++) {
    my $b =  $buses[$i];
    chomp($b);
    next if $b eq 'x';
    push(@b,[$b,$i]);
}
my @sorted = sort { $b->[0] <=> $a->[0] } @b;

my $offset = $sorted[0];
while (1) {
    my $check = ($ts + $sorted[0][1]) / $sorted[0][0];
    if($check eq int($check)) {
        last;
    }
    $ts++;
}
say "START WITH $ts";
my $counter = ($sorted[0][0])**4;

CHECKTS: while (1) {
    my $hits=0;
    exit if $ts > 402251700208309;
    say $ts if ($ts + $sorted[0][1]) % $counter ==0;

    foreach my $d (@sorted) {
        my $bus_ts = $ts + $d->[1];
        my $check = (($ts + $d->[1]) / $d->[0]);
        #   say "$ts  - $bus_ts - bus ".$d->[0]." with offset ".$d->[1]. " : $check";
        if (int($check) == $check) {
            $hits++;
        } else {
            $ts += $sorted[0][0];
            next CHECKTS;
        }
    }
    if ($hits eq @b) {
        say "GOT IT: ". $ts;
        exit;
    }
}

