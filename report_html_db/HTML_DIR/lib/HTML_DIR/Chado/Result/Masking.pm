use utf8;
package HTML_DIR::Chado::Result::Masking;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Masking

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

=head1 TABLE: C<masking>

=cut

__PACKAGE__->table("masking");

=head1 ACCESSORS

=head2 masking_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'masking_masking_id_seq'

=head2 operation_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 fstart

  data_type: 'bigint'
  is_nullable: 0

=head2 fend

  data_type: 'bigint'
  is_nullable: 0

=head2 library

  data_type: 'text'
  is_nullable: 1

=head2 feature_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "masking_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "masking_masking_id_seq",
  },
  "operation_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "fstart",
  { data_type => "bigint", is_nullable => 0 },
  "fend",
  { data_type => "bigint", is_nullable => 0 },
  "library",
  { data_type => "text", is_nullable => 1 },
  "feature_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</masking_id>

=back

=cut

__PACKAGE__->set_primary_key("masking_id");

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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JhbWPo83cyzgh5IajNqA6Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
