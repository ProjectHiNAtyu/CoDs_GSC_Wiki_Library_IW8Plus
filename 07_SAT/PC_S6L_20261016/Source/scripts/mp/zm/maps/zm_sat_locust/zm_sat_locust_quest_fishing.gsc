// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_fishing.gsc  (hash_00f98fbfa0e7dab5.gscc) (size: 2110 Bytes / 0x83e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a3cb2c2 (1513927362)
// size ...... 2110 (0x83e)
// includes .. 7   (offset: 0x7ce)
// strings ... 4   (offset: 0x806)
// dev strs .. 0   (offset: 0x83e)
// exports ... 9   (offset: 0x3be)
// cseg ...... 0xb1 + 0x30d (0x3be)
// imports ... 23  (offset: 0x526)
// animtree1 . 0   (offset: 0x83e)
// animtree2 . 0   (offset: 0x83e)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_fergus;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_locust_quest_fishing;

// Namespace zm_sat_locust_quest_fishing
// Params 0, eflags: 0x5
// Checksum 0xb623fa89, Offset: 0xcf
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_ee6c8b2aae13c83", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_quest_fishing
// Params 0, eflags: 0x4
// Checksum 0x57b638a3, Offset: 0xfc
// Size: 0x25
function private pre_main()
{
    zm_quest::register_quest_step( #"hash_ee6c8b2aae13c83", #"collect_pole", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
}

// Namespace zm_sat_locust_quest_fishing
// Params 0, eflags: 0x4
// Checksum 0xc40eab62, Offset: 0x129
// Size: 0x26
function private post_main()
{
    zm_save::function_1f44a48caae2acbf();
    utility::flag_wait( "onStartGameTypeFinished" );
    level thread zm_quest::start_quest( #"hash_ee6c8b2aae13c83" );
}

// Namespace zm_sat_locust_quest_fishing
// Params 2, eflags: 0x4
// Checksum 0xbc847df6, Offset: 0x157
// Size: 0x79
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "quest_item_used", &function_61cc5423beb9936e );
    level callback::add( "fishing_barrel_used", &function_64de174215b37e3f );
    utility::flag_wait( #"fergus_collected" );
    level callback::remove( "quest_item_used", &function_61cc5423beb9936e );
    level callback::remove( "fishing_barrel_used", &function_64de174215b37e3f );
}

// Namespace zm_sat_locust_quest_fishing
// Params 2, eflags: 0x4
// Checksum 0xabbeeb7e, Offset: 0x1d8
// Size: 0x76
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"fergus_collected" );
        
        if ( zm_save::function_1dda3554974a999e() )
        {
            level thread function_b3be3f673f14b77a();
        }
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_set( #"collect_rod" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_fishing
// Params 1, eflags: 0x4
// Checksum 0xeaeaba49, Offset: 0x256
// Size: 0x61
function private function_61cc5423beb9936e( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_fergus" || params.bundle.scriptable == %"hash_2748f9c3ea15c1e8" )
    {
        utility::flag_set( #"fergus_collected" );
    }
}

// Namespace zm_sat_locust_quest_fishing
// Params 1, eflags: 0x4
// Checksum 0xbf966ab3, Offset: 0x2bf
// Size: 0x1c
function private function_64de174215b37e3f( params )
{
    utility::flag_set( #"fergus_collected" );
}

// Namespace zm_sat_locust_quest_fishing
// Params 0
// Checksum 0xfd6c38d9, Offset: 0x2e3
// Size: 0xdb
function function_b3be3f673f14b77a()
{
    level endon( #"game_ended", #"zm_game_over" );
    utility::flag_wait( "poles_initalized" );
    player = level.players[ 0 ];
    
    if ( player )
    {
        player zm_sat_locust_fergus::function_c58d10b4f34e8525( 1 );
    }
    
    if ( level.fishing_struct.rod_barrel.max_rods < 4 )
    {
        level.fishing_struct.rod_barrel.max_rods++;
    }
    
    poles = zm_sat_locust_util::get_quest_reference( #"pole_pickups" );
    
    /#
        sphere( poles[ 0 ].origin, 10, ( 0.5, 0, 1 ), 0, 600 );
    #/
    
    poles[ 0 ] freescriptable();
    zm_sat_locust_fergus::function_49218c16f4815e4();
}

