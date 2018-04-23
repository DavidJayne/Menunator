use SDL;
use SDLx::App; 
use SDLx::Text;

my $app = SDLx::App->new;

my $message = SDLx::Text->new;

$message->write_to( $app, "Hello, World!" );
$message->write_to( $app, " Hello, World!" );
$message->write_to( $app, "  Hello,\nWorld!" );
$app->update;
#$app->run;
sleep(5);

