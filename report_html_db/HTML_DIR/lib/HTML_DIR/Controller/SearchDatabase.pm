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

sub getHTMLResultContig : Path("getHTMLResultContig") : Args(0) {
	my ( $self, $c ) = @_;

}

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
							tag => { 'like', 'result%' }
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
			if ( scalar(@likesNoDescription) > 0 ) {
				push @likes,
				  '-and' => [ @likesDescription, @likesNoDescription ];
			}
			else {
				push @likes, '-and' => [@likesDescription];
			}
		}
		elsif ( scalar(@likesDescription) > 0 ) {
			if ( scalar(@likesNoDescription) > 0 ) {
				push @likes, '-and' => [@likesNoDescription];
			}
			push @likes, '-or' => [@likesDescription];
		}
		elsif ( scalar(@likesDescription) <= 0
			and scalar(@likesNoDescription) > 0 )
		{
			push @likes, '-and' => [@likesDescription];
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

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2 searchContig

Method used to realize search by contigs, optional return a stretch or a reverse complement

=cut

sub searchContig : Path("/SearchDatabase/Contig") : CaptureArgs(4) :
  ActionClass('REST') { }

sub searchContig_GET {
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
		$data = substr( $data, $start, ( $end - $start ) );
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

	my @list = ();
	my %hash = ();
	$hash{'geneID'} = $sequence->id;
	$hash{'gene'}   = $sequence->name;
	$hash{'contig'} = $result;

	open( $FILEHANDLER, "<",
		dirname(__FILE__)
		  . "/../../../root/html_dir/search-database/contigs.tt" );

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);

	$hash{'html'} = $content;
	push @list, \%hash;
	$self->status_ok( $c, entity => @list );
	return @list;
}

sub getGeneBasics : Path("/SearchDatabase/GetGeneBasics") : CaptureArgs(1) :
  ActionClass('REST') { }

=head2 getGeneBasics
Method used to return basic data of genes from database: the beginning position from sequence, final position from the sequence, type, name
return a list of hash containing the basic data

=cut

sub getGeneBasics_GET {
	my ( $self, $c, $id ) = @_;

	#verify if the id exist and set
	if ( !$id and defined $c->request->param("id") ) {
		$id = $c->request->param("id");
	}

	#get data from db based on id
	my $resultSet = $c->model('Chado::Feature')->search(
		{
			'type.name'                    => 'based_on',
			'type_2.name'                  => 'locus_tag',
			'type_3.name'                  => 'tag',
			'type_4.name'                  => 'pipeline_id',
			'featureloc_featureprop.value' => '4249',
			'me.feature_id'                => "$id"
		},
		{
			join => [
				'feature_relationship_objects' => {
					'feature_relationship_objects' => {
						'type' => {'feature_relationships_subject'},
						'feature_relationship_props_subject_feature' =>
						  {'type'},
						'feature_relationship_props_subject_feature' => {'type'}
					}
				},
				'featureprops' => {
					'featureprops' => {'type'}
				},
				'featureloc_features' => {
					'featureloc_features' => {
						'featureloc_featureprop' => {'type'},
						'srcfeature'
					}
				}
			],
			select => [
				qw/ featureloc_features_2.fstart featureloc_features_2.fend featureprops_2.value srcfeature.uniquename /
			],
			as       => [qw/ residues seqlen name uniquename /],
			order_by => {
				-asc => [qw/ feature_relationship_props_subject_feature.value /]
			},
			distinct => 1
		}
	);

	#initializing list of results
	my @list = ();

	#based on results
	#add in list hash where will had the data
	while ( my $feature = $resultSet->next ) {
		my %hash = ();
		$hash{'fstart'}     = $feature->residues;
		$hash{'fend'}       = $feature->seqlen;
		$hash{'value'}      = $feature->name;
		$hash{'uniquename'} = $feature->uniquename;
		push( @list, \%hash );
	}

	#defining the type of return
	$self->status_ok( $c, entity => @list );

	return @list;
}

