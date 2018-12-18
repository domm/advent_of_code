use 5.026;
use strict;
#use warnings;

my $minutes = 1000000000;

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
my $deb=0;
my $step = 1;
my ($tt, $tl);
my $prev_sum=0;
my $prev_diff=-10;
my $found_step;
my $found_diff;
my @repeat;
my %rep;
for ($step .. $minutes) {
    my @new;
    ($tt, $tl) = (0,0);
    #say "After $step minute";
    for (my $x=0;$x<$rows;$x++) {
        for (my $y=0;$y<$cols;$y++) {

            my $this = $map[$x][$y];
            my ($trees, $lumber) = (0,0);
            foreach ( [-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]) {
                my $x1=$x+$_->[0];
                my $y1=$y+$_->[1];
                if ($x1 >=0 && $y1 >= 0 ) {
                    my $there = $map[$x1][$y1];
                    say "$x1, $y1, $there" if $deb;
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
            $new[$x][$y] = $new ;
            $tt++ if $new eq '|';
            $tl++ if $new eq '#';
        }
        # print "\n";
    }
    @map = @new;
    #print "\n";
    $step++;
    my $sum = $tt*$tl;
    my $diff = $sum - $prev_sum;
    $prev_sum=$sum;
    #if ($i > 100 && $prev_diff == $diff) {
    #    say $sum + ( $diff * ( $gen - $i ));
    #    exit;
    #}
    if ($step > 600) {
        if ($prev_diff == 0) {
            $found_diff = $diff;
            $found_step = $step;
        }
        if ($diff && $found_diff && $diff == $found_diff && $step > ($found_step+1)) {
            say "cycle at $step";

            my $mod = ($minutes - $step + 1) % scalar keys %rep;
            say $mod;
            say $rep{$mod};
            exit;
        }
        if ($found_step) {
            $rep{$step - $found_step} = $sum;
        }
    }
    $prev_diff = $diff;
    say "$step $sum $diff ($prev_diff, $found_diff, $found_step,)";
    say $step if $step % 10000 == 0;
}

print "$tt x $tl = ".$tt*$tl;


