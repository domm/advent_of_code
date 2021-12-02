use 5.030;
use strict;
use warnings;

my $depth = 0;
my $hor = 0;
my $aim = 0;
for my $command ( <> ) {
    if ($command =~ /f.*(\d+)/) {
        $hor+=$1;
        $depth += ($1 *$aim);
    }
    elsif ($command =~ /d.*(\d+)/) {
        $aim += $1;
    }
    elsif ($command =~ /u.*(\d+)/) {
        $aim -= $1;
    }
}
say "$hor $depth ". $hor * $depth;
