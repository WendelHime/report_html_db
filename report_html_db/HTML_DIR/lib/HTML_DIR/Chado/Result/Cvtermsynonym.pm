use utf8;
package HTML_DIR::Chado::Result::Cvtermsynonym;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Cvtermsynonym

=head1 DESCRIPTION

A cvterm actually represents a
distinct class or concept. A concept can be refered to by different
phrases or names. In addition to the primary name (cvterm.name) there
can be a number of alternative aliases or synonyms. For example, "T
cell" as a synonym for "T lymphocyte".

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

=head1 TABLE: C<cvtermsynonym>

=cut

__PACKAGE__->table("cvtermsynonym");

=head1 ACCESSORS

=head2 cvtermsynonym_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cvtermsynonym_cvtermsynonym_id_seq'

=head2 cvterm_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 synonym

  data_type: 'varchar'
  is_nullable: 0
  size: 1024

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

A synonym can be exact,
narrower, or broader than.

=cut

__PACKAGE__->add_columns(
  "cvtermsynonym_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cvtermsynonym_cvtermsynonym_id_seq",
  },
  "cvterm_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "synonym",
  { data_type => "varchar", is_nullable => 0, size => 1024 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cvtermsynonym_id>

=back

=cut

__PACKAGE__->set_primary_key("cvtermsynonym_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cvtermsynonym_c1>

=over 4

=item * L</cvterm_id>

=item * L</synonym>

=back

=cut

__PACKAGE__->add_unique_constraint("cvtermsynonym_c1", ["cvterm_id", "synonym"]);

=head1 RELATIONS

=head2 cvterm

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "cvterm",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "cvterm_id" },
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
    on_delete     => "CASCADE",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-05 16:38:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:F2WEaLL9GxFp51Y4xLdtmw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
