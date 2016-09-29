use utf8;
package html_dir::Chado::Result::CommonAncestorCvterm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::CommonAncestorCvterm

=head1 DESCRIPTION

The common ancestor of any
two terms is the intersection of both terms ancestors. Two terms can
have multiple common ancestors. Use total_pathdistance to get the
least common ancestor

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

=head1 TABLE: C<common_ancestor_cvterm>

=cut

__PACKAGE__->table("common_ancestor_cvterm");

=head1 ACCESSORS

=head2 cvterm1_id

  data_type: 'bigint'
  is_nullable: 1

=head2 cvterm2_id

  data_type: 'bigint'
  is_nullable: 1

=head2 ancestor_cvterm_id

  data_type: 'bigint'
  is_nullable: 1

=head2 pathdistance1

  data_type: 'integer'
  is_nullable: 1

=head2 pathdistance2

  data_type: 'integer'
  is_nullable: 1

=head2 total_pathdistance

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "cvterm1_id",
  { data_type => "bigint", is_nullable => 1 },
  "cvterm2_id",
  { data_type => "bigint", is_nullable => 1 },
  "ancestor_cvterm_id",
  { data_type => "bigint", is_nullable => 1 },
  "pathdistance1",
  { data_type => "integer", is_nullable => 1 },
  "pathdistance2",
  { data_type => "integer", is_nullable => 1 },
  "total_pathdistance",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5RIGLOhi+pbNv25L0FfT9w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
