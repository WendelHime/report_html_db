package html_dir::Controller::SearchDatabase;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

html_dir::Controller::SearchDatabase - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 searchGeneIdentifier

Method used to search on database genes by id

=cut

sub searchGeneIdentifier : Path("/SearchDatabase/GeneIdentifier") : Args(0) {
	my ( $self, $c ) = @_;

	$c->stash->{titlePage} = 'Gene identifier';
	$c->stash(currentPage => 'search-database');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
				-or => [
					tag => {'like', 'header%'},
					tag => 'menu',
					tag => 'footer',
					tag => {'like', 'search-database%'}
				]
	}))]);


#select distinct f.feature_id, ps.value
#from feature f
#join feature_relationship r on (f.feature_id = r.object_id)
#join cvterm cr on (r.type_id = cr.cvterm_id)
#join featureprop ps on (r.subject_id = ps.feature_id)
#join cvterm cs on (ps.type_id = cs.cvterm_id)
#join featureloc l on (l.feature_id = f.feature_id)
#join featureprop pl on (l.srcfeature_id = pl.feature_id)
#join cvterm cp on (pl.type_id = cp.cvterm_id)
#where cr.name = 'based_on' and cs.name = 'locus_tag' and cp.name = 'pipeline_id' and
#pl.value='4249';

	my $geneID = $c->req->param("geneID");
	$c->stash(
		searchResult => [
			$c->model('Chado::Feature')->search(
				{
					'type.name'                    => 'locus_tag',
					'type_2.name'                  => 'based_on',
					'type_3.name'                  => 'pipeline_id',
					'featureloc_featureprop.value' => '4249',
					'feature_relationship_props_subject_feature.value' =>
					  { 'like', '%'.$geneID.'%' }
				},
				{
					join => [

			  #						join feature_relationship r on (f.feature_id = r.object_id)
						'feature_relationship_objects' => {

							#							join cvterm cr on (r.type_id = cr.cvterm_id)
							'feature_relationship_objects' => {

				  #								join featureprop ps on (r.subject_id = ps.feature_id)
								'type' => {'feature_relationships_subject'},

				  #								join featureprop ps on (r.subject_id = ps.feature_id)
								'feature_relationship_props_subject_feature' =>
								  {
						 #									join cvterm cs on (ps.type_id = cs.cvterm_id)
									'type'
								  }
							}
						},

					   #						join featureloc l on (l.feature_id = f.feature_id)
						'featureloc_features' => {

				#							join featureprop pl on (l.srcfeature_id = pl.feature_id)
							'featureloc_features' => {

						#							  	join cvterm cp on (pl.type_id = cp.cvterm_id)
								'featureloc_featureprop' => {'type'}
							}
						}
					],
					select => [
						qw/ me.feature_id feature_relationship_props_subject_feature.value /
					],
					as       => [qw/ feature_id name /],
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

	$c->stash->{hadGlobal} = 0;
	$c->stash->{hadSearchDatabase} = 1;

	$c->stash( template => 'html_dir/search-database/result.tt' );

	#	$c->response->body(
	#		'Matched html_dir::Controller::SearchDatabase in SearchDatabase.');
}

=head2 descriptionToHash

Method used to return hash of values to be used in like search

=cut 

#sub descriptionToHash {
#	my ( $self, $value, $key, $type, @object );
#	my @terms = ();
#	while ( $value =~ /(\S+)/g ) {
#		push @terms, $1;
#	}
#	for ( my $i = 0 ; $i < scalar @terms ; $i++ ) {
#		push @object, { "$type", "%" . $terms[$i] . "%" };
#	}
#	return @object;
#}

=head2 searchGeneDescription

Method used to search on database genes by description
Receive by parameter gene description and descriptions to not be used

=cut

sub searchGeneDescription : Path("/SearchDatabase/GeneDescription") :
  Args(0) {
	my ( $self, $c ) = @_;
	my $geneDescription = $c->req->param("geneDesc"); 
	my $noDescription = $c->req->param("noDesc");
	my $individually = $c->req->param("individually");
	
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
				-or => [
					tag => {'like', 'header%'},
					tag => 'menu',
					tag => 'footer',
					tag => {'like', 'search-database%'}
				]
	}))]);
	
	my @likes = ();
	if ($geneDescription) {
		my @terms = ();
		while ( $geneDescription =~ /(\S+)/g ) {
			if ($individually) {
				push @likes,
				  '-or' =>
				  [ "feature_relationship_props_subject_feature_2.value" =>
					  { "like", "\%" . $1 . "\%" } ];
			}
			else {
				push @likes,
				  '-and' =>
				  [ "feature_relationship_props_subject_feature_2.value" =>
					  { "like", "\%" . $1 . "\%" } ];
			}
		}
	}
	if ($noDescription) {
		while ( $noDescription =~ /(\S+)/g ) {
			push @likes,
			  '-and' =>
			  [ "feature_relationship_props_subject_feature_2.value" =>
				  { "not like", "\%" . $1 . "\%" } ];
		}
	}

	$c->stash( likes => @likes );

