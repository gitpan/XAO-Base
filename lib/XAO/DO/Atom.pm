=head1 NAME

XAO::DO::Atom - recommended base object for all XAO dynamic objects

=head1 SYNOPSIS

Throwing an error from XAO object:

 throw $self "method - no 'foo' parameter";

=head1 DESCRIPTION

Provides some very basic functionality and common methods for all XAO
dynamic objects.

Atom (XAO::DO::Atom) was introduced in the release 1.03 mainly to
make error throwing uniform in all objects. There are many objects
currently not derived from Atom, but that will eventually change.

All new XAO dynamic object should use Atom as their base if they are not
already based on dynamic object.

=head1 METHODS

=over

=cut

###############################################################################
package XAO::DO::Atom;
use strict;
use XAO::Utils;
use XAO::Errors;

use vars qw($VERSION);
$VERSION=(0+sprintf('%u.%03u',(q$Id: Atom.pm,v 2.1 2005/01/13 22:34:34 am Exp $ =~ /\s(\d+)\.(\d+)\s/))) || die "Bad VERSION";

###############################################################################

=item new (%)

Generic new - just stores everything that it gets in a hash. Can be
overriden if an object uses something different then a hash as a base or
needs a different behavior.

=cut

sub new ($%) {
    my $proto=shift;
    my $self=merge_refs(get_args(\@_));
    bless $self,ref($proto) || $proto;
}

###############################################################################

=item throw ($)

Helps to write code like:

 sub foobar ($%) {
    my $self=shift;
    my $args=get_args(\@_);

    my $id=$args->{id} || throw $self "foobar - no 'id' given";
    ...
 }

It is recommended to always use text maessages af the following format:

 "function_name - error description starting from lowercase letter"

There is no need to print class name, it will be prepended to the front
of your error message automatically.

=cut

sub throw ($@) {
    my $self=shift;
    my $text=join('',@_);

    my $class;
    if(eval { $self->{objname} } && !$@) {
        $class='XAO::DO::' . $self->{objname};
    }
    else {
        $class=ref($self);
    }

    XAO::Errors->throw_by_class($class,$text);
}

###############################################################################
1;
__END__

=head1 EXPORTS

Nothing.

=head1 AUTHOR

Copyright (c) 2002 XAO, Inc.

Andrew Maltsev <am@xao.com>.

=head1 SEE ALSO

L<XAO::Objects>
