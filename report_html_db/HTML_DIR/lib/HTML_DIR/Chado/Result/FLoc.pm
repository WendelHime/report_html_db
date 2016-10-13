use utf8;
package HTML_DIR::Chado::Result::FLoc;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::FLoc

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
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<f_loc>

=cut

__PACKAGE__->table("f_loc");

=head1 ACCESSORS

=head2 feature_id

  data_type: 'bigint'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 dbxref_id

  data_type: 'bigint'
  is_nullable: 1

=head2 nbeg

  data_type: 'bigint'
  is_nullable: 1

=head2 nend

  data_type: 'bigint'
  is_nullable: 1

=head2 strand

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "feature_id",
  { data_type => "bigint", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "dbxref_id",
  { data_type => "bigint", is_nullable => 1 },
  "nbeg",
  { data_type => "bigint", is_nullable => 1 },
  "nend",
  { data_type => "bigint", is_nullable => 1 },
  "strand",
  { data_type => "smallint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cxEKR/fBogJDl6VbFvpsIQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
