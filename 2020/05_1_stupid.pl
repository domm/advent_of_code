use strict;
use warnings;
use 5.030;

my $max=0;

while (<STDIN>) {
    chomp();
    my @s = split //;
    my @r = splice(@s,0,7);

    my @row = (0 .. 127);
    for (my $i=0;$i<=6;$i++) {
        my $range = int(@row/2);
        #say $range;
        if ($r[$i] eq 'F') {
            @row = splice(@row,0,$range);
        }
        else {
            @row = splice(@row,$range, $range);
        }
    }
    my $row = $row[0];

    my @seats = (0 .. 7);
    for (my $i=0;$i<=2;$i++) {
        my $range = int(@seats/2);
        say $range;
        if ($s[$i] eq 'L') {
            @seats = splice(@seats,0,$range);
        }
        else {
            @seats = splice(@seats,$range, $range);
        }

    }
    my $seat = $seats[0];
    my $id = $row * 8 + $seat;

    say "$row / $seat -> $id";

    $max=$id if $id > $max;
}

say "MAX $max";

__END__
        # say "$lr, $tr, ".$r[$i].", $range";
        if ($range == 1) {
            $row = $r[$i] eq 'F' ? $lr : $tr;
        }
        if ($r[$i] eq 'F') {
            $lr = $lr;
            $tr = $lr + $range;
        }
        else {
            $lr += $range;
            $tr = $tr;
        }
        #say " -> $lr, $tr";
    }

     say "$row";

    my $ls=0;my $ts=7;my $seat;
    for (my $i=0;$i<=2;$i++) {
        my $range = int(($ts - $ls) / 2);
         say "$ls, $ts, ".$s[$i].", $range";
        if ($range == 1) {
            $seat = $s[$i] eq 'L' ? $ls : $ts;
        }
        if ($s[$i] eq 'L') {
            $ls = $ls;
            $ts = $ls + $range;
        }
        else {
            $ls += $range;
            $ts = $ts;
        }
        say " -> $ls, $ts";
    }
    say "$seat";

say $id;

    say "\n";
    exit;
}

sub find_row {
    my ($r, $lo, $up) = @_;
    if ($r eq 'F') {
        $lo = $lo;
        $up = int($up/2);
    }
    else {
        $lo = $lo + int($up/2);
        $up = $up + int($up/2);
    }
    return ($lo,$up)
}

__END__
my $in = join('',<STDIN>);
$in =~ s/\n\n/SEP/gm;
$in =~ s/\s/;/g;
my @d = split(/SEP/,$in);

my $valid;
for my $l (@d) {
    my %p = map { split /:/ } split( /;/, $l);
    $valid++ if (keys %p == 8 || (keys %p == 7 && !$p{cid}));
}
say $valid;
