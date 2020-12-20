use 5.020;
use strict;
use warnings;
use Math::Matrix;

my %tiles;
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


    for (0..3) {
        my $checksum = checksum(\@tile);
        my $m = Math::Matrix -> new(@tile);
        my $n = $m->rot90();
        push($tiles{$id}->@*,{
            check=>$checksum,
            tile=>$n,
        });
        @tile = @$n;
    }
    exit;
}


sub checksum {
    my $tile = shift;
    my $row = join('',map { /#/ ? 1 : 0 } $tile->[0]->@*);
    return eval '0b'.$row;
}


