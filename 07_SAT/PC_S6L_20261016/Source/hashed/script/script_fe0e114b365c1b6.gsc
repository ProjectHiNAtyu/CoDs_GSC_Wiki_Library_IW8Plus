// script_fe0e114b365c1b6  (hash_0fe0e114b365c1b6.gscc) (size: 2225 Bytes / 0x8b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1caed32e (481219374)
// size ...... 2225 (0x8b1)
// includes .. 4   (offset: 0x85d)
// strings ... 3   (offset: 0x87d)
// dev strs .. 0   (offset: 0x8b1)
// exports ... 10  (offset: 0x42d)
// cseg ...... 0x78 + 0x3b5 (0x42d)
// imports ... 23  (offset: 0x5bd)
// animtree1 . 0   (offset: 0x8b1)
// animtree2 . 0   (offset: 0x8b1)
#using script_4ce55cfc81c444ad;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_telemetry;

#namespace namespace_6c5e4059c3f00303;

// Namespace namespace_6c5e4059c3f00303
// Params 0, eflags: 0x5
// Checksum 0xac3346e5, Offset: 0x96
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a8bd87855584e660", #"ztron_item", undefined, &init );
}

// Namespace namespace_6c5e4059c3f00303
// Params 0
// Checksum 0x57efafba, Offset: 0xbf
// Size: 0x5c
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"gem", #"use", &usegem );
    ztron_item::function_5844a9c240f7dc8d( #"gem", #"postspawnitem", &function_ad5f01fe70e9ffad );
    ztron_item::function_5844a9c240f7dc8d( #"gem", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
}

// Namespace namespace_6c5e4059c3f00303
// Params 4
// Checksum 0x2bb9ee6, Offset: 0x123
// Size: 0x27
function function_f1b5ce25161ea3cb( scriptable, count, positioningresults, spawnoptions )
{
    
}

// Namespace namespace_6c5e4059c3f00303
// Params 1, eflags: 0x4
// Checksum 0xf21578e8, Offset: 0x152
// Size: 0x88
function private usegem( params )
{
    item = params.scriptable;
    player = params.player;
    
    if ( item.inuse )
    {
        return;
    }
    
    if ( item.scale > 8.5 )
    {
        player ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_happy" ) );
    }
    
    player ztron_telemetry::pickupgem();
    item ztron_item::function_f580915d21ddba69( player, undefined, 2, &function_799e25f3799eedfc );
}

// Namespace namespace_6c5e4059c3f00303
// Params 1, eflags: 0x4
// Checksum 0x8f37782e, Offset: 0x1e2
// Size: 0x30
function private function_799e25f3799eedfc( item )
{
    if ( item getscriptableparthasstate( "body", "trail" ) )
    {
        item setscriptablepartstate( "body", "trail" );
    }
}

// Namespace namespace_6c5e4059c3f00303
// Params 1, eflags: 0x4
// Checksum 0xd280a2d8, Offset: 0x21a
// Size: 0x4a
function private function_2c983537c15e53e7( params )
{
    if ( isdefined( params.launchforce ) )
    {
        params.modelspinning = 0;
    }
    
    if ( !isdefined( params.scale ) )
    {
        params.scale = function_d28afb59911eacbe();
    }
    
    return params;
}

// Namespace namespace_6c5e4059c3f00303
// Params 0
// Checksum 0xd6691da3, Offset: 0x26d
// Size: 0x56
function function_d28afb59911eacbe()
{
    t = randomfloat( 1 );
    
    if ( t < 0.9 )
    {
        return randomfloatrange( 1, 2 );
    }
    
    if ( t < 0.98 )
    {
        return randomfloatrange( 1, 5 );
    }
    
    return randomfloatrange( 1, 10 );
}

// Namespace namespace_6c5e4059c3f00303
// Params 2, eflags: 0x4
// Checksum 0x55d501fc, Offset: 0x2cc
// Size: 0x101
function private function_ad5f01fe70e9ffad( item, params )
{
    if ( isdefined( item ) )
    {
        item function_b398682b38f521f5( 1 );
        item.scale = params.scale;
        
        if ( isdefined( params.overridestate ) && item getscriptableparthasstate( "body", params.overridestate ) )
        {
            item setscriptablepartstate( "body", params.overridestate );
        }
        
        if ( isdefined( params.launchforce ) )
        {
            item physicslaunchserver( item.origin, params.launchforce * 15 );
            
            if ( !params.var_e459ddc65dfcaf9d )
            {
                item thread function_1eebc767b7091a96();
            }
        }
        else if ( !params.var_e459ddc65dfcaf9d )
        {
            item notsolid();
        }
        
        if ( isdefined( params.var_94a6561aeb9877de ) )
        {
            item.scale = params.var_94a6561aeb9877de;
        }
    }
}

// Namespace namespace_6c5e4059c3f00303
// Params 0, eflags: 0x4
// Checksum 0x6ff68d5a, Offset: 0x3d5
// Size: 0x58
function private function_1eebc767b7091a96()
{
    self endon( #"death" );
    wait 0.1;
    
    while ( isdefined( self ) )
    {
        bodyid = self physics_getbodyid( 0 );
        linearvelocity = physics_getbodylinvel( bodyid );
        
        if ( length( linearvelocity ) == 0 )
        {
            self notsolid();
            break;
        }
        
        wait 0.1;
    }
}

