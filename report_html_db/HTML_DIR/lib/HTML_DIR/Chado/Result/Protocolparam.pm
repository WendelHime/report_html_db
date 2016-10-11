use utf8;
package HTML_DIR::Chado::Result::Protocolparam;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Protocolparam

=head1 DESCRIPTION

Parameters related to a
protocol. For example, if the protocol is a soak, this might include attributes of bath temperature and duration.

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

=head1 TABLE: C<protocolparam>

=cut

__PACKAGE__->table("protocolparam");

=head1 ACCESSORS

=head2 protocolparam_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'protocolparam_protocolparam_id_seq'

=head2 protocol_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 datatype_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 unittype_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 value

  data_type: 'text'
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "protocolparam_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "protocolparam_protocolparam_id_seq",
  },
  "protocol_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "datatype_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "unittype_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</protocolparam_id>

=back

=cut

__PACKAGE__->set_primary_key("protocolparam_id");

=head1 RELATIONS

=head2 datatype

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "datatype",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "datatype_id" },
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
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 unittype

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "unittype",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "unittype_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:880JZjJScalCjZqWnRF6gg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
