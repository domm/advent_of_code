use 5.030;
use strict;
use warnings;

my @machine = map { chomp; [split(//)]  } <>;
my $rows = @machine;
my $cols = scalar $machine[0]->@*;

my $sum;
for (my $r=0;$r<$rows;$r++) {
    for (my $c=0;$c<$cols;$c++) {
        my $v = $machine[$r][$c];
        if ($v =~ /\d/) {
            my $num = $v;
            my $max_peek=0;
            FINDNUM: for my $peek (1,2) {
                my $look = $machine[$r][$c+$peek];
                if (defined $look && $look =~ /\d/) {
                    $num.=$look;
                    $max_peek=$peek;
                }
                else {
                    last FINDNUM;
                }
            }
            for my $lr (-1,0,1) {
                for my $lc  (-1 .. $max_peek+1) {
                    if ($machine[$r+$lr][$c+ $lc] && $machine[$r+$lr][$c+ $lc] =~ /[^\.\d]/) {
                        $sum+=$num;
                    }
                }
            }
            $c+=$max_peek;
        }
    }
}
say $sum;
