use 5.020;
my @exp = ( <STDIN> );
while (my $a = shift (@exp)) {
    for my $b (@exp) {
        for my $c (@exp) {
            if ($a + $b +$c == 2020) {
                say "$a $b $c -> ".$a*$b*$c;
                exit;
            }
        }
    }
}
