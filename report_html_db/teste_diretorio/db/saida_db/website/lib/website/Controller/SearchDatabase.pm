package website::Controller::SearchDatabase;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

website::Controller::SearchDatabase - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

sub gene : Path("/SearchDatabase/GetGene") : CaptureArgs(7) :
  ActionClass('REST') { }

sub gene_GET {
	my ( 
		$self,            $c,             $pipeline,     $geneID,
		$geneDescription, $noDescription, $individually, $featureId,
		$pageSize,        $offset )
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
	if ( !$pageSize and defined $c->request->param("pageSize") ) {
		$pageSize = $c->request->param("pageSize");
	}
	if ( !$offset and defined $c->request->param("offset") ) {
		$offset = $c->request->param("offset");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	my $pagedResponse = $searchDBClient->getGene( $c->config->{pipeline_id},
		$geneID, $geneDescription,
		$noDescription, $individually, $featureId, $pageSize, $offset );
	standardStatusOk(
		$self, $c, $pagedResponse->{response}, $pagedResponse->{"total"},
		$pageSize, $offset

	);
}

sub gene_basics : Path("/SearchDatabase/GetGeneBasics") : CaptureArgs(1) :
  ActionClass('REST') { }

sub gene_basics_GET {
	my ( $self, $c, $id ) = @_;
	if ( !$id and defined $c->request->param("id") ) {
		$id = $c->request->param("id");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getGeneBasics(
			$id, $c->config->{pipeline_id}
		)->{response}
	);
}

sub subsequence : Path("/SearchDatabase/GetSubsequence") : CaptureArgs(5) :
  ActionClass('REST') { }
  
sub subsequence_GET {
	my ( $self, $c, $type, $contig, $sequenceName, $start, $end ) = @_;
	if ( !$contig and defined $c->request->param("contig") ) {
		$contig = $c->request->param("contig");
	}
	if ( !$type and defined $c->request->param("type") ) {
		$type = $c->request->param("type");
	}
	if ( !$sequenceName and defined $c->request->param("sequenceName") ) {
		$sequenceName = $c->request->param("sequenceName");
	}
	if ( !$start and defined $c->request->param("start") ) {
		$start = $c->request->param("start");
	}
	if ( !$end and defined $c->request->param("end") ) {
		$end = $c->request->param("end");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getSubsequence(
			$type, $contig, $sequenceName, $start, $end, $c->config->{pipeline_id}
		)->{response}
	);
}

sub ncRNA_desc : Path("/SearchDatabase/ncRNA_desc") : CaptureArgs(1) :
  ActionClass('REST') { }
  
sub ncRNA_desc_GET {
	my ( $self, $c, $feature ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getncRNA_desc(
			$feature, $c->config->{pipeline_id}
		)->{response}
	); 
}

sub subEvidences : Path("/SearchDatabase/SubEvidences") : CaptureArgs(1) :
  ActionClass('REST') { }

sub subEvidences_GET {
	my ( $self, $c, $feature) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getSubevidences(
			$feature, $c->config->{pipeline_id}
		)->{response}
	);
}

sub analysesCDS : Path("/SearchDatabase/analysesCDS") : CaptureArgs(31) :
  ActionClass('REST') { }

sub analysesCDS_GET {
	my ( $self, $c) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = $c->config->{pipeline_id};
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	my $pagedResponse = $searchDBClient->getAnalysesCDS( \%hash );
	standardStatusOk(
		$self, $c,
		$pagedResponse->{response},
		$pagedResponse->{total},
		$hash{pageSize}, $hash{offset}
	);
}

sub trnaSearch : Path("/SearchDatabase/trnaSearch") : CaptureArgs(4) :
  ActionClass('REST') { }

sub trnaSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = $c->config->{pipeline_id};
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getTRNA(
			\%hash
		)->{response}
	);
}

