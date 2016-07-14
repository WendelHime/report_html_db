use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Site';
use Site::Controller::GlobalAnalyses;

ok( request('/globalanalyses')->is_success, 'Request should succeed' );
done_testing();
