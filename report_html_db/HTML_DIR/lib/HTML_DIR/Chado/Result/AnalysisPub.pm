use utf8;
package HTML_DIR::Chado::Result::AnalysisPub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::AnalysisPub

=head1 DESCRIPTION

Provenance. Linking table between analyses and the publications that mention them.

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

=head1 TABLE: C<analysis_pub>

=cut

__PACKAGE__->table("analysis_pub");

=head1 ACCESSORS

=head2 analysis_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'analysis_pub_analysis_pub_id_seq'

=head2 analysis_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "analysis_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "analysis_pub_analysis_pub_id_seq",
  },
  "analysis_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<analysis_pub_c1>

=over 4

=item * L</analysis_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("analysis_pub_c1", ["analysis_id", "pub_id"]);

=head1 RELATIONS

=head2 analysis

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Analysis>

=cut

__PACKAGE__->belongs_to(
  "analysis",
  "HTML_DIR::Chado::Result::Analysis",
  { analysis_id => "analysis_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 pub

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pub>

=cut

__PACKAGE__->belongs_to(
  "pub",
  "HTML_DIR::Chado::Result::Pub",
  { pub_id => "pub_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0zmypC6v6POIQNKNsBXXMA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
