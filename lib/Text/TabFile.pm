=head1 NAME:

Text::TabFile - Module for parsing tab delimited files

=head1 SYNOPSIS:

Text::TabFile provides a programattical interface to data stored in text 
files delimited with tabs. It is dependant upon the first row of the tab 
file containing header information for each corresponding "column" in the 
file.

After instancing, for each call to Read the next row's data is returned as 
a hash reference. The individual elements are keyed by their corresonding 
column headings.

=head1 USAGE:

A short example of usage is detailed below. It opens a file called 
'infile.tab', reads through every row and prints out the data from 
"COLUMN1" in that row. It then closes the file.

  my $tabfile = new Text::TabFile;
  $tabfile->Open('infile.tab');

  my @header = $tabfile->Fields;

  while ( my $row = $tabfile->Read ) {
    print $row->{COLUMN1}, "\n";
  }

  $tabfile->Close;

A shortcut for Open is to specifiy the file or a globbed filehanle as the 
first parameter when the module is instanced:

  my $tabfile = new Text::TabFile ('infile.tab');

  my $tabfile = new Text::TabFile (\*STDIN);

The Close() method is atuomatically called when the object passes out of 
scope. However, you should not depend on this. Use Close() when 
approrpiate.

Other informational methods are also available. They are listed blow:

=head1 METHODS:

=item Close()

Closes the file or connection, and cleans up various bits.

=item Fields()

Returns an array (or arrayref, depending on the requested context) with 
the column header fields in the order specified by the source file.

=item FileName()

If Open was given a filename, this function will return that value.

=item LineNumber()

This returns the line number of the last line read. If no calls to Read 
have been made, will be 0. After the first call to Read, this will return 
1, etc.

=item new([filename|filepointer],[enumerate])

Creates a new Text::TabFile object. Takes optional parameter that is either
a filename or a globbed filehandle. Files specified by filename must 
already exist.

Can optionally take a second argument. If this argument evaluates to true,
TabFile.pm will append a _NUM to the end of all fields with duplicate names.
That is, if your header row contains 2 columns named "NAME", one will be 
changed to NAME_1, the other to NAME_2.

=item Open([filename|filepointer], [enumerate])

Opens the given filename or globbed filehandle and reads the header line. 
Returns 0 if the operation failed. Returns the file object if succeeds.

Can optionally take a second argument. If this argument evaluates to true,
TabFile.pm will append a _NUM to the end of all fields with duplicate names.
That is, if your header row contains 2 columns named "NAME", one will be 
changed to NAME_1, the other to NAME_2.

=item Read()

Returns a hashref with the next record of data. The hash keys are determined
by the header line. 

__DATA__ and __LINE__ are also returned as keys.

__DATA__ is an arrayref with the record values in order.

__LINE__ is a string with the original tab-separated record. 

This method returns undef if there is no more data to be read.

=item setMode(encoding)

Set the given encoding scheme on the tabfile to allow for reading files
encoded in standards other than ASCII.

=head1 EXPORTABLE METHODS:

For convienience, the following methods are exportable. These are handy 
for quickly writing output tab files.

=item tj(@STUFF)

Tab Join. Returns the given array as a string joined with tabs.

=item tl(@STUFF)

Tab Line. Returns the given array as a string joined with tabs (with 
newline appended).

=head1 SEE ALSO:

  Text::Delimited

=head1 AUTHORSHIP:

  Phil Pollard <bennie@cpan.org>
  Released under GNU General Public License

  Additional work by Kristina Davis <kdavis@hmsonline.com>
  Based upon the original module by Andrew Barnett <abarnett@hmsonline.com>

  Derived from Util::TabFile 1.9 2003/11/05 17:53:24
  With permission granted from Health Market Science, Inc.

=cut

package Text::TabFile;
$Text::TabFile::VERSION='0.8';

use base 'Text::Delimited';
use strict;

require Exporter;
require DynaLoader;

push our @ISA, 'Exporter';
our @EXPORT_OK = qw(tj tl);

sub _init {
  my $self = shift @_;
  $self->Delimiter("\t");
}

sub tj {
  my $self = shift @_ if ref($_[0]);
  return join("\t",@_);
}

sub tl {
  my $self = shift @_ if ref($_[0]);
  return join("\t",@_) . "\n";
}

1;
