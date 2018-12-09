use 5.020;
use strict;
use warnings;
use List::Util qw(max);

my ($players, $last ) = @ARGV;
my %score  = map { $_ => 0 } 0 .. $players - 1;

my $head = {
    marble=>0,
};
$head->{prev} = $head->{next} = $head;

for my $marble (1 .. $last) {
    if ($marble % 23 == 0) {
        my $player = $marble % $players;
        $score{$player} += $marble;

        my $pick = rotate($head, -7);
        $score{$player} += $pick->{marble};

        my $prev = $pick->{prev};
        my $next = $pick->{next};
        $next->{prev} = $prev;
        $head = $prev->{next} = $next;
    }
    else {
        my $next = rotate($head, 2);
        my $item = {
            marble=>$marble,
            next=> $next,
            prev=>$next->{prev}
        };
        $item->{prev}{next} = $item;
        $item->{next}{prev} = $item;
        $head = $item;
    }
}

say "highscore: ". max values %score;

sub rotate {
    my ($h, $count) = @_;
    my $node = $count < 0 ? 'prev' : 'next';
    for (1 .. abs($count)) {
        $h = $h->{$node};
    }
    return $h;
}

sub dump {
    my $dump = $head;
    my $start = $head->{marble};
    while (1) {
        print $dump->{marble} . ' ';
        $dump = $dump->{next};
        last if $dump->{marble} eq $start;
    }
    print "\n";
}
