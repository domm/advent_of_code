use 5.030;
use strict;
use warnings;

my @algo =map { $_ eq '#' ? 1 : 0 } split(//,<>);
<>;

my %map;
my $r=0;
my ($min,$max) = (-1,0);
for my $row (<>) {
    chomp($row);
    my $c=0;
    for my $col (split(//,$row)) {
        $map{"$r:$c"} = $col eq '#' ? 1 : 0;
        $c++;
    }
    $r++;
}
$max=$r + 1;

my @look = ([-1,-1],[-1,0],[-1,1],[0,-1],[0,0],[0,1],[1,-1],[1,0],[1,1]);

for my $step (1 .. 2) {
    my %enhanced;
    for my $r ($min  .. $max) {
        for my $c ($min .. $max) {
            my $bits;
            for my $l (@look) {
                my $look = $map{join(':',$r+$l->[0],$c+$l->[1])};
                $bits .= $look ? 1 : 0;
            }
            my $new =  $algo[oct('0b'.$bits)];
            $enhanced{"$r:$c"} = $new;
            # say oct('0b'.$bits);
            # say $algo[oct('0b'.$bits)] ;
            # say $enhanced{"$r:$c"};
            # exit;
        }
    }
    %map = %enhanced;
    $min--;
    $max++;

    my $lit = 0;
    for (values %map) {
        $lit++ if $_ == 1;
    }
    say "$step LIT $lit";
}


