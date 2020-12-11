use strict;
#use warnings;
use 5.030;

$|=1;
my @map = map {chomp; [split//] }  <>;
my $h = @map;
my $w = $map[0]->@*;
my $occ=0;
my @around=([-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]);

while(1) {
    my @next;
    my $thisocc=0;
    for (my $r=0;$r<$h;$r++) {
        for (my $c=0;$c<$w;$c++) {
            my $old=$map[$r][$c];
            my $count = look(\@map, $r, $c);
            if ($old eq 'L' && $count == 0) {
                $next[$r][$c] = '#'
            }
            elsif ($old eq '#' && $count >= 5) {
                $next[$r][$c] = 'L'
            }
            else {
                $next[$r][$c] = $old;
            }
            $thisocc++ if $next[$r][$c] eq '#';
            #print $next[$r][$c];

        }
        #print"\n";
    }
    print '.';
    last if ($thisocc == $occ);
    @map = @next;
    $occ=$thisocc;
    #print "\n";
}
say "\n".$occ;

sub look {
    my ($map, $r, $c) = @_;
    my $count=0;
    foreach my $vec (@around) {

        my $tr=$r;
        my $tc=$c;
        while (1) {
            my $m=$tr+$vec->[0];
            my $n=$tc+$vec->[1];
            last if $m<0 || $n<0 || $m > $h || $n > $w;
            my $val = $map->[$m][$n];
            $count++ if $val eq '#';
            last unless $val  eq '.';
            $tr = $m;
            $tc = $n;
        }
    }
    return $count;
}


