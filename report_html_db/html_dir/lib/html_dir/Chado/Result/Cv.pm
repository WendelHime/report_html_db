use utf8;
package html_dir::Chado::Result::Cv;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Cv

=head1 DESCRIPTION

A controlled vocabulary or ontology. A cv is
composed of cvterms (AKA terms, classes, types, universals - relations
and properties are also stored in cvterm) and the relationships
between them.

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

=head1 TABLE: C<cv>

=cut

__PACKAGE__->table("cv");

=head1 ACCESSORS

=head2 cv_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'cv_cv_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the ontology. This
corresponds to the obo-format -namespace-. cv names uniquely identify
the cv. In OBO file format, the cv.name is known as the namespace.

=head2 definition

  data_type: 'text'
  is_nullable: 1

A text description of the criteria for
membership of this ontology.

=cut

__PACKAGE__->add_columns(
  "cv_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "cv_cv_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "definition",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cv_id>

=back

=cut

__PACKAGE__->set_primary_key("cv_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<cv_c1>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("cv_c1", ["name"]);

=head1 RELATIONS

=head2 cvprops

Type: has_many

Related object: L<html_dir::Chado::Result::Cvprop>

=cut

__PACKAGE__->has_many(
  "cvprops",
  "html_dir::Chado::Result::Cvprop",
  { "foreign.cv_id" => "self.cv_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvtermpaths

Type: has_many

Related object: L<html_dir::Chado::Result::Cvtermpath>

=cut

__PACKAGE__->has_many(
  "cvtermpaths",
  "html_dir::Chado::Result::Cvtermpath",
  { "foreign.cv_id" => "self.cv_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 cvterms

Type: has_many

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->has_many(
  "cvterms",
  "html_dir::Chado::Result::Cvterm",
  { "foreign.cv_id" => "self.cv_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4yK8lMU3zHPuowp3ERbHJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
