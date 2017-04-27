package website::Controller::Site;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

TESTE2::Controller::Site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

use base 'Catalyst::Controller::REST';
BEGIN { extends 'Catalyst::Controller::REST'; }

=head2 getHTMLContent
Method used to get HTML content from file by filepath
=cut

sub getHTMLContent : Path("/GetHTMLContent") : CaptureArgs(1) :
  ActionClass('REST') { }

sub getHTMLContent_GET {
	my ( $self, $c, $filepath ) = @_;
	if ( !$filepath and defined $c->request->param("filepath") ) {
		$filepath = $c->request->param("filepath");
	}
	if($filepath =~ m/\.\.\//) {
		$self->status_bad_request($c, message => "Invalid filepath");
	}
	use File::Basename;
	open( my $FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . $filepath );

	my $content = do { local $/; <$FILEHANDLER> };
	close($FILEHANDLER);
	standardStatusOk( $self, $c, $content );
}

=head2

Method used to return components used

=cut

sub getComponents : Path("/Components") : Args(0) :
  ActionClass('REST') { }

sub getComponents_GET {
	my ( $self, $c ) = @_;

	my $resultSet = $c->model('Basic::Component')->search(
		{},
		{
			order_by => {
				-asc => [qw/ component /]
			},
		}
	);

	my @list = ();
	while ( my $result = $resultSet->next ) {
		my %hash = ();
		$hash{id}        = $result->id;
		$hash{name}      = $result->name;
		$hash{component} = $result->component;
		if ( $result->filepath ne "" ) {
			$hash{filepath} = $result->filepath;
		}
		push @list, \%hash;
	}

	standardStatusOk( $self, $c, \@list );
}

=head2 searchContig

Method used to realize search by contigs, optional return a stretch or a reverse complement

=cut

sub searchContig : Path("/Contig") : CaptureArgs(4) :
  ActionClass('REST') { }

sub searchContig_GET {
	my ( $self, $c, $contig, $start, $end, $reverseComplement ) = @_;
	if ( !$contig and defined $c->request->param("contig") ) {
		$contig = $c->request->param("contig");
	}
	if ( !$start and defined $c->request->param("contigStart") ) {
		$start = $c->request->param("contigStart");
	}
	if ( !$end and defined $c->request->param("contigEnd") ) {
		$end = $c->request->param("contigEnd");
	}
	if ( !$reverseComplement
		and defined $c->request->param("revCompContig") )
	{
		$reverseComplement = $c->request->param("revCompContig");
	}

	use File::Basename;
	my $data     = "";
	my $sequence = $c->model('Basic::Sequence')->find($contig);

	open( my $FILEHANDLER,
		"<", dirname(__FILE__) . "/../../../root/" . $sequence->filepath );

	for my $line (<$FILEHANDLER>) {
		if ( !( $line =~ /^>\w+\n$/g ) ) {
			$data .= $line;
		}
	}
	close($FILEHANDLER);

	if ( $start && $end ) {
		$start += -1;
		$data = substr( $data, $start, ( $end - $start ) );
		$c->stash->{start}     = $start;
		$c->stash->{end}       = $end;
		$c->stash->{hadLimits} = 1;
	}
	if ( defined $reverseComplement ) {
		$data = formatSequence( reverseComplement($data) );
		$c->stash->{hadReverseComplement} = 1;
	}
	my $result = "";
	for ( my $i = 0 ; $i < length($data) ; $i += 60 ) {
		my $line = substr( $data, $i, 60 );
		$result .= "$line<br />";
	}

	my @list = ();
	my %hash = ();
	$hash{'geneID'} = $sequence->id;
	$hash{'gene'}   = $sequence->name;
	$hash{'contig'} = $result;

	push @list, \%hash;
	standardStatusOk( $self, $c, @list );
}

=head2 reverseComplement

Method used to return the reverse complement of a sequence

=cut

sub reverseComplement {
	my ($sequence) = @_;
	my $reverseComplement = reverse($sequence);
	$reverseComplement =~ tr/ACGTacgt/TGCAtgca/;
	return $reverseComplement;
}

=head2 formatSequence

Method used to format sequence

=cut

sub formatSequence {
    my $seq = shift;
    my $block = shift || 80;
    $seq =~ s/.{$block}/$&\n/gs;
    chomp $seq;
    return $seq;
}

=head2
Standard return of status ok
=cut

sub standardStatusOk {
	my ( $self, $c, $response, $total, $pageSize, $offset ) = @_;
	if (   ( defined $total || $total )
		&& ( defined $pageSize || $pageSize )
		&& ( defined $offset   || $offset ) )
	{
		my $pagedResponse = $c->model('PagedResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => $c->stats->elapsed,
			response    => $response,
			total       => $total,
			pageSize    => $pageSize,
			offset      => $offset,
		);
		$self->status_ok( $c, entity => $pagedResponse->pack(), );
	}
	else {
		my $baseResponse = $c->model('BaseResponse')->new(
			status_code => 200,
			message     => "Ok",
			elapsed_ms  => $c->stats->elapsed,
			response    => $response
		);
		$self->status_ok( $c, entity => $baseResponse->pack(), );
	}
}

=encoding utf8

=head1 AUTHOR

Wendel Hime L. Castro,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
