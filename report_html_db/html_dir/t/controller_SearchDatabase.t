use strict;
use warnings;
use Test::More;


use Catalyst::Test 'html_dir';
use html_dir::Controller::SearchDatabase;

ok( request('/searchdatabase')->is_success, 'Request should succeed' );
done_testing();
