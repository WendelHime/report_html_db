use utf8;
package HTML_DIR::Chado::Result::FeaturelocPub;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::FeaturelocPub

=head1 DESCRIPTION

Provenance of featureloc. Linking table between featurelocs and publications that mention them.

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

=head1 TABLE: C<featureloc_pub>

=cut

__PACKAGE__->table("featureloc_pub");

=head1 ACCESSORS

=head2 featureloc_pub_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'featureloc_pub_featureloc_pub_id_seq'

=head2 featureloc_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 pub_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "featureloc_pub_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "featureloc_pub_featureloc_pub_id_seq",
  },
  "featureloc_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "pub_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</featureloc_pub_id>

=back

=cut

__PACKAGE__->set_primary_key("featureloc_pub_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<featureloc_pub_c1>

=over 4

=item * L</featureloc_id>

=item * L</pub_id>

=back

=cut

__PACKAGE__->add_unique_constraint("featureloc_pub_c1", ["featureloc_id", "pub_id"]);

=head1 RELATIONS

=head2 featureloc

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Featureloc>

=cut

__PACKAGE__->belongs_to(
  "featureloc",
  "HTML_DIR::Chado::Result::Featureloc",
  { featureloc_id => "featureloc_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-11 16:44:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gPw1MDL+Na8w+749gZ8yDQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
