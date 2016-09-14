use utf8;
package html_dir::Chado::Result::CommentId;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::CommentId

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

=head1 TABLE: C<comment_id>

=cut

__PACKAGE__->table("comment_id");

=head1 ACCESSORS

=head2 cvterm_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns("cvterm_id", { data_type => "bigint", is_nullable => 1 });


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1R2y8Tm2SroYyZjq1z4fSQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
