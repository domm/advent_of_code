use 5.030;
use strict;
use warnings;
use utf8;

my @numbers = split (/,/,<>);
my @boards;
my %drawn;

my ($b,$r)=0;
for (<>) {
    chomp;
    if ($_ !~/\d/) {
        $b++;
        $r=0;
        next;
    }
    s/^ //;
    my @num = split(/ +/,$_);
    for (my $c=0;$c<5;$c++) {
        my $val = $num[$c];
        $boards[$b]->[$r]->{$val} = $val;
        $boards[$b]->[$c+5]->{$val} = $val;
    }
    $r++;
}
my $nope = shift @boards;
    say scalar @boards;

my $winners=0;
DRAW: for my $drawn (@numbers) {
    for (my $i=0;$i<@boards;$i++) {
        my $board = $boards[$i];
        next if $board eq 'winner';
        for my $line ($board->@*) {
            if ($line->{$drawn}) {
                $line->{$drawn} = 'X';
            }

            my @checked = grep { /X/ } values $line->%*;
            if (@checked == 5) {
                $boards[$i]='winner';
                $winners++;
                say "draw $drawn winners $winners";
            
                if ($winners == @boards) {
                    my $sum;
                    for my $r (0..4) {
                        for my $n (keys $board->[$r]->%*) {
                            $sum+=$n unless $board->[$r]{$n} eq 'X';
                        }
                    }
                    say $sum;
                    say $drawn;
                    say $sum * $drawn;
                    exit;
                }
                #next DRAW;
            }
        }
    }
}

