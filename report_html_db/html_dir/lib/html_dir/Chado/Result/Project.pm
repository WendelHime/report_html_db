use utf8;
package html_dir::Chado::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Project - Standard Chado flexible property table for projects.

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

=head1 TABLE: C<project>

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 project_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_project_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "project_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "project_project_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</project_id>

=back

=cut

__PACKAGE__->set_primary_key("project_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<project_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("project_c1", ["name"]);

=head1 RELATIONS

=head2 assay_projects

Type: has_many

Related object: L<html_dir::Chado::Result::AssayProject>

=cut

__PACKAGE__->has_many(
  "assay_projects",
  "html_dir::Chado::Result::AssayProject",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_projects

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentProject>

=cut

__PACKAGE__->has_many(
  "nd_experiment_projects",
  "html_dir::Chado::Result::NdExperimentProject",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_analyses

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectAnalysis>

=cut

__PACKAGE__->has_many(
  "project_analyses",
  "html_dir::Chado::Result::ProjectAnalysis",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_contacts

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectContact>

=cut

__PACKAGE__->has_many(
  "project_contacts",
  "html_dir::Chado::Result::ProjectContact",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_dbxrefs

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectDbxref>

=cut

__PACKAGE__->has_many(
  "project_dbxrefs",
  "html_dir::Chado::Result::ProjectDbxref",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_features

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectFeature>

=cut

__PACKAGE__->has_many(
  "project_features",
  "html_dir::Chado::Result::ProjectFeature",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_pubs

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectPub>

=cut

__PACKAGE__->has_many(
  "project_pubs",
  "html_dir::Chado::Result::ProjectPub",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_relationship_object_projects

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectRelationship>

=cut

__PACKAGE__->has_many(
  "project_relationship_object_projects",
  "html_dir::Chado::Result::ProjectRelationship",
  { "foreign.object_project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_relationship_subject_projects

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectRelationship>

=cut

__PACKAGE__->has_many(
  "project_relationship_subject_projects",
  "html_dir::Chado::Result::ProjectRelationship",
  { "foreign.subject_project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_stocks

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectStock>

=cut

__PACKAGE__->has_many(
  "project_stocks",
  "html_dir::Chado::Result::ProjectStock",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projectprops

Type: has_many

Related object: L<html_dir::Chado::Result::Projectprop>

=cut

__PACKAGE__->has_many(
  "projectprops",
  "html_dir::Chado::Result::Projectprop",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:S5vPN8hnfKhSwb6Uwle8ew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
