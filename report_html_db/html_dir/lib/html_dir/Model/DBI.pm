package html_dir::Model::DBI;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

TESTE2::Controller::SearchDatabase - Catalyst Controller

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

	my @list = ();
	my %hash = ();
	$hash{pipeline}        = 4528;
	$hash{featureId}       = $featureId;
	$hash{geneID}          = $geneID;
	$hash{geneDescription} = $geneDescription;
	$hash{noDescription}   = $noDescription;
	$hash{individually}    = $individually;

	my @resultList = @{ $c->model('DBI')->searchGene( \%hash ) };

	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		push @list,
		  {
			"feature_id" => $resultList[$i]->getFeatureID,
			"name"       => $resultList[$i]->getName,
			"uniquename" => $resultList[$i]->getUniquename,
			"value"      => $resultList[$i]->getValue,
			"fstart"     => $resultList[$i]->getStart,
			"fend"       => $resultList[$i]->getEnd
		  };
	}

	standardStatusOk( $self, $c, \@list );
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
		if ( !( $line =~ /^>\w+\n\
g ) ) {
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

	push @list, \%hash;
	standardStatusOk( $self, $c, @list );
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
	my %hash = ();
	$hash{pipeline}   = 4528;
	$hash{feature_id} = $id;

	my @resultList = @{ $c->model('DBI')->geneBasics( \%hash ) };
	my @list       = ();
	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		push @list,
		  {
			"feature_id" => $resultList[$i]->getFeatureID,
			"name"       => $resultList[$i]->getName,
			"uniquename" => $resultList[$i]->getUniquename,
			"value"      => $resultList[$i]->getValue,
			"fstart"     => $resultList[$i]->getStart,
			"fend"       => $resultList[$i]->getEnd
		  };
	}

	standardStatusOk( $self, $c, \@list );
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

	my $content = "";

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
			if ( !( $line =~ /^>\w+\n\
g ) ) {
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
		open(
			my $FILEHANDLER,
			"<",
			dirname(__FILE__) . "/../../../root/orfs_aa/" . $contig . ".fasta"
		);

		for my $line (<$FILEHANDLER>) {
			if ( !( $line =~ /^>\w+\n\
g ) ) {
				$content .= $line;
			}
		}
		close($FILEHANDLER);
		$content =~ s/\n/<br \/>/g;
	}
	standardStatusOk( $self, $c, { "sequence" => $content } );
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
	my $pipeline = 4528;
	standardStatusOk( $self, $c,
		$c->model('DBI')->ncRNA_description( $feature, $pipeline ) );

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
	my @list       = ();
	my @resultList = @{ $c->model('DBI')->subevidences($feature) };
	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		push @list,
		  {
			"id"                  => $resultList[$i]->getID,
			"type"                => $resultList[$i]->getType,
			"number"              => $resultList[$i]->getNumber,
			"start"               => $resultList[$i]->getStart,
			"end"                 => $resultList[$i]->getEnd,
			"strand"              => $resultList[$i]->getStrand,
			"is_obsolete"         => $resultList[$i]->getIsObsolete,
			"program"             => $resultList[$i]->getProgram,
			"program_description" => $resultList[$i]->getProgramDescription,
		  };
	}
	standardStatusOk( $self, $c, \@list );
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

	my %hash = ();
	$hash{properties} = $c->model('DBI')->intervalEvidenceProperties($feature);
	if ( exists $hash{intron} ) {
		if ( $hash{intron} eq 'yes' ) {
			$hash{coordinatesGene} = $hash{intron_start} - $hash{intron_end};
			$hash{coordinatesGenome} =
			  $hash{intron_start_seq} - $hash{intron_end_seq};
		}
	}
	if ( $typeFeature eq 'annotation_pathways' ) {
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
		$hash{id}       = $feature;
	}
	elsif ( $typeFeature eq 'annotation_orthology' ) {
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
		$hash{orthologous_groups} = \@orthologous_groups;
		$hash{id}                 = $feature;
	}
	if ( !( exists $hash{id} ) ) {
		$hash{id} = $feature;
	}

	standardStatusOk( $self, $c, \%hash );
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

	standardStatusOk( $self, $c,
		$c->model('DBI')->similarityEvidenceProperties($feature) );
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

	standardStatusOk( $self, $c, \@list );
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
	$hash{pipeline} = 4528;
	foreach my $array ( $c->model('DBI')->analyses_CDS( \%hash ) ) {
		foreach my $value (@$array) {
			push @list, $value;
		}
	}
	standardStatusOk( $self, $c, \@list );
}

=head2

Method used to realize search of tRNA

=cut

sub trnaSearch : Path("/SearchDatabase/trnaSearch") : CaptureArgs(3) :
  ActionClass('REST') { }

