package services::Model::TRNASearch;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Models::Application::TRNASearch',
    constructor => 'new',
);

1;

