use v5.36;
use Data::Dumper; $Data::Dumper::Maxdepth=300;$Data::Dumper::Indent=0;$Data::Dumper::Varname='';

my %pairs;
{
    my $i = 1;
    for ( split/\n\n/, join('',<>)) {
        $pairs{$i++} = [map { eval } split(/\n/)];
    }
}

my %result;
my $sum;
for my $idx (sort { $a <=> $b } keys %pairs) {
    my ($left, $right) = $pairs{$idx}->@*;
    for (my $i=0;$i<=$left->@*;$i++) {
        my $l = $left->[$i];
        my $r = $right->[$i];
        my $res = compair($l, $r);
        next if $res == 0;
        $result{$idx} = $res;
        $sum+=$idx if $res == 1;
        last;
    }
}
say "SUM $sum";

sub compair($l, $r) {
    #say Data::Dumper::Dumper ['compair',$l,'vs', $r];

    return 0 if !defined $l && !defined $r;
    if (!defined $l) {
        return 1;
    } elsif (!defined $r) {
        return -1;
    }

    if (!ref($l) && !ref($r)) {
        if ($l == $r) {
            return 0;
        }
        elsif ($l < $r) {
            return 1;
        }
        else {
            return -1
        }
    }
    else {
        $l = [$l] unless ref($l);
        $r = [$r] unless ref($r);

        for (my $si = 0;$si<=$l->@*;$si++) {
            my $rv = compair($l->[$si], $r->[$si]);
            return $rv unless $rv == 0;
        }
    }
}

