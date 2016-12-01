package HTML_DIR::Controller::Root;
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

HTML_DIR::Controller::Root - Root Controller for HTML_DIR

=head1 DESCRIPTION

Root where will have the main pages

=head1 METHODS

=cut 
my $feature_id;
	
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
	if(!defined $feature_id)
	{
		$feature_id = get_feature_id($c);
	}
	print STDERR $feature_id;
	$c->stash(
		targetClass => [
			$c->model('DBI')->get_target_class(81525, $feature_id)
		]
	);
	
	$c->stash(
		sequences => [
			$c->model('Basic::Sequence')->all
		]
	);
	
	$c->stash(template => 'html_dir/search-database/index.tt');
	$c->stash(components => [$c->model('Basic::Component')->all]);
	$c->stash->{hadGlobal} = 0;
	$c->stash->{hadSearchDatabase} = 1;

}


=head2 about

About page (/About)

=cut

sub about :Path("About") :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'About';
	$c->stash(currentPage => 'about');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
		-or => [
			tag => {'like', 'header%'},
			tag => 'menu',
			tag => 'footer',
			tag => {'like', 'about%'}
		]
	}))]);
	if(!defined $feature_id)
	{
		$feature_id = get_feature_id($c);
	}
	$c->stash(template => 'html_dir/about/index.tt');
	$c->stash->{hadGlobal} = 0;
	$c->stash->{hadSearchDatabase} = 1;

}

=head2 blast

The blast page (/Blast)

=cut
sub blast :Path("Blast") :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Blast';
	$c->stash(currentPage => 'blast');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
		-or => [
			tag => {'like', 'header%'},
			tag => 'menu',
			tag => 'footer',
			tag => {'like', 'blast%'}
		]
	}))]);
	if(undef $feature_id)
	{
		$feature_id = get_feature_id($c);
	}
	$c->stash(template => 'html_dir/blast/index.tt');
	$c->stash->{hadGlobal} = 0;
	$c->stash->{hadSearchDatabase} = 1;

}

=head2 downloads

The download page (/Downloads)

=cut
sub downloads :Path("Downloads") :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Downloads';
	$c->stash(currentPage => 'downloads');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
		-or => [
			tag => {'like', 'header%'},
			tag => 'menu',
			tag => 'footer',
			tag => {'like', 'downloads%'}
		]
	}))]);
	if(!defined $feature_id)
	{
		$feature_id = get_feature_id($c);
	}
	$c->stash(template => 'html_dir/downloads/index.tt');
	$c->stash->{hadGlobal} = 0;
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
				my $string = decode('utf-8', $text->{$key}{value});
				$string = encode('iso-8859-1', $string);
				$text->{$key}{value} = $string;
			}
		}
	}
    return @texts;
}


=head2

Method used to get feature id

=cut
sub get_feature_id {
	my ($c) = @_;
	return $c->model('DBI')->get_feature_id('Bacteria_upload');
}


=head2 help

The help page (/Help)

=cut
sub help :Path("Help") :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Help';
	$c->stash(currentPage => 'help');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
		-or => [
			tag => {'like', 'header%'},
			tag => 'menu',
			tag => 'footer',
			tag => {'like', 'help%'}
		]
	}))]);
	if(!defined $feature_id)
	{
		$feature_id = get_feature_id($c);
	}
	$c->stash(teste => $feature_id);
	$c->stash(template => 'html_dir/help/index.tt');
	$c->stash->{hadGlobal} = 0;
	$c->stash->{hadSearchDatabase} = 1;

}

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{titlePage} = 'Home';
	$c->stash(currentPage => 'home');
	$c->stash(texts => [encodingCorrection ($c->model('Basic::Text')->search({
		-or => [
			tag => {'like', 'header%'},
			tag => 'menu',
			tag => 'footer',
			tag => {'like', 'home%'}
		]
	}))]);
	if(!defined $feature_id)
	{
		$feature_id = get_feature_id($c);
	}
	$c->stash(template => 'html_dir/home/index.tt');
	$c->stash->{hadGlobal} = 0;
	$c->stash->{hadSearchDatabase} = 1;

}


=head2 default


Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

