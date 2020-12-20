use 5.020;
use strict;
use warnings;

my %tiles;
my %matches;
for(split(/\n\n/,join('',<>))) {
    my @raw = split(/\n/);
    my $name = shift(@raw);
    my ($id)= $name =~ /(\d+)/;
    say $id;

    my @tile;
    for(@raw) {
        chomp;
        push(@tile,[split//]);
    }

    my $top = checksum($tile[0]);
    my $bottom = checksum($tile[9]);
    my $left = checksum([ map { $tile[$_][0] } 0..9 ]);
    my $right = checksum([ map { $tile[$_][9] } 0..9 ]);

    $matches{$top}++;
    $matches{$bottom}++;
    $matches{$left}++;
    $matches{$right}++;

    $tiles{$id}=[$top, $bottom, $left, $right];
}

my %edges = map { $_=>1} grep { $matches{$_} == 1 } keys %matches;

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%edges;

my @corners;
while (my ($id,$borders) = each %tiles) {
    say $id;
    my @foo = grep { $edges{$_}} @$borders;
    say scalar @foo;
}

sub checksum {
    my $border = shift;
    my $row = join('',map { /#/ ? 1 : 0 } $border->@*);
    return eval '0b'.$row;
}

