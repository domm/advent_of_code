use 5.030;
use strict;
use warnings;

my %cards;
my $total;
while (<>) {
    m/Card\s+(?<card>\d+):\s+(?<winner>[\d ]+) \|\s+(?<numbers>[\d ]+)/;
    my $card = $+{card};
    $cards{$card} += 1;
    my %win = map { $_=>1 } split(/\s+/,$+{winner});
    my $wins=0;
    for (split(/\s+/,$+{numbers})) {
        if ($win{$_}) {
            $wins++;
        }
    }
    if ($wins) {
        for (1 .. $wins) {
            $cards{$card + $_} += $cards{$card};
        }
    }
}

for (values %cards) {
    $total+=$_;
}

say $total;
