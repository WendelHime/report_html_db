use utf8;
package html_dir::Chado::Result::CellLineDbxref;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::CellLineDbxref

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

=head1 TABLE: C<cell_line_dbxref>

=cut

__PACKAGE__->table("cell_line_dbxref");

=head1 ACCESSORS

=head2 cell_line_dbxref_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cell_line_dbxref_cell_line_dbxref_id_seq'

=head2 cell_line_id

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
  "cell_line_dbxref_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cell_line_dbxref_cell_line_dbxref_id_seq",
  },
  "cell_line_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_current",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cell_line_dbxref_id>

=back

=cut

__PACKAGE__->set_primary_key("cell_line_dbxref_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cell_line_dbxref_c1>

=over 4

=item * L</cell_line_id>

=item * L</dbxref_id>

=back

=cut

__PACKAGE__->add_unique_constraint("cell_line_dbxref_c1", ["cell_line_id", "dbxref_id"]);

=head1 RELATIONS

=head2 cell_line

Type: belongs_to

Related object: L<html_dir::Chado::Result::CellLine>

=cut

__PACKAGE__->belongs_to(
  "cell_line",
  "html_dir::Chado::Result::CellLine",
  { cell_line_id => "cell_line_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 dbxref

Type: belongs_to

Related object: L<html_dir::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "html_dir::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ooyFse5IU0jgDtqZgna9dQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
