use 5.030;
use strict;
use warnings;

my %sizes;
my @cwd;
while (my $cmd = <>) {
    if ($cmd eq '$ cd ..') {
        pop(@cwd);
    }
    elsif ($cmd =~ / cd (.*)$/) {
        push(@cwd,$1);
    }
    elsif ($cmd=~/^(\d+) (.*)/) {
        my ($size, $name) = ($1, $2);
        my @parent = @cwd;
        while (@parent) {
            $sizes{join('/',@parent)}+=$size;
            pop(@parent);
        }
    }
    # other data can be ignored
}

my $disk = 70000000;
my $to_delete = 30000000 - $disk + $sizes{'/'};
my $smallest = $disk;
for my $size (values %sizes) {
    next if $size < $to_delete;
    $smallest = $size if $size < $smallest;
}
say $smallest;

