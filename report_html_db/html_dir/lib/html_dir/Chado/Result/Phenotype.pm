use utf8;
package html_dir::Chado::Result::Phenotype;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Phenotype

=head1 DESCRIPTION

A phenotypic statement, or a single
atomic phenotypic observation, is a controlled sentence describing
observable effects of non-wild type function. E.g. Obs=eye, attribute=color, cvalue=red.

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

=head1 TABLE: C<phenotype>

=cut

__PACKAGE__->table("phenotype");

=head1 ACCESSORS

=head2 phenotype_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phenotype_phenotype_id_seq'

=head2 uniquename

  data_type: 'text'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 observable_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

The entity: e.g. anatomy_part, biological_process.

=head2 attr_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

Phenotypic attribute (quality, property, attribute, character) - drawn from PATO.

=head2 value

  data_type: 'text'
  is_nullable: 1

Value of attribute - unconstrained free text. Used only if cvalue_id is not appropriate.

=head2 cvalue_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

Phenotype attribute value (state).

=head2 assay_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

Evidence type.

=cut

__PACKAGE__->add_columns(
  "phenotype_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phenotype_phenotype_id_seq",
  },
  "uniquename",
  { data_type => "text", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "observable_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "attr_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "cvalue_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "assay_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phenotype_id>

=back

=cut

__PACKAGE__->set_primary_key("phenotype_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phenotype_c1>

=over 4

=item * L</uniquename>

=back

=cut

__PACKAGE__->add_unique_constraint("phenotype_c1", ["uniquename"]);

=head1 RELATIONS

=head2 assay

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "assay",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "assay_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 attr

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "attr",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "attr_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 cvalue

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "cvalue",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "cvalue_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 feature_phenotypes

Type: has_many

Related object: L<html_dir::Chado::Result::FeaturePhenotype>

=cut

__PACKAGE__->has_many(
  "feature_phenotypes",
  "html_dir::Chado::Result::FeaturePhenotype",
  { "foreign.phenotype_id" => "self.phenotype_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_phenotypes

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentPhenotype>

=cut

__PACKAGE__->has_many(
  "nd_experiment_phenotypes",
  "html_dir::Chado::Result::NdExperimentPhenotype",
  { "foreign.phenotype_id" => "self.phenotype_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 observable

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "observable",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "observable_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 phenotype_comparison_phenotype1s

Type: has_many

Related object: L<html_dir::Chado::Result::PhenotypeComparison>

=cut

__PACKAGE__->has_many(
  "phenotype_comparison_phenotype1s",
  "html_dir::Chado::Result::PhenotypeComparison",
  { "foreign.phenotype1_id" => "self.phenotype_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_comparison_phenotype2s

Type: has_many

Related object: L<html_dir::Chado::Result::PhenotypeComparison>

=cut

__PACKAGE__->has_many(
  "phenotype_comparison_phenotype2s",
  "html_dir::Chado::Result::PhenotypeComparison",
  { "foreign.phenotype2_id" => "self.phenotype_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::PhenotypeCvterm>

=cut

__PACKAGE__->has_many(
  "phenotype_cvterms",
  "html_dir::Chado::Result::PhenotypeCvterm",
  { "foreign.phenotype_id" => "self.phenotype_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotypeprops

Type: has_many

Related object: L<html_dir::Chado::Result::Phenotypeprop>

=cut

__PACKAGE__->has_many(
  "phenotypeprops",
  "html_dir::Chado::Result::Phenotypeprop",
  { "foreign.phenotype_id" => "self.phenotype_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenstatements

Type: has_many

Related object: L<html_dir::Chado::Result::Phenstatement>

=cut

__PACKAGE__->has_many(
  "phenstatements",
  "html_dir::Chado::Result::Phenstatement",
  { "foreign.phenotype_id" => "self.phenotype_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iVAmvFNTWOjq4KA/JKKISA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
