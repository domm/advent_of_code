use 5.010;
$_ = <STDIN>;
chomp;
my $r = join('|',map {'('.$_.uc($_).')|('.uc($_).$_.')'} a .. z);
1 while s/$r//g;
say length;
