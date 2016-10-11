use utf8;
package HTML_DIR::Chado::Result::StatsPathToRoot;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::StatsPathToRoot

=head1 DESCRIPTION

per-cvterm statistics on its
placement in the DAG relative to the root. There may be multiple paths
from any term to the root. This gives the total number of paths, and
the average minimum and maximum distances. Here distance is defined by
cvtermpath.pathdistance

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

=head1 TABLE: C<stats_paths_to_root>

=cut

__PACKAGE__->table("stats_paths_to_root");

=head1 ACCESSORS

=head2 cvterm_id

  data_type: 'bigint'
  is_nullable: 1

=head2 total_paths

  data_type: 'bigint'
  is_nullable: 1

=head2 avg_distance

  data_type: 'numeric'
  is_nullable: 1

=head2 min_distance

  data_type: 'integer'
  is_nullable: 1

=head2 max_distance

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "cvterm_id",
  { data_type => "bigint", is_nullable => 1 },
  "total_paths",
  { data_type => "bigint", is_nullable => 1 },
  "avg_distance",
  { data_type => "numeric", is_nullable => 1 },
  "min_distance",
  { data_type => "integer", is_nullable => 1 },
  "max_distance",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XVs1t4ho1eEtnBp4dsBBow


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
