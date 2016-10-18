use utf8;
package HTML_DIR::Chado::Result::Eimage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Eimage

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

=head1 TABLE: C<eimage>

=cut

__PACKAGE__->table("eimage");

=head1 ACCESSORS

=head2 eimage_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'eimage_eimage_id_seq'

=head2 eimage_data

  data_type: 'text'
  is_nullable: 1

We expect images in eimage_data (e.g. JPEGs) to be uuencoded.

=head2 eimage_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Describes the type of data in eimage_data.

=head2 image_uri

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "eimage_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "eimage_eimage_id_seq",
  },
  "eimage_data",
  { data_type => "text", is_nullable => 1 },
  "eimage_type",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "image_uri",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</eimage_id>

=back

=cut

__PACKAGE__->set_primary_key("eimage_id");

=head1 RELATIONS

=head2 expression_images

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ExpressionImage>

=cut

__PACKAGE__->has_many(
  "expression_images",
  "HTML_DIR::Chado::Result::ExpressionImage",
  { "foreign.eimage_id" => "self.eimage_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ek7+oVgWLsZhdOJxlIfmjA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
