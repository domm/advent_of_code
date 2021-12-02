use strict;
use warnings;
use 5.026;

my $target = shift(@ARGV);
chomp($target);

my @r = qw(3 7);
my @elfs = qw(0 1);
my $find_l = -1 * (length($target) + 2);
my ($last) = $target =~/(\d)$/;

while (1) {
    my $sum = 0;
    foreach my $elf (@elfs) {
        my $r = $r[$elf % @r];
        $sum+=$r;
    }
    my @dig = split(//,$sum);
    push(@r,@dig);
    for (my $i=0;$i<@elfs;$i++) {
        $elfs[$i] = ( $elfs[$i] + $r[$elfs[$i]] + 1) % @r;
    }

    if ($dig[-1] == $last) {
        my $str = join('',@r[$find_l .. -1]);
        if ($str =~ /$target/) {
            say scalar @r + $find_l + 1;
            exit;
        }
    }
}
