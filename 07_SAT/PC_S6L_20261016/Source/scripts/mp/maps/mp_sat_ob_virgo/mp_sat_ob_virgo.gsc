// scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo.gsc  (hash_18ab27f5a45c5ea9.gscc) (size: 4346 Bytes / 0x10fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc930f870 (3375429744)
// size ...... 4346 (0x10fa)
// includes .. 13  (offset: 0xe86)
// strings ... 39  (offset: 0xeee)
// dev strs .. 0   (offset: 0x10fa)
// exports ... 6   (offset: 0x8b2)
// cseg ...... 0x331 + 0x581 (0x8b2)
// imports ... 41  (offset: 0x9a2)
// animtree1 . 0   (offset: 0x10fa)
// animtree2 . 0   (offset: 0x10fa)
#using script_34b50456e3922412;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_lighting;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_starts;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\overlord;

#namespace mp_sat_ob_virgo;

// Namespace mp_sat_ob_virgo
// Params 0
// Checksum 0xf393b340, Offset: 0x34f
// Size: 0x182
function main()
{
    level.is_quest_story_mission = 1;
    precacheshader( "compass_map_mp_sat_ob_virgo" );
    virgo_audio::main();
    virgo_lighting::main();
    load::main();
    register_region_difficulties();
    level overlord::function_ddcc4b96977bcf4a( [ "ob/overlord_ob.csv", "ob/overlord_ob_virgo.csv" ] );
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvarifuninitialized( @"hash_ca08f59b64628422", "sat_virgo_outro" );
    init_virgo_activities();
    
    if ( !ob::nightmare() )
    {
        callback::add( #"player_spawned", &ob_virgo_util::function_ac8a27a537d8ac9c );
    }
    
    ob_virgo_util::init_hide_and_show_models();
    ob_virgo_util::init_vehicles();
    virgo_vo::init_virgo_radio();
    ob_virgo_util::function_62429e1b1c34454c();
    ob_virgo_util::virgo_effects();
    setgameprops( %"mp_sat_ob_virgo" );
    level.virgo = spawnstruct();
    level thread ob_virgo_util::function_3af329f7a69f7b06();
    level thread ob_virgo_util::function_dbc4595e2e99750();
    level.default_goalradius = 128;
    level thread virgo_minimap();
    
    if ( ob::nightmare() )
    {
        level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
        level.gametypebundle.enableintel = 0;
        setgameprops( %"mp_sat_ob_virgo_nightmare" );
        return;
    }
    
    thread function_5fb3a8c37ab7de60();
}

// Namespace mp_sat_ob_virgo
// Params 0
// Checksum 0xb67b6f48, Offset: 0x4d9
// Size: 0x2a
function virgo_minimap()
{
    compass::setupminimap( "compass_map_mp_sat_ob_virgo" );
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 15 );
    wait 1;
    compass::init_minimap_triggers();
}

// Namespace mp_sat_ob_virgo
// Params 0
// Checksum 0x3f1c05c4, Offset: 0x50b
// Size: 0x25
function register_region_difficulties()
{
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        level callback::callback( "region_difficulties_registered" );
    }
}

// Namespace mp_sat_ob_virgo
// Params 0
// Checksum 0x2118641a, Offset: 0x538
// Size: 0x3a
function init_virgo_activities()
{
    if ( !ob::nightmare() )
    {
        ob_virgo_startpoint::function_dde497892d9a4eca();
        ob_virgo_startpoint::function_2410a69c1fa2d233();
        ob_virgo_startpoint::init_virgo_carrier_activities();
    }
    else
    {
        ob_virgo_startpoint::function_b22efc63f5e59851();
    }
    
    ob_virgo_startpoint::init_virgo_return();
    level thread ob_gametype_story_mission::function_a535ecaaab8427b7();
}

// Namespace mp_sat_ob_virgo
// Params 0
// Checksum 0x2dbfb958, Offset: 0x57a
// Size: 0x338
function function_5fb3a8c37ab7de60()
{
    var_27dc14fa7d0d9942 = getscriptablearray( "jpn_start_gen", #targetname );
    garden_gen = getscriptablearray( "garden_gen", #targetname );
    hut_gens = getscriptablearray( "hut_gen", #targetname );
    parking_gens = getscriptablearray( "parking_gen", #targetname );
    models = getentarray( "nm_gen_model", "script_noteworthy" );
    clips = getentarray( "nm_gen_clip", "targetname" );
    container = getentarray( "nm_jpn_abom_container", "targetname" );
    container_clips = getentarray( "nm_jpn_abom_container_clips", "targetname" );
    new_array = arraycombine( models, clips, container, container_clips );
    scriptable_array = arraycombine( garden_gen, hut_gens, parking_gens, var_27dc14fa7d0d9942 );
    
    foreach ( g in scriptable_array )
    {
        if ( isdefined( g ) )
        {
            g setscriptablepartstate( "force_field_power_supply", "off" );
        }
    }
    
    foreach ( ent in new_array )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
    
    clip = getent( "nm_jpn_start_clip", "targetname" );
    
    if ( isdefined( clip ) )
    {
        clip delete();
    }
    
    boss_button = getent( "nm_boss_button", "targetname" );
    
    if ( isdefined( boss_button ) )
    {
        boss_button delete();
    }
    
    truck = getent( "nm_la_truck", "targetname" );
    truck_clips = getent( "nm_la_truck_clips", "targetname" );
    
    if ( isdefined( truck ) )
    {
        truck delete();
    }
    
    if ( isdefined( truck_clips ) )
    {
        truck_clips delete();
    }
    
    truck_2 = getent( "nm_la_truck_2", "targetname" );
    truck_2_clips = getent( "nm_la_truck_2_clips", "targetname" );
    
    if ( isdefined( truck_2 ) )
    {
        truck_2 delete();
    }
    
    if ( isdefined( truck_2_clips ) )
    {
        truck_2_clips delete();
    }
    
    level thread ob_nm_mode::function_7e4765db24e0ee73( "off", "jpn_wall_start", #targetname );
    level thread ob_nm_mode::function_7e4765db24e0ee73( "off", "jpn_wall_1", #targetname );
    level thread ob_nm_mode::function_7e4765db24e0ee73( "off", "jpn_wall_2", #targetname );
    level thread ob_nm_mode::function_7e4765db24e0ee73( "off", "jpn_wall_3", #targetname );
}