=head2 getSubsequence

Method used to get subsequence stretch of gene, returning the sequence, had to return in a json!

=cut

sub getSubsequence : Path("/SearchDatabase/GetSubsequence") : CaptureArgs(4) {
	my ( $self, $c, $contig, $start, $end, $type ) = @_;
	if ( !$contig and defined $c->request->param("contig") ) {
		$contig = $c->request->param("contig");
	}
	if ( !$start and defined $c->request->param("start") ) {
		$start = $c->request->param("start");
	}
	if ( !$end and defined $c->request->param("end") ) {
		$end = $c->request->param("end");
	}
	if ( !$type and defined $c->request->param("type") ) {
		$type = $c->request->param("type");
	}
	my $for          = $end - $start + 1;
	my @searchResult = $c->model('Chado::Feature')->search(
		{
			'uniquename' => "$contig"
		},
		{
			select => [ { SUBSTRING => [ 'residues', "$start", "$for" ] } ],
			as => ['residues']
		}
	);

	$c->stash( template => 'html_dir/search-database/result.tt' );

	#I need just one result, so in the end, return sequence
	my $feature  = $searchResult[0];
	my $sequence = $feature->{residues};
	if (   $sequence !~ /TAA$/i
		&& $sequence !~ /TAG$/i
		&& $sequence !~ /TGA$/i
		&& $type eq 'CDS' )
	{
		$sequence = reverseComplement($sequence);
	}
	return formatSequence($sequence);
}

=head2 ncRNA_desc  

Method used to return nc rna description

=cut

sub ncRNA_desc : Path("/SearchDatabase/ncRNA_desc") : CaptureArgs(1) :
  ActionClass('REST') { }

sub ncRNA_desc_GET {
	my ( $self, $c, $feature ) = @_;
	if ( !$feature and defined $c->request->param("feature") ) {
		$feature = $c->request->param("feature");
	}

	my $resultSet = $c->model('Chado::FeatureRelationship')->search(
		{
			'type.name'                    => 'interval',
			'type_2.name'                  => 'pipeline_id',
			'type_3.name'                  => 'target_description',
			'featureloc_featureprop.value' => '4249',
			'analysis.program'             => 'annotation_infernal.pl',
			'me.object_id'                 => "$feature",
		},
		{
			join => [
				'type',
				'feature_relationship_analysis_feature_feature_object' => {
					'feature_relationship_analysis_feature_feature_object' =>
					  {'analysis'}
				},
				'feature_relationship_featureloc_subject_feature' => {
					'feature_relationship_featureloc_subject_feature' =>
					  {'srcfeature'},
					'feature_relationship_featureloc_subject_feature' =>
					  { 'featureloc_featureprop' => {'type'} }
				},
				'feature_relationship_props_subject_feature' => {
					'feature_relationship_props_subject_feature' => {'type'}
				},
			],
			select => [
				qw/me.object_id feature_relationship_props_subject_feature_2.value/
			],
			as       => [qw/ object_id value /],
			order_by => {
				-asc =>
				  [qw/ feature_relationship_props_subject_feature_2.value /]
			},
			distinct => 1
		}
	);
	my @list = ();
	while ( my $result = $resultSet->next ) {
		my %hash = ();
		$hash{'object_id'} = $result->object_id;
		$hash{'value'}     = $result->value;
		push @list, \%hash;
	}
	$self->status_ok( $c, entity => @list );

	#	$c->stash( template => 'html_dir/search-database/result.tt' );

	return @list;
}

=head2 reverseComplement

Method used to return the reverse complement of a sequence

=cut

sub reverseComplement {
	my ($sequence) = @_;
	my $reverseComplement = reverse($sequence);
	$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return $reverseComplement;
}

=head formatSequence

Method used to format sequence

=cut

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

