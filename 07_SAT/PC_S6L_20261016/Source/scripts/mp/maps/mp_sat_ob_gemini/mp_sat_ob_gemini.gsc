// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini.gsc  (hash_104fbab56f4f1257.gscc) (size: 4455 Bytes / 0x1167 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa224d2ec (2720322284)
// size ...... 4455 (0x1167)
// includes .. 12  (offset: 0xf6b)
// strings ... 31  (offset: 0xfcb)
// dev strs .. 0   (offset: 0x1167)
// exports ... 7   (offset: 0x9a7)
// cseg ...... 0x2d5 + 0x6d2 (0x9a7)
// imports ... 39  (offset: 0xabf)
// animtree1 . 0   (offset: 0x1167)
// animtree2 . 0   (offset: 0x1167)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_audio;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_fx;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_starts;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\ob\jailbreak_machine;
#using scripts\mp\overlord;

#namespace mp_sat_ob_gemini;

// Namespace mp_sat_ob_gemini
// Params 0
// Checksum 0x2dd832d4, Offset: 0x2f3
// Size: 0x3d6
function main()
{
    level.is_quest_story_mission = 1;
    precacheshader( "compass_map_mp_sat_ob_gemini" );
    gemini_fx::function_dde9e9b738e845df();
    gemini_fx::function_a3f16c73525b6655();
    gemini_fx::function_ff29aa5831c0eb02();
    gemini_fx::function_3d68a0450cab12f3();
    gemini_audio::main();
    load::main();
    register_region_difficulties();
    level overlord::function_ddcc4b96977bcf4a( [ "ob/overlord_ob.csv", "ob/overlord_ob_gemini.csv" ] );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvar( @"hash_a5bc4354be7c0fe7", 0 );
    setdvarifuninitialized( @"hash_ca08f59b64628422", "sat_gemini_outro" );
    setdvar( @"hash_e9f70197071b36c9", 1 );
    setdvar( @"bg_compassshowenemies", 1 );
    init_gemini_activities();
    level thread set_minimap();
    
    if ( ob::nightmare() )
    {
        setgameprops( "mp_sat_ob_virgo_nightmare" );
        level.gametypebundle.enableintel = 0;
        level.vehiclespawndisabled = 1;
        nm_prison_front_doors = getentarray( "nm_prison_front_doors", "targetname" );
        
        foreach ( door in nm_prison_front_doors )
        {
            door delete();
        }
        
        m_oscar_ufo = getent( "m_oscar_ufo", "targetname" );
        
        if ( isdefined( m_oscar_ufo ) )
        {
            m_oscar_ufo hide();
        }
        
        return;
    }
    
    level thread gemini_util::function_539f246069fd0fa( "nm_prison_shield" );
    nm_cafeteria_blockers = getentarray( "nm_cafeteria_blockers", "targetname" );
    
    foreach ( blocker in nm_cafeteria_blockers )
    {
        if ( isdefined( blocker ) )
        {
            blocker delete();
        }
    }
    
    nm_cafeteria_blocker_clips = getentarray( "nm_cafeteria_blocker_clips", "targetname" );
    
    foreach ( clip in nm_cafeteria_blocker_clips )
    {
        if ( isdefined( clip ) )
        {
            clip delete();
        }
    }
    
    nm_cafe_flare_model = getentarray( "nm_cafe_flare_model", "targetname" );
    
    foreach ( m_flare in nm_cafe_flare_model )
    {
        if ( isdefined( m_flare ) )
        {
            m_flare delete();
        }
    }
    
    thread function_e9890a9628059522();
    m_oscar_ufo = getent( "m_oscar_ufo", "targetname" );
    
    if ( isdefined( m_oscar_ufo ) )
    {
        m_oscar_ufo delete();
    }
}

// Namespace mp_sat_ob_gemini
// Params 0
// Checksum 0xcb09e42e, Offset: 0x6d1
// Size: 0x25
function register_region_difficulties()
{
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        level callback::callback( "region_difficulties_registered" );
    }
}

// Namespace mp_sat_ob_gemini
// Params 0
// Checksum 0x962cfc62, Offset: 0x6fe
// Size: 0x2a
function set_minimap()
{
    compass::setupminimap( "compass_map_mp_sat_ob_gemini" );
    level utility::flag_wait_or_timeout( "story_mission_party_check_complete", 15 );
    wait 1;
    compass::init_minimap_triggers();
}

// Namespace mp_sat_ob_gemini
// Params 0
// Checksum 0x19c84512, Offset: 0x730
// Size: 0x57
function init_gemini_activities()
{
    if ( !ob::nightmare() )
    {
        callback::add( #"player_spawned", &gemini_util::player_setup );
        level thread setup_jailbreak();
        ob_gemini_startpoint::function_3e73da858166a840();
        ob_gemini_startpoint::function_c4b14cf6527efb77();
        ob_gemini_startpoint::function_e49a3335192f8ba2();
    }
    else
    {
        ob_gemini_startpoint::init_gemini_nm();
    }
    
    ob_gemini_startpoint::function_9f3cf62b9569d0d8();
    level thread ob_gametype_story_mission::function_a535ecaaab8427b7();
}

// Namespace mp_sat_ob_gemini
// Params 0
// Checksum 0x3f711177, Offset: 0x78f
// Size: 0x43
function setup_jailbreak()
{
    utility::flag_wait( "scriptables_ready" );
    scriptables = getentitylessscriptablearray( "gemini_jailbreak", #script_noteworthy );
    
    if ( scriptables.size > 0 )
    {
        scriptables[ 0 ] jailbreak_machine::init( 0, 3, 1 );
    }
}

// Namespace mp_sat_ob_gemini
// Params 0
// Checksum 0xc97f2857, Offset: 0x7da
// Size: 0x1cd
function function_e9890a9628059522()
{
    bm_nm_cafe_cell = getent( "bm_nm_cafe_cell", "targetname" );
    
    if ( isdefined( bm_nm_cafe_cell ) )
    {
        bm_nm_cafe_cell delete();
    }
    
    clips = getentarray( "nm_container_glass_clips", "script_noteworthy" );
    
    if ( isdefined( clips ) )
    {
        foreach ( item in clips )
        {
            item connectpaths();
        }
    }
    
    var_e0c6e35a01fb3d9f = getentarray( "nm_tube_main", "targetname" );
    
    if ( isdefined( var_e0c6e35a01fb3d9f ) )
    {
        foreach ( ent in var_e0c6e35a01fb3d9f )
        {
            ent delete();
        }
    }
    
    mine_walls = getentarray( "cradle_wall_mines", "targetname" );
    
    if ( isdefined( mine_walls ) )
    {
        foreach ( wall in mine_walls )
        {
            wall delete();
        }
    }
}

