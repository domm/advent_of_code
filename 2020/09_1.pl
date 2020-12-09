use strict;
use warnings;
use 5.030;

my $preamble=shift;
say $preamble;
my @in=map {chomp;$_} <>;
#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@in;

my $cnt=0;
while (1) {
    say "rount ".$cnt++;
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
    my %pre = map {$_,1} splice(@data, 0, $preamble);

    my $target = $data[0];
    for my $a (keys %pre) {
        if ($pre{$target - $a}) {
            return 1;
        }
    }
    return 0
}

