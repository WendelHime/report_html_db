use utf8;
package HTML_DIR::Chado::Result::PubauthorContact;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::PubauthorContact

=head1 DESCRIPTION

An author on a publication may have a corresponding entry in the contact table and this table can link the two.

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

=head1 TABLE: C<pubauthor_contact>

=cut

__PACKAGE__->table("pubauthor_contact");

=head1 ACCESSORS

=head2 pubauthor_contact_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'pubauthor_contact_pubauthor_contact_id_seq'

=head2 contact_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pubauthor_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "pubauthor_contact_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "pubauthor_contact_pubauthor_contact_id_seq",
  },
  "contact_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pubauthor_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</pubauthor_contact_id>

=back

=cut

__PACKAGE__->set_primary_key("pubauthor_contact_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<pubauthor_contact_c1>

=over 4

=item * L</contact_id>

=item * L</pubauthor_id>

=back

=cut

__PACKAGE__->add_unique_constraint("pubauthor_contact_c1", ["contact_id", "pubauthor_id"]);

=head1 RELATIONS

=head2 contact

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "HTML_DIR::Chado::Result::Contact",
  { contact_id => "contact_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pubauthor

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pubauthor>

=cut

__PACKAGE__->belongs_to(
  "pubauthor",
  "HTML_DIR::Chado::Result::Pubauthor",
  { pubauthor_id => "pubauthor_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+ChvjkxdV5VAE3yTmLjB+g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
