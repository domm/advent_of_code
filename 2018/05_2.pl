use 5.010;
my $in = <STDIN>;
chomp($in);
say length($in);

my $reg = join('|',map {'('.$_.uc($_).')|('.uc($_).$_.')'} a .. z);

my $shortest;
my $count=9999999;

foreach my $letter (a..z) { # should fork :-)
    say $letter;
    my $try = $in;
    $try=~s/$letter//gi;
    while ($try=~/$reg/) {
        $try=~s/$reg//g;
    }
    my $leng = length($try);
    say "$letter $leng";
    if ($leng < $count) {
        $shortest=$letter;
        $count = $leng;
    }
}
say "$shortest $count";

