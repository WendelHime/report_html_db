use utf8;
package html_dir::Chado::Result::Control;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Control

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

=head1 TABLE: C<control>

=cut

__PACKAGE__->table("control");

=head1 ACCESSORS

=head2 control_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'control_control_id_seq'

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 assay_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 tableinfo_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 row_id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 value

  data_type: 'text'
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "control_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "control_control_id_seq",
  },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "assay_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "tableinfo_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "row_id",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</control_id>

=back

=cut

__PACKAGE__->set_primary_key("control_id");

=head1 RELATIONS

=head2 assay

Type: belongs_to

Related object: L<html_dir::Chado::Result::Assay>

=cut

__PACKAGE__->belongs_to(
  "assay",
  "html_dir::Chado::Result::Assay",
  { assay_id => "assay_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 tableinfo

Type: belongs_to

Related object: L<html_dir::Chado::Result::Tableinfo>

=cut

__PACKAGE__->belongs_to(
  "tableinfo",
  "html_dir::Chado::Result::Tableinfo",
  { tableinfo_id => "tableinfo_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 type

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ho2n8VBOvcgrCreT1umowg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
