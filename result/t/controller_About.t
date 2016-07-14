use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Site';
use Site::Controller::About;

ok( request('/about')->is_success, 'Request should succeed' );
done_testing();
