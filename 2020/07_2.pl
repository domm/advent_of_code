use strict;
use warnings;
use 5.030;

my %bags;
my %contained;
while (<>) {
    my ($container, $content) = $_ =~ /^(.*?) bags contain (.*)\.$/;
    my @content = map { /^(\d+) (.*?) bags?/; [ $2,$1 ] } split(/, /,$content);
    next if $content[0][0] eq 'no other bags';

    $bags{$container} = \@content;
    foreach (@content) {
        push($contained{$_}->@*,$container);
    }
}

my %found;
my $count = count_bag('shiny gold');

sub count_bag {
    my ($bag) = @_;
    say "count $bag";
    my $children = $bags{$bag};
    my $thiscount = 1;
    foreach my $c ($children->@*) {
        say "$bag contains ".join(', ',@$c);
        my $factor = $c->[1];
        my $cc = count_bag($c->[0]);
        say "$factor * $cc";
        $thiscount += $factor * $cc;
    }
    return $thiscount;
}

say $count - 1;

