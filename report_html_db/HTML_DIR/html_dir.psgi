use strict;
use warnings;

use HTML_DIR;

my $app = HTML_DIR->apply_default_middlewares(HTML_DIR->psgi_app);
$app;

