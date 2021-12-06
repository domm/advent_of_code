use 5.030;
use strict;
use warnings;

my %fish;
for (split(',',<>) ) {
    $fish{int $_} ++;
}

for (1..256) {
    my %next;
    my $total=0;
    for my $fish ( sort keys %fish) {
        my $count = $fish{$fish};
        if ($fish == 0) {
            $next{6}=$count;
            $next{8}=$count;
            $total += $count;
        }
        else {
            $fish{$fish-1}=$count;
            $fish{$fish}=0;
        }
        $total += $count;
    }
    $fish{6}+=$next{6};
    $fish{8}+=$next{8};
    say "day $_: $total";
}

