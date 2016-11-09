use utf8;
package HTML_DIR::Chado::Result::Subevidences;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';



__PACKAGE__->table_class('DBIx::Class::ResultSource::View');


__PACKAGE__->table(qw/get_subevidences/);
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition(
    'SELECT * FROM get_subevidences(?)'
);
__PACKAGE__->add_columns(
	"subev_id",
	{ data_type => "integer", is_nullable => 1 },
	"subev_type",
	{ data_type => "varchar", is_nullable => 1 },
	"subev_number", 
	{ data_type => "integer", is_nullable => 1 },
	"subev_start",
	{ data_type => "integer", is_nullable => 1 },
	"subev_end",
	{ data_type => "integer", is_nullable => 1 },
	"subev_strand",
	{ data_type => "integer", is_nullable => 1 },
	"is_obsolete",
	{ data_type => "boolean", is_nullable => 1 },
	"program",
	{ data_type => "varchar", is_nullable => 1 },
);

sub get_subevidences {
	my ( $self, $feature_id ) = @_;
	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my ( $self, $dbh ) = @_;
			my $sth = $dbh->prepare(
				"SELECT * FROM get_subevidences(" . $feature_id . ") ORDER BY program ASC" );
			$sth->execute();
			my @rows = @{ $sth->fetchall_arrayref() };
			return map { $_->[0] } @rows;
		}
	);
}



__PACKAGE__->meta->make_immutable;
1;