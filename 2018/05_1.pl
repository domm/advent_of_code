use 5.010;
$_ = <STDIN>;
chomp;
my $r = join('|',map {'('.$_.uc($_).')|('.uc($_).$_.')'} a .. z);
E
say length;
