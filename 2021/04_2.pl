use 5.030;
use strict;
use warnings;

my @numbers = split( /,/, <> );
my @boards;

my ( $b, $r ) = 0;
for (<>) {
    chomp;
    if ( $_ !~ /\d/ ) { # newline, so start a new board
        $b++;
        $r = 0;
        next;
    }
    s/^ //;
    my @num = split(/ +/);
    for ( my $c = 0; $c < @num; $c++ ) {
        my $val = $num[$c];
        $boards[$b]->[$r]->{$val} = $val;
        $boards[$b]->[ $c + @num ]->{$val} = $val;
    }
    $r++;
}
shift(@boards);

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
                push(@results, $sum * $drawn);
            }
        }
    }
}

say "part 1: ".$results[0];
say "part 2: ".$results[-1];

