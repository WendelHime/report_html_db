package TESTE2::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
	TEMPLATE_EXTENSION	=>	'.tt',
	TIMER	=>	0,
	WRAPPER	=>	'teste2/_layout.tt',
	ENCODING	=>	'utf-8',
);

=head1 NAME

TESTE2::View::TT - TT View for TESTE2

=head1 DESCRIPTION

TT View for TESTE2.

=head1 SEE ALSO

L<TESTE2>

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
