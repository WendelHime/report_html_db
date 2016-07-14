package Site::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION 	=> '.tt',
    TIMER				=> 0,
    WRAPPER				=> 'site/_layout.tt',
);

=head1 NAME

Site::View::TT - TT View for Site

=head1 DESCRIPTION

TT View for Site.

=head1 SEE ALSO

L<Site>

=head1 AUTHOR

Wendel Hime,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
