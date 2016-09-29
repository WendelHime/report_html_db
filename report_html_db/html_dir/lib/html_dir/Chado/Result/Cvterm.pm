use utf8;
package html_dir::Chado::Result::Cvterm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Cvterm

=head1 DESCRIPTION

A term, class, universal or type within an
ontology or controlled vocabulary.  This table is also used for
relations and properties. cvterms constitute nodes in the graph
defined by the collection of cvterms and cvterm_relationships.

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

=head1 TABLE: C<cvterm>

=cut

__PACKAGE__->table("cvterm");

=head1 ACCESSORS

=head2 cvterm_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cvterm_cvterm_id_seq'

=head2 cv_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The cv or ontology or namespace to which
this cvterm belongs.

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 1024

A concise human-readable name or
label for the cvterm. Uniquely identifies a cvterm within a cv.

=head2 definition

  data_type: 'text'
  is_nullable: 1

A human-readable text
definition.

=head2 dbxref_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

Primary identifier dbxref - The
unique global OBO identifier for this cvterm.  Note that a cvterm may
have multiple secondary dbxrefs - see also table: cvterm_dbxref.

=head2 is_obsolete

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

Boolean 0=false,1=true; see
GO documentation for details of obsoletion. Note that two terms with
different primary dbxrefs may exist if one is obsolete.

=head2 is_relationshiptype

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

Boolean
0=false,1=true relations or relationship types (also known as Typedefs
in OBO format, or as properties or slots) form a cv/ontology in
themselves. We use this flag to indicate whether this cvterm is an
actual term/class/universal or a relation. Relations may be drawn from
the OBO Relations ontology, but are not exclusively drawn from there.

=cut

