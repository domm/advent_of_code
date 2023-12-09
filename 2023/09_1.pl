use 5.034;
use strict;
use warnings;
use List::Util qw(all reduce);

my $sum;
for (<>) {
    my @readings = split(/\s/,$_);

    my $do = 1;
    my @lasts;
    while ($do) {
        push(@lasts,$readings[-1]);
        my @next = calc(@readings);
        if (all { $_ == 0 } @next) {
            $do = 0;
        }
        else {
            @readings = @next;
        }
    }
    while (@lasts > 1) {
        my $next = pop(@lasts) + pop(@lasts);
        push(@lasts, $next);

    }
    $sum+=$lasts[0];
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

