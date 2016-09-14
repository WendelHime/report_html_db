use utf8;
package html_dir::Chado::Result::StockpropPub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::StockpropPub

=head1 DESCRIPTION

Provenance. Any stockprop assignment can optionally be supported by a publication.

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

=head1 TABLE: C<stockprop_pub>

=cut

__PACKAGE__->table("stockprop_pub");

=head1 ACCESSORS

=head2 stockprop_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'stockprop_pub_stockprop_pub_id_seq'

=head2 stockprop_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "stockprop_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "stockprop_pub_stockprop_pub_id_seq",
  },
  "stockprop_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</stockprop_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("stockprop_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<stockprop_pub_c1>

=over 4

=item * L</stockprop_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("stockprop_pub_c1", ["stockprop_id", "pub_id"]);

=head1 RELATIONS

=head2 pub

Type: belongs_to

Related object: L<html_dir::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "html_dir::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 stockprop

Type: belongs_to

Related object: L<html_dir::Chado::Result::Stockprop>

=cut

__PACKAGE__->belongs_to(
  "stockprop",
  "html_dir::Chado::Result::Stockprop",
  { stockprop_id => "stockprop_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iGY9rrtY+3Qf2F0EBbdU6w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
