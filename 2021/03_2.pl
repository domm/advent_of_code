use 5.030;
use strict;
use warnings;

my @in = <>;
my @bits;
for (@in) {
    chomp;
    my @line = split(//);
    push(@bits, \@line);
}

my $ox = oxygen(@bits);
say $ox;


my $scrub = scrubber(@bits);

say $scrub;

say $scrub * $ox;

sub oxygen {
    my @list = @_;
    my $pos=0;
    while (@list > 1) {
        my @res=([],[]);
        foreach my $row (@list) {
            my $bit = $row->[$pos];
            push($res[$bit]->@*,$row);
        }
        say $pos . ' '.scalar $res[0]->@*;
        say $pos . ' '.scalar $res[1]->@*;

        $pos++;
        my $next = $res[0]->@* > $res[1]->@* ?  $res[0] : $res[1];
        @list= @$next;
    }
    my $val = '0b'.(join('',$list[0]->@*));
    return eval $val;
}

sub scrubber {
    my @list = @_;
    my $pos=0;
    while (@list > 1) {
        my @res=([],[]);
        foreach my $row (@list) {
            my $bit = $row->[$pos];
            push($res[$bit]->@*,$row);
        }
        say $pos . ' '.scalar $res[0]->@*;
        say $pos . ' '.scalar $res[1]->@*;

        $pos++;
        my $next = $res[0]->@* <= $res[1]->@* ?  $res[0] : $res[1];
        @list= @$next;

    }
    my $val = '0b'.(join('',$list[0]->@*));
    return eval $val;
}