sub trnaSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4528;
	my @list       = ();
	my @resultList = @{ $c->model('DBI')->tRNA_search( \%hash ) };
	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		push @list,
		  {
			"id"         => $resultList[$i]->getID,
			"sequence"   => $resultList[$i]->getSequence,
			"amino_acid" => $resultList[$i]->getAminoAcid,
			"codon"      => $resultList[$i]->getCodon,
		  };
	}

	standardStatusOk( $self, $c, \@list );
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
	$hash{pipeline} = 4528;

	my @resultList = @{ $c->model('DBI')->trf_search( \%hash ) };
	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		push @list,
		  {
			"contig"      => $resultList[$i]->getContig,
			"start"       => $resultList[$i]->getStart,
			"end"         => $resultList[$i]->getEnd,
			"length"      => $resultList[$i]->getLength,
			"copy_number" => $resultList[$i]->getCopyNumber,
			"sequence"    => $resultList[$i]->getSequence,
		  };
	}

	standardStatusOk( $self, $c, \@list );
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
	$hash{pipeline} = 4528;

	my @resultList = @{ $c->model('DBI')->ncRNA_search( \%hash ) };

	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		push @list,
		  {
			id           => $resultList[$i]->getID,
			contig       => $resultList[$i]->getContig,
			start        => $resultList[$i]->getStart,
			end          => $resultList[$i]->getEnd,
			description  => $resultList[$i]->getDescription,
			target_ID    => $resultList[$i]->getTargetID,
			evalue       => $resultList[$i]->getEvalue,
			target_name  => $resultList[$i]->getTargetName,
			target_class => $resultList[$i]->getTargetClass,
			target_type  => $resultList[$i]->getTargetType
		  };
	}

	standardStatusOk( $self, $c, \@list );
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
	$hash{pipeline} = 4528;

	my @resultList =
	  @{ $c->model('DBI')->transcriptional_terminator_search( \%hash ) };

	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		my %hash = (
			contig => $resultList[$i]->getContig,
			start  => $resultList[$i]->getStart,
			end    => $resultList[$i]->getEnd,
		);

		$hash{confidence} = $resultList[$i]->getConfidence
		  if $resultList[$i]->getConfidence;
		$hash{hairpin_score} = $resultList[$i]->getHairpinScore
		  if $resultList[$i]->getHairpinScore;
		$hash{tail_score} = $resultList[$i]->getTailScore
		  if $resultList[$i]->getTailScore;
		push @list, \%hash;
	}

	standardStatusOk( $self, $c, \@list );
}

=head2

Method used to get data of ribosomal binding sites

=cut

sub rbsSearch : Path("/SearchDatabase/rbsSearch") : CaptureArgs(4) :
  ActionClass('REST') {
}

sub rbsSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	my @list = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = 4528;

	my @resultList = @{ $c->model('DBI')->rbs_search( \%hash ) };

	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		my %hash = (
			contig => $resultList[$i]->getContig,
			start  => $resultList[$i]->getStart,
			end    => $resultList[$i]->getEnd,
		);

		$hash{site_pattern} = $resultList[$i]->getSitePattern
		  if $resultList[$i]->getSitePattern;
		$hash{old_start} = $resultList[$i]->getOldStart
		  if $resultList[$i]->getOldStart;
		$hash{position_shift} = $resultList[$i]->getPositionShift
		  if $resultList[$i]->getPositionShift;
		$hash{new_start} = $resultList[$i]->getNewStart
		  if $resultList[$i]->getNewStart;

		push @list, \%hash;
	}

	standardStatusOk( $self, $c, \@list );
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
	$hash{pipeline} = 4528;

	my @resultList = @{ $c->model('DBI')->alienhunter_search( \%hash ) };

	for ( my $i = 0 ; $i < scalar @resultList ; $i++ ) {
		my %hash = (
			id     => $resultList[$i]->getID,
			contig => $resultList[$i]->getContig,
			start  => $resultList[$i]->getStart,
			end    => $resultList[$i]->getEnd,
		);

		$hash{length} = $resultList[$i]->getLength
		  if $resultList[$i]->getLength;
		$hash{score} = $resultList[$i]->getScore
		  if $resultList[$i]->getScore;
		$hash{threshold} = $resultList[$i]->getThreshold
		  if $resultList[$i]->getThreshold;

		push @list, \%hash;
	}

	standardStatusOk( $self, $c, \@list );
}

=head2

Method used to get feature by position

=cut

sub geneByPosition : Path("/SearchDatabase/geneByPosition") :
  CaptureArgs(2) : ActionClass('REST') { }

sub geneByPosition_GET {
	my ( $self, $c, $start, $end ) = @_;

	my %hash = ();
	$hash{pipeline} = 4528;
	$hash{start}    = $start;
	$hash{end}      = $end;
	my @ids = @{ $c->model('DBI')->geneByPosition( \%hash ) };
	my $featureId = join( " ", @ids );
	%hash            = ();
	$hash{pipeline}  = 4528;
	$hash{featureId} = $featureId;

	standardStatusOk( $self, $c, $c->model('DBI')->searchGene( \%hash ) );
}

=head2

Method used to make a default return of every ok request using BaseResponse model

=cut

sub standardStatusOk {
	my ( $self, $c, $response ) = @_;
	my $baseResponse = $c->model('BaseResponse')->new(
		status_code => 200,
		message     => "Ok",
		elapsed_ms  => $c->stats->elapsed,
		response    => $response
	);
	$self->status_ok(
		$c,
		entity => {
			"status"    => $baseResponse->getStatusCode,
			"message"   => $baseResponse->getMessage,
			"elapsedMs" => $baseResponse->getElapsedMs,
			"response"  => $baseResponse->getResponse
		}
	);
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