sub tandemRepeatsSearch : Path("/SearchDatabase/tandemRepeatsSearch") :
  CaptureArgs(5) : ActionClass('REST') { }

sub tandemRepeatsSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = $c->config->{pipeline_id};
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getTandemRepeats(
			\%hash
		)->{response}
	);
}

sub ncRNASearch : Path("/SearchDatabase/ncRNASearch") : CaptureArgs(7) :
  ActionClass('REST') { }

sub ncRNASearch_GET {
	my ( $self, $c ) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = $c->config->{pipeline_id};
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getncRNA(
			\%hash
		)->{response}
	);
}

sub transcriptionalTerminatorSearch :
  Path("/SearchDatabase/transcriptionalTerminatorSearch") : CaptureArgs(6) :
  ActionClass('REST') { }

sub transcriptionalTerminatorSearch_GET {
	my ( $self, $c ) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = $c->config->{pipeline_id};
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getTranscriptionalTerminator(
			\%hash
		)->{response}
	);
}

sub rbsSearch : Path("/SearchDatabase/rbsSearch") : CaptureArgs(4) :
  ActionClass('REST') {
}

sub rbsSearch_GET {
	my ( $self, $c ) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = $c->config->{pipeline_id};
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getRBSSearch(
			\%hash
		)->{response}
	);
}

sub alienhunterSearch : Path("/SearchDatabase/alienhunterSearch") :
  CaptureArgs(6) : ActionClass('REST') { }

sub alienhunterSearch_GET {
	my ( $self, $c ) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	$hash{pipeline} = $c->config->{pipeline_id};
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getAlienHunter(
			\%hash
		)->{response}
	);
}

sub geneByPosition : Path("/SearchDatabase/geneByPosition") :
  CaptureArgs(3) : ActionClass('REST') { }

sub geneByPosition_GET {
	my ( $self, $c, $start, $end ) = @_;
	if ( !$start and defined $c->request->param("start") ) {
		$start = $c->request->param("start");
	}
	if ( !$end and defined $c->request->param("end") ) {
		$end = $c->request->param("end");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getGeneByPosition(
			$start, $end, $c->config->{pipeline_id}
		)->{response}
	);
}

sub getSimilarityEvidenceProperties :
  Path("/SearchDatabase/getSimilarityEvidenceProperties") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getSimilarityEvidenceProperties_GET {
	my ( $self, $c, $feature ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk( $self, $c,
		$searchDBClient->getSimilarityEvidenceProperties($feature)->{response} );
}

sub getIntervalEvidenceProperties :
  Path("/SearchDatabase/getIntervalEvidenceProperties") : CaptureArgs(3) :
  ActionClass('REST') { }

sub getIntervalEvidenceProperties_GET {
	my ( $self, $c, $feature, $typeFeature, $pipeline ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	if ( !$typeFeature and defined $c->request->param("typeFeature") ) {
		$typeFeature = $c->request->param("typeFeature");
	}
	if ( !$pipeline and defined $c->request->param("pipeline") ) {
		$pipeline = $c->request->param("pipeline");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk( $self, $c,
		$searchDBClient->getIntervalEvidenceProperties($feature, $typeFeature, $pipeline)->{response} );
}

=head2
Standard return of status ok
=cut

sub standardStatusOk {
	my ( $self, $c, $response, $total, $pageSize, $offset ) = @_;
	if (   ( defined $total || $total )
		&& ( defined $pageSize || $pageSize )
		&& ( defined $offset   || $offset ) )
	{
		my $pagedResponse = $c->model('PagedResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => $c->stats->elapsed,
			response    => $response,
			total       => $total,
			pageSize    => $pageSize,
			offset      => $offset,
		);
		$self->status_ok( $c, entity => $pagedResponse->pack(), );
	}
	else {
		my $baseResponse = $c->model('BaseResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => $c->stats->elapsed,
			response    => $response
		);
		$self->status_ok( $c, entity => $baseResponse->pack(), );
	}
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

