use utf8;
package HTML_DIR::Chado::Result::StudyAssay;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::StudyAssay

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

=head1 TABLE: C<study_assay>

=cut

__PACKAGE__->table("study_assay");

=head1 ACCESSORS

=head2 study_assay_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'study_assay_study_assay_id_seq'

=head2 study_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 assay_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "study_assay_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "study_assay_study_assay_id_seq",
  },
  "study_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "assay_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</study_assay_id>

=back

=cut

__PACKAGE__->set_primary_key("study_assay_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<study_assay_c1>

=over 4

=item * L</study_id>

=item * L</assay_id>

=back

=cut

__PACKAGE__->add_unique_constraint("study_assay_c1", ["study_id", "assay_id"]);

=head1 RELATIONS

=head2 assay

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Assay>

=cut

__PACKAGE__->belongs_to(
  "assay",
  "HTML_DIR::Chado::Result::Assay",
  { assay_id => "assay_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 study

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Study>

=cut

__PACKAGE__->belongs_to(
  "study",
  "HTML_DIR::Chado::Result::Study",
  { study_id => "study_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vlsfTvBE4U+pZK7H23aXKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
