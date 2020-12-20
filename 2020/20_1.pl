use 5.020;
use strict;
use warnings;

my %tiles;
my %matches;
for(split(/\n\n/,join('',<>))) {
    my @raw = split(/\n/);
    my $name = shift(@raw);
    my ($id)= $name =~ /(\d+)/;

    my @tile;
    for(@raw) {
        chomp;
        push(@tile,[split//]);
    }

    my @sides;
    foreach ($tile[0], $tile[9], [ map { $tile[$_][0] } 0..9 ], [ map { $tile[$_][9] } 0..9 ]) {
        my $side = join ('',$_->@*);
        my $flip = join ('',reverse $_->@*);
        my @sorted = sort ($side, $flip);
        my $choose = $sorted[0];
        push(@sides,$choose);
        $matches{$choose}++;
    }
    $tiles{$id} = \@sides;
}


my %edges = map { $_=>1} grep { $matches{$_} == 1 } keys %matches;
use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%edges;
my $prod=1;
while (my ($id,$borders) = each %tiles) {
    use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $borders;

    my @foo = grep { $edges{$_}} @$borders;
    $prod *= $id if (@foo == 2);
}
say $prod;
