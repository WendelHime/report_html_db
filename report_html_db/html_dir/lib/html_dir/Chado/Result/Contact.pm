use utf8;
package html_dir::Chado::Result::Contact;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Contact - Model persons, institutes, groups, organizations, etc.

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

=head1 TABLE: C<contact>

=cut

__PACKAGE__->table("contact");

=head1 ACCESSORS

=head2 contact_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'contact_contact_id_seq'

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

What type of contact is this?  E.g. "person", "lab".

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "contact_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "contact_contact_id_seq",
  },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</contact_id>

=back

=cut

__PACKAGE__->set_primary_key("contact_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<contact_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("contact_c1", ["name"]);

=head1 RELATIONS

=head2 arraydesigns

Type: has_many

Related object: L<html_dir::Chado::Result::Arraydesign>

=cut

__PACKAGE__->has_many(
  "arraydesigns",
  "html_dir::Chado::Result::Arraydesign",
  { "foreign.manufacturer_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assays

Type: has_many

Related object: L<html_dir::Chado::Result::Assay>

=cut

__PACKAGE__->has_many(
  "assays",
  "html_dir::Chado::Result::Assay",
  { "foreign.operator_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterials

Type: has_many

Related object: L<html_dir::Chado::Result::Biomaterial>

=cut

__PACKAGE__->has_many(
  "biomaterials",
  "html_dir::Chado::Result::Biomaterial",
  { "foreign.biosourceprovider_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contact_relationship_objects

Type: has_many

Related object: L<html_dir::Chado::Result::ContactRelationship>

=cut

__PACKAGE__->has_many(
  "contact_relationship_objects",
  "html_dir::Chado::Result::ContactRelationship",
  { "foreign.object_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contact_relationship_subjects

Type: has_many

Related object: L<html_dir::Chado::Result::ContactRelationship>

=cut

__PACKAGE__->has_many(
  "contact_relationship_subjects",
  "html_dir::Chado::Result::ContactRelationship",
  { "foreign.subject_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contactprops

Type: has_many

Related object: L<html_dir::Chado::Result::Contactprop>

=cut

__PACKAGE__->has_many(
  "contactprops",
  "html_dir::Chado::Result::Contactprop",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_contacts

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureContact>

=cut

__PACKAGE__->has_many(
  "feature_contacts",
  "html_dir::Chado::Result::FeatureContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremap_contacts

Type: has_many

Related object: L<html_dir::Chado::Result::FeaturemapContact>

=cut

__PACKAGE__->has_many(
  "featuremap_contacts",
  "html_dir::Chado::Result::FeaturemapContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_contacts

Type: has_many

Related object: L<html_dir::Chado::Result::LibraryContact>

=cut

__PACKAGE__->has_many(
  "library_contacts",
  "html_dir::Chado::Result::LibraryContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_contacts

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentContact>

=cut

__PACKAGE__->has_many(
  "nd_experiment_contacts",
  "html_dir::Chado::Result::NdExperimentContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_contacts

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectContact>

=cut

__PACKAGE__->has_many(
  "project_contacts",
  "html_dir::Chado::Result::ProjectContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pubauthor_contacts

Type: has_many

Related object: L<html_dir::Chado::Result::PubauthorContact>

=cut

__PACKAGE__->has_many(
  "pubauthor_contacts",
  "html_dir::Chado::Result::PubauthorContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantifications

Type: has_many

Related object: L<html_dir::Chado::Result::Quantification>

=cut

__PACKAGE__->has_many(
  "quantifications",
  "html_dir::Chado::Result::Quantification",
  { "foreign.operator_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollections

Type: has_many

Related object: L<html_dir::Chado::Result::Stockcollection>

=cut

__PACKAGE__->has_many(
  "stockcollections",
  "html_dir::Chado::Result::Stockcollection",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studies

Type: has_many

Related object: L<html_dir::Chado::Result::Study>

=cut

__PACKAGE__->has_many(
  "studies",
  "html_dir::Chado::Result::Study",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6lGXWubb62v38HUSSbwT1g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
