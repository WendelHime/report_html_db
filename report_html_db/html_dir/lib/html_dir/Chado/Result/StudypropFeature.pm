use utf8;
package html_dir::Chado::Result::StudypropFeature;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::StudypropFeature

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

=head1 TABLE: C<studyprop_feature>

=cut

__PACKAGE__->table("studyprop_feature");

=head1 ACCESSORS

=head2 studyprop_feature_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'studyprop_feature_studyprop_feature_id_seq'

=head2 studyprop_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 feature_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "studyprop_feature_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "studyprop_feature_studyprop_feature_id_seq",
  },
  "studyprop_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "feature_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</studyprop_feature_id>

=back

=cut

__PACKAGE__->set_primary_key("studyprop_feature_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<studyprop_feature_studyprop_id_feature_id_key>

=over 4

=item * L</studyprop_id>

=item * L</feature_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "studyprop_feature_studyprop_id_feature_id_key",
  ["studyprop_id", "feature_id"],
);

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

=head2 studyprop

Type: belongs_to

Related object: L<html_dir::Chado::Result::Studyprop>

=cut

__PACKAGE__->belongs_to(
  "studyprop",
  "html_dir::Chado::Result::Studyprop",
  { studyprop_id => "studyprop_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
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
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Od58RV+167MqVEPCZ/X3sw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
