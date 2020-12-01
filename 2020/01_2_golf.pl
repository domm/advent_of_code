my @d = ( <STDIN> );
for my $a (@d) { for my $b (@d) { for my $c (@d) { die "$a $b $c -> ".$a*$b*$c if $a + $b +$c == 2020 } } }
