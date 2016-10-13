use utf8;
package HTML_DIR::Chado::Result::Library;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Library

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

=head1 TABLE: C<library>

=cut

__PACKAGE__->table("library");

=head1 ACCESSORS

=head2 library_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'library_library_id_seq'

=head2 organism_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 uniquename

  data_type: 'text'
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The type_id foreign key links
to a controlled vocabulary of library types. Examples of this would be: "cDNA_library" or "genomic_library"

=head2 is_obsolete

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 timeaccessioned

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 timelastmodified

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "library_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "library_library_id_seq",
  },
  "organism_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "uniquename",
  { data_type => "text", is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_obsolete",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "timeaccessioned",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "timelastmodified",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</library_id>

=back

=cut

__PACKAGE__->set_primary_key("library_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<library_c1>

=over 4

=item * L</organism_id>

=item * L</uniquename>

=item * L</type_id>

=back

=cut

__PACKAGE__->add_unique_constraint("library_c1", ["organism_id", "uniquename", "type_id"]);

=head1 RELATIONS

=head2 cell_line_libraries

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CellLineLibrary>

=cut

__PACKAGE__->has_many(
  "cell_line_libraries",
  "HTML_DIR::Chado::Result::CellLineLibrary",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryContact>

=cut

__PACKAGE__->has_many(
  "library_contacts",
  "HTML_DIR::Chado::Result::LibraryContact",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryCvterm>

=cut

__PACKAGE__->has_many(
  "library_cvterms",
  "HTML_DIR::Chado::Result::LibraryCvterm",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_dbxrefs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryDbxref>

=cut

__PACKAGE__->has_many(
  "library_dbxrefs",
  "HTML_DIR::Chado::Result::LibraryDbxref",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_expressions

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryExpression>

=cut

__PACKAGE__->has_many(
  "library_expressions",
  "HTML_DIR::Chado::Result::LibraryExpression",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_features

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryFeature>

=cut

__PACKAGE__->has_many(
  "library_features",
  "HTML_DIR::Chado::Result::LibraryFeature",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_pubs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryPub>

=cut

__PACKAGE__->has_many(
  "library_pubs",
  "HTML_DIR::Chado::Result::LibraryPub",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_relationship_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryRelationship>

=cut

__PACKAGE__->has_many(
  "library_relationship_objects",
  "HTML_DIR::Chado::Result::LibraryRelationship",
  { "foreign.object_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_relationship_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryRelationship>

=cut

__PACKAGE__->has_many(
  "library_relationship_subjects",
  "HTML_DIR::Chado::Result::LibraryRelationship",
  { "foreign.subject_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_synonyms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibrarySynonym>

=cut

__PACKAGE__->has_many(
  "library_synonyms",
  "HTML_DIR::Chado::Result::LibrarySynonym",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 libraryprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Libraryprop>

=cut

__PACKAGE__->has_many(
  "libraryprops",
  "HTML_DIR::Chado::Result::Libraryprop",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "organism",
  "HTML_DIR::Chado::Result::Organism",
  { organism_id => "organism_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 stock_libraries

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockLibrary>

=cut

__PACKAGE__->has_many(
  "stock_libraries",
  "HTML_DIR::Chado::Result::StockLibrary",
  { "foreign.library_id" => "self.library_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ifLcOkCx89wdIC4qG3GfMw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
