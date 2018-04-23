#! /usr/bin/perl

use lib './lib';

use strict;
use warnings;

use Data::Dumper;

use MenuItem;
use Menu;

my $itm1 = MenuItem->new({
    label => 'The Label',
    type  => 'foo'
});

print $itm1->label . "\n";
print $itm1->type . "\n\n";

my $itm2 = MenuItem::Command->new({
    label   => 'The Label',
    type    => 'foo',
    command => 'foo bar baz',
    foo     => 'bar'
});



print $itm2->label . "\n";
print $itm2->type . "\n";
print $itm2->command . "\n";
#print $itm2->foo . "\n\n";
print "\n";

my $mnu1 = Menu->new();
$mnu1->add_menu_item($itm1);
$mnu1->add_menu_item($itm2);

print Dumper($mnu1, $mnu1->items);
print Dumper($mnu1->items);



