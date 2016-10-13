use utf8;
package HTML_DIR::Chado::Result::LibrarySynonym;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::LibrarySynonym - Linking table between library and synonym.

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<library_synonym>

=cut

__PACKAGE__->table("library_synonym");

=head1 ACCESSORS

=head2 library_synonym_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'library_synonym_library_synonym_id_seq'

=head2 synonym_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 library_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The pub_id link is for
relating the usage of a given synonym to the publication in which it was used.

=head2 is_current

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

The is_current bit indicates whether the linked synonym is the current -official- symbol for the linked library.

=head2 is_internal

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

Typically a synonym
exists so that somebody querying the database with an obsolete name
can find the object they are looking for under its current name.  If
the synonym has been used publicly and deliberately (e.g. in a paper), it my also be listed in reports as a synonym.   If the synonym was not used deliberately (e.g., there was a typo which went public), then the is_internal bit may be set to "true" so that it is known that the synonym is "internal" and should be queryable but should not be listed in reports as a valid synonym.

=cut

__PACKAGE__->add_columns(
  "library_synonym_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "library_synonym_library_synonym_id_seq",
  },
  "synonym_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "library_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_current",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
  "is_internal",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</library_synonym_id>

=back

=cut

__PACKAGE__->set_primary_key("library_synonym_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<library_synonym_c1>

=over 4

=item * L</synonym_id>

=item * L</library_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("library_synonym_c1", ["synonym_id", "library_id", "pub_id"]);

=head1 RELATIONS

=head2 library

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "HTML_DIR::Chado::Result::Library",
  { library_id => "library_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 synonym

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Synonym>

=cut

__PACKAGE__->belongs_to(
  "synonym",
  "HTML_DIR::Chado::Result::Synonym",
  { synonym_id => "synonym_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DCW2KnAe7W91sNFm2YriiA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
