use 5.010;
my @c;
my $hit=0;
foreach (<STDIN>) {
    my ($x,$y,$w,$h) =$_ =~ /(\d+),(\d+): (\d+)x(\d+)/;
    for my $row ($x+1 .. $x+$w) {
        for my $col ($y+1 .. $y+$h) {
            #say "$row $col";
            $c[$row]->[$col]++;
            #   say $c[$row]->[$col];
            if ($c[$row]->[$col] == 2) {
                #    say "HIT";
                $hit++;
            }
        }
    }
}

say $hit;
