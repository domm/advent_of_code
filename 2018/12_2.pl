use strict;
use warnings;
use 5.026;
use List::Util qw(min max);

my $gen = shift @ARGV;

my $init = <>;
$init =~s/.*: //;
chomp($init);

my @init = split(//,$init);

my %pots;
for (my $i =-3;$i<@init;$i++) {
    $pots{$i} = $i < 0 ? '.' :$init[$i];
}

my %rules;
foreach (<>) {
    chomp;
    next unless /#/;
    my ($match, $replace) = $_ =~ /^(.{5}) => (.)$/;
    $rules{$match} = $replace;
}

my $pots = \%pots;
my $i=0;
my $prev_sum=0;
my $prev_diff=0;
foreach my $i (1 .. $gen ) {
    $pots = grow($pots);

    my $sum=0;
    foreach my $val ( sort{ $a <=>$b } keys %$pots) {
        if ($pots->{$val} && $pots->{$val}  eq '#') {
            $sum+=$val;
        }
    }
    my $diff = $sum - $prev_sum;
    $prev_sum=$sum;
    if ($i > 100 && $prev_diff == $diff) {
        say $sum + ( $diff * ( $gen - $i ));
        exit;
    }
    $prev_diff = $diff;
}

sub grow {
    my $old = shift;
    my %next;
    my $min = min(keys %$old) -2;
    my $max = max(keys %$old) +2;
    foreach my $potnr ($min .. $max) {
        my $neig = join('', map { $old->{$_} || '.' } ($potnr-2) .. ($potnr+2));
        next if $neig eq '.....';
        my $hit=0;
        foreach my $m (sort keys %rules) {
            if ($neig eq $m) {
                my $r = $rules{$m};
                $next{$potnr}=$r;
                $hit++;
                last;
            }
        }
        unless ($hit) {
            $next{$potnr}='.';
        }
    }

    # foreach my $i (sort { $a <=> $b }  keys %next) {
    #     print $next{$i} if $next{$i} ;
    # }
    # print"\n";

    return \%next;
}

