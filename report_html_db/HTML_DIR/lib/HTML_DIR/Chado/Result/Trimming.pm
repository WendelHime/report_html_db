use utf8;
package HTML_DIR::Chado::Result::Trimming;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Trimming

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

=head1 TABLE: C<trimming>

=cut

__PACKAGE__->table("trimming");

=head1 ACCESSORS

=head2 trimming_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'trimming_trimming_id_seq'

=head2 operation_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 direction

  data_type: 'integer'
  is_nullable: 0

=head2 size

  data_type: 'bigint'
  is_nullable: 0

=head2 feature_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "trimming_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "trimming_trimming_id_seq",
  },
  "operation_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "direction",
  { data_type => "integer", is_nullable => 0 },
  "size",
  { data_type => "bigint", is_nullable => 0 },
  "feature_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</trimming_id>

=back

=cut

__PACKAGE__->set_primary_key("trimming_id");

=head1 RELATIONS

=head2 operation

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Operation>

=cut

__PACKAGE__->belongs_to(
  "operation",
  "HTML_DIR::Chado::Result::Operation",
  { operation_id => "operation_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bJEycmMJoG27zxZExaSFRA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
