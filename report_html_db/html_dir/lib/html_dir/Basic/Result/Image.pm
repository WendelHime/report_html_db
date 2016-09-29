use utf8;
package html_dir::Basic::Result::Image;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Basic::Result::Image

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

=head1 TABLE: C<IMAGES>

=cut

__PACKAGE__->table("IMAGES");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 tag

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 filepath

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 details

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "tag",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "filepath",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "details",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 relations_texts_images

Type: has_many

Related object: L<html_dir::Basic::Result::RelationsTextsImage>

=cut

__PACKAGE__->has_many(
  "relations_texts_images",
  "html_dir::Basic::Result::RelationsTextsImage",
  { "foreign.idimage" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:F6xIxmZhC136WmmgUe4XPA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
