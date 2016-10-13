use utf8;
package HTML_DIR::Chado::Result::Synonym;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Synonym

=head1 DESCRIPTION

A synonym for a feature. One feature can have multiple synonyms, and the same synonym can apply to multiple features.

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

=head1 TABLE: C<synonym>

=cut

__PACKAGE__->table("synonym");

=head1 ACCESSORS

=head2 synonym_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'synonym_synonym_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The synonym itself. Should be human-readable machine-searchable ascii text.

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

Types would be symbol and fullname for now.

=head2 synonym_sgml

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The fully specified synonym, with any non-ascii characters encoded in SGML.

=cut

__PACKAGE__->add_columns(
  "synonym_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "synonym_synonym_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "synonym_sgml",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</synonym_id>

=back

=cut

__PACKAGE__->set_primary_key("synonym_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<synonym_c1>

=over 4

=item * L</name>

=item * L</type_id>

=back

=cut

__PACKAGE__->add_unique_constraint("synonym_c1", ["name", "type_id"]);

=head1 RELATIONS

=head2 cell_line_synonyms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CellLineSynonym>

=cut

__PACKAGE__->has_many(
  "cell_line_synonyms",
  "HTML_DIR::Chado::Result::CellLineSynonym",
  { "foreign.synonym_id" => "self.synonym_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_synonyms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureSynonym>

=cut

__PACKAGE__->has_many(
  "feature_synonyms",
  "HTML_DIR::Chado::Result::FeatureSynonym",
  { "foreign.synonym_id" => "self.synonym_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_synonyms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibrarySynonym>

=cut

__PACKAGE__->has_many(
  "library_synonyms",
  "HTML_DIR::Chado::Result::LibrarySynonym",
  { "foreign.synonym_id" => "self.synonym_id" },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XFH9AOFBl+e2qVOC9r2P+Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
