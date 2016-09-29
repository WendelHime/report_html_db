use utf8;
package html_dir::Chado::Result::Analysis;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Analysis

=head1 DESCRIPTION

An analysis is a particular type of a
    computational analysis; it may be a blast of one sequence against
    another, or an all by all blast, or a different kind of analysis
    altogether. It is a single unit of computation.

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

=head1 TABLE: C<analysis>

=cut

__PACKAGE__->table("analysis");

=head1 ACCESSORS

=head2 analysis_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'analysis_analysis_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

A way of grouping analyses. This
    should be a handy short identifier that can help people find an
    analysis they want. For instance "tRNAscan", "cDNA", "FlyPep",
    "SwissProt", and it should not be assumed to be unique. For instance, there may be lots of separate analyses done against a cDNA database.

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 program

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Program name, e.g. blastx, blastp, sim4, genscan.

=head2 programversion

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Version description, e.g. TBLASTX 2.0MP-WashU [09-Nov-2000].

=head2 algorithm

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Algorithm name, e.g. blast.

=head2 sourcename

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Source name, e.g. cDNA, SwissProt.

=head2 sourceversion

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 sourceuri

  data_type: 'text'
  is_nullable: 1

This is an optional, permanent URL or URI for the source of the  analysis. The idea is that someone could recreate the analysis directly by going to this URI and fetching the source data (e.g. the blast database, or the training model).

=head2 timeexecuted

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "analysis_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "analysis_analysis_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "program",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "programversion",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "algorithm",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "sourcename",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "sourceversion",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "sourceuri",
  { data_type => "text", is_nullable => 1 },
  "timeexecuted",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<analysis_c1>

=over 4

=item * L</program>

=item * L</programversion>

=item * L</sourcename>

=back

=cut

__PACKAGE__->add_unique_constraint("analysis_c1", ["program", "programversion", "sourcename"]);

=head1 RELATIONS

=head2 analysis_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisCvterm>

=cut

__PACKAGE__->has_many(
  "analysis_cvterms",
  "html_dir::Chado::Result::AnalysisCvterm",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_dbxrefs

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisDbxref>

=cut

__PACKAGE__->has_many(
  "analysis_dbxrefs",
  "html_dir::Chado::Result::AnalysisDbxref",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_operation

Type: might_have

Related object: L<html_dir::Chado::Result::AnalysisOperation>

=cut

__PACKAGE__->might_have(
  "analysis_operation",
  "html_dir::Chado::Result::AnalysisOperation",
  { "foreign.analysis_operation_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_pubs

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisPub>

=cut

__PACKAGE__->has_many(
  "analysis_pubs",
  "html_dir::Chado::Result::AnalysisPub",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_relationship_objects

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisRelationship>

=cut

__PACKAGE__->has_many(
  "analysis_relationship_objects",
  "html_dir::Chado::Result::AnalysisRelationship",
  { "foreign.object_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_relationship_subjects

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisRelationship>

=cut

__PACKAGE__->has_many(
  "analysis_relationship_subjects",
  "html_dir::Chado::Result::AnalysisRelationship",
  { "foreign.subject_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysisfeatures

Type: has_many

Related object: L<html_dir::Chado::Result::Analysisfeature>

=cut

__PACKAGE__->has_many(
  "analysisfeatures",
  "html_dir::Chado::Result::Analysisfeature",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysisprops

Type: has_many

Related object: L<html_dir::Chado::Result::Analysisprop>

=cut

__PACKAGE__->has_many(
  "analysisprops",
  "html_dir::Chado::Result::Analysisprop",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_analyses

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentAnalysis>

=cut

__PACKAGE__->has_many(
  "nd_experiment_analyses",
  "html_dir::Chado::Result::NdExperimentAnalysis",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 operations

Type: has_many

Related object: L<html_dir::Chado::Result::Operation>

=cut

__PACKAGE__->has_many(
  "operations",
  "html_dir::Chado::Result::Operation",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylotrees

Type: has_many

Related object: L<html_dir::Chado::Result::Phylotree>

=cut

__PACKAGE__->has_many(
  "phylotrees",
  "html_dir::Chado::Result::Phylotree",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_analyses

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectAnalysis>

=cut

__PACKAGE__->has_many(
  "project_analyses",
  "html_dir::Chado::Result::ProjectAnalysis",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantifications

Type: has_many

Related object: L<html_dir::Chado::Result::Quantification>

=cut

__PACKAGE__->has_many(
  "quantifications",
  "html_dir::Chado::Result::Quantification",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:z760DJmNCa2eF+B3CwtcoA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
