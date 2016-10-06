use utf8;
package HTML_DIR::Chado::Result::Organism;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Organism

=head1 DESCRIPTION

The organismal taxonomic
classification. Note that phylogenies are represented using the
phylogeny module, and taxonomies can be represented using the cvterm
module or the phylogeny module.

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

=head1 TABLE: C<organism>

=cut

__PACKAGE__->table("organism");

=head1 ACCESSORS

=head2 organism_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'organism_organism_id_seq'

=head2 abbreviation

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 genus

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 species

  data_type: 'varchar'
  is_nullable: 0
  size: 255

A type of organism is always
uniquely identified by genus and species. When mapping from the NCBI
taxonomy names.dmp file, this column must be used where it
is present, as the common_name column is not always unique (e.g. environmental
samples). If a particular strain or subspecies is to be represented,
this is appended onto the species name. Follows standard NCBI taxonomy
pattern.

=head2 common_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 infraspecific_name

  data_type: 'varchar'
  is_nullable: 1
  size: 1024

The scientific name for any taxon 
below the rank of species.  The rank should be specified using the type_id field
and the name is provided here.

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

A controlled vocabulary term that
specifies the organism rank below species. It is used when an infraspecific 
name is provided.  Ideally, the rank should be a valid ICN name such as 
subspecies, varietas, subvarietas, forma and subforma

=head2 comment

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "organism_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "organism_organism_id_seq",
  },
  "abbreviation",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "genus",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "species",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "common_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "infraspecific_name",
  { data_type => "varchar", is_nullable => 1, size => 1024 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "comment",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</organism_id>

=back

=cut

__PACKAGE__->set_primary_key("organism_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<organism_c1>

=over 4

=item * L</genus>

=item * L</species>

=item * L</type_id>

=item * L</infraspecific_name>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "organism_c1",
  ["genus", "species", "type_id", "infraspecific_name"],
);

=head1 RELATIONS

=head2 biomaterials

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Biomaterial>

=cut

__PACKAGE__->has_many(
  "biomaterials",
  "HTML_DIR::Chado::Result::Biomaterial",
  { "foreign.taxon_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cell_lines

Type: has_many

Related object: L<HTML_DIR::Chado::Result::CellLine>

=cut

__PACKAGE__->has_many(
  "cell_lines",
  "HTML_DIR::Chado::Result::CellLine",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 featuremap_organisms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::FeaturemapOrganism>

=cut

__PACKAGE__->has_many(
  "featuremap_organisms",
  "HTML_DIR::Chado::Result::FeaturemapOrganism",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 features

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Feature>

=cut

__PACKAGE__->has_many(
  "features",
  "HTML_DIR::Chado::Result::Feature",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 libraries

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Library>

=cut

__PACKAGE__->has_many(
  "libraries",
  "HTML_DIR::Chado::Result::Library",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismCvterm>

=cut

__PACKAGE__->has_many(
  "organism_cvterms",
  "HTML_DIR::Chado::Result::OrganismCvterm",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_dbxrefs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismDbxref>

=cut

__PACKAGE__->has_many(
  "organism_dbxrefs",
  "HTML_DIR::Chado::Result::OrganismDbxref",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_pubs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismPub>

=cut

__PACKAGE__->has_many(
  "organism_pubs",
  "HTML_DIR::Chado::Result::OrganismPub",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_relationship_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismRelationship>

=cut

__PACKAGE__->has_many(
  "organism_relationship_objects",
  "HTML_DIR::Chado::Result::OrganismRelationship",
  { "foreign.object_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organism_relationship_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::OrganismRelationship>

=cut

__PACKAGE__->has_many(
  "organism_relationship_subjects",
  "HTML_DIR::Chado::Result::OrganismRelationship",
  { "foreign.subject_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 organismprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Organismprop>

=cut

__PACKAGE__->has_many(
  "organismprops",
  "HTML_DIR::Chado::Result::Organismprop",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_comparisons

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PhenotypeComparison>

=cut

__PACKAGE__->has_many(
  "phenotype_comparisons",
  "HTML_DIR::Chado::Result::PhenotypeComparison",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phylonode_organisms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PhylonodeOrganism>

=cut

__PACKAGE__->has_many(
  "phylonode_organisms",
  "HTML_DIR::Chado::Result::PhylonodeOrganism",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stocks

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Stock>

=cut

__PACKAGE__->has_many(
  "stocks",
  "HTML_DIR::Chado::Result::Stock",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DvUlbQEzi39A/CIfp+DpRQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
