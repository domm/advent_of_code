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
            my $r2 = $r + $move->[0];
            my $c2 = $c + $move->[1];
            my $val = $map[$r2]->[$c2];
            if ($r2<0 || $c2<0) {
                $lower++;
            }
            elsif (not defined $val) {
                $lower++;
            }
            elsif ($heat < $val) {
                $lower++;
            }
        }
        if ($lower == 4) {
            $hits{$r.':'.$c} = $heat;
            $sum += $heat +1;
        }
    }
}

my @sizes;
foreach my $sink (keys %hits) {
    my $hit = {};
    my ($r,$c)=split(/:/,$sink);
    walk($r, $c, $hit, 1);
    my $size = scalar keys %$hit;
    push(@sizes,$size);
}

my @sort = sort { $b<=>$a} @sizes;
say $sort[0] *  $sort[1] * $sort[2];


sub walk {
    my ($r, $c, $hit, $l ) = @_;
    my $val = $map[$r]->[$c];
    #say "$l look at $r/$c : ".($val || 'x');
    return if !defined $val || $val == 9 || $val == -1;
    $hit->{"$r:$c"}++;
    $map[$r]->[$c] = -1;

    for my $move ([-1,0],[1,0],[0,-1],[0,1]) {
        my $r2 = $r + $move->[0];
        my $c2 = $c + $move->[1];
        if ($r2<0 || $c2<0) {
            next;
        }
        walk($r2,$c2, $hit, $l+1);
    }

}



