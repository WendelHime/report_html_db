use utf8;
package HTML_DIR::Chado::Result::OrganismRelationship;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::OrganismRelationship

=head1 DESCRIPTION

Specifies relationships between organisms 
that are not taxonomic. For example, in breeding, relationships such as 
"sterile_with", "incompatible_with", or "fertile_with" would be appropriate. Taxonomic
relatinoships should be housed in the phylogeny tables.

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

=head1 TABLE: C<organism_relationship>

=cut

__PACKAGE__->table("organism_relationship");

=head1 ACCESSORS

=head2 organism_relationship_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'organism_relationship_organism_relationship_id_seq'

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
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "organism_relationship_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "organism_relationship_organism_relationship_id_seq",
  },
  "subject_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "object_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</organism_relationship_id>

=back

=cut

__PACKAGE__->set_primary_key("organism_relationship_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<organism_relationship_c1>

=over 4

=item * L</subject_id>

=item * L</object_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "organism_relationship_c1",
  ["subject_id", "object_id", "type_id", "rank"],
);

=head1 RELATIONS

=head2 object

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "object",
  "HTML_DIR::Chado::Result::Organism",
  { organism_id => "object_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 subject

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "subject",
  "HTML_DIR::Chado::Result::Organism",
  { organism_id => "subject_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CPgdeNSZ+RkBH/kNksLjMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
