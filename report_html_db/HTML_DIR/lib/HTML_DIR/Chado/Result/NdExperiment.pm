use utf8;
package HTML_DIR::Chado::Result::NdExperiment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::NdExperiment

=head1 DESCRIPTION

This is the core table for the natural diversity module, 
representing each individual assay that is undertaken (this is usually *not* an 
entire experiment). Each nd_experiment should give rise to a single genotype or 
phenotype and be described via 1 (or more) protocols. Collections of assays that 
relate to each other should be linked to the same record in the project table.

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

=head1 TABLE: C<nd_experiment>

=cut

__PACKAGE__->table("nd_experiment");

=head1 ACCESSORS

=head2 nd_experiment_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nd_experiment_nd_experiment_id_seq'

=head2 nd_geolocation_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "nd_experiment_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nd_experiment_nd_experiment_id_seq",
  },
  "nd_geolocation_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nd_experiment_id>

=back

=cut

__PACKAGE__->set_primary_key("nd_experiment_id");

=head1 RELATIONS

=head2 nd_experiment_analyses

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentAnalysis>

=cut

__PACKAGE__->has_many(
  "nd_experiment_analyses",
  "HTML_DIR::Chado::Result::NdExperimentAnalysis",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentContact>

=cut

__PACKAGE__->has_many(
  "nd_experiment_contacts",
  "HTML_DIR::Chado::Result::NdExperimentContact",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_dbxrefs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentDbxref>

=cut

__PACKAGE__->has_many(
  "nd_experiment_dbxrefs",
  "HTML_DIR::Chado::Result::NdExperimentDbxref",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_genotypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentGenotype>

=cut

__PACKAGE__->has_many(
  "nd_experiment_genotypes",
  "HTML_DIR::Chado::Result::NdExperimentGenotype",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_phenotypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentPhenotype>

=cut

__PACKAGE__->has_many(
  "nd_experiment_phenotypes",
  "HTML_DIR::Chado::Result::NdExperimentPhenotype",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_projects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentProject>

=cut

__PACKAGE__->has_many(
  "nd_experiment_projects",
  "HTML_DIR::Chado::Result::NdExperimentProject",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_protocols

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentProtocol>

=cut

__PACKAGE__->has_many(
  "nd_experiment_protocols",
  "HTML_DIR::Chado::Result::NdExperimentProtocol",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_pubs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentPub>

=cut

__PACKAGE__->has_many(
  "nd_experiment_pubs",
  "HTML_DIR::Chado::Result::NdExperimentPub",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_stocks

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentStock>

=cut

__PACKAGE__->has_many(
  "nd_experiment_stocks",
  "HTML_DIR::Chado::Result::NdExperimentStock",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experimentprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentprop>

=cut

__PACKAGE__->has_many(
  "nd_experimentprops",
  "HTML_DIR::Chado::Result::NdExperimentprop",
  { "foreign.nd_experiment_id" => "self.nd_experiment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_geolocation

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::NdGeolocation>

=cut

__PACKAGE__->belongs_to(
  "nd_geolocation",
  "HTML_DIR::Chado::Result::NdGeolocation",
  { nd_geolocation_id => "nd_geolocation_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 type

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yhRiBCuZ4FSp+pOLDTK9cw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
