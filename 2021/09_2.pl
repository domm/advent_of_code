use 5.030;
use strict;
use warnings;

my @map;
my ($r)=0;
for (<>) {
    chomp;
    my $c=0;
    for (split(//)) {
        $map[$r]->[$c++] = $_;
    }
    $r++;
}

my ($risk,$sum)=(0,0);
my %hits;
for (my $r=0;$r<@map;$r++) {
    for (my $c=0;$c<$map[$r]->@*;$c++) {
        my $heat = $map[$r]->[$c];
        my $lower=0;
        for my $move ([-1,0],[1,0],[0,-1],[0,1]) {
            my $r2 = $r + $move->[0];
            my $c2 = $c + $move->[1];
            my $val = $map[$r2]->[$c2];
            if ($r2<0 || $c2<0) {
                $lower++;
            }
            elsif (not defined $val) {
                $lower++;
            }
            elsif ($heat < $val) {
                $lower++;
            }
        }
        if ($lower == 4) {
            $hits{$r.':'.$c} = $heat;
            $sum += $heat +1;
        }
    }
}

say $sum;

__END__
foreach my $sink (keys %hits) {
    my $size;
    my ($r,$c)=split(/:/,$sink);

    walk($r, $c);

}

sub walk {
    my ($r, $c,  ) = @_;
    for my $move ([-1,0],[1,0],[0,-1],[0,1]) {
        my $val = $map[$r + $move->[0]]->[$c + $move->[1]];
        say ($r + $move->[0])." ".($c + $move->[1]).": $val";

        

    }
    


}


use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%hits;


