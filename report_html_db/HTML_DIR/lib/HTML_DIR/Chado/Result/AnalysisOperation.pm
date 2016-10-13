use utf8;
package HTML_DIR::Chado::Result::AnalysisOperation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::AnalysisOperation

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

=head1 TABLE: C<analysis_operation>

=cut

__PACKAGE__->table("analysis_operation");

=head1 ACCESSORS

=head2 analysis_operation_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_operation_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "analysis_operation_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "type_operation_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_operation_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_operation_id");

=head1 RELATIONS

=head2 analysis_operation

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Analysis>

=cut

__PACKAGE__->belongs_to(
  "analysis_operation",
  "HTML_DIR::Chado::Result::Analysis",
  { analysis_id => "analysis_operation_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 type_operation

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type_operation",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "type_operation_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:O0eaG9O6mi9Om3BNboK0Lg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
