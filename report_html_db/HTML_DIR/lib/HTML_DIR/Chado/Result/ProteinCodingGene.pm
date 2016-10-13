use utf8;
package HTML_DIR::Chado::Result::ProteinCodingGene;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::ProteinCodingGene

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

=head1 TABLE: C<protein_coding_gene>

=cut

__PACKAGE__->table("protein_coding_gene");

=head1 ACCESSORS

=head2 feature_id

  data_type: 'bigint'
  is_nullable: 1

=head2 dbxref_id

  data_type: 'bigint'
  is_nullable: 1

=head2 organism_id

  data_type: 'bigint'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 uniquename

  data_type: 'text'
  is_nullable: 1

=head2 residues

  data_type: 'text'
  is_nullable: 1

=head2 seqlen

  data_type: 'bigint'
  is_nullable: 1

=head2 md5checksum

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 type_id

  data_type: 'bigint'
  is_nullable: 1

=head2 is_analysis

  data_type: 'boolean'
  is_nullable: 1

=head2 is_obsolete

  data_type: 'boolean'
  is_nullable: 1

=head2 timeaccessioned

  data_type: 'timestamp'
  is_nullable: 1

=head2 timelastmodified

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "feature_id",
  { data_type => "bigint", is_nullable => 1 },
  "dbxref_id",
  { data_type => "bigint", is_nullable => 1 },
  "organism_id",
  { data_type => "bigint", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "uniquename",
  { data_type => "text", is_nullable => 1 },
  "residues",
  { data_type => "text", is_nullable => 1 },
  "seqlen",
  { data_type => "bigint", is_nullable => 1 },
  "md5checksum",
  { data_type => "char", is_nullable => 1, size => 32 },
  "type_id",
  { data_type => "bigint", is_nullable => 1 },
  "is_analysis",
  { data_type => "boolean", is_nullable => 1 },
  "is_obsolete",
  { data_type => "boolean", is_nullable => 1 },
  "timeaccessioned",
  { data_type => "timestamp", is_nullable => 1 },
  "timelastmodified",
  { data_type => "timestamp", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RH7NDCUDT6lS8nBdnAG0BQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
