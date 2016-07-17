package Site::Controller::Help;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Site::Controller::Help - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{titlePage} = "Help";
    $c->stash(texts => [$c->model('Model::Text')->search({
        -or => [
            tag => {'like', 'header%'},
            tag => 'menu',
            tag => 'footer',
            tag => {'like', 'help%'}
        ]
    })]);
    $c->stash->{template} = 'site/help/index.tt';
    #$c->response->body('Matched Site::Controller::Help in Help.');
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
