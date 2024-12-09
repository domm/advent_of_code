#!/usr/bin/env perl
use v5.40;

my @map = split(//,<>);
pop(@map); # remove trainling newline

my $id = 0;
my $pos = 0;
my @frees;
my @files;
for my ($file, $space) (@map) {
    for (0 .. $file -1 ) {
        $files[$pos++] = $id;
    }
    for (0 .. $space -1 ) {
        $files[$pos] = '.';
        $frees[$pos++] = 1;
    }
    $id++;
}
my $max_id =$id - 1;
say $max_id;

my $defrag = join('', @files);
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
