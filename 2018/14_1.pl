use strict;
use warnings;
use 5.026;

my $target = shift(@ARGV);

my @r = qw(3 7);
my @elfs = qw(0 1);
my $num_rec_after_target = 10;

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
    if (@r >= $target + $num_rec_after_target) {
        say "stop";
        say join('',splice(@r,$target,$num_rec_after_target));
        exit;
    }
}



