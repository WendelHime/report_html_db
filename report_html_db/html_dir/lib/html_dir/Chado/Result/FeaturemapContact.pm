use utf8;
package html_dir::Chado::Result::FeaturemapContact;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::FeaturemapContact

=head1 DESCRIPTION

Links contact(s) with a featuremap.  Used to 
indicate a particular person or organization responsible for constrution of or 
that can provide more information on a particular featuremap.

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

=head1 TABLE: C<featuremap_contact>

=cut

__PACKAGE__->table("featuremap_contact");

=head1 ACCESSORS

=head2 featuremap_contact_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'featuremap_contact_featuremap_contact_id_seq'

=head2 featuremap_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 contact_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "featuremap_contact_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "featuremap_contact_featuremap_contact_id_seq",
  },
  "featuremap_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "contact_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</featuremap_contact_id>

=back

=cut

__PACKAGE__->set_primary_key("featuremap_contact_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<featuremap_contact_c1>

=over 4

=item * L</featuremap_id>

=item * L</contact_id>

=back

=cut

__PACKAGE__->add_unique_constraint("featuremap_contact_c1", ["featuremap_id", "contact_id"]);

=head1 RELATIONS

=head2 contact

Type: belongs_to

Related object: L<html_dir::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "html_dir::Chado::Result::Contact",
  { contact_id => "contact_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 featuremap

Type: belongs_to

Related object: L<html_dir::Chado::Result::Featuremap>

=cut

__PACKAGE__->belongs_to(
  "featuremap",
  "html_dir::Chado::Result::Featuremap",
  { featuremap_id => "featuremap_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-08 16:43:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JyrUXk+WGsGUFl9++mArQQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
