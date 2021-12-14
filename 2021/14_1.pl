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
my @sorted = sort { $count{$b} <=> $count{$a} } keys %count;
say $count{$sorted[0]} -  $count{$sorted[-1]};

