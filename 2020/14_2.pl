use strict;
use warnings;
use 5.030;
no strict 'refs';

my %mem;
my @mask;
for (<>) {
    if (/mask = (.*)/) {
        @mask = split //,$1;
    }
    elsif (/mem\[(\d+)\] = (\d+)/) {
        my ($addr,$val)=($1,$2);

        my @addr = split(//, sprintf(("%036b", $addr)));
        my @results=([]);

        for(my $i=0;$i<@addr;$i++) {
            my $in = $addr[$i];
            if ($mask[$i] eq 'X') {
                my @add;
                for my $r (@results) {
                    push(@add, [@$r,'1']);
                    push(@$r,'0');
                }
                push(@results, @add);
            }
            else {
                my $out = $mask[$i] eq '1' ? 1 : $in;
                for my $r (@results) {
                    push(@$r, $out);
                }
            }
        }
        foreach my $r (@results) {
            my $add = oct '0b'.join('',@$r);
            $mem{$add}=$val;
        }
    }
}

my $sum=0;
map { $sum+=$_ } values %mem;
say $sum;
