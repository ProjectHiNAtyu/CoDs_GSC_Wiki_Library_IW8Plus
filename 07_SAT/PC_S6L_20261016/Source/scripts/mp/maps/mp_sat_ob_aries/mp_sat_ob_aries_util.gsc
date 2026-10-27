// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util.gsc  (hash_3256648b54dbcce4.gscc) (size: 39915 Bytes / 0x9beb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4e3a232 (3303252530)
// size ...... 39915 (0x9beb)
// includes .. 19  (offset: 0x92b7)
// strings ... 138 (offset: 0x934f)
// dev strs .. 7   (offset: 0x9b8f)
// exports ... 118 (offset: 0x6133)
// cseg ...... 0xe36 + 0x52fd (0x6133)
// imports ... 239 (offset: 0x73a3)
// animtree1 . 0   (offset: 0x9beb)
// animtree2 . 0   (offset: 0x9beb)
#using script_61b40095fd0502f0;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\aries_boss\aries_boss;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\vision_utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_boss;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_weakpoint;
#using scripts\mp\mp_agent;

#namespace aries_util;

// Namespace aries_util
// Params 1
// Checksum 0xb78f9239, Offset: 0xe54
// Size: 0x18
function player_setup( params )
{
    ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm_reduced_mag_fov" );
}

