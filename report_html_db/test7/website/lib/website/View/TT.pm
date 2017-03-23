package website::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
	TEMPLATE_EXTENSION	=>	'.tt',
	TIMER	=>	0,
	WRAPPER	=>	'website/_layout.tt',
	ENCODING	=>	'utf-8',
	render_die	=> 1,
);

=head1 NAME

website::View::TT - TT View for website

=head1 DESCRIPTION

TT View for website.

=head1 SEE ALSO

L<website>

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
