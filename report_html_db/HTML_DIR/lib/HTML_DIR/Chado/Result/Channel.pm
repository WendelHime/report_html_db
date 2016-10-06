use utf8;
package HTML_DIR::Chado::Result::Channel;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Channel

=head1 DESCRIPTION

Different array platforms can record signals from one or more channels (cDNA arrays typically use two CCD, but Affymetrix uses only one).

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

=head1 TABLE: C<channel>

=cut

__PACKAGE__->table("channel");

=head1 ACCESSORS

=head2 channel_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'channel_channel_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 definition

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "channel_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "channel_channel_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "definition",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</channel_id>

=back

=cut

__PACKAGE__->set_primary_key("channel_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<channel_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("channel_c1", ["name"]);

=head1 RELATIONS

=head2 acquisitions

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Acquisition>

=cut

__PACKAGE__->has_many(
  "acquisitions",
  "HTML_DIR::Chado::Result::Acquisition",
  { "foreign.channel_id" => "self.channel_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay_biomaterials

Type: has_many

Related object: L<HTML_DIR::Chado::Result::AssayBiomaterial>

=cut

__PACKAGE__->has_many(
  "assay_biomaterials",
  "HTML_DIR::Chado::Result::AssayBiomaterial",
  { "foreign.channel_id" => "self.channel_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tjHG31eoTTmQ6JsyLklBtg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
