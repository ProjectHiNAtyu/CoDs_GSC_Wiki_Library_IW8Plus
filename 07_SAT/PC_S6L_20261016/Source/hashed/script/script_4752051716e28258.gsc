// script_4752051716e28258  (hash_4752051716e28258.gscc) (size: 4998 Bytes / 0x1386 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbb70c549 (3144729929)
// size ...... 4998 (0x1386)
// includes .. 9   (offset: 0x126a)
// strings ... 16  (offset: 0x12b2)
// dev strs .. 0   (offset: 0x1386)
// exports ... 13  (offset: 0xafe)
// cseg ...... 0x19f + 0x95f (0xafe)
// imports ... 48  (offset: 0xd06)
// animtree1 . 0   (offset: 0x1386)
// animtree2 . 0   (offset: 0x1386)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_save;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_a1597a4eb2463645;

// Namespace namespace_a1597a4eb2463645
// Params 0, eflags: 0x5
// Checksum 0x39e52dd3, Offset: 0x1bd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c87eef636c6bb618", #"ztron_item", undefined, &init );
}

// Namespace namespace_a1597a4eb2463645
// Params 0
// Checksum 0x9bdf68b3, Offset: 0x1e6
// Size: 0x44
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"sawblade", #"use", &usesawblade );
    ztron_sound::function_4ac735395b173fe( "sawblade_on_lp", "evt_ztron_pickup_sawblade_active_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "sawblade_launch_OS", "evt_ztron_pickup_sawblade_lose_blade" );
}

// Namespace namespace_a1597a4eb2463645
// Params 2
// Checksum 0xbb2469b9, Offset: 0x232
// Size: 0x24
function function_cfa2b891bf9e311c( owner, duration )
{
    return int( owner ztron_player_utility::function_10777122eee28fa8( duration, 1 ) );
}

// Namespace namespace_a1597a4eb2463645
// Params 1
// Checksum 0xb044c11e, Offset: 0x25f
// Size: 0x52
function usesawblade( params )
{
    player = params.player;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    activatesawblade( player, itemdata.duration );
}

// Namespace namespace_a1597a4eb2463645
// Params 0
// Checksum 0x4040740b, Offset: 0x2b9
// Size: 0xf, Type: bool
function function_e9c72efb25768863()
{
    return self.lifetime ?? 0;
}

// Namespace namespace_a1597a4eb2463645
// Params 2
// Checksum 0xdf6c1038, Offset: 0x2d1
// Size: 0x3f
function function_1b8fb201ec59e85e( origin, angle )
{
    var_425eb565f5fdf9c4 = utility::spawn_model( "sat_zm_ztron_props_sawblade", origin, angle );
    var_425eb565f5fdf9c4 notsolid();
    var_425eb565f5fdf9c4 enablelinkto();
    return var_425eb565f5fdf9c4;
}

// Namespace namespace_a1597a4eb2463645
// Params 4
// Checksum 0xed3cb1b6, Offset: 0x319
// Size: 0x344, Type: bool
function activatesawblade( player, duration, storebought = 0, var_4f41655560136ded = 0 )
{
    donenote = ztron_util::function_86d9bcab81b0ff0d( "sawblade_done" );
    radius = 70;
    
    if ( player.ztron.upgradeMask & 32768 )
    {
        radius = int( radius * 2 );
    }
    
    blade_array = [];
    angle = ( 0, 180, 180 );
    var_425eb565f5fdf9c4 = function_1b8fb201ec59e85e( player.origin + ( radius, 0, 32 ), angle );
    
    if ( isdefined( var_425eb565f5fdf9c4 ) )
    {
        blade_array[ blade_array.size ] = var_425eb565f5fdf9c4;
    }
    
    if ( !var_4f41655560136ded )
    {
        duration = function_cfa2b891bf9e311c( player, duration );
    }
    
    var_425eb565f5fdf9c4.lifetime = duration;
    
    if ( storebought )
    {
        save = spawnstruct();
        save.ref = "ztron_store_sawblade_5min";
        save.entity = var_425eb565f5fdf9c4;
        save.var_c93abd0f18db7640 = &function_e9c72efb25768863;
        player thread ztron_save::function_70c11aca4f83fcda( save );
    }
    
    if ( player.ztron.upgradeMask & 32768 )
    {
        angle = ( 180, 180, 0 );
        var_f442e53bfd8cb802 = function_1b8fb201ec59e85e( player.origin + ( radius * -1, 0, 32 ), angle );
        
        if ( isdefined( var_f442e53bfd8cb802 ) )
        {
            blade_array[ blade_array.size ] = var_f442e53bfd8cb802;
        }
    }
    
    foreach ( var_425eb565f5fdf9c4 in blade_array )
    {
        trigger = spawn( "trigger_box", var_425eb565f5fdf9c4.origin, 0, ( 24, 10, 24 ), ( 24, 10, 24 ) );
        
        if ( isdefined( trigger ) )
        {
            trigger enablelinkto();
            trigger linkto( var_425eb565f5fdf9c4 );
            var_425eb565f5fdf9c4.trigger = trigger;
            trigger thread function_bb93c96db27a64a2( player, donenote );
            
            /#
                var_425eb565f5fdf9c4 thread function_48a9fe78bdd85c17( trigger, player, donenote );
            #/
            
            continue;
        }
        
        blade_array = arrayremove( blade_array, var_425eb565f5fdf9c4 );
        var_425eb565f5fdf9c4 delete();
    }
    
    if ( blade_array.size == 0 )
    {
        return false;
    }
    
    var_7c4d5294acdb33b4 = ztron_item::function_8b0c01e93664327d( player, "tag_origin", blade_array, 360 );
    var_7c4d5294acdb33b4.blade_count = blade_array.size;
    
    foreach ( var_425eb565f5fdf9c4 in blade_array )
    {
        player thread function_456dd2340d0acf25( var_425eb565f5fdf9c4, storebought, donenote, var_7c4d5294acdb33b4 );
    }
    
    player thread function_5f27aa19e6958bde( blade_array, duration, donenote );
    player thread sawbladevehiclewatcher( donenote, storebought );
    return true;
}

