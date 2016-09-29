use utf8;
package html_dir::Chado::Result::SeqType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::SeqType

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

=head1 TABLE: C<seq_type>

=cut

__PACKAGE__->table("seq_type");

=head1 ACCESSORS

=head2 cvterm_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns("cvterm_id", { data_type => "integer", is_nullable => 1 });


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wR0SbZ7DTUznrEe4YywPaw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
