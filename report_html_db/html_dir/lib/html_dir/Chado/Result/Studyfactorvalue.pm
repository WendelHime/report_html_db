use utf8;
package html_dir::Chado::Result::Studyfactorvalue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

html_dir::Chado::Result::Studyfactorvalue

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

=head1 TABLE: C<studyfactorvalue>

=cut

__PACKAGE__->table("studyfactorvalue");

=head1 ACCESSORS

=head2 studyfactorvalue_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'studyfactorvalue_studyfactorvalue_id_seq'

=head2 studyfactor_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 assay_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 factorvalue

  data_type: 'text'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 rank

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "studyfactorvalue_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "studyfactorvalue_studyfactorvalue_id_seq",
  },
  "studyfactor_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "assay_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "factorvalue",
  { data_type => "text", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "rank",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</studyfactorvalue_id>

=back

=cut

__PACKAGE__->set_primary_key("studyfactorvalue_id");

=head1 RELATIONS

=head2 assay

Type: belongs_to

Related object: L<html_dir::Chado::Result::Assay>

=cut

__PACKAGE__->belongs_to(
  "assay",
  "html_dir::Chado::Result::Assay",
  { assay_id => "assay_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 studyfactor

Type: belongs_to

Related object: L<html_dir::Chado::Result::Studyfactor>

=cut

__PACKAGE__->belongs_to(
  "studyfactor",
  "html_dir::Chado::Result::Studyfactor",
  { studyfactor_id => "studyfactor_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-29 15:09:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:040GdhMxC0IkIvwmOnTxrg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
