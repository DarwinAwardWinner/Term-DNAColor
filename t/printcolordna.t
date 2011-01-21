#!perl
use Test::More;

use Term::DNAColor;

my $seq = "ATGCNATGCN";

my $colored_seq = colordna($seq);

diag "Here is a colored sequence: $colored_seq";

ok(1, "Placeholder test");

done_testing();
