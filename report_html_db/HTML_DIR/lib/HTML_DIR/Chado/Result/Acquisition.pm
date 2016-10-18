use utf8;
package HTML_DIR::Chado::Result::Acquisition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Acquisition

=head1 DESCRIPTION

This represents the scanning of hybridized material. The output of this process is typically a digital image of an array.

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

=head1 TABLE: C<acquisition>

=cut

__PACKAGE__->table("acquisition");

=head1 ACCESSORS

=head2 acquisition_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'acquisition_acquisition_id_seq'

=head2 assay_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 protocol_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 channel_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 acquisitiondate

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
  "acquisition_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "acquisition_acquisition_id_seq",
  },
  "assay_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "protocol_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "channel_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "acquisitiondate",
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

=item * L</acquisition_id>

=back

=cut

__PACKAGE__->set_primary_key("acquisition_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<acquisition_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("acquisition_c1", ["name"]);

=head1 RELATIONS

=head2 acquisition_relationship_objects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::AcquisitionRelationship>

=cut

__PACKAGE__->has_many(
  "acquisition_relationship_objects",
  "HTML_DIR::Chado::Result::AcquisitionRelationship",
  { "foreign.object_id" => "self.acquisition_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 acquisition_relationship_subjects

Type: has_many

Related object: L<HTML_DIR::Chado::Result::AcquisitionRelationship>

=cut

__PACKAGE__->has_many(
  "acquisition_relationship_subjects",
  "HTML_DIR::Chado::Result::AcquisitionRelationship",
  { "foreign.subject_id" => "self.acquisition_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 acquisitionprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Acquisitionprop>

=cut

__PACKAGE__->has_many(
  "acquisitionprops",
  "HTML_DIR::Chado::Result::Acquisitionprop",
  { "foreign.acquisition_id" => "self.acquisition_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Assay>

=cut

__PACKAGE__->belongs_to(
  "assay",
  "HTML_DIR::Chado::Result::Assay",
  { assay_id => "assay_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 channel

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Channel>

=cut

__PACKAGE__->belongs_to(
  "channel",
  "HTML_DIR::Chado::Result::Channel",
  { channel_id => "channel_id" },
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

=head2 quantifications

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Quantification>

=cut

__PACKAGE__->has_many(
  "quantifications",
  "HTML_DIR::Chado::Result::Quantification",
  { "foreign.acquisition_id" => "self.acquisition_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Q6t9RDobw27EJKp5214KHQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
