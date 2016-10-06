use utf8;
package HTML_DIR::Chado::Result::StockRelationshipPub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::StockRelationshipPub

=head1 DESCRIPTION

Provenance. Attach optional evidence to a stock_relationship in the form of a publication.

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

=head1 TABLE: C<stock_relationship_pub>

=cut

__PACKAGE__->table("stock_relationship_pub");

=head1 ACCESSORS

=head2 stock_relationship_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'stock_relationship_pub_stock_relationship_pub_id_seq'

=head2 stock_relationship_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "stock_relationship_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "stock_relationship_pub_stock_relationship_pub_id_seq",
  },
  "stock_relationship_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</stock_relationship_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("stock_relationship_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<stock_relationship_pub_c1>

=over 4

=item * L</stock_relationship_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "stock_relationship_pub_c1",
  ["stock_relationship_id", "pub_id"],
);

=head1 RELATIONS

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 stock_relationship

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::StockRelationship>

=cut

__PACKAGE__->belongs_to(
  "stock_relationship",
  "HTML_DIR::Chado::Result::StockRelationship",
  { stock_relationship_id => "stock_relationship_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fVYORbojBSteNG1ToQmx3w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
