// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries.gsc  (hash_16beee3d9e352b05.gscc) (size: 4374 Bytes / 0x1116 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a407533 (1782609203)
// size ...... 4374 (0x1116)
// includes .. 13  (offset: 0xf5a)
// strings ... 25  (offset: 0xfc2)
// dev strs .. 0   (offset: 0x1116)
// exports ... 8   (offset: 0x91e)
// cseg ...... 0x22e + 0x6f0 (0x91e)
// imports ... 42  (offset: 0xa5e)
// animtree1 . 0   (offset: 0x1116)
// animtree2 . 0   (offset: 0x1116)
#using script_636bd827a012af12;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_starts;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\outofbounds;
#using scripts\mp\overlord;
#using scripts\mp\telemetry_coop;

#namespace mp_sat_ob_aries;

// Namespace mp_sat_ob_aries
// Params 0
// Checksum 0x1b21e355, Offset: 0x24c
// Size: 0x2b2
function main()
{
    level.is_quest_story_mission = 1;
    precacheshader( "compass_map_mp_sat_ob_aries" );
    aries_audio::main();
    load::main();
    register_region_difficulties();
    outofbounds::registeroobentercallback( "player", &function_2b21ee45f81825e1 );
    level overlord::function_ddcc4b96977bcf4a( [ "ob/overlord_ob.csv", "ob/overlord_ob_aries.csv" ] );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvarifuninitialized( @"hash_ca08f59b64628422", "sat_aries_outro" );
    init_aries_activities();
    level thread set_minimap();
    level thread setup_boss_clips();
    setdvar( @"hash_fbb8d521a6914269", 16 );
    setdvar( @"hash_592417bef799b135", 1 );
    setdvar( @"bg_compassshowenemies", 1 );
    level thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "OutOfBounds" );
    
    if ( !ob::nightmare() )
    {
        laser_triggers = getentarray( "trig_laser_hurt", "targetname" );
        
        foreach ( trig in laser_triggers )
        {
            trig delete();
        }
        
        return;
    }
    
    laser_triggers = getentarray( "trig_laser_hurt", "targetname" );
    
    foreach ( trig in laser_triggers )
    {
        trig delete();
    }
    
    var_b2847202e6ba3325 = getentarray( "trig_boss_hurt", "targetname" );
    
    foreach ( trig in var_b2847202e6ba3325 )
    {
        trig delete();
    }
}

// Namespace mp_sat_ob_aries
// Params 0
// Checksum 0xa6849025, Offset: 0x506
// Size: 0x25
function register_region_difficulties()
{
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        level callback::callback( "region_difficulties_registered" );
    }
}

// Namespace mp_sat_ob_aries
// Params 0
// Checksum 0x6c88c206, Offset: 0x533
// Size: 0x2a
function set_minimap()
{
    compass::setupminimap( "compass_map_mp_sat_ob_aries" );
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 15 );
    wait 1;
    compass::init_minimap_triggers();
}

// Namespace mp_sat_ob_aries
// Params 0
// Checksum 0x64c58676, Offset: 0x565
// Size: 0x5d
function init_aries_activities()
{
    callback::add( #"player_spawned", &aries_util::player_setup );
    
    if ( !ob::nightmare() )
    {
        ob_aries_startpoint::function_5de80b69cadf84b8();
        ob_aries_startpoint::init_aries_nightmare_activities();
        ob_aries_startpoint::init_aries_boss_activities();
    }
    else
    {
        setgameprops( %"mp_sat_ob_virgo_nightmare" );
        ob_aries_startpoint::function_3fd951b2f2b783a1();
    }
    
    ob_aries_startpoint::function_e436133437cda485();
    level thread ob_gametype_story_mission::function_a535ecaaab8427b7();
}

// Namespace mp_sat_ob_aries
// Params 1
// Checksum 0x14fedbe8, Offset: 0x5ca
// Size: 0x19
function function_7be4c04ab57caefa( params )
{
    outofbounds::registerentforoob( self, "player" );
}

// Namespace mp_sat_ob_aries
// Params 3
// Checksum 0xd54a616d, Offset: 0x5eb
// Size: 0xb7
function function_2b21ee45f81825e1( exitnotify, clearnotify, triggertype )
{
    telemetry_coop::function_48065623105118c3();
    closest_point = getclosestpointonnavmesh( self.origin );
    
    if ( isdefined( closest_point ) )
    {
        self setorigin( closest_point + ( 0, 0, 32 ) );
        self setvelocity( ( 0, 0, 0 ) );
        return;
    }
    
    a_spawn_points = getspawnarray( "mp_ob_spawn_start" );
    self setorigin( a_spawn_points[ 0 ].origin + ( 0, 0, 32 ) );
    self setplayerangles( a_spawn_points[ 0 ].angles );
}

// Namespace mp_sat_ob_aries
// Params 0
// Checksum 0x22550593, Offset: 0x6aa
// Size: 0x274
function setup_boss_clips()
{
    aries_boss_ai_clips = getentarray( "aries_boss_ai_clips", "targetname" );
    island_clip = getent( "nm_barge_clip", "targetname" );
    barge_cover_pieces = getentarray( "nm_barge_cover", "targetname" );
    barge_cover_clips = getentarray( "nm_barge_cover_clip", "targetname" );
    barge_cover = arraycombine( barge_cover_pieces, barge_cover_clips );
    
    if ( !ob::nightmare() )
    {
        if ( isdefined( aries_boss_ai_clips ) )
        {
            foreach ( clip in aries_boss_ai_clips )
            {
                clip connectpaths();
            }
        }
        
        if ( isdefined( island_clip ) )
        {
            island_clip disconnectpaths();
            waitframe();
            island_clip delete();
        }
        
        if ( isdefined( barge_cover ) )
        {
            foreach ( cover in barge_cover )
            {
                cover delete();
            }
        }
        
        return;
    }
    
    if ( isdefined( island_clip ) )
    {
        island_clip connectpaths();
        waitframe();
        island_clip delete();
    }
    
    if ( isdefined( barge_cover ) )
    {
        foreach ( cover in barge_cover )
        {
            cover movez( 512, 0.25 );
        }
    }
    
    if ( isdefined( barge_cover_clips ) )
    {
        foreach ( clip in barge_cover_clips )
        {
            clip disconnectpaths();
        }
    }
}

