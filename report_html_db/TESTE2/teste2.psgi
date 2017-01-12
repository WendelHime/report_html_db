use strict;
use warnings;

use TESTE2;

my $app = TESTE2->apply_default_middlewares(TESTE2->psgi_app);
$app;

