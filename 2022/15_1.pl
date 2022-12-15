use v5.36;

my %map;
while (<>) {
    my ($sx, $sy, $bx, $by) = /=(-?\d+).*=(-?\d+).*=(-?\d+).*=(-?\d+)/;
    my $d = abs($sx - $bx) + abs($sy - $by);
    say "$sx $sy -> $bx $by = $d";
    $map{$sy}{$sx}='S';
    $map{$by}{$bx}='B';
    my @topleft=($sx-$d,$sy-$d);
    my @bottomright=($sx+$d, $sy+$d);
    #say "\t ".join(':',@topleft).' - '.join(':',@bottomright);
    for my $tx ($sx - $d .. $sx + $d) {
        for my $ty ($sy - $d .. $sy + $d) {
            #say "tr $tx:$ty";
            if (abs($sx - $tx) + abs($sy - $ty) <= $d) {
                $map{$ty}{$tx}||='#';
            }
        }

    }
}

say scalar grep { /#/ } values $map{10}->%*;


