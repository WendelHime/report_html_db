use utf8;
package HTML_DIR::Chado::Result::PhenotypeComparisonCvterm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::PhenotypeComparisonCvterm

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

=head1 TABLE: C<phenotype_comparison_cvterm>

=cut

__PACKAGE__->table("phenotype_comparison_cvterm");

=head1 ACCESSORS

=head2 phenotype_comparison_cvterm_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'phenotype_comparison_cvterm_phenotype_comparison_cvterm_id_seq'

=head2 phenotype_comparison_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 cvterm_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "phenotype_comparison_cvterm_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "phenotype_comparison_cvterm_phenotype_comparison_cvterm_id_seq",
  },
  "phenotype_comparison_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "cvterm_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</phenotype_comparison_cvterm_id>

=back

=cut

__PACKAGE__->set_primary_key("phenotype_comparison_cvterm_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<phenotype_comparison_cvterm_c1>

=over 4

=item * L</phenotype_comparison_id>

=item * L</cvterm_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "phenotype_comparison_cvterm_c1",
  ["phenotype_comparison_id", "cvterm_id"],
);

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

=head2 phenotype_comparison

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::PhenotypeComparison>

=cut

__PACKAGE__->belongs_to(
  "phenotype_comparison",
  "HTML_DIR::Chado::Result::PhenotypeComparison",
  { phenotype_comparison_id => "phenotype_comparison_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ucKLbFIKFrFlinb9pB0H9w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
