use 5.020;
use strict;
use warnings;

use Parse::RecDescent;

my @in=split(/\n\n/,join('',<>));
my $grammar = $in[0];
$grammar=~s/(\d+)/r$1/g;
my $parser = new Parse::RecDescent("startrule: r0 ';'\n".$grammar);

my $hit=0;
my @data=split(/\n/,$in[1]);
for my $l (@data) {
    $l.=';';
    if ($parser->startrule($l)) {
        $hit++;
    }
}
say $hit;
