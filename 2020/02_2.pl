use strict;
use warnings;
use 5.030;

my $valid;
while ( my $line = <STDIN> ) {
    chomp($line);
    my ( $p1, $p2, $letter, $pwd ) = $line =~ /^(\d+)-(\d+) (\w): (\w+)$/;
    my @pwd = ( 'X', split( //, $pwd ) );

    my $hit = 0;
    for my $i ( $p1, $p2 ) {
        $hit++ if $pwd[$i] eq $letter;
    }
    $valid++ if $hit == 1;
}
say $valid;

