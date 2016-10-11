use utf8;
package HTML_DIR::Chado::Result::Cvterm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Cvterm

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

Related object: L<HTML_DIR::Chado::Result::AcquisitionRelationship>

=cut

__PACKAGE__->has_many(
  "acquisition_relationships",
  "HTML_DIR::Chado::Result::AcquisitionRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 acquisitionprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Acquisitionprop>

=cut

__PACKAGE__->has_many(
  "acquisitionprops",
  "HTML_DIR::Chado::Result::Acquisitionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::AnalysisCvterm>

=cut

__PACKAGE__->has_many(
  "analysis_cvterms",
  "HTML_DIR::Chado::Result::AnalysisCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_operations

Type: has_many

Related object: L<HTML_DIR::Chado::Result::AnalysisOperation>

=cut

__PACKAGE__->has_many(
  "analysis_operations",
  "HTML_DIR::Chado::Result::AnalysisOperation",
  { "foreign.type_operation_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::AnalysisRelationship>

=cut

__PACKAGE__->has_many(
  "analysis_relationships",
  "HTML_DIR::Chado::Result::AnalysisRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysisfeatureprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Analysisfeatureprop>

=cut

__PACKAGE__->has_many(
  "analysisfeatureprops",
  "HTML_DIR::Chado::Result::Analysisfeatureprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysisprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Analysisprop>

=cut

__PACKAGE__->has_many(
  "analysisprops",
  "HTML_DIR::Chado::Result::Analysisprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesign_platformtypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Arraydesign>

=cut

__PACKAGE__->has_many(
  "arraydesign_platformtypes",
  "HTML_DIR::Chado::Result::Arraydesign",
  { "foreign.platformtype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesign_substratetypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Arraydesign>

=cut

__PACKAGE__->has_many(
  "arraydesign_substratetypes",
  "HTML_DIR::Chado::Result::Arraydesign",
  { "foreign.substratetype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesignprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Arraydesignprop>

=cut

__PACKAGE__->has_many(
  "arraydesignprops",
  "HTML_DIR::Chado::Result::Arraydesignprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assayprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Assayprop>

=cut

__PACKAGE__->has_many(
  "assayprops",
  "HTML_DIR::Chado::Result::Assayprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::BiomaterialRelationship>

=cut

__PACKAGE__->has_many(
  "biomaterial_relationships",
  "HTML_DIR::Chado::Result::BiomaterialRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterial_treatments

Type: has_many

Related object: L<HTML_DIR::Chado::Result::BiomaterialTreatment>

=cut

__PACKAGE__->has_many(
  "biomaterial_treatments",
  "HTML_DIR::Chado::Result::BiomaterialTreatment",
  { "foreign.unittype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 biomaterialprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Biomaterialprop>

=cut

__PACKAGE__->has_many(
  "biomaterialprops",
  "HTML_DIR::Chado::Result::Biomaterialprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_line_cvtermprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CellLineCvtermprop>

=cut

__PACKAGE__->has_many(
  "cell_line_cvtermprops",
  "HTML_DIR::Chado::Result::CellLineCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_line_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CellLineCvterm>

=cut

__PACKAGE__->has_many(
  "cell_line_cvterms",
  "HTML_DIR::Chado::Result::CellLineCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_line_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CellLineRelationship>

=cut

__PACKAGE__->has_many(
  "cell_line_relationships",
  "HTML_DIR::Chado::Result::CellLineRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_lineprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CellLineprop>

=cut

__PACKAGE__->has_many(
  "cell_lineprops",
  "HTML_DIR::Chado::Result::CellLineprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 chadoprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Chadoprop>

=cut

__PACKAGE__->has_many(
  "chadoprops",
  "HTML_DIR::Chado::Result::Chadoprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contact_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ContactRelationship>

=cut

__PACKAGE__->has_many(
  "contact_relationships",
  "HTML_DIR::Chado::Result::ContactRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contactprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Contactprop>

=cut

__PACKAGE__->has_many(
  "contactprops",
  "HTML_DIR::Chado::Result::Contactprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 contacts

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Contact>

=cut

__PACKAGE__->has_many(
  "contacts",
  "HTML_DIR::Chado::Result::Contact",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 controls

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Control>

=cut

__PACKAGE__->has_many(
  "controls",
  "HTML_DIR::Chado::Result::Control",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cv

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cv>

=cut

__PACKAGE__->belongs_to(
  "cv",
  "HTML_DIR::Chado::Result::Cv",
  { cv_id => "cv_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 cvprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvprop>

=cut

__PACKAGE__->has_many(
  "cvprops",
  "HTML_DIR::Chado::Result::Cvprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_dbxrefs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CvtermDbxref>

=cut

__PACKAGE__->has_many(
  "cvterm_dbxrefs",
  "HTML_DIR::Chado::Result::CvtermDbxref",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_relationship_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CvtermRelationship>

=cut

__PACKAGE__->has_many(
  "cvterm_relationship_objects",
  "HTML_DIR::Chado::Result::CvtermRelationship",
  { "foreign.object_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_relationship_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CvtermRelationship>

=cut

__PACKAGE__->has_many(
  "cvterm_relationship_subjects",
  "HTML_DIR::Chado::Result::CvtermRelationship",
  { "foreign.subject_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterm_relationship_types

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CvtermRelationship>

=cut

__PACKAGE__->has_many(
  "cvterm_relationship_types",
  "HTML_DIR::Chado::Result::CvtermRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermpath_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvtermpath>

=cut

__PACKAGE__->has_many(
  "cvtermpath_objects",
  "HTML_DIR::Chado::Result::Cvtermpath",
  { "foreign.object_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermpath_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvtermpath>

=cut

__PACKAGE__->has_many(
  "cvtermpath_subjects",
  "HTML_DIR::Chado::Result::Cvtermpath",
  { "foreign.subject_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermpath_types

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvtermpath>

=cut

__PACKAGE__->has_many(
  "cvtermpath_types",
  "HTML_DIR::Chado::Result::Cvtermpath",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermprop_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvtermprop>

=cut

__PACKAGE__->has_many(
  "cvtermprop_cvterms",
  "HTML_DIR::Chado::Result::Cvtermprop",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermprop_types

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvtermprop>

=cut

__PACKAGE__->has_many(
  "cvtermprop_types",
  "HTML_DIR::Chado::Result::Cvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermsynonym_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvtermsynonym>

=cut

__PACKAGE__->has_many(
  "cvtermsynonym_cvterms",
  "HTML_DIR::Chado::Result::Cvtermsynonym",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermsynonym_types

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Cvtermsynonym>

=cut

__PACKAGE__->has_many(
  "cvtermsynonym_types",
  "HTML_DIR::Chado::Result::Cvtermsynonym",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Dbprop>

=cut

__PACKAGE__->has_many(
  "dbprops",
  "HTML_DIR::Chado::Result::Dbprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbxref

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "HTML_DIR::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  { is_deferrable => 1, on_delete => "SET NULL", on_update => "NO ACTION" },
);

=head2 dbxrefprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Dbxrefprop>

=cut

__PACKAGE__->has_many(
  "dbxrefprops",
  "HTML_DIR::Chado::Result::Dbxrefprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 element_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ElementRelationship>

=cut

__PACKAGE__->has_many(
  "element_relationships",
  "HTML_DIR::Chado::Result::ElementRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 elementresult_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ElementresultRelationship>

=cut

__PACKAGE__->has_many(
  "elementresult_relationships",
  "HTML_DIR::Chado::Result::ElementresultRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 elements

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Element>

=cut

__PACKAGE__->has_many(
  "elements",
  "HTML_DIR::Chado::Result::Element",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 environment_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::EnvironmentCvterm>

=cut

__PACKAGE__->has_many(
  "environment_cvterms",
  "HTML_DIR::Chado::Result::EnvironmentCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expression_cvterm_cvterm_types

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ExpressionCvterm>

=cut

__PACKAGE__->has_many(
  "expression_cvterm_cvterm_types",
  "HTML_DIR::Chado::Result::ExpressionCvterm",
  { "foreign.cvterm_type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expression_cvterm_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ExpressionCvterm>

=cut

__PACKAGE__->has_many(
  "expression_cvterm_cvterms",
  "HTML_DIR::Chado::Result::ExpressionCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expression_cvtermprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ExpressionCvtermprop>

=cut

__PACKAGE__->has_many(
  "expression_cvtermprops",
  "HTML_DIR::Chado::Result::ExpressionCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 expressionprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Expressionprop>

=cut

__PACKAGE__->has_many(
  "expressionprops",
  "HTML_DIR::Chado::Result::Expressionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_cvtermprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureCvtermprop>

=cut

__PACKAGE__->has_many(
  "feature_cvtermprops",
  "HTML_DIR::Chado::Result::FeatureCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureCvterm>

=cut

__PACKAGE__->has_many(
  "feature_cvterms",
  "HTML_DIR::Chado::Result::FeatureCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_expressionprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureExpressionprop>

=cut

__PACKAGE__->has_many(
  "feature_expressionprops",
  "HTML_DIR::Chado::Result::FeatureExpressionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_genotypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureGenotype>

=cut

__PACKAGE__->has_many(
  "feature_genotypes",
  "HTML_DIR::Chado::Result::FeatureGenotype",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_pubprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeaturePubprop>

=cut

__PACKAGE__->has_many(
  "feature_pubprops",
  "HTML_DIR::Chado::Result::FeaturePubprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_relationshipprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureRelationshipprop>

=cut

__PACKAGE__->has_many(
  "feature_relationshipprops",
  "HTML_DIR::Chado::Result::FeatureRelationshipprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeatureRelationship>

=cut

__PACKAGE__->has_many(
  "feature_relationships",
  "HTML_DIR::Chado::Result::FeatureRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremapprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Featuremapprop>

=cut

__PACKAGE__->has_many(
  "featuremapprops",
  "HTML_DIR::Chado::Result::Featuremapprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremaps

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Featuremap>

=cut

__PACKAGE__->has_many(
  "featuremaps",
  "HTML_DIR::Chado::Result::Featuremap",
  { "foreign.unittype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featureposprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Featureposprop>

=cut

__PACKAGE__->has_many(
  "featureposprops",
  "HTML_DIR::Chado::Result::Featureposprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featureprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Featureprop>

=cut

__PACKAGE__->has_many(
  "featureprops",
  "HTML_DIR::Chado::Result::Featureprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 features

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Feature>

=cut

__PACKAGE__->has_many(
  "features",
  "HTML_DIR::Chado::Result::Feature",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 genotypeprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Genotypeprop>

=cut

__PACKAGE__->has_many(
  "genotypeprops",
  "HTML_DIR::Chado::Result::Genotypeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 genotypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Genotype>

=cut

__PACKAGE__->has_many(
  "genotypes",
  "HTML_DIR::Chado::Result::Genotype",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 libraries

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Library>

=cut

__PACKAGE__->has_many(
  "libraries",
  "HTML_DIR::Chado::Result::Library",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryCvterm>

=cut

__PACKAGE__->has_many(
  "library_cvterms",
  "HTML_DIR::Chado::Result::LibraryCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_expressionprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryExpressionprop>

=cut

__PACKAGE__->has_many(
  "library_expressionprops",
  "HTML_DIR::Chado::Result::LibraryExpressionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_featureprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryFeatureprop>

=cut

__PACKAGE__->has_many(
  "library_featureprops",
  "HTML_DIR::Chado::Result::LibraryFeatureprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::LibraryRelationship>

=cut

__PACKAGE__->has_many(
  "library_relationships",
  "HTML_DIR::Chado::Result::LibraryRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 libraryprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Libraryprop>

=cut

__PACKAGE__->has_many(
  "libraryprops",
  "HTML_DIR::Chado::Result::Libraryprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_analyses

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentAnalysis>

=cut

__PACKAGE__->has_many(
  "nd_experiment_analyses",
  "HTML_DIR::Chado::Result::NdExperimentAnalysis",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_stockprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentStockprop>

=cut

__PACKAGE__->has_many(
  "nd_experiment_stockprops",
  "HTML_DIR::Chado::Result::NdExperimentStockprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiment_stocks

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentStock>

=cut

__PACKAGE__->has_many(
  "nd_experiment_stocks",
  "HTML_DIR::Chado::Result::NdExperimentStock",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experimentprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentprop>

=cut

__PACKAGE__->has_many(
  "nd_experimentprops",
  "HTML_DIR::Chado::Result::NdExperimentprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_experiments

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperiment>

=cut

__PACKAGE__->has_many(
  "nd_experiments",
  "HTML_DIR::Chado::Result::NdExperiment",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_geolocationprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdGeolocationprop>

=cut

__PACKAGE__->has_many(
  "nd_geolocationprops",
  "HTML_DIR::Chado::Result::NdGeolocationprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocol_reagents

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdProtocolReagent>

=cut

__PACKAGE__->has_many(
  "nd_protocol_reagents",
  "HTML_DIR::Chado::Result::NdProtocolReagent",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocolprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdProtocolprop>

=cut

__PACKAGE__->has_many(
  "nd_protocolprops",
  "HTML_DIR::Chado::Result::NdProtocolprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocols

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdProtocol>

=cut

__PACKAGE__->has_many(
  "nd_protocols",
  "HTML_DIR::Chado::Result::NdProtocol",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagent_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdReagentRelationship>

=cut

__PACKAGE__->has_many(
  "nd_reagent_relationships",
  "HTML_DIR::Chado::Result::NdReagentRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagentprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdReagentprop>

=cut

__PACKAGE__->has_many(
  "nd_reagentprops",
  "HTML_DIR::Chado::Result::NdReagentprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagents

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdReagent>

=cut

__PACKAGE__->has_many(
  "nd_reagents",
  "HTML_DIR::Chado::Result::NdReagent",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 operations

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Operation>

=cut

__PACKAGE__->has_many(
  "operations",
  "HTML_DIR::Chado::Result::Operation",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_cvtermprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismCvtermprop>

=cut

__PACKAGE__->has_many(
  "organism_cvtermprops",
  "HTML_DIR::Chado::Result::OrganismCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismCvterm>

=cut

__PACKAGE__->has_many(
  "organism_cvterms",
  "HTML_DIR::Chado::Result::OrganismCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismRelationship>

=cut

__PACKAGE__->has_many(
  "organism_relationships",
  "HTML_DIR::Chado::Result::OrganismRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organismprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Organismprop>

=cut

__PACKAGE__->has_many(
  "organismprops",
  "HTML_DIR::Chado::Result::Organismprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organisms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Organism>

=cut

__PACKAGE__->has_many(
  "organisms",
  "HTML_DIR::Chado::Result::Organism",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phendescs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phendesc>

=cut

__PACKAGE__->has_many(
  "phendescs",
  "HTML_DIR::Chado::Result::Phendesc",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_assays

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_assays",
  "HTML_DIR::Chado::Result::Phenotype",
  { "foreign.assay_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_attrs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_attrs",
  "HTML_DIR::Chado::Result::Phenotype",
  { "foreign.attr_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_comparison_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PhenotypeComparisonCvterm>

=cut

__PACKAGE__->has_many(
  "phenotype_comparison_cvterms",
  "HTML_DIR::Chado::Result::PhenotypeComparisonCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_cvalues

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_cvalues",
  "HTML_DIR::Chado::Result::Phenotype",
  { "foreign.cvalue_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PhenotypeCvterm>

=cut

__PACKAGE__->has_many(
  "phenotype_cvterms",
  "HTML_DIR::Chado::Result::PhenotypeCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_observables

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phenotype>

=cut

__PACKAGE__->has_many(
  "phenotype_observables",
  "HTML_DIR::Chado::Result::Phenotype",
  { "foreign.observable_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotypeprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phenotypeprop>

=cut

__PACKAGE__->has_many(
  "phenotypeprops",
  "HTML_DIR::Chado::Result::Phenotypeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenstatements

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phenstatement>

=cut

__PACKAGE__->has_many(
  "phenstatements",
  "HTML_DIR::Chado::Result::Phenstatement",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonode_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PhylonodeRelationship>

=cut

__PACKAGE__->has_many(
  "phylonode_relationships",
  "HTML_DIR::Chado::Result::PhylonodeRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonodeprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phylonodeprop>

=cut

__PACKAGE__->has_many(
  "phylonodeprops",
  "HTML_DIR::Chado::Result::Phylonodeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonodes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phylonode>

=cut

__PACKAGE__->has_many(
  "phylonodes",
  "HTML_DIR::Chado::Result::Phylonode",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylotreeprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phylotreeprop>

=cut

__PACKAGE__->has_many(
  "phylotreeprops",
  "HTML_DIR::Chado::Result::Phylotreeprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylotrees

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phylotree>

=cut

__PACKAGE__->has_many(
  "phylotrees",
  "HTML_DIR::Chado::Result::Phylotree",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ProjectRelationship>

=cut

__PACKAGE__->has_many(
  "project_relationships",
  "HTML_DIR::Chado::Result::ProjectRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projectprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Projectprop>

=cut

__PACKAGE__->has_many(
  "projectprops",
  "HTML_DIR::Chado::Result::Projectprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 protocolparam_datatypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Protocolparam>

=cut

__PACKAGE__->has_many(
  "protocolparam_datatypes",
  "HTML_DIR::Chado::Result::Protocolparam",
  { "foreign.datatype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 protocolparam_unittypes

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Protocolparam>

=cut

__PACKAGE__->has_many(
  "protocolparam_unittypes",
  "HTML_DIR::Chado::Result::Protocolparam",
  { "foreign.unittype_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 protocols

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Protocol>

=cut

__PACKAGE__->has_many(
  "protocols",
  "HTML_DIR::Chado::Result::Protocol",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pub_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PubRelationship>

=cut

__PACKAGE__->has_many(
  "pub_relationships",
  "HTML_DIR::Chado::Result::PubRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pubprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Pubprop>

=cut

__PACKAGE__->has_many(
  "pubprops",
  "HTML_DIR::Chado::Result::Pubprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pubs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->has_many(
  "pubs",
  "HTML_DIR::Chado::Result::Pub",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantification_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::QuantificationRelationship>

=cut

__PACKAGE__->has_many(
  "quantification_relationships",
  "HTML_DIR::Chado::Result::QuantificationRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantificationprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Quantificationprop>

=cut

__PACKAGE__->has_many(
  "quantificationprops",
  "HTML_DIR::Chado::Result::Quantificationprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_cvtermprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockCvtermprop>

=cut

__PACKAGE__->has_many(
  "stock_cvtermprops",
  "HTML_DIR::Chado::Result::StockCvtermprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockCvterm>

=cut

__PACKAGE__->has_many(
  "stock_cvterms",
  "HTML_DIR::Chado::Result::StockCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_dbxrefprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockDbxrefprop>

=cut

__PACKAGE__->has_many(
  "stock_dbxrefprops",
  "HTML_DIR::Chado::Result::StockDbxrefprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_featuremaps

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockFeaturemap>

=cut

__PACKAGE__->has_many(
  "stock_featuremaps",
  "HTML_DIR::Chado::Result::StockFeaturemap",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_features

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockFeature>

=cut

__PACKAGE__->has_many(
  "stock_features",
  "HTML_DIR::Chado::Result::StockFeature",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_relationship_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockRelationshipCvterm>

=cut

__PACKAGE__->has_many(
  "stock_relationship_cvterms",
  "HTML_DIR::Chado::Result::StockRelationshipCvterm",
  { "foreign.cvterm_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stock_relationships

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockRelationship>

=cut

__PACKAGE__->has_many(
  "stock_relationships",
  "HTML_DIR::Chado::Result::StockRelationship",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollectionprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Stockcollectionprop>

=cut

__PACKAGE__->has_many(
  "stockcollectionprops",
  "HTML_DIR::Chado::Result::Stockcollectionprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollections

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Stockcollection>

=cut

__PACKAGE__->has_many(
  "stockcollections",
  "HTML_DIR::Chado::Result::Stockcollection",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Stockprop>

=cut

__PACKAGE__->has_many(
  "stockprops",
  "HTML_DIR::Chado::Result::Stockprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stocks

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Stock>

=cut

__PACKAGE__->has_many(
  "stocks",
  "HTML_DIR::Chado::Result::Stock",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studydesignprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Studydesignprop>

=cut

__PACKAGE__->has_many(
  "studydesignprops",
  "HTML_DIR::Chado::Result::Studydesignprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyfactors

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Studyfactor>

=cut

__PACKAGE__->has_many(
  "studyfactors",
  "HTML_DIR::Chado::Result::Studyfactor",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyprop_features

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StudypropFeature>

=cut

__PACKAGE__->has_many(
  "studyprop_features",
  "HTML_DIR::Chado::Result::StudypropFeature",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Studyprop>

=cut

__PACKAGE__->has_many(
  "studyprops",
  "HTML_DIR::Chado::Result::Studyprop",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 synonyms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Synonym>

=cut

__PACKAGE__->has_many(
  "synonyms",
  "HTML_DIR::Chado::Result::Synonym",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 treatments

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Treatment>

=cut

__PACKAGE__->has_many(
  "treatments",
  "HTML_DIR::Chado::Result::Treatment",
  { "foreign.type_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6rdc/5ijvPQOKKRsm7+xjQ


__PACKAGE__->has_many(
  "feature_relationships_subject",
  "HTML_DIR::Chado::Result::FeatureRelationship",
  { "foreign.subject_id" => "self.cvterm_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->meta->make_immutable;
1;