// Namespace namespace_a1597a4eb2463645
// Params 2, eflags: 0x4
// Checksum 0x35445e46, Offset: 0x666
// Size: 0x4c
function private sawbladevehiclewatcher( donenote, storebought = 0 )
{
    level endon( #"ztron_game_is_over" );
    self endon( donenote );
    self waittill( #"enter_vehicle" );
    
    if ( isdefined( self ) && !storebought )
    {
        self notify( donenote );
    }
}

// Namespace namespace_a1597a4eb2463645
// Params 2, eflags: 0x4
// Checksum 0x294295d9, Offset: 0x6ba
// Size: 0x17a
function private function_bb93c96db27a64a2( player, donenote )
{
    level endon( #"ztron_game_is_over" );
    player endon( donenote );
    player endon( #"disconnect" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", ent );
        
        if ( ent.var_280397aa85f15ab4 || ent.ztron.boss )
        {
            continue;
        }
        
        if ( isai( ent ) && ent.unittype == "zombie" )
        {
            time = gettime();
            
            if ( ent.var_4b2404973226fcf4 > time )
            {
                continue;
            }
            
            if ( !ent.nogib )
            {
                ent zombie_knockdown::function_6fc167d4a3590991( self.origin );
                ent namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
            }
            
            if ( randomint( 100 ) < 30 )
            {
                ent thread ztron_util::function_ea0a0be5c5468c48( randomfloatrange( 5, 10 ), player, "MOD_UNKNOWN" );
                ent dodamage( ent.maxhealth >> 1, ent.origin, player, self, "MOD_UNKNOWN" );
            }
            else
            {
                ent dodamage( ent.health, ent.origin, player, self, "MOD_UNKNOWN" );
            }
            
            ent.var_4b2404973226fcf4 = time + 1000;
        }
    }
}

// Namespace namespace_a1597a4eb2463645
// Params 3, eflags: 0x4
// Checksum 0xc59379b5, Offset: 0x83c
// Size: 0xd5
function private function_5f27aa19e6958bde( blade_array, time, donenote )
{
    self endon( donenote );
    self endon( #"disconnect" );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    while ( time > 0 )
    {
        wait 1;
        time--;
        
        foreach ( var_425eb565f5fdf9c4 in blade_array )
        {
            if ( var_425eb565f5fdf9c4.lifetime )
            {
                var_425eb565f5fdf9c4.lifetime--;
            }
        }
    }
    
    self notify( donenote );
}

// Namespace namespace_a1597a4eb2463645
// Params 4, eflags: 0x4
// Checksum 0x53762056, Offset: 0x919
// Size: 0x15e
function private function_456dd2340d0acf25( var_425eb565f5fdf9c4, storebought = 0, donenote, var_7c4d5294acdb33b4 )
{
    if ( storebought )
    {
        utility::waittill_any( donenote, "disconnect", "kill_shield", "death", "clear_active_item" );
    }
    else
    {
        utility::waittill_any( donenote, "kill_shield", "disconnect", "clone_shutdown", "death" );
    }
    
    self notify( donenote );
    ztron_sound::ztron_stopsound( var_425eb565f5fdf9c4 );
    waitframe();
    
    if ( isdefined( var_425eb565f5fdf9c4.trigger ) )
    {
        var_425eb565f5fdf9c4.trigger delete();
    }
    
    if ( isdefined( var_425eb565f5fdf9c4 ) )
    {
        ztron_item::function_21c3b4ab8aa7468d( [ var_425eb565f5fdf9c4 ] );
        var_7c4d5294acdb33b4.blade_count--;
        
        if ( var_7c4d5294acdb33b4.blade_count <= 0 )
        {
            ztron_item::function_39d7023e3666b11e( var_7c4d5294acdb33b4 );
        }
        
        var_425eb565f5fdf9c4 solid();
        vel = ( 0, 0, 20 );
        
        if ( isdefined( self ) )
        {
            targetpos = ( self.origin[ 0 ], self.origin[ 1 ], var_425eb565f5fdf9c4.origin[ 2 ] );
            vel = var_425eb565f5fdf9c4.origin - targetpos;
        }
        
        var_425eb565f5fdf9c4 physicslaunchserver( var_425eb565f5fdf9c4.origin, vel * 10 );
        wait 5;
        var_425eb565f5fdf9c4 delete();
    }
}

/#

    // Namespace namespace_a1597a4eb2463645
    // Params 3, eflags: 0x4
    // Checksum 0x3ce3515a, Offset: 0xa7f
    // Size: 0x7f, Type: dev
    function private function_48a9fe78bdd85c17( trigger, player, donenote )
    {
        level endon( #"ztron_game_is_over" );
        player endon( donenote );
        setdvarifuninitialized( @"scr_debug_draw_sawblade", 0 );
        
        while ( isdefined( trigger ) )
        {
            if ( getdvarint( @"scr_debug_draw_sawblade" ) )
            {
                drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
