use utf8;

package HTML_DIR::Chado::Result::AnalysesCDS;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table(qw/get_interval_evidence_properties/);
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition("4426671); \n?#");
__PACKAGE__->add_columns( "id", { data_type => "varchar", is_nullable => 1 }, );

#####
#
# Adicionar parametros recebidos em um unico hash
# Crar uma string para construir a query
# Receber referência do hash e caso exista a key ele adiciona o pedaço necessario a query
# Lembrar de verificar o conector das querys se vão possuir INTERSECT ou EXCEPT
#
#####
sub analyses_CDS {
	my ( $self, $hash ) = @_;
	my $storage = $self->storage;
	return $storage->dbh_do(
		sub {
			my ( $self, $dbh ) = @_;
			my $query     = "";
			my $connector = "";

			###
			# aqui começa um mooooooooonte de if
			###

			my $query_gene     = "";
			my $query_GO       = "";
			my $query_TCDB     = "";
			my $query_Phobius  = "";
			my $query_sigP     = "";
			my $query_blast    = "";
			my $query_RPS      = "";
			my $query_KEGG     = "";
			my $query_ORTH     = "";
			my $query_interpro = "";

			if ( exists $hash->{geneDesc} || exists $hash->{noDesc} ) {
				my $and = "";
				$query_gene =
				    "(SELECT DISTINCT f.feature_id "
				  . "FROM feature f JOIN feature_relationship r ON (f.feature_id = r.object_id) "
				  . "JOIN cvterm cr ON (r.type_id = cr.cvterm_id) "
				  . "JOIN featureloc l ON (l.feature_id = f.feature_id) "
				  . "JOIN featureprop pl ON (l.srcfeature_id = pl.feature_id) "
				  . "JOIN cvterm cp ON (pl.type_id = cp.cvterm_id) "
				  . "JOIN featureprop pd ON (r.subject_id = pd.feature_id) "
				  . "JOIN cvterm cd ON (pd.type_id = cd.cvterm_id) "
				  . "WHERE cr.name = 'based_on' AND cd.name = 'description' AND cp.name = 'pipeline_id' AND pl.value='"
				  . $hash->{pipeline}
				  . "' AND ";

				if ( exists $hash->{geneDesc} ) {
					$query_gene .=
					  generate_clause( $hash->{geneDesc}, "", "", "pd.value" );
					$and = " AND ";
				}
				if ( exists $hash->{noDesc} ) {
					$query_gene .=
					  generate_clause( $hash->{noDesc}, "NOT", $and,
						"pd.value" );
				}
				$query_gene .= ")";
				$connector = "1";
			}
			if (   exists $hash->{noGO}
				|| exists $hash->{goID}
				|| exists $hash->{goDesc} )
			{
				$query_GO =
				    "(SELECT DISTINCT r.object_id "
				  . "FROM feature_relationship r "
				  . "JOIN featureloc l ON (r.object_id = l.feature_id) "
				  . "JOIN featureprop p ON (p.feature_id = l.srcfeature_id) "
				  . "JOIN cvterm c ON (p.type_id = c.cvterm_id) "
				  . "JOIN feature_relationship pr ON (r.subject_id = pr.object_id) "
				  . "JOIN featureprop pd ON (pr.subject_id = pd.feature_id) "
				  . "JOIN cvterm cpd ON (pd.type_id = cpd.cvterm_id) "
				  . "WHERE c.name ='pipeline_id' AND p.value = '"
				  . $hash->{pipeline} . "' ";

				$connector = " INTERSECT " if $connector;

				if ( exists $hash->{noGO} ) {
					$connector = " EXCEPT ";
					$query_GO .= "AND cpd.name LIKE 'evidence_%')";
				}
				elsif ( exists $hash->{goID} ) {
					$query_GO .=
					  "AND cpd.name LIKE 'evidence_%' AND pd.value LIKE '%"
					  . $hash->{'goID'} . "%')";
				}
				elsif ( exists $hash->{goDesc} ) {
					$query_GO .=
					    "and cpd.name like 'evidence_%' and "
					  . generate_clause( $hash->{'goDesc'}, "", "", "pd.value" )
					  . " )";
				}
				$query_GO  = $connector . $query_GO;
				$connector = "1";
			}
			if (   exists $hash->{'noTC'}
				|| exists $hash->{'tcdbID'}
				|| exists $hash->{'tcdbFam'}
				|| exists $hash->{'tcdbSubclass'}
				|| exists $hash->{'tcdbClass'}
				|| exists $hash->{'tcdbDesc'} )
			{
				$query_TCDB =
				    "(SELECT DISTINCT r.object_id "
				  . "FROM feature_relationship r "
				  . "JOIN featureloc l ON (r.object_id = l.feature_id) "
				  . "JOIN featureprop p ON (p.feature_id = l.srcfeature_id) "
				  . "JOIN cvterm c ON (p.type_id = c.cvterm_id) "
				  . "JOIN feature_relationship pr ON (r.subject_id = pr.object_id) "
				  . "JOIN featureprop ppr ON (pr.subject_id = ppr.feature_id) "
				  . "JOIN featureprop pd ON (pr.subject_id = pd.feature_id) "
				  . "JOIN cvterm cpd ON (pd.type_id = cpd.cvterm_id) "
				  . "WHERE c.name ='pipeline_id' AND p.value = '"
				  . $hash->{pipeline} . "' ";

				$connector = " INTERSECT " if $connector;

				if ( $hash->{'noTC'} ) {
					$connector = " EXCEPT ";
					$query_TCDB .= " AND cpd.name = 'TCDB_ID')";
				}
				elsif ( $hash->{'tcdbID'} ) {
					$query_TCDB .= "AND cpd.name = 'TCDB_ID' AND pd.value = '"
					  . $hash->{'tcdbID'} . "')";
				}
				elsif ( $hash->{'tcdbFam'} ) {
					$query_TCDB .=
					  "AND cpd.name = 'TCDB_family' AND pd.value LIKE '"
					  . $hash->{'tcdbFam'} . "%')";
				}
				elsif ( $hash->{'tcdbSubclass'} ) {
					$query_TCDB .=
					  "AND cpd.name = 'TCDB_subclass' AND pd.value = '"
					  . $hash->{'tcdbSubclass'} . "')";
				}
				elsif ( $hash->{'tcdbClass'} ) {
					$query_TCDB .=
					  "AND cpd.name = 'TCDB_class' AND pd.value = '"
					  . $hash->{'tcdbClass'} . "')";
				}
				elsif ( $hash->{'tcdbDesc'} ) {
					$query_TCDB .=
					  "and cpd.name = 'hit_description' and "
					  . generate_clause( $hash->{'tcdbDesc'}, "", "",
						"pd.value" )
					  . " )";
				}
				$query_TCDB = $connector . $query_TCDB;
				$connector  = "1";
			}
			if (   exists $hash->{'noPhobius'}
				|| exists $hash->{'TMdom'}
				|| exists $hash->{'sigP'} ne "sigPwhatever" )
			{
				my $select = "(SELECT DISTINCT r.object_id ";
				my $join =
				    "FROM feature f "
				  . "JOIN feature_relationship r ON (r.subject_id = f.feature_id) "
				  . "JOIN feature fo ON (r.object_id = fo.feature_id) "
				  . "JOIN featureloc l ON (r.object_id = l.feature_id) "
				  . "JOIN featureprop p ON (p.feature_id = l.srcfeature_id) "
				  . "JOIN analysisfeature af ON (f.feature_id = af.feature_id) "
				  . "JOIN analysis a ON (a.analysis_id = af.analysis_id) "
				  . "JOIN cvterm c ON (p.type_id = c.cvterm_id) ";
				my $conditional =
"WHERE a.program = 'annotation_phobius.pl' AND c.name ='pipeline_id' AND pl.value='"
				  . $hash->{pipeline} . "'";

				$connector = " INTERSECT " if $connector;
				if ( $hash->{noPhobius} ) {
					$connector = " EXCEPT ";
					$query_Phobius =
					  $connector . $select . $join . $conditional . ")";
				}
				elsif ( $hash->{'TMdom'} ) {
					$join .=
"JOIN feature_relationship pr ON (r.subject_id = pr.object_id) "
					  . "JOIN featureprop ppr ON (pr.subject_id = ppr.feature_id) "
					  . "JOIN cvterm cpr ON (ppr.type_id = cpr.cvterm_id) "
					  . "JOIN featureprop pp ON (pr.subject_id = pp.feature_id) "
					  . "JOIN cvterm cpp ON (pp.type_id = cpp.cvterm_id) ";
					$conditional .=
" AND cpr.name = 'classification' AND ppr.value= 'TRANSMEM' AND cpp.name = 'predicted_TMHs' AND my_to_decimal(pp.value) ";

					if ( $hash->{'tmQuant'} eq "exact" ) {
						$conditional .= "= $hash->{'TMdom'} ";
					}
					elsif ( $hash->{'tmQuant'} eq "orLess" ) {
						$conditional .= "<= $hash->{'TMdom'} ";
					}
					elsif ( $hash->{'tmQuant'} eq "orMore" ) {
						$conditional .= ">= $hash->{'TMdom'} ";
					}
					$query_Phobius =
					  $connector . $select . $join . $conditional . ")";
					$connector = "1";
				}
				else {
					$query_Phobius = "";
				}

				if ( $hash->{'sigP'} ne "sigPwhatever"
					&& !$hash->{'noPhobius'} )
				{
					my $sigPconn = "";
					if ( $hash->{'sigP'} eq "sigPyes" ) {
						$sigPconn = " INTERSECT " if $connector;
					}
					elsif ( $hash->{'sigP'} eq "sigPno" ) {
						$sigPconn = " EXCEPT ";
					}

					$query_sigP .=
					  " $sigPconn (SELECT DISTINCT r.object_id FROM feature f
                        JOIN feature_relationship r ON (r.subject_id = f.feature_id)
                        JOIN feature fo ON (r.object_id = fo.feature_id)
                        JOIN featureloc l ON (r.object_id = l.feature_id)
                        JOIN featureprop p ON (p.feature_id = l.srcfeature_id)
                        JOIN analysisfeature af ON (f.feature_id = af.feature_id)
                        JOIN analysis a ON (a.analysis_id = af.analysis_id)
                        JOIN cvterm c ON (p.type_id = c.cvterm_id)
                        JOIN feature_relationship pr ON (r.subject_id = pr.object_id)
                        JOIN featureprop ppr ON (pr.subject_id = ppr.feature_id)
                        JOIN cvterm cpr ON (ppr.type_id = cpr.cvterm_id)
                        JOIN featureprop pp ON (pr.subject_id = pp.feature_id)
                        JOIN cvterm cpp ON (pp.type_id = cpp.cvterm_id)
                        where a.program = 'annotation_phobius.pl' AND c.name = 'pipeline_id' AND p.value = '"
					  . $hash->{pipeline}
					  . "' AND cpr.name = 'classification' AND ppr.value = 'SIGNAL')";
				}
				$connector = 1;
			}
			if (   exists $hash->{'noBlast'}
				|| exists $hash->{'blastID'}
				|| exists $hash->{'blastDesc'} )
			{
				$query_blast =
				  "(SELECT DISTINCT r.object_id " . " FROM feature f
                JOIN feature_relationship r ON (r.subject_id = f.feature_id)
                JOIN feature fo ON (r.object_id = fo.feature_id)
                JOIN analysisfeature af ON (f.feature_id = af.feature_id)
                JOIN analysis a ON (a.analysis_id = af.analysis_id)
                JOIN featureloc l ON (r.object_id = l.feature_id)
                JOIN featureprop p ON (p.feature_id = srcfeature_id)
                JOIN cvterm c ON (p.type_id = c.cvterm_id)
                JOIN feature_relationship ra ON (ra.object_id = f.feature_id)
                JOIN cvterm cra ON (ra.type_id = cra.cvterm_id)
                JOIN featureprop pfo ON (ra.subject_id = pfo.feature_id)
                JOIN cvterm cpfo ON (cpfo.cvterm_id = pfo.type_id)
                JOIN featureprop pr ON (r.object_id = pr.feature_id)
                JOIN cvterm cpr ON (pr.type_id = cpr.cvterm_id) ";
				my $conditional =
"WHERE a.program = 'annotation_blast.pl' AND c.name ='pipeline_id' AND p.value = '"
				  . $hash->{pipeline}
				  . "' AND cra.name = 'alignment' AND cpfo.name = 'subject_id'";
				$connector = " INTERSECT " if $connector;
				if ( $hash->{'noBlast'} ) {
					$conditional .= ")";
					$connector = " EXCEPT ";
				}
				elsif ( $hash->{'blastID'} ) {
					$conditional .=
					  " AND pfo.value LIKE '%" . $hash->{'blastID'} . "%' )";
				}
				elsif ( $hash->{'blastDesc'} ) {
					$conditional .= " AND "
					  . generate_clause( $hash->{'blastDesc'}, "", "",
						"pfo.value" )
					  . " )";
				}
				$query_blast = $connector . $query_blast . $conditional;
				$connector   = "1";
			}
			if (   exists $hash->{'noRps'}
				|| exists $hash->{'rpsID'}
				|| exists $hash->{'rpsDesc'} )
			{
				$query_RPS =
				    "(select distinct r.object_id "
				  . " from feature f "
				  . "join feature_relationship r on (r.subject_id = f.feature_id) "
				  . "join feature fo on (r.object_id = fo.feature_id) "
				  . "join analysisfeature af on (f.feature_id = af.feature_id) "
				  . "join analysis a on (a.analysis_id = af.analysis_id) "
				  . "join featureloc l on (r.object_id = l.feature_id) "
				  . "join featureprop p on (p.feature_id = srcfeature_id) "
				  . "join cvterm c on (p.type_id = c.cvterm_id) "
				  . "join feature_relationship ra on (ra.object_id = f.feature_id) "
				  . "join cvterm cra on (ra.type_id = cra.cvterm_id) "
				  . "join featureprop pfo on (ra.subject_id = pfo.feature_id) "
				  . "join cvterm cpfo on (cpfo.cvterm_id = pfo.type_id) "
				  . "join featureprop pr on (r.object_id = pr.feature_id) "
				  . "join cvterm cpr on (pr.type_id = cpr.cvterm_id) ";
				my $conditional =
"where a.program = 'annotation_rpsblast.pl' and c.name ='pipeline_id' and p.value = '"
				  . $hash->{pipeline}
				  . "' and cra.name = 'alignment' and cpfo.name = 'subject_id' ";
				$connector = " INTERSECT " if $connector;

				if ( $hash->{'noRps'} ) {
					$query_RPS .= ")";
					$connector = " EXCEPT ";
				}
				elsif ( $hash->{'rpsID'} ) {
					$conditional .=
					  " and pfo.value like '%" . $hash->{'rpsID'} . "%' )";
				}
				elsif ( $hash->{'rpsDesc'} ) {
					$conditional .= " and "
					  . generate_clause( $hash->{'rpsDesc'}, "", "",
						"pfo.value" )
					  . " )";
				}
				$query_RPS = $connector . $query_RPS . $conditional;
				$connector = 1;
			}
			if (   $hash->{'noKEGG'}
				|| $hash->{'koID'}
				|| $hash->{'keggPath'}
				|| $hash->{'keggDesc'} )
			{
				$query_KEGG =
				    "(select distinct r.object_id "
				  . "from feature_relationship r "
				  . "join featureloc l on (r.object_id = l.feature_id)"
				  . "join featureprop p on (p.feature_id = l.srcfeature_id)"
				  . "join cvterm c on (p.type_id = c.cvterm_id)"
				  . "join feature_relationship pr on (r.subject_id = pr.object_id)"
				  . "join featureprop ppr on (pr.subject_id = ppr.feature_id)"
				  . "join featureprop pd on (pr.subject_id = pd.feature_id)"
				  . "join cvterm cpd on (pd.type_id = cpd.cvterm_id) ";
				my $conditional = " where c.name ='pipeline_id' and p.value = '"
				  . $hash->{pipeline} . "' ";
				$connector = " intersect " if $connector;
				if ( $hash->{'noKEGG'} ) {
					$connector = " except ";
					$conditional .= " and cpd.name = 'orthologous_group_id')";
				}
				elsif ( $hash->{'koID'} ) {
					$conditional .=
					  " and cpd.name = 'orthologous_group_id' and pd.value = '"
					  . $hash->{'koID'} . "')";
				}
				elsif ( $hash->{'keggPath'} ) {
					$conditional .=
" and cpd.name = 'metabolic_pathway_id' and pd.value like '%"
					  . $hash->{'keggPath'} . "%')";
				}
				elsif ( $hash->{'keggDesc'} ) {
					$query_KEGG .=
" join analysisfeature af on (r.subject_id = af.feature_id)"
					  . "join analysis a on (a.analysis_id = af.analysis_id) ";
					$conditional .=
" and a.program = 'annotation_pathways.pl' and cpd.name = 'orthologous_group_description' and "
					  . generate_clause( $hash->{'keggDesc'}, "", "",
						"pd.value" )
					  . " )";
				}
				$query_KEGG = $query_KEGG . $conditional;
				$connector  = "1";
			}
			if (   exists $hash->{'noOrth'}
				|| exists $hash->{'orthID'}
				|| exists $hash->{'orthDesc'} )
			{
				$query_ORTH =
				    "(select distinct r.object_id"
				  . " from feature_relationship r "
				  . "join featureloc l on (r.object_id = l.feature_id) "
				  . "join featureprop p on (p.feature_id = l.srcfeature_id) "
				  . "join cvterm c on (p.type_id = c.cvterm_id) "
				  . "join feature_relationship pr on (r.subject_id = pr.object_id) "
				  . "join featureprop ppr on (pr.subject_id = ppr.feature_id) "
				  . "join featureprop pd on (pr.subject_id = pd.feature_id) "
				  . "join cvterm cpd on (pd.type_id = cpd.cvterm_id) ";
				my $conditional = "where c.name ='pipeline_id' and p.value = '"
				  . $hash->{pipeline} . "' ";
				$connector = " intersect " if $connector;
				if ( $hash->{'noOrth'} ) {
					$connector = " except ";
					$conditional .= "and cpd.name = 'orthologous_group')";
				}
				elsif ( $hash->{'orthID'} ) {
					$conditional =
					  "and cpd.name = 'orthologous_group' and pd.value like '%"
					  . $hash->{'orthID'} . "%')";
				}
				elsif ( $hash->{'orthDesc'} ) {
					$query_ORTH .=
" join analysisfeature af on (r.subject_id = af.feature_id) "
					  . " join analysis a on (a.analysis_id = af.analysis_id) ";
					$conditional .=
"and a.program = 'annotation_orthology.pl' and cpd.name = 'orthologous_group_description' and "
					  . generate_clause( $hash->{'orthDesc'}, "", "",
						"pd.value" )
					  . " )";
				}
				$query_ORTH = $connector . $query_ORTH . $conditional;
				$connector  = "1";
			}
			if (   exists $hash->{'noIP'}
				|| exists $hash->{'interproID'}
				|| exists $hash->{'interproDesc'} )
			{
				$query_interpro =
				    "(select distinct r.object_id "
				  . " from feature f "
				  . "join feature_relationship r on (r.subject_id = f.feature_id) "
				  . "join featureloc l on (r.object_id = l.feature_id) "
				  . "join featureprop p on (p.feature_id = l.srcfeature_id) "
				  . "join cvterm c on (p.type_id = c.cvterm_id) "
				  . "join feature_relationship pr on (r.subject_id = pr.object_id) "
				  . "join featureprop ppr on (pr.subject_id = ppr.feature_id) "
				  . "join cvterm cpr on (ppr.type_id = cpr.cvterm_id) ";
				my $conditional = "where c.name ='pipeline_id' and p.value = '"
				  . $hash->{pipeline} . "' ";
				$connector = " intersect " if $connector;
				if ( $hash->{'noIP'} ) {
					$connector = " except ";
					$conditional .= "and cpd.name like 'interpro_id'";
				}
				elsif ( $hash->{'interproID'} ) {
					$conditional .=
					  "and cpr.name like 'interpro_id' and ppr.value = '"
					  . $hash->{'interproID'} . "'";
				}
				elsif ( $hash->{'interproDesc'} ) {
					$conditional .=
					    "and cpr.name like 'description%' and ppr.value like '%"
					  . $hash->{'interproDesc'}
					  . "%'";
				}
				$query_interpro .= $conditional;
				$connector = 1;
			}

			$query =
			    $query_gene
			  . $query_GO
			  . $query_TCDB
			  . $query_Phobius
			  . $query_sigP
			  . $query_blast
			  . $query_RPS
			  . $query_KEGG
			  . $query_ORTH
			  . $query_interpro;

			my $sth = $dbh->prepare($query);
			$sth->execute();
			my @rows = @{ $sth->fetchall_arrayref() };
			return map { $_->[0] } @rows;
		}
	);
}

sub generate_clause {
	my $terms = shift;
	my $not   = shift || "";
	my $and   = shift || "";
	my $field = shift;

	my @terms  = split( /\s+/, $terms );
	my $clause = " $and (";
	my $i      = 0;
	foreach my $term (@terms) {
		my $com = "";
		$com = " or " if $i > 0;
		$clause .= "$com $field $not like '%$term%'";
		$i++;
	}
	$clause .= ")";
	return $clause;
}

__PACKAGE__->meta->make_immutable;
1;
