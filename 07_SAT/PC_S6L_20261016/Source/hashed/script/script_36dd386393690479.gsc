// script_36dd386393690479  (hash_36dd386393690479.gscc) (size: 1922 Bytes / 0x782 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37d5135f (936711007)
// size ...... 1922 (0x782)
// includes .. 2   (offset: 0x772)
// strings ... 0   (offset: 0x782)
// dev strs .. 0   (offset: 0x782)
// exports ... 4   (offset: 0x576)
// cseg ...... 0x58 + 0x51e (0x576)
// imports ... 7   (offset: 0x616)
// animtree1 . 0   (offset: 0x782)
// animtree2 . 0   (offset: 0x782)
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_d1fe2cfd7c2279e7;

// Namespace namespace_d1fe2cfd7c2279e7
// Params 0, eflags: 0x1
// Checksum 0xe5827038, Offset: 0x76
// Size: 0x82
function autoexec preinit()
{
    gametypexhash = getxhash( game_utility::getgametype() );
    
    if ( gametypexhash == #"sd" || gametypexhash == #"hc_sd" || gametypexhash == #"skirmish" )
    {
        if ( !utility::issharedfuncdefined( #"gametype", #"hash_e14c1978f1b4a97d", 0 ) )
        {
            utility::registersharedfunc( #"gametype", #"hash_e14c1978f1b4a97d", &function_d91937e8eed13806 );
        }
    }
}

// Namespace namespace_d1fe2cfd7c2279e7
// Params 1
// Checksum 0x46f1e16f, Offset: 0x100
// Size: 0x15
function function_d91937e8eed13806( isplanting )
{
    thread function_9e7f06255372863e( isplanting );
}

// Namespace namespace_d1fe2cfd7c2279e7
// Params 1
// Checksum 0x1215bb47, Offset: 0x11d
// Size: 0x459
function function_9e7f06255372863e( isplanting )
{
    self endon( #"death_or_disconnect", #"hash_2bd3c16fbd14b0bd" );
    self setscriptablepartstate( #"sd_bomb_screen_lock", #"unlock" );
    self setscriptablepartstate( #"sd_bomb_small_screen", #"standby" );
    wait 0.3;
    self setscriptablepartstate( #"sd_bomb_screen_lock", #"lock" );
    wait 0.3;
    self setscriptablepartstate( #"sd_bomb_screen_arm", #"off" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"default" );
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    
    if ( isplanting )
    {
        self setscriptablepartstate( #"sd_bomb_small_screen", #"standby" );
    }
    else
    {
        self setscriptablepartstate( #"sd_bomb_small_screen", #"on" );
    }
    
    wait 0.6;
    
    if ( isplanting )
    {
        self setscriptablepartstate( #"sd_bomb_small_screen", #"on" );
    }
    else
    {
        self setscriptablepartstate( #"sd_bomb_small_screen", #"standby" );
    }
    
    wait 0.6;
    self setscriptablepartstate( #"sd_bomb_screen_lock", #"unlock" );
    wait 0.6;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_1" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_1" );
    wait 0.15;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    wait 0.2;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_9" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_2" );
    wait 0.15;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    wait 0.3;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_0" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_3" );
    wait 0.15;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    wait 0.22;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_4" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_4" );
    wait 0.15;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    wait 0.2;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_9" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_5" );
    wait 0.15;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    wait 0.2;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_6" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_6" );
    wait 0.15;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    wait 0.12;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_6" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_7" );
    wait 0.15;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    wait 0.2;
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"press_7" );
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"press_8" );
    wait 0.05;
    self setscriptablepartstate( #"sd_bomb_screen_planting", #"hide" );
    
    if ( isplanting )
    {
        self setscriptablepartstate( #"sd_bomb_screen_arm", #"planted" );
    }
    else
    {
        self setscriptablepartstate( #"sd_bomb_screen_arm", #"disarmed" );
    }
    
    self setscriptablepartstate( #"sd_bomb_buttons_planting", #"default" );
    self setscriptablepartstate( #"sd_bomb_screen_lock", #"hide" );
}

