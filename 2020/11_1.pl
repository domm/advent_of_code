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
            my $neigh=0;
            foreach my $l (@around) {
                my $m=$r+$l->[0];
                my $n=$c+$l->[1];
                next if $m<0 || $n<0;
                my $val = $map[$m]->[$n];
                $neigh++ if $val eq '#';
               }
            if ($old eq 'L' && $neigh == 0) {
                $next[$r][$c] = '#'
            }
            elsif ($old eq '#' && $neigh >= 4) {
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

