use 5.034;
use strict;
use warnings;

my @map;
my $r=0;
my $g=1;
my %rows;
my %cols;
for my $line (<>) {
    my $c=0;
    for my $f (split(//,$line)) {
        if ($f eq '#') {
            push(@map, {g=>$g++, r=>$r, c=>$c});
            $rows{$r}++;
            $cols{$c}++;
        }
        $c++;
    }
    $r++;
}

my @empty_rows;
for (my $i=0;$i<$r;$i++) {
    push(@empty_rows,$i) unless $rows{$i};
}
my @empty_cols;
for (my $i=0;$i<$r;$i++) {
    push(@empty_cols,$i) unless $cols{$i};
}

my $expand = 1000000-1;
expand($expand, 'r', \@empty_rows, \%rows, \@map);
expand($expand, 'c', \@empty_cols, \%cols, \@map);

my %dist;
my $sum;
for my $g (@map) {
    my $from = $g->{g};
    for my $t (@map) {
        my $to = $t->{g};
        my $id = join('-',sort($from, $to));
        next if $to eq $from || $dist{$id};
        my $dist = $dist{$id} = abs($g->{r} - $t->{r}) + abs($g->{c} - $t->{c});
        $sum+=$dist;
    }
}

say $sum;
#draw();

sub expand {
    my ($expand, $dim, $empty, $onedim, $map) = @_;
    while (my $v = pop(@$empty)) {

        for my $g (sort { $b->{$dim} <=> $a->{$dim}} @$map ) {
            next unless $g->{$dim} > $v;
            #say $g->{g}. " $v -> ".$g->{$dim};
            my $new = $g->{$dim} + ($expand );
            #say "  move to ".$new;
            $g->{$dim} = $new;
        }
    }
}

sub draw {
    my @d;
    for my $g (@map) {
        $d[$g->{r}][$g->{c}] = $g->{g};
    }
    my $m = @d;
    say $m+=3;
    for (my $r=0;$r<$m;$r++) {
        for (my $c=0;$c<$m;$c++) {
            print $d[$r][$c] || '.';
        }
        print "\n";
    }
}
