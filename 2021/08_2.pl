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

my $sum;
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
    for my $cand (@sixes) {
        my $lc6 = List::Compare->new([keys %$cand], $res[1]);
        my @intersection = $lc6->get_intersection;
        if (@intersection == 1) {
            $res[6] = [ keys %$cand ];
        }
        else {
            my $lc9 = List::Compare->new([keys %$cand], $res[4]);
            my $lc0 = List::Compare->new([keys %$cand], $res[4]);
            my @intersection_9_4 = $lc9->get_intersection;
            my @intersection_0_4 = $lc0->get_intersection;
            if (@intersection_9_4 == 4) {
                $res[9] = [ keys %$cand ];
            }
            elsif (@intersection_0_4 == 3) {
                $res[0] = [ keys %$cand ];
            }
        }
    }

    my %decode;
    for (my $i = 0; $i<@res;$i++) {
        $decode{join('',sort $res[$i]->@*)} = $i;
    }

    my $output;
    for my $read (split/ /,$second) {
        my $lookup = join('',sort split(//,$read));
        #say "$lookup ". $decode{$lookup};
        $output.=$decode{$lookup};
    }
    say $output;
    $sum+=$output;
}
say $sum;
