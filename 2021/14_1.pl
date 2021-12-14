use 5.030;
use strict;
use warnings;

my $template = <>;<>;
chomp($template);
my %rules;
for (<>) {
    chomp;
    my ($pair,$insert) = split(/ -> /);
    my @split = split(//,$pair);
    $rules{$pair}=[$split[0],$insert];
}

my $step=1;
my @poly = split(//,$template);
for my $step (1 .. 10) {
    my @new;
    for (my $i=0;$i<@poly-1;$i++) {
        push(@new,$rules{$poly[$i].$poly[$i+1]}->@*);
    }
    push(@new,$poly[-1]);
    @poly = @new;
}

my %count;
for (@poly) {
    $count{$_}++;
}
my @sorted = sort { $count{$b} <=> $count{$a} } keys %count;
say $count{$sorted[0]} -  $count{$sorted[-1]};

