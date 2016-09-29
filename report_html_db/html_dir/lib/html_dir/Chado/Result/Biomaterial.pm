use utf8;
package html_dir::Chado::Result::Biomaterial;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Biomaterial

=head1 DESCRIPTION

A biomaterial represents the MAGE concept of BioSource, BioSample, and LabeledExtract. It is essentially some biological material (tissue, cells, serum) that may have been processed. Processed biomaterials should be traceable back to raw biomaterials via the biomaterialrelationship table.

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

=head1 TABLE: C<biomaterial>

=cut

__PACKAGE__->table("biomaterial");

=head1 ACCESSORS

=head2 biomaterial_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'biomaterial_biomaterial_id_seq'

=head2 taxon_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 biosourceprovider_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

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
  "biomaterial_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "biomaterial_biomaterial_id_seq",
  },
  "taxon_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "biosourceprovider_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</biomaterial_id>

=back

=cut

__PACKAGE__->set_primary_key("biomaterial_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<biomaterial_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("biomaterial_c1", ["name"]);

=head1 RELATIONS

=head2 assay_biomaterials

Type: has_many

Related object: L<html_dir::Chado::Result::AssayBiomaterial>

=cut

__PACKAGE__->has_many(
  "assay_biomaterials",
  "html_dir::Chado::Result::AssayBiomaterial",
  { "foreign.biomaterial_id" => "self.biomaterial_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_dbxrefs

Type: has_many

Related object: L<html_dir::Chado::Result::BiomaterialDbxref>

=cut

__PACKAGE__->has_many(
  "biomaterial_dbxrefs",
  "html_dir::Chado::Result::BiomaterialDbxref",
  { "foreign.biomaterial_id" => "self.biomaterial_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_relationship_objects

Type: has_many

Related object: L<html_dir::Chado::Result::BiomaterialRelationship>

=cut

__PACKAGE__->has_many(
  "biomaterial_relationship_objects",
  "html_dir::Chado::Result::BiomaterialRelationship",
  { "foreign.object_id" => "self.biomaterial_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_relationship_subjects

Type: has_many

Related object: L<html_dir::Chado::Result::BiomaterialRelationship>

=cut

__PACKAGE__->has_many(
  "biomaterial_relationship_subjects",
  "html_dir::Chado::Result::BiomaterialRelationship",
  { "foreign.subject_id" => "self.biomaterial_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_treatments

Type: has_many

Related object: L<html_dir::Chado::Result::BiomaterialTreatment>

=cut

__PACKAGE__->has_many(
  "biomaterial_treatments",
  "html_dir::Chado::Result::BiomaterialTreatment",
  { "foreign.biomaterial_id" => "self.biomaterial_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterialprops

Type: has_many

Related object: L<html_dir::Chado::Result::Biomaterialprop>

=cut

__PACKAGE__->has_many(
  "biomaterialprops",
  "html_dir::Chado::Result::Biomaterialprop",
  { "foreign.biomaterial_id" => "self.biomaterial_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biosourceprovider

Type: belongs_to

Related object: L<html_dir::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "biosourceprovider",
  "html_dir::Chado::Result::Contact",
  { contact_id => "biosourceprovider_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
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

=head2 taxon

Type: belongs_to

Related object: L<html_dir::Chado::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "taxon",
  "html_dir::Chado::Result::Organism",
  { organism_id => "taxon_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 treatments

Type: has_many

Related object: L<html_dir::Chado::Result::Treatment>

=cut

__PACKAGE__->has_many(
  "treatments",
  "html_dir::Chado::Result::Treatment",
  { "foreign.biomaterial_id" => "self.biomaterial_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gIYAbSa8fruQdQeVlLX2PA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
