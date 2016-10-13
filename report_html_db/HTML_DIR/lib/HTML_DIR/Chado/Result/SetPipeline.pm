use utf8;
package HTML_DIR::Chado::Result::SetPipeline;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::SetPipeline

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

=head1 TABLE: C<set_pipeline>

=cut

__PACKAGE__->table("set_pipeline");

=head1 ACCESSORS

=head2 set_pipeline_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'set_pipeline_set_pipeline_id_seq'

=head2 set_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 pipeline_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 execution_date

  data_type: 'timestamp'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "set_pipeline_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "set_pipeline_set_pipeline_id_seq",
  },
  "set_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "pipeline_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "execution_date",
  { data_type => "timestamp", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</set_pipeline_id>

=back

=cut

__PACKAGE__->set_primary_key("set_pipeline_id");

=head1 RELATIONS

=head2 pipeline

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Pipeline>

=cut

__PACKAGE__->belongs_to(
  "pipeline",
  "HTML_DIR::Chado::Result::Pipeline",
  { pipeline_id => "pipeline_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 set

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Set>

=cut

__PACKAGE__->belongs_to(
  "set",
  "HTML_DIR::Chado::Result::Set",
  { set_id => "set_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oSBQnkyxT1er86/Nimt/0g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
