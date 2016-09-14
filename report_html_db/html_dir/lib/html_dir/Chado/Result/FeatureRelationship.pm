use utf8;
package html_dir::Chado::Result::FeatureRelationship;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::FeatureRelationship

=head1 DESCRIPTION

Features can be arranged in
graphs, e.g. "exon part_of transcript part_of gene"; If type is
thought of as a verb, the each arc or edge makes a statement
[Subject Verb Object]. The object can also be thought of as parent
(containing feature), and subject as child (contained feature or
subfeature). We include the relationship rank/order, because even
though most of the time we can order things implicitly by sequence
coordinates, we can not always do this - e.g. transpliced genes. It is also
useful for quickly getting implicit introns.

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

=head1 TABLE: C<feature_relationship>

=cut

__PACKAGE__->table("feature_relationship");

=head1 ACCESSORS

=head2 feature_relationship_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'feature_relationship_feature_relationship_id_seq'

=head2 subject_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The subject of the subj-predicate-obj sentence. This is typically the subfeature.

=head2 object_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The object of the subj-predicate-obj sentence. This is typically the container feature.

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

Relationship type between subject and object. This is a cvterm, typically from the OBO relationship ontology, although other relationship types are allowed. The most common relationship type is OBO_REL:part_of. Valid relationship types are constrained by the Sequence Ontology.

=head2 value

  data_type: 'text'
  is_nullable: 1

Additional notes or comments.

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

The ordering of subject features with respect to the object feature may be important (for example, exon ordering on a transcript - not always derivable if you take trans spliced genes into consideration). Rank is used to order these; starts from zero.

=cut

__PACKAGE__->add_columns(
  "feature_relationship_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "feature_relationship_feature_relationship_id_seq",
  },
  "subject_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "object_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</feature_relationship_id>

=back

=cut

__PACKAGE__->set_primary_key("feature_relationship_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<feature_relationship_c1>

=over 4

=item * L</subject_id>

=item * L</object_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "feature_relationship_c1",
  ["subject_id", "object_id", "type_id", "rank"],
);

=head1 RELATIONS

=head2 feature_relationship_pubs

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureRelationshipPub>

=cut

__PACKAGE__->has_many(
  "feature_relationship_pubs",
  "html_dir::Chado::Result::FeatureRelationshipPub",
  {
    "foreign.feature_relationship_id" => "self.feature_relationship_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 feature_relationshipprops

Type: has_many

Related object: L<html_dir::Chado::Result::FeatureRelationshipprop>

=cut

__PACKAGE__->has_many(
  "feature_relationshipprops",
  "html_dir::Chado::Result::FeatureRelationshipprop",
  {
    "foreign.feature_relationship_id" => "self.feature_relationship_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 object

Type: belongs_to

Related object: L<html_dir::Chado::Result::Feature>

=cut

__PACKAGE__->belongs_to(
  "object",
  "html_dir::Chado::Result::Feature",
  { feature_id => "object_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 subject

Type: belongs_to

Related object: L<html_dir::Chado::Result::Feature>

=cut

__PACKAGE__->belongs_to(
  "subject",
  "html_dir::Chado::Result::Feature",
  { feature_id => "subject_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 type

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JQL8BDaaHqADK0Xkk2Nx9Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
