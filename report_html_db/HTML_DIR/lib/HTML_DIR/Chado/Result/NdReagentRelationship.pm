use utf8;
package HTML_DIR::Chado::Result::NdReagentRelationship;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::NdReagentRelationship

=head1 DESCRIPTION

Relationships between reagents. Some reagents form a group. i.e., they are used all together or not at all. Examples are adapter/linker/enzyme experiment reagents.

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

=head1 TABLE: C<nd_reagent_relationship>

=cut

__PACKAGE__->table("nd_reagent_relationship");

=head1 ACCESSORS

=head2 nd_reagent_relationship_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nd_reagent_relationship_nd_reagent_relationship_id_seq'

=head2 subject_reagent_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The subject reagent in the relationship. In parent/child terminology, the subject is the child. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.

=head2 object_reagent_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The object reagent in the relationship. In parent/child terminology, the object is the parent. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

The type (or predicate) of the relationship. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.

=cut

__PACKAGE__->add_columns(
  "nd_reagent_relationship_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nd_reagent_relationship_nd_reagent_relationship_id_seq",
  },
  "subject_reagent_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "object_reagent_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nd_reagent_relationship_id>

=back

=cut

__PACKAGE__->set_primary_key("nd_reagent_relationship_id");

=head1 RELATIONS

=head2 object_reagent

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::NdReagent>

=cut

__PACKAGE__->belongs_to(
  "object_reagent",
  "HTML_DIR::Chado::Result::NdReagent",
  { nd_reagent_id => "object_reagent_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 subject_reagent

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::NdReagent>

=cut

__PACKAGE__->belongs_to(
  "subject_reagent",
  "HTML_DIR::Chado::Result::NdReagent",
  { nd_reagent_id => "subject_reagent_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-05 16:38:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5M6if0qA3PKPnmp68+KWNg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
