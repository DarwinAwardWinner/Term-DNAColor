use strict;
use warnings;
use utf8;

package Term::DNAColor;
# ABSTRACT: Add colors to DNA and RNA sequences in terminal output

use base 'Exporter::Simple';
use Term::ANSIColor qw(color);

sub _get_nucl_color {
    my $nucl_colors = {
        A => 'green',
        T => 'red',
        U => 'red',             # Support RNA too!
        C => 'blue',
        G => 'yellow',
    };
    return color($nucl_colors->{$_[0]} || 'reset') . color('bold');
}

sub _wrap_nucl_in_color {
    return _get_nucl_color($_[0]) . $_[0] . color('reset');
}

=function colordna

Takes a string representing a DNA sequence and adds ANSI color codes
to the following nucleotides:

=for :list
* A: green
* T: red
* C: blue
* G: yellow

U is colorized like T, to accomodate RNA sequences.

In addition, the entire sequence is rendered in bold.

This function is exported by default.

=cut

sub colordna : Exported {
    my @seq_chars = split //, shift;
    my @colored_seq_chars = map { _wrap_nucl_in_color($_) } @seq_chars;
    return join "", @colored_seq_chars;
}

=function colorrna

This is simply an alias for C<colordna>. Both C<colordna> and
C<colorrna> will highlight U for uracil. Unlike C<colordna>, it is not
exported by default, but only by request.

=cut

sub colorrna : Exportable {
    return colordna(@_);
}

1; # Magic true value required at end of module
__END__

=head1 SYNOPSIS

    use Term::DNAColor;

    print colordna("ATCGGTCNNNTAGCTGAN"), "\n";

=head1 DESCRIPTION

This module provides a function, C<colordna>, that takes a DNA
sequence and wraps unambiguous nucleotides in ANSI color codes, so
that you can print the sequence to a terminal and have it come out
colored.

=head1 BUGS AND LIMITATIONS

Colors are not configurable.

Please report any bugs or feature requests to
C<rct+perlbug@thompsonclan.org>.

=head1 SEE ALSO

=for :list
* L<Term::ANSIColor> - Provides the ANSI color codes for this module
