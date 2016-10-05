use strict;
use warnings;
use Test::More;


use Catalyst::Test 'HTML_DIR';
use HTML_DIR::Controller::SearchDatabase;

ok( request('/searchdatabase')->is_success, 'Request should succeed' );
done_testing();
