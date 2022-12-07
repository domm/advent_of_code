use 5.030;
use strict;
use warnings;

my @cmds = map {chomp; $_} <>;
my %sizes;
my @cwd;

for (my $i=0;$i<@cmds;$i++) {
    my $cmd = $cmds[$i];
    if ($cmd eq '$ cd ..') {
        pop(@cwd);
    }
    elsif ($cmd =~ / cd (.*)$/) {
        my $dir = $1;
        push(@cwd,$dir);
    }
    elsif ($cmd eq '$ ls') {
        LS: while (1) {
            $i++;
            my $ls = $cmds[$i];
            last unless $ls;

            if ($ls =~ /dir (.*)/) {
                my $name = $1;
            }
            elsif ($ls=~/^(\d+) (.*)/) {
                my ($size, $name) = ($1, $2);
                my @parent = @cwd;
                while (@parent) {
                    $sizes{join('/',@parent)}+=$size;
                    pop(@parent);
                }
            }
            else {
                $i--;
                last LS;
            }
        }
    }
}

my $sum;
for my $size (values %sizes) {
    $sum += $size if $size <= 100000;
}
say $sum;

