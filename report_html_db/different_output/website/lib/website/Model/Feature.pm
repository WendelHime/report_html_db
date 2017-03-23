package website::Model::Feature;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Models::Application::Feature',
    constructor => 'new',
);

1;
