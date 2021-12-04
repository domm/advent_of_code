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
    my @num = split( / +/, $_ );
    for ( my $c = 0; $c < 5; $c++ ) {
        my $val = $num[$c];
        $boards[$b]->[$r]->{$val} = $val;
        $boards[$b]->[ $c + 5 ]->{$val} = $val;
    }
    $r++;
}
shift @boards;

for my $drawn (@numbers) {
    for my $board (@boards) {
        for my $line ( $board->@* ) {
            if ( exists $line->{$drawn} ) {
                $line->{$drawn} = 'X';
            }

            my @checked = grep {/X/} values $line->%*;
            if ( @checked == 5 ) {
                # WINNER!
                my $sum;
                for my $r ( 0 .. 4 ) {
                    for my $n ( keys $board->[$r]->%* ) {
                        $sum += $n unless $board->[$r]{$n} eq 'X';
                    }
                }
                say $sum;
                say $drawn;
                say $sum * $drawn;
                exit;
            }
        }
    }
}

