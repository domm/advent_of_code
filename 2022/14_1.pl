use v5.36;

my $map={};
$map->{0}{500} = 's';
for (<>) {
    chomp;
    my @lines;
    for (split (/ -> /)) {
        my ($col, $row) = split(/,/);
        push(@lines, [$row, $col]);
    }
    for (my $i = 0;$i<$#lines;$i++) {
        my $start = $lines[$i];
        my $end = $lines[$i + 1];
        if ($start->[0] eq $end->[0]) {
            my ($from, $to) = sort { $a <=> $b} ($start->[1] ,$end->[1]);
            for my $col ($from .. $to) {
                $map->{$start->[0]}{$col}='#';
            }
        }
        else {
            my ($from, $to) = sort { $a <=> $b} ($start->[0] ,$end->[0]);
            for my $row ($from .. $to) {
                $map->{$row}{$start->[1]}='#';
            }
        }
    }
}




sub draw {} {
for my $r (0..9) {
    print $r;
    for my $c (490 .. 510) {
        print $map->{$r}{$c} || ' ';
    }
    print "\n";
}
}
