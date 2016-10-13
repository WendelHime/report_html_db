use utf8;
package HTML_DIR::Chado::Result::AssayBiomaterial;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::AssayBiomaterial

=head1 DESCRIPTION

A biomaterial can be hybridized many times (technical replicates), or combined with other biomaterials in a single hybridization (for two-channel arrays).

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

=head1 TABLE: C<assay_biomaterial>

=cut

__PACKAGE__->table("assay_biomaterial");

=head1 ACCESSORS

=head2 assay_biomaterial_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'assay_biomaterial_assay_biomaterial_id_seq'

=head2 assay_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 biomaterial_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 channel_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "assay_biomaterial_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "assay_biomaterial_assay_biomaterial_id_seq",
  },
  "assay_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "biomaterial_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "channel_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</assay_biomaterial_id>

=back

=cut

__PACKAGE__->set_primary_key("assay_biomaterial_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<assay_biomaterial_c1>

=over 4

=item * L</assay_id>

=item * L</biomaterial_id>

=item * L</channel_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "assay_biomaterial_c1",
  ["assay_id", "biomaterial_id", "channel_id", "rank"],
);

=head1 RELATIONS

=head2 assay

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Assay>

=cut

__PACKAGE__->belongs_to(
  "assay",
  "HTML_DIR::Chado::Result::Assay",
  { assay_id => "assay_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 biomaterial

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Biomaterial>

=cut

__PACKAGE__->belongs_to(
  "biomaterial",
  "HTML_DIR::Chado::Result::Biomaterial",
  { biomaterial_id => "biomaterial_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 channel

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Channel>

=cut

__PACKAGE__->belongs_to(
  "channel",
  "HTML_DIR::Chado::Result::Channel",
  { channel_id => "channel_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:L1yUqkJMXaGGIv4hn4rLpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
