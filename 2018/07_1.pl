use 5.026;
use strict;

my %prereq;
while (<>) {
    my ($before, $after) = $_ =~/ ([A-Z]) .* ([A-Z])/;
    $prereq{$before} ||= '';
    $prereq{$after}.=$before;
}

my $order;
while (1) {
    # get the first sorted step that has no prereq left (i.e. all steps that have to be done before this step are done)
    my ($step) = sort grep { $prereq{$_} eq '' } keys %prereq;

    # store the step in the solution
    $order.=$step;

    # delete this step from the list of steps
    delete $prereq{$step};

    # go through all available prereqs and remove this step, as it is done now
    map { s/$step//; } values %prereq;

    # stop when we have now steps left to do
    unless (%prereq) {
        say $order;
        last;
    }
}

