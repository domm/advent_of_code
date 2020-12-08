use strict;
use warnings;
use 5.030;

my @original=map { /^(...) (.*)$/;$1.'_'.$2}<>;


my %tried;
while (1) {
    my @try = @original;
    PERMUTE: for (my $i=0;$i<@original;$i++) {
        my $line = $try[$i];
        next if $line =~ /acc/;
        if ($tried{$i}++) {
            next;
        }
        else {
            $line =~/nop/ ? $line=~s/nop/jmp/ : $line=~s/jmp/nop/;
            $try[$i] = $line;
            last PERMUTE;
        }
    }

    my ($exit, $acc) = run(@try);
    if ($exit) {
        say "IT ENDED: ". $acc;
        exit;
    }
    else {
        say "nope..";
    }
}


sub run {
    my @code = @_;
    my %seen;
    my $i=0;
    my $acc=0;
    while(1) {
        my $raw = $code[$i];
        my ($op, $val) = split(/_/,$raw);
        if ($seen{$i}++) {
            return 0;
        }
        elsif ($i >= @code) {
            return (1, $acc);
        }
        if ($op eq 'nop') {
            $i++
        }
        elsif ($op eq 'acc') {
            $acc+=$val;
            $i++
        }
        elsif ($op eq 'jmp') {
            $i+=$val;
        }
    }
}

