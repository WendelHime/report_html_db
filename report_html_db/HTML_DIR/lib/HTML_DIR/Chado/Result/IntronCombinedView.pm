use utf8;
package HTML_DIR::Chado::Result::IntronCombinedView;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::IntronCombinedView

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
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<intron_combined_view>

=cut

__PACKAGE__->table("intron_combined_view");

=head1 ACCESSORS

=head2 exon1_id

  data_type: 'bigint'
  is_nullable: 1

=head2 exon2_id

  data_type: 'bigint'
  is_nullable: 1

=head2 fmin

  data_type: 'bigint'
  is_nullable: 1

=head2 fmax

  data_type: 'bigint'
  is_nullable: 1

=head2 strand

  data_type: 'smallint'
  is_nullable: 1

=head2 srcfeature_id

  data_type: 'bigint'
  is_nullable: 1

=head2 intron_rank

  data_type: 'integer'
  is_nullable: 1

=head2 transcript_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "exon1_id",
  { data_type => "bigint", is_nullable => 1 },
  "exon2_id",
  { data_type => "bigint", is_nullable => 1 },
  "fmin",
  { data_type => "bigint", is_nullable => 1 },
  "fmax",
  { data_type => "bigint", is_nullable => 1 },
  "strand",
  { data_type => "smallint", is_nullable => 1 },
  "srcfeature_id",
  { data_type => "bigint", is_nullable => 1 },
  "intron_rank",
  { data_type => "integer", is_nullable => 1 },
  "transcript_id",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UgycSQVjroHhq6nfWpcgwQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
