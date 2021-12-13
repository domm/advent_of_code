use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my ($map, $fold) = split(/\n\n/,join('',<>));

my @map;
my ($max_c,$max_r)=(0,0);
for (split(/\n/,$map)) {
    chomp;
    last unless /\d/;
    my ($c, $r) = split(/,/);
    $map[$r][$c]='#';
    $max_r = $r if $r > $max_r;
    $max_c = $c if $c > $max_c;
}

for my $r (0..$max_r) {
    for my $c (0..$max_c) {
        $map[$r][$c] ||='.';
    }
}

#draw(\@map);

for (split(/\n/,$fold)) {
    my @new;
    if (/y=(\d+)/) {
        my $fold = $1;
        say $fold;
        splice(@map,$fold,1);
        my @low = splice(@map,$fold,@map-$fold);
        draw(\@map);
        say 'xxxxx';
        draw(\@low);

        say 'fold';
        my $r=0;
        for my $folded (reverse @low) {
            for (my $c=0;$c<@{$folded};$c++) {
                my $spot = $folded->[$c];
                $map[$r][$c] = $spot if $spot eq '#';
            }
            $r++;
        }
        draw(\@map);

    }
    exit;
}


sub draw {
    my $m = shift;
    say "draw";
    for my $r (@$m) {
        for (@$r) {
            print $_ || '.';
        }
        print "\n";
    }
    print "\n";
}

