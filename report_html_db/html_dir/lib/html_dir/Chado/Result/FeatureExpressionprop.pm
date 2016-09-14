use utf8;
package html_dir::Chado::Result::FeatureExpressionprop;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::FeatureExpressionprop

=head1 DESCRIPTION

Extensible properties for
feature_expression (comments, for example). Modeled on feature_cvtermprop.

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

=head1 TABLE: C<feature_expressionprop>

=cut

__PACKAGE__->table("feature_expressionprop");

=head1 ACCESSORS

=head2 feature_expressionprop_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'feature_expressionprop_feature_expressionprop_id_seq'

=head2 feature_expression_id

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
  "feature_expressionprop_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "feature_expressionprop_feature_expressionprop_id_seq",
  },
  "feature_expression_id",
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

=item * L</feature_expressionprop_id>

=back

=cut

__PACKAGE__->set_primary_key("feature_expressionprop_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<feature_expressionprop_c1>

=over 4

=item * L</feature_expression_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "feature_expressionprop_c1",
  ["feature_expression_id", "type_id", "rank"],
);

=head1 RELATIONS

=head2 feature_expression

Type: belongs_to

Related object: L<html_dir::Chado::Result::FeatureExpression>

=cut

__PACKAGE__->belongs_to(
  "feature_expression",
  "html_dir::Chado::Result::FeatureExpression",
  { feature_expression_id => "feature_expression_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hywW9bb6ya2djHTBvQPh/w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
