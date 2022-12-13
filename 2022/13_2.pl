use v5.36;
use Data::Dumper; $Data::Dumper::Maxdepth=300;$Data::Dumper::Indent=0;$Data::Dumper::Varname='';

my @data=([[2]], [[6]]);
for ( split/\n\n/, join('',<>)) {
    push(@data,map { eval } split(/\n/));
};

my @sorted = map { Data::Dumper::Dumper $_ } sort sort_package @data;

my $key = 1;
for (my $i=0;$i<@sorted;$i++) {
    my $p = $sorted[$i];
    if ($p eq '$1 = [[2]];' || $p eq '$1 = [[6]];') {
        $key *= ($i+1);
    }
}
say $key;

sub sort_package {
    my ($left, $right) = ($a, $b);
    my $res;
    for (my $i=0;$i<=$left->@*;$i++) {
        my $l = $left->[$i];
        my $r = $right->[$i];
        $res = compair($l, $r);
        next if $res == 0;
        last;
    }
    return -1 * $res;
}

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