__PACKAGE__->add_columns(
  "cvterm_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cvterm_cvterm_id_seq",
  },
  "cv_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 1024 },
  "definition",
  { data_type => "text", is_nullable => 1 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_obsolete",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "is_relationshiptype",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cvterm_id>

=back

=cut

__PACKAGE__->set_primary_key("cvterm_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cvterm_c1>

=over 4

=item * L</name>

=item * L</cv_id>

=item * L</is_obsolete>

=back

=cut

__PACKAGE__->add_unique_constraint("cvterm_c1", ["name", "cv_id", "is_obsolete"]);

=head2 C<cvterm_c2>

=over 4

=item * L</dbxref_id>

=back

=cut

__PACKAGE__->add_unique_constraint("cvterm_c2", ["dbxref_id"]);

=head1 RELATIONS

=head2 acquisition_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::AcquisitionRelationship>

=cut

__PACKAGE__->has_many(
  "acquisition_relationships",
  "html_dir::Chado::Result::AcquisitionRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 acquisitionprops

Type: has_many

Related object: L<html_dir::Chado::Result::Acquisitionprop>

=cut

__PACKAGE__->has_many(
  "acquisitionprops",
  "html_dir::Chado::Result::Acquisitionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisCvterm>

=cut

__PACKAGE__->has_many(
  "analysis_cvterms",
  "html_dir::Chado::Result::AnalysisCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_operations

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisOperation>

=cut

__PACKAGE__->has_many(
  "analysis_operations",
  "html_dir::Chado::Result::AnalysisOperation",
  { "foreign.type_operation_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::AnalysisRelationship>

=cut

__PACKAGE__->has_many(
  "analysis_relationships",
  "html_dir::Chado::Result::AnalysisRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysisfeatureprops

Type: has_many

Related object: L<html_dir::Chado::Result::Analysisfeatureprop>

=cut

__PACKAGE__->has_many(
  "analysisfeatureprops",
  "html_dir::Chado::Result::Analysisfeatureprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysisprops

Type: has_many

Related object: L<html_dir::Chado::Result::Analysisprop>

=cut

__PACKAGE__->has_many(
  "analysisprops",
  "html_dir::Chado::Result::Analysisprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesign_platformtypes

Type: has_many

Related object: L<html_dir::Chado::Result::Arraydesign>

=cut

__PACKAGE__->has_many(
  "arraydesign_platformtypes",
  "html_dir::Chado::Result::Arraydesign",
  { "foreign.platformtype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesign_substratetypes

Type: has_many

Related object: L<html_dir::Chado::Result::Arraydesign>

=cut

__PACKAGE__->has_many(
  "arraydesign_substratetypes",
  "html_dir::Chado::Result::Arraydesign",
  { "foreign.substratetype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesignprops

Type: has_many

Related object: L<html_dir::Chado::Result::Arraydesignprop>

=cut

__PACKAGE__->has_many(
  "arraydesignprops",
  "html_dir::Chado::Result::Arraydesignprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assayprops

Type: has_many

Related object: L<html_dir::Chado::Result::Assayprop>

=cut

__PACKAGE__->has_many(
  "assayprops",
  "html_dir::Chado::Result::Assayprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::BiomaterialRelationship>

=cut

__PACKAGE__->has_many(
  "biomaterial_relationships",
  "html_dir::Chado::Result::BiomaterialRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_treatments

Type: has_many

Related object: L<html_dir::Chado::Result::BiomaterialTreatment>

=cut

__PACKAGE__->has_many(
  "biomaterial_treatments",
  "html_dir::Chado::Result::BiomaterialTreatment",
  { "foreign.unittype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterialprops

Type: has_many

Related object: L<html_dir::Chado::Result::Biomaterialprop>

=cut

__PACKAGE__->has_many(
  "biomaterialprops",
  "html_dir::Chado::Result::Biomaterialprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_line_cvtermprops

Type: has_many

Related object: L<html_dir::Chado::Result::CellLineCvtermprop>

=cut

__PACKAGE__->has_many(
  "cell_line_cvtermprops",
  "html_dir::Chado::Result::CellLineCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_line_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::CellLineCvterm>

=cut

__PACKAGE__->has_many(
  "cell_line_cvterms",
  "html_dir::Chado::Result::CellLineCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_line_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::CellLineRelationship>

=cut

__PACKAGE__->has_many(
  "cell_line_relationships",
  "html_dir::Chado::Result::CellLineRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_lineprops

Type: has_many

Related object: L<html_dir::Chado::Result::CellLineprop>

=cut

__PACKAGE__->has_many(
  "cell_lineprops",
  "html_dir::Chado::Result::CellLineprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 chadoprops

Type: has_many

Related object: L<html_dir::Chado::Result::Chadoprop>

=cut

__PACKAGE__->has_many(
  "chadoprops",
  "html_dir::Chado::Result::Chadoprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contact_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::ContactRelationship>

=cut

__PACKAGE__->has_many(
  "contact_relationships",
  "html_dir::Chado::Result::ContactRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contactprops

Type: has_many

Related object: L<html_dir::Chado::Result::Contactprop>

=cut

__PACKAGE__->has_many(
  "contactprops",
  "html_dir::Chado::Result::Contactprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contacts

Type: has_many

Related object: L<html_dir::Chado::Result::Contact>

=cut

__PACKAGE__->has_many(
  "contacts",
  "html_dir::Chado::Result::Contact",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 controls

Type: has_many

Related object: L<html_dir::Chado::Result::Control>

=cut

__PACKAGE__->has_many(
  "controls",
  "html_dir::Chado::Result::Control",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cv

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cv>

=cut

__PACKAGE__->belongs_to(
  "cv",
  "html_dir::Chado::Result::Cv",
  { cv_id => "cv_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 cvprops

Type: has_many

Related object: L<html_dir::Chado::Result::Cvprop>

=cut

__PACKAGE__->has_many(
  "cvprops",
  "html_dir::Chado::Result::Cvprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_dbxrefs

Type: has_many

Related object: L<html_dir::Chado::Result::CvtermDbxref>

=cut

__PACKAGE__->has_many(
  "cvterm_dbxrefs",
  "html_dir::Chado::Result::CvtermDbxref",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_relationship_objects

Type: has_many

Related object: L<html_dir::Chado::Result::CvtermRelationship>

=cut

__PACKAGE__->has_many(
  "cvterm_relationship_objects",
  "html_dir::Chado::Result::CvtermRelationship",
  { "foreign.object_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_relationship_subjects

Type: has_many

Related object: L<html_dir::Chado::Result::CvtermRelationship>

=cut

__PACKAGE__->has_many(
  "cvterm_relationship_subjects",
  "html_dir::Chado::Result::CvtermRelationship",
  { "foreign.subject_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_relationship_types

Type: has_many

Related object: L<html_dir::Chado::Result::CvtermRelationship>

=cut

__PACKAGE__->has_many(
  "cvterm_relationship_types",
  "html_dir::Chado::Result::CvtermRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermpath_objects

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermpath>

=cut

__PACKAGE__->has_many(
  "cvtermpath_objects",
  "html_dir::Chado::Result::Cvtermpath",
  { "foreign.object_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermpath_subjects

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermpath>

=cut

__PACKAGE__->has_many(
  "cvtermpath_subjects",
  "html_dir::Chado::Result::Cvtermpath",
  { "foreign.subject_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermpath_types

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermpath>

=cut

__PACKAGE__->has_many(
  "cvtermpath_types",
  "html_dir::Chado::Result::Cvtermpath",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermprop_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermprop>

=cut

__PACKAGE__->has_many(
  "cvtermprop_cvterms",
  "html_dir::Chado::Result::Cvtermprop",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermprop_types

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermprop>

=cut

__PACKAGE__->has_many(
  "cvtermprop_types",
  "html_dir::Chado::Result::Cvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermsynonym_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermsynonym>

=cut

__PACKAGE__->has_many(
  "cvtermsynonym_cvterms",
  "html_dir::Chado::Result::Cvtermsynonym",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermsynonym_types

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermsynonym>

=cut

__PACKAGE__->has_many(
  "cvtermsynonym_types",
  "html_dir::Chado::Result::Cvtermsynonym",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbprops

Type: has_many

Related object: L<html_dir::Chado::Result::Dbprop>

=cut

__PACKAGE__->has_many(
  "dbprops",
  "html_dir::Chado::Result::Dbprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbxref

Type: belongs_to

Related object: L<html_dir::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "html_dir::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  { is_deferrable => 1, on_delete => "SET NULL", on_update => "NO ACTION" },
);

=head2 dbxrefprops

Type: has_many

Related object: L<html_dir::Chado::Result::Dbxrefprop>

=cut

__PACKAGE__->has_many(
  "dbxrefprops",
  "html_dir::Chado::Result::Dbxrefprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 element_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::ElementRelationship>

=cut

__PACKAGE__->has_many(
  "element_relationships",
  "html_dir::Chado::Result::ElementRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 elementresult_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::ElementresultRelationship>

=cut

__PACKAGE__->has_many(
  "elementresult_relationships",
  "html_dir::Chado::Result::ElementresultRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 elements

Type: has_many

Related object: L<html_dir::Chado::Result::Element>

=cut

__PACKAGE__->has_many(
  "elements",
  "html_dir::Chado::Result::Element",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 environment_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::EnvironmentCvterm>

=cut

__PACKAGE__->has_many(
  "environment_cvterms",
  "html_dir::Chado::Result::EnvironmentCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expression_cvterm_cvterm_types

Type: has_many

Related object: L<html_dir::Chado::Result::ExpressionCvterm>

=cut

__PACKAGE__->has_many(
  "expression_cvterm_cvterm_types",
  "html_dir::Chado::Result::ExpressionCvterm",
  { "foreign.cvterm_type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expression_cvterm_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::ExpressionCvterm>

=cut

__PACKAGE__->has_many(
  "expression_cvterm_cvterms",
  "html_dir::Chado::Result::ExpressionCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expression_cvtermprops

Type: has_many

Related object: L<html_dir::Chado::Result::ExpressionCvtermprop>

=cut

__PACKAGE__->has_many(
  "expression_cvtermprops",
  "html_dir::Chado::Result::ExpressionCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expressionprops

Type: has_many

Related object: L<html_dir::Chado::Result::Expressionprop>

=cut

__PACKAGE__->has_many(
  "expressionprops",
  "html_dir::Chado::Result::Expressionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_cvtermprops

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureCvtermprop>

=cut

__PACKAGE__->has_many(
  "feature_cvtermprops",
  "html_dir::Chado::Result::FeatureCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureCvterm>

=cut

__PACKAGE__->has_many(
  "feature_cvterms",
  "html_dir::Chado::Result::FeatureCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_expressionprops

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureExpressionprop>

=cut

__PACKAGE__->has_many(
  "feature_expressionprops",
  "html_dir::Chado::Result::FeatureExpressionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_genotypes

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureGenotype>

=cut

__PACKAGE__->has_many(
  "feature_genotypes",
  "html_dir::Chado::Result::FeatureGenotype",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_pubprops

Type: has_many

Related object: L<html_dir::Chado::Result::FeaturePubprop>

=cut

__PACKAGE__->has_many(
  "feature_pubprops",
  "html_dir::Chado::Result::FeaturePubprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_relationshipprops

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureRelationshipprop>

=cut

__PACKAGE__->has_many(
  "feature_relationshipprops",
  "html_dir::Chado::Result::FeatureRelationshipprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureRelationship>

=cut

__PACKAGE__->has_many(
  "feature_relationships",
  "html_dir::Chado::Result::FeatureRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremapprops

Type: has_many

Related object: L<html_dir::Chado::Result::Featuremapprop>

=cut

__PACKAGE__->has_many(
  "featuremapprops",
  "html_dir::Chado::Result::Featuremapprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremaps

Type: has_many

Related object: L<html_dir::Chado::Result::Featuremap>

=cut

__PACKAGE__->has_many(
  "featuremaps",
  "html_dir::Chado::Result::Featuremap",
  { "foreign.unittype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featureposprops

Type: has_many

Related object: L<html_dir::Chado::Result::Featureposprop>

=cut

__PACKAGE__->has_many(
  "featureposprops",
  "html_dir::Chado::Result::Featureposprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featureprops

Type: has_many

Related object: L<html_dir::Chado::Result::Featureprop>

=cut

__PACKAGE__->has_many(
  "featureprops",
  "html_dir::Chado::Result::Featureprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 features

Type: has_many

Related object: L<html_dir::Chado::Result::Feature>

=cut

__PACKAGE__->has_many(
  "features",
  "html_dir::Chado::Result::Feature",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 genotypeprops

Type: has_many

Related object: L<html_dir::Chado::Result::Genotypeprop>

=cut

__PACKAGE__->has_many(
  "genotypeprops",
  "html_dir::Chado::Result::Genotypeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 genotypes

Type: has_many

Related object: L<html_dir::Chado::Result::Genotype>

=cut

__PACKAGE__->has_many(
  "genotypes",
  "html_dir::Chado::Result::Genotype",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 libraries

Type: has_many

Related object: L<html_dir::Chado::Result::Library>

=cut

__PACKAGE__->has_many(
  "libraries",
  "html_dir::Chado::Result::Library",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::LibraryCvterm>

=cut

__PACKAGE__->has_many(
  "library_cvterms",
  "html_dir::Chado::Result::LibraryCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_expressionprops

Type: has_many

Related object: L<html_dir::Chado::Result::LibraryExpressionprop>

=cut

__PACKAGE__->has_many(
  "library_expressionprops",
  "html_dir::Chado::Result::LibraryExpressionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_featureprops

Type: has_many

Related object: L<html_dir::Chado::Result::LibraryFeatureprop>

=cut

__PACKAGE__->has_many(
  "library_featureprops",
  "html_dir::Chado::Result::LibraryFeatureprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::LibraryRelationship>

=cut

__PACKAGE__->has_many(
  "library_relationships",
  "html_dir::Chado::Result::LibraryRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 libraryprops

Type: has_many

Related object: L<html_dir::Chado::Result::Libraryprop>

=cut

__PACKAGE__->has_many(
  "libraryprops",
  "html_dir::Chado::Result::Libraryprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_analyses

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentAnalysis>

=cut

__PACKAGE__->has_many(
  "nd_experiment_analyses",
  "html_dir::Chado::Result::NdExperimentAnalysis",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_stockprops

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentStockprop>

=cut

__PACKAGE__->has_many(
  "nd_experiment_stockprops",
  "html_dir::Chado::Result::NdExperimentStockprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_stocks

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentStock>

=cut

__PACKAGE__->has_many(
  "nd_experiment_stocks",
  "html_dir::Chado::Result::NdExperimentStock",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experimentprops

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperimentprop>

=cut

__PACKAGE__->has_many(
  "nd_experimentprops",
  "html_dir::Chado::Result::NdExperimentprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiments

Type: has_many

Related object: L<html_dir::Chado::Result::NdExperiment>

=cut

__PACKAGE__->has_many(
  "nd_experiments",
  "html_dir::Chado::Result::NdExperiment",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_geolocationprops

Type: has_many

Related object: L<html_dir::Chado::Result::NdGeolocationprop>

=cut

__PACKAGE__->has_many(
  "nd_geolocationprops",
  "html_dir::Chado::Result::NdGeolocationprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocol_reagents

Type: has_many

Related object: L<html_dir::Chado::Result::NdProtocolReagent>

=cut

__PACKAGE__->has_many(
  "nd_protocol_reagents",
  "html_dir::Chado::Result::NdProtocolReagent",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocolprops

Type: has_many

Related object: L<html_dir::Chado::Result::NdProtocolprop>

=cut

__PACKAGE__->has_many(
  "nd_protocolprops",
  "html_dir::Chado::Result::NdProtocolprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocols

Type: has_many

Related object: L<html_dir::Chado::Result::NdProtocol>

=cut

__PACKAGE__->has_many(
  "nd_protocols",
  "html_dir::Chado::Result::NdProtocol",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagent_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::NdReagentRelationship>

=cut

__PACKAGE__->has_many(
  "nd_reagent_relationships",
  "html_dir::Chado::Result::NdReagentRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagentprops

Type: has_many

Related object: L<html_dir::Chado::Result::NdReagentprop>

=cut

__PACKAGE__->has_many(
  "nd_reagentprops",
  "html_dir::Chado::Result::NdReagentprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagents

Type: has_many

Related object: L<html_dir::Chado::Result::NdReagent>

=cut

__PACKAGE__->has_many(
  "nd_reagents",
  "html_dir::Chado::Result::NdReagent",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 operations

Type: has_many

Related object: L<html_dir::Chado::Result::Operation>

=cut

__PACKAGE__->has_many(
  "operations",
  "html_dir::Chado::Result::Operation",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_cvtermprops

Type: has_many

Related object: L<html_dir::Chado::Result::OrganismCvtermprop>

=cut

__PACKAGE__->has_many(
  "organism_cvtermprops",
  "html_dir::Chado::Result::OrganismCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::OrganismCvterm>

=cut

__PACKAGE__->has_many(
  "organism_cvterms",
  "html_dir::Chado::Result::OrganismCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::OrganismRelationship>

=cut

__PACKAGE__->has_many(
  "organism_relationships",
  "html_dir::Chado::Result::OrganismRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organismprops

Type: has_many

Related object: L<html_dir::Chado::Result::Organismprop>

=cut

__PACKAGE__->has_many(
  "organismprops",
  "html_dir::Chado::Result::Organismprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organisms

Type: has_many

Related object: L<html_dir::Chado::Result::Organism>

=cut

__PACKAGE__->has_many(
  "organisms",
  "html_dir::Chado::Result::Organism",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phendescs

Type: has_many

Related object: L<html_dir::Chado::Result::Phendesc>

=cut

__PACKAGE__->has_many(
  "phendescs",
  "html_dir::Chado::Result::Phendesc",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_assays

Type: has_many

Related object: L<html_dir::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_assays",
  "html_dir::Chado::Result::Phenotype",
  { "foreign.assay_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_attrs

Type: has_many

Related object: L<html_dir::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_attrs",
  "html_dir::Chado::Result::Phenotype",
  { "foreign.attr_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_comparison_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::PhenotypeComparisonCvterm>

=cut

__PACKAGE__->has_many(
  "phenotype_comparison_cvterms",
  "html_dir::Chado::Result::PhenotypeComparisonCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_cvalues

Type: has_many

Related object: L<html_dir::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_cvalues",
  "html_dir::Chado::Result::Phenotype",
  { "foreign.cvalue_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::PhenotypeCvterm>

=cut

__PACKAGE__->has_many(
  "phenotype_cvterms",
  "html_dir::Chado::Result::PhenotypeCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_observables

Type: has_many

Related object: L<html_dir::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_observables",
  "html_dir::Chado::Result::Phenotype",
  { "foreign.observable_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotypeprops

Type: has_many

Related object: L<html_dir::Chado::Result::Phenotypeprop>

=cut

__PACKAGE__->has_many(
  "phenotypeprops",
  "html_dir::Chado::Result::Phenotypeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenstatements

Type: has_many

Related object: L<html_dir::Chado::Result::Phenstatement>

=cut

__PACKAGE__->has_many(
  "phenstatements",
  "html_dir::Chado::Result::Phenstatement",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonode_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::PhylonodeRelationship>

=cut

__PACKAGE__->has_many(
  "phylonode_relationships",
  "html_dir::Chado::Result::PhylonodeRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonodeprops

Type: has_many

Related object: L<html_dir::Chado::Result::Phylonodeprop>

=cut

__PACKAGE__->has_many(
  "phylonodeprops",
  "html_dir::Chado::Result::Phylonodeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonodes

Type: has_many

Related object: L<html_dir::Chado::Result::Phylonode>

=cut

__PACKAGE__->has_many(
  "phylonodes",
  "html_dir::Chado::Result::Phylonode",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylotreeprops

Type: has_many

Related object: L<html_dir::Chado::Result::Phylotreeprop>

=cut

__PACKAGE__->has_many(
  "phylotreeprops",
  "html_dir::Chado::Result::Phylotreeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylotrees

Type: has_many

Related object: L<html_dir::Chado::Result::Phylotree>

=cut

__PACKAGE__->has_many(
  "phylotrees",
  "html_dir::Chado::Result::Phylotree",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::ProjectRelationship>

=cut

__PACKAGE__->has_many(
  "project_relationships",
  "html_dir::Chado::Result::ProjectRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projectprops

Type: has_many

Related object: L<html_dir::Chado::Result::Projectprop>

=cut

__PACKAGE__->has_many(
  "projectprops",
  "html_dir::Chado::Result::Projectprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 protocolparam_datatypes

Type: has_many

Related object: L<html_dir::Chado::Result::Protocolparam>

=cut

__PACKAGE__->has_many(
  "protocolparam_datatypes",
  "html_dir::Chado::Result::Protocolparam",
  { "foreign.datatype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 protocolparam_unittypes

Type: has_many

Related object: L<html_dir::Chado::Result::Protocolparam>

=cut

__PACKAGE__->has_many(
  "protocolparam_unittypes",
  "html_dir::Chado::Result::Protocolparam",
  { "foreign.unittype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 protocols

Type: has_many

Related object: L<html_dir::Chado::Result::Protocol>

=cut

__PACKAGE__->has_many(
  "protocols",
  "html_dir::Chado::Result::Protocol",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pub_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::PubRelationship>

=cut

__PACKAGE__->has_many(
  "pub_relationships",
  "html_dir::Chado::Result::PubRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pubprops

Type: has_many

Related object: L<html_dir::Chado::Result::Pubprop>

=cut

__PACKAGE__->has_many(
  "pubprops",
  "html_dir::Chado::Result::Pubprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pubs

Type: has_many

Related object: L<html_dir::Chado::Result::Pub>

=cut

__PACKAGE__->has_many(
  "pubs",
  "html_dir::Chado::Result::Pub",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantification_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::QuantificationRelationship>

=cut

__PACKAGE__->has_many(
  "quantification_relationships",
  "html_dir::Chado::Result::QuantificationRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantificationprops

Type: has_many

Related object: L<html_dir::Chado::Result::Quantificationprop>

=cut

__PACKAGE__->has_many(
  "quantificationprops",
  "html_dir::Chado::Result::Quantificationprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_cvtermprops

Type: has_many

Related object: L<html_dir::Chado::Result::StockCvtermprop>

=cut

__PACKAGE__->has_many(
  "stock_cvtermprops",
  "html_dir::Chado::Result::StockCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::StockCvterm>

=cut

__PACKAGE__->has_many(
  "stock_cvterms",
  "html_dir::Chado::Result::StockCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_dbxrefprops

Type: has_many

Related object: L<html_dir::Chado::Result::StockDbxrefprop>

=cut

__PACKAGE__->has_many(
  "stock_dbxrefprops",
  "html_dir::Chado::Result::StockDbxrefprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_featuremaps

Type: has_many

Related object: L<html_dir::Chado::Result::StockFeaturemap>

=cut

__PACKAGE__->has_many(
  "stock_featuremaps",
  "html_dir::Chado::Result::StockFeaturemap",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_features

Type: has_many

Related object: L<html_dir::Chado::Result::StockFeature>

=cut

__PACKAGE__->has_many(
  "stock_features",
  "html_dir::Chado::Result::StockFeature",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_relationship_cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::StockRelationshipCvterm>

=cut

__PACKAGE__->has_many(
  "stock_relationship_cvterms",
  "html_dir::Chado::Result::StockRelationshipCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_relationships

Type: has_many

Related object: L<html_dir::Chado::Result::StockRelationship>

=cut

__PACKAGE__->has_many(
  "stock_relationships",
  "html_dir::Chado::Result::StockRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollectionprops

Type: has_many

Related object: L<html_dir::Chado::Result::Stockcollectionprop>

=cut

__PACKAGE__->has_many(
  "stockcollectionprops",
  "html_dir::Chado::Result::Stockcollectionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollections

Type: has_many

Related object: L<html_dir::Chado::Result::Stockcollection>

=cut

__PACKAGE__->has_many(
  "stockcollections",
  "html_dir::Chado::Result::Stockcollection",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockprops

Type: has_many

Related object: L<html_dir::Chado::Result::Stockprop>

=cut

__PACKAGE__->has_many(
  "stockprops",
  "html_dir::Chado::Result::Stockprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stocks

Type: has_many

Related object: L<html_dir::Chado::Result::Stock>

=cut

__PACKAGE__->has_many(
  "stocks",
  "html_dir::Chado::Result::Stock",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studydesignprops

Type: has_many

Related object: L<html_dir::Chado::Result::Studydesignprop>

=cut

__PACKAGE__->has_many(
  "studydesignprops",
  "html_dir::Chado::Result::Studydesignprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyfactors

Type: has_many

Related object: L<html_dir::Chado::Result::Studyfactor>

=cut

__PACKAGE__->has_many(
  "studyfactors",
  "html_dir::Chado::Result::Studyfactor",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyprop_features

Type: has_many

Related object: L<html_dir::Chado::Result::StudypropFeature>

=cut

__PACKAGE__->has_many(
  "studyprop_features",
  "html_dir::Chado::Result::StudypropFeature",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyprops

Type: has_many

Related object: L<html_dir::Chado::Result::Studyprop>

=cut

__PACKAGE__->has_many(
  "studyprops",
  "html_dir::Chado::Result::Studyprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 synonyms

Type: has_many

Related object: L<html_dir::Chado::Result::Synonym>

=cut

__PACKAGE__->has_many(
  "synonyms",
  "html_dir::Chado::Result::Synonym",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 treatments

Type: has_many

Related object: L<html_dir::Chado::Result::Treatment>

=cut

__PACKAGE__->has_many(
  "treatments",
  "html_dir::Chado::Result::Treatment",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wAqc36r8i+dCUgrNkQFUpQ


__PACKAGE__->has_many(
  "feature_relationships_subject",
  "html_dir::Chado::Result::FeatureRelationship",
  { "foreign.subject_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->meta->make_immutable;
1;
