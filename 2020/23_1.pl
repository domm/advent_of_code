use 5.020;
use strict;
use warnings;

my @cups = map { {cup=>$_,next=>undef,prev=>undef} } split(//,$ARGV[0]);
my $size= @cups;

for (my $i=0;$i<@cups;$i++) {
    $cups[$i]->{prev} = $cups[$i-1];
    $cups[$i]->{next} = $cups[($i+1)% $size];
}

my $current = $cups[0];
for my $m (1..100) {
    say "\nround $m";
    dumpcups($current);
    my $remove_start = $current->{next};
    my $remove_end = rotate($current, 3);
    $current->{next} = $remove_end->{next};
    $current->{next}{prev} = $current;

    my $val = ($current->{cup} - 1) || 9;
    my $destination;
    while (!$destination) {
        say "try $val";
        $destination = find($current, $val);
        $val = (($val-1) % $size) || 9;
    }
    say "dest: ".$destination->{cup};
    my $destination_after = $destination->{next};

    $destination->{next} = $remove_start;
    $remove_start->{prev} = $destination;
    $destination_after->{prev} = $remove_end;
    $remove_end->{next} = $destination_after;

    $current = $current->{next};
    dumpcups($current);
}

my $start;
for (1..9) {
    if ($current->{cup} == 1) {
        $start=$current;
        last;
    }
    $current=$current->{next};
}

say result($start);

sub result {
    my $dh = shift;
    my $res;
    for (1..8) {
        $dh = $dh->{next};
        $res.=$dh->{cup};
    }
    return $res;
}


sub dumpcups {
    my $dh = shift;
    for (1..9) {
        print $dh->{cup}. ', ';
        $dh = $dh->{next};
    }
    print"\n";
}

sub rotate {
    my ($h, $count) = @_;
    my $dir = 'next';
    for (1 .. abs($count)) {
        $h = $h->{$dir};
    }
    return $h;
}

sub find {
    my ($h, $target) = @_;

    for (1..6) {
        return $h if $h->{cup} == $target;
        $h = $h->{next}
    }
    return;
}

#
#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@cups;
#
#my $head = {
#    marble=>0,
#};
#$head->{prev} = $head->{next} = $head;


