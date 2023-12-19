use 5.030;
use strict;
use warnings;

# math!! https://arachnoid.com/area_irregular_polygon/index.html


my $r = 0;
my $c = 0;
my %move = (
    R => [0, 1],
    L => [0, -1],
    U => [-1, 0],
    D => [1, 0],
);
my @bounds=(0,0,0,0);
my @int2step=qw(R D L U);

my %map = (
    "$r:$c" => {t=>'trench',s=>1,h=>'',d=>'U'},
);
for my $line (<>) {
    my ($nope, $not, $hex) = split(/ /,$line);
    say $hex;
    $hex=~/([a-f\d]{5})(\d)/;
    my $steps = hex($1);
    my $dir = $int2step[$2];

    my $m = $move{$dir};

    if ($dir eq 'D' || $dir eq 'U') { # correct bends for inside check
        $map{"$r:$c"}->{d} = $dir;
    }

    for (1 .. $steps ) {
        $r += $m->[0];
        $c += $m->[1];
        $map{"$r:$c"} = {t=>'trench',s=>1,h=>$hex,d=>$dir,p=>'#'};
        $bounds[0] = $r if $r < $bounds[0];
        $bounds[1] = $r if $r > $bounds[1];
        $bounds[2] = $c if $c < $bounds[2];
        $bounds[3] = $c if $c > $bounds[3];
    }
}

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@bounds;

# fill
my $inside = 0;
my $lava = 0;
for my $r ($bounds[0] .. $bounds[1]) {
    for my $c ($bounds[2] .. $bounds[3]) {
        my $f = $map{"$r:$c"};
        $lava++ if $f;
        if ($f) {
            if ($f->{d} eq 'U') {
                $inside = 1;
            }
            elsif ($f->{d} eq 'D') {
                $inside = 0;
            }
        }
        elsif (!$f) {
            if ($inside) {
                $map{"$r:$c"} = {t=>'fill',s=>1,p=>'O'};
                $lava++;
            }
        }
    }
}
say $lava;


#draw();

sub draw {
    for my $r ($bounds[0] .. $bounds[1]) {
        for my $c ($bounds[2] .. $bounds[3]) {
            print $map{"$r:$c"}->{d} || $map{"$r:$c"}->{p} || ' ';
        }
        print "\n";
    }

}

