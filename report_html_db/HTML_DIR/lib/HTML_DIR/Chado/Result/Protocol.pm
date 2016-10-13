use utf8;
package HTML_DIR::Chado::Result::Protocol;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Protocol - Procedural notes on how data was prepared and processed.

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

=head1 TABLE: C<protocol>

=cut

__PACKAGE__->table("protocol");

=head1 ACCESSORS

=head2 protocol_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'protocol_protocol_id_seq'

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 dbxref_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 uri

  data_type: 'text'
  is_nullable: 1

=head2 protocoldescription

  data_type: 'text'
  is_nullable: 1

=head2 hardwaredescription

  data_type: 'text'
  is_nullable: 1

=head2 softwaredescription

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "protocol_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "protocol_protocol_id_seq",
  },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "uri",
  { data_type => "text", is_nullable => 1 },
  "protocoldescription",
  { data_type => "text", is_nullable => 1 },
  "hardwaredescription",
  { data_type => "text", is_nullable => 1 },
  "softwaredescription",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</protocol_id>

=back

=cut

__PACKAGE__->set_primary_key("protocol_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<protocol_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("protocol_c1", ["name"]);

=head1 RELATIONS

=head2 acquisitions

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Acquisition>

=cut

__PACKAGE__->has_many(
  "acquisitions",
  "HTML_DIR::Chado::Result::Acquisition",
  { "foreign.protocol_id" => "self.protocol_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 arraydesigns

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Arraydesign>

=cut

__PACKAGE__->has_many(
  "arraydesigns",
  "HTML_DIR::Chado::Result::Arraydesign",
  { "foreign.protocol_id" => "self.protocol_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assays

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Assay>

=cut

__PACKAGE__->has_many(
  "assays",
  "HTML_DIR::Chado::Result::Assay",
  { "foreign.protocol_id" => "self.protocol_id" },
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
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 protocolparams

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Protocolparam>

=cut

__PACKAGE__->has_many(
  "protocolparams",
  "HTML_DIR::Chado::Result::Protocolparam",
  { "foreign.protocol_id" => "self.protocol_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
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
  { "foreign.protocol_id" => "self.protocol_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 treatments

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Treatment>

=cut

__PACKAGE__->has_many(
  "treatments",
  "HTML_DIR::Chado::Result::Treatment",
  { "foreign.protocol_id" => "self.protocol_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h7VrowYOTo7afSw+Qtl4LQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
