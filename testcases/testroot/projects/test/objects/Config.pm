package XAO::DO::Config;
use strict;
use XAO::Objects;
use base XAO::Objects->load(objname => 'Config', baseobj => 1);

sub init ($$) {
    my $self=shift;

    my $lc=XAO::Objects->new(objname => 'LocalConf', sitename => 'test');

    $self->embed('local' => $lc);

    $self->SUPER::init();
}

1;
