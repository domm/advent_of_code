use 5.020;
use strict;
use warnings;

my @cups = map { {cup=>$_,next=>undef,prev=>undef} } split(//,$ARGV[0]);
my $size= @cups;

my %by_label;
for (my $i=0;$i<@cups;$i++) {
    $cups[$i]->{prev} = $cups[$i-1];
    $cups[$i]->{next} = $cups[($i+1)% $size];
    $by_label{$cups[$i]->{cup}} = $cups[$i];
}

my $current = $cups[0];
for my $m (1..3) {
    say "round $m";
    dumpcups($current);
    my $remove_start = $current->{next};
    my $remove_end = rotate($current, 3);
    $current->{next} = $remove_end->{next};
    $current->{next}{prev} = $current;

    my $val = $current->{cup} - 1;
    say "des $val";
    my $destination = $by_label{$val};
    my $destination_after = $destination->{next};

    $destination->{next} = $remove_start;
    $remove_start->{prev} = $destination;
    $destination_after->{prev} = $remove_end;
    $remove_end->{next} = $destination_after;

    $current = $current->{next};
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



#
#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \@cups;
#
#my $head = {
#    marble=>0,
#};
#$head->{prev} = $head->{next} = $head;


