use 5.030;
use strict;
use warnings;


my %open=(
    '('=>')',
    '['=>']',
    '{'=>'}',
    '<'=>'>',
);

my %hits;
LINE: for my $line (<>) {
    chomp($line);
    my @stack;
    for my $c (split(//,$line)) {
        if ($open{$c}) {
            push(@stack,$c);
        }
        else {
            my $last = pop(@stack);
            if ($c ne $open{$last}) {
                #say "expected ". $open{$last}." but found $c";
                $hits{$c}++;
                next LINE;
            }

        }

    }
}

my %points=(
')'=> 3,
']'=> 57,
'}'=> 1197,
'>'=> 25137,
);

my $res=0;
while (my ($char,$count) = each %hits) {
    $res+= $points{$char} * $count;
}

say $res;



