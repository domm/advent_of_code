use 5.026;
use strict;
use warnings;
my @sky;
my $minx=0;
my $miny=0;
my $maxx;
my $maxy;
my @input;

while (<>) {
    my($y,$x,$my,$mx) = $_ =~ /position=<\s*([-\d]+),\s*([-\d]+)> velocity=<\s*([-\d]+),\s*([-\d]+)>/;
    $minx = $x if $x < $minx;
    $miny = $y if $y < $miny;
    $maxx = $x if $x > $maxx;
    $maxy = $y if $y > $maxy;
    push(@input,[$x,$y,$mx,$my]);
}
my $offset = 1+ (-1* ($minx < $miny ? $minx : $miny));
my $max = $offset + ($maxx > $maxy ? $maxx : $maxy);


foreach my $in (@input) {
    push($sky[$in->[0]+$offset][$in->[1]+$offset]->@*,[ $in->[2], $in->[3]]);
}

for (1..4) {
    show();
    tick();
    print `clear`;
    sleep(1);

}
sub tick {
    my @new;
    for my $i (1..$max) {
        for my $j (1..$max) {
            my $loc = $sky[$i][$j];
            next unless $loc;
            foreach my $p ($loc->@*) {
                push($new[$i + $p->[0]][$j + $p->[1]]->@*,$p);
            }
        }
    }
    @sky = @new;
}

sub show {
    for my $i (1..$max) {
        for my $j (1..$max) {
            my $p = $sky[$i][$j];
            if ($p) {
                print "#";
            }
            else {
                print ".";
            }
        }
        print "\n";
    }
}

