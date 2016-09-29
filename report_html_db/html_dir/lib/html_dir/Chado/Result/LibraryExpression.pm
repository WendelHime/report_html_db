use utf8;
package html_dir::Chado::Result::LibraryExpression;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::LibraryExpression - Links a library to expression statements.

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

=head1 TABLE: C<library_expression>

=cut

__PACKAGE__->table("library_expression");

=head1 ACCESSORS

=head2 library_expression_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'library_expression_library_expression_id_seq'

=head2 library_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 expression_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "library_expression_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "library_expression_library_expression_id_seq",
  },
  "library_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "expression_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</library_expression_id>

=back

=cut

__PACKAGE__->set_primary_key("library_expression_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<library_expression_c1>

=over 4

=item * L</library_id>

=item * L</expression_id>

=back

=cut

__PACKAGE__->add_unique_constraint("library_expression_c1", ["library_id", "expression_id"]);

=head1 RELATIONS

=head2 expression

Type: belongs_to

Related object: L<html_dir::Chado::Result::Expression>

=cut

__PACKAGE__->belongs_to(
  "expression",
  "html_dir::Chado::Result::Expression",
  { expression_id => "expression_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 library

Type: belongs_to

Related object: L<html_dir::Chado::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "html_dir::Chado::Result::Library",
  { library_id => "library_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 library_expressionprops

Type: has_many

Related object: L<html_dir::Chado::Result::LibraryExpressionprop>

=cut

__PACKAGE__->has_many(
  "library_expressionprops",
  "html_dir::Chado::Result::LibraryExpressionprop",
  { "foreign.library_expression_id" => "self.library_expression_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pub

Type: belongs_to

Related object: L<html_dir::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "html_dir::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pp/ZFJcY9sHB2yK0EHBiaw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
