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

my $disk = 70000000;
my $to_delete = 30000000 - $disk + $sizes{'/'};
my $smallest = $disk;
for my $size (values %sizes) {
    next if $size < $to_delete;
    $smallest = $size if $size < $smallest;
}
say $smallest;

