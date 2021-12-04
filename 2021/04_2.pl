use 5.030;
use strict;
use warnings;

my @in      = split( /\n\n/, join( '', <> ) );
my @numbers = split( /,/,    shift(@in) );
my @boards;

my ( $b, $r ) = 0;
for ( my $b = 0; $b < @in; $b++ ) {
    chomp( $in[$b] );
    my @rows = split( /\n/, $in[$b] );
    for ( my $r = 0; $r < @rows; $r++ ) {
        $rows[$r] =~ s/^ //;
        my @num = split( / +/, $rows[$r] );
        for ( my $c = 0; $c < @num; $c++ ) {
            my $val = $num[$c];
            $boards[$b]->[$r]->{$val} = $val;
            $boards[$b]->[ $c + @num ]->{$val} = $val;
        }
    }
}

my @results;

for my $drawn (@numbers) {
    for ( my $i = 0; $i < @boards; $i++ ) {
        my $board = $boards[$i];
        next if $board eq 'winner';

        for my $line ( $board->@* ) {
            if ( exists $line->{$drawn} ) {
                $line->{$drawn} = 'X';
            }

            my @checked = grep {/X/} values $line->%*;
            if ( @checked == 5 ) {
                $boards[$i] = 'winner';
                my $sum;
                for my $r ( 0 .. 4 ) {
                    for my $n ( keys $board->[$r]->%* ) {
                        $sum += $n unless $board->[$r]{$n} eq 'X';
                    }
                }
                push( @results, $sum * $drawn );
            }
        }
    }
}

say "part 1: " . $results[0];
say "part 2: " . $results[-1];

