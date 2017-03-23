use strict;
use warnings;

use website;

my $app = website->apply_default_middlewares(website->psgi_app);
$app;

