use utf8;
package HTML_DIR::Chado::Result::Environment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Environment - The environmental component of a phenotype description.

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

=head1 TABLE: C<environment>

=cut

__PACKAGE__->table("environment");

=head1 ACCESSORS

=head2 environment_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'environment_environment_id_seq'

=head2 uniquename

  data_type: 'text'
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "environment_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "environment_environment_id_seq",
  },
  "uniquename",
  { data_type => "text", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</environment_id>

=back

=cut

__PACKAGE__->set_primary_key("environment_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<environment_c1>

=over 4

=item * L</uniquename>

=back

=cut

__PACKAGE__->add_unique_constraint("environment_c1", ["uniquename"]);

=head1 RELATIONS

=head2 environment_cvterms

Type: has_many

Related object: L<HTML_DIR::Chado::Result::EnvironmentCvterm>

=cut

__PACKAGE__->has_many(
  "environment_cvterms",
  "HTML_DIR::Chado::Result::EnvironmentCvterm",
  { "foreign.environment_id" => "self.environment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phendescs

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phendesc>

=cut

__PACKAGE__->has_many(
  "phendescs",
  "HTML_DIR::Chado::Result::Phendesc",
  { "foreign.environment_id" => "self.environment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_comparison_environment1s

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PhenotypeComparison>

=cut

__PACKAGE__->has_many(
  "phenotype_comparison_environment1s",
  "HTML_DIR::Chado::Result::PhenotypeComparison",
  { "foreign.environment1_id" => "self.environment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenotype_comparison_environment2s

Type: has_many

Related object: L<HTML_DIR::Chado::Result::PhenotypeComparison>

=cut

__PACKAGE__->has_many(
  "phenotype_comparison_environment2s",
  "HTML_DIR::Chado::Result::PhenotypeComparison",
  { "foreign.environment2_id" => "self.environment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 phenstatements

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Phenstatement>

=cut

__PACKAGE__->has_many(
  "phenstatements",
  "HTML_DIR::Chado::Result::Phenstatement",
  { "foreign.environment_id" => "self.environment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-05 16:38:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:j1OZYhQl19Cayq6wgwKT1A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
