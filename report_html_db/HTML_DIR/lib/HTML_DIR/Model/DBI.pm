package HTML_DIR::Model::DBI;

use strict;
use warnings;
use parent 'Catalyst::Model::DBI';

__PACKAGE__->config(
	dsn      => 'dbi:Pg:dbname=chadodb;host=127.0.0.1',
	user     => 'chadouser',
	password => '',
	options  => {},
);

=head2

Method used to realize search based on parameters received by form of analyses of protein-coding genes

=cut

sub analyses_CDS {
	my ( $self, $hash ) = @_;
	my $dbh = $self->dbh;
	###
	# Query precisa começar encontrado todos os CDS primeiro como base,
	# inicializar conector,
	# adicionar na parte do gene também o conector
	###
	my $query =
	    "(select distinct f.feature_id "
	  . "from feature f "
	  . "join feature_relationship r on (f.feature_id = r.object_id) "
	  . "join cvterm cr on (r.type_id = cr.cvterm_id) "
	  . "join featureprop ps on (r.subject_id = ps.feature_id) "
	  . "join cvterm cs on (ps.type_id = cs.cvterm_id) "
	  . "join featureprop pf on (f.feature_id = pf.feature_id) "
	  . "join cvterm cf on (pf.type_id = cf.cvterm_id) "
	  . "join featureloc l on (l.feature_id = f.feature_id) "
	  . "join featureprop pl on (l.srcfeature_id = pl.feature_id) "
	  . "join cvterm cp on (pl.type_id = cp.cvterm_id) "
	  . "join featureprop pd on (r.subject_id = pd.feature_id) "
	  . "join cvterm cd on (pd.type_id = cd.cvterm_id) "
	  . "where cr.name = 'based_on' and cf.name = 'tag' and pf.value='CDS' and cs.name = 'locus_tag' and cd.name = 'description' and cp.name = 'pipeline_id' and pl.value='4249')";
	my $connector = "1";

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

	if (   ( exists $hash->{geneDesc} && $hash->{geneDesc} )
		|| ( exists $hash->{noDesc} && $hash->{noDesc} ) )
	{
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

		$connector = " INTERSECT " if $connector;

		if ( exists $hash->{geneDesc} && $hash->{geneDesc} ) {
			$query_gene .=
			  generate_clause( $hash->{geneDesc}, "", "", "pd.value" );
			$and = " AND ";
		}
		if ( exists $hash->{noDesc} && $hash->{noDesc} ) {
			$query_gene .=
			  generate_clause( $hash->{noDesc}, "NOT", $and, "pd.value" );
		}
		$query_gene .= ")";
		$query_gene = $connector . $query_gene;
		$connector  = "1";
	}
	if (   ( exists $hash->{noGO} && $hash->{noGO} )
		|| ( exists $hash->{goID}   && $hash->{noGO} )
		|| ( exists $hash->{goDesc} && $hash->{noGO} ) )
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

		if ( exists $hash->{noGO} && $hash->{noGO} ) {
			$connector = " EXCEPT " if $connector;
			$query_GO .= "AND cpd.name LIKE 'evidence_%' ";
		}
		elsif ( exists $hash->{goID} && $hash->{goID} ) {
			$query_GO .=
			  "AND cpd.name LIKE 'evidence_%' AND pd.value LIKE '%"
			  . $hash->{'goID'} . "%')";
		}
		elsif ( exists $hash->{goDesc} && $hash->{goDesc} ) {
			$query_GO .=
			  "and cpd.name like 'evidence_%' and "
			  . generate_clause( $hash->{'goDesc'}, "", "", "pd.value" ) . " )";
		}
		$query_GO  = $connector . $query_GO . ")";
		$connector = "1";
	}
	if (   ( exists $hash->{'noTC'} && $hash->{'noTC'} )
		|| ( exists $hash->{'tcdbID'}       && $hash->{'tcdbID'} )
		|| ( exists $hash->{'tcdbFam'}      && $hash->{'tcdbFam'} )
		|| ( exists $hash->{'tcdbSubclass'} && $hash->{'tcdbSubclass'} )
		|| ( exists $hash->{'tcdbClass'}    && $hash->{'tcdbClass'} )
		|| ( exists $hash->{'tcdbDesc'}     && $hash->{'tcdbDesc'} ) )
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
			$connector = " EXCEPT " if $connector;
			$query_TCDB .= " AND cpd.name = 'TCDB_ID'";
		}
		elsif ( $hash->{'tcdbID'} ) {
			$query_TCDB .= "AND cpd.name = 'TCDB_ID' AND pd.value = '"
			  . $hash->{'tcdbID'} . "'";
		}
		elsif ( $hash->{'tcdbFam'} ) {
			$query_TCDB .=
			  "AND cpd.name = 'TCDB_family' AND pd.value LIKE '"
			  . $hash->{'tcdbFam'} . "%'";
		}
		elsif ( $hash->{'tcdbSubclass'} ) {
			$query_TCDB .=
			  "AND cpd.name = 'TCDB_subclass' AND pd.value = '"
			  . $hash->{'tcdbSubclass'} . "'";
		}
		elsif ( $hash->{'tcdbClass'} ) {
			$query_TCDB .=
			  "AND cpd.name = 'TCDB_class' AND pd.value = '"
			  . $hash->{'tcdbClass'} . "'";
		}
		elsif ( $hash->{'tcdbDesc'} ) {
			$query_TCDB .=
			  "and cpd.name = 'hit_description' and "
			  . generate_clause( $hash->{'tcdbDesc'}, "", "", "pd.value" );
		}
		$query_TCDB = $connector . $query_TCDB . ")";
		$connector  = "1";
	}
	if (   ( exists $hash->{'noPhobius'} && $hash->{'noPhobius'} )
		|| ( exists $hash->{'TMdom'} && $hash->{'TMdom'} )
		|| ( exists $hash->{'sigP'}  && $hash->{'sigP'} ) )
	{
		if ( $hash->{'sigP'} ne "sigPwhatever" ) {

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
"WHERE a.program = 'annotation_phobius.pl' AND c.name ='pipeline_id' AND p.value='"
			  . $hash->{pipeline} . "'";

			$connector = " INTERSECT " if $connector;
			if ( $hash->{noPhobius} ) {
				$connector = " EXCEPT " if $connector;
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
					$sigPconn = " EXCEPT " if $connector;
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
			$connector = "1";
		}
	}
	if (   ( exists $hash->{'noBlast'} && $hash->{'noBlast'} )
		|| ( exists $hash->{'blastID'}   && $hash->{'blastID'} )
		|| ( exists $hash->{'blastDesc'} && $hash->{'blastDesc'} ) )
	{
		$query_blast = "(SELECT DISTINCT r.object_id " . " FROM feature f
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
			$connector = " EXCEPT " if $connector;
		}
		elsif ( $hash->{'blastID'} ) {
			$conditional .=
			  " AND pfo.value LIKE '%" . $hash->{'blastID'} . "%'";
		}
		elsif ( $hash->{'blastDesc'} ) {
			$conditional .= " AND "
			  . generate_clause( $hash->{'blastDesc'}, "", "", "pfo.value" );
		}
		$query_blast = $connector . $query_blast . $conditional . ")";
		$connector   = "1";
	}
	if (   ( exists $hash->{'noRps'} && $hash->{'noRps'} )
		|| ( exists $hash->{'rpsID'}   && $hash->{'rpsID'} )
		|| ( exists $hash->{'rpsDesc'} && $hash->{'rpsDesc'} ) )
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
			$connector = " EXCEPT " if $connector;
		}
		elsif ( $hash->{'rpsID'} ) {
			$conditional .= " and pfo.value like '%" . $hash->{'rpsID'} . "%'";
		}
		elsif ( $hash->{'rpsDesc'} ) {
			$conditional .= " and "
			  . generate_clause( $hash->{'rpsDesc'}, "", "", "pfo.value" );
		}
		$query_RPS = $connector . $query_RPS . $conditional . ")";
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
			$connector = " except " if $connector;
			$conditional .= " and cpd.name = 'orthologous_group_id'";
		}
		elsif ( $hash->{'koID'} ) {
			$conditional .=
			  " and cpd.name = 'orthologous_group_id' and pd.value = '"
			  . $hash->{'koID'} . "'";
		}
		elsif ( $hash->{'keggPath'} ) {
			$conditional .=
			  " and cpd.name = 'metabolic_pathway_id' and pd.value like '%"
			  . $hash->{'keggPath'} . "%'";
		}
		elsif ( $hash->{'keggDesc'} ) {
			$query_KEGG .=
			    " join analysisfeature af on (r.subject_id = af.feature_id)"
			  . "join analysis a on (a.analysis_id = af.analysis_id) ";
			$conditional .=
" and a.program = 'annotation_pathways.pl' and cpd.name = 'orthologous_group_description' and "
			  . generate_clause( $hash->{'keggDesc'}, "", "", "pd.value" );
		}
		$query_KEGG = $connector . $query_KEGG . $conditional . ")";
		$connector  = "1";
	}
	if (   ( exists $hash->{'noOrth'} && $hash->{'noOrth'} )
		|| ( exists $hash->{'orthID'}   && $hash->{'orthID'} )
		|| ( exists $hash->{'orthDesc'} && $hash->{'orthDesc'} ) )
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
			$connector = " except " if $connector;
			$conditional .= " and cpd.name = 'orthologous_group' ";
		}
		elsif ( $hash->{'orthID'} ) {
			$conditional =
			  "and cpd.name = 'orthologous_group' and pd.value like '%"
			  . $hash->{'orthID'} . "%'";
		}
		elsif ( $hash->{'orthDesc'} ) {
			$query_ORTH .=
			    " join analysisfeature af on (r.subject_id = af.feature_id) "
			  . " join analysis a on (a.analysis_id = af.analysis_id) ";
			$conditional .=
" and a.program = 'annotation_orthology.pl' and cpd.name = 'orthologous_group_description' and "
			  . generate_clause( $hash->{'orthDesc'}, "", "", "pd.value" );
		}
		$query_ORTH = $connector . $query_ORTH . $conditional . ")";
		$connector  = "1";
	}
	if (   ( exists $hash->{'noIP'} && $hash->{'noIP'} )
		|| ( exists $hash->{'interproID'}   && $hash->{'interproID'} )
		|| ( exists $hash->{'interproDesc'} && $hash->{'interproDesc'} ) )
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
			$connector = " except " if $connector;
			$conditional .= "and cpr.name like 'interpro_id'";
		}
		elsif ( $hash->{'interproID'} ) {
			$conditional .=
			  "and cpr.name like 'interpro_id' and ppr.value = '"
			  . $hash->{'interproID'} . "'";
		}
		elsif ( $hash->{'interproDesc'} ) {
			$conditional .=
			  "and cpr.name like 'description%' and ppr.value like '%"
			  . $hash->{'interproDesc'} . "%'";
		}
		$query_interpro = $connector . $query_interpro . $conditional . ")";
		$connector      = 1;
	}

	$query =
	    $query
	  . $query_gene
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
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };
	return @rows;
}

