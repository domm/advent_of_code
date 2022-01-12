use 5.030;
use strict;
use warnings;
use Data::Dumper;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my $add = <>;
chomp($add);
while (<>) {
    chomp;
    $add = '['.$add.','.$_.']';
    say $add;

    while (1) {
        say "START $add";
        my $ex = my $sp = 0;
        ($ex, $add) = explode($add);
        say "ex $ex, $add";
        unless ($ex) {
            ($sp, $add) = splt($add);
            say "spl $sp, $add";
        }
        last if !$ex && !$sp;
    }
    say "RESULT $add";

}
say $add;

sub explode($in) {
    my @stack = split(//,$in);
    my @done;
    my $l=0;
    while (@stack) {
        my $v = shift(@stack);
        if ($v =~ /\d/ && $stack[0] =~ /\d/) { # double digit
            $v.=shift(@stack);
        }
        $l++ if $v eq '[';
        $l-- if $v eq ']';
        if ($l eq 5) {
            #say join('',@done);
            #say $v;
            #say join('',@stack);
            my $take;
            while (1) {
                my $char = shift(@stack);
                last if $char eq ']';
                $take.=$char;
            }
            my ($l,$r)=split(/,/,$take);
            #say "$l - $r";
            for (my $j=0;$j<@stack;$j++) {
                if ($stack[$j] =~ /^\d$/) {
                    my $vr = $stack[$j];
                    if ( $stack[$j+1] =~ /\d/) { # OMG
                        $vr.=$stack[$j+1];
                        splice(@stack, $j+1,1);
                    }
                    my $new = $vr + $r;
                    $stack[$j]= $vr + $r;
                    $r=-1;
                    last;
                }
            }
            unshift(@stack,0) unless $r == -1;

            for (my $j=$#done;$j>=0;$j--) {
                if ($done[$j] =~ /^\d$/) {
                    my $vl = $done[$j];
                    if ( $done[$j-1] =~ /\d/) { # OMG
                        $vl = $done[$j-1].$vl;
                        splice(@done,$j-1,1);
                    }
                    $done[$j] = $vl + $l;
                    $l = -1;
                    last;
                }
            }
            push(@done,0) unless $l == -1;
            my $string = join('',@done,@stack);
            $string=~s/\[,/[0,/;
            $string=~s/,\]/,0]/;
            return(1,$string);
        }
        else {
            push(@done,$v);
        }
    }
    return (0,join('',@done));
}

sub splt($in) {
    if ($in =~/(1\d)/) {
        my $num = $1;
        my $left = int($num / 2);
        my $right = $num / 2;
        $right = int($right) + 1 if $right != int($right);
        $in =~ s/$num/"[$left,$right]"/e;
        #    say "split $num into $left, $right";
        return (1, $in);
    }
    return (0, $in);
}
