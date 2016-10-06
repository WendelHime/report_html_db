use utf8;
package HTML_DIR::Chado::Result::Contact;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Contact - Model persons, institutes, groups, organizations, etc.

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

Related object: L<HTML_DIR::Chado::Result::Arraydesign>

=cut

__PACKAGE__->has_many(
  "arraydesigns",
  "HTML_DIR::Chado::Result::Arraydesign",
  { "foreign.manufacturer_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assays

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Assay>

=cut

__PACKAGE__->has_many(
  "assays",
  "HTML_DIR::Chado::Result::Assay",
  { "foreign.operator_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterials

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Biomaterial>

=cut

__PACKAGE__->has_many(
  "biomaterials",
  "HTML_DIR::Chado::Result::Biomaterial",
  { "foreign.biosourceprovider_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contact_relationship_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ContactRelationship>

=cut

__PACKAGE__->has_many(
  "contact_relationship_objects",
  "HTML_DIR::Chado::Result::ContactRelationship",
  { "foreign.object_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contact_relationship_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ContactRelationship>

=cut

__PACKAGE__->has_many(
  "contact_relationship_subjects",
  "HTML_DIR::Chado::Result::ContactRelationship",
  { "foreign.subject_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contactprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Contactprop>

=cut

__PACKAGE__->has_many(
  "contactprops",
  "HTML_DIR::Chado::Result::Contactprop",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureContact>

=cut

__PACKAGE__->has_many(
  "feature_contacts",
  "HTML_DIR::Chado::Result::FeatureContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremap_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeaturemapContact>

=cut

__PACKAGE__->has_many(
  "featuremap_contacts",
  "HTML_DIR::Chado::Result::FeaturemapContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryContact>

=cut

__PACKAGE__->has_many(
  "library_contacts",
  "HTML_DIR::Chado::Result::LibraryContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentContact>

=cut

__PACKAGE__->has_many(
  "nd_experiment_contacts",
  "HTML_DIR::Chado::Result::NdExperimentContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ProjectContact>

=cut

__PACKAGE__->has_many(
  "project_contacts",
  "HTML_DIR::Chado::Result::ProjectContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pubauthor_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PubauthorContact>

=cut

__PACKAGE__->has_many(
  "pubauthor_contacts",
  "HTML_DIR::Chado::Result::PubauthorContact",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantifications

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Quantification>

=cut

__PACKAGE__->has_many(
  "quantifications",
  "HTML_DIR::Chado::Result::Quantification",
  { "foreign.operator_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollections

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Stockcollection>

=cut

__PACKAGE__->has_many(
  "stockcollections",
  "HTML_DIR::Chado::Result::Stockcollection",
  { "foreign.contact_id" => "self.contact_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studies

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Study>

=cut

__PACKAGE__->has_many(
  "studies",
  "HTML_DIR::Chado::Result::Study",
  { "foreign.contact_id" => "self.contact_id" },
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
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eotV/xqxEg59gGpdjE25lA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
