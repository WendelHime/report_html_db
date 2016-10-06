use utf8;
package HTML_DIR::Chado::Result::PhylotreePub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::PhylotreePub

=head1 DESCRIPTION

Tracks citations global to the tree e.g. multiple sequence alignment supporting tree construction.

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

=head1 TABLE: C<phylotree_pub>

=cut

__PACKAGE__->table("phylotree_pub");

=head1 ACCESSORS

=head2 phylotree_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phylotree_pub_phylotree_pub_id_seq'

=head2 phylotree_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "phylotree_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phylotree_pub_phylotree_pub_id_seq",
  },
  "phylotree_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phylotree_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("phylotree_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phylotree_pub_phylotree_id_key>

=over 4

=item * L</phylotree_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("phylotree_pub_phylotree_id_key", ["phylotree_id", "pub_id"]);

=head1 RELATIONS

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

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VtDx73GcjYKbFcGX93wk2A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
