use strict;
use warnings;
use 5.030;

my $in = join('',<STDIN>);
$in =~ s/\n\n/SEP/gm;
$in =~ s/\s/;/g;
my @d = split(/SEP/,$in);

my $valid = 0;
for my $l (@d) {
    my %p = map { split /:/ } split( /;/, $l);
    next unless (keys %p == 8 || (keys %p == 7 && !$p{cid}));
    next unless $p{byr} =~ /^\d{4}$/ && $p{byr} >= 1920 && $p{byr} <= 2002;
    next unless $p{iyr} =~ /^\d{4}$/ && $p{iyr} >= 2010 && $p{iyr} <= 2020;
    next unless $p{eyr} =~ /^\d{4}$/ && $p{eyr} >= 2020 && $p{eyr} <= 2030;
    next unless $p{hcl} =~ /^#[0-9a-f]{6}$/;
    next unless $p{ecl} =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/;
    next unless $p{pid} =~ /^\d{9}$/;
    if ($p{hgt} =~ /^(\d\d\d)cm$/) {
        next unless $1 >= 150 && $1 <= 193;
    }
    elsif ($p{hgt} =~ /^(\d\d)in$/) {
        next unless $1 >= 59 && $1 <= 76;
    }
    else {
        next;
    }

    $valid++;
}
say $valid;
