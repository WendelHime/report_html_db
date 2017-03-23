use strict;
use warnings;

use services;

my $app = services->apply_default_middlewares(services->psgi_app);
$app;

