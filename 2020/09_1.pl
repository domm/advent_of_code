use strict;
use warnings;
use 5.030;


use List::Permutor;

my $preamble=shift;
say $preamble;
my @in=<>;
#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@in;

my $cnt=0;
while (1) {
    say $cnt++;
    if (check(@in)) {
        shift @in;
    }
    else {
        say "found ".$in[$preamble ];
        exit;
    }
}

sub check {
    my @data = @_;
    my @pre = splice(@data, 0, $preamble);
    my $perm = new List::Permutor @pre;
    while (my ($a, $b) = $perm->next) {
        my $sum = $a+$b;
            say "$a + $b = $sum";
        if ($data[0] == $sum) {
            say "$a + $b = $sum";
            return 1;
        }
    }
}

