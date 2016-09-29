use utf8;
package html_dir::Chado::Result::OrganismPub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::OrganismPub - Attribution for organism.

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

=head1 TABLE: C<organism_pub>

=cut

__PACKAGE__->table("organism_pub");

=head1 ACCESSORS

=head2 organism_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'organism_pub_organism_pub_id_seq'

=head2 organism_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "organism_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "organism_pub_organism_pub_id_seq",
  },
  "organism_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</organism_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("organism_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<organism_pub_c1>

=over 4

=item * L</organism_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("organism_pub_c1", ["organism_id", "pub_id"]);

=head1 RELATIONS

=head2 organism

Type: belongs_to

Related object: L<html_dir::Chado::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "organism",
  "html_dir::Chado::Result::Organism",
  { organism_id => "organism_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pub

Type: belongs_to

Related object: L<html_dir::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "html_dir::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZCDVHvPhoLO0kDJ3pinW/A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
