use strict;
use warnings;
use Test::More;


use Catalyst::Test 'TESTE2';
use TESTE2::Controller::SearchDatabase;

ok( request('/searchdatabase')->is_success, 'Request should succeed' );
done_testing();
