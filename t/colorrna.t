#!perl
use Test::More;
use Term::ANSIColor 2.01 qw(colorstrip color);
use Term::DNAColor qw(colorrna);

my $seq = "ATGCNATGCN";

my $colored_seq = colorrna($seq);
ok($colored_seq, "dolorrna returned something");
is(colorstrip($colored_seq), $seq, "dolorrna does not change characters, only adds colors between them");

my $reset_end_regexp = quotemeta(color('reset')) . '$';

ok($colored_seq =~ m{$reset_end_regexp}, "dolorrna ends with a reset");

TODO: {
    local $TODO = "I don't know how to test for ANSI color code equivalence.";
}

done_testing();
