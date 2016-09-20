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

sub searchGeneIdentifier : Path("/SearchDatabase/GeneIdentifier") :
  CaptureArgs(1) {
	my ( $self, $c, $geneId ) = @_;

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
	$c->stash(
		searchResult => [
			$c->model('Chado::Feature')->search(
				{
					'type.name' => 'locus_tag',
					'type_2.name' => 'based_on',
					'type_3.name' => 'pipeline_id',
					'featureloc_featureprop.value' => '4249',
					'feature_relationship_props_subject_feature.value' => { 'like', "\%$geneId\%" }
				},
				{
					join => [
						'feature_relationship_objects' => {
							'feature_relationship_objects' => {
								'type' => {
									'feature_relationships_subject'
								},
								'feature_relationship_props_subject_feature' =>
								{
									'type'
								}
							}
						},
						'featureloc_features' => { 
							'featureloc_features' => {
								'featureloc_featureprop' => {'type'}
							}
						}

					],
#					+columns => 'me.feature_id feature_relationship_props_subject_feature.value',
					select => [
						qw/ me.feature_id feature_relationship_props_subject_feature.value /
					],
					as => [
						qw/ feature_id name /
					],
					order_by => { -asc => [qw/ feature_relationship_props_subject_feature.value /] },
					distinct => 1 
				}
			)
		]
	);

#	$c->stash(searchResult => [ $c->model('Chado::Feature')->getGeneIdentifier() ]);
	$c->stash(template => 'html_dir/search-database/result.tt');
#	$c->response->body(
#		'Matched html_dir::Controller::SearchDatabase in SearchDatabase.');
}

=head2 descriptionToHash

Method used to return hash of values to be used in like search

=cut 

sub descriptionToHash {
	my ( $self, $value, $regex, $key, $type, %like );
	my @terms = split( $regex, $value );
	for ( my $i = 0 ; $i < scalar @terms ; $i++ ) {
		$like{"$key"} = { $type, "%" . $terms[$i] . "%" };
	}
	return %like;
}

=head2 searchGeneDescription

Method used to search on database genes by description
Receive by parameter gene description and descriptions to not be used

=cut

sub searchGeneDescription : Path("/SearchDatabase/GeneDescription") :
  CaptureArgs(2) {
	my ( $self, $c, $geneDescription, $noDescription ) = @_;
	my %like = ( 'featureprops.value' => 'CDS' );

	if ($geneDescription) {
		descriptionToHash( $geneDescription, '^\s+$', "featureprops.value",
			"like", %like );
	}
	if ($noDescription) {
		descriptionToHash( $noDescription, '^\s+$', "featureprops.value",
			"not like", %like );
	}

#SELECT DISTINCT feature.feature_id, ps.value, ps.value
#FROM feature
#JOIN feature_relationship r ON (feature.feature_id = r.object_id)
#JOIN featureloc l ON (l.feature_id = feature.feature_id)
#JOIN featureprop ps ON (r.subject_id = ps.feature_id AND ps.feature_id = feature.feature_id AND l.srcfeature_id = ps.feature_id)
#JOIN cvterm cv ON (r.type_id = cv.cvterm_id AND ps.type_id = cv.cvterm_id)
#WHERE (cv.name = 'based_on' AND cv.name = 'tag' AND cv.name='locus_tag' AND cv.name='description' AND cv.name = 'pipeline_id') AND
#(ps.value = 'CDS' OR ps.value = 'VARIAVEL')

	$c->stash(
		searchResult => [
			$c->model('Chado::Feature')->search(
				{
					-and => [
						-or => [
							'cvterm.name' => 'based_on',
							'cvterm.name' => 'tag',
							'cvterm.name' => 'locus_tag',
							'cvterm.name' => 'description',
							'cvterm.name' => 'pipeline_id',
						],
						-or => [%like]
					]
				},
				{
					join => [
						'feature_relationship_objects',
						'featureloc_features',
						'featureprops',
						'feature_cvterms' => {
							'feature_cvterms' => {
								'cvterm' => 'feature_relationships',
								'cvterm' => 'featureprops'
							}
						},

					],
					columns => [
						qw/ feature_id  featureprops.value /,
						{
							'featureprops.feature_id' =>
							  'featureloc_features.srcfeature_id',
							'featureprops.feature_id' =>
							  'feature_relationship_objects.subject_id'
						}
					],
					order_by => { -asc => [qw/featureprops.value/] },
					distinct => 1
				}
			)
		]
	);
	$c->response->body(
		'Matched html_dir::Controller::SearchDatabase in SearchDatabase.');
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
			as => ["residues"]
		}
	);
	
	if($reverseComplement)
	{
		for(my $i = 0; $i < scalar @searchResult; $i++)
		{
			$searchResult[$i] = formatSequence(reverseComplement($searchResult[$i]->{residues}));
		}
	}
	
	$c->stash(
		searchResult => [
			@searchResult
		]
	);
	$c->response->body(
		'Matched html_dir::Controller::SearchDatabase in SearchDatabase.');
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
