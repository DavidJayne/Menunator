use SDL;
use SDL::Joystick;

# Initialize the joystick subsystem
SDL::init_sub_system(SDL_INIT_JOYSTICK);

# Check for joystick
if(SDL::Joystick::num_joysticks() > 0)
{
    # Open joystick
    my $joystick = SDL::Joystick->new(0);
    
    if($joystick)
    {
        printf("Opened Joystick 0\n");
        printf("Name: %s\n",              SDL::Joystick::name(0));
        printf("Number of Axes: %d\n",    $joystick->num_axes()); #SDL::Joystick::num_axes($joystick));
        printf("Number of Hats: %d\n",    $joystick->num_hats()); #SDL::Joystick::num_axes($joystick));
        printf("Number of Buttons: %d\n", SDL::Joystick::num_buttons($joystick));
        printf("Number of Balls: %d\n",   SDL::Joystick::num_balls($joystick));
    }
    else
    {
        printf("Couldn't open Joystick 0\n");
    }
    
    # Close if opened
    #SDL::Joystick::close($joystick) if SDL::Joystick::opened(0);
    #$joystick->close();
}

