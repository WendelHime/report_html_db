use utf8;
package HTML_DIR::Chado::Result::Studydesign;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::Studydesign

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

=head1 TABLE: C<studydesign>

=cut

__PACKAGE__->table("studydesign");

=head1 ACCESSORS

=head2 studydesign_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'studydesign_studydesign_id_seq'

=head2 study_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "studydesign_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "studydesign_studydesign_id_seq",
  },
  "study_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</studydesign_id>

=back

=cut

__PACKAGE__->set_primary_key("studydesign_id");

=head1 RELATIONS

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

=head2 studydesignprops

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Studydesignprop>

=cut

__PACKAGE__->has_many(
  "studydesignprops",
  "HTML_DIR::Chado::Result::Studydesignprop",
  { "foreign.studydesign_id" => "self.studydesign_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studyfactors

Type: has_many

Related object: L<HTML_DIR::Chado::Result::Studyfactor>

=cut

__PACKAGE__->has_many(
  "studyfactors",
  "HTML_DIR::Chado::Result::Studyfactor",
  { "foreign.studydesign_id" => "self.studydesign_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-06 15:58:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:w6pcvjNUxUfEVd9JS3GD+w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
