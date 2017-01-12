package TESTE::Controller::SearchDatabase;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

TESTE::Controller::SearchDatabase - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2 searchGene

Method used to search on database genes

=cut

sub searchGene : Path("/SearchDatabase/Gene") : CaptureArgs(5) :
  ActionClass('REST') { }

sub searchGene_GET {
	my ( $self, $c, $geneID, $geneDescription, $noDescription, $individually,
		$featureId )
	  = @_;

	if ( !$geneID and defined $c->request->param("geneID") ) {
		$geneID = $c->request->param("geneID");
	}
	if ( !$geneDescription and defined $c->request->param("geneDesc") ) {
		$geneDescription = $c->request->param("geneDesc");
	}
	if ( !$noDescription and defined $c->request->param("noDesc") ) {
		$noDescription = $c->request->param("noDesc");
	}
	if ( !$individually and defined $c->request->param("individually") ) {
		$individually = $c->request->param("individually");
	}
	if ( !$featureId and defined $c->request->param("featureId") ) {
		$featureId = $c->request->param("featureId");
	}

	use File::Basename;
	open( my $FILEHANDLER,
		"<",
		dirname(__FILE__) . "/../../../root/teste/search-database/gene.tt" );

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);

	my @list = ();
	my %hash = ();
	$hash{pipeline}        = 4249;
	$hash{featureId}       = $featureId;
	$hash{geneID}          = $geneID;
	$hash{geneDescription} = $geneDescription;
	$hash{noDescription}   = $noDescription;
	$hash{individually}    = $individually;

	$self->status_ok( $c,
		entity => $c->model('DBI')->searchGene( $content, \%hash ) );
}

=head2 encodingCorrection

Method used to correct encoding strings come from SQLite

=cut

sub encodingCorrection {
	my (@texts) = @_;

	use utf8;
	use Encode qw( decode encode );
	foreach my $text (@texts) {
		foreach my $key ( keys %$text ) {
			if ( $text->{$key} != 1 ) {
				my $string = decode( 'utf-8', $text->{$key}{value} );
				$string = encode( 'iso-8859-1', $string );
				$text->{$key}{value} = $string;
			}
		}
	}
	return @texts;
}

=head2 searchContig

Method used to realize search by contigs, optional return a stretch or a reverse complement

=cut

sub searchContig : Path("/SearchDatabase/Contig") : CaptureArgs(4) :
  ActionClass('REST') { }

sub searchContig_GET {
	my ( $self, $c, $contig, $start, $end, $reverseComplement ) = @_;
	if ( !$contig and defined $c->request->param("contig") ) {
		$contig = $c->request->param("contig");
	}
	if ( !$start and defined $c->request->param("contigStart") ) {
		$start = $c->request->param("contigStart");
	}
	if ( !$end and defined $c->request->param("contigEnd") ) {
		$end = $c->request->param("contigEnd");
	}
	if ( !$reverseComplement
		and defined $c->request->param("revCompContig") )
	{
		$reverseComplement = $c->request->param("revCompContig");
	}

	use File::Basename;
	my $data     = "";
	my $sequence = $c->model('Basic::Sequence')->find($contig);

	open( my $FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . $sequence->filepath );

	for my $line (<$FILEHANDLER>) {
		if ( !( $line =~ /^>\w+\n$/g ) ) {
			$data .= $line;
		}
	}
	close($FILEHANDLER);

	if ( $start && $end ) {
		$data = substr( $data, $start, ( $end - $start ) );
		$c->stash->{start}     = $start;
		$c->stash->{end}       = $end;
		$c->stash->{hadLimits} = 1;
	}
	if ( defined $reverseComplement ) {
		$data = formatSequence( reverseComplement($data) );
		$c->stash->{hadReverseComplement} = 1;
	}
	my $result = "";
	for ( my $i = 0 ; $i < length($data) ; $i += 60 ) {
		my $line = substr( $data, $i, 60 );
		$result .= "$line<br />";
	}

	my @list = ();
	my %hash = ();
	$hash{'geneID'} = $sequence->id;
	$hash{'gene'}   = $sequence->name;
	$hash{'contig'} = $result;

	open( $FILEHANDLER, "<",
		dirname(__FILE__)
		  . "/../../../root/teste/search-database/contigs.tt" );

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);

	$hash{'html'} = $content;
	push @list, \%hash;
	$self->status_ok( $c, entity => @list );
}

=head2 getGeneBasics
Method used to return basic data of genes from database: the beginning position from sequence, final position from the sequence, type, name
return a list of hash containing the basic data

=cut

