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
		$request->header( 'content_type' => 'application/x-www-form-urlencoded', 'accept' => 'application/json' );
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
