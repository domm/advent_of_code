use strict;
use warnings;
use 5.030;

my $valid;
while ( my $line = <STDIN> ) {
    chomp($line);
    my ( $min, $max, $letter, $pwd ) = $line =~ /^(\d+)-(\d+) (\w): (\w+)$/;
    my $cnt = () = $pwd =~ /$letter/g;

    $valid++ if ( $min <= $cnt && $cnt <= $max );
}
say $valid;

