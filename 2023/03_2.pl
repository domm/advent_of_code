use 5.030;
use strict;
use warnings;

my @machine = map { chomp; [split(//)]  } <>;
my $rows = @machine;
my $cols = scalar $machine[0]->@*;
my @parts;

for (my $r=0;$r<$rows;$r++) {
    for (my $c=0;$c<$cols;$c++) {
        my $v = $machine[$r][$c];
        if ($v =~ /\d/) {
            my $num = $v;
            my $maxo=0;
            FINDNUM: for my $o (1,2) {
                my $look = $machine[$r][$c+$o];
                if ($look =~ /\d/) {
                    $num.=$look;
                    $maxo=$o;
                }
                else {
                    last FINDNUM;
                }
            }
            for my $o (0 .. $maxo) {
                $machine[$r][$c+$o] = $num;
            }
            $c+=$maxo;
        }
        elsif ($v eq '*') {
            push(@parts, [$r, $c]);
        }
    }
}

my $sum;
for my $p (@parts) {
    say "check ".join(':',@$p);
    my @found;
    for my $c (-1,0,1) {
        my %seen;
        for my $r (-1,0,1) {
            my $v = $machine[$p->[0]+$c][$p->[1]+$r];
            if ($v =~ /\d/ && !$seen{$v}++) {
                say "$v at ".join(':',$p->[0]+$c, $p->[1]+$r);
                push(@found,$v);
            }
            elsif ($v eq '.') {
                say "reset seen";
                %seen = ();
            }
        }
    }
    if (@found == 2) {
        $sum+=$found[0]*$found[1];
    }
}
say $sum;
