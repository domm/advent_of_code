use 5.010;
my $twice, $trice;
foreach (<STDIN>) {
    my %c;
    map { $c{$_} ++ } split(//,$_);
    foreach my $h (values %c) {
        if ($h == 2) {
            $twice++;
            last;
        }
    }
    foreach my $h (values %c) {
        if ($h == 3) {
            $trice++;
            last;
        }
    }
}
say $twice;
say $trice;
say $twice * $trice;
