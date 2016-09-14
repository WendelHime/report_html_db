use strict;
use warnings;

use html_dir;

my $app = html_dir->apply_default_middlewares(html_dir->psgi_app);
$app;

