package Report_HTML_DB::Repositories::BlastRepository;
use Moose;

=pod

This repository is responsible to execute functions related with the BLAST tool

=cut

=pod
executeBlastSearch is used to execute search of the blast tool, 
using external parameters, mount the command line, and returns the reference of String
=cut

sub executeBlastSearch {
	my (
		$self, $blast, $database, $fastaSequence,
		$from, $to, $filter,
		$expect,        $matrix,              $ungappedAlignment,
		$geneticCode,   $databaseGeneticCode, $frameShiftPenalty,
		$otherAdvanced, $graphicalOverview,   $alignmentView,
		$descriptions,  $alignments,          $colorSchema
	) = @_;
	
	###
	#Ver como funciona frameShiftPenalty
	#Ver como funcionam os filtros usando os parametros -dust e -seg
	#Pedir para remover opções avançadas
	#Como aplicar color schema
	###
	
	my $command =
	  "echo -e \"$fastaSequence\" | $blast -db $database -show_gis ";
	$command .= " -query_loc \"" . $from . "-" . $to . "\" " if $from && $to;
	$command .= " -evalue \"$expect\" "                      if $expect;
	$command .= " -matrix \"$matrix\" "
	  if $matrix
	  && ( $blast eq "blastp"
		|| $blast eq "blastx"
		|| $blast eq "tblastn"
		|| $blast eq "tblastx" );
		
	$command .= " -ungapped " if $ungappedAlignment;
	$command .= " -query_genetic_code $geneticCode "
	  if $geneticCode && $blast eq "blastx";
	$command .= " -db_gen_code $databaseGeneticCode "
	  if $databaseGeneticCode
	  && ( $blast eq "tblastn" || $blast eq "tblastx" );
	  
	$command .= " -num_descriptions $descriptions " if $descriptions;
	$command .= " -num_alignments $alignments "     if $alignments;
	$command .= " -outfmt 0 "                       if !$alignmentView || undef $alignmentView;
	$command .= " -outfmt $alignmentView "          if $alignmentView;

	my @response = `$command`;

	return \@response;
}

1;
