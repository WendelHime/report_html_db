package services::Controller::Blast;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

services::Controller::Blast - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2

Method used to get feature id
$program				=>	scalar with the name of the program
$database				=>	scalar with the database
$fastaSequence			=>	scalar with the sequence
$from					=>	scalar from position sequence
$to						=>	scalar to position sequence
$filter					=>	referenced list with filters
$expect					=>	scalar with the expected evalue
$matrix					=>	scalar with matrix
$ungappedAlignment		=>	scalar with off or on for ungapped alignments
$geneticCode			=>	scalar with the genetic code
$databaseGeneticCode	=>	scalar with the database genetic code
$frameShiftPenality		=>	scalar with the frame shift penality option
$otherAdvanced			=>	scalar with other advanced options
$graphicalOverview		=>	scalar with off or on for graphical overview
$alignmentView			=>	scalar with the alignment view
$descriptions			=>	scalar with the quantity of descriptions
$alignments				=>	scalar with the quantity of alignments
$colorSchema			=>	scalar with the color schema

=cut

sub search : Path("/Blast/search") : CaptureArgs(18) : ActionClass('REST') { }

sub search_GET {
	my (
		$self,                $c,                  $blast,
		$database,            $fastaSequence,      $from,
		$to,                  $filter,             $expect,
		$matrix,              $ungappedAlignment,  $geneticCode,
		$databaseGeneticCode, $frameShiftPenality, $otherAdvanced,
		$graphicalOverview,   $alignmentView,      $descriptions,
		$alignments,          $colorSchema
	) = @_;

	if ( !$blast and defined $c->request->param("program") ) {
		$blast = $c->request->param("program");
	}
	if ( !$database and defined $c->request->param("database") ) {
		$database = $c->request->param("database");
	}
	if ( !$fastaSequence and defined $c->request->param("fastaSequence") ) {
		$fastaSequence = $c->request->param("fastaSequence");
	}
	if ( !$from and defined $c->request->param("from") ) {
		$from = $c->request->param("from");
	}
	if ( !$to and defined $c->request->param("to") ) {
		$to = $c->request->param("to");
	}
	if ( !$expect and defined $c->request->param("expect") ) {
		$expect = $c->request->param("expect");
	}
	if ( !$matrix and defined $c->request->param("matrix") ) {
		$matrix = $c->request->param("matrix");
	}
	if ( !$ungappedAlignment
		and defined $c->request->param("ungappedAlignment") )
	{
		$ungappedAlignment = $c->request->param("ungappedAlignment");
	}
	if ( !$geneticCode and defined $c->request->param("geneticCode") ) {
		$geneticCode = $c->request->param("geneticCode");
	}
	if ( !$databaseGeneticCode
		and defined $c->request->param("databaseGeneticCode") )
	{
		$databaseGeneticCode = $c->request->param("databaseGeneticCode");
	}
	if ( !$frameShiftPenality
		and defined $c->request->param("frameShiftPenality") )
	{
		$frameShiftPenality = $c->request->param("frameShiftPenality");
	}
	if ( !$otherAdvanced and defined $c->request->param("otherAdvanced") ) {
		$otherAdvanced = $c->request->param("otherAdvanced");
	}
	if ( !$graphicalOverview
		and defined $c->request->param("graphicalOverview") )
	{
		$graphicalOverview = $c->request->param("graphicalOverview");
	}
	if ( !$alignmentView and defined $c->request->param("alignmentView") ) {
		$alignmentView = $c->request->param("alignmentView");
	}
	if ( !$descriptions and defined $c->request->param("descriptions") ) {
		$descriptions = $c->request->param("descriptions");
	}
	if ( !$alignments and defined $c->request->param("alignments") ) {
		$alignments = $c->request->param("alignments");
	}
	if ( !$colorSchema and defined $c->request->param("colorSchema") ) {
		$colorSchema = $c->request->param("colorSchema");
	}

	return standardStatusOk(
		$self, $c,
		$c->model('BlastRepository')->executeBlastSearch(
			$blast,       $database,            $fastaSequence,
			$from,          $to,                  $filter,
			$expect,        $matrix,              $ungappedAlignment,
			$geneticCode,   $databaseGeneticCode, $frameShiftPenality,
			$otherAdvanced, $graphicalOverview,   $alignmentView,
			$descriptions,  $alignments,          $colorSchema
		)
	);
}

=head2

Method used to make a default return of every ok request using BaseResponse model

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
