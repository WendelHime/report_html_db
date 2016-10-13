use utf8;
package HTML_DIR::Chado::Result::OrganismCvtermprop;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::OrganismCvtermprop

=head1 DESCRIPTION

Extensible properties for
organism to cvterm associations. Examples: qualifiers

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

=head1 TABLE: C<organism_cvtermprop>

=cut

__PACKAGE__->table("organism_cvtermprop");

=head1 ACCESSORS

=head2 organism_cvtermprop_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'organism_cvtermprop_organism_cvtermprop_id_seq'

=head2 organism_cvterm_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The name of the
property/slot is a cvterm. The meaning of the property is defined in
that cvterm. 

=head2 value

  data_type: 'text'
  is_nullable: 1

The value of the
property, represented as text. Numeric values are converted to their
text representation. This is less efficient than using native database
types, but is easier to query.

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

Property-Value
ordering. Any organism_cvterm can have multiple values for any particular
property type - these are ordered in a list using rank, counting from
zero. For properties that are single-valued rather than multi-valued,
the default 0 value should be used

=cut

__PACKAGE__->add_columns(
  "organism_cvtermprop_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "organism_cvtermprop_organism_cvtermprop_id_seq",
  },
  "organism_cvterm_id",
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

=item * L</organism_cvtermprop_id>

=back

=cut

__PACKAGE__->set_primary_key("organism_cvtermprop_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<organism_cvtermprop_c1>

=over 4

=item * L</organism_cvterm_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "organism_cvtermprop_c1",
  ["organism_cvterm_id", "type_id", "rank"],
);

=head1 RELATIONS

=head2 organism_cvterm

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::OrganismCvterm>

=cut

__PACKAGE__->belongs_to(
  "organism_cvterm",
  "HTML_DIR::Chado::Result::OrganismCvterm",
  { organism_cvterm_id => "organism_cvterm_id" },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gAyArM0f32hLUkTJbc9y0A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;