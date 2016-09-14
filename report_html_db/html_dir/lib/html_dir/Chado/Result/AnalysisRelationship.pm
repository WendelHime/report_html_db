use utf8;
package html_dir::Chado::Result::AnalysisRelationship;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::AnalysisRelationship - Table that stores relationships between programs.

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

=head1 TABLE: C<analysis_relationship>

=cut

__PACKAGE__->table("analysis_relationship");

=head1 ACCESSORS

=head2 analysis_relationship_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'analysis_relationship_analysis_relationship_id_seq'

=head2 subject_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

analysis_relationship.subject_id i
s the subject of the subj-predicate-obj sentence.

=head2 object_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

analysis_relationship.object_id 
is the object of the subj-predicate-obj sentence.

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

analysis_relationship.type_id 
is relationship type between subject and object. This is a cvterm, typically 
from the OBO relationship ontology, although other relationship types are allowed.

=head2 value

  data_type: 'text'
  is_nullable: 1

analysis_relationship.value 
is for additional notes or comments.

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

analysis_relationship.rank is 
the ordering of subject analysiss with respect to the object analysis may be 
important where rank is used to order these; starts from zero.

=cut

__PACKAGE__->add_columns(
  "analysis_relationship_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "analysis_relationship_analysis_relationship_id_seq",
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

=item * L</analysis_relationship_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_relationship_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<analysis_relationship_c1>

=over 4

=item * L</subject_id>

=item * L</object_id>

=item * L</type_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "analysis_relationship_c1",
  ["subject_id", "object_id", "type_id", "rank"],
);

=head1 RELATIONS

=head2 object

Type: belongs_to

Related object: L<html_dir::Chado::Result::Analysis>

=cut

__PACKAGE__->belongs_to(
  "object",
  "html_dir::Chado::Result::Analysis",
  { analysis_id => "object_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 subject

Type: belongs_to

Related object: L<html_dir::Chado::Result::Analysis>

=cut

__PACKAGE__->belongs_to(
  "subject",
  "html_dir::Chado::Result::Analysis",
  { analysis_id => "subject_id" },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mOOGT/hXLYq2IbFmAVdA/A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
