use utf8;
package HTML_DIR::Chado::Result::CvtermDbxref;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::CvtermDbxref

=head1 DESCRIPTION

In addition to the primary
identifier (cvterm.dbxref_id) a cvterm can have zero or more secondary
identifiers/dbxrefs, which may refer to records in external
databases. The exact semantics of cvterm_dbxref are not fixed. For
example: the dbxref could be a pubmed ID that is pertinent to the
cvterm, or it could be an equivalent or similar term in another
ontology. For example, GO cvterms are typically linked to InterPro
IDs, even though the nature of the relationship between them is
largely one of statistical association. The dbxref may be have data
records attached in the same database instance, or it could be a
"hanging" dbxref pointing to some external database. NOTE: If the
desired objective is to link two cvterms together, and the nature of
the relation is known and holds for all instances of the subject
cvterm then consider instead using cvterm_relationship together with a
well-defined relation.

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

=head1 TABLE: C<cvterm_dbxref>

=cut

__PACKAGE__->table("cvterm_dbxref");

=head1 ACCESSORS

=head2 cvterm_dbxref_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cvterm_dbxref_cvterm_dbxref_id_seq'

=head2 cvterm_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 dbxref_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 is_for_definition

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

A
cvterm.definition should be supported by one or more references. If
this column is true, the dbxref is not for a term in an external database -
it is a dbxref for provenance information for the definition.

=cut

__PACKAGE__->add_columns(
  "cvterm_dbxref_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cvterm_dbxref_cvterm_dbxref_id_seq",
  },
  "cvterm_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_for_definition",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cvterm_dbxref_id>

=back

=cut

__PACKAGE__->set_primary_key("cvterm_dbxref_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cvterm_dbxref_c1>

=over 4

=item * L</cvterm_id>

=item * L</dbxref_id>

=back

=cut

__PACKAGE__->add_unique_constraint("cvterm_dbxref_c1", ["cvterm_id", "dbxref_id"]);

=head1 RELATIONS

=head2 cvterm

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "cvterm",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "cvterm_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 dbxref

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "HTML_DIR::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/KdzS/nu+vTA1qat+G69RA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
