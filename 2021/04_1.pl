use 5.030;
use strict;
use warnings;
use utf8;

my @numbers = split (/,/,<>);
my @boards;
my %drawn;

my ($b,$r)=0;
for (<>) {
    chomp;
    if ($_ !~/\d/) {
        $b++;
        $r=0;
        next;
    }
    s/^ //;
    my @num = split(/ +/,$_);
    for (my $c=0;$c<5;$c++) {
        my $val = $num[$c];
        $boards[$b]->[$r]->{$val} = $val;
        $boards[$b]->[$c+5]->{$val} = $val;
    }
    $r++;
}
my $nope = shift @boards;
use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@boards;


