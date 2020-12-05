use strict;
use warnings;
use 5.030;

# $a=0;while(<STDIN>){tr/FBLR/0101/;$b=eval'0b'.substr($_,0,7).'*8+0b'.substr($_,7,3);if($b>$a){$a=$b}}say $a;

while(<>){tr/FBLR/0101/;s/(.{7})(.{3})/'0b'.$1.'*8+0b'.$2/ee;if($_>$a){$a=$_}}say$a;

