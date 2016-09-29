use utf8;
package html_dir::Chado::Result::Phendesc;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Phendesc

=head1 DESCRIPTION

A summary of a _set_ of phenotypic statements for any one gcontext made in any one publication.

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

=head1 TABLE: C<phendesc>

=cut

__PACKAGE__->table("phendesc");

=head1 ACCESSORS

=head2 phendesc_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phendesc_phendesc_id_seq'

=head2 genotype_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 environment_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "phendesc_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phendesc_phendesc_id_seq",
  },
  "genotype_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "environment_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phendesc_id>

=back

=cut

__PACKAGE__->set_primary_key("phendesc_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phendesc_c1>

=over 4

=item * L</genotype_id>

=item * L</environment_id>

=item * L</type_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "phendesc_c1",
  ["genotype_id", "environment_id", "type_id", "pub_id"],
);

=head1 RELATIONS

=head2 environment

Type: belongs_to

Related object: L<html_dir::Chado::Result::Environment>

=cut

__PACKAGE__->belongs_to(
  "environment",
  "html_dir::Chado::Result::Environment",
  { environment_id => "environment_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 genotype

Type: belongs_to

Related object: L<html_dir::Chado::Result::Genotype>

=cut

__PACKAGE__->belongs_to(
  "genotype",
  "html_dir::Chado::Result::Genotype",
  { genotype_id => "genotype_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pub

Type: belongs_to

Related object: L<html_dir::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "html_dir::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 type

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JhTkEJEY548PtscsBKYo7g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
