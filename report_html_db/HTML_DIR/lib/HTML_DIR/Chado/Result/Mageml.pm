use utf8;
package HTML_DIR::Chado::Result::Mageml;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Mageml

=head1 DESCRIPTION

This table is for storing extra bits of MAGEml in a denormalized form. More normalization would require many more tables.

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

=head1 TABLE: C<mageml>

=cut

__PACKAGE__->table("mageml");

=head1 ACCESSORS

=head2 mageml_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'mageml_mageml_id_seq'

=head2 mage_package

  data_type: 'text'
  is_nullable: 0

=head2 mage_ml

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "mageml_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "mageml_mageml_id_seq",
  },
  "mage_package",
  { data_type => "text", is_nullable => 0 },
  "mage_ml",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</mageml_id>

=back

=cut

__PACKAGE__->set_primary_key("mageml_id");

=head1 RELATIONS

=head2 magedocumentations

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Magedocumentation>

=cut

__PACKAGE__->has_many(
  "magedocumentations",
  "HTML_DIR::Chado::Result::Magedocumentation",
  { "foreign.mageml_id" => "self.mageml_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Eli+kfbBUNSMzAzq/Oc2iA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