=head2

Method used to generate clause for any query

=cut

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

=head2

Method used to return tRNA data from database

=cut

sub tRNA_search {
	my ( $self, $hash ) = @_;
	my $dbh = $self->dbh;

	my $query =
	    "select r.object_id, fp.value, pt.value, pa.value "
	  . "from feature_relationship r "
	  . "join cvterm c on (r.type_id = c.cvterm_id) "
	  . "join featureloc l on (r.subject_id = l.feature_id) "
	  . "join analysisfeature af on (af.feature_id = r.object_id) "
	  . "join analysis a on (a.analysis_id = af.analysis_id) "
	  . "join featureprop p on (p.feature_id = l.srcfeature_id) "
	  . "join cvterm cp on (p.type_id = cp.cvterm_id) "
	  . "join featureprop pt on (r.subject_id = pt.feature_id) "
	  . "join cvterm cpt on (pt.type_id = cpt.cvterm_id) "
	  . "join featureprop pa on (r.subject_id = pa.feature_id) "
	  . "join cvterm cpa on (pa.type_id = cpa.cvterm_id) "
	  . "join featureprop fp on (r.subject_id = fp.feature_id) "
	  . "join cvterm cfp on (fp.type_id = cfp.cvterm_id) "
	  . "where c.name='interval' and a.program = 'annotation_trna.pl' and cp.name='pipeline_id' and p.value='"
	  . $hash->{pipeline}
	  . "' and cpt.name='type' and cpa.name='anticodon' and cfp.name = 'sequence' ";

	my $anticodon = "";

	if ( $hash->{'tRNAaa'} ne "" ) {
		$query .= "and pt.value = '" . $hash->{'tRNAaa'} . "'";
	}
	elsif ( $hash->{'tRNAcd'} ne "" ) {
		$anticodon = reverseComplement( $hash->{'tRNAcd'} );
		$query .= "and pa.value = '$anticodon'";
	}

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{id}         = $rows[$i][0];
		$hash{sequence}   = $rows[$i][1];
		$hash{amino_acid} = $rows[$i][2];
		$hash{codon}      = $rows[$i][3];
		push @list, \%hash;
	}

	return @list;
}

