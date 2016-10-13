use utf8;
package HTML_DIR::Chado::Result::NdExperimentContact;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::NdExperimentContact

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

=head1 TABLE: C<nd_experiment_contact>

=cut

__PACKAGE__->table("nd_experiment_contact");

=head1 ACCESSORS

=head2 nd_experiment_contact_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'nd_experiment_contact_nd_experiment_contact_id_seq'

=head2 nd_experiment_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 contact_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "nd_experiment_contact_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "nd_experiment_contact_nd_experiment_contact_id_seq",
  },
  "nd_experiment_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "contact_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nd_experiment_contact_id>

=back

=cut

__PACKAGE__->set_primary_key("nd_experiment_contact_id");

=head1 RELATIONS

=head2 contact

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Contact>

=cut

__PACKAGE__->belongs_to(
  "contact",
  "HTML_DIR::Chado::Result::Contact",
  { contact_id => "contact_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 nd_experiment

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::NdExperiment>

=cut

__PACKAGE__->belongs_to(
  "nd_experiment",
  "HTML_DIR::Chado::Result::NdExperiment",
  { nd_experiment_id => "nd_experiment_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-13 15:50:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wY7FAurDlSKMEdN6C6TOMw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
