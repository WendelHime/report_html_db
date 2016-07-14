use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Site';
use Site::Controller::SearchDatabase;

ok( request('/searchdatabase')->is_success, 'Request should succeed' );
done_testing();
