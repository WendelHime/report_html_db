use utf8;
package HTML_DIR::Chado::Result::Db;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Db

=head1 DESCRIPTION

A database authority. Typical databases in
bioinformatics are FlyBase, GO, UniProt, NCBI, MGI, etc. The authority
is generally known by this shortened form, which is unique within the
bioinformatics and biomedical realm.  To Do - add support for URIs,
URNs (e.g. LSIDs). We can do this by treating the URL as a URI -
however, some applications may expect this to be resolvable - to be
decided.

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

=head1 TABLE: C<db>

=cut

__PACKAGE__->table("db");

=head1 ACCESSORS

=head2 db_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'db_db_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 urlprefix

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "db_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "db_db_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "urlprefix",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</db_id>

=back

=cut

__PACKAGE__->set_primary_key("db_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<db_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("db_c1", ["name"]);

=head1 RELATIONS

=head2 dbprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Dbprop>

=cut

__PACKAGE__->has_many(
  "dbprops",
  "HTML_DIR::Chado::Result::Dbprop",
  { "foreign.db_id" => "self.db_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dbxrefs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Dbxref>

=cut

__PACKAGE__->has_many(
  "dbxrefs",
  "HTML_DIR::Chado::Result::Dbxref",
  { "foreign.db_id" => "self.db_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stockcollection_dbs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::StockcollectionDb>

=cut

__PACKAGE__->has_many(
  "stockcollection_dbs",
  "HTML_DIR::Chado::Result::StockcollectionDb",
  { "foreign.db_id" => "self.db_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qNYi046lU1ZSIyT8NIQEQA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