=head2

Method used to return tandem repeats data from database

=cut

sub trf_search {
	my ( $self, $hash ) = @_;
	my $dbh = $self->dbh;

	my $connector = "";
	my $select =
	  "select fl.uniquename, l.fstart, l.fend, pp.value, pc.value, pur.value ";
	my $join = "from feature_relationship r
                 join featureloc l on (r.subject_id = l.feature_id)
                 join feature fl on (fl.feature_id = l.srcfeature_id)
                 join featureprop pp on (r.subject_id = pp.feature_id)
                 join cvterm cp on (pp.type_id = cp.cvterm_id)
                 join featureprop pc on (r.subject_id = pc.feature_id)
                 join cvterm cc on (pc.type_id = cc.cvterm_id)
                 join featureprop pur on (pur.feature_id = r.subject_id)
                 join cvterm cpur on (pur.type_id = cpur.cvterm_id)
                 join analysisfeature af on (r.object_id = af.feature_id)
                 join analysis a on (af.analysis_id = a.analysis_id)
                 join featureprop ps on (ps.feature_id = l.srcfeature_id)
                 join cvterm cps on (ps.type_id = cps.cvterm_id) ";
	my $query =
"where a.program = 'annotation_trf.pl' and cp.name = 'period_size' and cc.name = 'copy_number' and cpur.name='sequence' and cps.name='pipeline_id' and ps.value='"
	  . $hash->{pipeline} . "' ";

	if ( $hash->{'TRFrepSeq'} !~ /^\s*$/ ) {
		$hash->{'TRFrepSeq'} =~ s/\s+//g;
		$query .= "and pur.value ilike '%$hash->{'TRFrepSeq'}%' ";
		$connector = ",";
	}

	if ( $hash->{'TRFrepSize'} !~ /^\s*$/ ) {
		$hash->{'TRFrepSize'} =~ s/\s+//g;

		if ( $hash->{'TRFsize'} eq "exactTRF" ) {
			$query .= "and pp.value = '$hash->{'TRFrepSize'}' ";
			$connector = ",";
		}
		elsif ( $hash->{'TRFsize'} eq "orLessTRF" ) {
			$query .= "and my_to_decimal(pp.value) <= '$hash->{'TRFrepSize'}' ";
			$connector = ",";
		}
		elsif ( $hash->{'TRFsize'} eq "orMoreTRF" ) {
			$query .= "and my_to_decimal(pp.value) >= '$hash->{'TRFrepSize'}' ";
			$connector = ",";
		}
	}

	if (   $hash->{'TRFrepNumMin'} !~ /^\s*$/
		|| $hash->{'TRFrepNumMax'} !~ /^\s*$/ )
	{
		my $min = 0;
		my $max = 0;

		$hash->{'TRFrepNumMin'} =~ s/\s+//g;
		if ( $hash->{'TRFrepNumMin'} ) {
			$min++;
		}

		$hash->{'TRFrepNumMax'} =~ s/\s+//g;
		if ( $hash->{'TRFrepNumMax'} ) {
			$max++;
		}

		if ( $min && $max ) {
			if ( $hash->{'TRFrepNumMin'} == $hash->{'TRFrepNumMax'} ) {
				$query .=
				  "and my_to_decimal(pc.value) = $hash->{'TRFrepNumMax'} ";
			}
			elsif ( $hash->{'TRFrepNumMin'} < $hash->{'TRFrepNumMax'} ) {
				$query .=
"and my_to_decimal(pc.value) >= $hash->{'TRFrepNumMin'} and my_to_decimal(pc.value) <= $hash->{'TRFrepNumMax'} ";
			}
		}
		elsif ($min) {
			$query .= "and my_to_decimal(pc.value) >= $hash->{'TRFrepNumMin'} ";
		}
		elsif ($max) {
			$query .= "and my_to_decimal(pc.value) <= $hash->{'TRFrepNumMax'} ";
		}
	}

	$query = $select . $join . $query;

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{contig}      = $rows[$i][0];
		$hash{start}       = $rows[$i][1];
		$hash{end}         = $rows[$i][2];
		$hash{'length'}    = $rows[$i][3];
		$hash{copy_number} = $rows[$i][4];
		$hash{sequence}    = $rows[$i][5];
		push @list, \%hash;
	}

	return @list;
}

