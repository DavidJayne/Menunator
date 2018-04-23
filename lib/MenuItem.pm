package MenuItem;
use Class::Accessor 'antlers';

has label  => ( is => "rw", isa => "Str" );
has type   => ( is => "rw", isa => "Str" );
has x      => ( is => "rw", isa => "Int" );
has y      => ( is => "rw", isa => "Int" );
has height => ( is => "rw", isa => "Int" );

#sub new {
#    my $proto = shift;
#    my $class = ref $proto || $proto;
#    return $class;
#}



package MenuItem::Command;
use Class::Accessor 'antlers';
extends 'MenuItem';

has command => ( is => "rw", isa => "Str" );


1;


