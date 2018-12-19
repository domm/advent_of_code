use 5.026;
use strict;
#use warnings;

my $minutes = 10;

my @map;
my $i=0;
my $cols=0;
my $rows=0;
foreach my $line (<>) {
    chomp($line);
    my @row = split(//,$line);
    $cols=scalar @row;
    $map[$i++]=\@row;
    $rows++;
}
my $step = 1;
my ($tt, $tl);
for ($step .. $minutes) {
    my @new;
    ($tt, $tl) = (0,0);
    say "After $step minute";
    for (my $x=0;$x<$rows;$x++) {
        for (my $y=0;$y<$cols;$y++) {

            my $this = $map[$x][$y];
            my ($trees, $lumber) = (0,0);
            foreach ( [-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]) {
                my $x1=$x+$_->[0];
                my $y1=$y+$_->[1];
                if ($x1 >=0 && $y1 >= 0 ) {
                    my $there = $map[$x1][$y1];
                    next unless $there;
                    $trees++ if $there eq '|';
                    $lumber++ if $there eq '#';
                }
            }
            my $new;
            if ($this eq '.' && $trees >= 3) {
                $new='|';
            }
            elsif ($this eq '|' && $lumber >= 3) {
                $new = '#';
            }
            elsif ($this eq '#') {
                if( $lumber && $trees ) {
                    $new = '#';
                }
                else {
                    $new = '.';
                }
            }
            else {
                $new = $this;
            }
            print $new[$x][$y] = $new ;
            $tt++ if $new eq '|';
            $tl++ if $new eq '#';
        }
        print "\n";
    }
    @map = @new;
    print "\n";
    $step++
}

print "$tt x $tl = ".$tt*$tl;