sub getGeneBasics : Path("/SearchDatabase/GetGeneBasics") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getGeneBasics_GET {
	my ( $self, $c, $id ) = @_;

	#verify if the id exist and set
	if ( !$id and defined $c->request->param("id") ) {
		$id = $c->request->param("id");
	}

	open(
		my $FILEHANDLER,
		"<",
		dirname(__FILE__)
		  . "/../../../root/teste/search-database/geneBasics.tt"
	);

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER)

	  ;
	my %hash = ();
	$hash{pipeline}   = 4249;
	$hash{feature_id} = $id;

	$self->status_ok( $c,
		entity => $c->model('DBI')->geneBasics( $content, \%hash ) );
}

=head2 getSubsequence

Method used to get subsequence stretch of gene, returning the sequence, had to return in a json!

=cut

sub getSubsequence : Path("/SearchDatabase/GetSubsequence") : CaptureArgs(5) :
  ActionClass('REST') { }

sub getSubsequence_GET {
	my ( $self, $c, $type, $contig, $sequenceName, $start, $end ) = @_;
	if ( !$contig and defined $c->request->param("contig") ) {
		$contig = $c->request->param("contig");
	}
	if ( !$type and defined $c->request->param("type") ) {
		$type = $c->request->param("type");
	}

	use File::Basename;
	open(
		my $FILEHANDLER,
		"<",
		dirname(__FILE__)
		  . "/../../../root/teste/search-database/sequence.tt"
	);

	my $html = do { local $/; <$FILEHANDLER> };
	my $content = "";
	close($FILEHANDLER);

	if ( $type ne "CDS" ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/seq/"
			  . $sequenceName
			  . ".fasta"
		);
		for my $line (<$FILEHANDLER>) {
			if ( !( $line =~ /^>\w+\n$/g ) ) {
				$content .= $line;
			}
		}

		close($FILEHANDLER);

		if ( $start && $end ) {
			$content = substr( $content, $start, ( $end - ( $start + 1 ) ) );
		}
		my $result = "";
		for ( my $i = 0 ; $i < length($content) ; $i += 60 ) {
			my $line = substr( $content, $i, 60 );
			$result .= "$line<br />";
		}
		$content = $result;
	}
	else {
		open( $FILEHANDLER, "<",
			    dirname(__FILE__)
			  . "/../../../root/orfs_aa/"
			  . $contig
			  . ".fasta" );

		for my $line (<$FILEHANDLER>) {
			if ( !( $line =~ /^>\w+\n$/g ) ) {
				$content .= $line;
			}
		}
		close($FILEHANDLER);
		$content =~ s/\n/<br \/>/g;
	}
	$self->status_ok( $c,
		entity => { "sequence" => $content, "html" => $html } );
}

=head2 ncRNA_desc  

Method used to return nc rna description

=cut

sub ncRNA_desc : Path("/SearchDatabase/ncRNA_desc") : CaptureArgs(1) :
  ActionClass('REST') { }

sub ncRNA_desc_GET {
	my ( $self, $c, $feature ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	my $pipeline = 4249;
	$self->status_ok( $c, entity => $c->model('DBI')->ncRNA_description( $feature, $pipeline ) );
}

=head2

Method used to return subevidences based on feature id

=cut

sub subEvidences : Path("/SearchDatabase/subEvidences") : CaptureArgs(1) :
  ActionClass('REST') { }

sub subEvidences_GET {
	my ( $self, $c, $feature ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	
	my %returnedHash = ();
	$returnedHash{subevidences} = $c->model('DBI')->subevidences( $feature);
	open(
		my $FILEHANDLER,
		"<",
		dirname(__FILE__)
		  . "/../../../root/teste/search-database/subEvidences.tt"
	);

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);
	$returnedHash{subEvidencesHtml} = { "content" => $content };
	open( $FILEHANDLER, "<",
		dirname(__FILE__)
		  . "/../../../root/teste/search-database/evidences.tt" );

	$content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);
	$returnedHash{evidencesHtml} = { "content" => $content };
	$self->status_ok( $c, entity => \%returnedHash );
}

=head2

Method used to return properties of evidences that the type is interval and basic data of everything isn't CDS

=cut

sub getIntervalEvidenceProperties :
  Path("/SearchDatabase/getIntervalEvidenceProperties") : CaptureArgs(2) :
  ActionClass('REST') { }

