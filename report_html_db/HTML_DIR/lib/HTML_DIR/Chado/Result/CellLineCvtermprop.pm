use utf8;
package HTML_DIR::Chado::Result::CellLineCvtermprop;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::CellLineCvtermprop

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

=head1 TABLE: C<cell_line_cvtermprop>

=cut

__PACKAGE__->table("cell_line_cvtermprop");

=head1 ACCESSORS

=head2 cell_line_cvtermprop_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cell_line_cvtermprop_cell_line_cvtermprop_id_seq'

=head2 cell_line_cvterm_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "cell_line_cvtermprop_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cell_line_cvtermprop_cell_line_cvtermprop_id_seq",
  },
  "cell_line_cvterm_id",
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

=item * L</cell_line_cvtermprop_id>

=back

=cut

__PACKAGE__->set_primary_key("cell_line_cvtermprop_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cell_line_cvtermprop_c1>

=over 4

=item * L</cell_line_cvterm_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "cell_line_cvtermprop_c1",
  ["cell_line_cvterm_id", "type_id", "rank"],
);

=head1 RELATIONS

=head2 cell_line_cvterm

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::CellLineCvterm>

=cut

__PACKAGE__->belongs_to(
  "cell_line_cvterm",
  "HTML_DIR::Chado::Result::CellLineCvterm",
  { cell_line_cvterm_id => "cell_line_cvterm_id" },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cw51zoGp4MiGGdEP3jveGA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
