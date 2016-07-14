use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Site';
use Site::Controller::Help;

ok( request('/help')->is_success, 'Request should succeed' );
done_testing();
