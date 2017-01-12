use strict;
use warnings;

use TESTE;

my $app = TESTE->apply_default_middlewares(TESTE->psgi_app);
$app;

