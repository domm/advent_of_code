use 5.030;
use strict;
use warnings;

my @prog = map { chomp; [ split/ / ] } <>;

#my $mnr = 99999999999999;
my $mnr = 99999996883287;

my $cnt=0;
while (1) {
    $mnr--;
    next if $mnr =~ /0/;
    if ($cnt++ > 100_000) {
        say $mnr;
        $cnt=0;
    }
    my @data=split(//,$mnr);
    my $result = run(@data);
    if ($result->{z} == 0) {
        say "found $mnr";
    }
}

sub run {
    my ( @input ) =@_;

    my %var = (w=>0,x=>0,y=>0,z=>0);
    for my $statement (@prog) {
        my ($op, $a, $b ) = $statement->@*;

        if ($op eq 'inp') {
            $var{$a} = shift(@input);
            next;
        }
        $var{a} //= 0;
        if ($b =~/[wxyz]/) {
            $b = $var{$b} // 0;
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
        elsif ($op eq 'eql') {
            $var{$a} = 1 if $var{$a} == $b;
        }
        else {
            die "invalid op $op";
        }
    }
    return \%var;
}

