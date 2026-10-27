// script_7b6957e5b60154de  (hash_7b6957e5b60154de.gscc) (size: 1753 Bytes / 0x6d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a9c86a9 (1788642985)
// size ...... 1753 (0x6d9)
// includes .. 6   (offset: 0x659)
// strings ... 4   (offset: 0x689)
// dev strs .. 1   (offset: 0x6cd)
// exports ... 9   (offset: 0x2ed)
// cseg ...... 0xaa + 0x243 (0x2ed)
// imports ... 18  (offset: 0x455)
// animtree1 . 0   (offset: 0x6d9)
// animtree2 . 0   (offset: 0x6d9)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\br\gametypes\br_publicevent_restock;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\loot\common_cache;

#namespace namespace_8ed9a616485f9fc4;

// Namespace namespace_8ed9a616485f9fc4
// Params 0, eflags: 0x5
// Checksum 0x48420934, Offset: 0xc8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_72edf43c811c098d", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_8ed9a616485f9fc4
// Params 0, eflags: 0x4
// Checksum 0x9cced3d4, Offset: 0xf1
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_RESTOCK", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_RESTOCK" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_8ed9a616485f9fc4
// Params 1
// Checksum 0x3871dddc, Offset: 0x121
// Size: 0x1d
function function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.waitfunc = &br_publicevent_restock::waitfunc;
}

// Namespace namespace_8ed9a616485f9fc4
// Params 0
// Checksum 0x79629288, Offset: 0x146
// Size: 0x98
function activity_type_init()
{
    if ( getdvarint( @"hash_b3eed398e2f3e6ee", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_RESTOCK", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_RESTOCK", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_RESTOCK", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_RESTOCK", 3, &function_d4acef179eb9f9b2 );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "power_up_field_resupply" ] = "pblc_wzan_rsnd";
    
    if ( !isdefined( level.var_2005ea41919076c3 ) )
    {
        level.var_2005ea41919076c3 = [];
    }
}

// Namespace namespace_8ed9a616485f9fc4
// Params 0
// Checksum 0x1f0040bc, Offset: 0x1e6
// Size: 0x32
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_8ed9a616485f9fc4
// Params 0
// Checksum 0xc9ee3d84, Offset: 0x220
// Size: 0x62
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( isdefined( level.var_bf943822438e6731 ) )
    {
        [[ level.var_bf943822438e6731 ]]();
    }
    
    level notify( #"hash_aa13ffcae465668a" );
    thread common_cache::restockall( 1 );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_8ed9a616485f9fc4
// Params 1
// Checksum 0x7ad9c559, Offset: 0x28a
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_8ed9a616485f9fc4
// Params 0
// Checksum 0x11510b76, Offset: 0x2b8
// Size: 0x35
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( isdefined( level.var_4b64e57647ed45e9 ) )
    {
        [[ level.var_4b64e57647ed45e9 ]]();
    }
}

