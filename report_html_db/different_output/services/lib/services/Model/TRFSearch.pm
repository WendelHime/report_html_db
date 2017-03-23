package services::Model::TRFSearch;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Models::Application::TRFSearch',
    constructor => 'new',
);

1;
