use 5.030;
use strict;
use warnings;
use List::Util qw(sum);

my @fish = map { 0 } ( 0 .. 8 );
$fish[ $_ ]++ for ( split( ',', <> ) );

for my $day ( 1 .. 256 ) {
    my $born = 0;
    for my $gen ( 0 .. 8 ) {
        if ( $gen == 0 ) {
            $born = $fish[$gen];
        }
        else {
            $fish[ $gen - 1 ] = $fish[$gen];
        }
    }
    $fish[6] += $fish[8] = $born;
    say "$day: ".sum(@fish) if ( $day == 80 || $day == 256 );
}

