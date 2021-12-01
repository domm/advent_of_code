use strict;
use warnings;
use 5.030;

my %contained;
for (<>) {
    my ($container, $content) = $_ =~ /^(.*?) bags contain (.*)\.$/;
    my @content = map {/^\d+ (.*?) bags?/} split(/, /,$content);
    foreach (@content) {
        push($contained{$_}->@*,$container);
    }
}

say count_bag('shiny gold', {});

sub count_bag {
    my ($bag, $agg) = @_;
    foreach my $p ($contained{$bag}->@*) {
        $agg->{$p}++;
        count_bag($p, $agg);
    }
    scalar keys $agg->%*;
}
