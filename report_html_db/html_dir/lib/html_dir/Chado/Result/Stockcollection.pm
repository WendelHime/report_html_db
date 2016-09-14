use utf8;
package html_dir::Chado::Result::Stockcollection;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Stockcollection

=head1 DESCRIPTION

The lab or stock center distributing the stocks in their collection.

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

=head1 TABLE: C<stockcollection>

=cut

__PACKAGE__->table("stockcollection");

=head1 ACCESSORS

=head2 stockcollection_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'stockcollection_stockcollection_id_seq'

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

type_id is the collection type cv.

=head2 contact_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

contact_id links to the contact information for the collection.

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

name is the collection.

=head2 uniquename

  data_type: 'text'
  is_nullable: 0

uniqename is the value of the collection cv.

=cut

__PACKAGE__->add_columns(
  "stockcollection_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "stockcollection_stockcollection_id_seq",
  },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "contact_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "uniquename",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</stockcollection_id>

=back

=cut

__PACKAGE__->set_primary_key("stockcollection_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<stockcollection_c1>

=over 4

=item * L</uniquename>

=item * L</type_id>

=back

=cut

__PACKAGE__->add_unique_constraint("stockcollection_c1", ["uniquename", "type_id"]);

=head1 RELATIONS

=head2 contact

Type: belongs_to

Related object: L<html_dir::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "html_dir::Chado::Result::Contact",
  { contact_id => "contact_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 stockcollection_dbs

Type: has_many

Related object: L<html_dir::Chado::Result::StockcollectionDb>

=cut

__PACKAGE__->has_many(
  "stockcollection_dbs",
  "html_dir::Chado::Result::StockcollectionDb",
  { "foreign.stockcollection_id" => "self.stockcollection_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollection_stocks

Type: has_many

Related object: L<html_dir::Chado::Result::StockcollectionStock>

=cut

__PACKAGE__->has_many(
  "stockcollection_stocks",
  "html_dir::Chado::Result::StockcollectionStock",
  { "foreign.stockcollection_id" => "self.stockcollection_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollectionprops

Type: has_many

Related object: L<html_dir::Chado::Result::Stockcollectionprop>

=cut

__PACKAGE__->has_many(
  "stockcollectionprops",
  "html_dir::Chado::Result::Stockcollectionprop",
  { "foreign.stockcollection_id" => "self.stockcollection_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RjQri6xBbcBa5wtqpKa7nw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
