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
    my $move=0;
    # move left herd
    while (my ($r, $row) = each @map) {
        while (my ($c, $val) = each @$row) {
            my $look = ($c + 1) % $width;
            # say "at $c, look at $look: ".$val.$map[$r][$look];
            if ($val eq '>') {
                if ($map[$r][$look] eq '.') {
                    $next[$r][$look] = $val;
                    $next[$r][$c] = '.';
                    $move++;
                }
            }
            $next[$r][$c] ||= $val;
        }
    }
    @map = @next;
    my @next2;
    # move down herd
    while (my ($r, $row) = each @map) {
        while (my ($c, $val) = each @$row) {
            my $look = ($r + 1) % $height;
            #say "down: at $r/$c, look at $look/$c: ".$val.$map[$look][$c];
            if ($val eq 'v') {
                if  ($map[$look][$c] eq '.') {
                    $next2[$look][$c] = $val;
                    $next2[$r][$c] = '.';
                    $move++;
                }
            }
            $next2[$r][$c] ||= $val;
        }
    }

    say $step;
    @map = @next2;
    if ($move == 0 ) {
        say "No movement on step $step";
        exit;
    }
}


