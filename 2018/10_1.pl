use 5.026;
use strict;
use warnings;
my @sky;
use List::Util qw/max min/;

while (<>) {
    my($y,$x,$vx,$vy) = $_ =~ /position=<\s*([-\d]+),\s*([-\d]+)> velocity=<\s*([-\d]+),\s*([-\d]+)>/;
    push(@sky,[$x,$y,$vy,$vx]);
}

my $sx = 10000000;
my $sy = 10000000;
my $smallest = 100000000;
while (1) {
    show();
    move();
}

my $count=0;
sub move {
    foreach (@sky) {
        $_->[0]+=$_->[2];
        $_->[1]+=$_->[3];
    }
    $count++;
}

sub show {
    my @map;
    my (@x, @y);
    my %positions = ();
    foreach (@sky) {
        push(@x,$_->[0]);
        push(@y,$_->[1]);
        $positions{$_->[0] . " " . $_->[1]} = 1;
    }

    my $minx = min(@x);
    my $maxx = max(@x);
    my $miny = min(@y);
    my $maxy = max(@y);
    my $size = $maxx - $minx;
    if ($size < $smallest) {
        $smallest = $size;
    }

    if ($size < 10) {
        for my $x ($minx .. $maxx) {
            for my $y  ($miny .. $maxy) {
                print $positions{$x . " " . $y} ? '#' : ' ';
            }
            print "\n";
        }
        say $count;
       exit; 
    }

    #say "$minx $maxx - $miny $maxy";

    #    for my $x ($minx..$maxx) {
    #    for my $y ($miny..$maxy) {
    #        print $positions{$x . " " . $y} ? '#' : '.';
    #    }
    #    say "";

    #}

}

sub draw {
    
}

