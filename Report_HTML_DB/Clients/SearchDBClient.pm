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

sub getPipeline {
	my ( $self ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/GetPipeline",
		\%{
			{
				"" => ""
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getRibosomalRNAs {
	my ( $self, $pipeline ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/GetRibosomalRNAs",
		\%{
			{
				"pipeline" => $pipeline
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getrRNASearch {
	my ( $self, $parameters ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/rRNA_search", $parameters,	"GET"
	);
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getFeatureID {
	my ( $self, $uniquename ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/GetFeatureID",
		\%{
			{
				uniquename => $uniquename
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getGene {
	my (
		$self,            $pipeline,      $geneID,
		$geneDescription, $noDescription, $individually,
		$featureId,       $pageSize,      $offset,
		$contig
	) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/Gene",
		\%{
			{
				"pipeline"        => $pipeline,
				"geneID"          => $geneID,
				"geneDesc" 		  => $geneDescription,
				"noDesc"		  => $noDescription,
				"individually"    => $individually,
				"featureId"       => $featureId,
				"pageSize"        => $pageSize,
				"offset"          => $offset,
				"contig"		  => $contig,
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getGeneBasics {
	my ( $self, $id, $pipeline ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/GetGeneBasics",
		\%{
			{
				id       => $id,
				pipeline => $pipeline,
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getSubsequence {
	my ( $self, $type, $contig, $sequenceName, $start, $end, $pipeline ) = @_;
	my $response = makeRequest(
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
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getncRNA_desc {
	my ( $self, $feature, $pipeline, $pageSize, $offset ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/ncRNA_desc",
		\%{
			{
				feature  => $feature,
				pipeline => $pipeline,
				pageSize => $pageSize,
				offset	 => $offset,
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getSubevidences {
	my ( $self, $feature, $pipeline ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/subEvidences",
		\%{
			{
				feature  => $feature,
				pipeline => $pipeline,
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getAnalysesCDS {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeRequest( $self->{rest_endpoint},
		"/SearchDatabase/analysesCDS", $parameters, "GET" );
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getTRNA {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeRequest( $self->{rest_endpoint},
		"/SearchDatabase/trnaSearch", $parameters, "GET" );
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getTandemRepeats {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/tandemRepeatsSearch",
		$parameters, "GET"
	);
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getncRNA {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeRequest( $self->{rest_endpoint},
		"/SearchDatabase/ncRNASearch", $parameters, "GET" );
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getTranscriptionalTerminator {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/transcriptionalTerminatorSearch",
		$parameters, "GET"
	);
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getRBSSearch {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeRequest( $self->{rest_endpoint},
		"/SearchDatabase/rbsSearch", $parameters, "GET" );
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getAlienHunter {
	my ( $self, $parameters ) = @_;

	#	my %hash = ();
	#	foreach my $key (keys %$parameters) {
	#		$hash{$key} = $parameters->{$key};
	#	}
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/alienhunterSearch",
		$parameters, "GET"
	);
	return Report_HTML_DB::Models::Services::PagedResponse->thaw($response);
}

sub getGeneByPosition {
	my ( $self, $start, $end, $pipeline ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/geneByPosition",
		\%{
			{
				start       => $start,
				end         => $end,
				pipeline_id => $pipeline,
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getTargetClass {
	my ( $self, $pipeline_id ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/targetClass",
		\%{
			{
				pipeline_id => $pipeline_id,
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getSimilarityEvidenceProperties {
	my ( $self, $feature_id ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/getSimilarityEvidenceProperties",
		\%{
			{
				feature => $feature_id
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getIdentifierAndDescriptionSimilarity {
	my ($self, $feature_id) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/getIdentifierAndDescriptionSimilarity",
		\%{
			{
				feature_id => $feature_id
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub getIntervalEvidenceProperties {
	my ( $self, $feature, $typeFeature, $pipeline ) = @_;
	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/getIntervalEvidenceProperties",
		\%{
			{
				feature     => $feature,
				typeFeature => $typeFeature,
				pipeline    => $pipeline
			}
		},
		"GET"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub postBlast {
	my ( $self, $parameters ) = @_;

	my $response = makeRequest(
		$self->{rest_endpoint},
		"/SearchDatabase/blast",
		$parameters, "POST"
	);
	return Report_HTML_DB::Models::Services::BaseResponse->thaw($response);
}

sub makeRequest {
	my ( $rest_endpoint, $action, $parameters, $method ) = @_;
	my $user_agent = LWP::UserAgent->new;
	my $url        = "";
	if ( $method eq "GET" ) {
		$url =
		  $rest_endpoint . $action . "?" . stringifyParameters($parameters);
		my $request = HTTP::Request->new( GET => $url );
		$request->header( 'content_type' => 'application/json' );
		my $response = $user_agent->request($request);
		return $response->content;
	}
	elsif ( $method eq "POST" ) {
		$url = $rest_endpoint;
		my $request = HTTP::Request->new( POST => $url );
		$request->content($parameters);
		$request->header( 'content_type' => 'application/json' );
		my $response = $user_agent->request($request);
		return $response->content;
	}

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
