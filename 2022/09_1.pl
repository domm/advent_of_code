use v5.36;
use strict;
use warnings;

my @head = (0,0);
my @tail = (0,0);
my %seen;
my %move = ( R=>[1,1],L=>[1,-1],U=>[0,-1],D=>[0,1]);
for my $in (<>) {
    my ($dir,$steps) = $in=~/(\w) (\d+)/;
    my ($dim,$factor) = $move{$dir}->@*;
    for (1 .. $steps) {
        $head[$dim] += $factor;
        my $dr = abs($head[0] - $tail[0]);
        my $dc = abs($head[1] - $tail[1]);
        if ($dr == 2 && $dc == 1) {
            $tail[0] = $head[0] - $factor;
            $tail[1] = $head[1];
        }
        elsif ($dr == 1 && $dc == 2) {
            $tail[1] = $head[1] - $factor;
            $tail[0] = $head[0];
        }
        elsif ($dr > 1) {
            $tail[0] += $factor;
        }
        elsif ($dc > 1) {
            $tail[1] += $factor;
        }
        $seen{join(':',@tail)}++;
    }
}

say scalar keys %seen;

#draw();

sub draw{
    for my $r (-5 .. 5) {
        for my $c (-5 .. 5) {
            if ($head[0] == $r && $head[1] eq $c) {
                print "H";
            }
            elsif ($tail[0] == $r && $tail[1] eq $c) {
                print "T";
            }
            elsif ($r ==0 && $c ==0) {
                print 's';
            }
            else {
                print '.';
            }
        }
        print "\n";
    }

}

