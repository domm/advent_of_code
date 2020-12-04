use strict;
use warnings;
use 5.030;

my $in = join('',<STDIN>);
$in =~ s/\n\n/SEP/gm;
$in =~ s/\n/ /g;
$in =~ s/\s/;/g;

my @d = split(/SEP/,$in);
my $valid = 0;
for my $l (@d) {
    my %p = map {  split/:/ } split(/;/, $l);
say $l;
    next unless (keys %p == 8 || (keys %p == 7 && !$p{cid}));
    say "A";
    next unless $p{byr} =~ /^\d{4}$/ && $p{byr} >= 1920 && $p{byr} <= 2002;
    say "B";
    next unless $p{iyr} =~ /^\d{4}$/ && $p{iyr} >= 2010 && $p{iyr} <= 2020;
    say "C";
    next unless $p{eyr} =~ /^\d{4}$/ && $p{eyr} >= 2020 && $p{eyr} <= 2030;
    say "D";
    next unless $p{hcl} =~ /^#[0-9a-f]{6}$/;
    say "e";
    next unless $p{ecl} =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/;
    say "F";
    next unless $p{pid} =~ /^\d{9}$/;

    if ($p{hgt} =~ /^(\d\d\d)cm$/) {
        say $p{hgt} . " $1";
        next unless $1 >= 150 && $1 <= 193;

    }
    elsif ($p{hgt} =~ /^(\d\d)in$/) {
        say $p{hgt} . " $1";
        next unless $1 >= 59 && $1 <= 76;
    }
    else {
        next;
    }
    say "G";

    $valid++;


    #    byr (Birth Year) - four digits; at least 1920 and at most 2002.
    #    iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    #    eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    #    hgt (Height) - a number followed by either cm or in:
    #        If cm, the number must be at least 150 and at most 193.
    #        If in, the number must be at least 59 and at most 76.
    #    hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    #    ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    #    pid (Passport ID) - a nine-digit number, including leading zeroes.
    #    cid (Country ID) - ignored, missing or not.


}

say $valid;

