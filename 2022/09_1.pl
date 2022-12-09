use v5.36;
use strict;
use warnings;

my @head = (0,0);
my @tail = (0,0);
my %seen;
my %move = ( R=>[1,1],L=>[1,-1],U=>[0,-1],D=>[0,1]);
for my $in (<>) {
    my ($dir,$steps) = $in=~/(\w) (\d+)/;
    say "Go $steps in $dir";
    my ($dim,$factor) = $move{$dir}->@*;

    $head[$dim] += $factor * $steps;

    draw();

}

sub draw{
    for my $r (-10 .. 10) {
        for my $c (-10 .. 10) {
            if ($head[0] == $r && $head[1] eq $c) {
                print "H";
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

