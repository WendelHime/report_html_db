use utf8;
package html_dir::Chado::Result::FeatureMeetsOnSameStrand;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::FeatureMeetsOnSameStrand

=head1 DESCRIPTION

as feature_meets, but
featurelocs must be on the same strand. symmetric,reflexive

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

=head1 TABLE: C<feature_meets_on_same_strand>

=cut

__PACKAGE__->table("feature_meets_on_same_strand");

=head1 ACCESSORS

=head2 subject_id

  data_type: 'bigint'
  is_nullable: 1

=head2 object_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "subject_id",
  { data_type => "bigint", is_nullable => 1 },
  "object_id",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wm17cpdAJ+KNBKDnanyQkA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
