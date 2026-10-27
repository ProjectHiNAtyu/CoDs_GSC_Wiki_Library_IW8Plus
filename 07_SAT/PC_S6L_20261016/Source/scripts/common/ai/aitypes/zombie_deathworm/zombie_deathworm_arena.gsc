// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_arena.gsc  (hash_1187904f70bad0ea.gscc) (size: 5128 Bytes / 0x1408 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53fcca78 (1409075832)
// size ...... 5128 (0x1408)
// includes .. 3   (offset: 0x1314)
// strings ... 7   (offset: 0x132c)
// dev strs .. 11  (offset: 0x1384)
// exports ... 18  (offset: 0xbe4)
// cseg ...... 0xfa + 0xaea (0xbe4)
// imports ... 37  (offset: 0xeb4)
// animtree1 . 0   (offset: 0x1408)
// animtree2 . 0   (offset: 0x1408)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace namespace_473bdc208d3e708a;

// Namespace namespace_473bdc208d3e708a
// Params 1
// Checksum 0xc885833, Offset: 0x118
// Size: 0x6f
function init_arena_precache( aitypescriptbundle )
{
    if ( utility::flag( "deathworm_arena_precache_init" ) )
    {
        return;
    }
    
    utility::flag_set( "deathworm_arena_precache_init" );
    process_arena_structs();
    level.var_28dd04f9f480d5b1 = getnoentvolumearray( "deathworm_exclude_unburrow", #script_noteworthy );
    level.var_6c7067692ba0c727 = getnoentvolumearray( "deathworm_exclude_melee", #script_noteworthy );
    
    /#
        level thread function_dbf49c34a49c13e8();
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x9392ff6f, Offset: 0x18f
// Size: 0xa6
function function_b99d9c9e039f92b0()
{
    var_a0ea22c4dcbee483 = function_73c9382b02f4adc( self.origin );
    
    if ( !isdefined( var_a0ea22c4dcbee483 ) )
    {
        level.arena_id_count++;
        var_a0ea22c4dcbee483 = { #var_acbda1a613de7dcb:level.arena_id_count, #radius:2000, #origin:self.origin };
        level.worm_arena_structs[ level.worm_arena_structs.size ] = var_a0ea22c4dcbee483;
        level.var_4398231e0c7c7480[ level.arena_id_count ] = [ var_a0ea22c4dcbee483 ];
    }
    
    set_home_arena( var_a0ea22c4dcbee483 );
    
    /#
        init_deathworm_arena_devgui();
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x515013b4, Offset: 0x23d
// Size: 0x34
function get_home_pos()
{
    assert( isdefined( self.var_bd1f15490f7391d.origin ) );
    return self.var_bd1f15490f7391d.origin;
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0xe0f44fac, Offset: 0x27a
// Size: 0x34
function get_home_radius()
{
    assert( isdefined( self.var_bd1f15490f7391d.radius ) );
    return self.var_bd1f15490f7391d.radius;
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x5a40121f, Offset: 0x2b7
// Size: 0x34
function get_home_arena_id()
{
    assert( isdefined( self.var_bd1f15490f7391d.var_acbda1a613de7dcb ) );
    return self.var_bd1f15490f7391d.var_acbda1a613de7dcb;
}

// Namespace namespace_473bdc208d3e708a
// Params 1
// Checksum 0xe7043d94, Offset: 0x2f4
// Size: 0x45
function set_home_arena( var_a0ea22c4dcbee483 )
{
    assert( isdefined( var_a0ea22c4dcbee483.origin ) );
    assert( isdefined( var_a0ea22c4dcbee483.radius ) );
    self.var_bd1f15490f7391d = var_a0ea22c4dcbee483;
}

// Namespace namespace_473bdc208d3e708a
// Params 1
// Checksum 0x57ae9875, Offset: 0x341
// Size: 0x8a, Type: bool
function function_9073d5c7012a71b6( pos )
{
    foreach ( volume in level.var_28dd04f9f480d5b1 )
    {
        if ( ispointinvolume( pos, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_473bdc208d3e708a
// Params 1
// Checksum 0x6fc0dce3, Offset: 0x3d4
// Size: 0x8a, Type: bool
function function_c1592b3e647c3368( pos )
{
    foreach ( volume in level.var_6c7067692ba0c727 )
    {
        if ( ispointinvolume( pos, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_473bdc208d3e708a
// Params 1
// Checksum 0xb8e4eee7, Offset: 0x467
// Size: 0xaf
function function_73c9382b02f4adc( pos )
{
    foreach ( var_a0ea22c4dcbee483 in level.worm_arena_structs )
    {
        dist_sq = distancesquared( var_a0ea22c4dcbee483.origin, pos );
        
        if ( dist_sq < squared( var_a0ea22c4dcbee483.radius ) )
        {
            return var_a0ea22c4dcbee483;
        }
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x189e4ed0, Offset: 0x51f
// Size: 0x102
function function_933a125e28cb04b5()
{
    self endon( #"death" );
    
    while ( utility::ent_flag( "is_underground" ) )
    {
        var_acbda1a613de7dcb = get_home_arena_id();
        
        if ( level.var_4398231e0c7c7480[ var_acbda1a613de7dcb ].size <= 1 )
        {
            return;
        }
        
        best_arena_struct = undefined;
        var_9c934b9e29e875f8 = -1;
        
        foreach ( var_a0ea22c4dcbee483 in level.var_4398231e0c7c7480[ var_acbda1a613de7dcb ] )
        {
            influence = getplayerinfluenceatposition( var_a0ea22c4dcbee483.origin, 1 );
            
            if ( influence > var_9c934b9e29e875f8 )
            {
                var_9c934b9e29e875f8 = influence;
                best_arena_struct = var_a0ea22c4dcbee483;
            }
            
            waitframe();
        }
        
        set_home_arena( best_arena_struct );
        waitframe();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0xb57c11d5, Offset: 0x629
// Size: 0xbe
function process_arena_structs()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    level.var_4398231e0c7c7480 = [];
    level.worm_arena_structs = [];
    var_a1cf66f177d17bd0 = utility::getstructarray( "deathworm_arena", "script_noteworthy" );
    level.arena_id_count = 0;
    
    foreach ( var_a0ea22c4dcbee483 in var_a1cf66f177d17bd0 )
    {
        function_8d188c61de6a181( var_a0ea22c4dcbee483 );
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 1
// Checksum 0xf385c08d, Offset: 0x6ef
// Size: 0xe8
function function_8d188c61de6a181( var_a0ea22c4dcbee483 )
{
    if ( !isdefined( var_a0ea22c4dcbee483 ) )
    {
        level.arena_id_count++;
        return level.arena_id_count;
    }
    
    if ( isdefined( var_a0ea22c4dcbee483.var_acbda1a613de7dcb ) )
    {
        return var_a0ea22c4dcbee483.var_acbda1a613de7dcb;
    }
    
    var_ed92d3edd3eded9 = undefined;
    
    if ( isdefined( var_a0ea22c4dcbee483.target ) )
    {
        var_ed92d3edd3eded9 = utility::getstruct( var_a0ea22c4dcbee483.target, "targetname" );
    }
    
    var_acbda1a613de7dcb = function_8d188c61de6a181( var_ed92d3edd3eded9 );
    var_a0ea22c4dcbee483.var_acbda1a613de7dcb = var_acbda1a613de7dcb;
    
    if ( !isdefined( level.var_4398231e0c7c7480[ var_acbda1a613de7dcb ] ) )
    {
        level.var_4398231e0c7c7480[ var_acbda1a613de7dcb ] = [];
    }
    
    level.var_4398231e0c7c7480[ var_acbda1a613de7dcb ][ level.var_4398231e0c7c7480[ var_acbda1a613de7dcb ].size ] = var_a0ea22c4dcbee483;
    level.worm_arena_structs[ level.worm_arena_structs.size ] = var_a0ea22c4dcbee483;
    return var_acbda1a613de7dcb;
}

/#

    // Namespace namespace_473bdc208d3e708a
    // Params 0
    // Checksum 0xf0464fb9, Offset: 0x7e0
    // Size: 0x2e, Type: dev
    function init_deathworm_arena_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x40>", "<dev string:x4c>", &toggle_debug_arena );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x6d923d71, Offset: 0x816
    // Size: 0x16, Type: dev
    function private function_6092041cbc2ec025()
    {
        return getdvarint( @"deathworm_debug_arena", 0 ) > 0;
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x1a53df6d, Offset: 0x834
    // Size: 0x1a, Type: dev
    function private toggle_debug_arena()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x5d>", @"deathworm_debug_arena" );
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 2, eflags: 0x4
    // Checksum 0xed6d16fb, Offset: 0x856
    // Size: 0x5b, Type: dev
    function private function_ab638dc78621c131( text, pos )
    {
        if ( function_6092041cbc2ec025() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x73>" + text, ( 1, 0, 0 ) );
        }
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x2b9c16a9, Offset: 0x8b9
    // Size: 0x32b, Type: dev
    function private function_dbf49c34a49c13e8()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( !function_6092041cbc2ec025() )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( level.players[ 0 ] ) )
            {
                waitframe();
                continue;
            }
            
            var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x85>" );
            
            if ( isdefined( var_f39d8960915f9a15 ) )
            {
                var_793675ba2ccf7f79 = ( 0, 0.5, 1 );
                utility::draw_circle( var_f39d8960915f9a15 get_home_pos(), var_f39d8960915f9a15 get_home_radius(), var_793675ba2ccf7f79, 1, 1, 1 );
                sphere( var_f39d8960915f9a15 get_home_pos(), 100, var_793675ba2ccf7f79, 1, 1 );
                print3d( var_f39d8960915f9a15 get_home_pos(), "<dev string:x96>", var_793675ba2ccf7f79 );
                var_aaf3810410e21411 = ( 1, 0.2, 0.2 );
                sphere( var_f39d8960915f9a15.worm_underground_ent.origin, 30, var_aaf3810410e21411, 1, 1 );
                print3d( var_f39d8960915f9a15.worm_underground_ent.origin + ( 0, 0, -10 ), "<dev string:xab>", var_aaf3810410e21411, 0.8, 0.5 );
            }
            
            foreach ( var_a0ea22c4dcbee483 in level.worm_arena_structs )
            {
                var_793675ba2ccf7f79 = ( 0.2, 0.5, 0.8 );
                
                if ( isdefined( var_a0ea22c4dcbee483.radius ) )
                {
                    influence = getplayerinfluenceatposition( var_a0ea22c4dcbee483.origin, 1 );
                    utility::draw_circle( var_a0ea22c4dcbee483.origin, var_a0ea22c4dcbee483.radius, var_793675ba2ccf7f79, 0.7, 1, 1 );
                    sphere( var_a0ea22c4dcbee483.origin, 50, var_793675ba2ccf7f79, 1, 1 );
                    print3d( var_a0ea22c4dcbee483.origin, "<dev string:xc7>" + var_a0ea22c4dcbee483.var_acbda1a613de7dcb + "<dev string:xdd>" + influence, var_793675ba2ccf7f79, 0.7 );
                }
            }
            
            foreach ( var_790844c409a3f2c3 in level.var_28dd04f9f480d5b1 )
            {
                orientedbox( var_790844c409a3f2c3.origin, ( 20, 20, 20 ), var_790844c409a3f2c3.angles, ( 1, 0, 0 ), 1, 1 );
                print3d( var_790844c409a3f2c3.origin, "<dev string:xee>", ( 1, 0, 0 ), 0.7, 0.5 );
            }
            
            waitframe();
        }
    }

#/
