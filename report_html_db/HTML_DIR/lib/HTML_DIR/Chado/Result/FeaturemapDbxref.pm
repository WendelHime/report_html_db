use utf8;
package HTML_DIR::Chado::Result::FeaturemapDbxref;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::FeaturemapDbxref

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

=head1 TABLE: C<featuremap_dbxref>

=cut

__PACKAGE__->table("featuremap_dbxref");

=head1 ACCESSORS

=head2 featuremap_dbxref_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'featuremap_dbxref_featuremap_dbxref_id_seq'

=head2 featuremap_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 dbxref_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 is_current

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "featuremap_dbxref_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "featuremap_dbxref_featuremap_dbxref_id_seq",
  },
  "featuremap_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_current",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</featuremap_dbxref_id>

=back

=cut

__PACKAGE__->set_primary_key("featuremap_dbxref_id");

=head1 RELATIONS

=head2 dbxref

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "HTML_DIR::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 featuremap

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Featuremap>

=cut

__PACKAGE__->belongs_to(
  "featuremap",
  "HTML_DIR::Chado::Result::Featuremap",
  { featuremap_id => "featuremap_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CTuikOhuRa9law6e8ZYXhw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
