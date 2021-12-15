use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my @map;
for (<>) {
    chomp;
    push(@map,[split(//,$_)]);
}
my $size = @map - 1;
my %nodes;
my $r=1;
for (my $r=0;$r<=$size;$r++) {
    for (my $c=0;$c<=$size;$c++) {
        my $from = "$r:$c";
        for my $look ( [ -1, 0 ], [ 1, 0 ], [ 0, -1 ], [ 0, 1 ] ) {
            my $tr = $r+$look->[0];
            my $tc = $c+$look->[1];
            next if $tr < 0 || $tc < 0 || $tr > $size || $tc > $size;
            #say "from $from to $tr:$tc: ". $map[$tr][$tc];
            push($nodes{$from}->@*, ["$tr:$tc", $map[$tr][$tc]]);
        }
    }
}

my $target = "$size:$size";
say $target;
for (1..10) {
    my %seen;
    my $cost=0;
    say walk('0:0', $cost, \%seen);
}

sub walk($node, $cost, $seen) {
    $seen->{$node}=1;
    say "$node - $cost";
    if ($node eq $target) {
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $seen;

        say "foud $cost";
        exit;
    }

    foreach my $next ( $nodes{$node}->@* ) {
        next if $seen->{$next->[0]};
        printf("next  %s, cost %s\n",@$next);
        $cost += $next->[1];
        walk( $next->[0], $cost, $seen );
    }
}

