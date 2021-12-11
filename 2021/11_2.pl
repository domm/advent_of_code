use 5.030;
use strict;
use warnings;

my @map;
my ($r) = 0;
for (<>) {
    chomp;
    my $c = 0;
    for ( split(//) ) {
        $map[$r]->[ $c++ ] = $_;
    }
    $r++;
}
my $flash=0;
my $step=0;
while (1) {
    $step++;
    $flash = 0;
    for my $r (0..9) {
        for my $c (0..9) {
            $map[$r][$c]++;
        }
    }
    for my $r (0..9) {
        for my $c (0..9) {
            flash($r, $c) if $map[$r][$c] > 9;
        }
    }
    if ($flash == 100) {
        say $step;
        exit;
    }
    #show($step);
}

sub flash {
    my ($r, $c) = @_;
    $map[$r][$c]=0;
    $flash++;
    for my $m ([-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]) {
        my $rm = $r+$m->[0];
        my $cm = $c+$m->[1];
        next if $rm < 0 || $cm < 0 || $rm > 9 || $cm > 9;
        next if $map[$rm][$cm] == 0;
        $map[$rm][$cm]++;
        flash($rm,$cm) if $map[$rm][$cm] > 9;
    }
}

sub show {
    my ($step) = @_;
    say "After step $step";
    for my $r (0..9) {
        for my $c (0..9) {
            print $map[$r][$c];
        }
        print "\n";
    }
}

