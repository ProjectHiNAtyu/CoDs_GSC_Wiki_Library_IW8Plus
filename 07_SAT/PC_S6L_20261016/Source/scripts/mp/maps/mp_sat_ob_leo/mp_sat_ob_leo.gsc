// scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo.gsc  (hash_1f483f01a517da79.gscc) (size: 5889 Bytes / 0x1701 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x443be923 (1144776995)
// size ...... 5889 (0x1701)
// includes .. 13  (offset: 0x144d)
// strings ... 33  (offset: 0x14b5)
// dev strs .. 8   (offset: 0x1659)
// exports ... 8   (offset: 0xc49)
// cseg ...... 0x356 + 0x8f3 (0xc49)
// imports ... 56  (offset: 0xd89)
// animtree1 . 0   (offset: 0x1701)
// animtree2 . 0   (offset: 0x1701)
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_starts;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\ob\jailbreak_machine;
#using scripts\mp\overlord;

#namespace mp_sat_ob_leo;

// Namespace mp_sat_ob_leo
// Params 0
// Checksum 0xd478f201, Offset: 0x374
// Size: 0x402
function main()
{
    level.is_quest_story_mission = 1;
    precacheshader( "compass_map_mp_sat_ob_leo" );
    leo_audio::main();
    load::main();
    level._effect[ "menendez_disappear" ] = loadfxasset( "vfx_mp_wc_leo_nic_character_spawn_cradle" );
    level._effect[ "menendez_summon" ] = loadfxasset( "vfx_mp_wc_leo_nic_menendez_summon_cradle" );
    level._effect[ "blinking_red_light" ] = loadfxasset( "vfx_iw9_level_global_blinking_red_light" );
    level._effect[ "blinking_white_light" ] = loadfxasset( "vfx_core_vehicle_aircraft_light_white_blink_lit" );
    level._effect[ "player_machete_marker" ] = loadfxasset( "vfx_sat_wc_leo_target_killstreak_machete_white" );
    level overlord::function_ddcc4b96977bcf4a( [ "ob/overlord_ob.csv", "ob/overlord_ob_leo.csv" ] );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    register_region_difficulties();
    init_leo_activities();
    level.leo = spawnstruct();
    level thread mp_sat_ob_leo_vo::function_8cf7281eaa34cdc4();
    level thread mp_sat_ob_leo_vo::function_eb8dcfcada984e40();
    level thread leo_minimap();
    level thread mp_sat_ob_leo_util::function_114cdd1a4d524d36();
    level thread mp_sat_ob_leo_util::setup_force_fields();
    thread mp_sat_ob_leo_util::init_butterflies();
    setdvarifuninitialized( @"hash_ca08f59b64628422", "sat_leo_outro" );
    level.default_goalradius = 128;
    level.var_8899b54bb25b4c92 = "white";
    
    if ( ob::nightmare() )
    {
        level.gametypebundle.enableintel = 0;
        setgameprops( %"mp_sat_ob_virgo_nightmare" );
        exploit_clips = getentarray( "nm_exploit_clip", "targetname" );
        
        foreach ( clip in exploit_clips )
        {
            clip.origin += ( 0, 0, 256 );
        }
        
        exploit_models = getentarray( "nm_exploit_model", "targetname" );
        
        foreach ( model in exploit_models )
        {
            model.origin += ( 0, 0, 256 );
        }
        
        return;
    }
    
    exploit_clips = getentarray( "nm_exploit_clip", "targetname" );
    
    foreach ( clip in exploit_clips )
    {
        clip delete();
    }
    
    exploit_models = getentarray( "nm_exploit_model", "targetname" );
    
    foreach ( model in exploit_models )
    {
        model delete();
    }
}

// Namespace mp_sat_ob_leo
// Params 0
// Checksum 0xb2506925, Offset: 0x77e
// Size: 0x61
function init_leo_activities()
{
    callback::add( #"player_spawned", &mp_sat_ob_leo_util::player_setup );
    
    if ( !ob::nightmare() )
    {
        level thread setup_jailbreak();
        ob_leo_startpoint::function_7c9d046e3ec59f53();
        ob_leo_startpoint::function_8efae75b2bbd10f();
    }
    else
    {
        ob_leo_startpoint::function_d64c96fadd5aae1b();
    }
    
    ob_leo_startpoint::init_leo_activity_return();
    level thread ob_gametype_story_mission::function_a535ecaaab8427b7();
    
    /#
        thread function_9d4b3c602ee56afe();
        thread function_8abe061d826dd0f3();
    #/
}

// Namespace mp_sat_ob_leo
// Params 0
// Checksum 0xa16f864a, Offset: 0x7e7
// Size: 0x3f
function setup_jailbreak()
{
    utility::flag_wait( "scriptables_ready" );
    scriptables = getentitylessscriptablearray( "leo_jailbreak", "script_noteworthy" );
    
    if ( scriptables.size > 0 )
    {
        scriptables[ 0 ] jailbreak_machine::init( 0, 1, 1 );
    }
}

// Namespace mp_sat_ob_leo
// Params 0
// Checksum 0x1b8d170f, Offset: 0x82e
// Size: 0x25
function register_region_difficulties()
{
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        level callback::callback( "region_difficulties_registered" );
    }
}

