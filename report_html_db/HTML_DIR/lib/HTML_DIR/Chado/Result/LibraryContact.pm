use utf8;
package HTML_DIR::Chado::Result::LibraryContact;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::LibraryContact

=head1 DESCRIPTION

Links contact(s) with a library.  Used to indicate a particular person or organization responsible for creation of or that can provide more information on a particular library.

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

=head1 TABLE: C<library_contact>

=cut

__PACKAGE__->table("library_contact");

=head1 ACCESSORS

=head2 library_contact_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'library_contact_library_contact_id_seq'

=head2 library_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 contact_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "library_contact_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "library_contact_library_contact_id_seq",
  },
  "library_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "contact_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</library_contact_id>

=back

=cut

__PACKAGE__->set_primary_key("library_contact_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<library_contact_c1>

=over 4

=item * L</library_id>

=item * L</contact_id>

=back

=cut

__PACKAGE__->add_unique_constraint("library_contact_c1", ["library_id", "contact_id"]);

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

=head2 library

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "HTML_DIR::Chado::Result::Library",
  { library_id => "library_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GE/xfm/ryz87x8+vy/njrA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
