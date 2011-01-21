use strict;
use warnings;
use utf8;

package Term::DNAColor;
# ABSTRACT: Add colors to DNA and RNA sequences

use Exporter::Simple;
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

This is simply an alias for C<colordna>. Unlike C<colordna>, it is not
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

This module mainly provides a function, C<colordna>, that takes a DNA
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

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
