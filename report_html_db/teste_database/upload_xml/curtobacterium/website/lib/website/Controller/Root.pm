package website::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

website::Controller::Root - Root Controller for website

=head1 DESCRIPTION

Root where will have the main pages

=head1 METHODS

=cut 


=head2 globalAnalyses

Global analyses page

=cut

sub globalAnalyses :Path("GlobalAnalyses") :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Global Analyses';
	$c->stash(currentPage => 'global-analyses');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
		-or => [
			tag => {'like', 'header%'},
			tag => 'menu',
			tag => 'footer',
			tag => {'like', 'global-analyses%'}
		]
	}))]);
	
	$c->stash(template => 'website/global-analyses/index.tt');
	$c->stash(components => [$c->model('Basic::Component')->all]);
	$c->stash->{hadGlobal} = 1;
	$c->stash->{hadSearchDatabase} = 1;
	

}

	
=head2 searchDatabase

Search database page (/SearchDatabase)

=cut
sub searchDatabase :Path("SearchDatabase") :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Search Database';
	$c->stash(currentPage => 'search-database');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
				-or => [
					tag => {'like', 'header%'},
					tag => 'menu',
					tag => 'footer',
					tag => {'like', 'search-database%'}
				]
	}))]);
	my $searchDBClient = Report_HTML_DB::Clients::SearchDBClient->new(rest_endpoint => $c->config->{rest_endpoint});
	my $pipeline;
	
	if(!$c->config->{pipeline_id}) {
		my $response = $searchDBClient->getPipeline()->getResponse()->{pipeline_id};
		use File::Basename;
		open( my $FILEHANDLER,
			">>", dirname(__FILE__) . "/../../../website.conf");
		print $FILEHANDLER "
pipeline_id $response
";
		close($FILEHANDLER);
		$pipeline = $response;
	} else {
		$pipeline = $c->config->{pipeline_id};
	}
	
	$c->stash(
		targetClass => $searchDBClient->getTargetClass($pipeline)->getResponse()  
	);
	
	$c->stash(
		rRNAsAvailable => $searchDBClient->getRibosomalRNAs($pipeline)->getResponse()
	);
	
	$c->stash(
		sequences => [
			$c->model('Basic::Sequence')->all
		]
	);
	
	$c->stash(template => 'website/search-database/index.tt');
	$c->stash(components => [$c->model('Basic::Component')->all]);
	$c->stash->{hadGlobal} = 1;
	$c->stash->{hadSearchDatabase} = 1;

}


=head2 about

About page (/About)

=cut

sub about : Path("About") : Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'About';
	$c->stash( currentPage => 'about' );
	$c->stash(
		texts => [
			encodingCorrection(
				$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'about%' }
						]
					}
				)
			)
		]
	);
	$c->stash( template => 'website/about/index.tt' );
	$c->stash->{hadGlobal}         = 1;
	$c->stash->{hadSearchDatabase} = 1;

}

=head2 blast

The blast page (/Blast)

=cut

sub blast : Path("Blast") : Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Blast';
	$c->stash( currentPage => 'blast' );
	$c->stash(
		texts => [
			encodingCorrection(
				$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'blast%' }
						]
					}
				)
			)
		]
	);
	
	$c->stash( template => 'website/blast/index.tt' );
	$c->stash->{hadGlobal}         = 1;
	$c->stash->{hadSearchDatabase} = 1;

}

=head2 downloads

The download page (/Downloads)

=cut

sub downloads : Path("Downloads") : Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Downloads';
	$c->stash( currentPage => 'downloads' );
	$c->stash(
		texts => [
			encodingCorrection(
				$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'downloads%' }
						]
					}
				)
			)
		]
	);
	
	$c->stash( template => 'website/downloads/index.tt' );
	$c->stash->{hadGlobal}         = 1;
	$c->stash->{hadSearchDatabase} = 1;

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

=head2

Method used to get feature id

=cut

#sub get_feature_id {
#	my ($c) = @_;
#	return $c->model('SearchDatabaseRepository')->get_feature_id($c->config->{uniquename});
#}

=head2 help

The help page (/Help)

=cut

sub help : Path("Help") : Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Help';
	$c->stash( currentPage => 'help' );
	$c->stash(
		texts => [
			encodingCorrection(
				$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'help%' }
						]
					}
				)
			)
		]
	);
	#if ( !defined $feature_id ) {
	#	$feature_id = get_feature_id($c);
	#}
	#$c->stash( teste    => $feature_id );
	$c->stash( template => 'website/help/index.tt' );
	$c->stash->{hadGlobal}         = 1;
	$c->stash->{hadSearchDatabase} = 1;

}

=head2 index

The root page (/)

=cut

