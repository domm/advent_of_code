#!/usr/bin/env perl
use v5.40;

my @map = split(//,<>);
pop(@map); # remove trainling newline

my %disk;
my $id = 0;
for my ($file, $space) (@map) {
    $disk{$id} = {
        file => $file,
        free => $space || 0,
    };
    $id++;
}
my $max_id =$id - 1;
say $max_id;


my $defrag='';
for my $id (0 .. $max_id) {
    $defrag.= $id x $disk{$id}->{file};
    $defrag.= '.' x $disk{$id}->{free};
}
$defrag.='.';
say $defrag;

while ($defrag =~ /\d\.\d/) {
    $defrag =~s /^(\d+)\.(.*)(\d)\./$1$3$2./;
    say $defrag;

}

my $checksum;
my @check = split(//,$defrag);
for (my $i = 0;$i<@check;$i++) {
    last if $check[$i] eq '.';
    $checksum+= $i * $check[$i];
}
say $checksum;
