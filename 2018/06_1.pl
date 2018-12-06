use 5.010;
use strict;
my @d = <STDIN>;
my $offset = 0;
my $max = 400;
my @map;
my $id='1';
foreach (@d) {
    chomp;
    my ($b,$a) = split(/, /);
    $a+=$offset;
    $b+=$offset;
    foreach my $x (0 .. $max) {
        foreach my $y (0..$max) {
            my $dist = abs($a - $x) + abs($b - $y);
            # say "checking dist $id $a : $b to point $x : $y => $dist";
            if ($dist == 0) {
               $map[$x][$y]=[uc($id),$dist];
               #  say "point";
            }
            elsif (not defined $map[$x][$y][1]) {
               $map[$x][$y]=[lc($id),$dist];
               # say "new";
            }
            elsif ($map[$x][$y][1] == $dist) {
               $map[$x][$y]=['.',$dist];
               # say "same";
            }
            elsif ($map[$x][$y][1] > $dist) {
               $map[$x][$y]=[lc($id),$dist];
               # say "nearest";
            }
        }
    }
    $id++;
}

my %count;


foreach my $x (0 .. $max) {
    foreach my $y (0..$max) {
        my $id = $map[$x][$y][0];
        if ($x == 0 || $y == 0 || $x == $max || $y == $max) {
            $count{$id} = -1;
        }
        $count{$id}++ unless $count{$id} == -1;
        #        print $map[$x][$y][0];
    }
    #    print"\n";
}
my $hit=0;;
foreach my $val (values %count) {
    $hit = $val if $val> $hit;
}

say $hit;


