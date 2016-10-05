use utf8;
package HTML_DIR::Chado::Result::Set;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Set

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

=head1 TABLE: C<set>

=cut

__PACKAGE__->table("set");

=head1 ACCESSORS

=head2 set_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'set_set_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "set_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "set_set_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</set_id>

=back

=cut

__PACKAGE__->set_primary_key("set_id");

=head1 RELATIONS

=head2 set_features

Type: has_many

Related object: L<HTML_DIR::Chado::Result::SetFeature>

=cut

__PACKAGE__->has_many(
  "set_features",
  "HTML_DIR::Chado::Result::SetFeature",
  { "foreign.set_id" => "self.set_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 set_pipelines

Type: has_many

Related object: L<HTML_DIR::Chado::Result::SetPipeline>

=cut

__PACKAGE__->has_many(
  "set_pipelines",
  "HTML_DIR::Chado::Result::SetPipeline",
  { "foreign.set_id" => "self.set_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-05 16:38:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BOBi9w0G6SRuWGQMOivkrA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
