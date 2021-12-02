my @f = <STDIN>;
while (1) { foreach (@f) { $a+=$_; if ($s{$a}++) {print "$a\n";exit; } } }
