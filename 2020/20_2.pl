use 5.020;
use strict;
use warnings;

use Math::Matrix;

my %tiles;
my %by_edge;
for(split(/\n\n/,join('',<>))) {
    my @raw = split(/\n/);
    my $name = shift(@raw);
    my ($id)= $name =~ /(\d+)/;

    my @tile;
    for(@raw) {
        chomp;
        push(@tile,[split//]);
    }
    for my $dir (0..3) {
        calc($id,$dir,\@tile);

        my $m = Math::Matrix->new(@tile);

        my $ud = $m->flipud;
        calc($id,$dir.'_ud',$ud);

        my $lr = $m->fliplr;
        calc($id,$dir.'_lr',$lr);

        my $n = $m->rot90();
        @tile = @$n;
    }

}

my @corners = qw(1951 3079 1171 2971); # test
#my @corners = qw(1609 1123 2621 3253); # prod

#my $start = $corners[0];
#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $tiles{$start};

for my $start (2729) {
    say "\n\nST $start";
    for my $cand ($tiles{$start}->@*) {
        my $got = $by_edge{$cand->{check}};
        next unless $got;
        next if scalar keys %$got == 1;
        say "GOT ";
        use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper $got;
    }
}


sub calc {
    my ($id,$dir,$tile) = @_;
    my $checksum = checksum($tile);
    my @inner;
    for my $r (1..8) {
        for my $c (1..8) {
            $inner[$r-1]->[$c-1]=$tile->[$r][$c];
        }
    }
    push($tiles{$id}->@*,{
        check=>$checksum,
        dir=>$dir,
        tile=>\@inner,
    });
    $by_edge{$checksum}->{$id}=$dir;
}

sub checksum {
    my $tile = shift;
    my $row = join('',map { /#/ ? 1 : 0 } $tile->[0]->@*);
    return eval '0b'.$row;
}

