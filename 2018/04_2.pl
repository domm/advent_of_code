use 5.010;
use strict;
use warnings;

my @rec = sort <STDIN>;

my $current_guard;
my $start;
my %stats;
my $highest=0;
my $highest_guard;
my $per_min_max;
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
        say "$l sleeps from $start to $end";
        #say $stats{$current_guard}{total}++;
        for ($start .. $end) {
            $stats{$current_guard}{total}++;
            $stats{$current_guard}{$_}++;
            if ($stats{$current_guard}{$_} > $per_min_max) {
                $per_min_max=$stats{$current_guard}{$_};
                $per_min_min = $_;
                $per_min_guard = $current_guard;
            }
        }
    #$say $stats{$current_guard}{total}++;
        if ($stats{$current_guard}{total} > $highest) {
            $highest_guard=$current_guard;
            $highest = $stats{$current_guard}{total};
        }
    }
}


foreach (reverse sort map { $_->{total} } values %stats) {
    say $_;
}

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%stats;

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $stats{$highest_guard};

my $hit=0;
my $max=undef;
while (my ($min,$count) = each %{$stats{$highest_guard}}) {
    next if $min eq 'total';
    if ($count > $hit) {
        $hit = $count;
        $max = $min;
    }
}

say "$highest_guard -> $max ".$highest_guard * $max;

say "2: $per_min_guard -> $per_min_min ($per_min_max) ".$per_min_guard * $per_min_min;