sub getIntervalEvidenceProperties_GET {
	my ( $self, $c, $feature, $typeFeature ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}

	my %hash           = ();
	$hash{properties} = $c->model('DBI')->intervalEvidenceProperties($feature);
	if ( exists $hash{intron} ) {
		if ( $hash{intron} eq 'yes' ) {
			$hash{coordinatesGene} = $hash{intron_start} - $hash{intron_end};
			$hash{coordinatesGenome} =
			  $hash{intron_start_seq} - $hash{intron_end_seq};
			open(
				my $FILEHANDLER,
				"<",
				dirname(__FILE__)
				  . "/../../../root/teste/search-database/tRNABasicResultHasIntron.tt"
			);

			my $content = do { local $/; <$FILEHANDLER> };
			close($FILEHANDLER);
			$hash{htmlHasIntron} = $content;
		}
	}
	if ( $typeFeature eq 'tRNAscan' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/tRNABasicResult.tt"
		);

		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{htmlBasicResult} = $content;
	}
	elsif ( $typeFeature eq 'RNA_scan' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/rnaScanBasicResult.tt"
		);

		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{htmlBasicResult} = $content;
	}
	elsif ( $typeFeature eq 'rRNA_prediction' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/rRNAPredictionBasicResult.tt"
		);

		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{htmlBasicResult} = $content;
	}

	#components used
	elsif ( $typeFeature eq 'annotation_interpro' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/interproBasicResult.tt"
		);

		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{html} = $content;
		$hash{id}   = $feature;
	}
	elsif ( $typeFeature eq 'annotation_tmhmm' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/tmhmmBasicResult.tt"
		);

		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{html} = $content;
		$hash{id}   = $feature;
	}
	elsif ( $typeFeature eq 'annotation_tcdb' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/tcdbBasicResult.tt"
		);
		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{html} = $content;
		$hash{id}   = $feature;
	}
	elsif ( $typeFeature eq 'annotation_pathways' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/pathwaysBasicResult.tt"
		);

		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);

		my @pathways        = ();
		my @ids             = ();
		my @descriptions    = ();
		my @classifications = ();
		for ( my $i = 0 ; $i < scalar @{ $hash{properties} } ; $i++ ) {
			while ( $hash{properties}[$i]->{metabolic_pathway_classification} =~
				/([\w\s]+)/g )
			{
				push @classifications, $1;
			}
			while ( $hash{properties}[$i]->{metabolic_pathway_description} =~
				/([\w\s]+)/g )
			{
				push @descriptions, $1;
			}
			while (
				$hash{properties}[$i]->{metabolic_pathway_id} =~ /([\w\s]+)/g )
			{
				push @ids, $1;
			}
			for ( my $j = 0 ; $j < scalar @ids ; $j++ ) {
				my %pathway = ();
				$pathway{id}            = $ids[$j];
				$pathway{description}   = $descriptions[$j];
				$pathway{classfication} = $classifications[$j];
				push @pathways, \%pathway;
			}
		}

		$hash{pathways} = \@pathways;
		$hash{html}     = $content;
		open( $FILEHANDLER, "<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/pathways.tt" );
		my $pathwaysHTML = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{htmlPathways} = $pathwaysHTML;
		$hash{id}           = $feature;
	}
	elsif ( $typeFeature eq 'annotation_orthology' ) {
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/orthologyBasicResult.tt"
		);

		my $content = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		my @orthologous_groups = ();
		my @groups             = ();
		my @descriptions       = ();
		my @classifications    = ();
		for ( my $i = 0 ; $i < scalar @{ $hash{properties} } ; $i++ ) {
			while ( $hash{properties}[$i]->{orthologous_group} =~
				/([\w\s.\-(),]+)/g )
			{
				push @groups, $1;
			}
			while ( $hash{properties}[$i]->{orthologous_group_description} =~
				/([\w\s.\-(),]+)/g )
			{
				push @descriptions, $1;
			}
			while ( $hash{properties}[$i]->{orthologous_group_classification} =~
				/([\w\s.\-(),]+)/g )
			{
				push @classifications, $1;
			}
			for ( my $j = 0 ; $j < scalar @groups ; $j++ ) {
				my %group = ();
				$group{group}          = $groups[$j];
				$group{description}    = $descriptions[$j];
				$group{classification} = $classifications[$j];
				push @orthologous_groups, \%group;
			}
		}
		open( $FILEHANDLER, "<",
			dirname(__FILE__)
			  . "/../../../root/teste/search-database/orthologies.tt" );
		my $orthologyHTML = do { local $/; <$FILEHANDLER> };
		close($FILEHANDLER);
		$hash{orthologous_groups} = \@orthologous_groups;
		$hash{htmlOrthology}      = $orthologyHTML;
		$hash{html}               = $content;
		$hash{id}                 = $feature;
	}
	if ( !( exists $hash{id} ) ) {
		$hash{id} = $feature;
	}

	$self->status_ok( $c, entity => \%hash );
}

