use 5.020;
my @exp = ( <STDIN> );
while (my $a = shift (@exp)) {
    for my $b (@exp) {
        if ($a + $b == 2020) {
            say "$a $b ".$a*$b;
        }
    }
}