#select distinct f.feature_id, ps.value, pd.value
#from feature f
#join feature_relationship r on (f.feature_id = r.object_id)
#join cvterm cr on (r.type_id = cr.cvterm_id)
#join featureprop ps on (r.subject_id = ps.feature_id)
#join cvterm cs on (ps.type_id = cs.cvterm_id)
#
#join featureprop pf on (f.feature_id = pf.feature_id)
#join cvterm cf on (pf.type_id = cf.cvterm_id)
#
#join featureloc l on (l.feature_id = f.feature_id)
#join featureprop pl on (l.srcfeature_id = pl.feature_id)
#join cvterm cp on (pl.type_id = cp.cvterm_id)
#join featureprop pd on (r.subject_id = pd.feature_id)
#join cvterm cd on (pd.type_id = cd.cvterm_id)
#where cr.name = 'based_on' and cf.name = 'tag' and pf.value='CDS' and cs.name = 'locus_tag' and cd.name = 'description' and cp.name = 'pipeline_id' and
#pl.value='$pipeline' and

	$c->stash(
		searchResult => [
			$c->model('Chado::Feature')->search(
				{
					'type.name'                    => 'locus_tag',
					'type_2.name'                  => 'based_on',
					'type_3.name'                  => 'tag',
					'type_4.name'                  => 'pipeline_id',
					'type_5.name'                  => 'description',
					'featureprops_2.value'         => 'CDS',
					'featureloc_featureprop.value' => '4249',
					@likes
					  ###		  ###
					  #			#
					  #	terms	#
					  #			#
					  ###		  ###
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
						'featureprops' => {
							'featureprops' => {'type'}
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
	$c->stash->{hadGlobal} = 0;
	$c->stash->{hadSearchDatabase} = 1;
	$c->stash( template => 'html_dir/search-database/result.tt' );

	#		$c->stash( template => 'html_dir/search-database/result.tt' )
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
				my $string = decode('utf-8', $text->{$key}{value});
				$string = encode('iso-8859-1', $string);
				$text->{$key}{value} = $string;
			}
		}
	}
    return @texts;
}

=head2 searchContig

Method used to realize search by contigs, optional return a stretch or a reverse complement

=cut

sub searchContig : Path("/SearchDatabase/SearchContig") : CaptureArgs(4) {
	my ( $self, $c, $contig, $start, $end, $reverseComplement ) = @_;
	my $column = "";
	if ( $start && $end ) {
		$column = "SUBSTRING(residues, $start, $end)";
	}
	else {
		$column = "residues";
	}
	my @searchResult = $c->model('Chado::Feature')->search(
		{
			uniquename => $contig
		},
		{
			select => $column,
			as     => ["residues"]
		}
	);

	if ($reverseComplement) {
		for ( my $i = 0 ; $i < scalar @searchResult ; $i++ ) {
			$searchResult[$i] =
			  formatSequence(
				reverseComplement( $searchResult[$i]->{residues} ) );
		}
	}

	$c->stash( searchResult => [@searchResult] );
	$c->response->body(
		"Matched html_dir::Controller::SearchDatabase in SearchDatabase.");
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
	$sequence =~ s/.{$block}/$&\n/gs;
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
