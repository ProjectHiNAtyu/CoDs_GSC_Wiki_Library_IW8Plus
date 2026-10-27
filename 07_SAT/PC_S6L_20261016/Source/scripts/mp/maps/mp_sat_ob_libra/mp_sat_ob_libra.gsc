// scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra.gsc  (hash_2777a805a640b7ed.gscc) (size: 5140 Bytes / 0x1414 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd923068d (3642951309)
// size ...... 5140 (0x1414)
// includes .. 13  (offset: 0x11d8)
// strings ... 31  (offset: 0x1240)
// dev strs .. 1   (offset: 0x1408)
// exports ... 10  (offset: 0xbbc)
// cseg ...... 0x247 + 0x975 (0xbbc)
// imports ... 37  (offset: 0xd4c)
// animtree1 . 0   (offset: 0x1414)
// animtree2 . 0   (offset: 0x1414)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_fx;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_starts;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\overlord;

#namespace mp_sat_ob_libra;

// Namespace mp_sat_ob_libra
// Params 0
// Checksum 0x9dc08005, Offset: 0x265
// Size: 0x1aa
function main()
{
    level.is_quest_story_mission = 1;
    
    /#
        setdvarifuninitialized( @"hash_8a31c22d672b8857", 3 );
    #/
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
        {
            level thread mp_sat_ob_libra_util::function_2fd559479db565bc( "<dev string:x24>", #targetname );
        }
    #/
    
    if ( !isdefined( level.default_goalradius ) )
    {
        level.default_goalradius = 1024;
    }
    
    scriptable::scriptable_adddamagedcallback( &mp_sat_ob_libra_util::function_c50fc0694e69ce63 );
    libra_audio::main();
    mp_sat_ob_libra_fx::main();
    
    if ( !ob::nightmare() )
    {
        callback::add( #"player_spawned", &remove_wingsuit );
        thread function_a039142ae7793046();
    }
    else
    {
        callback::add( #"player_spawned", &give_wingsuit );
        level.gametypebundle.enableintel = 0;
        level.vehiclespawndisabled = 1;
    }
    
    load::main();
    mp_sat_ob_libra_lighting::main();
    register_region_difficulties();
    level thread init_doors();
    level thread mp_sat_ob_libra_util::setup_cradle_canister_burst();
    level.var_d2cd3259bd5f8dcf = 1;
    setdvarifuninitialized( @"hash_ca08f59b64628422", "sat_end_flow" );
    level overlord::function_ddcc4b96977bcf4a( [ "ob/overlord_ob.csv", "ob/overlord_ob_libra.csv" ] );
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level thread libra_minimap();
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    init_libra_activities();
    level.hellstorm_intro_fraction = 0.9;
    level thread destructible_screens();
}

// Namespace mp_sat_ob_libra
// Params 0
// Checksum 0xa6c8c184, Offset: 0x417
// Size: 0x2a
function libra_minimap()
{
    compass::setupminimap( "compass_map_mp_sat_ob_libra" );
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 15 );
    wait 1;
    compass::init_minimap_triggers();
}

// Namespace mp_sat_ob_libra
// Params 1
// Checksum 0xc8ee5e25, Offset: 0x449
// Size: 0x1a
function remove_wingsuit( params )
{
    ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_defaultsuit_ob_no_skydiving", 1 );
}

// Namespace mp_sat_ob_libra
// Params 1
// Checksum 0x10f30387, Offset: 0x46b
// Size: 0x1a
function give_wingsuit( params )
{
    ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm", 1 );
}

// Namespace mp_sat_ob_libra
// Params 0
// Checksum 0xe03fd941, Offset: 0x48d
// Size: 0x25
function register_region_difficulties()
{
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        level callback::callback( "region_difficulties_registered" );
    }
}

// Namespace mp_sat_ob_libra
// Params 0
// Checksum 0xcff8f064, Offset: 0x4ba
// Size: 0x11
function init_libra_activities()
{
    ob_libra_startpoint::function_97e5a48748c953();
    level thread ob_gametype_story_mission::function_a535ecaaab8427b7();
}

// Namespace mp_sat_ob_libra
// Params 0
// Checksum 0xd5eec07c, Offset: 0x4d3
// Size: 0x17
function init_doors()
{
    level utility::flag_wait( "scriptables_ready" );
    level thread mp_sat_ob_libra_util::function_e3164f9f3de54eaa();
}

// Namespace mp_sat_ob_libra
// Params 0
// Checksum 0xa27d8b8d, Offset: 0x4f2
// Size: 0x512
function destructible_screens()
{
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    level.standby = getentitylessscriptablearray( "standby", #targetname );
    level.static = getentitylessscriptablearray( "static", #targetname );
    level.off = getentitylessscriptablearray( "off", #targetname );
    level.full = getentitylessscriptablearray( "full", #targetname );
    level.bink1 = getentitylessscriptablearray( "bink1", #targetname );
    level.bink2 = getentitylessscriptablearray( "bink2", #targetname );
    level.bink3 = getentitylessscriptablearray( "bink3", #targetname );
    level.bink4 = getentitylessscriptablearray( "bink4", #targetname );
    
    if ( isdefined( level.static ) )
    {
        foreach ( scriptable in level.static )
        {
            scriptable setscriptablepartstate( "base", "static" );
        }
    }
    
    if ( isdefined( level.standby ) )
    {
        foreach ( scriptable in level.standby )
        {
            scriptable setscriptablepartstate( "base", "standby" );
        }
    }
    
    if ( isdefined( level.off ) )
    {
        foreach ( scriptable in level.off )
        {
            scriptable setscriptablepartstate( "base", "off" );
        }
    }
    
    if ( isdefined( level.full ) )
    {
        foreach ( scriptable in level.full )
        {
            scriptable setscriptablepartstate( "base", "full" );
        }
    }
    
    if ( isdefined( level.bink1 ) )
    {
        foreach ( scriptable in level.bink1 )
        {
            scriptable setscriptablepartstate( "base", "bink1" );
        }
    }
    
    if ( isdefined( level.bink2 ) )
    {
        foreach ( scriptable in level.bink2 )
        {
            scriptable setscriptablepartstate( "base", "bink2" );
        }
    }
    
    if ( isdefined( level.bink3 ) )
    {
        foreach ( scriptable in level.bink3 )
        {
            scriptable setscriptablepartstate( "base", "bink3" );
        }
    }
    
    if ( isdefined( level.bink4 ) )
    {
        foreach ( scriptable in level.bink4 )
        {
            scriptable setscriptablepartstate( "base", "bink4" );
        }
    }
    
    waitframe();
}

// Namespace mp_sat_ob_libra
// Params 0
// Checksum 0x9a682bb4, Offset: 0xa0c
// Size: 0x1b0
function function_a039142ae7793046()
{
    hela_clips = getentarray( "hela_clip", "targetname" );
    force_fields = getentarray( "nm_shields", "targetname" );
    ff_clips = getentarray( "nm_ff_clips", "targetname" );
    
    foreach ( clip in hela_clips )
    {
        if ( isdefined( clip ) )
        {
            clip delete();
        }
    }
    
    foreach ( ent in force_fields )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
    
    ff_clips = getentarray( "nm_ff_clips", "targetname" );
    
    foreach ( clip in ff_clips )
    {
        if ( isdefined( clip ) )
        {
            clip delete();
        }
    }
}

