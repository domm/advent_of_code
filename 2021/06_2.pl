use 5.030;
use strict;
use warnings;

my %fish = map { $_ => 0 } ( 0 .. 8 );
for ( split( ',', <> ) ) {
    $fish{ int $_ }++;
}

for my $day ( 1 .. 256 ) {
    my $born  = 0;
    my $total = 0;
    for my $gen ( sort keys %fish ) {
        $total += $fish{$gen};
        if ( $gen == 0 ) {
            $born = $fish{$gen};
            $total += $fish{$gen};
        }
        else {
            $fish{ $gen - 1 } = $fish{$gen};
            $fish{$gen} = 0;
        }
    }
    $fish{6} += $fish{8} = $born;
    say "day $day: $total" if ( $day == 80 || $day == 256 );
}

