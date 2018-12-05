use 5.010;
use strict;
use warnings;

my @rec = sort <STDIN>;

my $current_guard;
my $start;
my %stats;
my $highest=0;
my $highest_guard;
my $per_min_max=0;
my $per_min_min;
my $per_min_guard;
foreach my $l (@rec) {
    my ($min) = $l =~ /:(\d\d)/;
    if ($l =~ /Guard #(\d+)/) {
        $current_guard = $1;
        $start = undef;
    }
    if ($l =~ /falls/) {
        $start = $min;
    }
    if ($l =~ /wakes/) {
        my $end = $min -1;
        for ($start .. $end) {
            $stats{$current_guard}{total}++;
            $stats{$current_guard}{$_}++;
            if ($stats{$current_guard}{$_} > $per_min_max) {
                $per_min_max=$stats{$current_guard}{$_};
                $per_min_min = $_;
                $per_min_guard = $current_guard;
            }
        }
        if ($stats{$current_guard}{total} > $highest) {
            $highest_guard=$current_guard;
            $highest = $stats{$current_guard}{total};
        }
    }
}

my $hit=0;
my $max=undef;
while (my ($min,$count) = each %{$stats{$highest_guard}}) {
    next if $min eq 'total';
    if ($count > $hit) {
        $hit = $count;
        $max = $min;
    }
}

say "1: $highest_guard -> $max; answer: ".$highest_guard * $max;

say "2: $per_min_guard -> $per_min_min ($per_min_max) answer: ".$per_min_guard * $per_min_min;