=head2

Method used to return non coding RNAs data from database

=cut

sub ncRNA_search {
	my ( $self, $hash ) = @_;
	my $dbh = $self->dbh;

	my $last_column = "";
	my $select =
	  "select distinct r.object_id, fl.uniquename, l.fstart, l.fend, pp.value";
	my $join = " from feature_relationship r 
                join featureloc lc on (r.subject_id = lc.feature_id)
                join feature fl on (fl.feature_id = lc.srcfeature_id)
                join cvterm c on (r.type_id = c.cvterm_id)
                join featureloc l on (r.subject_id = l.feature_id)
                join analysisfeature af on (af.feature_id = r.object_id)
                join analysis a on (a.analysis_id = af.analysis_id)
                join featureprop p on (p.feature_id = l.srcfeature_id) 
                join cvterm cp on (p.type_id = cp.cvterm_id) 
                join featureprop pp on (pp.feature_id = r.subject_id) 
                join cvterm cpp on (pp.type_id = cpp.cvterm_id) ";
	my $query =
"where c.name='interval' and a.program = 'annotation_infernal.pl' and cp.name='pipeline_id' and p.value='"
	  . $hash->{pipeline}
	  . "' and cpp.name='target_description' ";

	if ( $hash->{'ncRNAtargetID'} !~ /^\s*$/ ) {
		$hash->{'ncRNAtargetID'} =~ s/\s+//g;
		$select .= ", ppc.value";
		$last_column = "Target_ID";
		$join .=
"join featureprop ppc on (ppc.feature_id = r.subject_id) join cvterm cppc on (ppc.type_id = cppc.cvterm_id) ";
		$query .=
		  "and cppc.name = 'target_identifier' and ppc.value = '"
		  . $hash->{'ncRNAtargetID'} . "' ";
	}

	elsif ( $hash->{'ncRNAevalue'} !~ /^\s*$/ ) {
		$hash->{'ncRNAevalue'} =~ s/\s+//g;
		$select .= ", ppe.value";
		$last_column = "E-value";
		$join .=
"join featureprop ppe on (ppe.feature_id = r.subject_id) join cvterm cppe on (ppe.type_id = cppe.cvterm_id) ";
		if ( $hash->{'ncRNAevM'} eq "exactEv" ) {
			$query .=
			  "and cppe.name = 'evalue' and my_to_decimal(ppe.value) = "
			  . $hash->{'ncRNAevalue'};
		}
		elsif ( $hash->{'ncRNAevM'} eq "orLessEv" ) {
			$query .=
			  "and cppe.name = 'evalue' and my_to_decimal(ppe.value) <= "
			  . $hash->{'ncRNAevalue'};
		}
		elsif ( $hash->{'ncRNAevM'} eq "orMoreEv" ) {
			$query .=
			  "and cppe.name = 'evalue' and my_to_decimal(ppe.value) >= '"
			  . $hash->{'ncRNAevalue'} . "' ";
		}
	}
	elsif ( $hash->{'ncRNAtargetName'} !~ /^\s*$/ ) {
		$hash->{'ncRNAtargetName'} =~ s/^\s+//;
		$hash->{'ncRNAtargetName'} =~ s/\s+$//;
		$select .= ", ppn.value";
		$last_column = "Target_name";
		$join .=
"join featureprop ppn on (ppn.feature_id = r.subject_id) join cvterm cppn on (ppn.type_id = cppn.cvterm_id) ";
		$query .=
		  "and cppn.name = 'target_name' and ppn.value ilike '%"
		  . $hash->{'ncRNAtargetName'} . "%' ";
	}

	elsif ( $hash->{'ncRNAtargetClass'} !~ /^\s*$/ ) {
		$select .= ", ppc.value";
		$last_column = "Target_class";
		$join .=
"join featureprop ppc on (ppc.feature_id = r.subject_id) join cvterm cppc on (ppc.type_id = cppc.cvterm_id) ";
		$query .=
		  "and cppc.name = 'target_class' and ppc.value = '"
		  . $hash->{'ncRNAtargetClass'} . "'";
	}

	elsif ( $hash->{'ncRNAtargetType'} !~ /^\s*$/ ) {
		$hash->{'ncRNAtargetType'} =~ s/^\s+//;
		$hash->{'ncRNAtargetType'} =~ s/\s+$//;
		$select .= ", ppt.value";
		$last_column = "Target_type";
		$join .=
"join featureprop ppt on (ppt.feature_id = r.subject_id) join cvterm cppt on (ppt.type_id = cppt.cvterm_id) ";
		$query .=
		  "and cppt.name = 'target_type' and ppt.value ilike '%"
		  . $hash->{'ncRNAtargetType'} . "%' ";
	}
	elsif ( $hash->{'ncRNAtargetDesc'} !~ /^\s*$/ ) {
		$hash->{'ncRNAtargetDesc'} =~ s/^\s+//;
		$hash->{'ncRNAtargetDesc'} =~ s/\s+$//;
		$query .= "and pp.value ilike '%" . $hash->{'ncRNAtargetDesc'} . "%' ";
	}

	$query = $select . $join . $query;

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{id}          = $rows[$i][0];
		$hash{contig}      = $rows[$i][1];
		$hash{end}         = $rows[$i][2];
		$hash{start}       = $rows[$i][3];
		$hash{description} = $rows[$i][4];
		if ( $last_column ne "" ) {
			$hash{$last_column} = $rows[$i][5];
		}
		push @list, \%hash;
	}

	return @list;
}

=head2

Method used to return transcriptional terminator data from database

=cut

