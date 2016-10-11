use utf8;
package HTML_DIR::Chado::Result::FeatureDifference;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::FeatureDifference

=head1 DESCRIPTION

size of gap between two features. must be abutting or disjoint

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

=head1 TABLE: C<feature_difference>

=cut

__PACKAGE__->table("feature_difference");

=head1 ACCESSORS

=head2 subject_id

  data_type: 'bigint'
  is_nullable: 1

=head2 object_id

  data_type: 'bigint'
  is_nullable: 1

=head2 srcfeature_id

  data_type: 'smallint'
  is_nullable: 1

=head2 fmin

  data_type: 'bigint'
  is_nullable: 1

=head2 fmax

  data_type: 'bigint'
  is_nullable: 1

=head2 strand

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "subject_id",
  { data_type => "bigint", is_nullable => 1 },
  "object_id",
  { data_type => "bigint", is_nullable => 1 },
  "srcfeature_id",
  { data_type => "smallint", is_nullable => 1 },
  "fmin",
  { data_type => "bigint", is_nullable => 1 },
  "fmax",
  { data_type => "bigint", is_nullable => 1 },
  "strand",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:d1GQAGkihYI+CPN9KHUqUw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
