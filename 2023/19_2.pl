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
            push(@rules, { op=>'fallback', child=>$def, name =>$name  });
        }
        else {
            my ($attr,$op,$val,$next) = $def=~/^([xmas])([<>])(\d+):([a-zAR]+)$/;
            push(@rules, {
                attr=>$attr,
                op=>$op,
                val=>$val,
                child=>$next,
                name=>$name,
                code=>'$part'."->{$attr} $op $val",
            });
        }
    }
    $workflows{$name} = \@rules;
}

my %start=(
    xf=>0,
    xt=>4000,
    mf=>0,
    mt=>4000,
    af=>0,
    at=>4000,
    sf=>0,
    st=>4000,
);


my $sum;
doit('in',\%start,'in');
say $sum;

sub doit {
    my ($name, $ranges, $level) = @_;

    #say "$level $name";
    if ($name eq 'A') {
        say $level;
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $ranges;
        my $prod=1;
        for my $a (qw(x m a s)) {
            my $diff = $ranges->{$a.'t'} - $ranges->{$a.'f'};
            $prod*=$diff;
            #say $prod;
            $sum+=$prod;
        }
        return;
    }

    my $rules = $workflows{$name};
    if ($rules) {
        for (my $i=0;$i<@$rules;$i++) {
            my $r = $rules->[$i];

            next if $r->{op} eq 'fallback';
            my $op = $r->{op};
            my $attr = $r->{attr};
            my $val = $r->{val};

            my $match = { $ranges->%* };
            my $nomatch= { $ranges->%* };

            #say "$attr $op $val";

            if ($op eq '<' ) {
                $match->{$attr.'t'} = $val - 1;
                $nomatch->{$attr.'f'} = $val;
            }
            elsif ($op eq '>' ) {
                $match->{$attr.'f'} = $val +1;
                $nomatch->{$attr.'t'} = $val;
            }

            doit($r->{child},$match,$level.'=y->'.$r->{child});
            my $nomatch_rule = $rules->[$i+1];

            if ($nomatch_rule && $nomatch_rule->{child} ne 'R') {
                doit($nomatch_rule->{child},$nomatch,$level.'=n->'.$nomatch_rule->{child});
            }
        }
    }
}


# 167409079868000
# 356427798652792
# 7140781872294106
