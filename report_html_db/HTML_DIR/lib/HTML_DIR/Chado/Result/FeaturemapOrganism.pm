use utf8;
package HTML_DIR::Chado::Result::FeaturemapOrganism;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::FeaturemapOrganism

=head1 DESCRIPTION

Links a featuremap to the organism(s) with which it is associated.

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

=head1 TABLE: C<featuremap_organism>

=cut

__PACKAGE__->table("featuremap_organism");

=head1 ACCESSORS

=head2 featuremap_organism_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'featuremap_organism_featuremap_organism_id_seq'

=head2 featuremap_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 organism_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "featuremap_organism_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "featuremap_organism_featuremap_organism_id_seq",
  },
  "featuremap_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "organism_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</featuremap_organism_id>

=back

=cut

__PACKAGE__->set_primary_key("featuremap_organism_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<featuremap_organism_c1>

=over 4

=item * L</featuremap_id>

=item * L</organism_id>

=back

=cut

__PACKAGE__->add_unique_constraint("featuremap_organism_c1", ["featuremap_id", "organism_id"]);

=head1 RELATIONS

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

=head2 organism

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "organism",
  "HTML_DIR::Chado::Result::Organism",
  { organism_id => "organism_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:C7KafMJuJEvstzNS0sFabQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
