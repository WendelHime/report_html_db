use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Site';
use Site::Controller::Blast;

ok( request('/blast')->is_success, 'Request should succeed' );
done_testing();
