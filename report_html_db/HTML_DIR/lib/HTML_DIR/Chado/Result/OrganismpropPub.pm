use utf8;
package HTML_DIR::Chado::Result::OrganismpropPub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::OrganismpropPub - Attribution for organismprop.

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

=head1 TABLE: C<organismprop_pub>

=cut

__PACKAGE__->table("organismprop_pub");

=head1 ACCESSORS

=head2 organismprop_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'organismprop_pub_organismprop_pub_id_seq'

=head2 organismprop_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "organismprop_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "organismprop_pub_organismprop_pub_id_seq",
  },
  "organismprop_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</organismprop_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("organismprop_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<organismprop_pub_c1>

=over 4

=item * L</organismprop_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("organismprop_pub_c1", ["organismprop_id", "pub_id"]);

=head1 RELATIONS

=head2 organismprop

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Organismprop>

=cut

__PACKAGE__->belongs_to(
  "organismprop",
  "HTML_DIR::Chado::Result::Organismprop",
  { organismprop_id => "organismprop_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-05 16:38:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JgT3Y0WVI+m3AWCIbFwQfg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
