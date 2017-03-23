package Report_HTML_DB::Clients::SearchDBClient;
use Moose;
use HTTP::Request;
use LWP::UserAgent;
use Report_HTML_DB::Models::Services::BaseResponse;
use Report_HTML_DB::Models::Services::PagedResponse;

=pod

This class have the objective to represent the layer of access between any application and services

=cut

has rest_endpoint => ( is => 'ro', isa => 'Str' );

sub getFeatureID {
	my ( $self, $uniquename ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/GetFeatureID",
		\%{
			{
				uniquename => $uniquename
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getGene {
	my ( $self, $pipeline, $geneID, $geneDescription, $noDescription,
		$individually, $featureId, $pageSize, $offset )
	  = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/Gene",
		\%{
			{
				"pipeline"        => $pipeline,
				"geneID"          => $geneID,
				"geneDescription" => $geneDescription,
				"noDescription"   => $noDescription,
				"individually"    => $individually,
				"featureId"       => $featureId,
				"pageSize"		  => $pageSize,
				"offset"		  => $offset,
			}
		}
	);
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getGeneBasics {
	my ( $self, $id, $pipeline ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/GetGeneBasics",
		\%{
			{
				id       => $id,
				pipeline => $pipeline,
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getSubsequence {
	my ( $self, $type, $contig, $sequenceName, $start, $end, $pipeline ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/GetSubsequence",
		\%{
			{
				type         => $type,
				contig       => $contig,
				sequenceName => $sequenceName,
				start        => $start,
				end          => $end,
				pipeline     => $pipeline,
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getncRNA_desc {
	my ( $self, $feature, $pipeline ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/ncRNA_desc",
		\%{
			{
				feature  => $feature,
				pipeline => $pipeline,
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getSubevidences {
	my ( $self, $feature, $pipeline ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/subEvidences",
		\%{
			{
				feature  => $feature,
				pipeline => $pipeline,
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getAnalysesCDS {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeGetRequest( $self->{rest_endpoint},
		"/SearchDatabase/analysesCDS", $parameters );
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getTRNA {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeGetRequest( $self->{rest_endpoint},
		"/SearchDatabase/trnaSearch", $parameters );
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getTandemRepeats {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeGetRequest( $self->{rest_endpoint},
		"/SearchDatabase/tandemRepeatsSearch", $parameters );
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getncRNA {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeGetRequest( $self->{rest_endpoint},
		"/SearchDatabase/ncRNASearch", $parameters );
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getTranscriptionalTerminator {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeGetRequest( $self->{rest_endpoint},
		"/SearchDatabase/transcriptionalTerminatorSearch", $parameters );
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getRBSSearch {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeGetRequest( $self->{rest_endpoint},
		"/SearchDatabase/rbsSearch", $parameters );
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getAlienHunter {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeGetRequest( $self->{rest_endpoint},
		"/SearchDatabase/alienhunterSearch", $parameters );
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getGeneByPosition {
	my ( $self, $start, $end, $pipeline ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/geneByPosition",
		\%{
			{
				start    => $start,
				end      => $end,
				pipeline_id => $pipeline,
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getTargetClass {
	my ( $self, $pipeline_id ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/targetClass",
		\%{
			{
				pipeline_id => $pipeline_id,
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getSimilarityEvidenceProperties {
	my ( $self, $feature_id ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/getSimilarityEvidenceProperties",
		\%{
			{
				feature => $feature_id
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getIntervalEvidenceProperties {
	my ( $self, $feature, $typeFeature, $pipeline ) = @_;
	my $response = makeGetRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/getIntervalEvidenceProperties",
		\%{
			{
				feature => $feature,
				typeFeature => $typeFeature,
				pipeline => $pipeline
			}
		}
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub makeGetRequest {
	my ( $rest_endpoint, $action, $parameters ) = @_;
	my $user_agent = LWP::UserAgent->new;
	my $request =
	  HTTP::Request->new( 'GET' => $rest_endpoint
		  . $action . "?"
		  . stringifyParameters($parameters) );
	$request->header( 'content_type' => 'application/json' );
	my $response = $user_agent->request($request);
	return $response->content;
}

sub stringifyParameters {
	my ($parameters) = @_;
	my $result = "";
	foreach my $key ( keys %{$parameters} ) {
		$result .= "$key=" . $parameters->{$key} . "&";
	}
	chop($result);
	return $result;
}

1;
