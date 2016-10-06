use utf8;
package HTML_DIR::Chado::Result::Quantification;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Quantification

=head1 DESCRIPTION

Quantification is the transformation of an image acquisition to numeric data. This typically involves statistical procedures.

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

=head1 TABLE: C<quantification>

=cut

__PACKAGE__->table("quantification");

=head1 ACCESSORS

=head2 quantification_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'quantification_quantification_id_seq'

=head2 acquisition_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 operator_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 protocol_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 analysis_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 quantificationdate

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 uri

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "quantification_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "quantification_quantification_id_seq",
  },
  "acquisition_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "operator_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "protocol_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "analysis_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "quantificationdate",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "uri",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</quantification_id>

=back

=cut

__PACKAGE__->set_primary_key("quantification_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<quantification_c1>

=over 4

=item * L</name>

=item * L</analysis_id>

=back

=cut

__PACKAGE__->add_unique_constraint("quantification_c1", ["name", "analysis_id"]);

=head1 RELATIONS

=head2 acquisition

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Acquisition>

=cut

__PACKAGE__->belongs_to(
  "acquisition",
  "HTML_DIR::Chado::Result::Acquisition",
  { acquisition_id => "acquisition_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 analysis

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Analysis>

=cut

__PACKAGE__->belongs_to(
  "analysis",
  "HTML_DIR::Chado::Result::Analysis",
  { analysis_id => "analysis_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 elementresults

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Elementresult>

=cut

__PACKAGE__->has_many(
  "elementresults",
  "HTML_DIR::Chado::Result::Elementresult",
  { "foreign.quantification_id" => "self.quantification_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 operator

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "operator",
  "HTML_DIR::Chado::Result::Contact",
  { contact_id => "operator_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 protocol

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Protocol>

=cut

__PACKAGE__->belongs_to(
  "protocol",
  "HTML_DIR::Chado::Result::Protocol",
  { protocol_id => "protocol_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 quantification_relationship_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::QuantificationRelationship>

=cut

__PACKAGE__->has_many(
  "quantification_relationship_objects",
  "HTML_DIR::Chado::Result::QuantificationRelationship",
  { "foreign.object_id" => "self.quantification_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantification_relationship_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::QuantificationRelationship>

=cut

__PACKAGE__->has_many(
  "quantification_relationship_subjects",
  "HTML_DIR::Chado::Result::QuantificationRelationship",
  { "foreign.subject_id" => "self.quantification_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 quantificationprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Quantificationprop>

=cut

__PACKAGE__->has_many(
  "quantificationprops",
  "HTML_DIR::Chado::Result::Quantificationprop",
  { "foreign.quantification_id" => "self.quantification_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yJg0VAwe2Fl07sNGjtjneQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
