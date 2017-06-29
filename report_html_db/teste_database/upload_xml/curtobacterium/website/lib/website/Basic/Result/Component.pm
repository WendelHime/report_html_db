use utf8;
package website::Basic::Result::Component;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

website::Basic::Result::Component

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

=head1 TABLE: C<COMPONENTS>

=cut

__PACKAGE__->table("COMPONENTS");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 locus_tag

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 component

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 filepath

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "locus_tag",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "component",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "filepath",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-06-29 15:23:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Hid+ExNGQBfMm7R9Pf/6OA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
