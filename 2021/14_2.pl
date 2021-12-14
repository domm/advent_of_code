use 5.030;
use strict;
use warnings;

my @poly = split(//,<>);<>;
pop(@poly);
my %pairs;
for (my $i=0;$i<@poly-1;$i++) {
    $pairs{$poly[$i].$poly[$i+1]}++;
}
my %rules;
for (<>) {
    chomp;
    my ($pair,$insert) = split(/ -> /);
    my @split = split(//,$pair);
    $rules{$pair}=[$split[0].$insert,$insert.$split[1]];
}

for my $step (1 .. 40) {
    my %new;
    while (my ($pair,$count) = each %pairs) {
        $new{ $rules{$pair}[0] } += $count;
        $new{ $rules{$pair}[1] } += $count;
    }
    %pairs = %new;
}

my %count = ($poly[-1] => 1);
while (my ($pair,$count) = each %pairs) {
    my ($f,$s)=split(//,$pair);
    $count{$f}+=$count;
}
my @sorted = sort { $count{$b} <=> $count{$a} } keys %count;
say $count{$sorted[0]} -  $count{$sorted[-1]};

