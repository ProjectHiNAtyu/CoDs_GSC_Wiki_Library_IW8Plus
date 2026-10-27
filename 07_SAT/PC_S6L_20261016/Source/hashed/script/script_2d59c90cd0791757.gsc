// script_2d59c90cd0791757  (hash_2d59c90cd0791757.gscc) (size: 17761 Bytes / 0x4561 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd071be5a (3497115226)
// size ...... 17761 (0x4561)
// includes .. 7   (offset: 0x422d)
// strings ... 24  (offset: 0x4265)
// dev strs .. 27  (offset: 0x43fd)
// exports ... 53  (offset: 0x2b8d)
// cseg ...... 0x2f7 + 0x2896 (0x2b8d)
// imports ... 116 (offset: 0x33d5)
// animtree1 . 0   (offset: 0x4561)
// animtree2 . 0   (offset: 0x4561)
#using script_53600bb9c82cbdf2;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_589ae4efe3ba85ad;

// Namespace namespace_589ae4efe3ba85ad
// Params 0
// Checksum 0x9e0289b6, Offset: 0x315
// Size: 0x229
function init()
{
    level.var_70a8f1f223df0ff5 = { #var_bd844df41dc333e5:getdvarint( @"hash_a40ab26900c96528", 0 ), #var_8f6ae9782c211e64:getdvarint( @"hash_f92d2a7e425f4b63", 50 ), #var_3b4886bf8b6e1cb2:getdvarint( @"hash_ac72df6d6d18bd3", 950 ), #var_b7495b947564d29a:getdvarfloat( @"hash_3602c3a0e541b743", 1 ), #var_ca70d7f094a6992:getdvarfloat( @"hash_4ed36cc73b6d7445", 1 ), #var_5642fdda94827df7:getdvarfloat( @"hash_ec5aeb64e815290a", 50 ), #var_51e5b3c2fb68959c:getdvarfloat( @"hash_45bf6354ba52ee5", 1 ), #var_b23e3516c966f449:getdvarfloat( @"hash_1b5b213d6c1ccbbe", 5 ), #var_e9b78c701ef2f30b:getdvarfloat( @"hash_4fc81edb80cf4da0", 1 ), #var_4801b090b89242dc:undefined, #var_2b9c6d9df6cb7899:[], #bomb_explosion_locations:[], #var_3fffcec324ffd967:[], #bomb_spawn_locations:[], #var_c71ebeffbde62e9:undefined, #var_800286aff6c4430f:[], #available_sections:[], #active_clouds:[], #active_bombs:[], #virgil_ent:self };
    level.var_70a8f1f223df0ff5.available_sections = [ "left", "center", "right" ];
    level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ "left" ] = [];
    level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ "center" ] = [];
    level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ "right" ] = [];
    level.var_70a8f1f223df0ff5.charge_bomb_cooldown_sec = 20;
    level.var_70a8f1f223df0ff5.var_d8492c3ae0555f0 = 40;
    utility::ent_flag_set( "flag_virgil_attack_charge_bomb_require_cooldown" );
    utility::ent_flag_set( "flag_virgil_attack_charge_bomb_require_players" );
    thread function_d2d05108201c27c4();
    
    /#
        level thread attack_debug();
    #/
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0, eflags: 0x4
// Checksum 0x9bfc1972, Offset: 0x546
// Size: 0x59
function private function_d2d05108201c27c4()
{
    level endon( #"game_ended" );
    level.var_70a8f1f223df0ff5.virgil_ent endon( #"death" );
    
    while ( true )
    {
        arena_section = function_3ad7c267dc0a1dd7();
        
        if ( isdefined( arena_section ) )
        {
            function_caa813b1b18fec04( arena_section );
            continue;
        }
        
        waitframe();
    }
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0, eflags: 0x4
// Checksum 0x1f0c46b3, Offset: 0x5a7
// Size: 0x1af
function private function_3ad7c267dc0a1dd7()
{
    if ( utility::ent_flag( "flag_virgil_totems_state_active" ) || !utility::ent_flag( "flag_virgil_charge_bomb_enabled" ) || utility::ent_flag( "flag_virgil_stop_attacking" ) )
    {
        return;
    }
    
    if ( level.var_70a8f1f223df0ff5.available_sections.size == 0 )
    {
        return;
    }
    
    enough_time_has_passed = !isdefined( level.var_70a8f1f223df0ff5.var_c71ebeffbde62e9 ) || gettime() - level.var_70a8f1f223df0ff5.var_c71ebeffbde62e9 >= level.var_70a8f1f223df0ff5.charge_bomb_cooldown_sec * 1000;
    
    if ( utility::ent_flag( "flag_virgil_attack_charge_bomb_require_cooldown" ) && !enough_time_has_passed )
    {
        return;
    }
    
    arena_section = function_76ecceee1d5e4314();
    
    if ( !isdefined( arena_section ) && !utility::ent_flag( "flag_virgil_attack_charge_bomb_require_players" ) )
    {
        arena_section = utility::array_random( level.var_70a8f1f223df0ff5.available_sections );
    }
    
    if ( !zombie_boss_virgil::function_8fc422943bc5c65a() )
    {
        var_7a377a9575f91cca = !isdefined( level.var_70a8f1f223df0ff5.var_c71ebeffbde62e9 ) || gettime() - level.var_70a8f1f223df0ff5.var_c71ebeffbde62e9 >= level.var_70a8f1f223df0ff5.var_d8492c3ae0555f0 * 1000;
        
        if ( arena_section && var_7a377a9575f91cca && utility::ent_flag( "flag_virgil_attack_runic_volley" ) && !utility::ent_flag( "flag_virgil_attack_charge_bomb_interrupt_requested" ) && utility::ent_flag( "flag_virgil_attack_charge_bomb_require_players" ) )
        {
            utility::ent_flag_set( "flag_virgil_attack_charge_bomb_interrupt_requested" );
            utility::delaythread( 5, &utility::ent_flag_clear, "flag_virgil_attack_charge_bomb_interrupt_requested" );
        }
        
        return;
    }
    
    return arena_section;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0
// Checksum 0x562f8bcc, Offset: 0x75f
// Size: 0x117
function function_76ecceee1d5e4314()
{
    valid_player_array = utility::get_alive_players( 0 );
    
    if ( valid_player_array.size > 0 )
    {
        var_f8f29b8ca21d49e6 = utility::function_54fdde0a73217354( valid_player_array, 0, 1 );
    }
    
    var_10fe86183f38417c = [];
    
    if ( var_f8f29b8ca21d49e6 )
    {
        foreach ( arena_section in level.var_70a8f1f223df0ff5.available_sections )
        {
            explosion_target_location = get_explosion_target_location( arena_section );
            radius = level.var_70a8f1f223df0ff5.var_3b4886bf8b6e1cb2 * 1.2;
            var_e47183602f810870 = getplayersinradius( explosion_target_location, radius );
            
            if ( var_e47183602f810870.size > 0 )
            {
                var_10fe86183f38417c[ var_10fe86183f38417c.size ] = arena_section;
            }
        }
    }
    
    return utility::array_random( var_10fe86183f38417c );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0
// Checksum 0x472d0878, Offset: 0x87f
// Size: 0x1b
function get_available_section()
{
    return utility::array_random( level.var_70a8f1f223df0ff5.available_sections );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0x701fd10c, Offset: 0x8a3
// Size: 0xd4
function function_e0c1b431307f92cf( params )
{
    if ( getdvarint( @"hash_ec565fb5cfd84b8c", 0 ) == 0 )
    {
        return anim.failure;
    }
    
    if ( !utility::ent_flag( "zombie_asm_init_finished" ) )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "flag_virgil_totems_state_active" ) || !utility::ent_flag( "flag_virgil_charge_bomb_enabled" ) )
    {
        return anim.failure;
    }
    
    arena_section = utility::array_random( level.var_70a8f1f223df0ff5.available_section );
    
    if ( !isdefined( arena_section ) )
    {
        return anim.failure;
    }
    
    if ( !function_caa813b1b18fec04( arena_section ) )
    {
        return anim.failure;
    }
    
    ai::set_blackboard_cooldown( "charge_bomb_cooldown", self.charge_bomb_cooldown );
    return anim.success;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0x4
// Checksum 0xb08f2043, Offset: 0x980
// Size: 0x99
function private function_a745aeb63d0f9d09( spawn_pos )
{
    var_9c2f327f029305e9 = utility::spawn_model( %"sat_zm_virgil_ice_bomb_02", spawn_pos );
    var_9c2f327f029305e9 show();
    var_9c2f327f029305e9 setscriptablepartstate( #"fx", #"spawned" );
    var_9c2f327f029305e9 setscriptablepartstate( #"sfx", #"spawned" );
    var_9c2f327f029305e9.attack_info = { #var_c464a2d2aa68df50:0, #arena_section:undefined, #charge_threat:undefined, #charge_percent:0 };
    return var_9c2f327f029305e9;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0x4
// Checksum 0x2897d8d7, Offset: 0xa22
// Size: 0xda
function private cleanup_bomb( var_9c2f327f029305e9 )
{
    var_9c2f327f029305e9 endon( #"death", #"destroyed" );
    var_9c2f327f029305e9 notify( #"charge_bomb_complete" );
    level notify( #"charge_bomb_complete" );
    var_9c2f327f029305e9.warning_scriptable setscriptablepartstate( #"fx", #"off" );
    level.var_70a8f1f223df0ff5.active_bombs[ var_9c2f327f029305e9.attack_info.arena_section ] = undefined;
    level notify( #"hash_e799917d282bb6cd", var_9c2f327f029305e9 );
    wait 3;
    
    if ( var_9c2f327f029305e9.warning_scriptable )
    {
        var_9c2f327f029305e9.warning_scriptable freescriptable();
    }
    
    if ( var_9c2f327f029305e9.mover_ent )
    {
        var_9c2f327f029305e9.mover_ent delete();
    }
    
    var_9c2f327f029305e9 delete();
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0
// Checksum 0xd7127d7a, Offset: 0xb04
// Size: 0x16
function function_85e6976821acc952()
{
    return level.var_70a8f1f223df0ff5.active_bombs.size;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0xb2faf668, Offset: 0xb23
// Size: 0x22
function function_b2faf7a00597031( arena_section )
{
    return level.var_70a8f1f223df0ff5.available_sections[ arena_section ];
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0xb38c1ab7, Offset: 0xb4e
// Size: 0x1a5
function function_caa813b1b18fec04( arena_section )
{
    level endon( #"game_ended" );
    level.var_70a8f1f223df0ff5.virgil_ent endon( #"death" );
    level.var_70a8f1f223df0ff5.virgil_ent utility::ent_flag_set( "flag_virgil_attack_charge_bomb" );
    wrist_tag = level.var_70a8f1f223df0ff5.virgil_ent gettagorigin( "tag_accessory_right" );
    var_9c2f327f029305e9 = function_a745aeb63d0f9d09( wrist_tag );
    assert( isdefined( var_9c2f327f029305e9 ), "<dev string:x24>" );
    var_9c2f327f029305e9.mover_ent = utility::spawn_model( "tag_origin", wrist_tag );
    var_9c2f327f029305e9.mover_ent linkto( level.var_70a8f1f223df0ff5.virgil_ent, "tag_accessory_right", ( 400.036, -96.2863, 512.747 ), ( 0, 0, 0 ) );
    var_9c2f327f029305e9 linkto( var_9c2f327f029305e9.mover_ent, "tag_origin" );
    level thread start_charge_bomb( var_9c2f327f029305e9, arena_section );
    scene_name = "virgil_ice_bomb";
    
    if ( arena_section == "left" )
    {
        scene_name = "virgil_ice_bomb_right";
    }
    else if ( arena_section == "right" )
    {
        scene_name = "virgil_ice_bomb_left";
    }
    
    level.var_70a8f1f223df0ff5.virgil_ent zombie_boss_virgil::function_682e7757f916b296( scene_name );
    level.var_70a8f1f223df0ff5.var_c71ebeffbde62e9 = gettime();
    level.var_70a8f1f223df0ff5.virgil_ent utility::ent_flag_clear( "flag_virgil_attack_charge_bomb" );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 2, eflags: 0x4
// Checksum 0xa3b8b763, Offset: 0xcfb
// Size: 0x149
function private start_charge_bomb( var_9c2f327f029305e9, arena_section )
{
    var_9c2f327f029305e9.attack_info.arena_section = arena_section;
    level.var_70a8f1f223df0ff5.active_bombs[ arena_section ] = var_9c2f327f029305e9;
    level.var_70a8f1f223df0ff5.available_sections = arrayremove( level.var_70a8f1f223df0ff5.available_sections, arena_section );
    level notify( #"hash_d1b96c38eb3bb123", var_9c2f327f029305e9 );
    explosion_target = get_explosion_target_location( arena_section );
    
    if ( arena_section == "center" )
    {
        var_a00e9991d1f66d7b = vectornormalize2( level.var_70a8f1f223df0ff5.virgil_ent.origin - explosion_target );
        explosion_target += var_a00e9991d1f66d7b * 300;
    }
    
    var_9c2f327f029305e9.warning_scriptable = spawnscriptable( %"sat_zombie_virgil_charge_bomb_warning", explosion_target );
    explosion_target = get_explosion_target_location( arena_section );
    var_9c2f327f029305e9 game_utility::questcircle_create( "Airstrike", explosion_target, level.var_70a8f1f223df0ff5.var_3b4886bf8b6e1cb2 );
    var_9c2f327f029305e9 game_utility::questcircle_showtoall();
    level thread move_bomb( var_9c2f327f029305e9 );
    level thread set_rotation_speed( var_9c2f327f029305e9, 1000 );
    level thread rotate_bomb( var_9c2f327f029305e9 );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0x4
// Checksum 0x34e55284, Offset: 0xe4c
// Size: 0x14a
function private rotate_bomb( var_9c2f327f029305e9 )
{
    level.var_70a8f1f223df0ff5.virgil_ent endon( #"death" );
    var_9c2f327f029305e9 endon( #"charge_bomb_complete", #"death", #"destroyed" );
    current_angle = 0;
    previous_time_ms = gettime();
    current_time_ms = gettime();
    
    while ( isdefined( var_9c2f327f029305e9 ) )
    {
        current_time_ms = gettime();
        elapsed_time_sec = ( current_time_ms - previous_time_ms ) * 0.001;
        previous_time_ms = gettime();
        current_angle = math::wrap( 0, 360, current_angle + elapsed_time_sec * var_9c2f327f029305e9.attack_info.var_c464a2d2aa68df50 );
        x = cos( current_angle ) + var_9c2f327f029305e9.origin[ 0 ];
        y = sin( current_angle ) + var_9c2f327f029305e9.origin[ 1 ];
        vector = ( x, y, 0 ) - ( var_9c2f327f029305e9.origin[ 0 ], var_9c2f327f029305e9.origin[ 1 ], 0 );
        new_angles = vectortoangles( vector );
        var_9c2f327f029305e9.angles = new_angles;
        waitframe();
    }
}

// Namespace namespace_589ae4efe3ba85ad
// Params 3, eflags: 0x4
// Checksum 0xc1c52f42, Offset: 0xf9e
// Size: 0x126
function private set_rotation_speed( var_9c2f327f029305e9, new_speed, immediate = 0 )
{
    level.var_70a8f1f223df0ff5.virgil_ent endon( #"death" );
    var_9c2f327f029305e9 endon( #"charge_bomb_complete", #"death", #"destroyed" );
    
    if ( immediate )
    {
        var_9c2f327f029305e9.attack_info.var_c464a2d2aa68df50 = new_speed;
        return;
    }
    
    current_fraction = 0;
    var_a5cf3d3c65f1eb42 = var_9c2f327f029305e9.attack_info.var_c464a2d2aa68df50;
    previous_time_ms = gettime();
    current_time_ms = gettime();
    
    while ( current_fraction < 1 )
    {
        current_time_ms = gettime();
        elapsed_time_sec = ( current_time_ms - previous_time_ms ) * 0.001;
        previous_time_ms = gettime();
        current_fraction = clamp( current_fraction + 3 * elapsed_time_sec, 0, 1 );
        var_9c2f327f029305e9.attack_info.var_c464a2d2aa68df50 = math::lerp( var_a5cf3d3c65f1eb42, new_speed, current_fraction );
        waitframe();
    }
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0xf88552a6, Offset: 0x10cc
// Size: 0x1bb
function move_bomb( var_9c2f327f029305e9 )
{
    level.var_70a8f1f223df0ff5.virgil_ent endon( #"death" );
    var_9c2f327f029305e9 endon( #"charge_bomb_complete", #"death", #"destroyed" );
    start_time_ms = gettime();
    end_time_ms = gettime() + level.var_70a8f1f223df0ff5.var_b23e3516c966f449 * 1000;
    arena_section = var_9c2f327f029305e9.attack_info.arena_section;
    
    while ( gettime() < end_time_ms )
    {
        charge_frag = math::lerp_fraction( start_time_ms, end_time_ms, gettime() );
        var_9c2f327f029305e9.attack_info.charge_percent = clamp( math::lerp( 0, 1, charge_frag ), 0, 1 );
        waitframe();
    }
    
    var_9c2f327f029305e9.attack_info.charge_percent = 1;
    var_9c2f327f029305e9.mover_ent unlink();
    var_9c2f327f029305e9 setscriptablepartstate( #"sfx", #"released" );
    end_location = level.var_70a8f1f223df0ff5.var_3fffcec324ffd967[ arena_section ];
    end_location = ( end_location[ 0 ], end_location[ 1 ], var_9c2f327f029305e9.origin[ 2 ] );
    var_9c2f327f029305e9.mover_ent moveto( end_location, level.var_70a8f1f223df0ff5.var_e9b78c701ef2f30b, level.var_70a8f1f223df0ff5.var_e9b78c701ef2f30b, 0 );
    wait level.var_70a8f1f223df0ff5.var_e9b78c701ef2f30b;
    level thread function_4268ec65442d96f4( var_9c2f327f029305e9 );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0x4
// Checksum 0xc8735962, Offset: 0x128f
// Size: 0xc6
function private function_4268ec65442d96f4( var_9c2f327f029305e9 )
{
    arena_section = var_9c2f327f029305e9.attack_info.arena_section;
    origin = var_9c2f327f029305e9.origin + anglestoup( var_9c2f327f029305e9.angles ) * 150;
    explosion_target = get_explosion_target_location( arena_section );
    var_9c2f327f029305e9 setscriptablepartstate( #"fx", #"exploded" );
    var_9c2f327f029305e9 setscriptablepartstate( #"sfx", #"exploded" );
    mapcircle = var_9c2f327f029305e9.mapcircle;
    level thread cleanup_bomb( var_9c2f327f029305e9 );
    level thread function_e63fee8ab75d47ff( origin, arena_section, explosion_target, mapcircle );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 4, eflags: 0x4
// Checksum 0x6e1d868b, Offset: 0x135d
// Size: 0x150
function private function_e63fee8ab75d47ff( origin, arena_section, explosion_target, mapcircle )
{
    var_7319158b7beb9866 = level.var_70a8f1f223df0ff5.var_8f6ae9782c211e64;
    level utility::delaythread( 1, &zombie_boss_virgil::function_9c386609d0280bef, #"charge_bomb_first" );
    level thread function_1b3b1e19edd93973( origin, arena_section, explosion_target, var_7319158b7beb9866 );
    wait level.var_70a8f1f223df0ff5.var_ca70d7f094a6992;
    cloud_radius = level.var_70a8f1f223df0ff5.var_3b4886bf8b6e1cb2;
    
    if ( !level.var_70a8f1f223df0ff5.var_bd844df41dc333e5 )
    {
        duration_sec = level.var_70a8f1f223df0ff5.var_4801b090b89242dc ?? level.var_70a8f1f223df0ff5.var_5642fdda94827df7;
        level thread function_9c7e33594e7bde33( explosion_target, cloud_radius, duration_sec, arena_section, mapcircle );
        return;
    }
    
    if ( isdefined( mapcircle ) )
    {
        var_f3517ca4bbc066cc = { #mapcircle:mapcircle };
        var_f3517ca4bbc066cc game_utility::questcircle_delete();
    }
    
    level.var_70a8f1f223df0ff5.available_sections = arraycombineunique( level.var_70a8f1f223df0ff5.available_sections, [ arena_section ] );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0
// Checksum 0xc6943ad2, Offset: 0x14b5
// Size: 0x18
function function_19acc91d6a304892()
{
    level.var_70a8f1f223df0ff5.var_bd844df41dc333e5 = 1;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0
// Checksum 0x22ccd916, Offset: 0x14d5
// Size: 0x17
function function_56921e1013df3e11()
{
    level.var_70a8f1f223df0ff5.var_bd844df41dc333e5 = 0;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0x9f2776cd, Offset: 0x14f4
// Size: 0x22
function function_41f5e51182a17fdc( duration_sec )
{
    level.var_70a8f1f223df0ff5.var_4801b090b89242dc = duration_sec;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0x90a27270, Offset: 0x151e
// Size: 0xa6
function function_467c4559cdf2ff63( duration )
{
    arena_sections = [ "left", "center", "right" ];
    
    foreach ( section in arena_sections )
    {
        level thread function_b2001ff146fd19db( section, duration );
    }
}

// Namespace namespace_589ae4efe3ba85ad
// Params 2
// Checksum 0xad490b7, Offset: 0x15cc
// Size: 0x49
function function_b2001ff146fd19db( section, duration )
{
    explosion_target = get_explosion_target_location( section );
    level thread function_9c7e33594e7bde33( explosion_target, level.var_70a8f1f223df0ff5.var_3b4886bf8b6e1cb2, duration, section );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 5
// Checksum 0x421c6d40, Offset: 0x161d
// Size: 0x114
function function_9c7e33594e7bde33( spawn_position, radius, duration, arena_section = undefined, mapcircle = undefined )
{
    var_4c8067abeed44ee5 = utility::spawn_model( "tag_origin", spawn_position );
    var_4c8067abeed44ee5.radius = radius;
    var_4c8067abeed44ee5.arena_section = arena_section ?? "other";
    var_4c8067abeed44ee5.mapcircle = mapcircle;
    var_4c8067abeed44ee5.scriptable = spawnscriptable( %"sat_zombie_virgil_charge_bomb_ice_cloud", spawn_position, ( 0, 0, 0 ), undefined );
    var_4c8067abeed44ee5.scriptable utility::scriptable_setparententity( var_4c8067abeed44ee5 );
    var_4c8067abeed44ee5 thread callback::callback( #"hash_70700a7ae0ffa528", { #arena_section:arena_section, #duration:duration, #radius:radius, #position:spawn_position } );
    level thread function_17137dc16656398( var_4c8067abeed44ee5, duration );
    return var_4c8067abeed44ee5;
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0xdd1a2601, Offset: 0x173a
// Size: 0xc5
function function_239425f180f5a7fe( var_4c8067abeed44ee5 )
{
    level.var_70a8f1f223df0ff5.active_clouds = arrayremove( level.var_70a8f1f223df0ff5.active_clouds, var_4c8067abeed44ee5 );
    level notify( #"cloud_removed", var_4c8067abeed44ee5 );
    
    if ( var_4c8067abeed44ee5.arena_section != "other" )
    {
        level.var_70a8f1f223df0ff5.available_sections = arraycombineunique( level.var_70a8f1f223df0ff5.available_sections, [ var_4c8067abeed44ee5.arena_section ] );
    }
    
    if ( isdefined( var_4c8067abeed44ee5.mapcircle ) )
    {
        var_4c8067abeed44ee5 game_utility::questcircle_delete();
    }
    
    var_4c8067abeed44ee5.scriptable freescriptable();
    var_4c8067abeed44ee5 delete();
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0
// Checksum 0xd800c32d, Offset: 0x1807
// Size: 0x86
function function_950d4585ce2b2a46()
{
    foreach ( var_4c8067abeed44ee5 in level.var_70a8f1f223df0ff5.active_clouds )
    {
        level thread function_239425f180f5a7fe( var_4c8067abeed44ee5 );
    }
}

// Namespace namespace_589ae4efe3ba85ad
// Params 2, eflags: 0x4
// Checksum 0x35677630, Offset: 0x1895
// Size: 0xa4
function private function_17137dc16656398( var_4c8067abeed44ee5, duration )
{
    level endon( #"game_ended" );
    level.var_70a8f1f223df0ff5.virgil_ent endon( #"death" );
    var_4c8067abeed44ee5 endon( #"death" );
    level.var_70a8f1f223df0ff5.active_clouds[ var_4c8067abeed44ee5.arena_section ] = var_4c8067abeed44ee5;
    
    /#
        var_4c8067abeed44ee5 thread function_2a761b15842e14d6( var_4c8067abeed44ee5.origin, var_4c8067abeed44ee5.radius );
    #/
    
    level thread function_f25b7407f96c0ccd();
    wait duration;
    function_239425f180f5a7fe( var_4c8067abeed44ee5 );
}

/#

    // Namespace namespace_589ae4efe3ba85ad
    // Params 2
    // Checksum 0x9b2b0e11, Offset: 0x1941
    // Size: 0x44, Type: dev
    function function_2a761b15842e14d6( origin, radius )
    {
        self endon( #"death" );
        
        while ( true )
        {
            sphere( origin, radius, ( 0, 0.3, 1 ), 1 );
            waitframe();
        }
    }

#/

// Namespace namespace_589ae4efe3ba85ad
// Params 1
// Checksum 0xb567a67b, Offset: 0x198d
// Size: 0x2b
function function_7ed660c91ba7ca82( player )
{
    return level.var_70a8f1f223df0ff5.var_800286aff6c4430f[ player.entnum ];
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0, eflags: 0xc
// Checksum 0x9ebe244b, Offset: 0x19c1
// Size: 0x3ce
function private function_f25b7407f96c0ccd()
{
    self notify( #"hash_9ee025cad3ca4bc" );
    self endon( #"hash_9ee025cad3ca4bc" );
    level endon( #"game_ended" );
    
    while ( level.var_70a8f1f223df0ff5.active_clouds.size > 0 )
    {
        var_d484283622dca01c = [];
        
        foreach ( cloud in level.var_70a8f1f223df0ff5.active_clouds )
        {
            var_abc7d89aaa45b1cc = getplayersinradius( cloud.origin, cloud.radius );
            
            foreach ( player in var_abc7d89aaa45b1cc )
            {
                var_a7b0c92db5d80a70 = player callback::response( 0, #"hash_890a266bc5d64b1b", { #cloud:cloud, #player:player } );
                
                if ( !level.var_70a8f1f223df0ff5.var_800286aff6c4430f[ player.entnum ] )
                {
                    level.var_70a8f1f223df0ff5.var_800286aff6c4430f[ player.entnum ] = player;
                }
                
                if ( !var_a7b0c92db5d80a70 && !player.var_e5557a1483620915 )
                {
                    level thread function_8c7b9b9da0fc6edf( player );
                }
                else if ( var_a7b0c92db5d80a70 && player.var_e5557a1483620915 && !level.var_70a8f1f223df0ff5.virgil_ent utility::ent_flag( "flag_virgil_freeze_effects_active" ) )
                {
                    level thread function_a09504af23da06b0( player );
                }
                
                var_d484283622dca01c[ player.entnum ] = player;
            }
        }
        
        foreach ( player in level.var_70a8f1f223df0ff5.var_800286aff6c4430f )
        {
            if ( !var_d484283622dca01c[ player.entnum ] )
            {
                if ( !level.var_70a8f1f223df0ff5.virgil_ent utility::ent_flag( "flag_virgil_freeze_effects_active" ) )
                {
                    level thread function_a09504af23da06b0( player );
                }
                
                level.var_70a8f1f223df0ff5.var_800286aff6c4430f[ player.entnum ] = undefined;
            }
        }
        
        wait level.var_70a8f1f223df0ff5.var_b7495b947564d29a;
    }
    
    foreach ( player in level.var_70a8f1f223df0ff5.var_800286aff6c4430f )
    {
        if ( !level.var_70a8f1f223df0ff5.virgil_ent utility::ent_flag( "flag_virgil_freeze_effects_active" ) )
        {
            function_a09504af23da06b0( player );
        }
    }
    
    level.var_70a8f1f223df0ff5.var_800286aff6c4430f = [];
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0xc
// Checksum 0x36f8a7c6, Offset: 0x1d97
// Size: 0x5a
function private function_8c7b9b9da0fc6edf( player )
{
    self notify( #"hash_5628041a5b17edf0" );
    self endon( #"hash_5628041a5b17edf0" );
    player thread zombie_boss_virgil::function_8c7b9b9da0fc6edf( player );
    level.var_70a8f1f223df0ff5.virgil_ent utility::ent_flag_set( "flag_virgil_freeze_periodic_damage_active" );
    player notify( #"player_enter_cloud" );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0x4
// Checksum 0xa7f44ce5, Offset: 0x1df9
// Size: 0x23
function private function_a09504af23da06b0( player )
{
    player thread zombie_boss_virgil::function_a09504af23da06b0( player );
    player notify( #"hash_8ff6d3fdcb20e7c3" );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0x4
// Checksum 0x4a7ea8e8, Offset: 0x1e24
// Size: 0x5a
function private function_f0b44d3e45c3ff2b( var_9c2f327f029305e9 )
{
    cleanup_bomb( var_9c2f327f029305e9 );
    level.var_70a8f1f223df0ff5.available_sections = arraycombineunique( level.var_70a8f1f223df0ff5.available_sections, [ var_9c2f327f029305e9.attack_info.arena_section ] );
}

// Namespace namespace_589ae4efe3ba85ad
// Params 0, eflags: 0x4
// Checksum 0x8e070dd3, Offset: 0x1e86
// Size: 0x1ed
function private function_e362aa79fe014b72()
{
    var_fb5d3c9269080a09 = 137.5;
    level endon( #"game_ended" );
    level.var_70a8f1f223df0ff5.virgil_ent endon( #"death" );
    arena_sections = [ "left", "center", "right" ];
    
    foreach ( section in arena_sections )
    {
        if ( section == "right" || "left" )
        {
            projectile_radius = level.var_70a8f1f223df0ff5.var_3b4886bf8b6e1cb2 * 0.7;
        }
        else
        {
            projectile_radius = level.var_70a8f1f223df0ff5.var_3b4886bf8b6e1cb2;
        }
        
        explosion_target_location = get_explosion_target_location( section );
        var_81cb28a61e76c30d = level.var_70a8f1f223df0ff5.var_8f6ae9782c211e64;
        
        for ( i = 1; i <= var_81cb28a61e76c30d ; i++ )
        {
            new_angle = i * var_fb5d3c9269080a09;
            new_radius = projectile_radius * sqrt( i / var_81cb28a61e76c30d );
            x = new_radius * cos( new_angle );
            y = new_radius * sin( new_angle );
            target_pos = explosion_target_location + ( x, y, 0 );
            level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ section ][ level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ section ].size ] = target_pos;
            waitframe();
        }
    }
}

// Namespace namespace_589ae4efe3ba85ad
// Params 4, eflags: 0x4
// Checksum 0x17ec3dbe, Offset: 0x207b
// Size: 0x106
function private function_1b3b1e19edd93973( bomb_origin, arena_section, explosion_target, var_7319158b7beb9866 )
{
    if ( var_7319158b7beb9866 > level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ arena_section ].size )
    {
        var_7319158b7beb9866 = level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ arena_section ].size;
    }
    
    var_b42c5d63ae066ddf = 25;
    var_3745ee66399ffa7 = 0;
    
    for ( i = 0; i < var_7319158b7beb9866 ; i++ )
    {
        projectile_target = level.var_70a8f1f223df0ff5.var_2b9c6d9df6cb7899[ arena_section ][ i ];
        vector = projectile_target - bomb_origin;
        projectile = magicbullet( "sat_zombie_virgil_ice_spike_volley_attack", bomb_origin, bomb_origin + vector, level.var_70a8f1f223df0ff5.virgil_ent );
        projectile missile_settargetpos( projectile_target );
        projectile missile_setflightmodedirect();
        var_3745ee66399ffa7++;
        
        if ( var_3745ee66399ffa7 >= var_b42c5d63ae066ddf )
        {
            waitframe();
            var_3745ee66399ffa7 = 0;
        }
    }
}

// Namespace namespace_589ae4efe3ba85ad
// Params 4
// Checksum 0x97a05376, Offset: 0x2189
// Size: 0x237
function setup_arena_properties( charge_bomb_spawn_loc, charge_bomb_end_loc, charge_bomb_explosion_loc, var_26827aa210cb773e )
{
    var_45993faa5d2faf05 = utility::getstructarray( charge_bomb_spawn_loc.target, "targetname" );
    
    foreach ( var_399a0f97e8cb8e0b in var_45993faa5d2faf05 )
    {
        level.var_70a8f1f223df0ff5.bomb_spawn_locations[ var_399a0f97e8cb8e0b.script_noteworthy ] = var_399a0f97e8cb8e0b.origin;
    }
    
    var_1b267a12c794f23b = utility::getstructarray( charge_bomb_end_loc.target, "targetname" );
    
    foreach ( var_399a0f97e8cb8e0b in var_1b267a12c794f23b )
    {
        level.var_70a8f1f223df0ff5.var_3fffcec324ffd967[ var_399a0f97e8cb8e0b.script_noteworthy ] = var_399a0f97e8cb8e0b.origin;
    }
    
    var_aa2bc05ad18bdb99 = utility::getstructarray( charge_bomb_explosion_loc.target, "targetname" );
    
    foreach ( var_399a0f97e8cb8e0b in var_aa2bc05ad18bdb99 )
    {
        level.var_70a8f1f223df0ff5.bomb_explosion_locations[ var_399a0f97e8cb8e0b.script_noteworthy ] = var_399a0f97e8cb8e0b.origin;
    }
    
    level thread function_e362aa79fe014b72();
}

// Namespace namespace_589ae4efe3ba85ad
// Params 1, eflags: 0x4
// Checksum 0xc237cb53, Offset: 0x23c8
// Size: 0x73
function private get_explosion_target_location( arena_section )
{
    explosion_target = level.var_70a8f1f223df0ff5.bomb_explosion_locations[ arena_section ];
    var_5887294724d68aff = vectornormalize2( level.var_70a8f1f223df0ff5.bomb_explosion_locations[ arena_section ] - level.var_70a8f1f223df0ff5.bomb_spawn_locations[ arena_section ] );
    explosion_target += var_5887294724d68aff * 0;
    return explosion_target;
}

/#

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x4a1bd2e5, Offset: 0x2444
    // Size: 0x134, Type: dev
    function private attack_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x46>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x94>", "<dev string:x99>" + "<dev string:xbb>", &function_7ec988662988b6ec );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc1>", "<dev string:x99>" + "<dev string:xc8>", &function_7ec988662988b6ec );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd0>", "<dev string:x99>" + "<dev string:xd6>", &function_7ec988662988b6ec );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xdd>" );
        devgui::add_devgui_func( "<dev string:x94>", "<dev string:x13a>", &function_995b1fcfdb231f61 );
        devgui::add_devgui_func( "<dev string:xc1>", "<dev string:x162>", &function_5cc8234636843619 );
        devgui::add_devgui_func( "<dev string:xd0>", "<dev string:x18c>", &function_3314016b70478842 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x1b5>" );
        devgui::add_devgui_func( "<dev string:x1f2>", "<dev string:x20b>", &function_70928de83febd9e8 );
        devgui::add_devgui_func( "<dev string:x225>", "<dev string:x23a>", &function_8ee3fb485edeefc1 );
        devgui::add_devgui_func( "<dev string:x24f>", "<dev string:x264>", &function_a259efea1556dec4 );
        devgui::add_devgui_func( "<dev string:x279>", "<dev string:x291>", &function_815f11518d93ca63 );
        devgui::function_77df7fe7dd273e10();
        level thread update_dvars_loop();
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 1, eflags: 0x4
    // Checksum 0x3507efa0, Offset: 0x2580
    // Size: 0x5f, Type: dev
    function private function_7ec988662988b6ec( params )
    {
        switch ( params[ 0 ] )
        {
            case #"hash_c9b3133a17a3b2d0":
                level thread function_488410abe0f0070c();
                break;
            case #"hash_bf1a695c21e57fe4":
                level thread function_da3844bb35422870();
                break;
            case #"hash_96815ce4f2a3dbc5":
                level thread function_626ec70587f9a779();
                break;
        }
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 1, eflags: 0x4
    // Checksum 0x105438d3, Offset: 0x25e7
    // Size: 0x4e, Type: dev
    function private function_952ada68c7076267( arena_section )
    {
        bomb_end_location = level.var_70a8f1f223df0ff5.var_3fffcec324ffd967[ arena_section ];
        explosion_target_location = get_explosion_target_location( arena_section );
        function_e63fee8ab75d47ff( bomb_end_location, arena_section, explosion_target_location );
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x51cec592, Offset: 0x263d
    // Size: 0x11, Type: dev
    function private function_995b1fcfdb231f61()
    {
        function_952ada68c7076267( "<dev string:x2a9>" );
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x6a2bc7d9, Offset: 0x2656
    // Size: 0x11, Type: dev
    function private function_5cc8234636843619()
    {
        function_952ada68c7076267( "<dev string:x2ae>" );
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x530a361b, Offset: 0x266f
    // Size: 0x11, Type: dev
    function private function_3314016b70478842()
    {
        function_952ada68c7076267( "<dev string:x2b5>" );
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0xf3366ac3, Offset: 0x2688
    // Size: 0xaf, Type: dev
    function private function_a259efea1556dec4()
    {
        foreach ( bomb in level.var_70a8f1f223df0ff5.active_bombs )
        {
            function_3bf0ac1a8abdaae0( bomb );
            bomb.attack_info.charge_percent = 1;
            wait 0.25;
            function_4268ec65442d96f4( bomb );
        }
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x5016223, Offset: 0x273f
    // Size: 0x98, Type: dev
    function private function_815f11518d93ca63()
    {
        foreach ( bomb in level.var_70a8f1f223df0ff5.active_bombs )
        {
            function_3bf0ac1a8abdaae0( bomb );
            wait 0.25;
            level thread function_f0b44d3e45c3ff2b( bomb );
        }
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 1, eflags: 0x4
    // Checksum 0x1cdead99, Offset: 0x27df
    // Size: 0x48, Type: dev
    function private function_3bf0ac1a8abdaae0( bomb )
    {
        end_pos = level.var_70a8f1f223df0ff5.var_3fffcec324ffd967[ bomb.arena_section ];
        bomb.origin = end_pos;
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x9f5d9525, Offset: 0x282f
    // Size: 0x11, Type: dev
    function private function_488410abe0f0070c()
    {
        function_caa813b1b18fec04( "<dev string:x2a9>" );
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x611f18ba, Offset: 0x2848
    // Size: 0x11, Type: dev
    function private function_da3844bb35422870()
    {
        function_caa813b1b18fec04( "<dev string:x2ae>" );
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x7adbbd1a, Offset: 0x2861
    // Size: 0x11, Type: dev
    function private function_626ec70587f9a779()
    {
        function_caa813b1b18fec04( "<dev string:x2b5>" );
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x8622c5b3, Offset: 0x287a
    // Size: 0x97, Type: dev
    function private function_70928de83febd9e8()
    {
        foreach ( bomb in level.var_70a8f1f223df0ff5.active_bombs )
        {
            bomb.attack_info.charge_percent = 1;
        }
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0x4
    // Checksum 0x9365a78f, Offset: 0x2919
    // Size: 0x88, Type: dev
    function private function_8ee3fb485edeefc1()
    {
        foreach ( bomb in level.var_70a8f1f223df0ff5.active_bombs )
        {
            cleanup_bomb( bomb );
        }
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 0, eflags: 0xc
    // Checksum 0x5ebd9a1a, Offset: 0x29a9
    // Size: 0x12d, Type: dev
    function private update_dvars_loop()
    {
        self notify( #"hash_1db789d66fa6c8b6" );
        self endon( #"hash_1db789d66fa6c8b6" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            level.var_70a8f1f223df0ff5.var_e9b78c701ef2f30b = getdvarfloat( @"hash_4fc81edb80cf4da0", 1 );
            level.var_70a8f1f223df0ff5.var_51e5b3c2fb68959c = getdvarfloat( @"hash_45bf6354ba52ee5", 1 );
            level.var_70a8f1f223df0ff5.var_5642fdda94827df7 = getdvarfloat( @"hash_ec5aeb64e815290a", 50 );
            level.var_70a8f1f223df0ff5.var_ca70d7f094a6992 = getdvarfloat( @"hash_4ed36cc73b6d7445", 1 );
            level.var_70a8f1f223df0ff5.var_b7495b947564d29a = getdvarfloat( @"hash_3602c3a0e541b743", 1 );
            level.var_70a8f1f223df0ff5.var_3b4886bf8b6e1cb2 = getdvarint( @"hash_ac72df6d6d18bd3", 950 );
            level.var_70a8f1f223df0ff5.var_b23e3516c966f449 = getdvarfloat( @"hash_1b5b213d6c1ccbbe", 5 );
            wait 0.5;
        }
    }

    // Namespace namespace_589ae4efe3ba85ad
    // Params 1, eflags: 0x4
    // Checksum 0x42eccd52, Offset: 0x2ade
    // Size: 0xaf, Type: dev
    function private debug_print_charge( var_9c2f327f029305e9 )
    {
        var_9c2f327f029305e9 endon( #"death", #"destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_ff24f99d40e48d83", 0 ) )
            {
                print3d( var_9c2f327f029305e9.origin + ( 0, 0, 200 ), "<dev string:x2bb>" + var_9c2f327f029305e9.attack_info.charge_percent * 100, ( 0, 1, 0 ), 1, 5 );
                println( "<dev string:x2cc>" + var_9c2f327f029305e9.attack_info.charge_percent * 100 );
            }
            
            waitframe();
        }
    }

#/
