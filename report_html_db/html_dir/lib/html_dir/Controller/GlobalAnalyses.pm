package html_dir::Controller::GlobalAnalyses;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

html_dir::Controller::GlobalAnalyses - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut



sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{titlePage} = 'GlobalAnalyses';
    $c->stash(currentPage => 'global-analyses');
    $c->stash(texts => [$c->model('Model::Text')->search({
        -or => [
            tag => {'like', 'header%'},
            tag => 'menu',
            tag => 'footer',
            tag => {'like', 'global-analyses%'}
        ]
    })]);
    $c->stash(template => 'html_dir/global-analyses/index.tt');
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
