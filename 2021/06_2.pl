use 5.030;
use strict;
use warnings;

my %fish = map { $_ => 0 } ( 0 .. 8 );
for ( split( ',', <> ) ) {
    $fish{ int $_ }++;
}

for my $day ( 1 .. 256 ) {
    my $born = 0;
    my $total = 0;
    for my $fish ( sort keys %fish ) {
        my $count = $fish{$fish};
        if ( $fish == 0 ) {
            $born = $count;
            $total += $count;
        }
        else {
            $fish{ $fish - 1 } = $count;
            $fish{$fish} = 0;
        }
        $total += $count;
    }
    $fish{6} += $born;
    $fish{8} = $born;
    say "day $day: $total" if ( $day == 80 || $day == 256 );
}

