use 5.030;
use strict;
use warnings;

my @fish = split(',',<>);

for (0..80) {
    say "day $_: ".@fish;
    my @next;
    my @born;
    foreach my $f (@fish) {
        if ($f == 0) {
            push(@next,6);
            push(@born,8);
        }
        else {
            push(@next, $f - 1);
        }
    }
    @fish = ( @next, @born);
}

