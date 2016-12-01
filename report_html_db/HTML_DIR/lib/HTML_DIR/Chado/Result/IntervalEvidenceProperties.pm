use utf8;
package HTML_DIR::Chado::Result::IntervalEvidenceProperties;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';



__PACKAGE__->table_class('DBIx::Class::ResultSource::View');


__PACKAGE__->table(qw/get_interval_evidence_properties/);
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition(
    'SELECT * FROM get_interval_evidence_properties(?)'
);
__PACKAGE__->add_columns(
	"key",
	{ data_type => "varchar", is_nullable => 1 },	
	"key_value",
	{ data_type => "varchar", is_nullable => 1 },
);

#sub get_interval_evidence_properties {
#	my ( $self, $feature_id ) = @_;
#	my $storage = $self->storage;
#	return $storage->dbh_do(
#		sub {
#			my ( $self, $dbh ) = @_;
#			my $sth = $dbh->prepare(
#				"SELECT * FROM get_interval_evidence_properties(" . $feature_id . ")" );
#			$sth->execute();
#			my @rows = @{ $sth->fetchall_arrayref() };
#			return map { $_->[0] } @rows;
#		}
#	);
#}



__PACKAGE__->meta->make_immutable;
1;