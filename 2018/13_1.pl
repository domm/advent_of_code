use 5.026;
use strict;
use warnings;

my $width = 13;

my $map = join('',<>);
say $map;

my %carts;
my $id = 'a';
$map =~ s/([<>v\^])/my $d= $1; $carts{$id} = { dir=>$d, rot=>0, prev=> ($d=~\/[<>]\/ ? '-' : '|')};$id++/ge;

use Data::Dumper; $Data::Dumper::Maxdepth=3;$Data::Dumper::Sortkeys=1;warn Data::Dumper::Dumper \%carts;

my $tick = 0;
my $carts = scalar keys %carts;
#while ($map !~ /X/) {
for (1 .. 50 ) {
    while ($map =~ /[a-z]/) {
        $map=~s/([\\\/+\-\|])([a-z])/&left($2, $1)/e;
        $map=~s/([a-z])([\\\/+\-\|])/&right($1, $2)/e;
        $map=~s/([^\s])(.{13})([a-z])/&up($3, $1, $2)/es;
        $map=~s/([a-z])(.{13})([^\s])/&down($1, $3, $2)/es;
    }
    $map=~s/([A-Z])/lc($1)/gse;
    say $map;
    print `clear`; 
    select(undef,undef,undef,0.2);
}

sub left {
    my ($cart, $next) = @_;
    #say "left $cart?";
    return $next.$cart unless $carts{$cart}{dir} eq '<';

    if ($next eq '\\') {
        $carts{$cart}{dir} = '^';
    }
    elsif ($next eq '/') {
        $carts{$cart}{dir} = 'v';
    }

    my $moved=uc($cart).$carts{$cart}{prev};
    $carts{$cart}{prev}=$next;
    return $moved;

}
sub right {
    my ($cart, $next) = @_;
    #say "right $cart?";
    return $cart.$next unless $carts{$cart}{dir} eq '>';

    if ($next eq '\\') {
        $carts{$cart}{dir} = 'v';
    }
    elsif ($next eq '/') {
        $carts{$cart}{dir} = '^';
    }

    my $moved=$carts{$cart}{prev}.uc($cart);
    $carts{$cart}{prev}=$next;
    return $moved;

}
sub up {
    my ($cart, $next, $ignore) = @_;
    #say "up $cart?";
    return $next.$ignore.$cart unless $carts{$cart}{dir} eq '^';

    if ($next eq '\\') {
        $carts{$cart}{dir} = '<';
    }
    elsif ($next eq '/') {
        $carts{$cart}{dir} = '>';
    }


    my $moved = uc($cart).$ignore.$carts{$cart}{prev};
    $carts{$cart}{prev}=$next;
    return $moved;
}

sub down {
    my ($cart, $next, $ignore) = @_;
    #say "down $cart?";
    return $cart.$ignore.$next unless $carts{$cart}{dir} eq 'v';

    if ($next eq '\\') {
        $carts{$cart}{dir} = '>';
    }
    elsif ($next eq '/') {
        $carts{$cart}{dir} = '<';
    }

    my $moved = $carts{$cart}{prev}.$ignore.uc($cart);
    $carts{$cart}{prev}=$next;
    return $moved;
}
