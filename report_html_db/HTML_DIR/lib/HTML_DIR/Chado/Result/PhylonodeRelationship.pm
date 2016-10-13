use utf8;
package HTML_DIR::Chado::Result::PhylonodeRelationship;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::PhylonodeRelationship

=head1 DESCRIPTION

This is for 
relationships that are not strictly hierarchical; for example,
horizontal gene transfer. Most phylogenetic trees are strictly
hierarchical, nevertheless it is here for completeness.

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

=head1 TABLE: C<phylonode_relationship>

=cut

__PACKAGE__->table("phylonode_relationship");

=head1 ACCESSORS

=head2 phylonode_relationship_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phylonode_relationship_phylonode_relationship_id_seq'

=head2 subject_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 object_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'integer'
  is_nullable: 1

=head2 phylotree_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "phylonode_relationship_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phylonode_relationship_phylonode_relationship_id_seq",
  },
  "subject_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "object_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "integer", is_nullable => 1 },
  "phylotree_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phylonode_relationship_id>

=back

=cut

__PACKAGE__->set_primary_key("phylonode_relationship_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phylonode_relationship_subject_id_key>

=over 4

=item * L</subject_id>

=item * L</object_id>

=item * L</type_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "phylonode_relationship_subject_id_key",
  ["subject_id", "object_id", "type_id"],
);

=head1 RELATIONS

=head2 object

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Phylonode>

=cut

__PACKAGE__->belongs_to(
  "object",
  "HTML_DIR::Chado::Result::Phylonode",
  { phylonode_id => "object_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 phylotree

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Phylotree>

=cut

__PACKAGE__->belongs_to(
  "phylotree",
  "HTML_DIR::Chado::Result::Phylotree",
  { phylotree_id => "phylotree_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 subject

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Phylonode>

=cut

__PACKAGE__->belongs_to(
  "subject",
  "HTML_DIR::Chado::Result::Phylonode",
  { phylonode_id => "subject_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 type

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+hUtZquv1/TtjaYKt/m6CQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
