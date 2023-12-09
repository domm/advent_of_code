use 5.034;
use strict;
use warnings;
use List::Util qw(all reduce);

my $sum;
for (<>) {
    my @readings = split(/\s/,$_);

    my $do = 1;
    my @firsts;
    while ($do) {
        push(@firsts,$readings[0]);
        my @next = calc(@readings);
        if (all { $_ == 0 } @next) {
            $do = 0;
        }
        else {
            @readings = @next;
        }
    }
    push(@firsts,0);
    while (@firsts > 1) {
        my ($a, $b) =  ( pop(@firsts), pop(@firsts) );
        my $next = $b - $a;
        push(@firsts, $next);

    }
    $sum+=$firsts[0];
}

say $sum;

sub calc {
    my @in = @_;
    my @out;
    for (my $i=0;$i<@in - 1;$i++) {
        my $diff = $in[$i + 1] - $in[$i];
        push(@out, $diff);
    }
    return @out;
}

