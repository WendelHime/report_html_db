use utf8;
package HTML_DIR::Chado::Result::StockcollectionDb;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTML_DIR::Chado::Result::StockcollectionDb

=head1 DESCRIPTION

Stock collections may be respresented 
by an external online database. This table associates a stock collection with 
a database where its member stocks can be found. Individual stock that are part 
of this collction should have entries in the stock_dbxref table with the same 
db_id record

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

=head1 TABLE: C<stockcollection_db>

=cut

__PACKAGE__->table("stockcollection_db");

=head1 ACCESSORS

=head2 stockcollection_db_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'stockcollection_db_stockcollection_db_id_seq'

=head2 stockcollection_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 db_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "stockcollection_db_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "stockcollection_db_stockcollection_db_id_seq",
  },
  "stockcollection_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "db_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</stockcollection_db_id>

=back

=cut

__PACKAGE__->set_primary_key("stockcollection_db_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<stockcollection_db_c1>

=over 4

=item * L</stockcollection_id>

=item * L</db_id>

=back

=cut

__PACKAGE__->add_unique_constraint("stockcollection_db_c1", ["stockcollection_id", "db_id"]);

=head1 RELATIONS

=head2 db

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Db>

=cut

__PACKAGE__->belongs_to(
  "db",
  "HTML_DIR::Chado::Result::Db",
  { db_id => "db_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 stockcollection

Type: belongs_to

Related object: L<HTML_DIR::Chado::Result::Stockcollection>

=cut

__PACKAGE__->belongs_to(
  "stockcollection",
  "HTML_DIR::Chado::Result::Stockcollection",
  { stockcollection_id => "stockcollection_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-18 14:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5LUgX6d/y0nOfQSMcRFcVw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
