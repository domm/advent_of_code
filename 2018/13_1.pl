use 5.026;
use strict;
#use warnings;

my $width = 0;
my $map;
while (<>) {
    $map.=$_;
    $width = length($_) if length($_) > $width;
}
$width--;
my %carts;
my $id = 'a';
$map =~ s/([<>v\^])/my $d= $1; $carts{$id} = { dir=>$d, rot=>0, prev=> ($d=~\/[<>]\/ ? '-' : '|')};$id++/ge;

my $carts = scalar keys %carts;
while ($map !~ /x/i) {
    print `clear`;
    while ($map =~ /[a-z]/) {
        $map=~s/([\\\/+\-A-Z])([a-z])/&left($2, $1)/e;
        $map=~s/([a-z])([\\\/+\-A-Z])/&right($1, $2)/e;
        $map=~s/([\\\/+\|A-Z])(.{$width})([a-z])/&up($3, $1, $2)/es;
        $map=~s/([a-z])(.{$width})([\\\/+\|A-Z])/&down($1, $3, $2)/es;
    }
    $map=~s/([A-Z])/lc($1)/gse;
    say $map;
    if ($map =~ /^(.*)x/is) {
        my $l = length($1);
        my $row = int($l / $width) ;
        $map =~/\n([^\n]*?)x/is;
        my $col = length($1);
        say "$row / $col";
        exit;
    }

    select(undef,undef,undef,0.5);
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
    elsif ($next eq '+') {
        turn($cart);
    }
    elsif ($next =~/[a-z]/i) {
        return "X".$carts{$cart}{prev};
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
    elsif ($next eq '+') {
        turn($cart);
    }
    elsif ($next =~/[a-z]/i) {
        return $carts{$cart}{prev}."X";
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
    elsif ($next eq '+') {
        turn($cart);
    }
    elsif ($next =~/[a-z]/i) {
        return "X".$ignore.$carts{$cart}{prev};
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
    elsif ($next eq '+') {
        turn($cart);
    }
    elsif ($next =~/[a-z]/i) {
        return $carts{$cart}{prev}.$ignore."X";
    }

    my $moved = $carts{$cart}{prev}.$ignore.uc($cart);
    $carts{$cart}{prev}=$next;
    return $moved;
}


sub turn {
    my $cart = shift;
    my $cur = $carts{$cart}{dir};
    my $turn = $carts{$cart}{rot} % 3;
    my @dirs = qw(^ < v > ^ <);

    if ($turn == 0) { # left
        foreach my $i (1 .. 4) {
            if ($cur eq $dirs[$i]) {
                $carts{$cart}{dir}=$dirs[$i+1];
            }
        }
    }
    elsif ($turn == 2) { # right
        foreach my $i (1 .. 4) {
            if ($cur eq $dirs[$i]) {
                $carts{$cart}{dir}=$dirs[$i-1];
            }
        }
    }
    $carts{$cart}{rot}++;
}