sub transcriptional_terminator_search {
	my ( $self, $hash ) = @_;
	my $dbh    = $self->dbh;
	my $select = "select fl.uniquename, l.fstart, l.fend, pp.value";
	my $join   = " from feature_relationship r
                 join featureloc lc on (r.subject_id = lc.feature_id)
                 join feature fl on (fl.feature_id = lc.srcfeature_id)
                 join cvterm c on (r.type_id = c.cvterm_id)
                 join featureloc l on (r.subject_id = l.feature_id)
                 join analysisfeature af on (af.feature_id = r.object_id)
                 join analysis a on (a.analysis_id = af.analysis_id)
                 join featureprop p on (p.feature_id = l.srcfeature_id)
                 join cvterm cp on (p.type_id = cp.cvterm_id)
                 join featureprop pp on (pp.feature_id = r.subject_id)
                 join cvterm cpp on (pp.type_id = cpp.cvterm_id) ";
	my $query =
"where c.name='interval' and a.program = 'annotation_transterm.pl' and cp.name='pipeline_id' and p.value='"
	  . $hash->{pipeline} . "' ";

	my $search_field;
	my $field;
	my $modifier;

	if ( $hash->{'TTconf'} !~ /^\s*$/ ) {
		$search_field = $hash->{'TTconf'};
		$modifier     = $hash->{'TTconfM'};
		$field        = "confidence";
	}
	elsif ( $hash->{'TThp'} !~ /^\s*$/ ) {
		$search_field = $hash->{'TThp'};
		$modifier     = $hash->{'TThpM'};
		$field        = "hairpin";
	}
	elsif ( $hash->{'TTtail'} !~ /^\s*$/ ) {
		$search_field = $hash->{'TTtail'};
		$modifier     = $hash->{'TTtailM'};
		$field        = "tail";
	}

	$search_field =~ s/\s+//g;

	if ( $modifier eq "exact" ) {
		$query .=
"and cpp.name = '$field' and my_to_decimal(pp.value) = $search_field ";
	}
	elsif ( $modifier eq "orLess" ) {
		$query .=
"and cpp.name = '$field' and my_to_decimal(pp.value) <= $search_field ";
	}
	elsif ( $modifier eq "orMore" ) {
		$query .=
"and cpp.name = '$field' and my_to_decimal(pp.value) >= $search_field ";
	}

	$query = $select . $join . $query;

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{contig} = $rows[$i][0];
		$hash{start}  = $rows[$i][1];
		$hash{end}    = $rows[$i][2];
		if ( $hash->{'TTconf'} !~ /^\s*$/ ) {
			$hash{confidence} = $rows[$i][3];
		}
		elsif ( $hash->{'TThp'} !~ /^\s*$/ ) {
			$hash{hairpin_score} = $rows[$i][3];
		}
		elsif ( $hash->{'TTtail'} !~ /^\s*$/ ) {
			$hash{tail_score} = $rows[$i][3];
		}

		push @list, \%hash;
	}

	return @list;
}

=head2

Method used to return ribosomal binding sites data from database

=cut

sub rbs_search {
	my ( $self, $hash ) = @_;
	my $dbh = $self->dbh;

	my $last_column = "";
	my $select      = "select fl.uniquename, l.fstart, l.fend, pp.value";
	my $join        = " from feature_relationship r
                join featureloc lc on (r.subject_id = lc.feature_id) 
                join feature fl on (fl.feature_id = lc.srcfeature_id) 
                join cvterm c on (r.type_id = c.cvterm_id)
                join featureloc l on (r.subject_id = l.feature_id)
                join analysisfeature af on (af.feature_id = r.object_id)
                join analysis a on (a.analysis_id = af.analysis_id)
                join featureprop p on (p.feature_id = l.srcfeature_id)
                join cvterm cp on (p.type_id = cp.cvterm_id)
                join featureprop pp on (pp.feature_id = r.subject_id)
                join cvterm cpp on (pp.type_id = cpp.cvterm_id)";
	my $query =
"where c.name='interval' and a.program = 'annotation_rbsfinder.pl' and cp.name='pipeline_id' and p.value='"
	  . $hash->{pipeline} . "' ";

	my $newcodon = 0;

	if ( $hash->{'RBSpattern'} !~ /^\s*$/ ) {
		$hash->{'RBSpattern'} =~ s/\s*//g;
		$query .=
		  "and cpp.name='RBS_pattern' and pp.value like '%"
		  . $hash->{'RBSpattern'} . "'";
	}
	elsif ( $hash->{'RBSshift'} ) {
		if ( $hash->{'RBSshiftM'} eq "both" ) {
			$query .= "and cpp.name='position_shift' and pp.value <> 0";
		}
		elsif ( $hash->{'RBSshiftM'} eq "neg" ) {
			$query .=
			  "and cpp.name='position_shift' and my_to_decimal(pp.value) < 0";
		}
		elsif ( $hash->{'RBSshiftM'} eq "pos" ) {
			$query .=
			  "and cpp.name='position_shift' and my_to_decimal(pp.value) > 0";
		}
	}
	elsif ( $hash->{'RBSnewcodon'} ) {
		$select .= ", pp2.value";
		$last_column = "new_start";
		$join .=
"join featureprop pp2 on (pp2.feature_id = r.subject_id) join cvterm cpp2 on (pp2.type_id = cpp2.cvterm_id)";
		$query .=
"and cpp.name='old_start_codon' and cpp2.name='new_start_codon' and (pp.value <> pp2.value)";
		$newcodon++;
	}

	$query = $select . $join . $query;

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };
	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{contig} = $rows[$i][0];
		$hash{start}  = $rows[$i][2];
		$hash{end}    = $rows[$i][1];

		if ( $hash->{'RBSpattern'} !~ /^\s*$/ ) {
			$hash{site_pattern} = $rows[$i][3];
		}
		elsif ( exists $rows[$i][4] ) {
			$hash{old_start} = $rows[$i][3];
			$hash{new_start} = $rows[$i][4];
		}
		else {
			$hash{position_shift} = $rows[$i][3];
		}

		push @list, \%hash;
	}

	return @list;
}