sub index : Path : Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Home';
	$c->stash( currentPage => 'home' );
	$c->stash(
		texts => [
			encodingCorrection(
				$c->model('Basic::Text')->search(
					{
						-or => [
							tag => { 'like', 'header%' },
							tag => 'menu',
							tag => 'footer',
							tag => { 'like', 'home%' }
						]
					}
				)
			)
		]
	);
	#if ( !defined $feature_id ) {
	#	$feature_id = get_feature_id($c);
	#}
	$c->stash( template => 'website/home/index.tt' );
	$c->stash->{hadGlobal}         = 1;
	$c->stash->{hadSearchDatabase} = 1;

}

sub downloadFile : Path("DownloadFile") : CaptureArgs(1) {
	my ( $self, $c, $type ) = @_;
	if ( !$type and defined $c->request->param("type") ) {
		$type = $c->request->param("type");
	}
	my $filepath = (
		$c->model('Basic::File')->search(
			{
				tag => "$type"
			},
			{
				columns => qw/filepath/,
				rows    => 1
			}
		)->single->get_column(qw/filepath/)
	);

	open( my $FILEHANDLER, "<", dirname(__FILE__) . "/../../../root/" . $filepath );
	binmode $FILEHANDLER;
	my $file;

	local $/ = \10240;
	while (<$FILEHANDLER>) {
		$file .= $_;
	}
	$c->response->body($file);
	$c->response->headers->content_type('application/x-download');
	my $filename = "";
	if($filepath =~ /\/([\w\s\-_]+\.[\w\s\-_]+)/g) {
		$filename = $1;
	}
	$c->response->body($file);
	$c->response->header('Content-Disposition' => 'attachment; filename='.$filename);
	close $FILEHANDLER;
}

sub reports : Path("reports") : CaptureArgs(3) {
	my ( $self, $c, $type, $file, $file2 ) = @_;
	my $filepath = "$type/$file";
	$filepath .= "/$file2" if $file2;
	
	$self->status_bad_request( $c, message => "Invalid request" )
	  if ( $filepath =~ m/\.\.\// );
	
	use File::Basename;
	open( my $FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . $filepath );
	my $content = "";
	while ( my $line = <$FILEHANDLER> ) {
		#$line =~ s/href="/href="\/reports\/$type\//
		  #if ( $line =~ /href="/ && $line !~ /href="http\:\/\// );
		$content .= $line . "\n";
	}
	close($FILEHANDLER);
	if($filepath =~ /\.png/g) {
                use MIME::Base64;
                $content = MIME::Base64::encode_base64($content);
        } elsif($filepath =~ /.html/g) {
                if(!($filepath =~ m/pathway/)) {
                        $content =~ s/src="/src="\/$type\//igm;
                        $content =~ s/HREF="/HREF="\/$type\//g;
                } else {
                        foreach ($content =~ /<img[\w\s"=]*src="([\.\w\s\-\/]*)"/img) {
                                if($_ =~ m/kegg.gif/) {
                                        my $imagePath = $_;
                                        $imagePath =~ s/\.\.\///;
                                         open( $FILEHANDLER,
                                        "<", dirname(__FILE__) . "/../../../root/$type/" . $imagePath );
                                } else {
                                        open( $FILEHANDLER,
                                        "<", dirname(__FILE__) . "/../../../root/$type/$file" . "/" . $_ );
                                }
                                my $contentFile = do { local($/); <$FILEHANDLER> };
                                close($FILEHANDLER);
                                use MIME::Base64;
                                $contentFile = MIME::Base64::encode_base64($contentFile);
                                $content =~ s/<img[\w\s"=]*src="$_/<img src="data:image\/png;base64,$contentFile/;
                        }
                        #$content =~ s/HREF="/HREF="/$type/igm;
                }
        }
	$c->response->body($content);
}

=head2 default


Standard 404 error page

=cut

sub default : Path {
	my ( $self, $c ) = @_;
	$c->response->body('Oops, page not found');
	$c->response->status(404);
}

=head2 renderView

Attempt to render a view, if needed.

=cut

sub renderView : ActionClass('RenderView') { }

sub end : Private {
	my ( $self, $c ) = @_;

	if ( scalar @{ $c->error } ) {
		$c->stash->{errors}   = $c->error;
		for my $error ( @{ $c->error } ) {
			$c->log->error($error);
		}
		$c->stash(
			texts => [
				encodingCorrection(
					$c->model('Basic::Text')->search(
						{
							-or => [
								tag => { 'like', 'header%' },
								tag => 'menu',
								tag => 'footer',
							]
						}
					)
				)
			]
		);
		$c->stash->{hadGlobal}         = 1;
		$c->stash->{hadSearchDatabase} = 1;
		$c->stash->{template} = 'website/errors.tt';
		$c->forward('website::View::TT');
		$c->clear_errors;
	}

	return 1 if $c->response->status =~ /^3\d\d$/;
	return 1 if $c->response->body;

	unless ( $c->response->content_type ) {
		$c->response->content_type('text/html; charset=utf-8');
	}

	$c->forward('website::View::TT');
}

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;


