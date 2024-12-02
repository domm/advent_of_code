#!/usr/bin/perl
use v5.40;

my $valid = 0;
REP: while ( my $line = <> ) {
    my @report = grep { /\d/ } split(/\s+/ ,$line);
    next if $report[0] - $report[1] == 0;
    my $dir = ($report[0] - $report[1]) > 0 ? 1 : -1;
    for (my $i=1;$i<@report;$i++) {
        my $diff = $report[$i-1]-$report[$i];
        my $this_dir = $diff > 0 ? 1 : -1;
        next REP if $diff == 0 || abs($diff) > 3;
        next REP if $dir != $this_dir;
    }
    $valid++;
}
say $valid;