=head2

Method used to return horizontal transferences data from database

=cut

sub alienhunter_search {
	my ( $self, $hash ) = @_;
	my $dbh = $self->dbh;

	my $select =
	  "select r.object_id, fl.uniquename, l.fstart, l.fend, pp.value";
	my $join = " from feature_relationship r
                join featureloc lc on (r.subject_id = lc.feature_id) 
                join feature fl on (fl.feature_id = lc.srcfeature_id) 
                join cvterm c on (r.type_id = c.cvterm_id)
                join featureloc l on (r.subject_id = l.feature_id)
                join analysisfeature af on (af.feature_id = r.object_id)
                join analysis a on (a.analysis_id = af.analysis_id)
                join featureprop p on (p.feature_id = l.srcfeature_id)
                join cvterm cp on (p.type_id = cp.cvterm_id)
                join featureprop pp on (pp.feature_id = r.subject_id)
                join cvterm cpp on (pp.type_id = cpp.cvterm_id) ";
	my $query =
"where c.name='interval' and a.program = 'annotation_alienhunter.pl' and cp.name='pipeline_id' and p.value='"
	  . $hash->{pipeline} . "' ";

	my $search_field;
	my $field;
	my $modifier;

	if ( $hash->{'AHlen'} !~ /^\s*$/ ) {
		$search_field = $hash->{'AHlen'};
		$modifier     = $hash->{'AHlenM'};
		$field        = "length";
	}
	elsif ( $hash->{'AHscore'} !~ /^\s*$/ ) {
		$search_field = $hash->{'AHscore'};
		$modifier     = $hash->{'AHscM'};
		$field        = "score";
	}
	elsif ( $hash->{'AHthr'} !~ /^\s*$/ ) {
		$search_field = $hash->{'AHthr'};
		$modifier     = $hash->{'AHthrM'};
		$field        = "threshold";
	}

	$search_field =~ s/\s+//g;

	if ( $modifier eq "exact" ) {
		$query .=
"and cpp.name = '$field' and my_to_decimal(pp.value) = $search_field ";
	}
	elsif ( $modifier eq "orLess" ) {
		$query .=
"and cpp.name = '$field' and my_to_decimal(pp.value) <= $search_field ";
	}
	elsif ( $modifier eq "orMore" ) {
		$query .=
"and cpp.name = '$field' and my_to_decimal(pp.value) >= $search_field ";
	}

	$query = $select . $join . $query;

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };
	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{id}     = $rows[$i][0];
		$hash{contig} = $rows[$i][1];
		$hash{start}  = $rows[$i][2];
		$hash{end}    = $rows[$i][3];
		if ( $hash->{'AHlen'} !~ /^\s*$/ ) {
			$hash{'length'} = $rows[$i][4];
		}
		elsif ( $hash->{'AHscore'} !~ /^\s*$/ ) {
			$hash{score} = $rows[$i][4];
		}
		elsif ( $hash->{'AHthr'} !~ /^\s*$/ ) {
			$hash{threshold} = $rows[$i][4];
		}

		push @list, \%hash;
	}

	return @list;
}

=head2

Method used to return the reverse complement

=cut

sub reverseComplement {
	my ($sequence) = @_;
	my $reverseComplement = reverse($sequence);
	$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return $reverseComplement;
}

sub searchGene {
	my ( $self, $html, $hash ) = @_;
	my $dbh = $self->dbh;

	my $query =
"SELECT me.feature_id, feature_relationship_props_subject_feature.value, feature_relationship_props_subject_feature_2.value "
	  . "FROM feature me "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_2 ON feature_relationship_objects_2.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature ON feature_relationship_props_subject_feature.feature_id = feature_relationship_objects_2.subject_id "
	  . "LEFT JOIN cvterm type ON type.cvterm_id = feature_relationship_props_subject_feature.type_id "
	  . "LEFT JOIN cvterm type_2 ON type_2.cvterm_id = feature_relationship_objects_2.type_id "
	  . "LEFT JOIN featureloc featureloc_features_2 ON featureloc_features_2.feature_id = me.feature_id "
	  . "LEFT JOIN featureprop featureloc_featureprop ON featureloc_featureprop.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN cvterm type_3 ON type_3.cvterm_id = featureloc_featureprop.type_id "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_4 ON feature_relationship_objects_4.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature_2 ON feature_relationship_props_subject_feature_2.feature_id = feature_relationship_objects_4.subject_id "
	  . "LEFT JOIN cvterm type_4 ON type_4.cvterm_id = feature_relationship_props_subject_feature_2.type_id ";
	my $where =
"WHERE type.name = 'locus_tag' AND type_2.name = 'based_on' AND type_3.name = 'pipeline_id' AND type_4.name = 'description' AND featureloc_featureprop.value = '"
	  . $hash->{pipeline} . "' ";

	my $connector = "";
	if ( exists $hash->{featureId} && $hash->{featureId} ) {
		if ( index( $hash->{featureId}, " " ) != -1 ) {
			$where .= " AND (";
			while ( $hash->{featureId} =~ /(\d+)+/g ) {
				$connector = " OR " if $connector;
				$where .= $connector . "me.feature_id = '$1'";
				$connector = "1";
			}
			$where .= ")";
		}
		else {

			$where .= " AND me.feature_id = '" . $hash->{featureId} . "'";
			$connector = "1";
		}
	}

	if (   ( exists $hash->{geneDescription} && $hash->{geneDescription} )
		or ( exists $hash->{noDescription} && $hash->{noDescription} ) )
	{
		$connector = " AND " if $connector;
		$where .= $connector;
		my @likesDescription   = ();
		my @likesNoDescription = ();
		if ( $hash->{geneDescription} ) {
			while ( $hash->{geneDescription} =~ /(\S+)/g ) {
				push @likesDescription,
				  generate_clause( "$1", "", "",
					"feature_relationship_props_subject_feature_2.value" );
			}
		}
		if ( $hash->{noDescription} ) {
			while ( $hash->{noDescription} =~ /(\S+)/g ) {
				push @likesNoDescription,
				  generate_clause( "$1", "NOT", "",
					"feature_relationship_props_subject_feature_2.value" );
			}
		}

		if (    exists $hash->{individually}
			and $hash->{individually}
			and scalar(@likesDescription) > 0 )
		{
			if ( scalar(@likesNoDescription) > 0 ) {
				foreach my $like (@likesDescription) {
					$where .= " AND " . $like;
				}
				foreach my $notLike (@likesNoDescription) {
					$where .= " AND " . $notLike;
				}
			}
			else {
				foreach my $like (@likesDescription) {
					$where .= " AND " . $like;
				}
			}
		}
		elsif ( scalar(@likesDescription) > 0 ) {
			my $and = "";
			if ( scalar(@likesNoDescription) > 0 ) {
				foreach my $notLike (@likesNoDescription) {
					$where .= " AND " . $notLike;
				}
				$and = "1";
			}
			if ($and) {
				$and = " AND ";
			}
			else {
				$and = " OR ";
			}
			$where .= " AND (";
			my $counter = 0;
			foreach my $like (@likesDescription) {
				if ( $counter == 0 ) {
					$where .= $like;
					$counter++;
				}
				else {
					$where .= $and . $like;
				}
			}
			$where .= " ) ";
		}
		elsif ( scalar(@likesDescription) <= 0
			and scalar(@likesNoDescription) > 0 )
		{
			foreach my $like (@likesNoDescription) {
				$where .= " AND " . $like;
			}
		}
	}

	if ( exists $hash->{geneID} && $hash->{geneID} ) {
		$where .=
		  " AND feature_relationship_props_subject_feature.value LIKE '%"
		  . $hash->{geneID} . "%'";
	}

	$query .= $where
	  . " ORDER BY feature_relationship_props_subject_feature.value ASC ";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };
	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{feature_id} = $rows[$i][0];
		$hash{name}       = $rows[$i][1];
		$hash{uniquename} = $rows[$i][2];
		$hash{html}       = $html;

		push @list, \%hash;
	}

	return \@list;
}

