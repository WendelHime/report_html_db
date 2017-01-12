package TESTE2::Model::BaseResponse;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Models::Services::BaseResponse',
    constructor => 'new',
);

1;
