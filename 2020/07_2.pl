use strict;
use warnings;
use 5.030;

my %bags;
for (<>) {
    my ($container, $content) = $_ =~ /^(.*?) bags contain (.*)\.$/;
    my @content = map {/^(\d+) (.*?) bags?/; [ $2,$1 ] } split(/, /,$content);
    next if $content[0][0] eq 'no other bags';

    $bags{$container} = \@content;
}

say count_bag('shiny gold') - 1;

sub count_bag {
    my $bag = shift;
    my $count = 1;
    foreach my $c ($bags{$bag}->@*) {
        $count += $c->[1] * count_bag($c->[0]);
    }
    return $count;
}
