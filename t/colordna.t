#!perl
use Test::More;
use Term::ANSIColor 2.01 qw(colorstrip color);
use Term::DNAColor;

my $seq = "ATGCNATGCN";

my $colored_seq = colordna($seq);
ok($colored_seq, "colordna returned something");
is(colorstrip($colored_seq), $seq, "colordna does not change characters, only adds colors between them");

my $reset_end_regexp = quotemeta(color('reset')) . '$';

ok($colored_seq =~ m{$reset_end_regexp}, "colordna ends with a reset");

TODO: {
    local $TODO = "I don't know how to test for ANSI color code equivalence.";
}

done_testing();
