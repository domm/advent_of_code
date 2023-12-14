use 5.034;
use strict;
use warnings;

my @rot;
for my $line (<>) {
    chomp($line);
    my @row = split(//,$line);
    for (my $i=0;$i<@row;$i++) {
        $rot[$i].= $row[$i] eq '.' ? ' ' : $row[$i];
    }
}

my @back;
for my $row (@rot) {
    while ($row =~ / O/) {
        $row=~s/ O/O /g;
    }

    # rotate back
    my @row = split(//,$row);
    for (my $i=@row-1;$i>=0;$i--) {
        $back[$i].=$row[$i];
    }
}

my $load;
for (my $i=0;$i<@back;$i++) {
    my $rocks = () = $back[$i] =~ /O/g;
    $load += ($rocks * (@back - $i));
}
say $load;
