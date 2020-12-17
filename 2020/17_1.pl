use 5.020;
use strict;
use warnings;
use Clone qw(clone);

my @map = map { chomp; [ split // ] } <>;
my $z   = 0;
my %map;

for (my $y=0;$y<@map;$y++) {
    my $row = $map[$y];
    for (my $x=0;$x<@$row;$x++) {
        $map{join(':',$z,$y,$x)} = $row->[$x];
    }
}

my @moves;
for my $mz ((-1,0,1)) {
    for my $my ((-1,0,1)) {
        for my $mx ((-1,0,1)) {
            push(@moves,[$mz,$my,$mx]) unless $mz == 0 && $my ==0 && $mx ==0;
        }
    }
}
my $active=0;
for (1..1) {
    my %new;
    $active=0;
    while (my ($pos,$val) = each %map) {
        my ($z,$y,$x) = split(/:/,$pos);
        my $count=0;
        for my $m (@moves) {
            my $look = join(':',$z+$m->[0],$y+$m->[1],$x+$m->[2]);
            my $check = $map{$look} || '.';
            $count++ if $check eq '#';
        }
        if ($val eq '#') {
            $new{$pos} = ($count == 2 || $count ==3) ? '#' : '.';
        }
        else {
            $new{$pos} = $count ==3 ? '#' : '.';
        }
        $active++ if $new{$pos} eq '#';
    }
    %map = %{clone(\%new)};
    use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%map;

}

say $active;
