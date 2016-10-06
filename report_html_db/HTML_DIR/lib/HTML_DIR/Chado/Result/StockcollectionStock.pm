use utf8;
package HTML_DIR::Chado::Result::StockcollectionStock;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::StockcollectionStock

=head1 DESCRIPTION

stockcollection_stock links
a stock collection to the stocks which are contained in the collection.

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

=head1 TABLE: C<stockcollection_stock>

=cut

__PACKAGE__->table("stockcollection_stock");

=head1 ACCESSORS

=head2 stockcollection_stock_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'stockcollection_stock_stockcollection_stock_id_seq'

=head2 stockcollection_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 stock_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "stockcollection_stock_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "stockcollection_stock_stockcollection_stock_id_seq",
  },
  "stockcollection_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "stock_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</stockcollection_stock_id>

=back

=cut

__PACKAGE__->set_primary_key("stockcollection_stock_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<stockcollection_stock_c1>

=over 4

=item * L</stockcollection_id>

=item * L</stock_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "stockcollection_stock_c1",
  ["stockcollection_id", "stock_id"],
);

=head1 RELATIONS

=head2 stock

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Stock>

=cut

__PACKAGE__->belongs_to(
  "stock",
  "HTML_DIR::Chado::Result::Stock",
  { stock_id => "stock_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 stockcollection

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Stockcollection>

=cut

__PACKAGE__->belongs_to(
  "stockcollection",
  "HTML_DIR::Chado::Result::Stockcollection",
  { stockcollection_id => "stockcollection_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gS7R54SS+NHTctB6zZGqaQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
