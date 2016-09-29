use utf8;
package html_dir::Chado::Result::Studyfactor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Studyfactor

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

=head1 TABLE: C<studyfactor>

=cut

__PACKAGE__->table("studyfactor");

=head1 ACCESSORS

=head2 studyfactor_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'studyfactor_studyfactor_id_seq'

=head2 studydesign_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 type_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "studyfactor_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "studyfactor_studyfactor_id_seq",
  },
  "studydesign_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</studyfactor_id>

=back

=cut

__PACKAGE__->set_primary_key("studyfactor_id");

=head1 RELATIONS

=head2 studydesign

Type: belongs_to

Related object: L<html_dir::Chado::Result::Studydesign>

=cut

__PACKAGE__->belongs_to(
  "studydesign",
  "html_dir::Chado::Result::Studydesign",
  { studydesign_id => "studydesign_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 studyfactorvalues

Type: has_many

Related object: L<html_dir::Chado::Result::Studyfactorvalue>

=cut

__PACKAGE__->has_many(
  "studyfactorvalues",
  "html_dir::Chado::Result::Studyfactorvalue",
  { "foreign.studyfactor_id" => "self.studyfactor_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type

Type: belongs_to

Related object: L<html_dir::Chado::Result::Cvterm>

=cut

__PACKAGE__->belongs_to(
  "type",
  "html_dir::Chado::Result::Cvterm",
  { cvterm_id => "type_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7JZREZ5ISSFmfabIewFu/w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
