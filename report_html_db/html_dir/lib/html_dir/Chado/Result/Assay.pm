use utf8;
package html_dir::Chado::Result::Assay;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Assay

=head1 DESCRIPTION

An assay consists of a physical instance of
an array, combined with the conditions used to create the array
(protocols, technician information). The assay can be thought of as a hybridization.

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

=head1 TABLE: C<assay>

=cut

__PACKAGE__->table("assay");

=head1 ACCESSORS

=head2 assay_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'assay_assay_id_seq'

=head2 arraydesign_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 protocol_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 assaydate

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 arrayidentifier

  data_type: 'text'
  is_nullable: 1

=head2 arraybatchidentifier

  data_type: 'text'
  is_nullable: 1

=head2 operator_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 dbxref_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "assay_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "assay_assay_id_seq",
  },
  "arraydesign_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "protocol_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "assaydate",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "arrayidentifier",
  { data_type => "text", is_nullable => 1 },
  "arraybatchidentifier",
  { data_type => "text", is_nullable => 1 },
  "operator_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</assay_id>

=back

=cut

__PACKAGE__->set_primary_key("assay_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<assay_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("assay_c1", ["name"]);

=head1 RELATIONS

=head2 acquisitions

Type: has_many

Related object: L<html_dir::Chado::Result::Acquisition>

=cut

__PACKAGE__->has_many(
  "acquisitions",
  "html_dir::Chado::Result::Acquisition",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesign

Type: belongs_to

Related object: L<html_dir::Chado::Result::Arraydesign>

=cut

__PACKAGE__->belongs_to(
  "arraydesign",
  "html_dir::Chado::Result::Arraydesign",
  { arraydesign_id => "arraydesign_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 assay_biomaterials

Type: has_many

Related object: L<html_dir::Chado::Result::AssayBiomaterial>

=cut

__PACKAGE__->has_many(
  "assay_biomaterials",
  "html_dir::Chado::Result::AssayBiomaterial",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay_projects

Type: has_many

Related object: L<html_dir::Chado::Result::AssayProject>

=cut

__PACKAGE__->has_many(
  "assay_projects",
  "html_dir::Chado::Result::AssayProject",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assayprops

Type: has_many

Related object: L<html_dir::Chado::Result::Assayprop>

=cut

__PACKAGE__->has_many(
  "assayprops",
  "html_dir::Chado::Result::Assayprop",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 controls

Type: has_many

Related object: L<html_dir::Chado::Result::Control>

=cut

__PACKAGE__->has_many(
  "controls",
  "html_dir::Chado::Result::Control",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbxref

Type: belongs_to

Related object: L<html_dir::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "html_dir::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 operator

Type: belongs_to

Related object: L<html_dir::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "operator",
  "html_dir::Chado::Result::Contact",
  { contact_id => "operator_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 protocol

Type: belongs_to

Related object: L<html_dir::Chado::Result::Protocol>

=cut

__PACKAGE__->belongs_to(
  "protocol",
  "html_dir::Chado::Result::Protocol",
  { protocol_id => "protocol_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 study_assays

Type: has_many

Related object: L<html_dir::Chado::Result::StudyAssay>

=cut

__PACKAGE__->has_many(
  "study_assays",
  "html_dir::Chado::Result::StudyAssay",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyfactorvalues

Type: has_many

Related object: L<html_dir::Chado::Result::Studyfactorvalue>

=cut

__PACKAGE__->has_many(
  "studyfactorvalues",
  "html_dir::Chado::Result::Studyfactorvalue",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5df8M3DUGpr6GOlHrC3o9w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
