use 5.030;
use strict;
use warnings;

my @map = map { chomp(); [split//]} <>;
my $width =  $map[0]->@*;
my $height = @map;

my $step=0;
while (1) {
    $step++;
    my @next;
    # move left herd
    while (my ($r, $row) = each @map) {
        while (my ($c, $val) = each @$row) {
            my $look = ($c + 1) % $width;
            #say "at $c, look at $look: ".$val.$map[$r][$look];
            if ($val eq '>' && $map[$r][$look] eq '.') {
                $next[$r][$look] = $val;
                $next[$r][$c] = '.';
            }
            else {
                $next[$r][$c] = $val if !$next[$r][$c] || $next[$r][$c] eq '.';
            }
        }
    }
    # move down herd
    while (my ($r, $row) = each @map) {
        while (my ($c, $val) = each @$row) {
            my $look = ($r + 1) % $height;
            #say "down: at $r/$c, look at $look/$c: ".$val.$map[$look][$c];
            if ($val eq 'v' && $map[$look][$c] eq '.') {
                $next[$look][$c] = $val;
                $next[$r][$c] = '.';
            }
            else {
                $next[$r][$c] = $val if !$next[$r][$c] || $next[$r][$c] eq '.';
            }
        }
    }

    say $step;
    for my $row (@next) {
        for my $col (@$row) {
            print $col;
        }
        print "\n";
    }
    @map = @next;
exit if $step == 2;
}


