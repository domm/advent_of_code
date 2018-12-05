use 5.010;
use Text::Levenshtein::XS qw(distance);
my @ids = <STDIN>;
foreach my $a (@ids) {
    chomp($a);
    for (my $i=0;$i<@ids;$i++) {
        my $b =  $ids[$i];
        chomp($b);
        if (distance($a,$b) == 1) {
            say $a;
            say $b;
            exit;
        }
    }
}
