use 5.030;
use strict;
use warnings;
use List::Compare;
my $hit;
my %direct=(
    2 => 1,
    3 => 7,
    4 => 4,
    7 => 8,
);

for (<>) {
    chomp;
    my ($first,$second)=split/ \| /;
    my @res;
    my @fives;
    my @sixes;
    for my $read (split/ /,$first) {
        my $l = length($read);
        if (my $num = $direct{$l}) {
            $res[$num] = [ split(//,$read) ];
        }
        elsif ($l == 5) {
            push(@fives, { map { $_ => 1 } split(//,$read) });
        }
        elsif ($l == 6) {
            push(@sixes, { map { $_ => 1 } split(//,$read) });
        }
        else { die "ARGH $l $read" }
    }
    while (@fives) {
        my $cand = shift(@fives);
        # if contains both of 1 its a 3
        if ($cand->{$res[1][0]} && $cand->{$res[1][1]}) {
            $res[3] = [ keys %$cand ];
        }
        else {
            my $lc5 = List::Compare->new([keys %$cand], $res[4]);
            my @intersection = $lc5->get_intersection;
            if (@intersection == 3) {
                $res[5] = [ keys %$cand ];
            }

            if (@fives == 1) {
                my $two = shift (@fives);
                $res[2] = [ keys %$two ];
            }
            else {
                push(@fives,$cand);
            }
        }
    }
    while (@sixes) {
        my $cand = shift(@sixes);
        my $lc6 = List::Compare->new([keys %$cand], $res[1]);
        my @intersection = $lc6->get_intersection;
        my $hit;
        if (@intersection == 1) {
            $res[6] = [ keys %$cand ];
            $hit=1;
        }
        else {
            my $lc9 = List::Compare->new([keys %$cand], $res[4]);
            my @intersection = $lc9->get_intersection;
            if (@intersection == 4) {
                $res[9] = [ keys %$cand ];
                $hit=1;
            }
        }
        if (@sixes == 1) {
            my $zero = shift (@sixes);
            $res[0] = [ keys %$zero ];
        }
        elsif (!$hit) {
            push(@sixes,$cand);
        }
    }



}
say $hit;
