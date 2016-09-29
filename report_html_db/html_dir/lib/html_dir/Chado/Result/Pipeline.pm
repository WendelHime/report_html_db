use utf8;
package html_dir::Chado::Result::Pipeline;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Pipeline - This table stores created pipelines by users of system

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

=head1 TABLE: C<pipeline>

=cut

__PACKAGE__->table("pipeline");

=head1 ACCESSORS

=head2 pipeline_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'pipeline_pipeline_id_seq'

=head2 configuration_string

  data_type: 'text'
  is_nullable: 0

String that defines the steps to execute the pipeline

=head2 pipeline_name

  data_type: 'text'
  is_nullable: 1

Pipeline description

=cut

__PACKAGE__->add_columns(
  "pipeline_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "pipeline_pipeline_id_seq",
  },
  "configuration_string",
  { data_type => "text", is_nullable => 0 },
  "pipeline_name",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</pipeline_id>

=back

=cut

__PACKAGE__->set_primary_key("pipeline_id");

=head1 RELATIONS

=head2 set_pipelines

Type: has_many

Related object: L<html_dir::Chado::Result::SetPipeline>

=cut

__PACKAGE__->has_many(
  "set_pipelines",
  "html_dir::Chado::Result::SetPipeline",
  { "foreign.pipeline_id" => "self.pipeline_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YaQema26lYY31d7VcEpp0w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
