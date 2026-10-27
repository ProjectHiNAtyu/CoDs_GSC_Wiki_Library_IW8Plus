// script_2b352aad1f80b92  (hash_02b352aad1f80b92.gscc) (size: 28259 Bytes / 0x6e63 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2934ca46 (691325510)
// size ...... 28259 (0x6e63)
// includes .. 18  (offset: 0x6607)
// strings ... 104 (offset: 0x6697)
// dev strs .. 15  (offset: 0x6daf)
// exports ... 41  (offset: 0x493f)
// cseg ...... 0x77c + 0x41c3 (0x493f)
// imports ... 166 (offset: 0x4fa7)
// animtree1 . 0   (offset: 0x6e63)
// animtree2 . 0   (offset: 0x6e63)
#using script_16ea1b94f0f381b3;
#using script_38234c6dc0321d2a;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace namespace_9972523f9872e5a4;

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0x8e309fa8, Offset: 0x79a
// Size: 0x79
function private function_2e563ff1483f0c39( save_index, flag_value )
{
    value = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_e0f1dfd9209666a6" ) ?? 0;
    
    if ( flag_value == 1 )
    {
        value = utility::set_bit_flag( value, save_index );
    }
    else
    {
        value = utility::function_911d2d3c6d773726( value, save_index );
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_e0f1dfd9209666a6", value );
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x440af93f, Offset: 0x81b
// Size: 0x41, Type: bool
function private function_a33bd7dd9039f692( save_index )
{
    value = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_e0f1dfd9209666a6" ) ?? 0;
    return utility::get_bit_flag( value, save_index ) ?? 0;
}

// Namespace namespace_9972523f9872e5a4
// Params 0
// Checksum 0x6f7ad271, Offset: 0x865
// Size: 0x585
function setup_veytharion_puzzle()
{
    level namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"open_hidden_room", &function_28ceefcedd6c5cff );
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "begin_round_logic" );
    level thread function_38a6222ef07dc6d6( "vt_hr_offer_light", 0 );
    level.var_f4f0b61b1640b63 = spawnstruct();
    level.var_f4f0b61b1640b63.a_cubes = [];
    s_switch = utility::getstruct( "tmp_v_go_button" );
    level.var_f4f0b61b1640b63.scr_switch = spawnscriptable( %"hash_27390420a8e454b1", s_switch.origin, s_switch.angles );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level callback::add( #"hash_fdb7c9b3f46244da", &function_a26bff79822c02eb );
        level callback::add( "on_round_start", &function_b73edeedad956f71 );
    }
    
    a_icons = [ "hand", "fire", "water", "life" ];
    a_s_cubes = utility::getstructarray( "tmp_v_cube" );
    
    /#
        if ( getdvarint( @"hash_e888c9fdc9ffdf08" ) )
        {
            a_s_cubes = utility::getstructarray( "<dev string:x24>" );
        }
    #/
    
    foreach ( cube in a_s_cubes )
    {
        scriptable = spawnscriptable( %"hash_7c61731d806acd63", cube.origin, cube.angles );
        interaction::register_scriptable_interact( scriptable, &cube_interact );
        var_a1179bfbbe57a3f7 = utility::array_random( a_icons );
        a_icons = arrayremove( a_icons, var_a1179bfbbe57a3f7 );
        scriptable.s_home = cube;
        scriptable.var_7be3d52e21910f39 = var_a1179bfbbe57a3f7;
        scriptable setscriptablepartstate( "model", scriptable.var_7be3d52e21910f39 );
        level.var_f4f0b61b1640b63.a_cubes[ level.var_f4f0b61b1640b63.a_cubes.size ] = scriptable;
    }
    
    level thread function_18e91bd433a1ca83();
    s_vessel = utility::getstruct( "tmp_v_vessel" );
    var_d9b4e2d18be02353 = utility::getstruct( s_vessel.target );
    level.var_f4f0b61b1640b63.mdl_vessel = utility::spawn_model( %"hash_6ae1bf89bd3b877c", s_vessel.origin, s_vessel.angles );
    level.var_f4f0b61b1640b63.mdl_vessel.s_left = s_vessel;
    level.var_f4f0b61b1640b63.mdl_vessel.s_right = var_d9b4e2d18be02353;
    level.var_f4f0b61b1640b63.mdl_vessel.a_cubes = [];
    var_cc9dbb3fbaaec44e = utility::getstruct( "tmp_v_interact_left" );
    level.var_f4f0b61b1640b63.interact = zm_quest::function_91f9590e98d57ff6( var_cc9dbb3fbaaec44e, &function_94fc7e843370125a, undefined, "hidden" );
    level.var_f4f0b61b1640b63.interact.angles = var_cc9dbb3fbaaec44e.angles;
    level.var_f4f0b61b1640b63.interact.side = "left";
    level.var_f4f0b61b1640b63.var_47fc666b426f4a73 = getent( "tmp_ground_2", "targetname" ).origin;
    
    /#
        function_68aeb41a854a3fe6();
    #/
    
    level zm_save::function_1f44a48caae2acbf();
    
    if ( function_a33bd7dd9039f692( 0 ) )
    {
        a_all_slots = utility::getstructarray( "tmp_v_block_slot_right" );
        var_cd7128c5bc666b1 = [ "water", "life", "hand", "fire" ];
        
        foreach ( i, var_9b19a902922a31d4 in a_all_slots )
        {
            foreach ( cube in level.var_f4f0b61b1640b63.a_cubes )
            {
                if ( cube.var_7be3d52e21910f39 == var_cd7128c5bc666b1[ i ] )
                {
                    next_cube = cube;
                    break;
                }
            }
            
            next_cube.origin = var_9b19a902922a31d4.origin;
            next_cube.angles = var_9b19a902922a31d4.angles;
            next_cube setscriptablepartstate( "usable", "off" );
        }
        
        function_596128becdf13eca( 1 );
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 0, eflags: 0x4
// Checksum 0x9195b7c5, Offset: 0xdf2
// Size: 0xb5
function private function_18e91bd433a1ca83()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player hasperk( "specialty_death_perception" ) )
            {
                player setclientomnvar( "te_cu_vis", 1 );
                continue;
            }
            
            player setclientomnvar( "te_cu_vis", 0 );
        }
        
        wait 1;
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x7ba70032, Offset: 0xeaf
// Size: 0x1c4
function private cube_interact( player )
{
    if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 0 ) )
    {
        return;
    }
    
    self notify( #"cube_active" );
    
    /#
        iprintlnbold( self.var_7be3d52e21910f39 );
    #/
    
    player val::set( "cubin", "weapon", 0 );
    self setscriptablepartstate( "usable", "off" );
    self setscriptablepartstate( "model", self.var_7be3d52e21910f39 + "_glow" );
    
    if ( !self.e_linker )
    {
        self.e_linker = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self scriptablesetparententity( self.e_linker );
    }
    
    self.e_linker playsoundonmovingent( "evt_scarab_mq_cubepuzzle_cube_pickup" );
    
    while ( player usebuttonpressed() && namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 0 ) && !istrue( self.off ) )
    {
        var_247d22c685c1b9db = anglestoforward( player getplayerangles() );
        v_offset = player geteye() + var_247d22c685c1b9db * 40;
        trace_results = trace::ray_trace( player geteye(), v_offset, undefined, undefined, undefined, undefined, undefined, [ self ] );
        
        if ( trace_results[ "fraction" ] < 0.98 )
        {
            v_offset = trace_results[ "position" ] - var_247d22c685c1b9db * 6;
        }
        
        self.e_linker moveto( v_offset, 0.1 );
        self.e_linker rotateto( player getplayerangles( 1 ) + ( 0, 180, 0 ), 0.1 );
        waitframe();
    }
    
    if ( isdefined( player ) )
    {
        player val::reset( "cubin", "weapon" );
    }
    
    drop_cube( self, player );
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0x5ab70f0f, Offset: 0x107b
// Size: 0x29e
function private drop_cube( cube, player )
{
    if ( cube.off )
    {
        return;
    }
    
    if ( function_ab58d7936bf8d2df( cube ) )
    {
        return;
    }
    
    cube setscriptablepartstate( "model", cube.var_7be3d52e21910f39 );
    cube.e_linker playsoundonmovingent( "evt_scarab_mq_cubepuzzle_cube_putdown" );
    
    if ( player )
    {
        v_dir = player getvelocity() / 2;
    }
    
    if ( !isdefined( contents ) )
    {
        contents = trace::create_default_contents( 1 );
    }
    
    v_cube = cube.e_linker.origin + ( v_dir ?? ( 0, 0, 0 ) );
    v_nav = utility::function_5918594658d3ffba( v_cube, 0, -512, 48, contents );
    
    if ( !v_nav && player )
    {
        v_nav = utility::function_5918594658d3ffba( player.origin, 32, -512, 48, contents );
        
        if ( !v_nav )
        {
            v_cube = player.origin;
        }
    }
    
    v_drop = utility::drop_to_ground( v_nav ?? v_cube, 0, undefined, undefined, contents );
    var_4671f41f4c5cc36 = 2116;
    
    if ( distancesquared( v_drop, level.var_f4f0b61b1640b63.var_47fc666b426f4a73 ) < var_4671f41f4c5cc36 )
    {
        v_drop = getgroundposition( v_nav ?? v_cube, 1, 30 );
    }
    
    v_drop += ( 0, 0, 4 );
    n_force = distance( cube.e_linker.origin, v_drop ) / 0.35;
    n_wait = cube.e_linker zm_quest::fake_physicslaunch( v_drop, n_force );
    cube.e_linker rotateto( ( 0, cube.e_linker.angles[ 1 ], 0 ), n_wait );
    wait n_wait / 2;
    
    if ( function_ab58d7936bf8d2df( cube ) )
    {
        return;
    }
    
    wait n_wait / 2;
    var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( cube.e_linker.origin );
    
    if ( !issubstr( var_8c4fe62d01999d1e.script_zone_name, "zone_nw_temple" ) || issubstr( var_8c4fe62d01999d1e.script_zone_name, "zone_nw_temple_exter" ) )
    {
        playsoundatpos( cube.origin, "evt_fail_stinger" );
        respawn_cube( cube );
        return;
    }
    
    cube setscriptablepartstate( "usable", "on" );
    level thread cube_timeout( cube );
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x20e567c2, Offset: 0x1321
// Size: 0xd2
function private cube_timeout( cube )
{
    cube endon( #"cube_active" );
    wait 5;
    level waittill( #"on_round_end" );
    cube setscriptablepartstate( "model", "off" );
    cube setscriptablepartstate( "usable", "off" );
    wait 1;
    cube.e_linker.origin = cube.s_home.origin;
    cube.e_linker.angles = cube.s_home.angles;
    wait 0.5;
    cube setscriptablepartstate( "usable", "on" );
    cube setscriptablepartstate( "model", cube.var_7be3d52e21910f39 );
}

// Namespace namespace_9972523f9872e5a4
// Params 3, eflags: 0x4
// Checksum 0xc4cf8b5d, Offset: 0x13fb
// Size: 0x685
function private function_ab58d7936bf8d2df( cube, var_98bf9e1167bf7b79 = "left", var_5c907e13da5756d6 = 0 )
{
    if ( cube.off || cube.b_is_moving )
    {
        return;
    }
    
    a_all_slots = utility::getstructarray( "tmp_v_block_slot_" + var_98bf9e1167bf7b79 );
    a_slots = arraycopy( a_all_slots ?? [] );
    
    foreach ( slot in a_slots )
    {
        if ( slot.cube )
        {
            a_slots = arrayremove( a_slots, slot );
        }
    }
    
    if ( !a_slots.size )
    {
        return;
    }
    
    n_lowest = 5;
    
    foreach ( slot in a_slots )
    {
        if ( slot.script_noteworthy == "4" )
        {
            s_highest = slot;
        }
        
        if ( int( slot.script_noteworthy ) < n_lowest )
        {
            n_lowest = int( slot.script_noteworthy );
            var_fbc268db0a98ac30 = slot;
        }
    }
    
    if ( distancesquared( cube.origin, s_highest.origin ) < 4096 )
    {
        level.var_f4f0b61b1640b63.mdl_vessel.a_cubes = arrayremove( level.var_f4f0b61b1640b63.mdl_vessel.a_cubes, cube );
        var_fbc268db0a98ac30.cube = cube;
        cube.slot = var_fbc268db0a98ac30;
        
        if ( cube.var_7be3d52e21910f39 == "hand" )
        {
            function_6badf7074b09e5ce( 0 );
        }
        
        level utility::flag_set( "cube_in_motion" );
        cube.e_linker unlink();
        cube.b_is_moving = 1;
        
        if ( var_5c907e13da5756d6 )
        {
            cube.e_linker playsoundonmovingent( "evt_scarab_mq_cubepuzzle_cube_from_mover" );
            forward_offset = anglestoforward( s_highest.angles ) * 12;
            cube.e_linker moveto( cube.origin + forward_offset, 0.3, 0.2, 0 );
            cube.e_linker waittill( #"movedone" );
            cube.e_linker moveto( s_highest.origin + forward_offset, 0.75, 0.25, 0.25 );
            cube.e_linker rotateto( s_highest.angles, 0.75, 0.25, 0.25 );
            cube.e_linker waittill( #"movedone" );
            cube.e_linker moveto( s_highest.origin, 0.3, 0, 0.2 );
        }
        else
        {
            cube.e_linker playsoundonmovingent( "evt_scarab_mq_cubepuzzle_cube_place_into_holder" );
            cube.e_linker moveto( s_highest.origin, 0.5 );
            cube.e_linker rotateto( s_highest.angles, 0.5 );
        }
        
        cube.e_linker waittill( #"movedone" );
        cube.b_is_moving = undefined;
        
        if ( var_fbc268db0a98ac30 != s_highest )
        {
            n_move_time = 0.75 / int( var_fbc268db0a98ac30.script_noteworthy );
            cube.e_linker moveto( var_fbc268db0a98ac30.origin, n_move_time );
            wait n_move_time;
        }
        
        b_success = function_d5f6f7ad144ec359( var_fbc268db0a98ac30, cube, var_98bf9e1167bf7b79 );
        
        if ( b_success )
        {
            playsoundatpos( cube.origin, "uin_zm_common_pickup_item_important" );
            cube setscriptablepartstate( "model", cube.var_7be3d52e21910f39 );
        }
        
        var_1058da8bcb214c1d = 1;
        
        foreach ( slot in a_all_slots )
        {
            if ( !slot.cube )
            {
                var_1058da8bcb214c1d = 0;
            }
        }
        
        if ( var_1058da8bcb214c1d )
        {
            foreach ( placed_cube in level.var_f4f0b61b1640b63.a_cubes )
            {
                placed_cube setscriptablepartstate( "vfx", "on" );
            }
            
            if ( var_98bf9e1167bf7b79 == "right" )
            {
                level thread function_596128becdf13eca();
            }
            else
            {
                level utility::flag_set( "v_puzzle_usable" );
                level utility::flag_set( "v_puzzle_started" );
                
                if ( level.var_f4f0b61b1640b63.scr_switch getscriptablepartstate( "sound" ) != "on" )
                {
                    level.var_f4f0b61b1640b63.scr_switch setscriptablepartstate( "sound", "on" );
                }
            }
        }
        
        if ( var_98bf9e1167bf7b79 == level.var_f4f0b61b1640b63.interact.side && level.var_f4f0b61b1640b63.mdl_vessel.a_cubes.size < 2 )
        {
            function_b730c984f486fbc( var_98bf9e1167bf7b79 );
        }
        else
        {
            function_b730c984f486fbc( var_98bf9e1167bf7b79, 0 );
        }
        
        level utility::flag_clear( "cube_in_motion" );
        return 1;
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 3, eflags: 0x4
// Checksum 0xe67564e3, Offset: 0x1a88
// Size: 0x20d, Type: bool
function private function_d5f6f7ad144ec359( var_4108ecc20cf047a9, cube, var_98bf9e1167bf7b79 )
{
    if ( cube.var_7be3d52e21910f39 == "hand" )
    {
        return true;
    }
    
    if ( var_4108ecc20cf047a9.script_noteworthy == "1" )
    {
        return true;
    }
    
    var_5ae6d55a83904821 = function_89d28d5e4c4b1a0e( int( var_4108ecc20cf047a9.script_noteworthy ) - 1, var_98bf9e1167bf7b79 );
    var_e30318f81ae0dce0 = var_5ae6d55a83904821.cube.var_7be3d52e21910f39;
    
    if ( var_e30318f81ae0dce0 == "hand" )
    {
        return true;
    }
    
    if ( ( var_e30318f81ae0dce0 == "fire" || cube.var_7be3d52e21910f39 == "fire" ) && ( cube.var_7be3d52e21910f39 == "water" || cube.var_7be3d52e21910f39 == "life" || var_e30318f81ae0dce0 == "water" || var_e30318f81ae0dce0 == "life" ) )
    {
        function_6badf7074b09e5ce( 0 );
        
        foreach ( scr_cube in level.var_f4f0b61b1640b63.a_cubes )
        {
            if ( scr_cube.slot )
            {
                scr_cube.slot.cube = undefined;
            }
            
            level thread respawn_cube( scr_cube );
        }
        
        playsoundatpos( cube.origin, "evt_scarab_mq_cubepuzzle_cube_destruction" );
        function_b730c984f486fbc( var_98bf9e1167bf7b79, 0 );
        function_93ce83f5c6e45665( 0 );
        level.var_f4f0b61b1640b63.mdl_vessel.a_cubes = [];
        
        if ( var_98bf9e1167bf7b79 == "right" )
        {
            level thread move_vessel( var_98bf9e1167bf7b79 );
        }
        
        return false;
    }
    
    return true;
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0x878bebc0, Offset: 0x1c9e
// Size: 0x10f
function private function_b730c984f486fbc( var_98bf9e1167bf7b79, var_e12f26713e8411c0 = 1 )
{
    a_slots = utility::getstructarray( "tmp_v_block_slot_" + var_98bf9e1167bf7b79 );
    
    foreach ( slot in a_slots )
    {
        if ( slot.cube )
        {
            if ( var_e12f26713e8411c0 )
            {
                slot.cube setscriptablepartstate( "model", slot.cube.var_7be3d52e21910f39 + "_glow" );
                continue;
            }
            
            slot.cube setscriptablepartstate( "model", slot.cube.var_7be3d52e21910f39 );
        }
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x307e3df4, Offset: 0x1db5
// Size: 0xe6
function private function_93ce83f5c6e45665( var_e12f26713e8411c0 = 1 )
{
    foreach ( cube in level.var_f4f0b61b1640b63.mdl_vessel.a_cubes )
    {
        if ( cube.off )
        {
            continue;
        }
        
        if ( var_e12f26713e8411c0 )
        {
            cube setscriptablepartstate( "model", cube.var_7be3d52e21910f39 + "_glow" );
            continue;
        }
        
        cube setscriptablepartstate( "model", cube.var_7be3d52e21910f39 );
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x83c47c5, Offset: 0x1ea3
// Size: 0x139
function private respawn_cube( cube )
{
    level utility::flag_clear( "v_puzzle_started" );
    
    if ( cube.slot )
    {
        cube.slot.cube = undefined;
        cube.slot = undefined;
    }
    
    if ( cube.e_linker )
    {
        cube.e_linker unlink();
    }
    
    cube setscriptablepartstate( "model", "off" );
    cube setscriptablepartstate( "usable", "off" );
    cube.off = 1;
    level waittill( #"on_round_end" );
    
    if ( cube.e_linker )
    {
        cube.e_linker.origin = cube.s_home.origin;
        cube.e_linker.angles = cube.s_home.angles;
    }
    
    cube.off = undefined;
    cube setscriptablepartstate( "usable", "on" );
    cube setscriptablepartstate( "model", cube.var_7be3d52e21910f39 );
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x5c47bae3, Offset: 0x1fe4
// Size: 0x26e
function private function_94fc7e843370125a( player )
{
    if ( !level utility::flag( "v_puzzle_usable" ) || !level utility::flag( "v_puzzle_started" ) || level utility::flag( "v_vessel_in_motion" ) )
    {
        return;
    }
    
    if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 0 ) )
    {
        return;
    }
    
    v_start = player utility::get_player_camera_origin();
    v_end = v_start + anglestoforward( player getplayerangles() ) * 100;
    trace = trace::ray_trace( v_start, v_end, [ player, level.var_f4f0b61b1640b63.mdl_vessel ], undefined, 0, 1, 1 );
    
    if ( trace[ "scriptable" ] && trace[ "scriptable" ].var_7be3d52e21910f39 )
    {
        cube = trace[ "scriptable" ];
        
        if ( cube.b_is_moving )
        {
            return;
        }
        
        if ( arraycontains( level.var_f4f0b61b1640b63.mdl_vessel.a_cubes, cube ) )
        {
            level utility::flag_clear( "v_puzzle_usable" );
            cube setscriptablepartstate( "vfx", "on" );
            function_ab58d7936bf8d2df( cube, self.side, 1 );
            player playrumbleonentity( "damage_heavy" );
            level utility::flag_set( "v_puzzle_usable" );
            return;
        }
        
        if ( level.var_f4f0b61b1640b63.mdl_vessel.a_cubes.size == 2 )
        {
            return;
        }
        
        if ( level.var_f4f0b61b1640b63.mdl_vessel.a_cubes.size == 1 && level.var_f4f0b61b1640b63.mdl_vessel.a_cubes[ 0 ].var_7be3d52e21910f39 != "hand" && cube.var_7be3d52e21910f39 != "hand" )
        {
            return;
        }
        
        level utility::flag_clear( "v_puzzle_usable" );
        cube setscriptablepartstate( "vfx", "on" );
        b_success = function_b4bba63f96b99103( cube, player );
        
        if ( b_success )
        {
            level utility::flag_set( "v_puzzle_usable" );
        }
        
        return;
    }
    
    if ( getdvarint( @"hash_e888c9fdc9ffdf08" ) )
    {
        /#
            level thread utility::draw_arrow_time( v_start, trace[ "<dev string:x34>" ], ( 1, 0, 0 ), 10 );
        #/
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 3, eflags: 0x4
// Checksum 0x1a3d2a17, Offset: 0x225a
// Size: 0x29
function private function_6c9d677b0fb49e1a( n_delay, v_pos, str_sfx )
{
    wait n_delay;
    playsoundatpos( v_pos, str_sfx );
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0xe8e60525, Offset: 0x228b
// Size: 0x57d, Type: bool
function private function_b4bba63f96b99103( cube, player )
{
    if ( cube.b_is_moving || level utility::flag( "v_vessel_in_motion" ) )
    {
        return false;
    }
    
    level.var_f4f0b61b1640b63.mdl_vessel.a_cubes[ level.var_f4f0b61b1640b63.mdl_vessel.a_cubes.size ] = cube;
    
    if ( cube.var_7be3d52e21910f39 == "hand" )
    {
        var_9b19a902922a31d4 = utility::getstruct( "tmp_v_vessel_slot1" + self.side );
    }
    else
    {
        var_9b19a902922a31d4 = utility::getstruct( "tmp_v_vessel_slot2" + self.side );
    }
    
    level utility::flag_set( "cube_in_motion" );
    forward_offset = anglestoforward( var_9b19a902922a31d4.angles ) * 12;
    cube.b_is_moving = 1;
    cube.e_linker playsoundonmovingent( #"hash_80fb56642a5257b6" );
    cube.e_linker moveto( cube.origin + forward_offset, 0.3, 0.2, 0 );
    cube.e_linker waittill( #"movedone" );
    cube.e_linker moveto( var_9b19a902922a31d4.origin + forward_offset, 0.75, 0.25, 0.25 );
    cube.e_linker rotateto( var_9b19a902922a31d4.angles, 0.75, 0.25, 0.25 );
    cube.e_linker waittill( #"movedone" );
    
    if ( isdefined( player ) )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    cube.e_linker moveto( var_9b19a902922a31d4.origin, 0.3, 0, 0.2 );
    wait 0.5;
    
    if ( !cube.off )
    {
        var_66221021ec64ec12 = int( cube.slot.script_noteworthy );
        cube.slot.cube = undefined;
        cube.slot = undefined;
        var_cbcd1d3390e1d875 = 0;
    }
    
    for ( i = var_66221021ec64ec12; i < 4 ; i++ )
    {
        var_a53e04f049fc270c = function_89d28d5e4c4b1a0e( i + 1, self.side );
        cube_moving = var_a53e04f049fc270c.cube;
        
        if ( !cube_moving )
        {
            continue;
        }
        
        playworldsound( cube_moving.origin, #"hash_c41ba31e8a1333f5" );
        cube.b_is_moving = 1;
        cube_moving.e_linker moveto( cube_moving.e_linker.origin - ( 0, 0, 8 ), 0.25 );
        var_38c3e111e1a60c36 = function_89d28d5e4c4b1a0e( i, self.side );
        var_38c3e111e1a60c36.cube = cube_moving;
        cube_moving.slot = var_38c3e111e1a60c36;
        var_a53e04f049fc270c.cube = undefined;
        var_cbcd1d3390e1d875 = 1;
    }
    
    wait 0.3;
    
    if ( var_cbcd1d3390e1d875 && isdefined( player ) )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    a_slots = utility::getstructarray( "tmp_v_block_slot_" + self.side );
    
    foreach ( slot in a_slots )
    {
        if ( slot.cube && slot.cube != cube )
        {
            function_d5f6f7ad144ec359( slot, slot.cube, self.side );
        }
    }
    
    foreach ( moved_cube in level.var_f4f0b61b1640b63.a_cubes )
    {
        moved_cube.b_is_moving = undefined;
    }
    
    if ( cube.off )
    {
        level utility::flag_clear( "v_puzzle_usable" );
        level utility::flag_clear( "cube_in_motion" );
        return false;
    }
    
    cube.e_linker linkto( level.var_f4f0b61b1640b63.mdl_vessel );
    level utility::flag_clear( "cube_in_motion" );
    
    if ( cube.var_7be3d52e21910f39 == "hand" )
    {
        function_6badf7074b09e5ce( 1 );
    }
    
    if ( level.var_f4f0b61b1640b63.mdl_vessel.a_cubes.size == 2 )
    {
        level utility::flag_clear( "v_puzzle_usable" );
        function_b730c984f486fbc( self.side, 0 );
        function_93ce83f5c6e45665();
    }
    
    return true;
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0xf135f44f, Offset: 0x2811
// Size: 0xae
function private function_89d28d5e4c4b1a0e( n_index, var_98bf9e1167bf7b79 )
{
    a_slots = utility::getstructarray( "tmp_v_block_slot_" + var_98bf9e1167bf7b79 );
    
    foreach ( slot in a_slots )
    {
        if ( int( slot.script_noteworthy ) == n_index )
        {
            return slot;
        }
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x38b34261, Offset: 0x28c7
// Size: 0x7d
function private function_6badf7074b09e5ce( var_e12f26713e8411c0 = 1 )
{
    scr_switch = level.var_f4f0b61b1640b63.scr_switch;
    
    if ( var_e12f26713e8411c0 )
    {
        scr_switch setscriptablepartstate( "base", "on" );
        scr_switch zm_damage::register_scriptable_damage_callback( &function_2b456d1dc0c8fb12, 1 );
        return;
    }
    
    scr_switch setscriptablepartstate( "base", "off" );
    scr_switch zm_damage::function_c31f9d79d5ceb7ec( &function_2b456d1dc0c8fb12, 0 );
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x4b6ab5bd, Offset: 0x294c
// Size: 0x87
function private function_2b456d1dc0c8fb12( params )
{
    if ( !isplayer( params.eattacker ) || !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( params.eattacker, 0, 0 ) )
    {
        return params.idamage;
    }
    
    zm_damage::function_c31f9d79d5ceb7ec( &function_2b456d1dc0c8fb12, 0 );
    self setscriptablepartstate( "base", "hit" );
    level thread move_vessel( level.var_f4f0b61b1640b63.interact.side );
    return -1;
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0xc
// Checksum 0xd0ed102f, Offset: 0x29dc
// Size: 0x415
function private move_vessel( var_20cffba9e8152e48 )
{
    self notify( #"hash_4d09cc2dcdca85e4" );
    self endon( #"hash_4d09cc2dcdca85e4" );
    
    if ( level utility::flag( "cube_in_motion" ) )
    {
        level utility::flag_waitopen( "cube_in_motion" );
        
        foreach ( cube in level.var_f4f0b61b1640b63.a_cubes )
        {
            if ( cube.off && level.var_f4f0b61b1640b63.interact.side == "left" )
            {
                return;
            }
        }
    }
    
    level utility::flag_set( "v_vessel_in_motion" );
    level utility::flag_clear( "v_puzzle_usable" );
    activateworldevent( "we_sat_zm_scarab_puzzle_groove" );
    wait 0.5;
    
    if ( !level.var_f4f0b61b1640b63.interact )
    {
        return;
    }
    
    function_b730c984f486fbc( var_20cffba9e8152e48, 0 );
    function_93ce83f5c6e45665( 0 );
    
    if ( self.origin )
    {
        playrumblelooponposition( "low_highfreq", self.origin );
    }
    
    if ( var_20cffba9e8152e48 == "left" )
    {
        v_move = level.var_f4f0b61b1640b63.mdl_vessel.s_right.origin;
        level.var_f4f0b61b1640b63.interact.side = "right";
        level.var_f4f0b61b1640b63.interact.origin = utility::getstruct( "tmp_v_interact_right" ).origin;
    }
    else
    {
        v_move = level.var_f4f0b61b1640b63.mdl_vessel.s_left.origin;
        level.var_f4f0b61b1640b63.interact.side = "left";
        level.var_f4f0b61b1640b63.interact.origin = utility::getstruct( "tmp_v_interact_left" ).origin;
    }
    
    level.var_f4f0b61b1640b63.mdl_vessel playsoundonmovingent( #"hash_ed0fb9e24446d840" );
    level.var_f4f0b61b1640b63.mdl_vessel moveto( v_move, 4 );
    level.var_f4f0b61b1640b63.mdl_vessel waittill( #"movedone" );
    level utility::flag_clear( "v_vessel_in_motion" );
    level utility::flag_set( "v_puzzle_usable" );
    deactivateworldevent( "we_sat_zm_scarab_puzzle_groove" );
    function_93ce83f5c6e45665();
    
    if ( level.var_f4f0b61b1640b63.mdl_vessel.a_cubes.size < 2 && function_89d28d5e4c4b1a0e( 1, level.var_f4f0b61b1640b63.interact.side ).cube )
    {
        function_b730c984f486fbc( level.var_f4f0b61b1640b63.interact.side );
    }
    
    foreach ( cube in level.var_f4f0b61b1640b63.mdl_vessel.a_cubes )
    {
        if ( cube.var_7be3d52e21910f39 == "hand" )
        {
            function_6badf7074b09e5ce( 1 );
        }
    }
    
    stopallrumbles();
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0xc769136c, Offset: 0x2df9
// Size: 0xf8
function private function_88137c31a4cc40a8( cube )
{
    switch ( cube.var_7be3d52e21910f39 )
    {
        case #"hash_7651db02434beff0":
            string = "W";
            color = ( 0, 0, 1 );
            break;
        case #"hash_ceb098150f024a39":
            string = "F";
            color = ( 1, 0, 0 );
            break;
        case #"hash_6f991839e820093f":
            string = "L";
            color = ( 0, 1, 0 );
            break;
        case #"hash_cc8437548a4a4480":
            string = "D";
            color = ( 1, 1, 1 );
            break;
    }
    
    while ( cube )
    {
        if ( cube getscriptablepartstate( "model" ) == "on" )
        {
            /#
                print3d( cube.origin, string, color );
            #/
        }
        
        waitframe();
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1
// Checksum 0x3f9219d4, Offset: 0x2ef9
// Size: 0x434
function function_596128becdf13eca( b_instant )
{
    if ( level utility::flag( "hr_v_opened" ) )
    {
        return;
    }
    
    level utility::flag_set( "hr_v_opened" );
    function_2e563ff1483f0c39( 0, 1 );
    
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        level callback::add( #"hash_fdb7c9b3f46244da", &function_a26bff79822c02eb );
    }
    
    level utility::flag_clear( "v_puzzle_usable" );
    level.var_f4f0b61b1640b63.interact freescriptable();
    function_b730c984f486fbc( "right", 0 );
    activateworldevent( "we_sat_zm_scarab_vhr_idle" );
    s_water = utility::getstruct( "ven_srm_int" );
    var_d4127ece161f3bf5 = ( -4235.01, 2083.99, 1513 );
    level.var_45e7e2011b0c506d = spawnscriptable( %"zm_sat_scarab_mq_ping", var_d4127ece161f3bf5, s_water.angles );
    level.var_45e7e2011b0c506d setscriptablepartstate( "base", "on_poo" );
    level.var_45e7e2011b0c506d setscriptablepartstate( "pool_audio", "idle" );
    
    if ( !b_instant )
    {
        playsoundatpos( s_water.origin, "evt_scarab_mq_cubepuzzle_wall_open" );
        playrumblelooponposition( "steady_rumble", s_water.origin );
        earthquake( 0.25, 8, s_water.origin, 4000 );
    }
    
    a_doors = getentarray( "ven_srm_ent", #targetname );
    
    foreach ( door in a_doors )
    {
        door notsolid();
        
        if ( int( door.script_noteworthy ) > 0 )
        {
            door_top = door;
        }
    }
    
    v_offset_switch = rotatevectorinverted( level.var_f4f0b61b1640b63.scr_switch.origin - door_top.origin, door_top.angles );
    level.var_f4f0b61b1640b63.scr_switch scriptablesetparententity( door_top, v_offset_switch, ( 0, 0, 0 ) );
    var_f1be77dc9d0b94af = 5;
    
    if ( b_instant )
    {
        var_f1be77dc9d0b94af = 0.05;
        v_offset = anglestoforward( ( 0, 135, 0 ) ) * 10;
        door_top moveto( door_top.origin + v_offset, var_f1be77dc9d0b94af );
        wait var_f1be77dc9d0b94af;
    }
    else
    {
        v_offset = anglestoforward( ( 0, 135, 0 ) ) * 10;
        door_top moveto( door_top.origin + v_offset, 1.5 );
        wait 2;
        activateworldevent( "we_vfx_hidden_room_door_open_dust_v" );
    }
    
    level.var_f4f0b61b1640b63.scr_switch setscriptablepartstate( "sound", "end" );
    activateworldevent( "we_lgt_secret_room_veytharion" );
    
    if ( !b_instant )
    {
        level thread namespace_9d8e359c3b1041e5::droppowerupsharedfunc( "free_perk", s_water.origin + ( 0, 0, 32 ) );
    }
    
    foreach ( door in a_doors )
    {
        door moveto( door.origin + ( 0, 0, int( door.script_noteworthy ) ), var_f1be77dc9d0b94af );
    }
    
    zm_quest::function_91f9590e98d57ff6( s_water.origin, &function_f4ae0c537ce2a427, &function_4e17b571acaf8c96, "hidden" );
    
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        level callback::add( "on_round_start", &function_b73edeedad956f71 );
    }
    
    if ( !b_instant )
    {
        wait 5.5;
        stopallrumbles();
    }
    
    level.var_f4f0b61b1640b63 = undefined;
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0xb6218f66, Offset: 0x3335
// Size: 0x36
function private function_4e17b571acaf8c96( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x2c030921, Offset: 0x3374
// Size: 0xde
function private function_f4ae0c537ce2a427( player )
{
    if ( self.b_on_cooldown || !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 0 ) )
    {
        return;
    }
    
    self.b_on_cooldown = 1;
    level utility::flag_set( "call_the_rains" );
    
    if ( level.var_45e7e2011b0c506d )
    {
        level.var_45e7e2011b0c506d setscriptablepartstate( "pool_audio", "activated" );
    }
    
    activateworldevent( "we_sat_zm_scarab_vhr_active" );
    deactivateworldevent( "we_sat_zm_scarab_vhr_idle" );
    wait 4;
    activateworldevent( "we_sat_zm_scarab_vhr_active_loop" );
    level waittill( #"on_round_end" );
    
    if ( level.var_45e7e2011b0c506d )
    {
        level.var_45e7e2011b0c506d setscriptablepartstate( "pool_audio", "idle" );
    }
    
    deactivateworldevent( "we_sat_zm_scarab_vhr_active" );
    deactivateworldevent( "we_sat_zm_scarab_vhr_active_loop" );
    activateworldevent( "we_sat_zm_scarab_vhr_idle" );
    self.b_on_cooldown = undefined;
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x3dc23e91, Offset: 0x345a
// Size: 0x3b
function private function_b73edeedad956f71( params )
{
    if ( level utility::flag( "call_the_rains" ) )
    {
        level utility::flag_clear( "call_the_rains" );
        level callback::callback( #"hash_fdb7c9b3f46244da", params );
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1
// Checksum 0xa190a190, Offset: 0x349d
// Size: 0x6c
function function_a26bff79822c02eb( params )
{
    self notify( #"hash_da9a3b16991524eb" );
    self endon( #"hash_da9a3b16991524eb" );
    
    /#
        iprintlnbold( "<dev string:x3d>" );
    #/
    
    zm_sat_scarab_rb::function_2a311bb411c253bc();
    
    while ( true )
    {
        level waittill( #"on_round_end" );
        
        if ( !level.var_a009ab14ee0d3223.isspecialround )
        {
            zm_sat_scarab_rb::function_8c76b7030e848cf6();
            return;
        }
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 0
// Checksum 0xa43e506f, Offset: 0x3511
// Size: 0x1f8
function setup_caltheris_puzzle()
{
    trigger = getnoentvolumearray( "cals_ch_t", #targetname )[ 0 ];
    
    if ( !trigger )
    {
        return;
    }
    
    level zm_save::function_1f44a48caae2acbf();
    
    for ( var_f78a8a358290e80b = 0; var_f78a8a358290e80b < 4 && function_a33bd7dd9039f692( 1 + var_f78a8a358290e80b ) ; var_f78a8a358290e80b++ )
    {
    }
    
    if ( var_f78a8a358290e80b == 4 )
    {
        function_15c042a972d1bd3c( 1 );
        return;
    }
    
    i = var_f78a8a358290e80b;
    
    while ( i < 4 )
    {
        i++;
        tile = getent( "cals_ch_" + i, #targetname );
        tile.v_lowered = tile.origin;
        tile.v_raised = tile.origin + ( 0, 0, 3 );
        tile playsound( #"hash_8817bc774fd98ee2" );
        tile moveto( tile.v_raised, 1 );
        tile waittill( #"movedone" );
        
        /#
            iprintlnbold( "<dev string:x4b>" + i );
        #/
        
        while ( true )
        {
            trigger waittill( #"trigger", player );
            
            if ( !isplayer( player ) || !zm_utility::is_player_valid_target( player ) || player.inlaststand || player.b_on_tile )
            {
                continue;
            }
            
            b_success = undefined;
            
            if ( player isonground() && distancesquared( player.origin, tile.origin ) < 576 )
            {
                player.b_on_tile = 1;
                b_success = player function_f3663348c5c3d079( tile, i );
                
                if ( b_success )
                {
                    function_2e563ff1483f0c39( 1 + i - 1, 1 );
                    break;
                }
                
                continue;
            }
            
            player.b_on_tile = undefined;
        }
    }
    
    function_15c042a972d1bd3c();
}

// Namespace namespace_9972523f9872e5a4
// Params 1
// Checksum 0x65be03db, Offset: 0x3711
// Size: 0x2eb
function function_15c042a972d1bd3c( b_instant )
{
    if ( level utility::flag( "hr_c_opened" ) )
    {
        return;
    }
    
    level utility::flag_set( "hr_c_opened" );
    level zm_music::function_446e6e39d7feeb7c( [ "zone_se_temple_finalroom" ], #"hash_fbe0dd520b625cb1" );
    function_2e563ff1483f0c39( 4, 1 );
    var_cc9dbb3fbaaec44e = utility::getstruct( "cal_srm_mote_spawn" );
    level.var_fa70818e51423610 = spawnscriptable( %"zm_sat_scarab_mq_ping", var_cc9dbb3fbaaec44e.origin, var_cc9dbb3fbaaec44e.angles );
    level.var_fa70818e51423610 setscriptablepartstate( "base", "on_lan" );
    level.var_fa70818e51423610 setscriptablepartstate( "lantern_audio", "idle" );
    interact = zm_quest::function_91f9590e98d57ff6( var_cc9dbb3fbaaec44e.origin, &function_376e9dfa27fc220a, &function_4e17b571acaf8c96, "hidden" );
    interact.var_73fb7d069fe8d933 = var_cc9dbb3fbaaec44e;
    level.var_a49d56295c2c3969 = spawnscriptable( %"hash_1343e719c59033f7", var_cc9dbb3fbaaec44e.origin, var_cc9dbb3fbaaec44e.angles );
    
    if ( !b_instant )
    {
        playrumblelooponposition( "steady_rumble", var_cc9dbb3fbaaec44e.origin );
        earthquake( 0.25, 8.5, var_cc9dbb3fbaaec44e.origin, 4000 );
        activateworldevent( "we_vfx_hidden_room_door_open_dust_c" );
    }
    
    level.var_a49d56295c2c3969 utility::function_7c10ea82c1e305b8( "idle_fx", "on" );
    var_f1be77dc9d0b94af = b_instant ? 0.05 : 5;
    playsoundatpos( var_cc9dbb3fbaaec44e.origin, "evt_scarab_mq_tilepuzzle_wall_open" );
    a_door = getentarray( "cals_srm_ent", #targetname );
    
    foreach ( var_8d35515160df2742 in a_door )
    {
        var_8d35515160df2742 moveto( var_8d35515160df2742.origin - ( 0, 0, 148 ), var_f1be77dc9d0b94af );
    }
    
    a_motes = utility::getstructarray( "cal_srm_mote" );
    
    foreach ( s_spawn in a_motes )
    {
        astral_motes::function_9ff53054c89e44ed( s_spawn );
    }
    
    if ( !b_instant )
    {
        wait 5.5;
        stopallrumbles();
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0xbf48042b, Offset: 0x3a04
// Size: 0x498, Type: bool
function private function_f3663348c5c3d079( tile, n_target_id )
{
    level utility::flag_clear( "fail_cal_chal" );
    self playrumbleonentity( "damage_heavy" );
    self earthquakeforplayer( 0.15, 0.5, tile.origin, 64 );
    tile playsound( #"hash_21a22a79b7510ba0" );
    tile moveto( tile.v_lowered, 0.5 );
    tile waittill( #"movedone" );
    tile.n_hits = 0;
    thread function_9a15041a08636a3b( tile );
    var_ad8b274417815b62 = utility::getstructarray( "cals_ch_tg" + n_target_id );
    a_targets = [];
    
    foreach ( var_5990ce3727e634d1 in var_ad8b274417815b62 )
    {
        scriptable = spawnscriptable( %"hash_5728676741fb6a70", var_5990ce3727e634d1.origin, var_5990ce3727e634d1.angles );
        scriptable zm_damage::register_scriptable_damage_callback( &function_8e82ae10532c99b8, 1 );
        scriptable.parent_tile = tile;
        a_targets[ a_targets.size ] = scriptable;
    }
    
    a_covers = getentarray( "cals_ch_cover_" + n_target_id, #targetname );
    
    foreach ( mdl_cover in a_covers )
    {
        mdl_cover hide();
    }
    
    str_result = level utility::waittill_notify_or_timeout_return( "cal_chal_next", 15 );
    
    if ( self )
    {
        var_a393e718f020dc26 = !self.b_on_tile;
        self.b_on_tile = undefined;
    }
    
    if ( str_result != "cal_chal_next" || level utility::flag( "fail_cal_chal" ) )
    {
        /#
            iprintlnbold( "<dev string:x5c>" + n_target_id );
        #/
        
        playsoundatpos( tile.origin, "evt_fail_stinger" );
        
        foreach ( mdl_cover in a_covers )
        {
            mdl_cover show();
        }
        
        level notify( #"cal_chal_next" );
        
        foreach ( target in a_targets )
        {
            target freescriptable();
        }
        
        level thread function_1021cb9352ab4ed( tile.origin );
        blocker = createnavbadplacebybounds( tile.origin, ( 36, 36, 24 ), tile.angles );
        tile moveto( tile.v_lowered - ( 0, 0, 750 ), 1.5, 0.1 );
        playworldsound( tile.origin, #"hash_ea0886f3ed8cfc9a" );
        wait 60;
        playworldsound( tile.origin + ( 0, 0, 750 ), #"hash_4782acdb9598c0a6" );
        tile moveto( tile.v_raised + ( 0, 0, 1 ), 3, 0, 2 );
        tile waittill( #"movedone" );
        tile moveto( tile.v_raised, 0.3, 0.2, 0.1 );
        tile waittill( #"movedone" );
        destroynavobstacle( blocker );
        return false;
    }
    
    tile playsound( #"hash_718f4a1c42a81084" );
    
    /#
        iprintlnbold( "<dev string:x69>" + n_target_id );
    #/
    
    return true;
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x20bdd668, Offset: 0x3ea5
// Size: 0xd9
function private function_1021cb9352ab4ed( origin )
{
    level endon( #"game_ended" );
    a_zombies = getaiarrayinradius( origin, 50, "team_two_hundred" );
    
    foreach ( zombie in a_zombies )
    {
        if ( ( !isdefined( zombie.aicategory ) || zombie.aicategory == "normal" ) && !zombie zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            zombie thread zombie_knockdown::function_6fc167d4a3590991( origin, 200, 30 );
            waitframe();
        }
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0xb370ba5a, Offset: 0x3f86
// Size: 0xaf
function private function_8e82ae10532c99b8( params )
{
    if ( !isplayer( params.eattacker ) || self.b_hit )
    {
        return -1;
    }
    
    params.eattacker playrumbleonentity( "damage_light" );
    self.b_hit = 1;
    self.parent_tile.n_hits++;
    
    if ( self.parent_tile.n_hits > 3 )
    {
        level notify( #"cal_chal_next" );
    }
    
    self setscriptablepartstate( "base", "hit" );
    utility::delaycall( 1, &freescriptable );
    return params.idamage;
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0x80dae9fd, Offset: 0x403e
// Size: 0x7d
function private function_9a15041a08636a3b( tile )
{
    level endon( #"cal_chal_next" );
    
    while ( isalive( self ) && self isonground() && distancesquared( self.origin, tile.origin ) < 576 )
    {
        wait 0.25;
    }
    
    if ( isalive( self ) )
    {
        self.b_on_tile = undefined;
    }
    
    level utility::flag_set( "fail_cal_chal" );
    level notify( #"cal_chal_next" );
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0xc231550d, Offset: 0x40c3
// Size: 0x2d, Type: bool
function private function_71b483f1203e2039( player )
{
    var_eb8fc40490886d0a = player points::zm_get_points();
    
    if ( var_eb8fc40490886d0a >= 400 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0xfe74ce80, Offset: 0x40f9
// Size: 0x16c
function private function_376e9dfa27fc220a( player )
{
    if ( self.b_on_cooldown || !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 0 ) )
    {
        return;
    }
    
    self.b_on_cooldown = 1;
    playworldsound( self.origin, #"hash_cff7bfa3e42e72c1" );
    level.var_a49d56295c2c3969 utility::function_7c10ea82c1e305b8( "pulse_fx", "on" );
    player playrumbleonentity( "damage_heavy" );
    wait 1.5;
    playworldsound( self.origin, #"hash_3dda46959f648cd1" );
    
    for ( i = 0; i < 4 ; i++ )
    {
        s_dest = function_5712d5206a5ce73d();
        level thread function_2a285f77fdca72e3( self.var_73fb7d069fe8d933, s_dest );
        wait randomfloatrange( 0.75, 2 );
    }
    
    level.var_fa70818e51423610 setscriptablepartstate( "lantern_audio", "off" );
    level.var_a49d56295c2c3969 utility::function_7c10ea82c1e305b8( "idle_fx", "off" );
    level.var_a49d56295c2c3969 utility::function_7c10ea82c1e305b8( "pulse_fx", "off" );
    level waittill( #"on_round_end" );
    level.var_fa70818e51423610 setscriptablepartstate( "lantern_audio", "idle" );
    level.var_a49d56295c2c3969 utility::function_7c10ea82c1e305b8( "idle_fx", "on" );
    self.b_on_cooldown = undefined;
}

// Namespace namespace_9972523f9872e5a4
// Params 0
// Checksum 0x8647a2d8, Offset: 0x426d
// Size: 0x197
function function_5712d5206a5ce73d()
{
    a_valid_dest = level.var_15313fda32ee3aa3.var_cda555f949bd894f;
    
    foreach ( e_mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
    {
        if ( !isdefined( e_mote.current_struct ) )
        {
            continue;
        }
        
        if ( arraycontains( a_valid_dest, e_mote.current_struct ) )
        {
            a_valid_dest = arrayremove( a_valid_dest, e_mote.current_struct );
        }
    }
    
    if ( a_valid_dest.size == 0 )
    {
        for ( i = 0; i < level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size ; i++ )
        {
            current_mote = level.var_15313fda32ee3aa3.var_c9b8f22d382189d6[ i ];
            
            if ( current_mote.var_648eef0ab0822c74 )
            {
                continue;
            }
            
            if ( isdefined( current_mote ) && isdefined( current_mote.current_struct ) && arraycontains( level.var_15313fda32ee3aa3.var_cda555f949bd894f, current_mote.current_struct ) )
            {
                a_valid_dest[ a_valid_dest.size ] = current_mote.current_struct;
                current_mote astral_motes::clean_up_mote();
                break;
            }
        }
    }
    
    return utility::array_random( a_valid_dest );
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0x4
// Checksum 0x5c6c36db, Offset: 0x440d
// Size: 0x1fe
function private function_2a285f77fdca72e3( struct, s_dest )
{
    mote = astral_motes::function_9ff53054c89e44ed( struct );
    mote.current_struct = s_dest;
    mote utility::function_7c10ea82c1e305b8( "extra_explosion_fx", "on" );
    mote utility::function_7c10ea82c1e305b8( "body", "fly_into_forge" );
    mote endon( #"hash_579e00333db2ae69" );
    mote endon( #"hash_b68f89ffb0f7da0" );
    wait 0.5;
    playrumbleonposition( "damage_light", struct.origin );
    path = [];
    total_time = 0;
    
    while ( true )
    {
        if ( !isdefined( struct.target ) )
        {
            break;
        }
        
        if ( path.size > 0 )
        {
            var_71d6803b87dffba9 = ( randomfloatrange( -50, 50 ), randomfloatrange( -50, 50 ), randomfloatrange( -50, 50 ) );
        }
        else
        {
            var_71d6803b87dffba9 = ( 0, 0, 0 );
        }
        
        path[ path.size ] = struct.origin + var_71d6803b87dffba9;
        var_667a4f7febbf8d4c = utility::getstruct( struct.target, "targetname" );
        total_time += distance( struct.origin, var_667a4f7febbf8d4c.origin ) / 200;
        struct = var_667a4f7febbf8d4c;
    }
    
    path[ path.size ] = s_dest.origin - ( 0, 0, 10 );
    path[ path.size ] = s_dest.origin;
    mote.e_mover utility::function_2159dd4196ff4b81( path, total_time, 1, 0, 0, 1, 0.5 );
    
    if ( isdefined( mote ) && isdefined( mote.e_mover ) )
    {
        mote.e_mover.angles = ( 0, 0, 0 );
        mote utility::function_7c10ea82c1e305b8( "extra_explosion_fx", "on" );
        mote astral_motes::function_af255fa65d6d08f7();
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 2, eflags: 0xc
// Checksum 0xbc4d49bf, Offset: 0x4613
// Size: 0xc1
function private function_38a6222ef07dc6d6( str_targetname, var_e12f26713e8411c0 = 1 )
{
    self notify( #"hash_3640a78d8750dbdb" );
    self endon( #"hash_3640a78d8750dbdb" );
    light = getent( str_targetname, #targetname );
    
    if ( !light )
    {
        return;
    }
    
    if ( !var_e12f26713e8411c0 )
    {
        light function_82bcffd59d3fb411( 0 );
        return;
    }
    
    n_intensity = 100;
    n_max = 8000 - n_intensity;
    var_f208f4f1a3745e92 = n_max / 20;
    
    for ( i = 0; i < 20 ; i++ )
    {
        n_intensity += var_f208f4f1a3745e92;
        light function_82bcffd59d3fb411( n_intensity );
        wait 0.1;
    }
}

// Namespace namespace_9972523f9872e5a4
// Params 1, eflags: 0x4
// Checksum 0xe6ec89aa, Offset: 0x46dc
// Size: 0x57
function private function_28ceefcedd6c5cff( params )
{
    str_room = params[ 0 ];
    
    if ( str_room == "v" )
    {
        level thread function_596128becdf13eca();
        return;
    }
    
    if ( str_room == "c" )
    {
        level thread function_15c042a972d1bd3c();
        return;
    }
    
    level thread function_596128becdf13eca();
    level thread function_15c042a972d1bd3c();
}

/#

    // Namespace namespace_9972523f9872e5a4
    // Params 0, eflags: 0x4
    // Checksum 0x13149dc0, Offset: 0x473b
    // Size: 0x44, Type: dev
    function private function_68aeb41a854a3fe6()
    {
        devgui::function_9082edeb5db93280( "<dev string:x79>" );
        devgui::add_devgui_func( "<dev string:x98>", "<dev string:xb4>", &function_3ba91fd22410e773 );
        devgui::add_devgui_func( "<dev string:xc1>", "<dev string:xe1>", &function_c460441c81f2cb71 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_9972523f9872e5a4
    // Params 0, eflags: 0x4
    // Checksum 0xa93a0668, Offset: 0x4787
    // Size: 0x15f, Type: dev
    function private function_3ba91fd22410e773()
    {
        player = level.players[ 0 ];
        
        if ( !level.var_f4f0b61b1640b63 || !level.var_f4f0b61b1640b63.a_cubes.size )
        {
            iprintlnbold( "<dev string:x101>" );
            return;
        }
        
        if ( !isdefined( level.var_f4f0b61b1640b63.var_b43429303fec68d7 ) )
        {
            level.var_f4f0b61b1640b63.var_b43429303fec68d7 = 0;
        }
        
        n_index = level.var_f4f0b61b1640b63.var_b43429303fec68d7 % level.var_f4f0b61b1640b63.a_cubes.size;
        cube = level.var_f4f0b61b1640b63.a_cubes[ n_index ];
        v_forward = anglestoforward( cube.angles );
        v_dest = cube.origin + v_forward * 60;
        player setorigin( v_dest );
        level.var_f4f0b61b1640b63.var_b43429303fec68d7 = ( n_index + 1 ) % level.var_f4f0b61b1640b63.a_cubes.size;
        iprintlnbold( "<dev string:x11f>" + n_index + 1 + "<dev string:x133>" + level.var_f4f0b61b1640b63.a_cubes.size );
    }

    // Namespace namespace_9972523f9872e5a4
    // Params 0, eflags: 0x4
    // Checksum 0xddb93cdf, Offset: 0x48ee
    // Size: 0x51, Type: dev
    function private function_c460441c81f2cb71()
    {
        level thread function_15c042a972d1bd3c();
        fake_interact = utility::getstruct( "<dev string:x137>" );
        fake_interact.var_73fb7d069fe8d933 = fake_interact;
        fake_interact.b_on_cooldown = undefined;
        fake_interact function_376e9dfa27fc220a( level.players[ 0 ] );
    }

#/
