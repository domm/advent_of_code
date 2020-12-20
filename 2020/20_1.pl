use 5.020;
use strict;
use warnings;
use Math::Matrix;

my %tiles;
my %matches;
for(split(/\n\n/,join('',<>))) {
    my @raw = split(/\n/);
    my $name = shift(@raw);
    my ($id)= $name =~ /(\d+)/;
    say $id;

    my @tile;
    for(@raw) {
        chomp;
        push(@tile,[split//]);
    }

    my %seen;
    for my $dir (0..3) {
        calc($id,$dir,\@tile,\%seen);

        my $m = Math::Matrix->new(@tile);

        my $ud = $m->flipud;
        calc($id,$dir.'_ud',$ud,\%seen);

        my $lr = $m->fliplr;
        calc($id,$dir.'_lr',$lr,\%seen);

        my $n = $m->rot90();
        @tile = @$n;
    }

}

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%matches;

#use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%tiles;


sub calc {
    my ($id,$dir,$tile, $seen) = @_;
    my $checksum = checksum($tile);
    return if $seen->{$checksum}++;
    push($tiles{$id}->@*,{
        check=>$checksum,
        dir=>$dir,
        #tile=>$tile,
    });
    push($matches{$checksum}->@*,[$id,$dir]);
}


sub checksum {
    my $tile = shift;
    my $row = join('',map { /#/ ? 1 : 0 } $tile->[0]->@*);
    return eval '0b'.$row;
}


