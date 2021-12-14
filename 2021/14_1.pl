use 5.030;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my $template = <>;
chomp($template);
<>;
my %rules;
for (<>) {
    chomp;
    my ($pair,$insert) = split(/ -> /);
    my @split = split(//,$pair);
    $rules{$pair}=[$split[0],$insert];
}

my $step=1;
my @poly = split(//,$template);
while ($step <= 10 ) {

    my @new;
    for (my $i=0;$i<@poly-1;$i++) {
        my $check = $poly[$i].$poly[$i+1];
        if ($rules{$check}) {
            push(@new,$rules{$check}->@*);
        }
        else {
            push(@new,$poly[$i])
        }
    }
    push(@new,$poly[-1]);
    #say "step $step: ".join('',@new);
    $step++;
    @poly = @new;
}

say scalar@poly;

my %count;
for (@poly) {
    $count{$_}++;
}
use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%count;

my @sorted = sort { $count{$b} <=> $count{$a} } keys %count;

say $count{$sorted[0]} -  $count{$sorted[-1]};






__END__

my ($map, $fold) = split(/\n\n/,join('',<>));
say $fold;
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

draw(\@map);
for my $line (split(/\n/,$fold)) {
    say "LINE $line";
    my @new;
    if ($line =~ /y=(\d+)/) {
        my @new = fold($1,@map);
        #   my $fold = $1;
        #   splice(@map,$fold,1);
        #   my @low = splice(@map,$fold,@map-$fold);
        #   draw(\@map);
        #   say 'xxxxx';
        #   draw(\@low);

        #   say 'fold';
        #   my $r=0;
        #   for my $folded (reverse @low) {
        #       for (my $c=0;$c<@{$folded};$c++) {
        #           my $spot = $folded->[$c];
        #           $map[$r][$c] = $spot if $spot eq '#';
        #       }
        #       $r++;
        #   }
        #   draw(\@map);
        # draw(\@new);
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
    draw(\@map);
    count(\@map);
    exit;
}

sub count {
    my $map = shift;
    my $cnt=0;
    for my $r (@$map) {
        for my $c (@$r) {
            $cnt++ if $c eq '#';
        }
    }
    say $cnt;
}


sub fold {
    my ($fold, @map) = @_;
    splice(@map,$fold,1);
    my @low = splice(@map,$fold,@map-$fold);
    my $r=0;
    for my $folded (reverse @low) {
        for (my $c=0;$c<@{$folded};$c++) {
            my $spot = $folded->[$c];
            $map[$r][$c] = $spot if $spot eq '#';
        }
        $r++;
    }
    return @map;
}


sub draw {
    my $m = shift;
    say "draw";
    for my $r (@$m) {
        for (@$r) {
            print $_ || '.';
        }
        print "\n";
    }
    print "\n";
}

