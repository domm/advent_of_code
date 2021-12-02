use strict;
use warnings;
use 5.028;

my $in = join('',<>);

# remove circles
my $backtracks=0;
while ($in =~/(\([^(]+\|\))/) {
    my $rep = $1;
    $backtracks += (length($rep) - 3 ) /2;
    $in=~s/\([^(]+\|\)//;
    say $rep;
}
say $backtracks;
my %branches=(1=>[0,0]);
my $branch=1;
my $max=0;
my $thousand = 0;
foreach my $l (split(//,$in)) {
    if ($l=~/[NSEW]/) {
        $branches{$branch}->[0]++;
        $branches{$branch}->[2].=$l;
        $thousand++ if $branches{$branch}[0] >= 1000;
    }
    if ($l eq '(') {
        my $new_branch=$branch.'_1';
        my $val = $branches{$branch}->[0];
        $branches{$new_branch} = [ $val, $val, $branches{$branch}->[2]];
        $branch = $new_branch;
    }
    elsif ($l eq ')') {
        $branch =~s/_\d+$//;
    }
    elsif ($l eq '|') {
        my ($counter) = $branch =~ /_(\d+)$/;
        $counter++;
        my $new_branch = $branch;
        $new_branch=~s/(\d+)$/$counter/;
        my $val = $branches{$branch}->[1];
        $branches{$new_branch} = [ $val, $val, $branches{$branch}->[2]];
        $branch = $new_branch;
    }
    $max = $branches{$branch}[0] if $max < $branches{$branch}[0];
}
say $max;
say $thousand;
