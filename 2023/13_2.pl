use 5.034;
use strict;
use warnings;

my $sum;
my $s=0;
SET: for my $set (split(/\n\n/, join('',<>))) {
    $s++;
    my $ignore = get_val($set,0);
    for my $pos (0 .. length($set)-1) {
        my $check = $set;
        my $smudge = substr($check, $pos, 1);
        next if $smudge eq "\n";
        substr($check, $pos, 1, $smudge eq '#' ? '.' : '#');
        my $val = get_val($check, $ignore);
        if ($val) {
            $sum+=$val;
            next SET;
        }
    }
}
say $sum;

sub get_val {
    my ($check, $ignore) = @_;
    my $val;
    my @rows;
    my @cols;
    for my $line (split/\n/,$check) {
        my @row = split(//,$line);
        push(@rows, $line);
        for (my $i=0;$i<@row;$i++) {
            $cols[$i].=$row[$i];
        }
    }

    my $r = 100 * find_mirror('r', $ignore / 100 ,@rows);
    my $c = find_mirror('c', $ignore , @cols);
    if ($ignore && $r && $c) {
        return $r == $ignore ? $c : $r;
    }
    else {
        return  $r || $c;
    }
}


sub find_mirror {
    my ($type, $ignore, @set) = @_;

    for (my $i=0;$i<@set;$i++) {
        my $this = $set[$i];
        my $next = $set[$i+1];
        if ($next && $this eq $next) {
            #say "$type same at $i-".($i+1)."   $this = $next";
            my $j = $i;
            my $ok = 1;
            LOOK: for (my $j=1;$j<=$i;$j++) {
                if ($i - $j < 0 || !$set[$i + 1 + $j ]) {
                    # reached end
                    #say "end";
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
                if ($i +1 == $ignore) {
                    #say "ignore!";
                    $ok = 1;
                }
                else {
                    #say "$type LINE AFTER $i";
                    return $i+ 1;
                }
            }
        }
    }
}

