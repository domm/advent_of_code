use strict;
use warnings;
use 5.030;

my $count;
my %gq;
while (<>) {
    chomp();
    my @q = split //;
    if (@q == 0) {
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%gq;
        say scalar keys %gq;
        $count += scalar keys %gq;
        %gq=();
    }
    for (@q) {
        $gq{$_}++;
    }
}
$count += scalar keys %gq;

say $count;
