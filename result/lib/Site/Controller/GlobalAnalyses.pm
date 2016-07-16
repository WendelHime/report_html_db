package Site::Controller::GlobalAnalyses;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Site::Controller::GlobalAnalyses - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{titlePage} = "Global analysis";
    $c->stash(texts => [$c->model('Model::Text')->all]);
    $c->stash->{template} = 'site/globalAnalyses/index.tt';
    #$c->response->body('Matched Site::Controller::GlobalAnalyses in GlobalAnalyses.');
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
