use 5.030;
use strict;
use warnings;

my @prog = map { chomp; [ split/ / ] } <>;
my %var;
for (1..8) {
    say "$_ ". run($_);
    say $var{w}.$var{x},$var{y}.$var{z};
}

sub run {
    my ( @input ) =@_;

    %var = (w=>0,x=>0,y=>0,z=>0);
    for my $statement (@prog) {
        my ($op, $a, $b ) = $statement->@*;

        if ($op eq 'inp') {
            $var{$a} = shift(@input);
            next;
        }
        if ($b =~/[wxyz]/) {
            $b = $var{$b};
        }
        #        say "call $op with $a, $b";
        if ($op eq 'add') {
            $var{$a} += $b;
        }
        elsif ($op eq 'mul') {
            $var{$a} *= $b;
        }
        elsif ($op eq 'div') {
            $var{$a} = int($var{$a}/$b);
        }
        elsif ($op eq 'mod') {
            $var{$a} = $var{$a} % $b;
        }
        elsif ($op eq 'eq') {
            $var{$a} = 1 if $var{$a} == $b;
        }
        else {
            die "invalid op $op";
        }
    }
}

