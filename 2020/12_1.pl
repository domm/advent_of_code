use strict;
use warnings;
use 5.030;
no strict 'refs';

my @in = map { [/^(\w)(\d+)$/] }  <>;

my $dir = 'E';
my @map;

my %turn=(
    L => [qw(N W S E)],
    R => [qw(S W N E)]
);

my $r=1000;
my $c=1000;

for (@in) {
    my ($op, $val) = @$_;
    &$op($val);
    say "$r  / $c";
}

say abs($r-1000) + abs($c-1000);


sub N { $r -= shift }
sub S { $r += shift }
sub E { $c += shift }
sub W { $c -= shift }

sub F {
    my $val = shift;
    $dir->($val);
}

sub L {
    my $val = shift;
    turn('L',$val);
}
sub R {
    my $val = shift;
    turn('R',$val);
}

sub turn {
    my ($to, $val) = @_;
    my $times = $val / 90;
    for (1 .. $times) {
        my $new = $dir = shift($turn{$to}->@*);
        push($turn{$to}->@*, $new);
    }
}
