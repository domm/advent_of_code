use 5.034;
use strict;
use warnings;

my %rules = (
    '/' => { N=>'E', E=>'N', S => 'W', W=>'S' },
    '\\' => { N=>'W', E=>'S', S => 'E', W=>'N' },
    '|' => { N=>'N', E=>'NS', S => 'S', W=>'NS' },
    '-' => { N=>'EW', E=>'E', S => 'EW', W=>'W' },
    '.' => { N=>'N', E=>'E', S => 'S', W=>'W' },
);
my %move = (
    N=>[-1,0],
    E=>[0,1],
    S=>[1,0],
    W=>[0,-1],
);

my @map = map { chomp; [split//] } <>;
my $max = $#map;

my @edges = map { {pos =>[0, $_], dir=>'S'},{pos =>[$max, $_], dir=>'N'}, {pos =>[$_,0], dir=>'E'}, {pos =>[$_,$max], dir=>'W'}  } 0 .. $max;
my $max_power = 0;
for my $start (@edges) {
    my $power = beam_it( $start );
    $max_power = $power if $power > $max_power;
}
say $max_power;

sub beam_it {
    my @beams = @_;
    my %powered;
    while (@beams) {
        my $beam = shift(@beams);
        my $pos = join(':',$beam->{pos}->@*);
        next if $powered{ $pos }{$beam->{dir}}++;

        my $action = $rules{$map[$beam->{pos}[0]][$beam->{pos}[1]]};
        for my $dir (split(//,$action->{$beam->{dir}})) {
            my $new_r = $beam->{pos}[0] + $move{$dir}[0];
            my $new_c = $beam->{pos}[1] + $move{$dir}[1];
            if ($new_r >= 0 && $new_r <= $max && $new_c >=0 && $new_c <= $max) {
                my $new = { pos=>[ $new_r, $new_c ], dir=>$dir };
                push(@beams, $new);
            }
        }
    }
    return scalar keys %powered;
}

