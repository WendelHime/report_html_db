package website::Controller::Site;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

website::Controller::Site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

sub gene : Path("/SearchDatabase/GetGene") : CaptureArgs(6) :
  ActionClass('REST') { }

sub gene_GET {
	my ( $self, $c, $pipeline, $geneID, $geneDescription, $noDescription,
		$individually, $featureId )
	  = @_;
	if ( !$pipeline and defined $c->request->param("pipeline") ) {
		$pipeline = $c->request->param("pipeline");
	}
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
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getGene(
			$pipeline,      $geneID,       $geneDescription,
			$noDescription, $individually, $featureId
		)
	);
}

sub gene_basics : Path("/SearchDatabase/GetGeneBasics") : CaptureArgs(2) :
  ActionClass('REST') { }

sub gene_basics_GET {
	my ( $self, $c, $id, $pipeline ) = @_;
	if ( !$id and defined $c->request->param("id") ) {
		$id = $c->request->param("id");
	}
	if ( !$pipeline and defined $c->request->param("pipeline") ) {
		$pipeline = $c->request->param("pipeline");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getGeneBasics(
			$id, $pipeline
		)
	);
}

sub subsequence : Path("/SearchDatabase/GetSubsequence") : CaptureArgs(6) :
  ActionClass('REST') { }
  
sub subsequence_GET {
	my ( $self, $c, $type, $contig, $sequenceName, $start, $end, $pipeline ) = @_;
	if ( !$contig and defined $c->request->param("contig") ) {
		$contig = $c->request->param("contig");
	}
	if ( !$type and defined $c->request->param("type") ) {
		$type = $c->request->param("type");
	}
	if ( !$pipeline and defined $c->request->param("pipeline") ) {
		$pipeline = $c->request->param("pipeline");
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
			$type, $contig, $sequenceName, $start, $end, $pipeline
		)
	);
}

sub ncRNA_desc : Path("/SearchDatabase/ncRNA_desc") : CaptureArgs(2) :
  ActionClass('REST') { }
  
sub ncRNA_desc_GET {
	my ( $self, $c, $feature, $pipeline ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	if ( !$pipeline and defined $c->request->param("pipeline") ) {
		$pipeline = $c->request->param("pipeline");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getncRNA_desc(
			$feature, $pipeline
		)
	); 
}

sub subEvidences : Path("/SearchDatabase/SubEvidences") : CaptureArgs(2) :
  ActionClass('REST') { }

sub subEvidences_GET {
	my ( $self, $c, $feature, $pipeline ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}
	if ( !$pipeline and defined $c->request->param("pipeline") ) {
		$pipeline = $c->request->param("pipeline");
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getSubevidences(
			$feature, $pipeline
		)
	);
}

sub analysesCDS : Path("/SearchDatabase/analysesCDS") : CaptureArgs(32) :
  ActionClass('REST') { }

sub analysesCDS_GET {
	my ( $self, $c) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getAnalysesCDS(
			\%hash
		)
	);
}

sub trnaSearch : Path("/SearchDatabase/trnaSearch") : CaptureArgs(5) :
  ActionClass('REST') { }

sub trnaSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getTRNA(
			\%hash
		)
	);
}

sub tandemRepeatsSearch : Path("/SearchDatabase/tandemRepeatsSearch") :
  CaptureArgs(6) : ActionClass('REST') { }

sub tandemRepeatsSearch_GET {
	my ( $self, $c ) = @_;

	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getTandemRepeats(
			\%hash
		)
	);
}

sub ncRNASearch : Path("/SearchDatabase/ncRNASearch") : CaptureArgs(8) :
  ActionClass('REST') { }

sub ncRNASearch_GET {
	my ( $self, $c ) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getncRNA(
			\%hash
		)
	);
}

sub transcriptionalTerminatorSearch :
  Path("/SearchDatabase/transcriptionalTerminatorSearch") : CaptureArgs(7) :
  ActionClass('REST') { }

sub transcriptionalTerminatorSearch_GET {
	my ( $self, $c ) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getTranscriptionalTerminator(
			\%hash
		)
	);
}

sub rbsSearch : Path("/SearchDatabase/rbsSearch") : CaptureArgs(5) :
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
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getRBSSearch(
			\%hash
		)
	);
}

sub alienhunterSearch : Path("/SearchDatabase/alienhunterSearch") :
  CaptureArgs(7) : ActionClass('REST') { }

sub alienhunterSearch_GET {
	my ( $self, $c ) = @_;
	my %hash = ();
	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
		}
	}
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getAlienHunter(
			\%hash
		)
	);
}

sub geneByPosition : Path("/SearchDatabase/geneByPosition") :
  CaptureArgs(3) : ActionClass('REST') { }

sub geneByPosition_GET {
	my ( $self, $c, $start, $end, $pipeline ) = @_;
	if ( !$start and defined $c->request->param("start") ) {
		$start = $c->request->param("start");
	}
	if ( !$end and defined $c->request->param("end") ) {
		$end = $c->request->param("end");
	}
	if ( !$pipeline and defined $c->request->param("pipeline") ) {
		$pipeline = $c->request->param("pipeline");
	}
	my %hash = ();
	$hash{pipeline} = $pipeline;
	$hash{start}    = $start;
	$hash{end}      = $end;
	my $searchDBClient =
	  Report_HTML_DB::Clients::SearchDBClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	standardStatusOk(
		$self, $c,
		$searchDBClient->getGeneByPosition(
			\%hash
		)
	);
}



=head2
Standard return of status ok
=cut

sub standardStatusOk {
	my ( $self, $c, $response ) = @_;
	if ( $response eq "" ) {
		$response = "null";
	}
	if ( $response =~ /ARRAY/g ) {
		$response = "null" if ( scalar @$response <= 1 );
	}
	my $baseResponse = $c->model('BaseResponse')->new(
		status_code => 200,
		message     => "Ok",
		elapsed_ms  => $c->stats->elapsed,
		response    => $response
	);
	$self->status_ok( $c, entity => $baseResponse->pack(), );
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
