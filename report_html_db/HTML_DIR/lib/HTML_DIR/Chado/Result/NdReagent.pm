use utf8;
package HTML_DIR::Chado::Result::NdReagent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::NdReagent

=head1 DESCRIPTION

A reagent such as a primer, an enzyme, an adapter oligo, a linker oligo. Reagents are used in genotyping experiments, or in any other kind of experiment.

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

=head1 TABLE: C<nd_reagent>

=cut

__PACKAGE__->table("nd_reagent");

=head1 ACCESSORS

=head2 nd_reagent_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nd_reagent_nd_reagent_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 80

The name of the reagent. The name should be unique for a given type.

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The type of the reagent, for example linker oligomer, or forward primer.

=head2 feature_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

If the reagent is a primer, the feature that it corresponds to. More generally, the corresponding feature for any reagent that has a sequence that maps to another sequence.

=cut

__PACKAGE__->add_columns(
  "nd_reagent_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nd_reagent_nd_reagent_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "feature_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nd_reagent_id>

=back

=cut

__PACKAGE__->set_primary_key("nd_reagent_id");

=head1 RELATIONS

=head2 feature

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Feature>

=cut

__PACKAGE__->belongs_to(
  "feature",
  "HTML_DIR::Chado::Result::Feature",
  { feature_id => "feature_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);

=head2 nd_protocol_reagents

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdProtocolReagent>

=cut

__PACKAGE__->has_many(
  "nd_protocol_reagents",
  "HTML_DIR::Chado::Result::NdProtocolReagent",
  { "foreign.reagent_id" => "self.nd_reagent_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagent_relationship_object_reagents

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdReagentRelationship>

=cut

__PACKAGE__->has_many(
  "nd_reagent_relationship_object_reagents",
  "HTML_DIR::Chado::Result::NdReagentRelationship",
  { "foreign.object_reagent_id" => "self.nd_reagent_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagent_relationship_subject_reagents

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdReagentRelationship>

=cut

__PACKAGE__->has_many(
  "nd_reagent_relationship_subject_reagents",
  "HTML_DIR::Chado::Result::NdReagentRelationship",
  { "foreign.subject_reagent_id" => "self.nd_reagent_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_reagentprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdReagentprop>

=cut

__PACKAGE__->has_many(
  "nd_reagentprops",
  "HTML_DIR::Chado::Result::NdReagentprop",
  { "foreign.nd_reagent_id" => "self.nd_reagent_id" },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-05 16:38:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+WbG61dd63BipVkSelNYNA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
