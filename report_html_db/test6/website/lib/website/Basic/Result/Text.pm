use utf8;
package website::Basic::Result::Text;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

website::Basic::Result::Text

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

=head1 TABLE: C<TEXTS>

=cut

__PACKAGE__->table("TEXTS");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 tag

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 value

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
  "value",
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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-23 15:16:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2Ob5TUJKgLX7b9lWkah8XA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
