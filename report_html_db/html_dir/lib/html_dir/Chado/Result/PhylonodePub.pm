use utf8;
package html_dir::Chado::Result::PhylonodePub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::PhylonodePub

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

=head1 TABLE: C<phylonode_pub>

=cut

__PACKAGE__->table("phylonode_pub");

=head1 ACCESSORS

=head2 phylonode_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phylonode_pub_phylonode_pub_id_seq'

=head2 phylonode_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "phylonode_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phylonode_pub_phylonode_pub_id_seq",
  },
  "phylonode_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phylonode_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("phylonode_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phylonode_pub_phylonode_id_key>

=over 4

=item * L</phylonode_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("phylonode_pub_phylonode_id_key", ["phylonode_id", "pub_id"]);

=head1 RELATIONS

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

=head2 pub

Type: belongs_to

Related object: L<html_dir::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "html_dir::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:W6YnlQ2IE30s9x2BgXJgmQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
