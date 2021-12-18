use 5.030;
use strict;
use warnings;
use Data::Dumper;
use feature qw(signatures);
no warnings qw(experimental::signatures);

my $add = <>;
chomp($add);
while (<>) {
    chomp;
    $add = '['.$add.','.$_.']';

    reduce($add);

}
say $add;


sub reduce($in) {
    my @stack = split(//,$in);
    my @done;
    my $l=0;
    for (my $i=0;$i<@stack;$i++) {
        my $v = shift(@stack);
        $l++ if $v eq '[';
        $l-- if $v eq ']';
        if ($l eq 5) {
            say "explode $i";
            my ($l,undef,$r,undef) = splice(@stack,0,4);
            say "$l $r";
            for (my $j=0;$j<@stack;$j++) {
                if ($stack[$j] =~ /^\d$/) {
                    $stack[$j]+= $r;
                    $r=-1;
                    last;
                }
            }
            unshift(@stack,0) unless $r == -1;

            for (my $j=$#done;$j>=0;$j--) {
                if ($done[$j] =~ /^\d$/) {
                    $done[$j]+= $l;
                    $l = -1;
                    last;
                }
            }
            push(@done,0) unless $l == -1;

            say join('',@done,@stack);;
            #say join '',@stack[$i+1 .. $i+5];
            exit;
        }
        else {
            push(@done,$v);
        }
    }
}




__END__
my @homework = map { eval($_) } <>;

my $prev = [shift (@homework),shift(@homework)];
while (@homework) {
    my $added = [$prev,shift(@homework)];


    $prev = $added;
}
warn Dumper $prev;

