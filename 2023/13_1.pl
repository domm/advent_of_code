use 5.034;
use strict;
use warnings;

my $sum;
for my $set (split(/\n\n/, join('',<>))) {
    my @rows;
    my @cols;
    for my $line (split/\n/,$set) {
        #chomp($line);
        my @row = split(//,$line);
        push(@rows, $line);
        for (my $i=0;$i<@row;$i++) {
            $cols[$i].=$row[$i];
        }
    }

    $sum += 100 * find_mirror('r',@rows);
    $sum += find_mirror('c',@cols);
}
say $sum;

sub find_mirror {
    my ($type, @set) = @_;

    for (my $i=0;$i<@set;$i++) {
        my $this = $set[$i];
        my $next = $set[$i+1];
        if ($next && $this eq $next) {
            # say "$type same at $i-".($i+1)."   $this = $next";
            my $j = $i;
            my $ok = 1;
            LOOK: for (my $j=1;$j<=$i;$j++) {
                if ($i - $j < 0 || !$set[$i + 1 + $j ]) {
                    # reached end
                    last LOOK;
                }
                my $left = $set[$i - $j];
                my $right = $set[$i + 1 + $j ];
                #say "  check $left vs $right";
                if ($left ne $right) {
                    $ok = 0;
                    last LOOK;
                }
            }
            if ($ok) {
                # say "$type LINE AFTER $i";
                return $i+1;
            }
        }
    }
}

