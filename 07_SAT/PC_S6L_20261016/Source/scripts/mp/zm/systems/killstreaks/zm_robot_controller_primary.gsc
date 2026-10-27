// scripts\mp\zm\systems\killstreaks\zm_robot_controller_primary.gsc  (hash_5de125a146ebcab7.gscc) (size: 1725 Bytes / 0x6bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0893171 (3230216561)
// size ...... 1725 (0x6bd)
// includes .. 9   (offset: 0x62d)
// strings ... 5   (offset: 0x675)
// dev strs .. 0   (offset: 0x6bd)
// exports ... 8   (offset: 0x2f1)
// cseg ...... 0x9f + 0x252 (0x2f1)
// imports ... 18  (offset: 0x431)
// animtree1 . 0   (offset: 0x6bd)
// animtree2 . 0   (offset: 0x6bd)
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\hud_message;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_glocke_drop;
#using scripts\mp\zm\systems\killstreaks\zm_robot_controller;

#namespace zm_robot_controller_primary;

// Namespace zm_robot_controller_primary
// Params 0, eflags: 0x5
// Checksum 0xaa7589fd, Offset: 0xbd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"zm_robot_controller_primary", #"zm_robot_controller", &pre_main, undefined );
}

// Namespace zm_robot_controller_primary
// Params 0, eflags: 0x4
// Checksum 0xd8a693cd, Offset: 0xe6
// Size: 0x17
function private pre_main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "zm_bernard_primary" ), &init );
}

// Namespace zm_robot_controller_primary
// Params 0, eflags: 0x4
// Checksum 0x6a028a4d, Offset: 0x105
// Size: 0x21
function private init()
{
    killstreaks::registerkillstreak( "zm_bernard_primary", &function_95593d8d1cb71405, undefined, undefined, &zm_robot_controller::function_8f305741152309b9 );
    data_init();
}

// Namespace zm_robot_controller_primary
// Params 0, eflags: 0x4
// Checksum 0x98462c35, Offset: 0x12e
// Size: 0xdc
function private data_init()
{
    bundle = level.streakglobals.streakbundles[ "zm_bernard_primary" ];
    contents = trace::create_contents( 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1 );
    searchradius = 172;
    radius = 115;
    height = 230;
    bundle.tacpointdata = { #height:height, #radius:radius, #searchradius:searchradius, #contents:contents };
    bundle.version = "primary";
    bundle.callbacks = [ "verify":&function_42ad13306c22d13c, "execute":&function_7fdbf35c700e57f0 ];
}

// Namespace zm_robot_controller_primary
// Params 1
// Checksum 0xc8a4f32f, Offset: 0x212
// Size: 0x27, Type: bool
function function_95593d8d1cb71405( streakinfo = killstreak_utility::createstreakinfo( "zm_bernard_primary", self ) )
{
    return zm_robot_controller::controller_use( streakinfo );
}

// Namespace zm_robot_controller_primary
// Params 1, eflags: 0x4
// Checksum 0xdb2dfdb7, Offset: 0x242
// Size: 0x76
function private function_7fdbf35c700e57f0( params )
{
    params.type = "delivery_loot";
    level callback::callback( #"hash_2767e511882e6794", params );
    params.drop = zm_sat_locust_glocke_drop::request_glocke_drop( params.position, params.from_position, params.type );
    level callback::callback( #"hash_2eec00c5f9affd9b", params );
}

// Namespace zm_robot_controller_primary
// Params 1, eflags: 0x4
// Checksum 0xf9b67123, Offset: 0x2c0
// Size: 0x30, Type: bool
function private function_42ad13306c22d13c( streakinfo )
{
    if ( !zm_sat_locust_glocke_drop::is_not_active() )
    {
        hud_message::showerrormessage( %"KILLSTREAKS/INVALID_POINT", undefined, 1 );
        return false;
    }
    
    return true;
}

