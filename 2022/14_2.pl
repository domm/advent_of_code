use v5.36;

my $map={};
my $max_r = 0;
for (<>) {
    chomp;
    my @lines;
    for (split (/ -> /)) {
        my ($col, $row) = split(/,/);
        push(@lines, [$row, $col]);
        $max_r = $row if $row > $max_r;
    }
    for (my $i = 0;$i<$#lines;$i++) {
        my $start = $lines[$i];
        my $end = $lines[$i + 1];
        if ($start->[0] eq $end->[0]) {
            my ($from, $to) = sort { $a <=> $b} ($start->[1] ,$end->[1]);
            for my $col ($from .. $to) {
                $map->{$start->[0]}{$col}='#';
            }
        }
        else {
            my ($from, $to) = sort { $a <=> $b} ($start->[0] ,$end->[0]);
            for my $row ($from .. $to) {
                $map->{$row}{$start->[1]}='#';
            }
        }
    }
}
$max_r+=2; # add a floor
for (-1000 .. 1000) {
    $map->{$max_r}{$_} = '#';
}

my $sand_at_rest = 0;
ALL: while (1) {
    my $r =0; my $c = 500;
    ROW: while ($r <= $max_r) {
        if (!$map->{$r}{$c}) { # trickle down
            $r++;
            next ROW;
        }
        for my $dc (0,-1,1) { # spread out
            my $lc = $c + $dc;
            if (!$map->{$r}{$lc}) {
                $r++;
                $c = $lc;
                next ROW;
            }
        }
        $map->{$r-1}{$c} = '.';
        $sand_at_rest++;
        if ($r==1 && $c==500) { # filled up to sand source
            say $sand_at_rest;
            exit;
        }
        last ROW;
    }
}
