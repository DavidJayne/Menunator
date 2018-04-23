#! /usr/bin/perl

use strict;
use warnings;

use SDL;
use SDL::Joystick;
use SDL::Event;
use SDL::Events;
use SDLx::App;

# create our main screen
#my $app = SDLx::App->new(
#    w            => 500,
#    h            => 500,
#    exit_on_quit => 1,
#    dt           => 0.02,
#    title        => 'SDLx Pong'
#);

my $app = SDLx::App->new(
    w            => 500,
    h            => 500,
    exit_on_quit => 1,
    dt           => 1,
    min_t        => 0,
    title        => 'foo'
);

my $joystick = SDL::Joystick->new(0);
my $num_buttons = $joystick->num_buttons();
my $num_axes = $joystick->num_axes();


# handles events
$app->add_event_handler(
    sub {
        my ( $event, $app ) = @_;
        
        if ( $event->type == SDL_JOYAXISMOTION ) {
            for my $axis (0 .. $joystick->num_axes() - 1) {
                printf "Axis %d = %d\n", $axis, $joystick->get_axis($axis) if ($joystick->get_axis($axis));
            }
        }
        
        if ( $event->type == SDL_JOYHATMOTION ) {
            for my $hat (0 .. $joystick->num_hats() - 1) {
                printf "Hat %d = %d\n", $hat, $joystick->get_hat($hat) if ($joystick->get_hat($hat));
            }
        }
        
        if ( $event->type == SDL_JOYBUTTONDOWN ) {
            #print "Button\n";
            for my $btn (0 .. $joystick->num_buttons() - 1) {
                print "Button $btn pressed\n" if ($joystick->get_button($btn));
            }
        }
        
        if ( $event->type == SDL_KEYDOWN ) {
            print "Keyboard\n";
        }
        
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

$app->run();
