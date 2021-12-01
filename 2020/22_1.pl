use 5.020;
use strict;
use warnings;

my ($p1,$p2) = split(/\n\n/,join('',<>));

my @p1 = grep {/^\d+$/} split(/\n/,$p1);
my @p2 = grep {/^\d+$/} split(/\n/,$p2);

my $round=1;
while (@p1 && @p2) {
    my $c1 = shift(@p1);
    my $c2 = shift(@p2);
    say "\n$round: $c1 vs $c2";
    if ($c1 > $c2) {
        push(@p1,$c1,$c2);
    }
    else {
        push(@p2,$c2,$c1);
    }

    say "p1: ".join(',',@p1);
    say "p2: ".join(',',@p2);
    $round++;
}

my @winner = reverse (@p1 > @p2 ? @p1 : @p2);
my $score = 0;
for my $i (1 .. @winner) {
    $score+=$i * $winner[$i-1];
    say "$i -> $score";
}
say $score;

