package Catalyst::TraitFor::Request::Plack::Session;

# ABSTRACT: Easily access the current request's Plack session

use Moose::Role;
use namespace::autoclean;
use MooseX::AttributeShortcuts;

use Plack::Session;

=attr plack_session

A place to stash the session, if we've created it.

=method plack_session

Returns the L<Plack::Session> object for this request.  If necessary the
session object will be constructed.

=cut

has plack_session => (
    is  => 'lazy',
    isa => 'Plack::Session',
);

sub _build_plack_session { Plack::Session->new(shift->env) }

!!42;
__END__

=head1 SYNOPSIS

    # in your app class
    use CatalystX::RoleApplicator;
    __PACKAGE__->apply_request_class_roles(qw/
        Catalyst::TraitFor::Request::Plack::Session
    /);

    # then, off in an action/view/whatever somewhere...
    my $ps = $ctx->req->plack_session;

=head1 DESCRIPTION

This is a tiny little L<Catalyst::Request> class trait that allows easy,
lazy access to the L<Plack> session, on demand.

Note that for this to make any sense at all, you need to be using
L<Plack::Middleware::Session>.

=head1 SEE ALSO

L<Plack::Middleware::Session>

=cut