// Namespace mp_sat_ob_leo
// Params 0
// Checksum 0x41f6fab1, Offset: 0x85b
// Size: 0x2a
function leo_minimap()
{
    compass::setupminimap( "compass_map_mp_sat_ob_leo" );
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 15 );
    wait 1;
    compass::init_minimap_triggers();
}

/#

    // Namespace mp_sat_ob_leo
    // Params 0
    // Checksum 0xc48bf6bd, Offset: 0x88d
    // Size: 0x376, Type: dev
    function function_9d4b3c602ee56afe()
    {
        setdevdvarifuninitialized( @"hash_64cde311e2354de6", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_e524988145d4bac3", "<dev string:x24>" );
        var_72b946e7b2453d02 = utility::getstruct( "<dev string:x26>", "<dev string:x46>" );
        var_c6e451950b363145 = utility::getstruct( "<dev string:x51>", "<dev string:x46>" );
        
        if ( !isdefined( var_72b946e7b2453d02 ) )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_64cde311e2354de6" ) == 1 )
            {
                if ( !level utility::flag( "<dev string:x6f>" ) )
                {
                    if ( var_c6e451950b363145 scene::get_state() == "<dev string:x81>" )
                    {
                        var_c6e451950b363145 scene::stop();
                    }
                    
                    utility::stop_exploder( "<dev string:x89>" );
                    level utility::flag_clear( "<dev string:x9f>" );
                    setdvar( @"hash_e524988145d4bac3", 0 );
                    var_72b946e7b2453d02 thread scene::play();
                    level utility::flag_set( "<dev string:x6f>" );
                    waitframe();
                    var_72b946e7b2453d02 scene::stop();
                    level.players[ 0 ] setorigin( ( 3584, 3136, -40968 ) );
                    level.players[ 0 ] setplayerangles( ( 0, 180, 0 ) );
                }
            }
            else if ( getdvarint( @"hash_64cde311e2354de6" ) == 0 )
            {
                if ( level utility::flag( "<dev string:x6f>" ) )
                {
                    if ( var_72b946e7b2453d02 scene::get_state() == "<dev string:x81>" )
                    {
                        var_72b946e7b2453d02 scene::stop();
                    }
                    
                    level utility::flag_clear( "<dev string:x6f>" );
                }
            }
            
            if ( getdvarint( @"hash_e524988145d4bac3" ) == 1 )
            {
                if ( !level utility::flag( "<dev string:x9f>" ) )
                {
                    if ( var_72b946e7b2453d02 scene::get_state() == "<dev string:x81>" )
                    {
                        var_72b946e7b2453d02 scene::stop();
                    }
                    
                    level utility::flag_clear( "<dev string:x6f>" );
                    setdvar( @"hash_64cde311e2354de6", 0 );
                    mp_sat_ob_leo_util::function_7ef23a62d6556750();
                    mp_sat_ob_leo_util::function_b11f02a770404e83( 1, 0.05 );
                    
                    foreach ( struct in level.var_6e37e4867416dc04 )
                    {
                        var_2625efdafde82b32 = getentarray( struct.target, #targetname );
                        
                        foreach ( ent in var_2625efdafde82b32 )
                        {
                            if ( isdefined( ent ) )
                            {
                                ent hide();
                            }
                        }
                    }
                    
                    var_c6e451950b363145 thread scene::play();
                    utility::exploder( "<dev string:x89>" );
                    level utility::flag_set( "<dev string:x9f>" );
                    waitframe();
                    var_c6e451950b363145 scene::stop();
                }
            }
            else if ( getdvarint( @"hash_e524988145d4bac3" ) == 0 )
            {
                if ( level utility::flag( "<dev string:x9f>" ) )
                {
                    if ( var_c6e451950b363145 scene::get_state() == "<dev string:x81>" )
                    {
                        var_c6e451950b363145 scene::stop();
                    }
                    
                    utility::stop_exploder( "<dev string:x89>" );
                    level utility::flag_clear( "<dev string:x9f>" );
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace mp_sat_ob_leo
    // Params 0
    // Checksum 0xeefb2e79, Offset: 0xc0b
    // Size: 0x3e, Type: dev
    function function_8abe061d826dd0f3()
    {
        setdevdvarifuninitialized( @"hash_8654b7e8fa452fff", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_3281ead04b48dd20", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_82fe9148b4aeae78", "<dev string:x24>" );
    }

#/
