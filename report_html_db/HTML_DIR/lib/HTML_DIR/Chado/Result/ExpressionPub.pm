use utf8;
package HTML_DIR::Chado::Result::ExpressionPub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::ExpressionPub

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

=head1 TABLE: C<expression_pub>

=cut

__PACKAGE__->table("expression_pub");

=head1 ACCESSORS

=head2 expression_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'expression_pub_expression_pub_id_seq'

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
  "expression_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "expression_pub_expression_pub_id_seq",
  },
  "expression_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</expression_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("expression_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<expression_pub_c1>

=over 4

=item * L</expression_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("expression_pub_c1", ["expression_id", "pub_id"]);

=head1 RELATIONS

=head2 expression

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Expression>

=cut

__PACKAGE__->belongs_to(
  "expression",
  "HTML_DIR::Chado::Result::Expression",
  { expression_id => "expression_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NTnpTUB4xTsUTXZNFbi8Zg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
