use utf8;
package HTML_DIR::Chado::Result::LibraryDbxref;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::LibraryDbxref - Links a library to dbxrefs.

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

=head1 TABLE: C<library_dbxref>

=cut

__PACKAGE__->table("library_dbxref");

=head1 ACCESSORS

=head2 library_dbxref_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'library_dbxref_library_dbxref_id_seq'

=head2 library_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 dbxref_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 is_current

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "library_dbxref_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "library_dbxref_library_dbxref_id_seq",
  },
  "library_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "dbxref_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "is_current",
  { data_type => "boolean", default_value => \"true", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</library_dbxref_id>

=back

=cut

__PACKAGE__->set_primary_key("library_dbxref_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<library_dbxref_c1>

=over 4

=item * L</library_id>

=item * L</dbxref_id>

=back

=cut

__PACKAGE__->add_unique_constraint("library_dbxref_c1", ["library_id", "dbxref_id"]);

=head1 RELATIONS

=head2 dbxref

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Dbxref>

=cut

__PACKAGE__->belongs_to(
  "dbxref",
  "HTML_DIR::Chado::Result::Dbxref",
  { dbxref_id => "dbxref_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 library

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Library>

=cut

__PACKAGE__->belongs_to(
  "library",
  "HTML_DIR::Chado::Result::Library",
  { library_id => "library_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Yig++9NFjWdNqLK/zDGJHg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
