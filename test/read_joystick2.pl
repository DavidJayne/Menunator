#! /usr/bin/perl

use strict;
use warnings;

use SDL;
use SDL::Joystick;
use SDL::Event;
use SDL::Events;
use SDLx::App;
use SDLx::Text;

# create our main screen
#my $app = SDLx::App->new(
#    w            => 500,
#    h            => 500,
#    exit_on_quit => 1,
#    dt           => 0.02,
#    title        => 'SDLx Pong'
#);

print "Hat up    = " . SDL_HAT_UP . "\n";
print "Hat right = " . SDL_HAT_RIGHT . "\n";
print "Hat down  = " . SDL_HAT_DOWN . "\n";
print "Hat left  = " . SDL_HAT_LEFT . "\n";


my $app = SDLx::App->new(
    w            => 1280,
    h            => 720,
    exit_on_quit => 1,
    dt           => .1,
    min_t        => 0,
    title        => 'foo'
);

my $joystick = SDL::Joystick->new(0);
$app->update;
my $outp = SDLx::Text->new(
    font => 'font.ttf',
    size => 15
);


# handles events
$app->add_event_handler(
    sub {
        my ( $event, $app ) = @_;
        
        #if ( $event->type == SDL_JOYAXISMOTION ) {
        #    # drawOutput($joystick);
        #    #for my $axis (0 .. $joystick->num_axes() - 1) {
        #    #    printf "Axis %d = %d\n", $axis, $joystick->get_axis($axis) if ($joystick->get_axis($axis));
        #    #}
        #}
        #
        #if ( $event->type == SDL_JOYHATMOTION ) {
        #    for my $hat (0 .. $joystick->num_hats() - 1) {
        #        printf "Hat %d = %d\n", $hat, $joystick->get_hat($hat) if ($joystick->get_hat($hat));
        #    }
        #}
        #
        #if ( $event->type == SDL_JOYBUTTONDOWN ) {
        #    #print "Button\n";
        #    for my $btn (0 .. $joystick->num_buttons() - 1) {
        #        print "Button $btn pressed\n" if ($joystick->get_button($btn));
        #    }
        #}
        #
        if ($event->type == SDL_KEYDOWN) {
            print "Keyboard\n";
            if ( $event->key_sym == SDLK_ESCAPE ) {
                exit;
            }
        }
        
        if ($event->type == SDL_JOYHATMOTION) {
            if($event->jhat_value == SDL_HAT_UP) {
                print "Hat UP\n";
            }
            elsif($event->jhat_value == SDL_HAT_RIGHT) {
                print "Hat RIGHT\n";
            }
            elsif($event->jhat_value == SDL_HAT_DOWN) {
                print "Hat DOWN\n";
            }
            elsif($event->jhat_value == SDL_HAT_LEFT) {
                print "Hat LEFT\n";
            }
        }
        
        #if ( $event->type == SDL_HAT_UP ) {
        #    print "Hat UP\n";
        #}
        #if ( $event->type == SDL_HAT_RIGHT ) {
        #    print "Hat RIGHT\n";
        #}
        #if ( $event->type == SDL_HAT_DOWN ) {
        #    print "Hat DOWN\n";
        #}
        #if ( $event->type == SDL_HAT_LEFT ) {
        #    print "Hat LEFT\n";
        #}
        
        
        # if ( $event->type == SDL_KEYDOWN ) {
        #     if ( $event->key_sym == SDLK_UP ) {
        #         $player1->{v_y} = -2;
        #     }
        #     elsif ( $event->key_sym == SDLK_DOWN ) {
        #         $player1->{v_y} = 2;
        #     }
        # }
        # elsif ( $event->type == SDL_KEYUP ) {
        #     if (   $event->key_sym == SDLK_UP
        #         or $event->key_sym == SDLK_DOWN )
        #     {
        #         $player1->{v_y} = 0;
        #     }
        # }
    }
);

$app->add_move_handler(sub {
    my ($event, $app) = @_;
   
    my $num_axes    = $joystick->num_axes;
    my $num_hats    = $joystick->num_hats;
    my $num_buttons = $joystick->num_buttons;
    
    # first, we clear the screen
    $app->draw_rect( [ 0, 0, $app->w, $app->h ], 0x000000 );
    
    my $text = "Axes:\n";
    
    for (my $ax=0; $ax<$num_axes; $ax++) {
        $text .= sprintf "  Axis %d = %d\n", $ax, $joystick->get_axis($ax); 
    }
    
    $text .= "\nHats:\n";
    
    for (my $hat=0; $hat<$num_hats; $hat++) {
        $text .= sprintf "  Hat %d = %d\n", $hat, $joystick->get_hat($hat); 
    }
    
    $text .= "\nButtons:\n";
    
    for (my $btn=0; $btn<$num_buttons; $btn++) {
        $text .= sprintf "  Button %d = %s\n", $btn, ($joystick->get_button($btn)) ? 'ON' : 'OFF'; 
    }
    
    $outp->write_to($app, $text);
    $app->update;        
});

$app->run();

