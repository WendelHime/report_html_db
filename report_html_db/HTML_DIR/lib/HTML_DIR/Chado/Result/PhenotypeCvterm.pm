use utf8;
package HTML_DIR::Chado::Result::PhenotypeCvterm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::PhenotypeCvterm - phenotype to cvterm associations.

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

=head1 TABLE: C<phenotype_cvterm>

=cut

__PACKAGE__->table("phenotype_cvterm");

=head1 ACCESSORS

=head2 phenotype_cvterm_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phenotype_cvterm_phenotype_cvterm_id_seq'

=head2 phenotype_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 cvterm_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "phenotype_cvterm_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phenotype_cvterm_phenotype_cvterm_id_seq",
  },
  "phenotype_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "cvterm_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phenotype_cvterm_id>

=back

=cut

__PACKAGE__->set_primary_key("phenotype_cvterm_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phenotype_cvterm_c1>

=over 4

=item * L</phenotype_id>

=item * L</cvterm_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint("phenotype_cvterm_c1", ["phenotype_id", "cvterm_id", "rank"]);

=head1 RELATIONS

=head2 cvterm

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "cvterm",
  "HTML_DIR::Chado::Result::Cvterm",
  { cvterm_id => "cvterm_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 phenotype

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Phenotype>

=cut

__PACKAGE__->belongs_to(
  "phenotype",
  "HTML_DIR::Chado::Result::Phenotype",
  { phenotype_id => "phenotype_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hUue8XFHzE8Qzr03Em7KpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
