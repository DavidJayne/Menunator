package Menu;
use Class::Accessor 'antlers';

use MenuItem;
use SDL::Surface;
use SDLx::Surface;

#has surface       => ( is => "ro" );
has items         => ( is => "ro" );
has selected_item => ( is => "rw" );
has x        => ( is => "rw", isa => "Int" );
has y        => ( is => "rw", isa => "Int" );
has height   => ( is => "rw", isa => "Int" );
has width    => ( is => "rw", isa => "Fart" );



sub new {
   my $class = shift @_;
   my $self = $class->SUPER::new(@_);
    
   $self->{selected_item} = 0;
   
   return $self;
}

sub load_yaml {
    my $self = shift;
        
}

sub add_menu_item {
    my $self = shift;
    
    my $itm = shift;
    
    # TODO: enforce type
    #printf "\$itm isa %s\n", ref $itm;
    
    push @{$self->{items}}, $itm;    
}

1;



