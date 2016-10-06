use utf8;
package HTML_DIR::Chado::Result::Contactprop;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Contactprop

=head1 DESCRIPTION

A contact can have any number of slot-value property 
tags attached to it. This is an alternative to hardcoding a list of columns in the 
relational schema, and is completely extensible.

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

=head1 TABLE: C<contactprop>

=cut

__PACKAGE__->table("contactprop");

=head1 ACCESSORS

=head2 contactprop_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'contactprop_contactprop_id_seq'

=head2 contact_id

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
  "contactprop_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "contactprop_contactprop_id_seq",
  },
  "contact_id",
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

=item * L</contactprop_id>

=back

=cut

__PACKAGE__->set_primary_key("contactprop_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<contactprop_c1>

=over 4

=item * L</contact_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint("contactprop_c1", ["contact_id", "type_id", "rank"]);

=head1 RELATIONS

=head2 contact

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "HTML_DIR::Chado::Result::Contact",
  { contact_id => "contact_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8l5viFM1i/r1dEn/Xj1Ngg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
