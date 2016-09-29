use utf8;
package html_dir::Chado::Result::Operation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Operation

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

=head1 TABLE: C<operation>

=cut

__PACKAGE__->table("operation");

=head1 ACCESSORS

=head2 operation_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'operation_operation_id_seq'

=head2 analysis_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "operation_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "operation_operation_id_seq",
  },
  "analysis_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</operation_id>

=back

=cut

__PACKAGE__->set_primary_key("operation_id");

=head1 RELATIONS

=head2 analysis

Type: belongs_to

Related object: L<html_dir::Chado::Result::Analysis>

=cut

__PACKAGE__->belongs_to(
  "analysis",
  "html_dir::Chado::Result::Analysis",
  { analysis_id => "analysis_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 filterings

Type: has_many

Related object: L<html_dir::Chado::Result::Filtering>

=cut

__PACKAGE__->has_many(
  "filterings",
  "html_dir::Chado::Result::Filtering",
  { "foreign.operation_id" => "self.operation_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 maskings

Type: has_many

Related object: L<html_dir::Chado::Result::Masking>

=cut

__PACKAGE__->has_many(
  "maskings",
  "html_dir::Chado::Result::Masking",
  { "foreign.operation_id" => "self.operation_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 trimmings

Type: has_many

Related object: L<html_dir::Chado::Result::Trimming>

=cut

__PACKAGE__->has_many(
  "trimmings",
  "html_dir::Chado::Result::Trimming",
  { "foreign.operation_id" => "self.operation_id" },
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
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N61S4RcF+x/JkDPWcSJ7sQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
