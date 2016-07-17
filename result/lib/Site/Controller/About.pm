package Site::Controller::About;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Site::Controller::About - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{titlePage} = "About";
    $c->stash(texts => [$c->model('Model::Text')->search({
        -or => [
            tag => {'like', 'header%'},
            tag => 'menu',
            tag => 'footer',
            tag => {'like', 'about%'}
        ]
    })]);
    $c->stash->{template} = 'site/about/index.tt';
    #$c->response->body('Matched Site::Controller::About in About.');
}



=encoding utf8

=head1 AUTHOR

Wendel Hime,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
