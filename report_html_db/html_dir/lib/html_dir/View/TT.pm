package html_dir::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
	TEMPLATE_EXTENSION	=>	'.tt',
	TIMER	=>	0,
	WRAPPER	=>	'html_dir/_layout.tt',
	ENCODING	=>	'utf-8',
	render_die	=> 1,
);

=head1 NAME

html_dir::View::TT - TT View for html_dir

=head1 DESCRIPTION

TT View for html_dir.

=head1 SEE ALSO

L<html_dir>

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;