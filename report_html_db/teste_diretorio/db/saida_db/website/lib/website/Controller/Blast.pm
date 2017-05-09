package website::Controller::Blast;
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

sub search : Path("/Blast/search") : CaptureArgs(7) : ActionClass('REST') { }

sub search_POST {
	my (
		$self,                $c,                  $blast,
		$database,            $fastaSequence,      $from,
		$to,                  $filter,             $expect,
		$matrix,              $ungappedAlignment,  $geneticCode,
		$databaseGeneticCode, $frameShiftPenality, $otherAdvanced,
		$graphicalOverview,   $alignmentView,      $descriptions,
		$alignments,          $colorSchema,        $fastaFile
	) = @_;
	if ( !$blast and defined $c->request->param("PROGRAM") ) {
		$blast = $c->request->param("PROGRAM");
	}
	if ( !$database and defined $c->request->param("DATALIB") ) {
		$database = $c->request->param("DATALIB");
	}
	if ( !$fastaSequence and defined $c->request->param("SEQUENCE") ) {
		$fastaSequence = $c->request->param("SEQUENCE");
	}
	if ( !$fastaFile and defined $c->request->param("SEQFILE") ) {
		$fastaFile = $c->request->param("SEQFILE");
	}
	if ( !$from and defined $c->request->param("QUERY_FROM") ) {
		$from = $c->request->param("QUERY_FROM");
	}
	if ( !$to and defined $c->request->param("QUERY_TO") ) {
		$to = $c->request->param("QUERY_TO");
	}
	if ( !$filter and defined $c->request->param("FILTER") ) {
		$filter = $c->request->param("FILTER");
	}
	if ( !$expect and defined $c->request->param("EXPECT") ) {
		$expect = $c->request->param("EXPECT");
	}
	if ( !$matrix and defined $c->request->param("MAT_PARAM") ) {
		$matrix = $c->request->param("MAT_PARAM");
	}
	if ( !$ungappedAlignment
		and defined $c->request->param("UNGAPPED_ALIGNMENT") )
	{
		$ungappedAlignment = $c->request->param("UNGAPPED_ALIGNMENT");
	}
	if ( !$geneticCode and defined $c->request->param("GENETIC_CODE") ) {
		$geneticCode = $c->request->param("GENETIC_CODE");
	}
	if ( !$databaseGeneticCode
		and defined $c->request->param("DB_GENETIC_CODE") )
	{
		$databaseGeneticCode = $c->request->param("DB_GENETIC_CODE");
	}
	if ( !$frameShiftPenality
		and defined $c->request->param("OOF_ALIGN") )
	{
		$frameShiftPenality = $c->request->param("OOF_ALIGN");
	}
	if ( !$otherAdvanced and defined $c->request->param("OTHER_ADVANCED") ) {
		$otherAdvanced = $c->request->param("OTHER_ADVANCED");
	}
	if ( !$graphicalOverview
		and defined $c->request->param("OVERVIEW") )
	{
		$graphicalOverview = $c->request->param("OVERVIEW");
	}
	if ( !$alignmentView and defined $c->request->param("ALIGNMENT_VIEW") ) {
		$alignmentView = $c->request->param("ALIGNMENT_VIEW");
	}
	if ( !$descriptions and defined $c->request->param("DESCRIPTIONS") ) {
		$descriptions = $c->request->param("DESCRIPTIONS");
	}
	if ( !$alignments and defined $c->request->param("ALIGNMENTS") ) {
		$alignments = $c->request->param("ALIGNMENTS");
	}
	if ( !$colorSchema and defined $c->request->param("COLOR_SCHEMA") ) {
		$colorSchema = $c->request->param("COLOR_SCHEMA");
	}

	my %hash = ();

	foreach my $key ( keys %{ $c->request->params } ) {
		if ( $key && $key ne "0" ) {
			$hash{$key} = $c->request->params->{$key};
			$hash{$key} =~ s/['"&.|]//g;
		}
	}
	
	unless ( exists $hash{SEQUENCE} ) {
		$hash{SEQUENCE} = $hash{SEQFILE};
		delete $hash{SEQFILE};
	}
	my $content = "";
	my @fuckingSequence = split(/\s+/, $hash{SEQUENCE});
	 $hash{SEQUENCE} = join('\n', @fuckingSequence);
	print "\n".$hash{SEQUENCE}."\n";
	if($hash{SEQUENCE} !~ />/) {
		$hash{SEQUENCE} = ">Sequence\n" . $hash{SEQUENCE};
	}
	my $blastClient =
	  Report_HTML_DB::Clients::BlastClient->new(
		rest_endpoint => $c->config->{rest_endpoint} );
	my $baseResponse = $blastClient->search( \%hash );
	%hash = ();
	$baseResponse = $blastClient->fancy( $baseResponse->{response} );
	my $returnedHash = $baseResponse->{response};
	use MIME::Base64;
	foreach my $key (keys %$returnedHash) {
		if($key =~ /.html/ ) {
			$hash{$key} = MIME::Base64::decode_base64($returnedHash->{$key});
		} else {
			$hash{$key} = $returnedHash->{$key};
		}
	}
	
	standardStatusOk($self, $c, \%hash);
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

