use strict;
use warnings;
use 5.030;
no strict 'refs';

my %mem;
my @mask;
for (<>) {
    if (/mask = (.*)/) {
        my @inmask = split //,$1;
        @mask=();
        for(my $i=0;$i<@inmask;$i++) {
            next if $inmask[$i] eq 'X';
            push(@mask,[$i, $inmask[$i]]);
        }
    }
    elsif (/mem\[(\d+)\] = (\d+)/) {
        my ($addr,$val)=($1,$2);
        my @val = split(//, sprintf(("%036b", $val)));
        foreach (@mask) {
            $val[$_->[0]] = $_->[1];
        }
        $mem{$addr}=oct '0b'.join('',@val);
    }
}

my $sum=0;
map { $sum+=$_ } values %mem;
say $sum;
