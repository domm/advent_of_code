use 5.030;
use strict;
use warnings;
use List::Util qw(sum);

my ($wf,$r) = split(/\n\n/,join('',<>));

my %workflows;
for my $l (split(/\n/,$wf)) {
    my ($name, $rules) = $l =~/^([a-z]+)\{(.*)\}/;
    my @rules;
    for my $def (split (/,/,$rules)) {
        if ($def =~ /^[a-zAR]+$/) {
            push(@rules, { op=>'fallback', next=>$def });
        }
        else {
            my ($attr,$op,$val,$next) = $def=~/^([xmas])([<>])(\d+):([a-zAR]+)$/;
            push(@rules, {
                attr=>$attr,
                op=>$op,
                val=>$val,
                next=>$next,
                code=>'$part'."->{$attr} $op $val",
            });
        }
    }
    $workflows{$name} = \@rules;
}

my $sum;
for my $p (split(/\n/, $r)) {
    $p=~s/=/=>/g;
    my $part = eval $p;

    my $res = 'in';
    my $s=0;
    while ($res ne 'A' && $res ne 'R') {
        $res = process($res,$part);
    }
    if ($res eq 'A') {
        $sum += sum(values %$part);
    }
    print "\n";
}
say $sum;

sub process {
    my ($wf, $part) = @_;
    for my $r ($workflows{$wf}->@*) {
        return $r->{next} unless $r->{code};
        my $c = $r->{code};
        if (eval $c) {
            return $r->{next};
        }
    }
}