sub geneBasics {
	my ( $self, $html, $hash ) = @_;
	my $dbh = $self->dbh;

	my $query =
"SELECT featureloc_features_2.fstart, featureloc_features_2.fend, featureprops_2.value, srcfeature.uniquename, srcfeature.feature_id "
	  . "FROM feature me "
	  . "LEFT JOIN feature_relationship feature_relationship_objects_2 ON feature_relationship_objects_2.object_id = me.feature_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature ON feature_relationship_props_subject_feature.feature_id = feature_relationship_objects_2.subject_id "
	  . "LEFT JOIN cvterm type ON type.cvterm_id = feature_relationship_props_subject_feature.type_id "
	  . "LEFT JOIN cvterm type_2 ON type_2.cvterm_id = feature_relationship_objects_2.type_id "
	  . "LEFT JOIN featureprop featureprops_2 ON featureprops_2.feature_id = me.feature_id "
	  . "LEFT JOIN cvterm type_3 ON type_3.cvterm_id = featureprops_2.type_id "
	  . "LEFT JOIN featureloc featureloc_features_2 ON featureloc_features_2.feature_id = me.feature_id "
	  . "LEFT JOIN feature srcfeature ON srcfeature.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN featureprop featureloc_featureprop ON featureloc_featureprop.feature_id = featureloc_features_2.srcfeature_id "
	  . "LEFT JOIN cvterm type_4 ON type_4.cvterm_id = featureloc_featureprop.type_id "
	  . "WHERE ( ( featureloc_featureprop.value = '"
	  . $hash->{pipeline}
	  . "' AND me.feature_id = '"
	  . $hash->{feature_id}
	  . "' AND type.name = 'locus_tag' AND type_2.name = 'based_on' AND type_3.name = 'tag' AND type_4.name = 'pipeline_id' ) ) "
	  . "GROUP BY featureloc_features_2.fstart, featureloc_features_2.fend, featureprops_2.value, srcfeature.uniquename, srcfeature.feature_id "
	  . "ORDER BY MIN( feature_relationship_props_subject_feature.value )";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };
	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{'fstart'}     = $rows[$i][0];
		$hash{'fend'}       = $rows[$i][1];
		$hash{'value'}      = $rows[$i][2];
		$hash{'uniquename'} = $rows[$i][3];
		$hash{'feature_id'} = $rows[$i][4];
		$hash{'html'}       = $html;

		push @list, \%hash;
	}

	return \@list;
}

sub ncRNA_description {
	my ( $self, $feature_id, $pipeline ) = @_;
	my $dbh = $self->dbh;

	my $query =
	  "SELECT me.object_id, feature_relationship_props_subject_feature_2.value "
	  . "FROM feature_relationship me  "
	  . "JOIN cvterm type ON type.cvterm_id = me.type_id "
	  . "LEFT JOIN analysisfeature feature_relationship_analysis_feature_feature_object_2 ON feature_relationship_analysis_feature_feature_object_2.feature_id = me.object_id "
	  . "LEFT JOIN analysis analysis ON analysis.analysis_id = feature_relationship_analysis_feature_feature_object_2.analysis_id "
	  . "LEFT JOIN featureloc feature_relationship_featureloc_subject_feature_2 ON feature_relationship_featureloc_subject_feature_2.feature_id = me.subject_id "
	  . "LEFT JOIN featureprop featureloc_featureprop ON featureloc_featureprop.feature_id = feature_relationship_featureloc_subject_feature_2.srcfeature_id "
	  . "LEFT JOIN cvterm type_2 ON type_2.cvterm_id = featureloc_featureprop.type_id "
	  . "LEFT JOIN featureprop feature_relationship_props_subject_feature_2 ON feature_relationship_props_subject_feature_2.feature_id = me.subject_id "
	  . "LEFT JOIN cvterm type_3 ON type_3.cvterm_id = feature_relationship_props_subject_feature_2.type_id "
	  . "WHERE ( ( analysis.program = 'annotation_infernal.pl' AND featureloc_featureprop.value = '"
	  . $pipeline
	  . "' AND me.object_id = '"
	  . $feature_id
	  . "' AND type.name = 'interval' AND type_2.name = 'pipeline_id' AND type_3.name = 'target_description' ) ) "
	  . "GROUP BY me.object_id, feature_relationship_props_subject_feature_2.value "
	  . "ORDER BY feature_relationship_props_subject_feature_2.value ASC";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };
	my %hash = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		$hash{'object_id'} = $rows[$i][0];
		$hash{'value'}     = $rows[$i][1];
	}

	return \%hash;
}

