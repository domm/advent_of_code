use 5.026;
use strict;
use warnings;
my @sky;
my $smallest = 1000000;
my $prev=$smallest + 1;
my $count=0;

while (<>) {
    my($y,$x,$vx,$vy) = $_ =~ /position=<\s*([-\d]+),\s*([-\d]+)> velocity=<\s*([-\d]+),\s*([-\d]+)>/;
    push(@sky,[$x,$y,$vy,$vx]);
}

while (1) {
    my @map;
    my ($max, $min)=(0,0);
    foreach (@sky) {
        # move
        $_->[0]+=$_->[2];
        $_->[1]+=$_->[3];

        # get min/max x so we can calc vertical size
        $max = $_->[0] if $_->[0] > $max;
        $min = $_->[0] if $_->[0] < $min;
    }

    # calc vertical size
    my $size = $max - $min;
    if ($size < $smallest) {
        $smallest = $prev = $size;
    }

    if ($size > $prev) { # found it!
        my @word;
        my @box=(1000,0,1000,0);
        foreach (@sky) {
            # travel back in time!
            $_->[0]-=$_->[2];
            $_->[1]-=$_->[3];

            # draw the point
            $word[$_->[0]][$_->[1]]="#";

            # figure out the exact bounding box
            $box[0] = $_->[0] if $_->[0] < $box[0];
            $box[1] = $_->[0] if $_->[0] > $box[1];
            $box[2] = $_->[1] if $_->[1] < $box[2];
            $box[3] = $_->[1] if $_->[1] > $box[3];
        }
        foreach my $x ($box[0] .. $box[1]) {
            foreach my $y ($box[2] .. $box[3]) {
                print $word[$x][$y] || ' ';
            }
            print "\n";
        }
        say "waiting for $count seconds";
        exit;
    }
    $count++;
}
