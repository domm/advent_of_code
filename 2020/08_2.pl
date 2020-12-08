use strict;
use warnings;
use 5.030;

my @original = <>;
my %tried;
my $acc;
while (1) {
    my @try = @original;
    for ( my $i = 0; $i < @original; $i++ ) {
        my $line = $try[$i];
        next if $line =~ /acc/;
        if ( $tried{$i}++ ) {
            next;
        }
        else {
            $line =~ /nop/ ? $line =~ s/nop/jmp/ : $line =~ s/jmp/nop/;
            $try[$i] = $line;
            last;
        }
    }

    $acc = run(@try);
    last if $acc;
}
say $acc;

sub run {
    my @code = @_;
    my %seen;
    my $i   = 0;
    my $acc = 0;
    while (1) {
        return 0    if $seen{$i}++;
        return $acc if $i >= @code;
        my ( $op, $val ) = split( / /, $code[$i] );

        if ( $op eq 'jmp' ) { $i   += $val; next }
        if ( $op eq 'acc' ) { $acc += $val }
        $i++;
    }
}
