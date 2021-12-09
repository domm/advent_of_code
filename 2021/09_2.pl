use 5.030;
use strict;
use warnings;

my @map;
my ($r)=0;
for (<>) {
    chomp;
    my $c=0;
    for (split(//)) {
        $map[$r]->[$c++] = $_;
    }
    $r++;
}

my ($risk,$sum)=(0,0);
my %hits;
for (my $r=0;$r<@map;$r++) {
    for (my $c=0;$c<$map[$r]->@*;$c++) {
        my $heat = $map[$r]->[$c];
        my $lower=0;
        for my $move ([-1,0],[1,0],[0,-1],[0,1]) {
            my $val = $map[$r + $move->[0]]->[$c + $move->[1]];
            if (not defined $val) {
                $lower++;
            }
            elsif ($heat < $val) {
                $lower++;
            }
            if ($lower == 4) {
                $hits{$r.':'.$c} = $heat;
                $sum += $heat +1;
            }
        }
    }
}

say $sum;


