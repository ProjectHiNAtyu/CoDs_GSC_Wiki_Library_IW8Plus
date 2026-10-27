// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_river_jungle.gsc  (hash_271069fc4bab99ee.gscc) (size: 6054 Bytes / 0x17a6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x880850a5 (2282246309)
// size ...... 6054 (0x17a6)
// includes .. 14  (offset: 0x1582)
// strings ... 31  (offset: 0x15f2)
// dev strs .. 0   (offset: 0x17a6)
// exports ... 18  (offset: 0xaf2)
// cseg ...... 0x2e4 + 0x80e (0xaf2)
// imports ... 68  (offset: 0xdc2)
// animtree1 . 0   (offset: 0x17a6)
// animtree2 . 0   (offset: 0x17a6)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\chyron;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_river_waterfall;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;

#namespace namespace_428e8296940d82f;

// Namespace namespace_428e8296940d82f
// Params 0, eflags: 0x5
// Checksum 0xafa73c88, Offset: 0x302
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a19c0fc4b410fd33", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_428e8296940d82f
// Params 0, eflags: 0x4
// Checksum 0x7e2dc063, Offset: 0x32b
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_RIVER_JUNGLE";
    activity_common::registeractivitytype( "OB_ARIES_RIVER_JUNGLE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_JUNGLE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_JUNGLE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_JUNGLE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_RIVER_JUNGLE" );
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0x8c131a55, Offset: 0x3a2
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_6ebca32596469abf();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0x5a09f782, Offset: 0x403
// Size: 0x52
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    story_contract_util::mark_complete( level.players, #"aries_launch" );
    activity_instance function_2cca153dfc990ce8();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0x304e4c8e, Offset: 0x45d
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_428e8296940d82f
// Params 1
// Checksum 0x4e8e4ea7, Offset: 0x481
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_f6587b4851d706ee( player );
    }
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0xaea24439, Offset: 0x53d
// Size: 0x16
function function_6ebca32596469abf()
{
    activity_instance = self;
    ob_story_mission_utils::function_6314f03dfe2adbc5();
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0x9a1e526, Offset: 0x55b
// Size: 0x8b
function function_2cca153dfc990ce8()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    aries_util::function_ff8302797d7d1756();
    activity_instance thread chyron::function_d41002779543c80e();
    level thread aries_vo::function_5708884067303551();
    activity_instance thread function_43d699447dea5816();
    activity_instance thread function_901d9a3f6f488d67();
    level thread function_35127c9b8bb9d31f();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_river_jungle_weapon", "flag_river_trail_ambush", 1 );
    activity_instance thread namespace_431f49c04df538e7::function_e9dab9bdf043397d();
    activity_instance thread namespace_431f49c04df538e7::function_66e2b6b02ac05427();
    level utility::flag_wait( "flag_look_for_woods_jungle_01" );
}

