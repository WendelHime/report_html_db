use utf8;
package html_dir::Chado::Result::PhylonodeOrganism;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::PhylonodeOrganism

=head1 DESCRIPTION

This linking table should only be used for nodes in taxonomy trees; it provides a mapping between the node and an organism. One node can have zero or one organisms, one organism can have zero or more nodes (although typically it should only have one in the standard NCBI taxonomy tree).

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

=head1 TABLE: C<phylonode_organism>

=cut

__PACKAGE__->table("phylonode_organism");

=head1 ACCESSORS

=head2 phylonode_organism_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phylonode_organism_phylonode_organism_id_seq'

=head2 phylonode_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

One phylonode cannot refer to >1 organism.

=head2 organism_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "phylonode_organism_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phylonode_organism_phylonode_organism_id_seq",
  },
  "phylonode_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "organism_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phylonode_organism_id>

=back

=cut

__PACKAGE__->set_primary_key("phylonode_organism_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phylonode_organism_phylonode_id_key>

=over 4

=item * L</phylonode_id>

=back

=cut

__PACKAGE__->add_unique_constraint("phylonode_organism_phylonode_id_key", ["phylonode_id"]);

=head1 RELATIONS

=head2 organism

Type: belongs_to

Related object: L<html_dir::Chado::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "organism",
  "html_dir::Chado::Result::Organism",
  { organism_id => "organism_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 phylonode

Type: belongs_to

Related object: L<html_dir::Chado::Result::Phylonode>

=cut

__PACKAGE__->belongs_to(
  "phylonode",
  "html_dir::Chado::Result::Phylonode",
  { phylonode_id => "phylonode_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f0lchztbINgm07OJ//jW6g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
