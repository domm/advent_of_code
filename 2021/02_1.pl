use 5.030;
use strict;
use warnings;

my $depth = 0;
my $hor = 0;
for my $command ( <> ) {
    if ($command =~ /f.*(\d+)/) {
        $hor+=$1;
    }
    elsif ($command =~ /d.*(\d+)/) {
        $depth += $1;
    }
    elsif ($command =~ /u.*(\d+)/) {
        $depth -= $1;
    }
}
say "$hor $depth ". $hor * $depth;
