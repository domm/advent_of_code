use 5.034;
use strict;
use warnings;

my %rules = (
    '|' => { N=>'N',S=>'S' },
    '-' => { E=>'E',W=>'W' },
    'L' => { S=>'E',W=>'N' },
    'J' => { S=>'W',E=>'N' },
    '7' => { E=>'S',N=>'W' },
    'F' => { N=>'E',W=>'S' },
);
my %move = (
    'N'=>[-1,0],
    'E'=>[0,1],
    'S'=>[1,0],
    'W'=>[0,-1],
);

my @map;
my $r=0;
my $start;
for my $l (<>) {
    chomp($l);
    my $c = 0;
    for my $m ( split(//,$l) ) {
        my $tile = { tile=>$m, dist=>0};
        if ($m eq 'S') {
            $start=[$r,$c];
            $tile->{is_start}=1;
            $tile->{rules} = $rules{'F'};
        }
        elsif ($m ne '.') {
            $tile->{rules} = $rules{$m};
        }
        $map[$r][$c] = $tile;
        $c++;
    }
    $r++;
}


my $step = 0;
my $loc = $start;
my $dir = @map > 50 ? 'N' : 'E';

while (1) {
    my $look_to = [$loc->[0] + $move{$dir}->[0], $loc->[1] + $move{$dir}->[1]] ;
    # printf("%s at %i:%i dir %s, look at %i:%i\n", ,$map[$loc->[0]][$loc->[1]]{tile}, @$loc, $dir, @$look_to);
    my $look = $map[$look_to->[0]][$look_to->[1]];
    $look->{loop} = 1;
    if (my $next_dir = $look->{rules}{$dir}) {
        $loc = $look_to;
        $dir = $next_dir;
        $look->{dist} = ++$step;
        # printf("\tconenction to %s, new dir %s", $look->{tile}, $dir);
        if ($look->{tile} eq 'S') {
            say "BACK AT START";
            say $step / 2;
            last;
        }
    }
    else {
        say "NO CONNECTION";
        exit;
    }
}

$map[$start->[0]][$start->[1]]{tile} = '|';
$map[$start->[0]][$start->[1]]{loop} = 1;

my $in=0;
my $cnt = 0;
for my $r (0 .. @map -1) {
    my $size = @{$map[0]};
    for my $c (0 .. $size -1) {
        if ($map[$r][$c]{loop}) {
            if ($map[$r][$c]{tile} eq '|' ||$map[$r][$c]{tile} eq 'J' || $map[$r][$c]{tile} eq 'L' ) {
                $in = $in ? 0 : 1;
            }
        }
        elsif (!$map[$r][$c]{loop}) {
            $cnt++ if $in;
        }
    }
}

say "inside $cnt";

