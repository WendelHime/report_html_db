use utf8;
package HTML_DIR::Chado::Result::Elementresult;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Elementresult

=head1 DESCRIPTION

An element on an array produces a measurement when hybridized to a biomaterial (traceable through quantification_id). This is the base data from which tables that actually contain data inherit.

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

=head1 TABLE: C<elementresult>

=cut

__PACKAGE__->table("elementresult");

=head1 ACCESSORS

=head2 elementresult_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'elementresult_elementresult_id_seq'

=head2 element_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 quantification_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 signal

  data_type: 'double precision'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "elementresult_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "elementresult_elementresult_id_seq",
  },
  "element_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "quantification_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "signal",
  { data_type => "double precision", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</elementresult_id>

=back

=cut

__PACKAGE__->set_primary_key("elementresult_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<elementresult_c1>

=over 4

=item * L</element_id>

=item * L</quantification_id>

=back

=cut

__PACKAGE__->add_unique_constraint("elementresult_c1", ["element_id", "quantification_id"]);

=head1 RELATIONS

=head2 element

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Element>

=cut

__PACKAGE__->belongs_to(
  "element",
  "HTML_DIR::Chado::Result::Element",
  { element_id => "element_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 elementresult_relationship_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ElementresultRelationship>

=cut

__PACKAGE__->has_many(
  "elementresult_relationship_objects",
  "HTML_DIR::Chado::Result::ElementresultRelationship",
  { "foreign.object_id" => "self.elementresult_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 elementresult_relationship_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::ElementresultRelationship>

=cut

__PACKAGE__->has_many(
  "elementresult_relationship_subjects",
  "HTML_DIR::Chado::Result::ElementresultRelationship",
  { "foreign.subject_id" => "self.elementresult_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantification

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Quantification>

=cut

__PACKAGE__->belongs_to(
  "quantification",
  "HTML_DIR::Chado::Result::Quantification",
  { quantification_id => "quantification_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ERmhmkx3kqgE+uh67JhzMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
