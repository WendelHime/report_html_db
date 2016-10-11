use utf8;
package HTML_DIR::Chado::Result::Featuremap;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Featuremap

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

=head1 TABLE: C<featuremap>

=cut

__PACKAGE__->table("featuremap");

=head1 ACCESSORS

=head2 featuremap_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'featuremap_featuremap_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 unittype_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "featuremap_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "featuremap_featuremap_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "unittype_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</featuremap_id>

=back

=cut

__PACKAGE__->set_primary_key("featuremap_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<featuremap_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("featuremap_c1", ["name"]);

=head1 RELATIONS

=head2 featuremap_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeaturemapContact>

=cut

__PACKAGE__->has_many(
  "featuremap_contacts",
  "HTML_DIR::Chado::Result::FeaturemapContact",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremap_dbxrefs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeaturemapDbxref>

=cut

__PACKAGE__->has_many(
  "featuremap_dbxrefs",
  "HTML_DIR::Chado::Result::FeaturemapDbxref",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremap_organisms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeaturemapOrganism>

=cut

__PACKAGE__->has_many(
  "featuremap_organisms",
  "HTML_DIR::Chado::Result::FeaturemapOrganism",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremap_pubs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeaturemapPub>

=cut

__PACKAGE__->has_many(
  "featuremap_pubs",
  "HTML_DIR::Chado::Result::FeaturemapPub",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremapprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Featuremapprop>

=cut

__PACKAGE__->has_many(
  "featuremapprops",
  "HTML_DIR::Chado::Result::Featuremapprop",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featurepos

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Featurepo>

=cut

__PACKAGE__->has_many(
  "featurepos",
  "HTML_DIR::Chado::Result::Featurepo",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featureranges

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Featurerange>

=cut

__PACKAGE__->has_many(
  "featureranges",
  "HTML_DIR::Chado::Result::Featurerange",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_featuremaps

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockFeaturemap>

=cut

__PACKAGE__->has_many(
  "stock_featuremaps",
  "HTML_DIR::Chado::Result::StockFeaturemap",
  { "foreign.featuremap_id" => "self.featuremap_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 unittype

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "unittype",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "unittype_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ndGOhMEOdUCJpMRSlYYJww


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
