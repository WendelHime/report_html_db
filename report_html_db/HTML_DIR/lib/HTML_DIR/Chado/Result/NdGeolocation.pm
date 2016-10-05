use utf8;
package HTML_DIR::Chado::Result::NdGeolocation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::NdGeolocation

=head1 DESCRIPTION

The geo-referencable location of the stock. NOTE: This entity is subject to change as a more general and possibly more OpenGIS-compliant geolocation module may be introduced into Chado.

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

=head1 TABLE: C<nd_geolocation>

=cut

__PACKAGE__->table("nd_geolocation");

=head1 ACCESSORS

=head2 nd_geolocation_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nd_geolocation_nd_geolocation_id_seq'

=head2 description

  data_type: 'text'
  is_nullable: 1

A textual representation of the location, if this is the original georeference. Optional if the original georeference is available in lat/long coordinates.

=head2 latitude

  data_type: 'real'
  is_nullable: 1

The decimal latitude coordinate of the georeference, using positive and negative sign to indicate N and S, respectively.

=head2 longitude

  data_type: 'real'
  is_nullable: 1

The decimal longitude coordinate of the georeference, using positive and negative sign to indicate E and W, respectively.

=head2 geodetic_datum

  data_type: 'varchar'
  is_nullable: 1
  size: 32

The geodetic system on which the geo-reference coordinates are based. For geo-references measured between 1984 and 2010, this will typically be WGS84.

=head2 altitude

  data_type: 'real'
  is_nullable: 1

The altitude (elevation) of the location in meters. If the altitude is only known as a range, this is the average, and altitude_dev will hold half of the width of the range.

=cut

__PACKAGE__->add_columns(
  "nd_geolocation_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nd_geolocation_nd_geolocation_id_seq",
  },
  "description",
  { data_type => "text", is_nullable => 1 },
  "latitude",
  { data_type => "real", is_nullable => 1 },
  "longitude",
  { data_type => "real", is_nullable => 1 },
  "geodetic_datum",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "altitude",
  { data_type => "real", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nd_geolocation_id>

=back

=cut

__PACKAGE__->set_primary_key("nd_geolocation_id");

=head1 RELATIONS

=head2 nd_experiments

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdExperiment>

=cut

__PACKAGE__->has_many(
  "nd_experiments",
  "HTML_DIR::Chado::Result::NdExperiment",
  { "foreign.nd_geolocation_id" => "self.nd_geolocation_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 nd_geolocationprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::NdGeolocationprop>

=cut

__PACKAGE__->has_many(
  "nd_geolocationprops",
  "HTML_DIR::Chado::Result::NdGeolocationprop",
  { "foreign.nd_geolocation_id" => "self.nd_geolocation_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-05 16:38:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aqFzO+siNhani8nGAvmX8Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