sub subevidences {
	my ( $self, $feature_id ) = @_;
	my $dbh = $self->dbh;

	my $query = "SELECT * FROM get_subevidences('" . $feature_id . "')";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my %component_name = (
		'annotation_interpro.pl' => 'Domain search - InterProScan',
		'annotation_blast.pl'    => 'Similarity search - BLAST',
		'annotation_rpsblast.pl' => 'Similarity search - RPSBLAST',
		'annotation_phobius.pl' =>
		  'Transmembrane domains and signal peptide search - Phobius',
		'annotation_pathways.pl'  => 'Pathway classification - KEGG',
		'annotation_orthology.pl' => 'Orthology assignment - eggNOG',
		'annotation_tcdb.pl'      => 'Transporter classification - TCDB',
		'annotation_dgpi.pl'      => 'GPI anchor - DGPI',
		'annotation_tmhmm.pl'     => 'TMHMM',
	);

	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{subev_id}           = $rows[$i][0];
		$hash{subev_type}         = $rows[$i][1];
		$hash{subev_number}       = $rows[$i][2];
		$hash{subev_start}        = $rows[$i][3];
		$hash{subev_end}          = $rows[$i][4];
		$hash{subev_strand}       = $rows[$i][5];
		$hash{is_obsolete}        = $rows[$i][6];
		$hash{program}            = $rows[$i][7];
		$hash{descriptionProgram} = $component_name{ $hash{program} };

		push @list, \%hash;
	}

	return \@list;
}

sub intervalEvidenceProperties {
	my ( $self, $feature_id ) = @_;
	my $dbh = $self->dbh;

	my $query = "SELECT * FROM get_interval_evidence_properties($feature_id)";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my @list = ();

	my @listProperties = ();
	my %property       = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{key}       = $rows[$i][0];
		$hash{key_value} = $rows[$i][1];

		push @list, \%hash;
	}

	for ( my $i = 0 ; $i < scalar @list ; $i++ ) {
		my $hash = $list[$i];
		if ( !exists $property{ $hash->{key} } ) {
			if ( $hash->{key} eq "anticodon" ) {
				$property{ $hash->{key} } = $hash->{key_value};
				$property{codon} = reverseComplement( $hash->{key_value} );
			}
			else {
				$property{ $hash->{key} } = $hash->{key_value};
			}
		}
		else {
			my %tempHash = ();
			foreach my $key ( keys %property ) {
				if ( defined $key && $key ) {
					$tempHash{$key} = $property{$key};
				}
			}
			push @listProperties, \%tempHash;
			%property = ();
			if ( $hash->{key} eq "anticodon" ) {
				$property{ $hash->{key} } = $hash->{key_value};
				$property{codon} = reverseComplement( $hash->{key_value} );
			}
			else {
				$property{ $hash->{key} } = $hash->{key_value};
			}
		}
		if ( scalar @listProperties == 0 ) {
			push @listProperties, \%property;
		}
	}

	return \@listProperties;
}

sub similarityEvidenceProperties {
	my ( $self, $feature_id, $html ) = @_;
	my $dbh = $self->dbh;

	my $query = "SELECT * FROM get_similarity_evidence_properties($feature_id)";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{key}       = $rows[$i][0];
		$hash{key_value} = $rows[$i][1];
		push @list, \%hash;
	}
	my %hash = ();
	for ( my $i = 0 ; $i < scalar @list ; $i++ ) {
		my $result = $list[$i];
		if ( $result->{key} eq "anticodon" ) {
			$hash{ $result->{key} } = $result->{key_value};
			$hash{codon} = reverseComplement( $result->{key_value} );
		}
		else {
			$hash{ $result->{key} } = $result->{key_value};
		}
	}
	$hash{html} = $html;
	$hash{id}   = $feature_id;

	return \%hash;

}

sub get_feature_id {
	my ( $self, $uniquename ) = @_;
	my $dbh = $self->dbh;

	my $query =
	  "SELECT feature_id FROM feature WHERE uniquename = '$uniquename' LIMIT 1";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	return $rows[0][0];
}

sub get_target_class {
	my ( $self, $type_id, $feature_id ) = @_;
	my $dbh = $self->dbh;

	my $query =
	    "SELECT value FROM featureprop WHERE type_id = "
	  . $type_id
	  . " AND feature_id = "
	  . $feature_id
	  . " ORDER BY value ASC";

	my $sth = $dbh->prepare($query);
	print STDERR $query;
	$sth->execute();
	my @rows = @{ $sth->fetchall_arrayref() };

	my @list = ();
	for ( my $i = 0 ; $i < scalar @rows ; $i++ ) {
		my %hash = ();
		$hash{value} = $rows[$i][0];
		push @list, \%hash;
	}

	return @list;
}

=head1 NAME

HTML_DIR::Model::DBI - DBI Model Class

=head1 SYNOPSIS

See L<HTML_DIR>

=head1 DESCRIPTION

DBI Model Class.

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
