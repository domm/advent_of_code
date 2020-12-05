use strict;
use warnings;
use 5.030;

my $max=0;

while (<STDIN>) {
    chomp();
    my @s = split //;
    my @r = splice(@s,0,7);

    my $lr=1;my $tr=128;my $row;
    for (my $i=0;$i<=6;$i++) {
        my $range = int(($tr - $lr) / 2);
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

     say "$row \n\n";
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
