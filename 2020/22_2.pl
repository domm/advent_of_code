use 5.020;
use strict;
#use warnings;

my ($p1,$p2) = split(/\n\n/,join('',<>));

my %cards;
$cards{1} = [grep {/^\d+$/} split(/\n/,$p1)];
$cards{2} = [grep {/^\d+$/} split(/\n/,$p2)];
my %seen;

my $game = 0;

my $winner =play(%cards);

my @winner = reverse $cards{$winner}->@*;
my $score = 0;
for my $i (1 .. @winner) {
    $score+=$i * $winner[$i-1];
}
say $score;

sub play {
    my %deck = @_;
    my $round = 0;
    $game++;
    while ($deck{1}->@* && $deck{2}->@*) {
        $round++;
        #say "\nRound $round Game $game";
        my $check = join('-',map { join(',',@$_) } $deck{1},$deck{2});
        if ($seen{$check}++) {
            return 1;
        }
        my $c1 = shift($deck{1}->@*);
        my $c2 = shift($deck{2}->@*);
        #say "$c1 vs $c2";
        my @result;
        my $winner;
        if (scalar $deck{1}->@* >= $c1 && scalar $deck{2}->@* >= $c2) {
            $winner = play(
                1=>[grep {$_} @{$deck{1}}[0 .. $c1] ],
                2=>[grep {$_} @{$deck{2}}[0 .. $c2] ],
            );
            @{$deck{1}} = grep {$_} @{$deck{1}};
            @{$deck{2}} = grep {$_} @{$deck{2}};
        }
        else {
            $winner = ($c1 > $c2) ? 1 : 2;
        }
        #say "Winner $winner";
        if ($winner == 1) {
            @result = ($c1,$c2);
        }
        else {
            @result = ($c2,$c1);
        }
        push($deck{$winner}->@*,@result);
    }

    $game--;
    return $deck{1}->@* ? 1 : 2;
}
