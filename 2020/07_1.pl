use strict;
use warnings;
use 5.030;

#posh brown bags contain 5 dim coral bags, 1 plaid blue bag, 2 faded bronze bags, 2 light black bags.
#vibrant lime bags contain 3 dull lavender bags, 3 dim crimson bags, 3 mirrored lavender bags, 2 muted cyan bags.


my %bags;
my %contained;
while (<>) {
    my ($container, $content) = $_ =~ /^(.*?) bags contain (.*)\.$/;
    my @content = map { say $_;/^\d+ (.*?) bags?/} split(/, /,$content);
    #say $container ." -> ".join (', ',@content);

    $bags{$container} = \@content;
    foreach (@content) {
        push($contained{$_}->@*,$container);
    }
}

my %found;

count_bag('shiny gold');

sub count_bag {
    my $bag=shift;
    my $parents = $contained{$bag};
    foreach my $p ($parents->@*) {
        $found{$p}++;
        count_bag($p);
    }
}

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%contained;

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%found;

say scalar keys %found;