// Namespace namespace_428e8296940d82f
// Params 1
// Checksum 0xd3c135a0, Offset: 0x5ee
// Size: 0x35
function function_f6587b4851d706ee( player )
{
    activity_instance = self;
    activity_instance thread function_915fa23c7ad24757( player );
    player ob_story_mission_utils::function_2383fc8bfc3074d2();
    player ob_story_mission_utils::function_288fdad79fa2a11();
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0xafe45737, Offset: 0x62b
// Size: 0x48
function function_901d9a3f6f488d67()
{
    t_start = getent( "trig_jungle_intro_grapple", #targetname );
    t_start waittill( #"trigger" );
    level utility::flag_set( "river_jungle_update_wp_1" );
    
    if ( isdefined( t_start ) )
    {
        t_start delete();
    }
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0xaeaef2a2, Offset: 0x67b
// Size: 0x13
function function_35127c9b8bb9d31f()
{
    aries_util::function_619b5a0410cf1a0a( "e_river_trail_vtol", "hide" );
}

/#

    // Namespace namespace_428e8296940d82f
    // Params 0
    // Checksum 0x6961dc8e, Offset: 0x696
    // Size: 0x5, Type: dev
    function function_215737ca5dda02a4()
    {
        
    }

#/

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0xb53b345e, Offset: 0x6a3
// Size: 0x9d
function function_43d699447dea5816()
{
    activity_instance = self;
    level endon( #"dawg_objective_start", #"hash_de389439306f958d", #"OB_ARIES_RIVER_MINEFIELD" );
    level.var_5fe1c01595a2e32b = [];
    level utility::flag_wait_or_timeout( "flag_jungle_vo_find_woods_complete", 10 );
    ob_story_mission_utils::function_31f2c265b77aa2c1( 1 );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_look_for_woods_jungle" );
    level utility::flag_wait( "flag_grapple_hook_vo" );
    ob_story_mission_utils::objective_text_clear();
    waitframe();
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_grapple_hook_jungle" );
    activity_instance thread function_227164c53c6c785e();
    level utility::flag_wait( "flag_look_for_woods_jungle_01" );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0x1e38c9f9, Offset: 0x748
// Size: 0x12a
function function_227164c53c6c785e()
{
    if ( ob::nightmare() )
    {
        return;
    }
    
    activity_instance = self;
    wait 3;
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_grapple_hook", &"sat_ob/hint_grapple_hook", 10 );
        
        if ( !player getcamerathirdperson() && player::isaliveandnotinlaststand( player ) )
        {
            if ( !player isswitchingweapon() && !player isreloading() && !player ismantling() && !player isthrowinggrenade() && !player israisingweapon() && !player ismeleeing() && !player function_41360f0bcfc012aa() && player isonground() )
            {
                player thread function_c03fce1b4112cce6();
            }
        }
    }
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0xac321cde, Offset: 0x87a
// Size: 0x1b4
function function_c03fce1b4112cce6()
{
    player = self;
    player val::set( "grapple_inspect", "damageshield", 1 );
    player val::set( "grapple_inspect", "damage", 0 );
    player val::set( "grapple_inspect", "show_hud", 0 );
    player val::set( "grapple_inspect", "fire", 0 );
    player val::set( "grapple_inspect", "ads", 0 );
    player val::set( "grapple_inspect", "reload", 0 );
    player val::set( "grapple_inspect", "weapon_switch", 0 );
    player val::set( "grapple_inspect", "offhand_weapons", 0 );
    player val::set( "grapple_inspect", "armor", 0 );
    player val::set( "grapple_inspect", "melee", 0 );
    player thread function_9b50e1e787a11c73();
    old_wpn = player.primaryweapons[ 0 ];
    
    if ( player getcurrentweapon() == player.primaryweapons[ 1 ] )
    {
        old_wpn = player.primaryweapons[ 1 ];
    }
    
    player takeweapon( old_wpn );
    grapple_wpn = makeweapon( "sat_wpn_prop_grappling_gun" );
    player giveweapon( grapple_wpn );
    level utility::flag_set( "flag_grapple_hook_vo_start" );
    player switchtoweapon( grapple_wpn );
    wait 2.5;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    remove_wpn = player aries_util::function_862a02480e506c14();
    
    if ( isdefined( remove_wpn ) )
    {
        self takeweapon( remove_wpn );
    }
    
    player giveweapon( old_wpn, 0, 0, 0, 1 );
    player switchtoweapon( old_wpn );
    player ob_story_mission_utils::function_ec74a55c78cc831( 1 );
    player val::reset_all( "grapple_inspect" );
}

// Namespace namespace_428e8296940d82f
// Params 0
// Checksum 0xad30b4c6, Offset: 0xa36
// Size: 0x3b
function function_9b50e1e787a11c73()
{
    self endon( #"hash_c280c79b99811a3e" );
    self waittill( #"player_teleport_end" );
    remove_wpn = aries_util::function_862a02480e506c14();
    
    if ( isdefined( remove_wpn ) )
    {
        self takeweapon( remove_wpn );
    }
}

// Namespace namespace_428e8296940d82f
// Params 1
// Checksum 0x327b97c0, Offset: 0xa79
// Size: 0x79
function function_915fa23c7ad24757( player )
{
    activity_instance = self;
    player endon( #"ent_flag_jungle_clear_wp_1", #"death_or_disconnect" );
    player utility::ent_flag_wait( "ent_flag_grapple_hook_vo" );
    obj_s = utility::getstruct( "s_wp_jungle_cliffs_1", "targetname" );
    activity_instance thread aries_util::function_e6895f5efd1feb56( player, obj_s.origin, undefined, undefined, player, "ent_flag_jungle_clear_wp_1", undefined, 2500 );
}

