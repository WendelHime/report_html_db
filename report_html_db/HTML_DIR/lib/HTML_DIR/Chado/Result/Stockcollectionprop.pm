use utf8;
package HTML_DIR::Chado::Result::Stockcollectionprop;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Stockcollectionprop

=head1 DESCRIPTION

The table stockcollectionprop
contains the value of the stock collection such as website/email URLs;
the value of the stock collection order URLs.

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

=head1 TABLE: C<stockcollectionprop>

=cut

__PACKAGE__->table("stockcollectionprop");

=head1 ACCESSORS

=head2 stockcollectionprop_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'stockcollectionprop_stockcollectionprop_id_seq'

=head2 stockcollection_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The cv for the type_id is "stockcollection property type".

=head2 value

  data_type: 'text'
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "stockcollectionprop_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "stockcollectionprop_stockcollectionprop_id_seq",
  },
  "stockcollection_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</stockcollectionprop_id>

=back

=cut

__PACKAGE__->set_primary_key("stockcollectionprop_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<stockcollectionprop_c1>

=over 4

=item * L</stockcollection_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "stockcollectionprop_c1",
  ["stockcollection_id", "type_id", "rank"],
);

=head1 RELATIONS

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

=head2 type

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:y8gt+Z7TOxhhhF7UjktJ1g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
