package TESTE2::Controller::Site;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

TESTE2::Controller::Site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2 getHTMLContent
Method used to get HTML content from file by filepath
=cut

sub getHTMLContent : Path("/GetHTMLContent") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getHTMLContent_GET {
	my ( $self, $c, $filepath ) = @_;
	if ( !$filepath and defined $c->request->param("filepath") ) {
		$filepath = $c->request->param("filepath");
	}
	use File::Basename;
	open( my $FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . $filepath );

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);
	standardStatusOk( $self, $c, $content );
}

=head2
Standard return of status ok
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