// Namespace aries_util
// Params 1
// Checksum 0x92991b70, Offset: 0xe74
// Size: 0x26
function function_d77f848569c2ad76( params )
{
    ob_story_mission_utils::function_2383fc8bfc3074d2();
    ob_story_mission_utils::function_288fdad79fa2a11();
    ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm_reduced_mag_fov" );
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x62646e99, Offset: 0xea2
    // Size: 0x5, Type: dev
    function function_b358eb22ab4a751()
    {
        
    }

#/

// Namespace aries_util
// Params 0
// Checksum 0x2f1eac28, Offset: 0xeaf
// Size: 0x67
function function_97223bf7668b6f43()
{
    activity_instance = self;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( level.players[ 0 ].team, level.players[ 0 ].sessionsquadid );
    activity_instance thread function_db2cc34407899e7( var_64bb57aa2d6e8b35 );
    activity_instance thread function_aef4822eb8341ab1( var_64bb57aa2d6e8b35 );
    activity_instance thread function_8b4b3f114e609cc2( var_64bb57aa2d6e8b35 );
}

// Namespace aries_util
// Params 1
// Checksum 0xbb261148, Offset: 0xf1e
// Size: 0xc2
function function_db2cc34407899e7( var_64bb57aa2d6e8b35 )
{
    level endon( #"aries_boss_phasetwo_complete" );
    level utility::flag_wait( "flag_mars_hint_growths" );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_aries_nightmare_growth", &"sat_ob/hint_aries_nightmare_growth", 10 );
    }
}

// Namespace aries_util
// Params 1
// Checksum 0xd6164e5c, Offset: 0xfe8
// Size: 0xc5
function function_aef4822eb8341ab1( var_64bb57aa2d6e8b35 )
{
    level endon( #"aries_boss_phasethree_complete" );
    level utility::flag_wait( "flag_mars_hint_boss" );
    wait 10;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_aries_nightmare_growth", &"sat_ob/hint_aries_nightmare_growth", 10 );
    }
}

// Namespace aries_util
// Params 1
// Checksum 0xd43e2b8d, Offset: 0x10b5
// Size: 0xc5
function function_8b4b3f114e609cc2( var_64bb57aa2d6e8b35 )
{
    level endon( #"aries_boss_phasethree_complete" );
    level utility::flag_wait( "flag_mars_hint_head" );
    wait 5;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_aries_nightmare_head", &"sat_ob/hint_aries_nightmare_head", 10 );
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xfb473558, Offset: 0x1182
    // Size: 0x5, Type: dev
    function function_9e79afaa2768d1b()
    {
        
    }

#/

// Namespace aries_util
// Params 1
// Checksum 0xc186ceee, Offset: 0x118f
// Size: 0x1d
function getplayercount( activity_instance )
{
    level.playercount = activity_instance_common::function_be0fb090edaf64f( activity_instance );
}

// Namespace aries_util
// Params 2
// Checksum 0x37b554d, Offset: 0x11b4
// Size: 0xeb
function function_619b5a0410cf1a0a( str_ent_array, var_10d0ec8539ca87f8 )
{
    a_ents = getentarray( str_ent_array, #targetname );
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) )
        {
            switch ( var_10d0ec8539ca87f8 )
            {
                case #"hash_7ebb454a971d80d":
                    ent hide();
                    break;
                case #"hash_ca51c18a00a0a89c":
                    ent show();
                    break;
                case #"hash_897c0184865c23aa":
                    ent delete();
                    break;
            }
        }
    }
    
    return a_ents;
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x9edcc0b2, Offset: 0x12a8
    // Size: 0xf, Type: dev
    function function_1fba812dff471090()
    {
        iprintln( "<dev string:x24>" );
    }

#/

// Namespace aries_util
// Params 0
// Checksum 0xbc7c769c, Offset: 0x12bf
// Size: 0xbe
function function_862a02480e506c14()
{
    found_wpn = self getcurrentweapon();
    
    if ( found_wpn.basename != "sat_wpn_prop_grappling_gun" )
    {
        var_a8124a64ed911c19 = self getweaponslistprimaries();
        
        foreach ( equipped_wpn in var_a8124a64ed911c19 )
        {
            if ( equipped_wpn.basename == "sat_wpn_prop_grappling_gun" )
            {
                found_wpn = equipped_wpn;
                return found_wpn;
            }
        }
        
        return;
    }
    
    return found_wpn;
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xe61233d8, Offset: 0x1386
    // Size: 0x5, Type: dev
    function function_c4ccc89026111873()
    {
        
    }

#/

// Namespace aries_util
// Params 3
// Checksum 0x3189daf2, Offset: 0x1393
// Size: 0x194
function function_fc9b9daf8e49ecb4( var_5a2d888ab5e604d8, var_db7a3c6a5dcdec18, str_dawg_mode )
{
    if ( isdefined( var_db7a3c6a5dcdec18 ) )
    {
        var_78ff46db6d2c6b5f = getent( var_db7a3c6a5dcdec18, #targetname );
        
        if ( isdefined( var_78ff46db6d2c6b5f ) )
        {
            var_78ff46db6d2c6b5f delete();
        }
    }
    
    a_ai_dawgs = [];
    var_263285fff9e45a22 = utility::getstructarray( var_5a2d888ab5e604d8 );
    
    if ( !isdefined( str_dawg_mode ) )
    {
        str_dawg_mode = "attack";
    }
    
    foreach ( struct in var_263285fff9e45a22 )
    {
        dawg = mp_agent::spawnnewagentaitype( "sat_dawg_sm", struct.origin, struct.angles, "team_hundred_ninety" );
        dawg.var_24954f14e27b448d = 1;
        owner = utility::spawn_tag_origin( dawg.origin, dawg.angles );
        owner.team = dawg.team;
        dawg.spawned_tag_origin = owner;
        dawg.mode = str_dawg_mode;
        dawg dawg::dawgpostinit( owner );
        
        if ( isdefined( dawg ) )
        {
            a_ai_dawgs = arraycombineunique( a_ai_dawgs, [ dawg ] );
        }
    }
    
    return a_ai_dawgs;
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x7fad739e, Offset: 0x1530
    // Size: 0x5, Type: dev
    function function_7cd81705b5b3efb7()
    {
        
    }

#/

// Namespace aries_util
// Params 9
// Checksum 0xfd95c374, Offset: 0x153d
// Size: 0x171
function function_e6895f5efd1feb56( player, position_entity, z_offset, obj_marker_bundle, var_ac2c0371b649d62e, flag_endon, timeout, distance_threshold = 1000, b_intro_anim = 0 )
{
    activity_instance = self;
    player endon( #"death_or_disconnect" );
    
    if ( !isdefined( position_entity ) )
    {
        /#
            iprintln( "<dev string:x33>" );
        #/
        
        return;
    }
    
    if ( !isdefined( var_ac2c0371b649d62e ) )
    {
        var_ac2c0371b649d62e = player;
    }
    
    var_ac2c0371b649d62e endon( flag_endon );
    
    if ( isvector( position_entity ) )
    {
        activity_instance thread function_ce0f8dcc997e45f2( player, position_entity, z_offset, var_ac2c0371b649d62e, flag_endon, timeout, b_intro_anim );
    }
    else
    {
        activity_instance thread function_ec449855c495dd2e( player, position_entity, z_offset, var_ac2c0371b649d62e, flag_endon, timeout );
        position_entity = position_entity.origin;
    }
    
    waypoint_active = 0;
    
    if ( distance_threshold >= 0 )
    {
        while ( true )
        {
            if ( !waypoint_active && distance2dsquared( player.origin, position_entity ) < squared( distance_threshold ) )
            {
                player notify( #"show_objective_waypoint" );
                waypoint_active = 1;
            }
            else if ( waypoint_active && distance2dsquared( player.origin, position_entity ) >= squared( distance_threshold ) )
            {
                player notify( #"hide_objective_waypoint" );
                waypoint_active = 0;
            }
            
            waitframe();
        }
        
        return;
    }
    
    player notify( #"show_objective_waypoint" );
}

// Namespace aries_util
// Params 7
// Checksum 0xeae7d050, Offset: 0x16b6
// Size: 0x192
function function_ce0f8dcc997e45f2( player, obj_origin, z_offset, var_ac2c0371b649d62e, flag_endon, timeout, b_intro_anim )
{
    if ( isdefined( timeout ) )
    {
        player endon( #"disconnect" );
    }
    
    activity_instance = self;
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( obj_origin, z_offset, [ player ], undefined, b_intro_anim );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    objective_state( obj_id, "active" );
    
    while ( true )
    {
        if ( !isent( player ) || !isent( var_ac2c0371b649d62e ) )
        {
            break;
        }
        
        msg = utility::waittill_any_ents_return( player, "show_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        
        if ( !arraycontains( activity_instance.a_obj_id, obj_id ) )
        {
            break;
        }
        
        if ( msg == flag_endon )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
        
        objective_state( obj_id, "current" );
        
        if ( isdefined( timeout ) )
        {
            result = utility::function_22939e0bc589604e( timeout, player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        else
        {
            result = utility::waittill_any_ents_return_params( player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        
        objective_state( obj_id, "active" );
        
        if ( result[ "message" ] == flag_endon || result[ "message" ] == "timeout" )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace aries_util
// Params 6
// Checksum 0x5020d168, Offset: 0x1850
// Size: 0x13e
function function_ec449855c495dd2e( player, obj_entity, z_offset, var_ac2c0371b649d62e, flag_endon, timeout )
{
    activity_instance = self;
    obj_id = player ob_story_mission_utils::function_804834359f20ef5a( obj_entity, z_offset, [ player ] );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    objective_state( obj_id, "active" );
    
    while ( true )
    {
        msg = utility::waittill_any_ents_return( player, "show_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        
        if ( msg == flag_endon )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
        
        objective_state( obj_id, "current" );
        
        if ( isdefined( timeout ) )
        {
            result = utility::function_22939e0bc589604e( timeout, player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        else
        {
            result = utility::waittill_any_ents_return_params( player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        
        objective_state( obj_id, "active" );
        
        if ( result[ "message" ] == flag_endon || result[ "message" ] == "timeout" )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
    }
}

// Namespace aries_util
// Params 3
// Checksum 0xb381c616, Offset: 0x1996
// Size: 0x3f
function function_b9cb179f9577f32a( obj_origin, z_offset = 48, a_players )
{
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( obj_origin, z_offset, a_players );
    return obj_id;
}

// Namespace aries_util
// Params 3
// Checksum 0xb381c616, Offset: 0x19de
// Size: 0x3f
function function_804834359f20ef5a( obj_entity, z_offset = 80, a_players )
{
    obj_id = ob_story_mission_utils::function_804834359f20ef5a( obj_entity, z_offset, a_players );
    return obj_id;
}

// Namespace aries_util
// Params 2
// Checksum 0xb381c65c, Offset: 0x1a26
// Size: 0x1f
function objective_marker_show( obj_id, a_players )
{
    ob_story_mission_utils::objective_marker_show( obj_id, a_players );
}

// Namespace aries_util
// Params 2
// Checksum 0xb381c65c, Offset: 0x1a4d
// Size: 0x1f
function objective_marker_hide( obj_id, a_players )
{
    ob_story_mission_utils::objective_marker_hide( obj_id, a_players );
}

// Namespace aries_util
// Params 1
// Checksum 0xb381c601, Offset: 0x1a74
// Size: 0x15
function objective_marker_clear( obj_id )
{
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace aries_util
// Params 3
// Checksum 0x438cb606, Offset: 0x1a91
// Size: 0x76
function function_ab06e28322870f4( obj_origin, var_a0ba6d83e3c5a462, a_players )
{
    if ( !isdefined( self.a_obj_circle ) )
    {
        self.a_obj_circle = [];
    }
    
    obj_circle = spawnquestcircle( "Quest_Ob", obj_origin[ 0 ], obj_origin[ 1 ], var_a0ba6d83e3c5a462, undefined );
    self.a_obj_circle[ self.a_obj_circle.size ] = obj_circle;
    function_ea26b2af32d9cfda( obj_circle, a_players );
    return obj_circle;
}

// Namespace aries_util
// Params 2
// Checksum 0xa9fd6dc0, Offset: 0x1b10
// Size: 0xc8
function function_ea26b2af32d9cfda( obj_circle, a_players )
{
    if ( !isdefined( self.a_obj_circle ) )
    {
        self.a_obj_circle = [];
    }
    
    assert( arraycontains( self.a_obj_circle, obj_circle ), "<dev string:x80>" );
    
    if ( isdefined( a_players ) )
    {
        foreach ( player in a_players )
        {
            obj_circle showtoplayer( player );
        }
        
        return;
    }
    
    obj_circle show();
}

// Namespace aries_util
// Params 2
// Checksum 0x86a98864, Offset: 0x1be0
// Size: 0xc8
function function_2006c93a321c0277( obj_circle, a_players )
{
    if ( !isdefined( self.a_obj_circle ) )
    {
        self.a_obj_circle = [];
    }
    
    assert( arraycontains( self.a_obj_circle, obj_circle ), "<dev string:x80>" );
    
    if ( isdefined( a_players ) )
    {
        foreach ( player in a_players )
        {
            obj_circle hidefromplayer( player );
        }
        
        return;
    }
    
    obj_circle hide();
}

// Namespace aries_util
// Params 1
// Checksum 0x4c1498a0, Offset: 0x1cb0
// Size: 0x5d
function function_352aa3aab98a0618( obj_circle )
{
    if ( !isdefined( self.a_obj_circle ) )
    {
        self.a_obj_circle = [];
    }
    
    assert( arraycontains( self.a_obj_circle, obj_circle ), "<dev string:x80>" );
    self.a_obj_circle = arrayremove( self.a_obj_circle, obj_circle );
    obj_circle delete();
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xce3cfc8c, Offset: 0x1d15
    // Size: 0x5, Type: dev
    function function_aa6d50c92afae467()
    {
        
    }

#/

// Namespace aries_util
// Params 0
// Checksum 0x5422ad2a, Offset: 0x1d22
// Size: 0x31
function function_ff8302797d7d1756()
{
    if ( !level callback::exists( #"player_spawned", &function_403e4a9e87a348e ) )
    {
        level callback::add( #"player_spawned", &function_403e4a9e87a348e );
    }
}

// Namespace aries_util
// Params 0
// Checksum 0xc1c8e369, Offset: 0x1d5b
// Size: 0x30
function function_449d53209415d945()
{
    if ( level callback::exists( #"player_spawned", &function_403e4a9e87a348e ) )
    {
        level callback::remove( #"player_spawned", &function_403e4a9e87a348e );
    }
}

// Namespace aries_util
// Params 1
// Checksum 0x4265b769, Offset: 0x1d93
// Size: 0xa1
function function_403e4a9e87a348e( params )
{
    player = self;
    
    if ( isarray( level.var_5fe1c01595a2e32b ) )
    {
        foreach ( ent_flag in level.var_5fe1c01595a2e32b )
        {
            player utility::ent_flag_set( ent_flag );
        }
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x3ab43691, Offset: 0x1e3c
    // Size: 0x5, Type: dev
    function function_ded0bf811d52af16()
    {
        
    }

#/

// Namespace aries_util
// Params 0
// Checksum 0x5008dfa5, Offset: 0x1e49
// Size: 0x81
function function_41bc1c00b63773ec()
{
    player_rand = utility::array_random( level.players );
    
    if ( !isdefined( player_rand ) || !isdefined( player_rand.origin ) )
    {
        return;
    }
    
    var_e1bcef3f163144fb = getaiarrayinradius( player_rand.origin, 1500, "team_hundred_ninety" );
    [ ai_soldier_closest ] = function_628bac9faa9d1e86( var_e1bcef3f163144fb, player_rand.origin );
    return ai_soldier_closest;
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x62a9d27a, Offset: 0x1ed3
    // Size: 0x5, Type: dev
    function function_5fd65e6377516de()
    {
        
    }

#/

// Namespace aries_util
// Params 0
// Checksum 0x71af1878, Offset: 0x1ee0
// Size: 0x13
function memory_fx_init()
{
    utility::add_fx( "memory_gun_trail", "vfx_sat_mp_ob_ari_cradle_memory_gun_trail_1" );
}

// Namespace aries_util
// Params 0
// Checksum 0x4f46d193, Offset: 0x1efb
// Size: 0x13
function annihilate_fx_init()
{
    utility::add_fx( "annihilate_upside_zombie", "vfx_sat_wc_ai_cradle_soldier_death_01" );
}

// Namespace aries_util
// Params 3
// Checksum 0xe2f679ed, Offset: 0x1f16
// Size: 0x1df
function function_3f8753d47ffa5842( a_waypoints, f_lerp_time, f_delay )
{
    var_a382e2d2eac9a511 = self;
    
    if ( !isdefined( f_delay ) )
    {
        f_delay = 0.1;
    }
    
    wait f_delay;
    
    if ( !isdefined( a_waypoints ) )
    {
        /#
            iprintln( "<dev string:xac>" );
        #/
        
        return;
    }
    
    if ( !isdefined( f_lerp_time ) )
    {
        f_lerp_time = 10;
    }
    
    if ( !isdefined( var_a382e2d2eac9a511.angles ) )
    {
        var_a382e2d2eac9a511.angles = ( 0, 0, 0 );
    }
    
    memory_fx_ent = utility::spawn_tag_origin();
    memory_fx_ent.origin = var_a382e2d2eac9a511.origin;
    memory_fx_ent.angles = var_a382e2d2eac9a511.angles;
    memory_fx_ent show();
    waitframe();
    playfxontag( level._effect[ "memory_gun_trail" ], memory_fx_ent, "tag_origin" );
    
    if ( a_waypoints.size > 1 )
    {
        var_c825b792756a2787 = f_lerp_time / a_waypoints.size;
    }
    else
    {
        var_c825b792756a2787 = f_lerp_time;
    }
    
    foreach ( waypoint in a_waypoints )
    {
        if ( isstring( waypoint ) )
        {
            waypoint_struct = utility::getstruct( waypoint, "targetname" );
        }
        else
        {
            waypoint_struct = waypoint;
        }
        
        if ( waypoint_struct )
        {
            memory_fx_ent moveto( waypoint_struct.origin, var_c825b792756a2787, var_c825b792756a2787 / 4, var_c825b792756a2787 / 4 );
            wait var_c825b792756a2787;
        }
    }
    
    stopfxontag( level._effect[ "memory_gun_trail" ], memory_fx_ent, "tag_origin" );
    waitframe();
    
    if ( isdefined( memory_fx_ent ) )
    {
        memory_fx_ent delete();
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xafc521fa, Offset: 0x20fd
    // Size: 0x5, Type: dev
    function function_3b2e68a5f6e6693d()
    {
        
    }

#/

// Namespace aries_util
// Params 5
// Checksum 0x194a1abf, Offset: 0x210a
// Size: 0x11f
function function_5c470cf8fafe39f5( flag_endon = "aries_river_base_complete", var_e37b688741c97a21 = 8, z_offset = 64, var_4aa6e8871ea33d53 = 5, var_a6842cb15c782315 = 9 )
{
    self endon( #"death" );
    level endon( flag_endon );
    struct = utility::spawn_tag_origin();
    struct.owner = self;
    struct.origin += ( 0, 0, z_offset );
    struct linkto( self );
    remaining_shots = var_e37b688741c97a21;
    
    if ( var_4aa6e8871ea33d53 >= var_a6842cb15c782315 )
    {
        var_4aa6e8871ea33d53 = var_a6842cb15c782315 - 1;
        
        if ( var_4aa6e8871ea33d53 <= 0 )
        {
            var_4aa6e8871ea33d53 = 0;
        }
    }
    
    while ( remaining_shots > 0 )
    {
        wait randomfloatrange( var_4aa6e8871ea33d53, var_a6842cb15c782315 );
        struct thread function_5efc6f07a943c8bb( undefined, remaining_shots );
        remaining_shots--;
    }
    
    if ( isdefined( struct ) )
    {
        struct unlink();
        struct delete();
    }
}

// Namespace aries_util
// Params 0
// Checksum 0x28963361, Offset: 0x2231
// Size: 0x35
function mortars_fx_init()
{
    utility::add_fx( "vfx_sat_wc_libra_mech_mortar_impact", "vfx_t10_levels_sp_storm_stm_explo_mortar_1_runner" );
    utility::add_fx( "vfx_sat_wc_libra_mech_mortar_muz", "vfx_t10_levels_sp_storm_stm_explo_mortar_1_muzzle" );
    utility::add_fx( "vfx_sat_wc_libra_mech_mortar_projectile", "vfx_t10_levels_sp_storm_stm_explo_mortar_1_trail" );
}

// Namespace aries_util
// Params 3
// Checksum 0x83ad460d, Offset: 0x226e
// Size: 0x431
function function_5efc6f07a943c8bb( effect_radius_sq = 48000, var_fd26a7234878ce7c = undefined, b_draw_debug = 0 )
{
    self notify( #"mortars_fired" );
    thread function_a5a571ec2b7b0761();
    contents = trace::create_world_contents();
    down = ( 0, 0, -1 );
    player_target = utility::array_random( ob_story_mission_utils::get_playing_players() );
    
    if ( !isdefined( player_target ) )
    {
        return;
    }
    
    distancefromplayer = 500;
    
    if ( isdefined( var_fd26a7234878ce7c ) )
    {
        if ( var_fd26a7234878ce7c <= 1 )
        {
            distancefromplayer = 100;
        }
        else if ( var_fd26a7234878ce7c < 3 )
        {
            distancefromplayer = 300;
        }
    }
    
    var_6cb5dc4fa6843dfe = self.origin - player_target.origin;
    var_ef9fd8e0b85b020a = length2d( var_6cb5dc4fa6843dfe );
    
    if ( var_ef9fd8e0b85b020a < 1200 )
    {
        var_4bc2b6e1810f74fd = utility::flatten_vector( utility::randomvector( 1 ) );
    }
    else
    {
        if ( var_ef9fd8e0b85b020a < 3000 )
        {
            distancefromplayer = mapfloat( 0, 2166.67, 0, var_ef9fd8e0b85b020a - 500, distancefromplayer );
        }
        
        offset = randomfloatrange( 4, 10 );
        
        if ( utility::cointoss() )
        {
            offset *= -1;
        }
        
        yaw = vectortoangles( vectornormalize( var_6cb5dc4fa6843dfe ) )[ 1 ] + offset;
        var_4bc2b6e1810f74fd = anglestoforward( ( 0, yaw, 0 ) );
    }
    
    var_b5797ee51cfc0469 = player_target.origin + var_4bc2b6e1810f74fd * distancefromplayer;
    var_b5797ee51cfc0469 += utility::randomvector( 100 );
    var_b5797ee51cfc0469 += ( 0, 0, 512 );
    var_24f56bee90b9aed8 = var_b5797ee51cfc0469 + down * 1024;
    var_24f56bee90b9aed8 = getclosestpointonnavmesh( var_24f56bee90b9aed8 );
    start = self.origin;
    end = trace::ray_trace( var_b5797ee51cfc0469, var_24f56bee90b9aed8, undefined, contents )[ "position" ];
    
    /#
        if ( b_draw_debug )
        {
            line( start, end, ( 1, 0, 0 ), 1, 0, 100 );
            sphere( end, 5, ( 1, 1, 0 ), 0, 100 );
        }
    #/
    
    self notify( #"mortars_incoming", end );
    
    if ( soundexists( "weap_mortar_fire_dist_aries" ) )
    {
        level thread utility::play_sound_in_space( "weap_mortar_fire_dist_aries", start );
    }
    
    physicsexplosionsphere( start, 350, 350, 200 );
    projectilemodel = spawn( "script_model", start );
    projectilemodel setmodel( "equipment_mortar_shell_improvised_01_mp" );
    playfx( level._effect[ "vfx_sat_wc_libra_mech_mortar_muz" ], start, anglestoforward( self.angles ) );
    playfxontag( level._effect[ "vfx_sat_wc_libra_mech_mortar_projectile" ], projectilemodel, "tag_origin" );
    soundlength = lookupsoundlength( "weap_mortar_incoming_aries" ) * 0.001 * 0.8;
    sounddelay = max( level.framedurationseconds, 5.5 - soundlength - 0.5 );
    
    if ( soundexists( "weap_mortar_incoming_aries" ) )
    {
        projectilemodel utility::delaythread( sounddelay, &utility::playsoundontag, "weap_mortar_incoming_aries", "tag_origin" );
    }
    
    if ( soundexists( "weap_mortar_fly_lp_aries" ) )
    {
        projectilemodel thread utility::play_loop_sound_on_entity( "weap_mortar_fly_lp_aries" );
    }
    
    slice = 1 / 5.5 / level.framedurationseconds;
    fraction = 0;
    
    while ( fraction < 1 )
    {
        previousorigin = projectilemodel.origin;
        projectilemodel.origin = math::get_point_on_parabola( start, end, 3000, fraction );
        projectilemodel.angles = vectortoangles( projectilemodel.origin - previousorigin );
        fraction += slice;
        waitframe();
    }
    
    if ( soundexists( "weap_mortar_fly_lp_aries" ) )
    {
        projectilemodel thread utility::stop_loop_sound_on_entity( "weap_mortar_fly_lp_aries" );
    }
    
    effects_player = 0;
    
    if ( isdefined( player_target ) )
    {
        b_within_range = distance2dsquared( player_target.origin, end );
        
        if ( b_within_range < effect_radius_sq )
        {
            effects_player = 1;
        }
    }
    
    function_7c3a17655d6ec8e8( projectilemodel, effects_player, player_target );
}

// Namespace aries_util
// Params 0
// Checksum 0x7d4a43f8, Offset: 0x26a7
// Size: 0x33
function function_a5a571ec2b7b0761()
{
    level endon( #"mortars_fired" );
    utility::flag_set( "mortars_mortarInAir" );
    self waittill( #"mortars_impact" );
    utility::flag_clear( "mortars_mortarInAir" );
}

// Namespace aries_util
// Params 4
// Checksum 0x786d2e6b, Offset: 0x26e2
// Size: 0xe1
function function_7c3a17655d6ec8e8( projectilemodel, var_f1ad2ec3de96509e, player_target, var_e67811ad879eb46d )
{
    end = projectilemodel.origin;
    projectilemodel delete();
    
    if ( var_f1ad2ec3de96509e )
    {
        if ( player_target playerads() )
        {
            earthquakeintensity = 0.09;
        }
        else
        {
            earthquakeintensity = 0.4;
        }
        
        physicsexplosionsphere( end, 512, 256, 150 );
        earthquake( earthquakeintensity, 1.25, end, 50000 );
        playrumbleonposition( "damage_heavy", end );
        mortars_damage_player( player_target, end, var_e67811ad879eb46d );
    }
    
    level thread function_51705c0c81c28eb6( end );
    playfx( level._effect[ "vfx_sat_wc_libra_mech_mortar_impact" ], end );
    self notify( #"mortars_impact", end );
    level notify( #"mortars_impact", end );
}

// Namespace aries_util
// Params 1
// Checksum 0xea9b68e2, Offset: 0x27cb
// Size: 0x5c
function function_51705c0c81c28eb6( origin )
{
    scriptorigin = spawn( "script_origin", origin + ( 0, 0, 15 ) );
    
    if ( soundexists( "eqp_sat_frag_grenade_expl_trans_aries" ) )
    {
        playsoundatpos( scriptorigin.origin, "eqp_sat_frag_grenade_expl_trans_aries" );
    }
    
    wait 8;
    scriptorigin delete();
}

// Namespace aries_util
// Params 0
// Checksum 0xfb31515a, Offset: 0x282f
// Size: 0x3b, Type: bool
function function_869e236a42981d22()
{
    if ( trace::ray_trace_passed( self.origin + ( 0, 0, 384 ), self.origin, [ self ], trace::create_world_contents() ) )
    {
        return false;
    }
    
    return true;
}

// Namespace aries_util
// Params 3
// Checksum 0xe7c00db8, Offset: 0x2873
// Size: 0x9a
function mortars_damage_player( player, impactorigin, var_e67811ad879eb46d = 512 )
{
    if ( player function_869e236a42981d22() )
    {
        return;
    }
    
    if ( isdefined( impactorigin ) && isdefined( self ) && isdefined( self.owner ) )
    {
        damage = 100;
        self.owner radiusdamage( impactorigin, var_e67811ad879eb46d, damage, damage / 2, self.owner, "MOD_EXPLOSIVE" );
    }
    
    player utility::delaycall( 0.2, &shellshock, "default_nosound", 2 );
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x1199b0d3, Offset: 0x2915
    // Size: 0x5, Type: dev
    function function_65fb8c1619fe51b()
    {
        
    }

#/

// Namespace aries_util
// Params 2
// Checksum 0xdc5900b8, Offset: 0x2922
// Size: 0x4ab
function mars_setup( activity_instance, play_spawn_anim = 0 )
{
    if ( !isdefined( level.var_2985432051e64d71 ) )
    {
        function_48e7ae5855bc8be3();
    }
    
    level.mars_ai = spawnstruct();
    level.mars_ai.play_spawn_anim = play_spawn_anim;
    level.mars_ai.stalk = getent( "mars_body", #targetname );
    level.mars_ai.stalk.animname = "mars_stalk";
    level.mars_ai.stalk setcandamage( 1 );
    level.mars_ai.stalk function_dc61b81ec6b63cc4( 1 );
    level.mars_ai.stalk.maxhealth = 99999;
    level.mars_ai.stalk.health = level.mars_ai.stalk.maxhealth;
    level.mars_ai.var_1e0c729a105495d0 = 0;
    level.mars_ai.var_39226c238ed4b176 = getent( "mars_healthbar", #targetname );
    level.mars_ai.activity_instance = activity_instance;
    level.mars_ai.var_e03a976980256ff1 = [];
    level.mars_ai.remaining_heads = 3;
    level.mars_ai.inactive_state = 1;
    level.mars_ai.stalk enablelinkto();
    head_tags = [ "j_crown_end1", "j_crown_end2", "j_crown_end3" ];
    
    for ( var_e8b483d049d7276b = 0; var_e8b483d049d7276b < head_tags.size ; var_e8b483d049d7276b++ )
    {
        crown_tag_pos = level.mars_ai.stalk gettagorigin( head_tags[ var_e8b483d049d7276b ] );
        crown_tag_angles = level.mars_ai.stalk gettagangles( head_tags[ var_e8b483d049d7276b ] );
        head = mp_agent::spawnnewagentaitype( "sat_aries_boss", crown_tag_pos, crown_tag_angles, "team_two_hundred" );
        head function_dc61b81ec6b63cc4( 1 );
        head linktomoveoffset( level.mars_ai.stalk, head_tags[ var_e8b483d049d7276b ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
        
        if ( var_e8b483d049d7276b != 0 )
        {
            head.tall_head = 1;
        }
        
        flower_inner_pedal_a_tags = [ "J_inner_pedalAA", "J_inner_pedalBA", "J_inner_pedalCA", "J_inner_pedalDA" ];
        flower_inner_pedal_b_tags = [ "J_inner_pedalAB", "J_inner_pedalBB", "J_inner_pedalCB", "J_inner_pedalDB" ];
        flower_inner_pedal_c_tags = [ "J_inner_pedalAC", "J_inner_pedalBC", "J_inner_pedalCC", "J_inner_pedalDC" ];
        var_a15739b2ddf26463 = [ "J_stem_base", "J_stem1", "J_stem2", "J_stem3", "J_stem4" ];
        var_be12c1700c6c3b51 = [ "J_stem_end" ];
        var_818c1ee101078d31 = [ "J_MainRoot" ];
        function_a9fc5347b20c20fb( head, flower_inner_pedal_a_tags, "c_sat_aries_mars_flower_inner_pedal_a_hvk" );
        function_a9fc5347b20c20fb( head, flower_inner_pedal_b_tags, "c_sat_aries_mars_flower_inner_pedal_b_hvk" );
        function_a9fc5347b20c20fb( head, flower_inner_pedal_c_tags, "c_sat_aries_mars_flower_inner_pedal_c_hvk" );
        function_a9fc5347b20c20fb( head, var_a15739b2ddf26463, "c_sat_aries_mars_flower_stalk_hvk" );
        function_a9fc5347b20c20fb( head, var_be12c1700c6c3b51, "c_sat_aries_mars_flower_stalk_end_hvk" );
        function_a9fc5347b20c20fb( head, var_818c1ee101078d31, "c_sat_aries_mars_flower_mainroot_hvk" );
        head notify( #"linked_to_tag_origin" );
        level.mars_ai.var_e03a976980256ff1[ level.mars_ai.var_e03a976980256ff1.size ] = head;
    }
    
    level.mars_ai mars::weak_point_setup();
    level.mars_ai thread aries_boss::function_b9a054cc6f3e702f();
    level.mars_ai mars::healthbar_setup();
    level callback::callback( #"aries_boss_started", { #players:level.players } );
}

// Namespace aries_util
// Params 3
// Checksum 0xfb944cfd, Offset: 0x2dd5
// Size: 0x99
function function_a9fc5347b20c20fb( ent, tag_list, havok_model )
{
    for ( joint_index = 0; joint_index < tag_list.size ; joint_index++ )
    {
        pos = ent gettagorigin( tag_list[ joint_index ] );
        var_962312285405f88b = spawn( "script_model", pos );
        var_962312285405f88b setmodel( havok_model );
        var_962312285405f88b function_dc61b81ec6b63cc4( 1 );
        var_962312285405f88b linktomoveoffset( ent, tag_list[ joint_index ], ( 0, 0, -10 ), ( 0, 0, 0 ) );
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xd8290646, Offset: 0x2e76
    // Size: 0x5, Type: dev
    function function_cd7b41536fa8d538()
    {
        
    }

#/

// Namespace aries_util
// Params 3
// Checksum 0x66265f02, Offset: 0x2e83
// Size: 0x6a
function function_33c5d646b9cd4113( target_count, var_cdb665c03b873a33, var_6012528acbd3c217 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( var_6012528acbd3c217 ) )
    {
        level endon( var_6012528acbd3c217 );
    }
    
    current_ai_count = getaicount();
    
    while ( current_ai_count >= target_count )
    {
        current_ai_count = getaicount();
        wait 0.5;
    }
    
    if ( isdefined( var_cdb665c03b873a33 ) )
    {
        utility::flag_set( var_cdb665c03b873a33 );
    }
}

// Namespace aries_util
// Params 0
// Checksum 0x4624808e, Offset: 0x2ef5
// Size: 0x1f
function function_fe0a54195e81bbc6()
{
    if ( utility::cointoss() )
    {
        zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "ADZ", 999 );
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x11f85999, Offset: 0x2f1c
    // Size: 0x5, Type: dev
    function function_1a66c4b5af1894d4()
    {
        
    }

#/

// Namespace aries_util
// Params 4
// Checksum 0x8ab348dc, Offset: 0x2f29
// Size: 0x20d
function function_38727ebeb1f631eb( scene_nodes, flag_distance, squad_override, flag_combat )
{
    var_e46e31af7098095 = utility::getstructarray( scene_nodes, "targetname" );
    waitframe();
    
    if ( isdefined( squad_override ) && level.is_squad_size_small )
    {
        var_47e6a615fa3aefaa = var_e46e31af7098095.size / 2;
        var_e46e31af7098095 = utility::array_slice_random( var_e46e31af7098095, var_47e6a615fa3aefaa );
    }
    
    if ( var_e46e31af7098095.size > 0 )
    {
        foreach ( s_node in var_e46e31af7098095 )
        {
            s_node thread scene::add_spawn_function( &function_c1e4b08f8776eb99, "_object_all_" );
            s_node thread scene::play( undefined, "looping_idle" );
        }
        
        utility::flag_wait_any( "flag_aries_nightmare_maze_ambient_zmb_shot", flag_distance, flag_combat );
        
        foreach ( s_node in var_e46e31af7098095 )
        {
            wait randomfloatrange( 0, 0.5 );
            s_node thread scene::play( undefined, "action_forward" );
            s_node notify( #"scene_action" );
            utility::flag_wait( "flag_aries_nightmare_tower_catchup_complete" );
            
            foreach ( s_node in var_e46e31af7098095 )
            {
                s_node scene::cleanup();
            }
        }
        
        return;
    }
    
    return;
}

// Namespace aries_util
// Params 0
// Checksum 0x73c0df94, Offset: 0x313e
// Size: 0x9e
function function_c1e4b08f8776eb99()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.team = "team_hundred_ninety";
    self._blackboard.var_30ab8ffc06e38f0a = 1;
    self._blackboard.var_a7ac06c0829177ee = 1;
    namespace_659599414270bd0a::enable_emergence_spawning( 1 );
    namespace_659599414270bd0a::set_emergence_spawning_through_death_percentage( 100 );
    namespace_659599414270bd0a::force_emergence_spawning( 1, undefined, 1 );
    thread function_6309af2de30c587f();
    utility::flag_wait( "flag_aries_nightmare_tower_catchup_complete" );
    wait 5;
    self dodamage( 99999, self.origin, self, self );
}

// Namespace aries_util
// Params 1
// Checksum 0xe8ed1e61, Offset: 0x31e4
// Size: 0xbb
function function_6309af2de30c587f( flag_shot )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"damage", amount, attacker );
    utility::flag_set( "flag_aries_nightmare_maze_ambient_zmb_shot" );
    
    if ( amount < self.health )
    {
        utility::flag_set( "flag_aries_nightmare_maze_ambient_zmb_shot" );
        self function_fa32376aaa88a7a2( self.origin, 5000 );
        return;
    }
    
    if ( amount >= self.health )
    {
        scene_struct = self.sceneobjectdata.sceneroot;
        self notify( #"scene_death" );
    }
}

// Namespace aries_util
// Params 0
// Checksum 0xb0ac57fb, Offset: 0x32a7
// Size: 0x53
function function_bff5127100ef382e()
{
    level endon( #"game_ended" );
    self endon( #"scene_release" );
    scene_struct = self.sceneobjectdata.sceneroot;
    self waittill( #"scene_death" );
    scene::play( undefined, "death" );
}

// Namespace aries_util
// Params 1
// Checksum 0xede9dc02, Offset: 0x3302
// Size: 0x196
function function_2aa782e2f16bd276( scene_nodes )
{
    var_e46e31af7098095 = utility::getstructarray( scene_nodes, "targetname" );
    waitframe();
    
    if ( var_e46e31af7098095.size > 0 )
    {
        foreach ( s_node in var_e46e31af7098095 )
        {
            switch ( s_node.script_scenescriptbundle )
            {
                case #"hash_9be012271d4f3801":
                    s_node thread scene::add_spawn_function( &function_efd9490f7ef64b8c, "_object_all_" );
                    s_node thread scene::play( undefined, [ "idle_01_b", "default" ] );
                    break;
                case #"hash_e9eb1560d4266e29":
                    s_node thread scene::add_spawn_function( &function_74f2823989f7be15, "_object_all_" );
                    s_node thread scene::play( undefined, "idle" );
                    wait 0.75;
                    break;
            }
        }
        
        utility::flag_wait( "flag_aries_nightmare_tower_catchup_complete" );
        
        foreach ( s_node in var_e46e31af7098095 )
        {
            s_node scene::cleanup();
        }
        
        return;
    }
    
    return;
}

// Namespace aries_util
// Params 0
// Checksum 0x891e1c7c, Offset: 0x34a0
// Size: 0x1e
function function_efd9490f7ef64b8c()
{
    thread function_e7812c88257eace3();
    thread function_246a0d905cb82dd5();
    thread function_f11e8f365c0b1034();
    thread function_d4e0f416fdd0fc2c();
}

// Namespace aries_util
// Params 0
// Checksum 0x132f2053, Offset: 0x34c6
// Size: 0x36
function function_74f2823989f7be15()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    thread function_e7812c88257eace3();
    thread function_2048e711d56b4b47();
    thread function_edb6eaa8fbd3a4ed();
    thread function_d4e0f416fdd0fc2c();
}

// Namespace aries_util
// Params 0
// Checksum 0x24abc60f, Offset: 0x3504
// Size: 0x9e
function function_2048e711d56b4b47()
{
    level endon( #"flag_aries_nightmare_maze_complete" );
    var_c16e8946d253c0ce = utility::spawn_tag_origin( self.origin + ( 0, 0, 32 ) );
    var_c16e8946d253c0ce.origin += ( 0, 0, 64 );
    var_c16e8946d253c0ce show();
    waitframe();
    self waittill( #"death" );
    self hide();
    utility::ent_flag_set( "flg_trapped_zmb_dead" );
    playfxontag( level._effect[ "annihilate_upside_zombie" ], var_c16e8946d253c0ce, "tag_origin" );
}

// Namespace aries_util
// Params 0
// Checksum 0xf829c05f, Offset: 0x35aa
// Size: 0x4a
function function_e7812c88257eace3()
{
    zombie = self;
    zombie.team = "team_hundred_ninety";
    zombie.dontdroploot = 1;
    zombie.var_a13bed1ac47e1b2c = 1;
    zombie.noragdoll = 1;
}

// Namespace aries_util
// Params 0
// Checksum 0xe46cac97, Offset: 0x35fc
// Size: 0x50
function function_d4e0f416fdd0fc2c()
{
    zombie = self;
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::flag_wait( "flag_aries_nightmare_tower_catchup_complete" );
    wait 5;
    zombie dodamage( 99999, zombie.origin, zombie, zombie );
}

// Namespace aries_util
// Params 0
// Checksum 0x20660aec, Offset: 0x3654
// Size: 0x3e
function function_246a0d905cb82dd5()
{
    level endon( #"game_ended" );
    
    while ( self.health > 0 )
    {
        wait 0.5;
    }
    
    /#
        iprintln( "<dev string:xec>" );
    #/
    
    utility::ent_flag_set( "flg_trapped_zmb_dead" );
}

// Namespace aries_util
// Params 0
// Checksum 0xc7e63d3e, Offset: 0x369a
// Size: 0xc0
function function_f11e8f365c0b1034()
{
    level endon( #"game_ended" );
    self endon( #"flg_trapped_zmb_dead" );
    
    while ( !utility::ent_flag( "flg_trapped_zmb_dead" ) )
    {
        wait 0.5;
        a_players_in_range = getplayersinradius( self.origin, 56, 512 );
        
        foreach ( playr in a_players_in_range )
        {
            playr function_6b846ab5602de222();
        }
    }
}

// Namespace aries_util
// Params 0
// Checksum 0x55f99d2, Offset: 0x3762
// Size: 0xda
function function_edb6eaa8fbd3a4ed()
{
    level endon( #"game_ended" );
    self endon( #"flg_trapped_zmb_dead" );
    self endon( #"death" );
    
    while ( !utility::ent_flag( "flg_trapped_zmb_dead" ) )
    {
        wait 0.5;
        a_players_in_range = getplayersinradius( self.origin + ( 0, 0, -115 ), 56, 512 );
        
        foreach ( playr in a_players_in_range )
        {
            playr function_6b846ab5602de222();
        }
    }
}

// Namespace aries_util
// Params 0
// Checksum 0x72953966, Offset: 0x3844
// Size: 0x15
function function_6b846ab5602de222()
{
    self dodamage( 5, self.origin, self, self );
}

// Namespace aries_util
// Params 6
// Checksum 0xe299b07b, Offset: 0x3861
// Size: 0x111
function function_d286c108cb82dc61( str_targetname, target_amount, anim_rate, anim_define, timer_cleanup, var_b60496d5b429ae0f )
{
    level endon( #"game_ended" );
    var_2c291d8781b16f5b = utility::getstructarray( str_targetname, "targetname" );
    var_2c291d8781b16f5b = arrayrandomize( var_2c291d8781b16f5b );
    
    if ( target_amount > var_2c291d8781b16f5b.size )
    {
        i = minint( target_amount, var_2c291d8781b16f5b.size );
    }
    else
    {
        i = var_2c291d8781b16f5b.size;
    }
    
    if ( i > 0 )
    {
        while ( i < target_amount )
        {
            if ( isdefined( anim_rate ) )
            {
                var_2c291d8781b16f5b[ i ] thread scene::set_anim_rate( anim_rate );
            }
            
            if ( isdefined( anim_define ) )
            {
                var_2c291d8781b16f5b[ i ] thread scene::play( anim_define );
            }
            else
            {
                var_2c291d8781b16f5b[ i ] thread scene::play();
            }
            
            if ( isdefined( timer_cleanup ) )
            {
                wait timer_cleanup;
                var_2c291d8781b16f5b[ i ] thread scene::cleanup();
            }
            else
            {
                utility::flag_wait( var_b60496d5b429ae0f );
                var_2c291d8781b16f5b[ i ] thread scene::cleanup();
            }
            
            i++;
            wait 0.1;
        }
        
        return;
    }
    
    /#
        iprintln( "<dev string:x102>" );
    #/
    
    return;
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x99454bef, Offset: 0x397a
    // Size: 0x5, Type: dev
    function function_a43239266977bfec()
    {
        
    }

#/

// Namespace aries_util
// Params 2
// Checksum 0x46e6b9c8, Offset: 0x3987
// Size: 0xc6
function function_555eb42caeaae66( ent, a_structs )
{
    movetime = 5;
    ent markkeyframedmover();
    ent forcenetfieldhighlod( 1 );
    ent setmoveroptimized( 1 );
    ent setmoverantilagged( 1 );
    a_str = utility::getstructarray( a_structs, "script_noteworthy" );
    a_str = sortbydistance( a_str, ent.origin );
    i = 0;
    i_max = a_str.size;
    
    while ( i < i_max )
    {
        ent moveto( a_str[ i ].origin, movetime, 0, 0 );
        
        if ( i < i_max )
        {
            i++;
        }
        else
        {
            /#
                iprintln( "<dev string:x11a>" );
            #/
        }
        
        wait movetime;
    }
}

// Namespace aries_util
// Params 2
// Checksum 0xa380360f, Offset: 0x3a55
// Size: 0x117
function function_2ad4d6454b67c8a8( a_ents, movetime )
{
    foreach ( ent in a_ents )
    {
        ent markkeyframedmover();
        ent forcenetfieldhighlod( 1 );
        ent setmoveroptimized( 1 );
        ent setmoverantilagged( 1 );
    }
    
    i = 0;
    i_max = a_ents.size;
    
    if ( !isdefined( movetime ) )
    {
        movetime = 0.25;
    }
    
    while ( i < i_max )
    {
        var_4c9e817bf99c1777 = utility::getstruct( a_ents[ i ].target, "targetname" );
        a_ents[ i ] moveto( var_4c9e817bf99c1777.origin, movetime, 0.1, 0.1 );
        i++;
        wait movetime;
    }
}

// Namespace aries_util
// Params 4
// Checksum 0x4efd8d1e, Offset: 0x3b74
// Size: 0xab
function function_50e36c4cb125951e( ent, var_bb12dc67bf5606ea, var_b185b326b2b05700, endonflag )
{
    ent markkeyframedmover();
    ent forcenetfieldhighlod( 1 );
    ent setmoveroptimized( 1 );
    ent setmoverantilagged( 1 );
    
    while ( !utility::flag( endonflag ) )
    {
        if ( isdefined( var_bb12dc67bf5606ea ) && isdefined( var_b185b326b2b05700 ) )
        {
            var_888096c9807495cf = randomfloatrange( var_bb12dc67bf5606ea, var_b185b326b2b05700 );
        }
        else
        {
            var_888096c9807495cf = randomfloatrange( -25, 25 );
        }
        
        var_d8ff11f31b222b3d = randomfloatrange( 3, 6 );
        ent rotateto( ( var_888096c9807495cf, var_888096c9807495cf, var_888096c9807495cf ), var_d8ff11f31b222b3d, 1, 1 );
        wait var_d8ff11f31b222b3d;
    }
}

// Namespace aries_util
// Params 3
// Checksum 0xd704cd6a, Offset: 0x3c27
// Size: 0x107
function function_6cb163c484b62fbc( movingent, inittarget, endonflag )
{
    movetime = 5;
    ent = getent( movingent, #targetname );
    ent markkeyframedmover();
    ent forcenetfieldhighlod( 1 );
    ent setmoveroptimized( 1 );
    ent setmoverantilagged( 1 );
    var_4c9e817bf99c1777 = utility::getstruct( inittarget, "targetname" );
    ent markkeyframedmover();
    ent forcenetfieldhighlod( 1 );
    ent setmoveroptimized( 1 );
    ent setmoverantilagged( 1 );
    
    while ( !utility::flag( endonflag ) )
    {
        var_888096c9807495cf = randomfloatrange( -25, 25 );
        var_4c9e817bf99c1777 = utility::getstruct( var_4c9e817bf99c1777.target, "targetname" );
        ent moveto( var_4c9e817bf99c1777.origin, movetime, 0, 0 );
        ent rotateto( ( var_888096c9807495cf, var_888096c9807495cf, var_888096c9807495cf ), movetime, 1, 1 );
        wait movetime - 1;
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x50ccecb2, Offset: 0x3d36
    // Size: 0x5, Type: dev
    function function_c25d7f218a7d648()
    {
        
    }

#/

// Namespace aries_util
// Params 4
// Checksum 0xce7a1752, Offset: 0x3d43
// Size: 0x76
function player_camera_sway_enable( e_trigger, flag_endon, sway_multiplier = 1, b_cinematic_motion = 1 )
{
    if ( isdefined( flag_endon ) && level utility::flag( flag_endon ) )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread player_camera_sway_setup( e_trigger, sway_multiplier, flag_endon );
    
    if ( b_cinematic_motion )
    {
        player_utility::function_99d180c3f0ca93b8( self, "iw9_swimming", 2 );
    }
}

// Namespace aries_util
// Params 3
// Checksum 0xa707bd32, Offset: 0x3dc1
// Size: 0x195
function player_camera_sway_setup( e_trigger, base_multiplier = 1, flag_endon )
{
    self notify( #"hash_7e6f47b45b49978e" );
    self endon( #"hash_7e6f47b45b49978e" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        self.var_c7b6c9bfdbf8d9fc delete();
        wait 0.2;
        self.var_c7b6c9bfdbf8d9fc = undefined;
        player_camera_sway_disable();
        wait 0.2;
    }
    
    player_camera_sway_settings( base_multiplier );
    duration = min( 3, self.var_c7b6c9bfdbf8d9fc.base_duration );
    self.var_c7b6c9bfdbf8d9fc.angles = function_2bba09510ee8823d();
    
    if ( isdefined( e_trigger ) )
    {
        thread player_camera_sway_toggle( e_trigger, flag_endon );
    }
    else
    {
        thread player_camera_sway_thread( e_trigger, flag_endon, duration );
    }
    
    level utility::flag_wait( flag_endon );
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        self.var_c7b6c9bfdbf8d9fc rotateto( ( 0, 0, 0 ), duration, duration * 0.2, duration * 0.4 );
    }
    
    wait duration;
    wait 0.2;
    self playersetgroundreferenceent( undefined );
    self.var_550963bbb003c756 = ( 0, 0, 0 );
    wait 0.2;
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        self.var_c7b6c9bfdbf8d9fc delete();
        wait 0.2;
        self.var_c7b6c9bfdbf8d9fc = undefined;
    }
    
    thread player_camera_sway_disable();
}

// Namespace aries_util
// Params 0
// Checksum 0xd97d06ff, Offset: 0x3f5e
// Size: 0x51
function player_camera_sway_init()
{
    utility::ent_flag_set( "player_camera_sway" );
    self.var_c7b6c9bfdbf8d9fc = spawn( "script_model", self.origin );
    self.var_c7b6c9bfdbf8d9fc.angles = self getplayerangles();
    self playersetgroundreferenceent( self.var_c7b6c9bfdbf8d9fc );
}

// Namespace aries_util
// Params 8
// Checksum 0x452ef22f, Offset: 0x3fb7
// Size: 0x1ce
function player_camera_sway_settings( base_multiplier = 1, base_duration = 6, duration_variance = 1, base_yaw = 1.5, base_pitch = 1.5, base_roll = 3, low_variance = 0.5, high_variance = 1 )
{
    if ( !isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        player_camera_sway_init();
    }
    
    if ( getdvarint( @"hash_ccecb2781660d0fc" ) == 1 )
    {
        base_duration *= 4;
        base_multiplier *= 0.25;
    }
    
    if ( base_multiplier >= 1 )
    {
        self.var_c7b6c9bfdbf8d9fc.base_duration = base_duration;
        self.var_c7b6c9bfdbf8d9fc.duration_variance = duration_variance;
    }
    else
    {
        self.var_c7b6c9bfdbf8d9fc.base_duration = base_duration * 1 / base_multiplier;
        self.var_c7b6c9bfdbf8d9fc.duration_variance = duration_variance * 1 / base_multiplier;
    }
    
    self.var_c7b6c9bfdbf8d9fc.base_yaw = base_yaw * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.base_pitch = base_pitch * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.base_roll = base_roll * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.low_variance = low_variance * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.high_variance = high_variance * base_multiplier;
}

// Namespace aries_util
// Params 3
// Checksum 0x1d6be826, Offset: 0x418d
// Size: 0x36e
function player_camera_sway_thread( e_trigger, flag_endon, duration )
{
    self notify( #"hash_8eb6dbe7c059e641" );
    self endon( #"hash_8eb6dbe7c059e641" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( utility::ent_flag( "player_camera_sway" ) && !level utility::flag( flag_endon ) )
    {
        duration = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_duration - self.var_c7b6c9bfdbf8d9fc.duration_variance, self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance );
        yaw = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_yaw * -1 - self.var_c7b6c9bfdbf8d9fc.low_variance, self.var_c7b6c9bfdbf8d9fc.base_yaw );
        pitch = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_pitch * -1 - self.var_c7b6c9bfdbf8d9fc.low_variance, self.var_c7b6c9bfdbf8d9fc.base_pitch );
        roll = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_roll * -1 - self.var_c7b6c9bfdbf8d9fc.high_variance, self.var_c7b6c9bfdbf8d9fc.base_roll );
        self.var_c7b6c9bfdbf8d9fc rotateto( ( yaw, pitch, roll ) + function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration + randomfloat( self.var_c7b6c9bfdbf8d9fc.duration_variance );
        
        if ( !utility::ent_flag( "player_camera_sway" ) || level utility::flag( flag_endon ) )
        {
            break;
        }
        
        duration = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_duration - self.var_c7b6c9bfdbf8d9fc.duration_variance, self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance );
        yaw = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_yaw * -1, self.var_c7b6c9bfdbf8d9fc.base_yaw + self.var_c7b6c9bfdbf8d9fc.low_variance );
        pitch = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_pitch * -1, self.var_c7b6c9bfdbf8d9fc.base_pitch + self.var_c7b6c9bfdbf8d9fc.low_variance );
        roll = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_roll * -1, self.var_c7b6c9bfdbf8d9fc.base_roll + self.var_c7b6c9bfdbf8d9fc.high_variance );
        self.var_c7b6c9bfdbf8d9fc rotateto( ( yaw, pitch, roll ) + function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration + randomfloat( self.var_c7b6c9bfdbf8d9fc.duration_variance );
    }
}

// Namespace aries_util
// Params 0
// Checksum 0x5e7efdd0, Offset: 0x4503
// Size: 0x26
function function_2bba09510ee8823d()
{
    if ( isdefined( self.var_550963bbb003c756 ) )
    {
        return self.var_550963bbb003c756;
    }
    
    return ( 0, 0, 0 );
}

// Namespace aries_util
// Params 0
// Checksum 0xc2860837, Offset: 0x4532
// Size: 0x29
function player_camera_sway_disable()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"cancel_disorientation" );
    player_utility::function_c14762bb6e0b4edb( self );
    utility::ent_flag_clear( "player_camera_sway" );
}

// Namespace aries_util
// Params 2
// Checksum 0xd7858eb8, Offset: 0x4563
// Size: 0xa0
function player_camera_sway_toggle( e_trigger, flag_endon )
{
    self notify( #"hash_3f4d189bae83b5c7" );
    self endon( #"hash_3f4d189bae83b5c7" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( self istouching( e_trigger ) )
        {
            if ( !utility::ent_flag( "player_camera_sway" ) )
            {
                utility::ent_flag_set( "player_camera_sway" );
                thread player_camera_sway_thread( e_trigger, flag_endon );
            }
        }
        else
        {
            utility::ent_flag_clear( "player_camera_sway" );
            thread player_camera_sway_disable();
        }
        
        wait 1.5;
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xec6b939, Offset: 0x460b
    // Size: 0x5, Type: dev
    function function_e667b65275fe86b7()
    {
        
    }

#/

// Namespace aries_util
// Params 2
// Checksum 0x5e5a84be, Offset: 0x4618
// Size: 0x1bf
function function_46ea5163d8f3c881( var_2c9997925f5b83e7 = "nmr_corridor_containers_rumble_01", radius = 2048 )
{
    nearbyplayers = utility::playersincylinder( self.origin, radius );
    
    switch ( var_2c9997925f5b83e7 )
    {
        case #"hash_af7ed295e438c21c":
            foreach ( player in nearbyplayers )
            {
                player thread nmr_corridor_containers_rumble_01();
            }
            
            break;
        case #"hash_af7ed595e438c6d5":
            foreach ( player in nearbyplayers )
            {
                player thread function_dc96340aadf40700();
            }
            
            break;
        default:
            foreach ( player in nearbyplayers )
            {
                player thread nmr_corridor_containers_rumble_01();
            }
            
            break;
    }
}

// Namespace aries_util
// Params 3
// Checksum 0x1410e779, Offset: 0x47df
// Size: 0x73
function function_9ed10383b23b052f( var_252f351b804092e2 = "viewmodel_medium", delay = 0.5, var_252f341b804090af = "damage_med" )
{
    self endon( #"death_or_disconnect" );
    self playrumbleonpositionforclient( var_252f351b804092e2, self.origin );
    wait delay;
    self playrumbleonpositionforclient( var_252f341b804090af, self.origin );
}

// Namespace aries_util
// Params 0
// Checksum 0xd7d95f47, Offset: 0x485a
// Size: 0x5d
function nmr_corridor_containers_rumble_01()
{
    self endon( #"death_or_disconnect" );
    thread function_9ed10383b23b052f( "viewmodel_small" );
    wait 0.1;
    thread function_9ed10383b23b052f( "viewmodel_small" );
    wait 0.2;
    thread function_9ed10383b23b052f( "viewmodel_large" );
    wait 0.5;
    thread function_9ed10383b23b052f( "viewmodel_large" );
    wait 0.3;
    thread function_9ed10383b23b052f();
}

// Namespace aries_util
// Params 0
// Checksum 0x67bc7b56, Offset: 0x48bf
// Size: 0x4b
function function_dc96340aadf40700()
{
    self endon( #"death_or_disconnect" );
    thread function_9ed10383b23b052f( "viewmodel_large" );
    wait 0.3;
    thread function_9ed10383b23b052f( "viewmodel_large" );
    wait 0.6;
    thread function_9ed10383b23b052f();
    wait 0.5;
    thread function_9ed10383b23b052f( "viewmodel_small" );
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0x59ff4b7e, Offset: 0x4912
    // Size: 0x5, Type: dev
    function function_4399de2974797b56()
    {
        
    }

#/

// Namespace aries_util
// Params 0
// Checksum 0x4472147e, Offset: 0x491f
// Size: 0xf2
function function_3d7162d72da84e14()
{
    var_9f8436ce5218f373 = utility::getstruct( "sat_cin_ari_nightmare_vines_02", "targetname" );
    var_9f843cce521900a5 = utility::getstruct( "sat_cin_ari_nightmare_vines_04", "targetname" );
    waitframe();
    var_9f8436ce5218f373 thread scene::play( undefined, "nightmare_intro_idle" );
    var_9f843cce521900a5 thread scene::play( undefined, "nightmare_intro_idle" );
    utility::flag_wait( "flag_aries_nightmare_intro_complete" );
    wait 1;
    var_9f8436ce5218f373 thread scene::play( undefined, "nightmare_intro" );
    wait 1.5;
    var_9f843cce521900a5 thread scene::play( undefined, "nightmare_intro" );
    var_aac9f20fcdf57812 = utility::getstruct( "sat_cin_ari_nightmare_vines_02_b", "targetname" );
    var_aac9f20fcdf57812 thread scene::play( undefined, "nightmare_intro_idle" );
    utility::flag_wait( "flag_trg_intro_maze_vines_b" );
    wait 1.5;
    var_aac9f20fcdf57812 thread scene::play( undefined, "nightmare_intro" );
    wait 10;
    var_9f8436ce5218f373 scene::cleanup();
    var_aac9f20fcdf57812 scene::cleanup();
    var_9f843cce521900a5 scene::cleanup();
}

// Namespace aries_util
// Params 0
// Checksum 0x15e3d9ca, Offset: 0x4a19
// Size: 0x4f
function function_26d151c44e04f67c()
{
    animnode = utility::getstruct( "sat_cin_ari_nightmare_vines_03", "targetname" );
    waitframe();
    animnode scene::play( undefined, "nightmare_maze_idle" );
    utility::flag_wait( "flag_nm_maze_woods_memory_01_narration_complete" );
    wait 2.5;
    animnode scene::play( undefined, "nightmare_maze" );
}

// Namespace aries_util
// Params 0
// Checksum 0xffd5eaee, Offset: 0x4a70
// Size: 0x57
function function_aa46fed9c0298214()
{
    var_cd180e8f278ceb34 = utility::getstruct( "weak_point_flower_vine_01", "targetname" );
    var_cd18118f278cf1cd = utility::getstruct( "weak_point_flower_vine_02", "targetname" );
    waitframe();
    var_cd180e8f278ceb34 scene::play( undefined, "nightmare_flower_vine_idle" );
    var_cd18118f278cf1cd scene::play( undefined, "nightmare_flower_vine_idle" );
}

// Namespace aries_util
// Params 0
// Checksum 0x38ca9f9a, Offset: 0x4acf
// Size: 0xa9
function function_4f28f01bdd215b23()
{
    weak_point_tower_vine_long_a = utility::getstruct( "weak_point_tower_vine_long_a", "targetname" );
    weak_point_tower_vine_long_b = utility::getstruct( "weak_point_tower_vine_long_b", "targetname" );
    weak_point_tower_vine_short_a = utility::getstruct( "weak_point_tower_vine_short_a", "targetname" );
    weak_point_tower_vine_short_b = utility::getstruct( "weak_point_tower_vine_short_b", "targetname" );
    waitframe();
    weak_point_tower_vine_long_a scene::play( undefined, "nightmare_flower_vine_idle" );
    weak_point_tower_vine_long_b scene::play( undefined, "nightmare_flower_vine_idle" );
    weak_point_tower_vine_short_a scene::play( undefined, "nightmare_flower_vine_idle" );
    weak_point_tower_vine_short_b scene::play( undefined, "nightmare_flower_vine_idle" );
}

// Namespace aries_util
// Params 4
// Checksum 0x7603e928, Offset: 0x4b80
// Size: 0x51
function function_49b0c125a9c14292( animnode_vine, var_46f1327fcd04fb1e, shot_name, wait_time )
{
    if ( isdefined( var_46f1327fcd04fb1e ) )
    {
        utility::flag_wait( var_46f1327fcd04fb1e );
        wait wait_time;
        animnode_vine scene::play( undefined, shot_name );
        wait 10;
        animnode_vine scene::cleanup();
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xde366093, Offset: 0x4bd9
    // Size: 0x5, Type: dev
    function function_3a08bbab6e924fee()
    {
        
    }

#/

// Namespace aries_util
// Params 8
// Checksum 0xfaa53c7f, Offset: 0x4be6
// Size: 0x1b7
function function_d092342c9ead418d( weakpoint_targetname, flag_activate, scr_vine, blocker_scriptnoteworthy, frame_scriptnoteworthy, var_24286670d3d027f9, var_f5ce28eacfa24069, var_e73d2b8ea8ff9536 = 1 )
{
    utility::flag_wait( "scriptables_ready" );
    vine_animnode = utility::getstruct( scr_vine, "targetname" );
    e_weakpoint = weak_point::cluster_setup( weakpoint_targetname, "closed" );
    
    if ( isdefined( flag_activate ) )
    {
        utility::flag_wait( flag_activate );
    }
    
    e_weakpoint weak_point::cluster_set_state( "opening" );
    e_weakpoint waittill( #"weak_point_destroyed" );
    wait 1;
    utility::flag_set( var_24286670d3d027f9 );
    thread weakpoint_destroyed_rumble( e_weakpoint.origin, var_e73d2b8ea8ff9536 );
    
    if ( isdefined( scr_vine ) )
    {
        vine_animnode scene::play( undefined, "nightmare_flower_vine" );
    }
    
    if ( isdefined( var_f5ce28eacfa24069 ) )
    {
        level utility::flag_set( var_f5ce28eacfa24069 );
    }
    
    if ( isdefined( blocker_scriptnoteworthy ) )
    {
        vine_door = getscriptablearray( blocker_scriptnoteworthy, #script_noteworthy );
        
        foreach ( door in vine_door )
        {
            door setscriptablepartstate( "base", "dead" );
        }
        
        thread function_f3e519abae986ab3( vine_door[ 0 ].origin );
    }
    
    wait 10;
    vine_animnode scene::cleanup();
}

// Namespace aries_util
// Params 2
// Checksum 0x88c42d41, Offset: 0x4da5
// Size: 0x10e
function function_adfe0f04f6331e73( vine_targetname, flag_trigger )
{
    utility::flag_wait( flag_trigger );
    a_e_chain = [];
    e_vine = getent( vine_targetname, #targetname );
    a_e_chain = arraycombineunique( a_e_chain, [ e_vine ] );
    
    while ( true )
    {
        if ( isdefined( e_vine.target ) )
        {
            e_vine = getent( e_vine.target, #targetname );
            a_e_chain = arraycombineunique( a_e_chain, [ e_vine ] );
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    foreach ( vine in a_e_chain )
    {
        vine delete();
        wait 0.75;
    }
}

// Namespace aries_util
// Params 6
// Checksum 0x6ee8c57e, Offset: 0x4ebb
// Size: 0x139
function weakpoint_destroyed_rumble( var_5677176200caf891, var_e73d2b8ea8ff9536 = 1, scale = 0.3, duration = 3.5, rumble = "artillery_rumble_light", radius = 1024 )
{
    activity_instance = self;
    
    if ( isdefined( var_5677176200caf891 ) )
    {
        nearbyplayers = utility::playersincylinder( var_5677176200caf891, radius );
    }
    else
    {
        nearbyplayers = level.players;
    }
    
    foreach ( player in nearbyplayers )
    {
        if ( var_e73d2b8ea8ff9536 )
        {
            player earthquakeforplayer( scale, duration, player.origin, radius );
        }
        
        player playrumbleonpositionforclient( rumble, player.origin );
    }
}

// Namespace aries_util
// Params 2
// Checksum 0xd654d451, Offset: 0x4ffc
// Size: 0x125, Type: bool
function function_3cbf328d51b124cc( a_weakpoints, distance_threshold = 10000 )
{
    foreach ( player in level.players )
    {
        foreach ( weakpoint in a_weakpoints )
        {
            dist = distance2dsquared( player.origin, weakpoint.origin );
            
            if ( dist < distance_threshold )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace aries_util
// Params 2
// Checksum 0xfea64ead, Offset: 0x512a
// Size: 0xf0
function function_f3e519abae986ab3( v_door_location, radius = 2048 )
{
    activity_instance = self;
    
    if ( isdefined( v_door_location ) )
    {
        nearbyplayers = utility::playersincylinder( v_door_location, radius );
    }
    else
    {
        nearbyplayers = level.players;
    }
    
    foreach ( player in nearbyplayers )
    {
        player earthquakeforplayer( 0.3, 0.5, player.origin, 256 );
        player playrumbleonpositionforclient( "artillery_rumble_light", player.origin );
    }
}

// Namespace aries_util
// Params 0
// Checksum 0xd0dcdcdd, Offset: 0x5222
// Size: 0x84
function function_8aaa6995bd26fc43()
{
    activity_instance = self;
    s_ability_case = utility::getstruct( "s_ability_case_boss", "targetname" );
    
    if ( isdefined( s_ability_case ) )
    {
        if ( !isdefined( s_ability_case.angles ) )
        {
            s_ability_case.angles = ( 0, 0, 0 );
        }
        
        activity_instance thread ob_story_mission_utils::function_516cfe2bb1eed11f( s_ability_case.origin, "super_survival_life_drain", "super_war_machine", "default", s_ability_case.angles );
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xbe6c0588, Offset: 0x52ae
    // Size: 0x5, Type: dev
    function function_103f3b5d1501b02c()
    {
        
    }

#/

// Namespace aries_util
// Params 2
// Checksum 0xbff9de5d, Offset: 0x52bb
// Size: 0x2e9
function function_ef6698d52dee64dd( var_350081e54157f2d8, var_8aa4e2649f733ea )
{
    level endon( #"aries_river_base_complete" );
    activity_instance = self;
    countdown = var_350081e54157f2d8.size;
    
    if ( getdvarint( @"hash_4bc188e324733a72", 0 ) )
    {
        index = randomintrange( 1, var_350081e54157f2d8.size + 1 );
        random_waypoint = var_350081e54157f2d8[ index ];
        countdown = 1;
        
        if ( isdefined( random_waypoint[ 0 ] ) && isdefined( random_waypoint[ 1 ] ) )
        {
            activity_instance thread function_ac25755336ef7ba8( index, random_waypoint[ 0 ], random_waypoint[ 1 ], undefined, var_8aa4e2649f733ea );
        }
        
        activity_instance thread function_919aa7fa81425c5d( index, var_350081e54157f2d8, var_8aa4e2649f733ea );
    }
    else
    {
        foreach ( index, var_939fda3d3c9d3f14 in var_350081e54157f2d8 )
        {
            if ( isdefined( var_939fda3d3c9d3f14[ 0 ] ) && isdefined( var_939fda3d3c9d3f14[ 1 ] ) )
            {
                activity_instance thread function_ac25755336ef7ba8( index, var_939fda3d3c9d3f14[ 0 ], var_939fda3d3c9d3f14[ 1 ], undefined, var_8aa4e2649f733ea );
            }
            
            wait 1;
        }
    }
    
    while ( countdown > 0 )
    {
        level waittill( #"hash_6dbd3ff8ce575581", value );
        var_350081e54157f2d8[ value ][ 2 ] = 1;
        
        foreach ( index, var_939fda3d3c9d3f14 in var_350081e54157f2d8 )
        {
            if ( !var_939fda3d3c9d3f14[ 2 ] )
            {
                level notify( "clear_waypoint_timed_reminder_" + index );
                
                if ( getdvarint( @"hash_4bc188e324733a72", 0 ) )
                {
                    b_dupe = 0;
                    var_b2f61d303f6c27b2 = utility::getstruct( var_939fda3d3c9d3f14[ 0 ], "targetname" );
                    
                    foreach ( circle in activity_instance.a_obj_circle )
                    {
                        if ( circle.origin[ 0 ] == var_b2f61d303f6c27b2.origin[ 0 ] && circle.origin[ 1 ] == var_b2f61d303f6c27b2.origin[ 1 ] )
                        {
                            b_dupe = 1;
                            break;
                        }
                    }
                    
                    if ( !b_dupe )
                    {
                        activity_instance thread function_ac25755336ef7ba8( index, var_939fda3d3c9d3f14[ 0 ], var_939fda3d3c9d3f14[ 1 ] );
                    }
                }
                else
                {
                    activity_instance thread function_ac25755336ef7ba8( index, var_939fda3d3c9d3f14[ 0 ], var_939fda3d3c9d3f14[ 1 ] );
                }
            }
            
            wait 1;
        }
        
        countdown--;
        wait 0.1;
    }
}

// Namespace aries_util
// Params 5
// Checksum 0x4a175909, Offset: 0x55ac
// Size: 0x269
function function_ac25755336ef7ba8( index, str_waypoint_targetname, flag_event, timeout = 60, quest_circle_radius )
{
    level endon( "clear_waypoint_timed_reminder_" + index );
    activity_instance = self;
    msg = utility::waittill_notify_or_timeout_return( flag_event, timeout );
    
    if ( msg != "timeout" )
    {
        return 1;
    }
    
    level notify( #"hash_6dbd3ff8ce575581", index );
    var_b2f61d303f6c27b2 = utility::getstruct( str_waypoint_targetname, "targetname" );
    
    if ( !isdefined( quest_circle_radius ) )
    {
        quest_circle_radius = 1024;
    }
    
    if ( isdefined( var_b2f61d303f6c27b2 ) && isdefined( var_b2f61d303f6c27b2.origin ) )
    {
        if ( getdvarint( @"hash_4bc188e324733a72", 0 ) )
        {
            b_dupe = 0;
            
            foreach ( circle in activity_instance.a_obj_circle )
            {
                if ( circle.origin[ 0 ] == var_b2f61d303f6c27b2.origin[ 0 ] && circle.origin[ 1 ] == var_b2f61d303f6c27b2.origin[ 1 ] )
                {
                    b_dupe = 1;
                    break;
                }
            }
            
            if ( !b_dupe )
            {
                obj_id = activity_instance ob_story_mission_utils::function_ab06e28322870f4( var_b2f61d303f6c27b2.origin, quest_circle_radius );
            }
        }
        else
        {
            obj_id = activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( var_b2f61d303f6c27b2.origin );
        }
        
        a_pair = [ obj_id, var_b2f61d303f6c27b2.origin ];
        
        if ( isdefined( level.var_25731c1d2290b64d ) )
        {
            level.var_25731c1d2290b64d[ level.var_25731c1d2290b64d.size ] = a_pair;
        }
        
        if ( isdefined( flag_event ) )
        {
            level utility::flag_wait( flag_event );
        }
        
        if ( getdvarint( @"hash_4bc188e324733a72", 0 ) )
        {
            if ( arraycontains( activity_instance.a_obj_circle, obj_id ) )
            {
                activity_instance ob_story_mission_utils::function_352aa3aab98a0618( obj_id );
            }
            
            return;
        }
        
        if ( arraycontains( activity_instance.a_obj_id, obj_id ) )
        {
            activity_instance ob_story_mission_utils::objective_marker_clear( obj_id );
        }
    }
}

// Namespace aries_util
// Params 3
// Checksum 0x4a3a68d1, Offset: 0x581d
// Size: 0x153
function function_919aa7fa81425c5d( revealed_index, var_350081e54157f2d8, quest_circle_radius )
{
    activity_instance = self;
    activity_instance utility::flag_wait( "flag_aries_river_barge_first_flower_destroyed" );
    msg = level utility::flag_wait_any_return( "flg_jungle_root_1_dest", "flg_jungle_root_2_dest", "flg_jungle_root_3_dest" );
    destroyed_index = 1;
    
    switch ( msg )
    {
        case #"hash_f484e1e1f6f1a32d":
            destroyed_index = 2;
            break;
        case #"hash_6f55625cc5cb15e0":
            destroyed_index = 3;
            break;
    }
    
    foreach ( index, var_939fda3d3c9d3f14 in var_350081e54157f2d8 )
    {
        if ( index == destroyed_index )
        {
            continue;
        }
        
        if ( index != revealed_index )
        {
            var_b2f61d303f6c27b2 = utility::getstruct( var_939fda3d3c9d3f14[ 0 ], "targetname" );
            obj_id = activity_instance ob_story_mission_utils::function_ab06e28322870f4( var_b2f61d303f6c27b2.origin, quest_circle_radius );
            activity_instance thread function_f1c6a24611d4e903( var_b2f61d303f6c27b2, obj_id, var_939fda3d3c9d3f14[ 1 ] );
        }
    }
}

// Namespace aries_util
// Params 3
// Checksum 0x344fade5, Offset: 0x5978
// Size: 0x9d
function function_f1c6a24611d4e903( var_b2f61d303f6c27b2, obj_id, flag_event )
{
    activity_instance = self;
    a_pair = [ obj_id, var_b2f61d303f6c27b2.origin ];
    
    if ( isdefined( level.var_25731c1d2290b64d ) )
    {
        level.var_25731c1d2290b64d[ level.var_25731c1d2290b64d.size ] = a_pair;
    }
    
    if ( isdefined( flag_event ) )
    {
        level utility::flag_wait( flag_event );
    }
    
    if ( arraycontains( activity_instance.a_obj_circle, obj_id ) )
    {
        activity_instance ob_story_mission_utils::function_352aa3aab98a0618( obj_id );
    }
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xda440971, Offset: 0x5a1d
    // Size: 0x5, Type: dev
    function function_f4739c897a182338()
    {
        
    }

#/

// Namespace aries_util
// Params 2
// Checksum 0x8c1e99d9, Offset: 0x5a2a
// Size: 0xba
function bloodpool_handler( triggers_targetname, endonflag )
{
    self endon( endonflag );
    var_f0f5992896ac4854 = getnoentvolumearray( triggers_targetname, #targetname );
    
    foreach ( blood_pool_trigger in var_f0f5992896ac4854 )
    {
        blood_pool_trigger childthread function_5ca4b75ff2a9155();
    }
    
    if ( !isdefined( level.var_2985432051e64d71 ) )
    {
        function_48e7ae5855bc8be3();
    }
}

// Namespace aries_util
// Params 0
// Checksum 0xf76a0c92, Offset: 0x5aec
// Size: 0x1e
function function_48e7ae5855bc8be3()
{
    utility::add_fx( "blood_waterfall_drops", "vfx_sat_mp_ob_aries_container_stream_cam_01" );
    level.var_2985432051e64d71 = 1;
}

// Namespace aries_util
// Params 0
// Checksum 0xa35469ee, Offset: 0x5b12
// Size: 0x79
function function_5ca4b75ff2a9155()
{
    self notify( #"hash_3b7bd0a845243484" );
    self endon( #"hash_3b7bd0a845243484" );
    self.affected_players = [];
    
    while ( true )
    {
        self waittill( #"trigger", triggerer );
        
        if ( !arraycontains( self.affected_players, triggerer ) )
        {
            triggerer thread function_ff928707a246ee64( self );
            self.affected_players[ self.affected_players.size ] = triggerer;
        }
    }
}

// Namespace aries_util
// Params 1
// Checksum 0x8290b44d, Offset: 0x5b93
// Size: 0xb2
function function_ff928707a246ee64( e_trigger )
{
    self endon( #"death_or_disconnect" );
    playfxontagforclients( utility::getfx( "blood_waterfall_drops" ), self, "j_head", self );
    
    while ( self istouching( e_trigger ) )
    {
        if ( isplayer( self ) )
        {
            if ( player::isinlaststand( self ) )
            {
                self dodamage( 1, self.origin, self, self );
            }
            else
            {
                self dodamage( 1, self.origin, self, self );
            }
            
            wait 1;
        }
    }
    
    if ( isdefined( self ) )
    {
        stopfxontagforclients( utility::getfx( "blood_waterfall_drops" ), self, "j_head", self );
        e_trigger.affected_players = arrayremove( e_trigger.affected_players, self );
    }
}

// Namespace aries_util
// Params 0
// Checksum 0xad697664, Offset: 0x5c4d
// Size: 0xd5
function bloodpool_player_setup()
{
    if ( !utility::flag( "flag_bloodpool_revive_respawn" ) )
    {
        callback::add( #"player_spawned", &function_a12440d9d4452ecf );
        callback::add( #"player_connect", &function_a12440d9d4452ecf );
        callback::add( #"hash_cc06eb1d45f33a0c", &function_a12440d9d4452ecf );
        utility::flag_set( "flag_bloodpool_revive_respawn" );
    }
    
    foreach ( player in level.players )
    {
        player thread function_a12440d9d4452ecf();
    }
}

// Namespace aries_util
// Params 1
// Checksum 0x15c985fe, Offset: 0x5d2a
// Size: 0x113
function function_a12440d9d4452ecf( params )
{
    self notify( #"hash_4b0b5ac2a00a8275" );
    self endon( #"hash_4b0b5ac2a00a8275" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( !utility::flag( "aries_boss_phasethree_complete" ) && isalive( self ) )
    {
        if ( player::isinlaststand( self ) )
        {
            if ( isalive( self ) && self isswimming() )
            {
                self dodamage( 1, self.origin, self, self );
                squadwipe = ob_gametype_story_mission::function_bdac21d30de781da();
                
                if ( squadwipe )
                {
                    self kill();
                    break;
                }
            }
            
            wait 1;
        }
        
        if ( isalive( self ) && self isswimming() )
        {
            self dodamage( 1, self.origin, self, self );
            wait 1;
            continue;
        }
        
        if ( isalive( self ) && utility::ispointinwater( self.origin ) )
        {
            self dodamage( 2, self.origin, self, self );
            wait 1;
            continue;
        }
        
        waitframe();
    }
}

// Namespace aries_util
// Params 6
// Checksum 0xabaa5b97, Offset: 0x5e45
// Size: 0xcb
function waterfall_handler( vfx_waterfall, trig_damage, var_171ccbf6191b59be, hide_flag, var_17e53713cad723bb, flag_sfx )
{
    utility::flag_wait( "scriptables_ready" );
    
    if ( isdefined( var_171ccbf6191b59be ) )
    {
        utility::flag_wait( var_171ccbf6191b59be );
    }
    
    if ( isdefined( var_17e53713cad723bb ) )
    {
        wait var_17e53713cad723bb;
    }
    
    vfx_scriptable = getentitylessscriptablearray( vfx_waterfall, "script_noteworthy" )[ 0 ];
    waitframe();
    vfx_scriptable setscriptablepartstate( "VFX", "visible" );
    
    if ( isdefined( flag_sfx ) )
    {
        utility::flag_set( flag_sfx );
    }
    
    if ( isdefined( trig_damage ) )
    {
        thread bloodpool_handler( trig_damage, "flag_aries_nightmare_tower_water_level_90" );
    }
    
    if ( isdefined( hide_flag ) )
    {
        utility::flag_wait( hide_flag );
        vfx_scriptable setscriptablepartstate( "VFX", "hidden" );
    }
}

// Namespace aries_util
// Params 4
// Checksum 0xad91cb48, Offset: 0x5f18
// Size: 0x86
function function_e28a5c3e044c9723( vfx_nw, cleanup_flag, var_171ccbf6191b59be, var_17e53713cad723bb )
{
    utility::flag_wait( "scriptables_ready" );
    
    if ( isdefined( var_171ccbf6191b59be ) )
    {
        utility::flag_wait( var_171ccbf6191b59be );
    }
    
    if ( isdefined( var_17e53713cad723bb ) )
    {
        wait var_17e53713cad723bb;
    }
    
    vfx_scriptable = getentitylessscriptablearray( vfx_nw, "script_noteworthy" )[ 0 ];
    waitframe();
    vfx_scriptable setscriptablepartstate( "VFX", "visible" );
    utility::flag_wait( cleanup_flag );
    vfx_scriptable delete();
}

/#

    // Namespace aries_util
    // Params 0
    // Checksum 0xf76c3c8c, Offset: 0x5fa6
    // Size: 0x5, Type: dev
    function function_6511bc8f9e1a50bd()
    {
        
    }

#/

// Namespace aries_util
// Params 1
// Checksum 0xdcf2706c, Offset: 0x5fb3
// Size: 0x147
function hallucinate_manager( scale )
{
    switch ( scale )
    {
        case #"hash_2daf318af0c70342":
            earthquake( 0.8, 1.25, self.origin, 256 );
            playrumbleonposition( "artillery_rumble_light", self.origin );
            break;
        case #"hash_a140edb8b517af03":
            earthquake( 0.75, 0.8, self.origin, 256 );
            playrumbleonposition( "artillery_rumble_light", self.origin );
            break;
        case #"hash_c71b112fe04823d6":
            earthquake( 0.4, 0.6, self.origin, 256 );
            playrumbleonposition( "artillery_rumble_light", self.origin );
            break;
        case #"hash_29ed96c0ae9b5ce":
            earthquake( 0.3, 0.5, self.origin, 256 );
            playrumbleonposition( "artillery_rumble_light", self.origin );
            break;
        case #"hash_4ee5dd8d108f25e6":
            earthquake( 0.4, 1.75, self.origin, 256 );
            playrumbleonposition( "artillery_rumble_light", self.origin );
            break;
    }
}

// Namespace aries_util
// Params 1, eflags: 0x4
// Checksum 0xc4e2d4c9, Offset: 0x6102
// Size: 0x31
function private function_8bdb68aaf251cce0( duration )
{
    vision_utility::function_89d3efe42060754c( "ac130_flir_glitch", 0.25 );
    wait duration;
    vision_utility::function_6cb9d8e0202ee81( "ac130_flir_glitch", 0.5 );
}

