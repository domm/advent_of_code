use 5.034;
use strict;
use warnings;

my $in = <>;
chomp($in);
my %boxes = map { $_ => [] } 0 .. 255;
for (split(/,/,$in)) {
    /^([a-z]+)(=|-)(\d*)$/;
    my $label = $1;
    my $op = $2;
    my $val = $3;

    my $box_id = hash($label);
    my $box = $boxes{$box_id};

    if ($op eq '=') {
        my $replaced=0;
        for my $len (@$box) {
            if ($len->{label} eq $label) {
                $len->{focal} = $val;
                $replaced = 1;
                last;
            }
        }
        unless ($replaced) {
            push(@$box,{ label=>$label, focal=>$val });
        }
    }
    else {
        my @new = grep { $_->{label} ne $label } @$box;
        $boxes{$box_id} = \@new;
    }
}

my $power = 0;
for my $bi (keys %boxes) {
    my $box = $boxes{$bi};
    for (my $i=0;$i<@$box;$i++) {
        $power += ($bi+1) * ($i +1 ) * $box->[$i]{focal};
    }
}
say $power;

sub hash {
    my $string = shift;
    my $v = 0;
    for my $c (split(//,$string)) {
        $v += ord($c);
        $v *= 17;
        $v = $v % 256;
    }
    return $v;
}

