#!/usr/bin/env perl
use v5.40;

my @map = split(//,<>);
pop(@map); # remove trainling newline

my $id = 0;
my $pos = 0;
my %frees;
my @frees;
my @files;
for my ($file, $space) (@map) {
    for (0 .. $file -1 ) {
        $files[$pos++] = $id;
    }
    if ($space) {
        for (0 .. $space -1 ) {
            push(@frees, $pos);
            $pos++;
        }
    }
    $id++;
}

my $defrag;

while (@frees) {
    my $val = pop(@files);
    next if !defined $val;
    my $next_free = shift(@frees);
    $files[$next_free] = $val;
    $defrag = join('', map { $_ // '.' } @files);
    last if $defrag !~ /\d\.\d/ ;
    #last if $next_free + 1 >= @files;
    #last if $defrag =~ /^\d+$/;
}
$defrag = join('', map { $_ // '.' } @files);
my $checksum=0;
for (my $i = 0;$i<@files;$i++) {
    next if (! defined $files[$i]) || $files[$i] eq '.';
    $checksum+= $i * $files[$i];
}
say $checksum;

