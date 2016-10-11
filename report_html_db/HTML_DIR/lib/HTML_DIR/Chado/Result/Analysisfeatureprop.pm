use utf8;
package HTML_DIR::Chado::Result::Analysisfeatureprop;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Analysisfeatureprop

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

=head1 TABLE: C<analysisfeatureprop>

=cut

__PACKAGE__->table("analysisfeatureprop");

=head1 ACCESSORS

=head2 analysisfeatureprop_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'analysisfeatureprop_analysisfeatureprop_id_seq'

=head2 analysisfeature_id

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
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "analysisfeatureprop_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "analysisfeatureprop_analysisfeatureprop_id_seq",
  },
  "analysisfeature_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysisfeatureprop_id>

=back

=cut

__PACKAGE__->set_primary_key("analysisfeatureprop_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<analysisfeature_id_type_id_rank>

=over 4

=item * L</analysisfeature_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "analysisfeature_id_type_id_rank",
  ["analysisfeature_id", "type_id", "rank"],
);

=head1 RELATIONS

=head2 analysisfeature

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Analysisfeature>

=cut

__PACKAGE__->belongs_to(
  "analysisfeature",
  "HTML_DIR::Chado::Result::Analysisfeature",
  { analysisfeature_id => "analysisfeature_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6ZknFj8m0wZ1RO4rLDhSxw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
