use 5.010;
use strict;
use warnings;
my @c;
my %no;
foreach (<STDIN>) {
    my ($id,$x,$y,$w,$h) =$_ =~ /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/;
    $no{$id}=1;
    for my $row ($x+1 .. $x+$w) {
        for my $col ($y+1 .. $y+$h) {
            push(@{$c[$row]->[$col]}, $id);
        }
    }
}

foreach my $row (@c) {
    foreach my $col (@$row) {
        if ($col && @$col > 1) {
            foreach my $id (@$col) {
                delete $no{$id};
            }
        }
    }
}

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%no;

