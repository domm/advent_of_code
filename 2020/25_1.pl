use 5.020;
use strict;
use warnings;


my ($card_public, $door_public) = @ARGV;
my $subject_number = 7;

my $card_loop = crack($card_public);
say "card loop size: $card_loop";
say fake($door_public,$card_loop);

my $door_loop = crack($door_public);
say "card loop size: $door_loop";
say fake($card_public,$door_loop);

sub crack {
    my $target = shift;
    my $loop_size=1;
    my $value = 1;
    while (1) {
        $value *= $subject_number;
        $value = $value % 20201227;
        return $loop_size if $value == $target;
        $loop_size++;
    }
}

sub fake {
    my ($subject_number,$loop_size) = @_;
    my $value = 1;
    for (1 .. $loop_size) {
        $value *= $subject_number;
        $value = $value % 20201227;
    }
    return $value;
}

