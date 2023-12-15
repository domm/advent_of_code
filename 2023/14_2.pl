use 5.034;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ":utf8");

my @start = map { chomp;s/\./ /g;s/#/█/g;$_; }<>;
my @dish = @start;

my $max = 1000000000;
my %rep;

for my $step (1 .. $max) {
    @dish = cycle(@dish);
    my $load = load(@dish);

    next if $step < 12;

    push($rep{$load}->@*, $step);
    if ($rep{$load}->@* > 3) {
        my @loop = $rep{$load}->@*;
        if ($loop[-1] - $loop[-2] == $loop[-2] - $loop[-3]) {
            my $size = $loop[-1] - $loop[-2];
            my $foo = $max - $step;
            my $mod = $foo % $size;
            say "$max - $step = $foo => $mod";
            say $load;
            # hm, did I just get lucky that I got mod==0 and thus the correct load?
            exit;
        }
    }
}

sub cycle {
    my $dish = @_;
    for my $s (1..4) {
        @dish = rotate_right(tilt(@dish));
    }
    return @dish;
}

sub tilt {
    my @dish = @_;
    my @rot;
    for my $line (@dish) {
        next unless $line;
        my @row = split(//,$line);
        for (my $i=0;$i<@row;$i++) {
            $rot[$i].= $row[$i] eq '.' ? ' ' : $row[$i];
        }
    }

    my @back;
    for my $row (@rot) {
        next unless $row;
        while ($row =~ / O/) {
            $row=~s/ O/O /g;
        }
        my @row = split(//,$row);
        for (my $i=@row-1;$i>=0;$i--) {
            $back[$i].=$row[$i];
        }
    }
    return @back;
}

sub rotate_right {
    my @dish = @_;
    my @rot;

    for my $row (reverse @dish) {
        my @row = split(//,$row);
        for (my $i=0;$i<@row;$i++) {
            $rot[@row-$i].=$row[$i];
        }
    }
    shift(@rot);
    return reverse @rot;
}


sub load {
    my @dish = @_;
    my $load;
    for (my $i=0;$i<@dish;$i++) {
        next unless $dish[$i];
        my $rocks = () = $dish[$i] =~ /O/g;
        $load += ($rocks * (@dish - $i));
    }
    return $load;
}

sub display {
    my @dish = @_;
    for (@dish) {
        say $_ if $_;;
    }
    print "\n";
}
