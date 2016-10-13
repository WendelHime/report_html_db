use utf8;
package HTML_DIR::Chado::Result::Gff3view;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Gff3view

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

=head1 TABLE: C<gff3view>

=cut

__PACKAGE__->table("gff3view");

=head1 ACCESSORS

=head2 feature_id

  data_type: 'bigint'
  is_nullable: 1

=head2 ref

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 source

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 1024

=head2 fstart

  data_type: 'bigint'
  is_nullable: 1

=head2 fend

  data_type: 'bigint'
  is_nullable: 1

=head2 score

  data_type: 'text'
  is_nullable: 1

=head2 strand

  data_type: 'text'
  is_nullable: 1

=head2 phase

  data_type: 'text'
  is_nullable: 1

=head2 seqlen

  data_type: 'bigint'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 organism_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "feature_id",
  { data_type => "bigint", is_nullable => 1 },
  "ref",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "source",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 1024 },
  "fstart",
  { data_type => "bigint", is_nullable => 1 },
  "fend",
  { data_type => "bigint", is_nullable => 1 },
  "score",
  { data_type => "text", is_nullable => 1 },
  "strand",
  { data_type => "text", is_nullable => 1 },
  "phase",
  { data_type => "text", is_nullable => 1 },
  "seqlen",
  { data_type => "bigint", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "organism_id",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RqbdxCbmODtEMZZictvEEA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
