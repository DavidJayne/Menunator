#! /usr/bin/perl

use strict;
use warnings;

use SDL;
use SDL::Event;
use SDL::Events;
use SDL::Joystick;
use SDL::Surface;
use SDL::Video;
use SDLx::App;
use SDLx::Surface;
use SDLx::Text;
use SDL::Mouse;  # just to hide the damn cursor?

use YAML::Syck;
use Data::Dumper;

# TODO: put in lib
use constant {
    MENU_UP_EVENT   => SDL_USEREVENT + 1,
    MENU_DOWN_EVENT => SDL_USEREVENT + 2,
    MENU_PICK_EVENT => SDL_USEREVENT + 3
};


# load config
my $config = LoadFile('config/main/main.yml');
my $menu   = LoadFile('config/menu/test.yml');

#print Dumper($config, $menu);

# set up app
my $app = SDLx::App->new(
    w            => 1280,
    h            => 720,
    exit_on_quit => 1,
    dt           => .1,
    min_t        => 0,
    title        => 'foo',
    #fullscreen   => 1
);

# our joystick object
# TODO: handle none
my $joystick = SDL::Joystick->new(0);


# DEBUG
printf "SDL_ASYNCBLIT = %d\n", SDL_ASYNCBLIT;
printf "SDL_SWSURFACE = %d\n", SDL_SWSURFACE;


# surfaces
my $menu_surface = SDLx::Surface->new(
    width=> 800, 
    height=>600, 
    #flags=> SDL_HWSURFACE, 
    #depth=>32
);


# menu text
my $menu_title = SDLx::Text->new(
    font  => $config->{menu_title}{font},
    size  => $config->{menu_title}{size},
    color => [255, 255, 255], #FIXME
    text  => $menu->{label} 
);

my $menu_item = SDLx::Text->new(
    font  => $config->{menu}{font},
    size  => $config->{menu}{size},
    color => [255, 255, 255], #FIXME
    #text  => 'foo' 
);


# custom events
my $event_menu_up = SDL::Event->new();
$event_menu_up->type(MENU_UP_EVENT);
my $event_menu_down = SDL::Event->new();
$event_menu_down->type(MENU_DOWN_EVENT);
my $event_menu_pick = SDL::Event->new();
$event_menu_pick->type(MENU_PICK_EVENT);



# selected menu item index
my $sel_item = 0;

### should be in show_handler
####

$app->add_event_handler(sub {
    my ( $event, $app ) = @_;
    
    if ($event->type == SDL_KEYDOWN) {
        print "Keyboard\n";
        if ( $event->key_sym == SDLK_ESCAPE ) {
            exit;
        }        
        elsif ( $event->key_sym == SDLK_UP) {
            SDL::Events::push_event($event_menu_up);
        }
        elsif ( $event->key_sym == SDLK_DOWN) {
            SDL::Events::push_event($event_menu_down);
        }
        elsif ( $event->key_sym == SDLK_RETURN) {
            SDL::Events::push_event($event_menu_pick);
        }
    }
    
    if ($event->type == MENU_UP_EVENT) {
        print "Menu Up Event\n";
        $sel_item--;
        if ($sel_item < 0) {
            $sel_item = @{$menu->{items}} - 1;
        }
        #update_menu();
    }
    
    if ($event->type == MENU_DOWN_EVENT) {
        print "Menu Down Event\n";
        $sel_item++;
        if ($sel_item == @{$menu->{items}}) {
            $sel_item = 0;
        }
        #update_menu();
    }
    
    if ($event->type == MENU_PICK_EVENT) {
        print "Menu Pick Event\n";
        
        printf "command: %s", $menu->{items}[$sel_item]{command};
        system $menu->{items}[$sel_item]{command}; 
 
    }
    
    if ($event->type == SDL_JOYHATMOTION) {
        if($event->jhat_value == SDL_HAT_UP) {
            SDL::Events::push_event($event_menu_up);
        }
        elsif($event->jhat_value == SDL_HAT_RIGHT) {
            #print "Hat RIGHT\n"; #DEBUG
        }
        elsif($event->jhat_value == SDL_HAT_DOWN) {
            SDL::Events::push_event($event_menu_down);
        }
        elsif($event->jhat_value == SDL_HAT_LEFT) {
            #print "Hat LEFT\n"; #DEBUG
        }
    }
    
});

sub update_menu {
    # clear the screen
    $menu_surface->draw_rect( [ 0, 0, $menu_surface->w, $menu_surface->h ], 0x000000FF );
    
    my ($curr_x, $curr_y) = (10, 10);
    
    $menu_title->write_xy($menu_surface, $curr_x, $curr_y);
    $curr_y += $config->{menu_title}{size} + $config->{menu_title}{vert_pad};
    
    for (my $i=0; $i<@{$menu->{items}}; $i++) {
        my $item = $menu->{items}[$i];
        $item->{label} = 'dir (TODO)' if ($item->{type} eq 'dir'); # TODO: handle dir type
        
        # TODO: track item x/y for hilight
        
        my $item_text = ($i == $sel_item) ? '* ' . $item->{label} : '  ' . $item->{label};

        $menu_item->write_xy($menu_surface, $curr_x, $curr_y, $item_text);
        $curr_y += $config->{menu}{size} + $config->{menu}{vert_pad};
    }
}

    
$app->add_show_handler(sub {
    my ($event, $app) = @_;
    
    # no mouse cursor
    SDL::Mouse::show_cursor(SDL_DISABLE);
    
    # clear the screen
    $app->draw_rect( [ 0, 0, $app->w, $app->h ], 0x000000 );
    
    update_menu();
    
    # draw layers
    $menu_surface->blit($app, [0,0,$menu_surface->w,$menu_surface->h], [10,10,0,0]);
    #$app->blit_by($menu_surface);
    
    #my ($curr_x, $curr_y) = (10, 10);
    #
    #$menu_title->write_xy($app, $curr_x, $curr_y);
    #$curr_y += $config->{menu_title}{size} + $config->{menu_title}{vert_pad};
    #
    #for (my $i=0; $i<@{$menu->{items}}; $i++) {
    #    my $item = $menu->{items}[$i];
    #    $item->{label} = 'dir (TODO)' if ($item->{type} eq 'dir'); # TODO: handle dir type
    #    
    #    my $item_text = ($i == $sel_item) ? '* ' . $item->{label} : '  ' . $item->{label};
    #
    #    $menu_item->write_xy($app, $curr_x, $curr_y, $item_text);
    #    $curr_y += $config->{menu}{size} + $config->{menu}{vert_pad};
    #}
    
    
    $menu_item->write_xy($app, 10, 500, $sel_item);
    
    $app->update;
});

$app->run();
