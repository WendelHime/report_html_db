use utf8;
package HTML_DIR::Chado::Result::NdProtocol;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::NdProtocol

=head1 DESCRIPTION

A protocol can be anything that is done as part of the experiment.

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

=head1 TABLE: C<nd_protocol>

=cut

__PACKAGE__->table("nd_protocol");

=head1 ACCESSORS

=head2 nd_protocol_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nd_protocol_nd_protocol_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The protocol name.

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "nd_protocol_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nd_protocol_nd_protocol_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nd_protocol_id>

=back

=cut

__PACKAGE__->set_primary_key("nd_protocol_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<nd_protocol_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("nd_protocol_name_key", ["name"]);

=head1 RELATIONS

=head2 nd_experiment_protocols

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperimentProtocol>

=cut

__PACKAGE__->has_many(
  "nd_experiment_protocols",
  "HTML_DIR::Chado::Result::NdExperimentProtocol",
  { "foreign.nd_protocol_id" => "self.nd_protocol_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocol_reagents

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdProtocolReagent>

=cut

__PACKAGE__->has_many(
  "nd_protocol_reagents",
  "HTML_DIR::Chado::Result::NdProtocolReagent",
  { "foreign.nd_protocol_id" => "self.nd_protocol_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_protocolprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdProtocolprop>

=cut

__PACKAGE__->has_many(
  "nd_protocolprops",
  "HTML_DIR::Chado::Result::NdProtocolprop",
  { "foreign.nd_protocol_id" => "self.nd_protocol_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ng6sJO9p4yMnAJX3vLUJWQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
