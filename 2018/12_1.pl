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
for (1 .. 20 ) {
    $pots = grow($pots);
}

my $sum=0;
foreach my $val ( sort{ $a <=>$b } keys %$pots) {
    if ($pots->{$val} && $pots->{$val}  eq '#') {
        $sum+=$val;
    }
}
say $sum;


sub grow {
    my $old = shift;
    my %next;
    my $min = min(keys %$old) -2;
    my $max = max(keys %$old) +2;
    foreach my $potnr ($min .. $max) {
        my $neig = join('', map { $old->{$_} || '.' } ($potnr-2) .. ($potnr+2));
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

    #foreach my $i (sort { $a <=> $b }  keys %next) {
    #    print $next{$i} if $next{$i} ;
    #}
    #print"\n";

    return \%next;
}

