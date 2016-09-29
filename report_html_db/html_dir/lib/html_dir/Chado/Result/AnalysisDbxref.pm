use utf8;
package html_dir::Chado::Result::AnalysisDbxref;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::AnalysisDbxref - Links an analysis to dbxrefs.

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

=head1 TABLE: C<analysis_dbxref>

=cut

__PACKAGE__->table("analysis_dbxref");

=head1 ACCESSORS

=head2 analysis_dbxref_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'analysis_dbxref_analysis_dbxref_id_seq'

=head2 analysis_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 dbxref_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 is_current

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

True if this dbxref 
is the most up to date accession in the corresponding db. Retired 
accessions should set this field to false

=cut

__PACKAGE__->add_columns(
  "analysis_dbxref_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "analysis_dbxref_analysis_dbxref_id_seq",
  },
  "analysis_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_current",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_dbxref_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_dbxref_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<analysis_dbxref_c1>

=over 4

=item * L</analysis_id>

=item * L</dbxref_id>

=back

=cut

__PACKAGE__->add_unique_constraint("analysis_dbxref_c1", ["analysis_id", "dbxref_id"]);

=head1 RELATIONS

=head2 analysis

Type: belongs_to

Related object: L<html_dir::Chado::Result::Analysis>

=cut

__PACKAGE__->belongs_to(
  "analysis",
  "html_dir::Chado::Result::Analysis",
  { analysis_id => "analysis_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 dbxref

Type: belongs_to

Related object: L<html_dir::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "html_dir::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cjJJm0Dn8bZih12r2RsDEg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
