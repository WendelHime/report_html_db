use utf8;
package html_dir::Chado::Result::ProjectFeature;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::ProjectFeature

=head1 DESCRIPTION

This table is intended associate records in the feature table with a project.

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

=head1 TABLE: C<project_feature>

=cut

__PACKAGE__->table("project_feature");

=head1 ACCESSORS

=head2 project_feature_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_feature_project_feature_id_seq'

=head2 feature_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 project_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "project_feature_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "project_feature_project_feature_id_seq",
  },
  "feature_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "project_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</project_feature_id>

=back

=cut

__PACKAGE__->set_primary_key("project_feature_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<project_feature_c1>

=over 4

=item * L</feature_id>

=item * L</project_id>

=back

=cut

__PACKAGE__->add_unique_constraint("project_feature_c1", ["feature_id", "project_id"]);

=head1 RELATIONS

=head2 feature

Type: belongs_to

Related object: L<html_dir::Chado::Result::Feature>

=cut

__PACKAGE__->belongs_to(
  "feature",
  "html_dir::Chado::Result::Feature",
  { feature_id => "feature_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 project

Type: belongs_to

Related object: L<html_dir::Chado::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "html_dir::Chado::Result::Project",
  { project_id => "project_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZR0G+mmbHPhR7jsLCNpSPg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
