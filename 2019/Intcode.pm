package Intcode;

use strict;
use warnings;
use 5.030;
use feature 'signatures';
no warnings 'experimental::signatures';

use base qw(Class::Accessor::Fast);

__PACKAGE__->mk_accessors(qw(pos code modes output input halted relbase));

sub new ($class, $code, $pos = 0) {
    return bless {
        code => $code,
        pos  => $pos,
        modes => [],
        input => [],
        halted=>0,
        relbase=>0,
    }, $class;
}

sub runit ($self, $final = 0) {
    while (1) {
        my $raw = $self->code->[ $self->read_pos ];
        chomp($raw);
        my @modes= split(//,$raw);

        my $op = join('',reverse (grep {$_} (pop(@modes),pop(@modes))));
        @modes = reverse(@modes);
        $op=~s/^0//;
        #say $self->{pos}." op $op";
        chomp($op);
        my $method = 'op_' . $op;

        $self->modes(\@modes);
        last unless defined $self->$method;
    }
    return $self->code->[$final];
}

sub op_1 ($self) { # add
    $self->val($self->val + $self->val);
}

sub op_2 ($self) { # multiply
    $self->val($self->val * $self->val);
}

sub op_3 ($self) { # input
    my $in = shift($self->input->@*);
    #say "got input ".( $in || 'nothing yet');
    unless (defined $in) {
        $self->{pos} = $self->{pos}-1;
        return undef;
    }
    $self->val($in);
}

sub op_4 ($self) { # output
    $self->output($self->val);
    return undef;
}

sub op_5 ($self) { # jump-if-true
    my $pos = $self->pos;
    my $check = $self->val;
    my $target = $self->val;
    if ($check != 0) {
        $self->pos($target);
    }
}

sub op_6 ($self) { # jump-if-false
    my $pos = $self->pos;
    my $check = $self->val;
    my $target = $self->val;
    if ($check == 0) {
        $self->pos($target);
    }
}

sub op_7 ($self) { # less then
    $self->val($self->val < $self->val ? 1 : 0);
}

sub op_8 ($self) { # equals
    $self->val($self->val == $self->val ? 1 : 0);
}

sub op_9 ($self) { # relbase
    my $base = $self->val;
    #warn "new relbase $base";
    $self->relbase($self->relbase + $base);
}

sub op_99 ($self) {
    $self->halted(1);
    say "HALT";
    return undef;
}

sub val {
    my ($self, $val) = @_;
    my $mode = shift(@{$self->modes}) || 0;
    my $pointer = $self->code->[$self->read_pos];
    say "GET $mode $pointer" if DEBUG;
    if ($mode == 0) {
        $self->code->[$pointer] = $val if defined $val;
        return $self->code->[ $pointer];
    }
    elsif ($mode == 1) {
        die "mode 1 not to be used on set!" if defined $val;
        return $pointer;
    }
    elsif ($mode == 2) {
        $self->code->[$self->relbase + $pointer] = $val if defined $val;
        return $self->code->[$self->relbase + $pointer];
    }
    die "invalid mode $mode";
}

sub read_pos ($self) {
    my $pos = $self->pos ;
    $self->pos($pos + 1);
    return $pos;
}

1;
