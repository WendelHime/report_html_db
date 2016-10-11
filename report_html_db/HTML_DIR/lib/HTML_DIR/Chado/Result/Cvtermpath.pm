use utf8;
package HTML_DIR::Chado::Result::Cvtermpath;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Cvtermpath

=head1 DESCRIPTION

The reflexive transitive closure of
the cvterm_relationship relation.

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

=head1 TABLE: C<cvtermpath>

=cut

__PACKAGE__->table("cvtermpath");

=head1 ACCESSORS

=head2 cvtermpath_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cvtermpath_cvtermpath_id_seq'

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

The relationship type that
this is a closure over. If null, then this is a closure over ALL
relationship types. If non-null, then this references a relationship
cvterm - note that the closure will apply to both this relationship
AND the OBO_REL:is_a (subclass) relationship.

=head2 subject_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 object_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 cv_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

Closures will mostly be within
one cv. If the closure of a relationship traverses a cv, then this
refers to the cv of the object_id cvterm.

=head2 pathdistance

  data_type: 'integer'
  is_nullable: 1

The number of steps
required to get from the subject cvterm to the object cvterm, counting
from zero (reflexive relationship).

=cut

__PACKAGE__->add_columns(
  "cvtermpath_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cvtermpath_cvtermpath_id_seq",
  },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "subject_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "object_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "cv_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pathdistance",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cvtermpath_id>

=back

=cut

__PACKAGE__->set_primary_key("cvtermpath_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cvtermpath_c1>

=over 4

=item * L</subject_id>

=item * L</object_id>

=item * L</type_id>

=item * L</pathdistance>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "cvtermpath_c1",
  ["subject_id", "object_id", "type_id", "pathdistance"],
);

=head1 RELATIONS

=head2 cv

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cv>

=cut

__PACKAGE__->belongs_to(
  "cv",
  "HTML_DIR::Chado::Result::Cv",
  { cv_id => "cv_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 object

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "object",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "object_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 subject

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "subject",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "subject_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 type

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jMXOSBveV8yNgOJvTAAKZg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
