use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my ($map, $fold) = split(/\n\n/,join('',<>));
my @map;
my ($max_r,$max_c)=(0,0);
for (split(/\n/,$map)) {
    chomp;
    last unless /\d/;
    my ($c, $r) = split(/,/);
    $map[$r][$c]='#';
    $max_r = $r if $r > $max_r;
    $max_c = $c if $c > $max_c;
}

for my $r (0..$max_r) {
    for my $c (0..$max_c) {
        $map[$r][$c] ||='.';
    }
}

for my $line (split(/\n/,$fold)) {
    my @new;
    if ($line =~ /y=(\d+)/) {
        my @new = fold($1,@map);
        @map = @new;
    }
    elsif ($line =~ /x=(\d+)/) {
        my $at = $1;
        my $r=0;
        for my $row (@map) {
            splice(@$row,$at,1);
            my @right = splice(@$row,$at,@$row-$at);
            my $c=0;
            for my $mark (reverse @right) {
                $map[$r][$c] = $mark if $mark eq '#';
                $c++;
            }
            $r++;
        }

    }
}
draw(\@map);

sub fold {
    my ($fold, @map) = @_;
    splice(@map,$fold,1);
    my @low = splice(@map,$fold,@map-$fold);
    push(@low, [map {'.'} (0..$max_c) ]) if @low != @map;
    my $r=0;
    for my $folded (reverse @low) {
        for (my $c=0;$c<@$folded;$c++) {
            my $spot = $folded->[$c];
            $map[$r][$c] = $spot if $spot eq '#';
        }
        $r++;
    }
    return @map;
}


sub draw {
    my $m = shift;
    for my $r (@$m) {
        for (@$r) {
            print $_;
        }
        print "\n";
    }
    print "\n";
}

