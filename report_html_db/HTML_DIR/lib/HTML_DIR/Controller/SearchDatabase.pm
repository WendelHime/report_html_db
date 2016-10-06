package HTML_DIR::Controller::SearchDatabase;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

HTML_DIR::Controller::SearchDatabase - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 searchGene

Method used to search on database genes

=cut

sub searchGene : Path("/SearchDatabase/Gene") : CaptureArgs(4) {
	my ( $self, $c, $geneID, $geneDescription, $noDescription, $individually )
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

	$c->stash->{titlePage} = 'Search gene';
	$c->stash( currentPage => 'search-database' );
	$c->stash(
		texts => [
			encodingCorrection(
				$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'search-database%' }
						]
					}
				)
			)
		]
	);

	my @likes = ();

	if ( defined $geneDescription or defined $noDescription ) {
		my @likesDescription   = ();
		my @likesNoDescription = ();
		if ($geneDescription) {
			while ( $geneDescription =~ /(\S+)/g ) {
				push @likesDescription,
				  "feature_relationship_props_subject_feature_2.value" =>
				  { "like", "%" . $1 . "%" };
			}
		}
		if ($noDescription) {
			while ( $noDescription =~ /(\S+)/g ) {
				push @likesNoDescription,
				  "feature_relationship_props_subject_feature_2.value" =>
				  { "not like", "%" . $1 . "%" };
			}
		}

		if (    defined $individually
			and $individually
			and scalar(@likesDescription) > 0 )
		{
			push @likes, '-and' => [@likesDescription];
		}
		elsif ( scalar(@likesDescription) > 0 ) {
			push @likes, '-or' => [@likesDescription];
		}
		if ( scalar(@likesNoDescription) > 0 ) {
			push @likes, '-and' => [@likesNoDescription];
		}
	}

	$c->stash(
		searchResult => [
			$c->model('Chado::Feature')->search(
				{
					'type.name'                    => 'locus_tag',
					'type_2.name'                  => 'based_on',
					'type_3.name'                  => 'pipeline_id',
					'type_4.name'                  => 'description',
					'featureloc_featureprop.value' => '4249',
					'feature_relationship_props_subject_feature.value' =>
					  { 'like', '%' . $geneID . '%' },
					@likes
				},
				{
					join => [
						'feature_relationship_objects' => {
							'feature_relationship_objects' => {
								'type' => {'feature_relationships_subject'},
								'feature_relationship_props_subject_feature' =>
								  {'type'},
								'feature_relationship_props_subject_feature' =>
								  {'type'}
							}
						},
						'featureloc_features' => {
							'featureloc_features' => {
								'featureloc_featureprop' => {'type'}
							}
						},
						'feature_relationship_objects' => {
							'feature_relationship_objects' => {
								'feature_relationship_props_subject_feature' =>
								  {'type'}
							}
						}
					],
					select => [
						qw/ me.feature_id feature_relationship_props_subject_feature.value feature_relationship_props_subject_feature_2.value /
					],
					as       => [qw/ feature_id name uniquename/],
					order_by => {
						-asc => [
							qw/ feature_relationship_props_subject_feature.value /
						]
					},
					distinct => 1
				}
			)
		]
	);
	$c->stash->{type_search}       = 0;
	$c->stash->{hadGlobal}         = 0;
	$c->stash->{hadSearchDatabase} = 1;
	$c->stash( template => 'html_dir/search-database/result.tt' );
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

sub searchContig : Path("/SearchDatabase/Contig") : CaptureArgs(4) {
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
	$c->stash->{titlePage} = 'Search contig';
	$c->stash( currentPage => 'search-database' );
	$c->stash(
		texts => [
			encodingCorrection(
				$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'search-database%' }
						]
					}
				)
			)
		]
	);
	my $data     = "";
	my $sequence = $c->model('Basic::Sequence')->find($contig);
	open( my $FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . $sequence->filepath );

	for my $line (<$FILEHANDLER>) {
		if ( !( $line =~ /^>\w+\n$/g ) ) {
			$data .= $line;
		}
	}
	close($FILEHANDLER);
	if ( $start && $end ) {
		$data = substr( $data, $start - 1, ( $end - $start ) );
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
	$c->stash->{type_search}       = 1;
	$c->stash->{hadGlobal}         = 0;
	$c->stash->{hadSearchDatabase} = 1;

	$c->stash->{sequence} = $sequence;
	$c->stash->{contig}   = $result;
	$c->stash( template => 'html_dir/search-database/result.tt' );
}

sub reverseComplement {
	my ($sequence) = @_;
	my $reverseComplement = reverse($sequence);
	$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return $reverseComplement;
}

sub formatSequence {
	my ( $sequence, $block ) = @_;
	$block = $block || 80 if ($block);
	$sequence =~ s/.{$block}/$&
/gs;
	chomp $sequence;
	return $sequence;
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