=head2

Method used to return properties of evidence typed like similarity

=cut

sub getSimilarityEvidenceProperties :
  Path("/SearchDatabase/getSimilarityEvidenceProperties") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getSimilarityEvidenceProperties_GET {
	my ( $self, $c, $feature ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	
	open(
		my $FILEHANDLER,
		"<",
		dirname(__FILE__)
		  . "/../../../root/teste/search-database/similarityBasicResult.tt"
	);

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);
	
	$self->status_ok( $c, entity => $c->model('DBI')->similarityEvidenceProperties($feature, $content) );
}

=head2

Method used to return components used

=cut

sub getComponents : Path("/SearchDatabase/getComponents") : Args(0) :
  ActionClass('REST') { }

sub getComponents_GET {
	my ( $self, $c ) = @_;

	my $resultSet = $c->model('Basic::Component')->search(
		{},
		{
			order_by => {
				-asc => [qw/ component /]
			}
		}
	);

	my @list = ();

	while ( my $result = $resultSet->next ) {
		my %hash = ();
		$hash{id}        = $result->id;
		$hash{name}      = $result->name;
		$hash{component} = $result->component;
		if ( $result->filepath ne "" ) {
			$hash{filepath} = $result->filepath;
		}
		push @list, \%hash;
	}
	$self->status_ok( $c, entity => \@list );
}

=head2 reverseComplement

Method used to return the reverse complement of a sequence

=cut

sub reverseComplement {
	my ($sequence) = @_;
	my $reverseComplement = reverse($sequence);
	$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return $reverseComplement;
}

=head2 formatSequence

Method used to format sequence

=cut

sub formatSequence {
	my ( $sequence, $block ) = @_;
	$block = $block || 80 if ($block);
	$sequence =~ s/.{$block}/$&
/gs;
	chomp $sequence;
	return $sequence;
}

=head2 analysesCDS

Method used to make search of analyses of protein-coding genes

=cut

sub analysesCDS : Path("/SearchDatabase/analysesCDS") : CaptureArgs(31) :
  ActionClass('REST') { }

sub analysesCDS_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4249;
	foreach my $array ( $c->model('DBI')->analyses_CDS( \%hash ) ) {
		foreach my $value (@$array) {
			push @list, $value;
		}
	}
	$self->status_ok( $c, entity => \@list );
}

=head2

Method used to realize search of tRNA

=cut

sub trnaSearch : Path("/SearchDatabase/trnaSearch") : CaptureArgs(3) :
  ActionClass('REST') { }

sub trnaSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4249;

	@list = $c->model('DBI')->tRNA_search( \%hash );

	$self->status_ok( $c, entity => \@list );
}

=head2

Method used to get data of tandem repeats

=cut

sub tandemRepeatsSearch : Path("/SearchDatabase/tandemRepeatsSearch") :
  CaptureArgs(5) : ActionClass('REST') { }

sub tandemRepeatsSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4249;

	@list = $c->model('DBI')->trf_search( \%hash );

	$self->status_ok( $c, entity => \@list );
}

=head2

Method used to get data of non coding RNAs

=cut

sub ncRNASearch : Path("/SearchDatabase/ncRNASearch") : CaptureArgs(7) :
  ActionClass('REST') { }

sub ncRNASearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4249;

	@list = $c->model('DBI')->ncRNA_search( \%hash );

	$self->status_ok( $c, entity => \@list );
}

=head2

Method used to get data of transcriptional terminators

=cut

sub transcriptionalTerminatorSearch :
  Path("/SearchDatabase/transcriptionalTerminatorSearch") : CaptureArgs(6) :
  ActionClass('REST') { }

sub transcriptionalTerminatorSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4249;

	@list = $c->model('DBI')->transcriptional_terminator_search( \%hash );

	$self->status_ok( $c, entity => \@list );
}

=head2

Method used to get data of ribosomal binding sites

=cut

sub rbsSearch : Path("/SearchDatabase/rbsSearch") : CaptureArgs(4) :
  ActionClass('REST') { }

sub rbsSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4249;

	@list = $c->model('DBI')->rbs_search( \%hash );

	$self->status_ok( $c, entity => \@list );
}

=head2

Method used to get data of horizontal gene transfers

=cut

sub alienhunterSearch : Path("/SearchDatabase/alienhunterSearch") :
  CaptureArgs(6) : ActionClass('REST') { }

sub alienhunterSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4249;

	@list = $c->model('DBI')->alienhunter_search( \%hash );

	$self->status_ok( $c, entity => \@list );
}

=encoding utf8

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

