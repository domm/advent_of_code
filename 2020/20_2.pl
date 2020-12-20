use 5.020;
use strict;
use warnings;

use Math::Matrix;

my %tiles;
my %by_edge;
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
    for my $dir (0..3) {
        calc($id,$dir,\@tile);

        my $m = Math::Matrix->new(@tile);

        my $ud = $m->flipud;
        calc($id,$dir.'_ud',$ud);

        my $lr = $m->fliplr;
        calc($id,$dir.'_lr',$lr);

        my $n = $m->rot90();
        @tile = @$n;
    }
}

my %edges = map { $_=>1} grep { $matches{$_} == 3 } keys %matches;
my @corners;
my $prod=1;
while (my ($id,$data) = each %tiles) {
    my $count =0 ;
    my %seen;
    my $dir;
    foreach my $b (@$data) {
        next unless $matches{$b->{check}};
        next if $seen{$b->{check}}++;
        if ($matches{$b->{check}} == 3) {
            $count++;
        }
    }
    if ($count == 2) {
        $prod*=$id;
        push(@corners,$id);
    }
}
say $prod;

for my $start ($corners[0]) {
    say "\n\nST $start";
    for my $cand ($tiles{$start}->@*) {
        next unless $matches{$cand->{check}};
        next if $matches{$cand->{check}} == 3;
        my $got = $by_edge{$cand->{check}};
        next unless $got;
        next if scalar keys %$got == 1;
        say "GOT ";
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $got;
    }
}

# orient it correctly, put it in the top-left, then find additional tiles with a matching edge, orient it correctly to put unique edges at top, finish the top row, then find a matching tile for the second row, orient it correctly with the unique edge at the left, then finish the row by picking the one matching tile and orienting it to also match with the tile above it.


sub calc {
    my ($id,$dir,$tile) = @_;
    my $checksum = checksum($tile);
    my $checksum2 = checksum2($tile);
    my @inner;
    for my $r (1..8) {
        for my $c (1..8) {
            $inner[$r-1]->[$c-1]=$tile->[$r][$c];
        }
    }
    push($tiles{$id}->@*,{
        check=>$checksum,
        dir=>$dir,
        tile=>\@inner,
    });
    $by_edge{$checksum}->{$id}=$dir;

    $matches{$checksum < $checksum2 ? $checksum : $checksum2}++;
}

sub checksum {
    my $tile = shift;
    my $row = join('',map { /#/ ? 1 : 0 } $tile->[0]->@*);
    return eval '0b'.$row;
}

sub checksum2 {
    my $tile = shift;
    my $row = join('',map { /#/ ? 1 : 0 } reverse $tile->[0]->@*);
    return eval '0b'.$row;
}

