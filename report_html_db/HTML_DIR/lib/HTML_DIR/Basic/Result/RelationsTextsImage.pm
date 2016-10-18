use utf8;
package HTML_DIR::Basic::Result::RelationsTextsImage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Basic::Result::RelationsTextsImage

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

=head1 TABLE: C<RELATIONS_TEXTS_IMAGES>

=cut

__PACKAGE__->table("RELATIONS_TEXTS_IMAGES");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 idimage

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 idtext

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "idimage",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "idtext",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 idimage

Type: belongs_to

Related object: L<HTML_DIR::Basic::Result::Image>

=cut

__PACKAGE__->belongs_to(
  "idimage",
  "HTML_DIR::Basic::Result::Image",
  { id => "idimage" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 idtext

Type: belongs_to

Related object: L<HTML_DIR::Basic::Result::Text>

=cut

__PACKAGE__->belongs_to(
  "idtext",
  "HTML_DIR::Basic::Result::Text",
  { id => "idtext" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OFC/dHScG88LzHD4w3pUOw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
