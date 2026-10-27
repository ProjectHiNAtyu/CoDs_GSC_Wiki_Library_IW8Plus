// scripts\mp\ob\activities\ob_activity_sagittarius.gsc  (hash_2df0ae34927176ae.gscc) (size: 54949 Bytes / 0xd6a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x823a5287 (2184860295)
// size ...... 54949 (0xd6a5)
// includes .. 45  (offset: 0xc7a1)
// strings ... 219 (offset: 0xc909)
// dev strs .. 47  (offset: 0xd451)
// exports ... 102 (offset: 0x8c7d)
// cseg ...... 0x1527 + 0x7756 (0x8c7d)
// imports ... 351 (offset: 0x9c6d)
// animtree1 . 0   (offset: 0xd6a5)
// animtree2 . 0   (offset: 0xd6a5)
#using script_2399696a9d953451;
#using script_30152080457bb762;
#using script_3edd59d0d3fc3262;
#using script_61b40095fd0502f0;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\objective_marker_bundle_helper;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_utility;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\supers\combat_hologram;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_merc_camp;
#using scripts\mp\ob\activities\ob_activity_sagittarius_sniper_boss;
#using scripts\mp\ob\activities\ob_activity_sagittarius_vo;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_exfil_trans;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\snd\snd_ob;

#namespace ob_activity_sagittarius;

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x5
// Checksum 0x1b93f5bf, Offset: 0x1545
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_d72cf2a56e2971d1", undefined, &sagittarius_init, undefined );
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0xe7647c07, Offset: 0x1566
// Size: 0x12c
function private sagittarius_init()
{
    level._effect[ "sag_boss_sniper_laser" ] = loadfxasset( "vfx_sat_ob_sag_prya_red_laser_beam" );
    level._effect[ "sag_boss_sniper_trail" ] = loadfxasset( "vfx_sat_ob_sag_prya_tracer_largebolt_w" );
    level._effect[ "sag_boss_sniper_glint" ] = loadfxasset( "vfx_sat_sag_boss_sniper_glint" );
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_de02dc15c4554e0e", 0 ) )
    {
        return;
    }
    
    level.var_2d8511c2818cdd93 = [];
    level.var_9ff6ee3074298a7 = [];
    
    if ( !isdefined( level.sag_killstreak_map ) )
    {
        level.sag_killstreak_map = [];
    }
    
    level callback::add( #"hash_cc06eb1d45f33a0c", &onplayerjoinsquad );
    level callback::add( #"player_disconnect", &function_7d01d9bdc1a809c5 );
    level callback::add( #"player_leave_squad", &function_7d01d9bdc1a809c5 );
    level.var_7244c9b844ee8842 = [];
    utility::registersharedfunc( #"ob_loot", #"hash_b5deae02f491843f", &ob_story_mission_utils::function_97fcb77435f4ba9b, 1 );
    thread function_b358163be4dcc93b();
    thread function_abbe6eab99c995d1();
    thread init_respawn_points();
}

// Namespace ob_activity_sagittarius
// Params 0
// Checksum 0xe63ca37c, Offset: 0x169a
// Size: 0xfa
function init_respawn_points()
{
    level endon( #"game_ended" );
    utility::flag_wait( "sag_cs_init_complete" );
    array_t = [ "respawn_points_van", "respawn_points_art_warehouse", "respawn_points_heliport", "respawn_points_restricted", "respawn_points_electric", "respawn_points_ruins", "respawn_points_ruins_2", "respawn_points_stronghold" ];
    level.var_6209aa2f9c5149e4 = [];
    
    foreach ( t in array_t )
    {
        level.var_6209aa2f9c5149e4[ t ] = utility::getstructarray( t, "targetname" );
    }
}

// Namespace ob_activity_sagittarius
// Params 3
// Checksum 0xcd086c31, Offset: 0x179c
// Size: 0x1ab
function set_current_respawn_point( var_cd7e11dc688992d4, var_308733e8f18f6ecf, var_62e46f7d044c1a4f )
{
    if ( isdefined( var_308733e8f18f6ecf ) )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( var_308733e8f18f6ecf ), var_62e46f7d044c1a4f );
        return;
    }
    
    respawnpoints = "";
    
    switch ( var_cd7e11dc688992d4.var_ee4dff6c24f787f8 )
    {
        case 0:
            if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 0 )
            {
                respawnpoints = "art_warehouse";
                var_62e46f7d044c1a4f = 0.35;
            }
            else if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 1 )
            {
                respawnpoints = "heliport";
                var_62e46f7d044c1a4f = 0.6;
            }
            
            break;
        case 1:
            if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 0 )
            {
                respawnpoints = "restricted";
                var_62e46f7d044c1a4f = 0.35;
            }
            else if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 1 )
            {
                respawnpoints = "electric";
                var_62e46f7d044c1a4f = 0.6;
            }
            
            break;
        case 2:
            if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 0 )
            {
                respawnpoints = "ruins";
                var_62e46f7d044c1a4f = 0.35;
            }
            else if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 1 )
            {
                respawnpoints = "ruins_2";
                var_62e46f7d044c1a4f = 0.6;
            }
            
            break;
    }
    
    if ( respawnpoints != "" )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( respawnpoints ), var_62e46f7d044c1a4f );
    }
}

// Namespace ob_activity_sagittarius
// Params 1
// Checksum 0x14d97fab, Offset: 0x194f
// Size: 0x2b
function get_respawn_points( targetname )
{
    prefix = "respawn_points_";
    return level.var_6209aa2f9c5149e4[ prefix + targetname ];
}

// Namespace ob_activity_sagittarius
// Params 0
// Checksum 0x5e1a3e28, Offset: 0x1983
// Size: 0x42
function function_b358163be4dcc93b()
{
    for ( structs = utility::getstructarray( "boss_teleport_art_warehouse" ); !structs.size ; structs = utility::getstructarray( "boss_teleport_art_warehouse" ) )
    {
        wait 0.5;
    }
    
    utility::flag_set( "sag_cs_init_complete" );
}

// Namespace ob_activity_sagittarius
// Params 0
// Checksum 0xfa1133d4, Offset: 0x19cd
// Size: 0x28f
function function_abbe6eab99c995d1()
{
    utility::flag_wait( "sag_cs_init_complete" );
    function_e495dd127d00b297( [ "boss_teleport_art_warehouse", "boss_teleport_heliport" ] );
    
    if ( getdvarint( @"hash_eda1a22d0e17ac1a", 1 ) > 0 )
    {
        function_e495dd127d00b297( [ "boss_teleport_restricted_area", "boss_teleport_electric_area" ] );
        function_e495dd127d00b297( [ "boss_teleport_strongholdhill", "boss_teleport_strongholdhill_2" ] );
    }
    
    thread spawnScriptables();
    
    /#
        gui_info = [ [ "<dev string:x24>", &function_518eee3bd007cea9 ], [ "<dev string:x37>", &function_462e71b64ad07c87 ] ];
        
        for ( var_719b80983f19b2f5 = 0; var_719b80983f19b2f5 < gui_info.size ; var_719b80983f19b2f5++ )
        {
            devgui::function_9082edeb5db93280( "<dev string:x4a>" + gui_info[ var_719b80983f19b2f5 ][ 0 ] + "<dev string:x5a>" );
            
            foreach ( area_index, var_650330e1a99e0dee in level.var_326b134b5d097db8 )
            {
                for ( index = 0; index < var_650330e1a99e0dee.debug_targetnames.size ; index++ )
                {
                    params = var_719b80983f19b2f5 + "<dev string:x5c>" + area_index + "<dev string:x6b>" + index;
                    devgui::function_cd4e263c1f3018ae( var_650330e1a99e0dee.debug_targetnames[ index ] + "<dev string:x6d>" + "<dev string:x6f>", params + "<dev string:x6b>" + 1, gui_info[ var_719b80983f19b2f5 ][ 1 ], 0 );
                    devgui::function_cd4e263c1f3018ae( var_650330e1a99e0dee.debug_targetnames[ index ] + "<dev string:x6d>" + "<dev string:x79>", params + "<dev string:x6b>" + 0, gui_info[ var_719b80983f19b2f5 ][ 1 ], 0 );
                }
            }
            
            devgui::function_77df7fe7dd273e10();
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x85>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xae>", "<dev string:xb7>", &function_d160b153b5d87983, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc5>", "<dev string:xca>", &function_d160b153b5d87983, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd6>", "<dev string:xda>", &function_d160b153b5d87983, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe5>", "<dev string:xe9>", &function_d160b153b5d87983, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf4>", "<dev string:xfa>", &function_d160b153b5d87983, 1 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace ob_activity_sagittarius
// Params 1
// Checksum 0x295bc347, Offset: 0x1c64
// Size: 0x3a
function function_d160b153b5d87983( params )
{
    if ( !isdefined( level.var_777b5ed7edd75e81 ) )
    {
        level.var_777b5ed7edd75e81 = [];
    }
    
    level.var_777b5ed7edd75e81[ level.var_777b5ed7edd75e81.size ] = params[ 0 ];
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0xa8fb23da, Offset: 0x1ca6
// Size: 0xf2
function private function_e495dd127d00b297( teleport_locations )
{
    if ( !isdefined( level.var_326b134b5d097db8 ) )
    {
        level.var_326b134b5d097db8 = [];
    }
    
    new_location = spawnstruct();
    new_location.var_e26932b14b792eb3 = 0;
    new_location.var_5b37ae8285315e61 = [];
    
    /#
        new_location.debug_targetnames = teleport_locations;
    #/
    
    foreach ( index, location in teleport_locations )
    {
        new_location.var_5b37ae8285315e61[ index ] = utility::getstructarray( location );
    }
    
    level.var_326b134b5d097db8[ level.var_326b134b5d097db8.size ] = new_location;
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x2950e3de, Offset: 0x1da0
// Size: 0x29
function private sag_setup_cover()
{
    if ( !isdefined( var_a2f06d79347ba577 ) )
    {
        var_a2f06d79347ba577 = [];
    }
    
    var_a2f06d79347ba577 = ob_soldier_util::function_a315cc5d1dee425a( "e_cover_sag" );
    waitframe();
    function_5da3abd6d959353d();
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x783812e7, Offset: 0x1dd1
// Size: 0xe
function private function_5da3abd6d959353d()
{
    ob_activity_utility::ob_enable_cover_nodes( "e_covernode_sag" );
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x31a49097, Offset: 0x1de7
// Size: 0x28
function private sag_setup_turrets()
{
    a_turret_structs = utility::getstructarray( "s_sag_turret", "targetname" );
    level thread ob_soldier_util::function_fc6e58e10547459b( a_turret_structs );
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x74110755, Offset: 0x1e17
// Size: 0xc6
function private function_6548903e8b873802()
{
    var_91e77627e4a7d6b4 = utility::getstructarray( "s_sag_mine", "targetname" );
    
    if ( var_91e77627e4a7d6b4 )
    {
        foreach ( mine_struct in var_91e77627e4a7d6b4 )
        {
            trap_owner = ob_activity_utility::function_d12ca4c58fe5faf0();
            mine = ob_soldier_util::ob_mine_spawn( mine_struct.origin, undefined, trap_owner, undefined, mine_struct.angles, 1 );
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0xa7fe579, Offset: 0x1ee5
// Size: 0xb9
function private function_fcbe8a08b77fb506()
{
    structs = utility::getstructarray( "sag_objective_location", "targetname" );
    
    foreach ( struct in structs )
    {
        radius = struct.radius ?? 1000;
        function_1c4c7ef874191be2( "sag_objective_location", struct.origin, radius, 1 );
    }
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x63cba2e4, Offset: 0x1fa6
// Size: 0xfa
function private function_d6792934196f53d8()
{
    var_c71ee435a07462be = utility::getstructarray( "s_sag_ammocrate", "targetname" );
    
    if ( var_c71ee435a07462be )
    {
        foreach ( ammocrate_struct in var_c71ee435a07462be )
        {
            ammocrate = spawnscriptable( "military_ammo_restock_story", ammocrate_struct.origin, ammocrate_struct.angles );
            ammocrate setscriptablepartstate( "military_ammo_restock_story", "useable_on" );
        }
        
        ammocrate = spawnscriptable( "military_ammo_restock_story", ( 11935.7, -28961.5, 4051.94 ), ( 0, -55, 0 ) );
        ammocrate setscriptablepartstate( "military_ammo_restock_story", "useable_on" );
    }
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x46553af7, Offset: 0x20a8
// Size: 0x23a
function private spawnScriptables()
{
    utility::flag_wait( "scriptables_ready" );
    var_31fca1348e82e1a2 = function_d567da5e22061f91();
    interact_angle = get_sag_intro_spawn_angles();
    level.var_bca2cec52d03f8c6 = ob_story_mission_utils::init_objective_interaction( var_31fca1348e82e1a2, %"nexus_activity_joiner_sagittarius_intro", &function_c127e2c7333fb19a, #"sat_ob_sagittarius_intro", interact_angle );
    rfid_struct = utility::getstruct( "sag_rfid_reader" );
    
    if ( rfid_struct )
    {
        level.sag_rfid_reader = spawnscriptable( "ob_activity_sagittarius_step_4_2_interact", rfid_struct.origin, rfid_struct.angles );
        level.sag_rfid_reader disableplayeruseforallplayers();
    }
    
    level.van_radio = spawnscriptable( "ob_activity_guild_radio_audio", ( 30259, 1165, 597 ) );
    
    for ( index = 0; index < 5 ; index++ )
    {
        var_500f9cd57c86328e = getentitylessscriptablearray( "sag_servers_0" + index + 1, #targetname );
        
        if ( var_500f9cd57c86328e )
        {
            function_53664df9d6e891c4( var_500f9cd57c86328e, "base" );
        }
    }
    
    function_9d9ca4a498bd9b64();
    killstreak_structs = utility::getstructarray( "sag_killstreak", "targetname" );
    
    foreach ( killstreak in killstreak_structs )
    {
        if ( killstreak && killstreak.script_noteworthy )
        {
            killstreakorigin = killstreak.origin;
            var_8a249bc41ff35167 = killstreakorigin[ 0 ] + "_" + killstreakorigin[ 1 ] + "_" + killstreakorigin[ 2 ];
            
            if ( level.sag_killstreak_map[ var_8a249bc41ff35167 ] )
            {
                continue;
            }
            
            level.sag_killstreak_map[ var_8a249bc41ff35167 ] = 1;
            var_b305a8b22e6f6929 = "obloot_killstreak_" + killstreak.script_noteworthy;
            spawnscriptable( var_b305a8b22e6f6929, killstreakorigin, killstreak.angles );
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0xe8d56e0b, Offset: 0x22ea
// Size: 0x192
function private function_62f9c8759de7ae19( var_cd7e11dc688992d4 )
{
    if ( !level.var_4e5b26fefe68335e )
    {
        level.var_4e5b26fefe68335e = spawnstruct();
        var_26ad585bf3f8d930 = getscriptbundle( %"hash_111848346800e99d" );
        var_d5dea03251ea138b = utility::getstructarray( "s_sag_drone" );
        
        foreach ( drone_struct in var_d5dea03251ea138b )
        {
            drone_difficulty_region = region_difficulty_manager::get_region_difficulty( drone_struct.origin );
            spawn_options = { #allow_visited:1, #respawn_on_death:1, #spawn_angles:drone_struct.angles, #difficulty_region:drone_difficulty_region, #var_2858c1d9ffae3f84:var_26ad585bf3f8d930.var_2858c1d9ffae3f84, #goal:#"hash_6573e43fb6b70d11", #canlootdrop:0, #canmove:1, #spawnpos:drone_struct.origin, #enableaimassist:1, #candamage:1 };
            level.var_4e5b26fefe68335e spawn_drone( var_cd7e11dc688992d4, 0, 1, spawn_options );
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0xa41225b0, Offset: 0x2484
// Size: 0xf
function private get_sag_intro_spawn_angles()
{
    return ( 0, -90, 0 );
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0xb69138c1, Offset: 0x249c
// Size: 0xf
function private function_d567da5e22061f91()
{
    return ( 2516, -19589, 920 );
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x4434ed73, Offset: 0x24b4
// Size: 0x228
function private onplayerjoinsquad( params )
{
    player = self;
    
    /#
        if ( getdvarint( @"hash_5436d5235eac4401", 0 ) )
        {
            thread function_d8fee8117384959a( player );
        }
    #/
    
    sag_mission_struct = level.var_2d8511c2818cdd93[ player.sessionsquadid ];
    
    if ( !isdefined( sag_mission_struct ) || sag_mission_struct.resetting )
    {
        sag_mission_struct = { #stronghold_locked_doors:[], #var_7080aee967898ed4:0, #var_2daa3ace3eeb3032:undefined, #var_ee4dff6c24f787f8:undefined, #sessionsquadid:player.sessionsquadid, #team:player.team, #squad_leader:player };
        level.var_2d8511c2818cdd93[ player.sessionsquadid ] = sag_mission_struct;
        thread sagittarius_start( sag_mission_struct );
        thread function_4d218f5d7a697d97( sag_mission_struct, player.sessionsquadid );
    }
    
    foreach ( abilitycase in level.var_dd19ba25ac528b3c )
    {
        ob_item_select::function_a499824164a33b4f( abilitycase, [ player ] );
    }
    
    thread function_d851c0825968ae38( sag_mission_struct, player );
    player endon( #"disconnect" );
    
    while ( getbuildversion() != "SHIP" )
    {
        player waittill( #"hash_1b6b9613636daa6a" );
        sag_mission_struct notify( #"squad_left_match" );
        waitframe();
        logstring( "[Sagittarius] Restarting for squad ", player.sessionsquadid, " since progress was reset for ", player.name );
        
        if ( player == ( squad_utility::getsquadleader( sag_mission_struct.team, sag_mission_struct.sessionsquadid ) ?? player ) )
        {
            thread sagittarius_start( sag_mission_struct );
            thread function_4d218f5d7a697d97( sag_mission_struct, player.sessionsquadid );
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x232946e0, Offset: 0x26e4
// Size: 0xe2
function private function_b3daf3fd0739bc90( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 waittill( #"sag_give_loadout", index );
    var_cd7e11dc688992d4.loadoutindex = index;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        function_d626cc76cae468c1( player, index );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x1d6b9447, Offset: 0x27ce
// Size: 0x57
function private function_d626cc76cae468c1( player, index )
{
    player ob_story_mission_utils::function_3b9c5aa009cba304( "classtable_sat_ob_sagittarius", index, 1 );
    
    if ( !player.var_cebe8b1aded0bdea )
    {
        player function_619f2b974e6c604a( 300 );
        thread onplayerrespawn( player );
        player.var_cebe8b1aded0bdea = 1;
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x7f911856, Offset: 0x282d
// Size: 0x2e
function private function_acc9ecf6cb4bb9a6( loadoutindex )
{
    self endon( #"disconnect" );
    utility::ent_flag_wait( "squad_play_begin" );
    function_d626cc76cae468c1( self, loadoutindex );
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0xa2ac97e3, Offset: 0x2863
// Size: 0x45
function private onplayerrespawn( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"spawned" );
        player function_619f2b974e6c604a( 300 );
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x606bcaaa, Offset: 0x28b0
// Size: 0x184
function private function_7d01d9bdc1a809c5( params )
{
    player = self;
    var_cd7e11dc688992d4 = level.var_2d8511c2818cdd93[ player.sessionsquadid ];
    is_squad_leader = var_cd7e11dc688992d4.squad_leader == player;
    session_id = player.sessionsquadid;
    player_team = player.team;
    
    if ( var_cd7e11dc688992d4 )
    {
        foreach ( callback in var_cd7e11dc688992d4.remove_player_callbacks )
        {
            profilestart();
            [[ callback ]]( player, var_cd7e11dc688992d4 );
            profilestop();
        }
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( player_team, session_id );
    
    if ( !isdefined( var_64bb57aa2d6e8b35 ) )
    {
        level.var_7244c9b844ee8842[ session_id ] = undefined;
    }
    
    waitframe();
    
    if ( var_cd7e11dc688992d4 && is_squad_leader )
    {
        new_squad_leader = squad_utility::getsquadleader( player_team, session_id );
        
        if ( new_squad_leader )
        {
            var_cd7e11dc688992d4.squad_leader = new_squad_leader;
            return;
        }
        
        logstring( "[Sagittarius] Resetting for squad ", session_id, " since all players left the match." );
        function_eee59895c53d92a0( var_cd7e11dc688992d4 );
        var_cd7e11dc688992d4 notify( #"squad_left_match" );
        function_216f10c03bf30fc9( var_cd7e11dc688992d4, session_id );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xcb057df4, Offset: 0x2a3c
// Size: 0x3a
function private function_4d218f5d7a697d97( var_cd7e11dc688992d4, sessionsquadid )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 waittill( #"completed" );
    function_216f10c03bf30fc9( var_cd7e11dc688992d4, sessionsquadid );
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xdc9167bf, Offset: 0x2a7e
// Size: 0x19d
function private function_216f10c03bf30fc9( var_cd7e11dc688992d4, sessionsquadid )
{
    function_e2116fc30acb3d6f( var_cd7e11dc688992d4 );
    
    if ( var_cd7e11dc688992d4.var_e7665325aece18e8 )
    {
        function_53664df9d6e891c4( var_cd7e11dc688992d4.var_e7665325aece18e8, "base" );
        var_cd7e11dc688992d4.var_e7665325aece18e8 = undefined;
    }
    
    foreach ( circle in var_cd7e11dc688992d4.circle_objectives )
    {
        circle delete();
    }
    
    foreach ( interact in var_cd7e11dc688992d4.interacts )
    {
        interact delete();
    }
    
    if ( var_cd7e11dc688992d4.uplinkprops.trigger )
    {
        var_cd7e11dc688992d4.uplinkprops.trigger delete();
    }
    
    var_cd7e11dc688992d4 ob_story_mission_utils::mission_objective_marker_clear();
    level.var_2d8511c2818cdd93[ sessionsquadid ] = undefined;
    level.var_9ff6ee3074298a7 = arrayremove( level.var_9ff6ee3074298a7, sessionsquadid );
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x32e7c4d8, Offset: 0x2c23
// Size: 0xcf
function private sagittarius_start( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    function_a25acb62ddab20e2( "sag_encounter", 1 );
    sag_setup_cover();
    sag_setup_turrets();
    function_6548903e8b873802();
    function_fcbe8a08b77fb506();
    function_d6792934196f53d8();
    function_62f9c8759de7ae19( var_cd7e11dc688992d4 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    var_64bb57aa2d6e8b35 childthread sagittarius_music( var_cd7e11dc688992d4 );
    childthread function_b3daf3fd0739bc90( var_cd7e11dc688992d4 );
    childthread sagittarius_intro( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    childthread sagittarius_mini_boss( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    childthread sagittarius_stronghold( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    childthread function_e375dee6bcab318e( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x70aab77b, Offset: 0x2cfa
// Size: 0x2aa
function private function_d7be3a8633d69a3b( var_cd7e11dc688992d4 )
{
    level endon( #"game_ended" );
    var_fd1181cb41f2b250 = [ "MERC_CAMP_Q4_HELIPORT_01", "MERC_CAMP_Q4_EPIC_BRIDGE", "MERC_CAMP_Q4_FLATS_01", "ROADSIDE_ASSISTANCE_heliport_west_01", "ROADSIDE_ASSISTANCE_antenna_north_01" ];
    utility::flag_wait( "activity_nexus_init_complete" );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "mission_activated" );
    activity_instances = activity_common::function_394486cf35d84dc8();
    
    foreach ( instance in activity_instances )
    {
        if ( !instance )
        {
            continue;
        }
        
        instance.var_e2fbbbbf65e236fe = 1;
        variant_tag = instance.varianttag;
        
        if ( arraycontains( var_fd1181cb41f2b250, variant_tag ) )
        {
            var_ea54c0ab42a167ca = activity_instance_common::function_776ee11e7acc64a5( instance );
            nearby_players = getplayersinradius( var_ea54c0ab42a167ca, 5000 );
            
            if ( nearby_players.size > 0 )
            {
                var_fd1181cb41f2b250 = arrayremove( var_fd1181cb41f2b250, variant_tag );
                continue;
            }
            
            instance.var_92ac5b0ebd14fc08 = 100;
            activity_state = instance.state;
            
            switch ( activity_state )
            {
                case #"hash_52776813dae194d3":
                    activity_instance_common::function_852865f5a195559f( instance );
                case #"hash_d9fe739ef1ff5d6f":
                    var_fd1181cb41f2b250 = arrayremove( var_fd1181cb41f2b250, variant_tag );
                    function_e5e240f74adf7d03( instance );
                    break;
                default:
                    activity_instance_common::function_9aeeabe50fc9cc3e( instance );
                    break;
            }
        }
    }
    
    waitframe();
    
    foreach ( variant in var_fd1181cb41f2b250 )
    {
        activity_definition = activity_definition_utils::getactivitydefinition( variant );
        
        if ( isdefined( activity_definition ) )
        {
            custom_properties = activity_definition_utils::function_9129cd8075c85c09( activity_definition );
            activity_type = custom_properties.activitytype;
            new_instance = ob_activity_utility::function_fe0fd74238abb635( activity_type, variant, "Activity" );
            
            if ( new_instance )
            {
                new_instance.var_e2fbbbbf65e236fe = 1;
                new_instance.var_92ac5b0ebd14fc08 = 100;
            }
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x9b4ec65b, Offset: 0x2fac
// Size: 0x64
function private function_e5e240f74adf7d03( activity_instance )
{
    activity_definition = activity_definition_utils::getactivitydefinition( activity_instance.varianttag );
    custom_properties = activity_definition_utils::function_9129cd8075c85c09( activity_definition );
    activity_type = custom_properties.activitytype;
    
    if ( activity_type == "REV_OB_MERC_CAMP" )
    {
        activity_instance thread ob_activity_merc_camp::function_6092d36d6b04c071();
    }
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0xfe1e2443, Offset: 0x3018
// Size: 0x26c
function private function_9d9ca4a498bd9b64()
{
    ability_case_data = [ [ "minor_ability_case_aqueduct", "super_mega_jump", undefined, #"tactical" ], [ "minor_ability_case_warehouse", "super_mega_jump", "super_grappling_hook_sm", #"tactical" ], [ "minor_ability_case_police", "super_mega_jump", "super_grappling_hook_sm", #"tactical" ], [ "major_ability_case_bunker", "super_vision_pulse", "super_survival_life_drain", #"default" ] ];
    level.var_dd19ba25ac528b3c = [];
    
    foreach ( data in ability_case_data )
    {
        spawn_struct_targetname = data[ 0 ];
        var_465fe7c1010084da = data[ 1 ];
        var_465fe6c1010082a7 = data[ 2 ];
        slot = data[ 3 ];
        struct = utility::getstruct( spawn_struct_targetname, "targetname" );
        
        if ( struct )
        {
            ability_case = ob_item_select::function_95f9ecc2af4693f6( struct.origin, var_465fe7c1010084da, var_465fe6c1010082a7, slot, struct.angles );
            ob_item_select::function_1dfd8b3bc8e33dd8( ability_case );
            level.var_dd19ba25ac528b3c[ level.var_dd19ba25ac528b3c.size ] = ability_case;
        }
    }
    
    var_23a67658150da977 = [ "sag_aqueduct_supply", "sag_bunker_supply_1", "sag_bunker_supply_2", "sag_boss_supply" ];
    
    foreach ( targetname in var_23a67658150da977 )
    {
        story_contract_util::function_e6799e9a19df2365( targetname );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xa602d160, Offset: 0x328c
// Size: 0x1d2
function private sagittarius_intro( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    level.van_radio setscriptablepartstate( "Radio", "on" );
    childthread function_f5ac4f96ca33b9b8( var_cd7e11dc688992d4 );
    var_cd7e11dc688992d4 story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"sag_intro" );
    var_cd7e11dc688992d4 notify( #"sag_give_loadout", 0 );
    logstring( "[Sagittarius] started for squad: " + var_cd7e11dc688992d4.sessionsquadid );
    var_cd7e11dc688992d4 utility::ent_flag_set( "mission_activated" );
    level.var_7244c9b844ee8842[ var_cd7e11dc688992d4.sessionsquadid ] = 1;
    level childthread function_d7be3a8633d69a3b( var_cd7e11dc688992d4 );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    level thread function_cddb50034003950e( var_cd7e11dc688992d4 );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_sag_intro_flyby", { #fadestarthold:3, #timeout:26, #countdown:0, #squad:var_64bb57aa2d6e8b35 } );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_sag_territory_load", { #fadeendhold:3, #timeout:47, #fadestartnone:1, #countdown:0, #squad:var_64bb57aa2d6e8b35 } );
    var_cd7e11dc688992d4 notify( #"sagittarius_intro_bink_complete" );
    childthread function_cdfe39187377b8f3( var_cd7e11dc688992d4 );
    utility::flag_wait( "ob_infil_completed" );
    var_cd7e11dc688992d4.squad_leader chyron::function_a6d314bf326b0e52( "sag_intro" );
    overlord::playconversation( "completed_the_scan_comms", var_64bb57aa2d6e8b35.players, 3 );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"sag_intro" );
    
    /#
        iprintlnbold( "<dev string:x107>" );
    #/
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x53db8e4b, Offset: 0x3466
// Size: 0x167
function private function_f5ac4f96ca33b9b8( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 notify( #"hash_710ef62fa3034b91" );
    var_cd7e11dc688992d4 endon( #"hash_710ef62fa3034b91" );
    radio_chatter = [ [ "dx_wc_wsag_sspe_guig_howfarwestaretheysea", 5 ], [ "dx_wc_wsag_sspe_gui6_stadiumithinklittlep", 5 ], [ "dx_wc_wsag_sspe_guig_howfareast", 5 ], [ "dx_wc_wsag_sspe_gui6_almosttothecolosseum", 5 ], [ "dx_wc_wsag_sspe_guig_almostiaskedyourcrew", 5 ], [ "dx_wc_wsag_sspe_gui6_weturnedeverystonetw", 5 ], [ "dx_wc_wsag_sspe_guig_notheyregettingintel", 10 ] ];
    
    for ( index = 0; index < radio_chatter.size ; index++ )
    {
        sound_alias = radio_chatter[ index ][ 0 ];
        var_d39c92eb5ec4af0c = radio_chatter[ index ][ 1 ];
        sound_time = lookupsoundlength( sound_alias ) / 1000;
        radio_chatter[ index ][ 1 ] = sound_time + var_d39c92eb5ec4af0c;
    }
    
    while ( radio_chatter.size > 0 )
    {
        for ( index = 0; index < radio_chatter.size ; index++ )
        {
            sound_alias = radio_chatter[ index ][ 0 ];
            wait_time = radio_chatter[ index ][ 1 ];
            snd::play( sound_alias, ( 30259, 1165, 597 ) );
            wait wait_time;
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x26ea664, Offset: 0x35d5
// Size: 0x5da
function private sagittarius_mini_boss( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    var_cd7e11dc688992d4 story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"sag_mini_boss" );
    var_cd7e11dc688992d4 notify( #"sag_give_loadout", 0 );
    
    if ( getdvarint( @"hash_377c5b80178d41f1", 0 ) < 1 )
    {
        function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_839eefce8262622", var_64bb57aa2d6e8b35.players );
        van_origin = ( 30259, 1165, 597 );
        circle_objective = function_123f3470d175c518( var_cd7e11dc688992d4, van_origin, 2200, 1 );
        childthread function_ea8bd1192690d3e4( circle_objective, van_origin, 2200, 2, var_64bb57aa2d6e8b35 );
        childthread function_2a6ba541e258c5( var_cd7e11dc688992d4, getgroundposition( circle_objective.origin, 32, 9999 ), 2200, "investigation_waypoint_reached", "sagittarius_van_circle" );
        var_cd7e11dc688992d4 utility::ent_flag_wait( "investigation_waypoint_reached" );
        thread overlord::playconversation( "radio_signal_acquired", var_64bb57aa2d6e8b35.players, undefined, 0 );
        circle_objective utility::ent_flag_wait( "circle_objective_shrinking_completed" );
        circle_objective delete();
        function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_6790ebea0334544c", var_64bb57aa2d6e8b35.players );
        childthread namespace_bbbb94f0356653a2::function_f19b17747f2036c4( [ "nag_check_van" ], 25, 45, "mini_van_checked", var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
        interact = function_d7b144a0cdbd7cba( var_cd7e11dc688992d4, ( 30281, 1149, 604 ), undefined, "duration_short", undefined, "sagittarius_van_handle", undefined, &"sat_ob_activities/contract_sag_find_mini_van_title" );
        interact waittill( #"valid_use", player );
        var_cd7e11dc688992d4 notify( #"mini_van_checked" );
        var_726e61c62699d639 = "van_regroup_" + var_cd7e11dc688992d4.sessionsquadid;
        var_673fca035832e068 = "boss_cinematic_completed_" + var_cd7e11dc688992d4.sessionsquadid;
        teleport_structs = utility::getstructarray( "sag_boss_intro_teleport", "script_noteworthy" );
        var_64bb57aa2d6e8b35 thread coop::play_cinematic( "sat_priya_intro", { #timeout:22, #triggerradius:450, #flag:var_673fca035832e068, #flag_countdown:var_726e61c62699d639, #var_ba7c3b8fa9d3823:player, #structs:teleport_structs, #squad:var_64bb57aa2d6e8b35 } );
        level utility::flag_wait( var_726e61c62699d639 );
        level utility::flag_clear( var_726e61c62699d639 );
        
        if ( coop::should_play_igcs() )
        {
            wait 1;
        }
        
        van_scriptable = getscriptablearray( "sag_van", #targetname );
        
        if ( van_scriptable && van_scriptable[ 0 ] )
        {
            van_scriptable[ 0 ] setscriptablepartstate( "sag_miniboss", "intro", 0 );
        }
        
        level.van_radio setscriptablepartstate( "Radio", "off" );
        var_cd7e11dc688992d4 notify( #"hash_710ef62fa3034b91" );
        level utility::flag_wait( var_673fca035832e068 );
        var_cd7e11dc688992d4 notify( #"hash_62cef73c0e699b02" );
        level utility::flag_clear( var_673fca035832e068 );
    }
    else
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player setorigin( ( 30518, -2810, 2072 ) );
        }
    }
    
    childthread runbossfight( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    set_current_respawn_point( var_cd7e11dc688992d4, "van", 0.1 );
    var_cd7e11dc688992d4 waittill( #"boss_fight_completed", boss_origin, boss_angles, boss_corpse );
    overlord::playevent( "target_down_check_here", var_64bb57aa2d6e8b35.players );
    waitframe();
    function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_776e2a9d2adea2f9", var_64bb57aa2d6e8b35.players );
    var_b3eefe3fc356ae8f = var_cd7e11dc688992d4.var_2daa3ace3eeb3032[ var_cd7e11dc688992d4.var_7080aee967898ed4 ];
    keycard_interact = function_d7b144a0cdbd7cba( var_cd7e11dc688992d4, boss_origin + ( 0, 0, 10 ), &function_bf7c758810629180, undefined, var_cd7e11dc688992d4, var_b3eefe3fc356ae8f, undefined, &"sat_ob_activities/contract_sag_acquire" );
    childthread namespace_bbbb94f0356653a2::function_f19b17747f2036c4( [ "nag_keycard_1" ], 30, 45, "keycard_acquired", var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    var_cd7e11dc688992d4 waittill( #"keycard_acquired", keycard_player );
    
    if ( level.var_7244c9b844ee8842.size < getdvarint( @"hash_8bfed2d2a7cb81ca", 1 ) && getdvarint( @"hash_9cb2755bbb6da0b2", 0 ) )
    {
        var_64bb57aa2d6e8b35.players[ 0 ] function_679f8fb01354adca();
    }
    
    keycard_scene_struct = { #angles:keycard_player.angles, #origin:keycard_player.origin };
    keycard_scene_struct scene::play( [ keycard_player ], undefined, "sat_mp_ob_sag_priya_grab" );
    function_ee08a4456c7b5cc7( var_cd7e11dc688992d4.mission_ui, var_cd7e11dc688992d4.mission_ui.maxprogress, var_64bb57aa2d6e8b35.players );
    waypoint_objective_handler::waypoint_objective_handler_cancel( var_b3eefe3fc356ae8f, { #squad:var_cd7e11dc688992d4.sessionsquadid, #team:var_cd7e11dc688992d4.team } );
    
    if ( boss_corpse )
    {
        thread function_a569be9d8f86df34( boss_corpse, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 );
    }
    
    overlord::playconversation( "karma_we_have_the_access", var_64bb57aa2d6e8b35.players );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"sag_mini_boss" );
    
    /#
        iprintlnbold( "<dev string:x124>" );
    #/
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x56be9cad, Offset: 0x3bb7
// Size: 0x5a
function private function_78c6ac552f42784a()
{
    var_8bd7d1fb1102f957 = ai_spawn_director::lookup_spawn_request( "sag_aqueduct_ambush_encounter_volume" );
    
    if ( isdefined( var_8bd7d1fb1102f957 ) && function_9b649316adcccbaa( var_8bd7d1fb1102f957 ).status == 1 )
    {
        function_ef57f478f96b050c( var_8bd7d1fb1102f957, 1 );
        ai_spawn_director::add_spawned_callback( var_8bd7d1fb1102f957, &function_cbec0ead63fa35c2 );
        
        /#
            iprintlnbold( "<dev string:x145>" );
        #/
    }
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0x49a69f6e, Offset: 0x3c19
// Size: 0xab
function private function_cbec0ead63fa35c2( var_38d93398304edde1, var_cd7e11dc688992d4, agent, data )
{
    level endon( #"game_ended" );
    level endon( #"hash_bc6d9607586e5000" );
    
    if ( !isdefined( level.var_7bf9fb25c9ec683c ) )
    {
        level.var_7bf9fb25c9ec683c = [];
    }
    
    level.var_7bf9fb25c9ec683c[ level.var_7bf9fb25c9ec683c.size ] = agent;
    agent waittill( #"death" );
    level.var_7bf9fb25c9ec683c = arrayremove( level.var_7bf9fb25c9ec683c, agent );
    
    if ( level.var_7bf9fb25c9ec683c.size == 0 )
    {
        level.var_7bf9fb25c9ec683c = undefined;
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xacd5b458, Offset: 0x3ccc
// Size: 0x182
function private function_91c26ad4d7863519( var_cd7e11dc688992d4, aqueduct_origin )
{
    level endon( #"game_ended" );
    var_cd7e11dc688992d4 utility::waittill_any( "hologram_scanned", "completed", "squad_left_match" );
    
    while ( true )
    {
        should_kill_encounter = 1;
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, aqueduct_origin ) < squared( 5500 ) )
            {
                should_kill_encounter = 0;
                break;
            }
        }
        
        if ( should_kill_encounter && level.var_7bf9fb25c9ec683c )
        {
            level notify( #"hash_bc6d9607586e5000" );
            
            foreach ( agent in level.var_7bf9fb25c9ec683c )
            {
                agent agent_utils::despawnagent();
            }
            
            level.var_7bf9fb25c9ec683c = undefined;
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xb3f745d6, Offset: 0x3e56
// Size: 0x149
function private function_95f09ebc94a546f0( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"boss_fight_completed" );
    
    if ( !var_cd7e11dc688992d4.var_84c97fb73f83bff6 )
    {
        function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_5dc57043d73af52e", var_64bb57aa2d6e8b35.players );
    }
    
    while ( true )
    {
        var_cd7e11dc688992d4 waittill( #"hash_125fb82cce5e15d8" );
        
        if ( !var_cd7e11dc688992d4.var_84c97fb73f83bff6 )
        {
            var_cd7e11dc688992d4 waittill( #"decoy_spotted" );
            var_cd7e11dc688992d4.var_84c97fb73f83bff6 = 1;
            
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                player utility::callsharedfunc( #"hint", #"add_simple", "hint_scan_decoy", &"sat_ob/hint_scan_echo_unit", 10 );
            }
        }
        
        function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_359b184eb497d993", var_64bb57aa2d6e8b35.players );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xdfcb8b26, Offset: 0x3fa7
// Size: 0x55
function private function_4ee9fda79308b959( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"boss_fight_completed" );
    
    while ( true )
    {
        var_cd7e11dc688992d4 waittill( #"hologram_scanned" );
        function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_5dc57043d73af52e", var_64bb57aa2d6e8b35.players );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xc782e6c0, Offset: 0x4004
// Size: 0x6d
function private function_cf7c095da17079a5( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"boss_fight_completed" );
    
    while ( true )
    {
        var_cd7e11dc688992d4 waittill( #"cradle_spawn" );
        wait 0.5;
        utility::callsharedfunc( #"ob_cradle", #"hash_da32d345fbc532ff", "medium", 3, undefined, var_64bb57aa2d6e8b35.players, undefined, undefined, 0 );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xf381fa4, Offset: 0x4079
// Size: 0x24
function private function_bf7c758810629180( player, var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 notify( #"keycard_acquired", player );
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x975d36a4, Offset: 0x40a5
// Size: 0x39b
function private runbossfight( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_c2d8c70c9e8914f6 = undefined;
    var_36fdc13ba4992ae2 = [ [ "sagittarius_aqueduct_hologram_0", "sagittarius_boss_circle_1_path_0", "sagittarius_boss_decoy_1_path_0", "sagittarius_boss_circle_2_path_0", "sagittarius_boss_body_path_0" ], [ "sagittarius_aqueduct_hologram_1", "sagittarius_boss_circle_1_path_1", "sagittarius_boss_decoy_1_path_1", "sagittarius_boss_circle_2_path_1", "sagittarius_boss_body_path_1" ] ];
    
    do
    {
        var_326b134b5d097db8 = level.var_326b134b5d097db8;
        var_c68c3e402c24de7e = getdvarint( @"sag_boss_fight_location_override", 0 );
        var_c68c3e402c24de7e = clampint( var_c68c3e402c24de7e, 0, var_326b134b5d097db8.size );
        has_location_override = var_c68c3e402c24de7e != 0;
        
        if ( var_c68c3e402c24de7e )
        {
            var_8cfd1764035d20ed = var_326b134b5d097db8[ var_c68c3e402c24de7e ];
            
            if ( !var_8cfd1764035d20ed.var_e26932b14b792eb3 )
            {
                var_8cfd1764035d20ed.var_e26932b14b792eb3 = 1;
                var_c2d8c70c9e8914f6 = var_8cfd1764035d20ed.var_5b37ae8285315e61;
                var_cd7e11dc688992d4.var_ee4dff6c24f787f8 = var_c68c3e402c24de7e;
                var_cd7e11dc688992d4.var_2daa3ace3eeb3032 = var_36fdc13ba4992ae2[ var_cd7e11dc688992d4.var_ee4dff6c24f787f8 ];
            }
        }
        else
        {
            for ( index = 0; index < var_326b134b5d097db8.size ; index++ )
            {
                var_8cfd1764035d20ed = var_326b134b5d097db8[ index ];
                
                if ( !var_8cfd1764035d20ed.var_e26932b14b792eb3 )
                {
                    var_8cfd1764035d20ed.var_e26932b14b792eb3 = 1;
                    var_c2d8c70c9e8914f6 = var_8cfd1764035d20ed.var_5b37ae8285315e61;
                    var_cd7e11dc688992d4.var_ee4dff6c24f787f8 = index;
                    var_cd7e11dc688992d4.var_2daa3ace3eeb3032 = var_36fdc13ba4992ae2[ var_cd7e11dc688992d4.var_ee4dff6c24f787f8 ];
                    break;
                }
            }
        }
        
        if ( !var_c2d8c70c9e8914f6 )
        {
            /#
                iprintlnbold( "<dev string:x154>" );
            #/
            
            overlord::playevent( "priya_move_standby", var_64bb57aa2d6e8b35.players, undefined, 0, 0 );
            level waittill( #"hash_445483ee5b317eb2" );
        }
    }
    while ( !var_c2d8c70c9e8914f6 );
    
    childthread function_95f09ebc94a546f0( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    childthread function_4ee9fda79308b959( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    childthread function_cf7c095da17079a5( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    boss = ob_activity_sagittarius_sniper_boss::start_fight( var_cd7e11dc688992d4, var_c2d8c70c9e8914f6, &function_6a6f34abd0c3f9fd, &function_1dbdf4ce39f3f3e5 );
    boss.allowlongdeath = 0;
    boss.deathanimmode = "nophysics";
    boss.noragdoll = 1;
    childthread namespace_bbbb94f0356653a2::function_69bfa840c2e7f264( boss, var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    
    if ( !level.var_7bf9fb25c9ec683c || level.var_7bf9fb25c9ec683c.size == 0 )
    {
        thread function_91c26ad4d7863519( var_cd7e11dc688992d4, boss.origin );
        function_78c6ac552f42784a();
    }
    
    boss waittill( #"death" );
    
    if ( isdefined( var_cd7e11dc688992d4.var_dde5404226c05288 ) )
    {
        var_cd7e11dc688992d4.var_dde5404226c05288 delete();
    }
    
    [ var_3168f7303670a541, corpse_angles ] = function_a387c7ed9820a793( boss, 90 );
    ob_story_mission_utils::function_eee81c6c2c7fdb3( var_64bb57aa2d6e8b35 );
    overlord::playevent( "armor_upgrade_1", var_64bb57aa2d6e8b35.players, 0.1, 0, 0 );
    wait 2.5;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( var_3168f7303670a541 + ( 0, 0, 10 ), corpse_angles );
    common_item::function_61c2c0251e742ffd( %"hash_72b17f2fec0488d3", undefined, spawnoptions );
    function_e2116fc30acb3d6f( var_cd7e11dc688992d4 );
    boss_corpse = boss getcorpseentity();
    
    if ( boss_corpse )
    {
        thread function_d7cf408a687b759a( boss_corpse, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 );
    }
    
    var_cd7e11dc688992d4 notify( #"boss_fight_completed", var_3168f7303670a541, corpse_angles, boss_corpse );
    ob_activity_sagittarius_sniper_boss::function_365c8f6480690c2e( var_cd7e11dc688992d4 );
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0x92310b0, Offset: 0x4448
// Size: 0x128
function private function_a569be9d8f86df34( boss_corpse, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    var_cd7e11dc688992d4 endon( #"boss_corpse_deleted" );
    var_4ffe084f684e2a9b = 4000000;
    
    while ( true )
    {
        should_remove_corpse = 1;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( boss_corpse && distancesquared( player.origin, boss_corpse.origin ) < var_4ffe084f684e2a9b )
            {
                should_remove_corpse = 0;
                break;
            }
        }
        
        if ( should_remove_corpse )
        {
            if ( boss_corpse )
            {
                boss_corpse delete();
                var_cd7e11dc688992d4 notify( #"boss_corpse_deleted" );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0x9c4be767, Offset: 0x4578
// Size: 0x57
function private function_d7cf408a687b759a( boss_corpse, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"boss_corpse_deleted" );
    var_cd7e11dc688992d4 utility::waittill_any( "squad_left_match", "completed" );
    
    if ( boss_corpse )
    {
        boss_corpse delete();
        var_cd7e11dc688992d4 notify( #"boss_corpse_deleted" );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xbf104693, Offset: 0x45d7
// Size: 0x214
function private function_a387c7ed9820a793( agent, var_ef81874bf9536578 = 0 )
{
    corpse = agent getcorpseentity();
    var_3168f7303670a541 = agent.origin;
    corpse_angles = agent.angles;
    
    if ( corpse )
    {
        [ var_3168f7303670a541, corpse_angles ] = function_a05311de2625a536( agent, corpse );
        pairs = function_edc3b09be2f3f34e( var_3168f7303670a541, 25, 6 );
        
        foreach ( pair in pairs )
        {
            hit_ground = !trace::ray_trace_passed( pair[ 0 ] + ( 0, 0, 10 ), pair[ 0 ] - ( 0, 0, 10 ) );
            
            if ( hit_ground )
            {
                hit_ground = !trace::ray_trace_passed( pair[ 1 ] + ( 0, 0, 10 ), pair[ 1 ] - ( 0, 0, 10 ) );
            }
            
            if ( hit_ground )
            {
                y_angle = vectortoangles( pair[ 0 ] - pair[ 1 ] )[ 1 ] + var_ef81874bf9536578;
                corpse_angles = ( corpse_angles[ 0 ], y_angle, corpse_angles[ 2 ] );
                
                /#
                    sphere( pair[ 0 ], 10, ( 1, 0, 0 ), 1, 300 );
                    sphere( pair[ 1 ], 10, ( 1, 0, 0 ), 1, 300 );
                    line( pair[ 0 ], pair[ 1 ], ( 0, 1, 0 ), 1, 1, 300 );
                #/
                
                break;
            }
        }
        
        corpse.origin = var_3168f7303670a541;
        corpse.angles = corpse_angles;
    }
    
    return [ var_3168f7303670a541, corpse_angles ];
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xfd5aa564, Offset: 0x47f4
// Size: 0x16e
function private function_a05311de2625a536( agent, corpse )
{
    corpse_angles = ( 1, 0, 0 );
    var_3168f7303670a541 = agent.origin;
    
    if ( corpse )
    {
        ignore_ents = [ agent, corpse ];
    }
    else
    {
        ignore_ents = [ agent ];
    }
    
    trace = trace::ray_trace( agent.origin + ( 0, 0, 100 ), agent.origin - ( 0, 0, 10 ), ignore_ents );
    
    if ( trace && trace[ "normal" ] )
    {
        normal = vectornormalize( trace[ "normal" ] );
        down_vector = ( 0, 0, -1 );
        dot = vectordot( down_vector, normal );
        projected = normal * dot;
        forward = vectornormalize( down_vector - projected );
        
        if ( forward != ( 0, 0, 0 ) )
        {
            right = vectornormalize( vectorcross( forward, normal ) );
            angles = vectortoangles( forward );
            corpse_angles = angles;
            var_3168f7303670a541 = trace[ "position" ];
        }
    }
    
    return [ var_3168f7303670a541, corpse_angles ];
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0xc5205109, Offset: 0x496b
// Size: 0x122
function private function_edc3b09be2f3f34e( center_origin, radius, var_ccf8564517967d23 )
{
    pairs = [];
    anglestep = 3.14159 / var_ccf8564517967d23;
    
    for ( i = 0; i < var_ccf8564517967d23 ; i++ )
    {
        angle = i * anglestep;
        var_b7e4d689fa6d3323 = math::radians_to_degrees( angle );
        x1 = center_origin[ 0 ] + radius * cos( var_b7e4d689fa6d3323 );
        y1 = center_origin[ 1 ] + radius * sin( var_b7e4d689fa6d3323 );
        z1 = center_origin[ 2 ];
        var_6d3a5bf0c269ee2a = math::radians_to_degrees( angle + 3.14159 );
        x2 = center_origin[ 0 ] + radius * cos( var_6d3a5bf0c269ee2a );
        y2 = center_origin[ 1 ] + radius * sin( var_6d3a5bf0c269ee2a );
        z2 = center_origin[ 2 ];
        pairs[ pairs.size ] = [ ( x1, y1, z1 ), ( x2, y2, z2 ) ];
    }
    
    return pairs;
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0x115107e7, Offset: 0x4a96
// Size: 0x12c
function private function_6a6f34abd0c3f9fd( boss, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 )
{
    namespace_bbbb94f0356653a2::function_860e2822ee021a99( var_64bb57aa2d6e8b35.players[ 0 ].origin, boss.origin, var_64bb57aa2d6e8b35.players );
    var_dde5404226c05288 = function_123f3470d175c518( var_cd7e11dc688992d4, boss.origin, 4000, 1 );
    var_cd7e11dc688992d4.var_dde5404226c05288 = var_dde5404226c05288;
    childthread function_ea8bd1192690d3e4( var_dde5404226c05288, boss.origin, 4000, 1, var_64bb57aa2d6e8b35, 1, 1 );
    var_b3eefe3fc356ae8f = var_cd7e11dc688992d4.var_2daa3ace3eeb3032[ var_cd7e11dc688992d4.var_7080aee967898ed4 ];
    childthread function_2a6ba541e258c5( var_cd7e11dc688992d4, getgroundposition( var_dde5404226c05288.origin, 32, 9999 ), 4000, undefined, var_b3eefe3fc356ae8f );
    var_dde5404226c05288 utility::ent_flag_wait( "circle_objective_shrinking_completed" );
    var_cd7e11dc688992d4.var_7080aee967898ed4++;
    var_cd7e11dc688992d4 notify( #"hash_8b447625fbb572ca" );
    thread reveal_boss_marker( boss, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 );
    set_current_respawn_point( var_cd7e11dc688992d4 );
    thread function_2bd21a4d8d84d98b( var_cd7e11dc688992d4, boss );
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xfe4dc8c1, Offset: 0x4bca
// Size: 0x1a4
function private function_2bd21a4d8d84d98b( var_cd7e11dc688992d4, boss )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    boss endon( #"death" );
    origin = undefined;
    radius = undefined;
    
    switch ( var_cd7e11dc688992d4.var_ee4dff6c24f787f8 )
    {
        case 0:
            if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 0 )
            {
                origin = ( 33381, -11635, 270 );
                radius = 4500;
            }
            else if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 1 )
            {
                origin = ( 29686, -21618, 277 );
                radius = 4500;
            }
            
            break;
        case 1:
            if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 0 )
            {
                origin = ( 26757, -12449, 433 );
                radius = 2800;
            }
            else if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 1 )
            {
                origin = ( 23083, -20680, 433 );
                radius = 2350;
            }
            
            break;
        case 2:
            if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 0 )
            {
            }
            else if ( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e == 1 )
            {
            }
            
            break;
    }
    
    if ( origin && radius )
    {
        var_cd7e11dc688992d4.var_dde5404226c05288.origin = ( origin[ 0 ], origin[ 1 ], radius );
        var_cd7e11dc688992d4 waittill( #"hash_125fb82cce5e15d8" );
        var_cd7e11dc688992d4.var_dde5404226c05288 delete();
        var_cd7e11dc688992d4.var_dde5404226c05288 = undefined;
    }
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0x9b087785, Offset: 0x4d76
// Size: 0x7a
function private function_1dbdf4ce39f3f3e5( origin, radius, var_cd7e11dc688992d4 )
{
    objectiveoffset = ( 0, 0, 80 );
    var_b3eefe3fc356ae8f = var_cd7e11dc688992d4.var_2daa3ace3eeb3032[ var_cd7e11dc688992d4.var_7080aee967898ed4 ];
    function_2a6ba541e258c5( var_cd7e11dc688992d4, origin + objectiveoffset, radius, undefined, var_b3eefe3fc356ae8f, "hologram_scanned" );
    var_cd7e11dc688992d4.var_7080aee967898ed4++;
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0x3826a292, Offset: 0x4df8
// Size: 0x98
function private reveal_boss_marker( boss, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    var_cd7e11dc688992d4.var_9be376218db54aba = "sat_ob_objectivemarker_boss";
    boss_marker_id = var_cd7e11dc688992d4 ob_story_mission_utils::function_b0fb462142682571( boss, var_64bb57aa2d6e8b35.players, 150 );
    objidpoolmanager::objective_set_play_intro( boss_marker_id, 0 );
    wait 5;
    var_cd7e11dc688992d4 ob_story_mission_utils::mission_objective_marker_clear( boss_marker_id, var_64bb57aa2d6e8b35.players );
    var_cd7e11dc688992d4.var_9be376218db54aba = undefined;
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x93ab55cc, Offset: 0x4e98
// Size: 0x53
function private function_e2116fc30acb3d6f( var_cd7e11dc688992d4 )
{
    if ( isdefined( var_cd7e11dc688992d4.var_ee4dff6c24f787f8 ) )
    {
        level.var_326b134b5d097db8[ var_cd7e11dc688992d4.var_ee4dff6c24f787f8 ].var_e26932b14b792eb3 = 0;
        var_cd7e11dc688992d4.var_ee4dff6c24f787f8 = undefined;
        level notify( #"hash_445483ee5b317eb2" );
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0xdff26281, Offset: 0x4ef3
// Size: 0x1a, Type: bool
function private function_36133a06b39806ef( sessionsquadid )
{
    return level.var_9ff6ee3074298a7[ 0 ] == sessionsquadid;
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0xb253ab80, Offset: 0x4f16
// Size: 0x27
function private function_3bcdfac354444f01()
{
    wait 1.4;
    snd::play( "dx_wc_wsag_scar_gpa1_userpriyazaveriserve", level.sag_rfid_reader.origin );
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xf952e869, Offset: 0x4f45
// Size: 0xa44
function private sagittarius_stronghold( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    var_cd7e11dc688992d4 story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"sag_stronghold" );
    var_cd7e11dc688992d4 notify( #"sag_give_loadout", 0 );
    function_13259fcdad7a338e( var_cd7e11dc688992d4 );
    
    if ( var_64bb57aa2d6e8b35.sagjump )
    {
        sagittarius_stronghold_end( var_64bb57aa2d6e8b35.players[ 0 ], var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
        return;
    }
    
    function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_667700e097517cdf", var_64bb57aa2d6e8b35.players );
    level thread function_2a6ba541e258c5( var_cd7e11dc688992d4, ( 12056, -29494, 4410 ), 3000, "stronghold_waypoint_reached", "sagittarius_stronghold" );
    overlord::playconversation( "fastest_way_there", var_64bb57aa2d6e8b35.players );
    wait 8;
    overlord::playconversation( "offer_stands_mason", var_64bb57aa2d6e8b35.players );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "stronghold_waypoint_reached" );
    function_ee08a4456c7b5cc7( var_cd7e11dc688992d4.mission_ui, var_cd7e11dc688992d4.mission_ui.maxprogress, var_64bb57aa2d6e8b35.players );
    level.var_9ff6ee3074298a7[ level.var_9ff6ee3074298a7.size ] = var_cd7e11dc688992d4.sessionsquadid;
    
    if ( function_36133a06b39806ef( var_cd7e11dc688992d4.sessionsquadid ) )
    {
        function_38cceab373548cbc( var_cd7e11dc688992d4 );
    }
    
    set_current_respawn_point( var_cd7e11dc688992d4, "stronghold", 0.85 );
    overlord::playconversation( "data_bunker_ahead", var_64bb57aa2d6e8b35.players );
    childthread function_5818be31fe9030f5( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_2bb6c4820bb46f2a", var_64bb57aa2d6e8b35.players );
    interact = function_d7b144a0cdbd7cba( var_cd7e11dc688992d4, level.sag_rfid_reader.origin + ( 0, 0, 3 ), undefined, undefined, undefined, "sagittarius_stronghold_rfid", undefined, &"sat_ob_activities/contract_sag_access" );
    interact waittill( #"valid_use", player );
    var_cd7e11dc688992d4 notify( #"sag_rfid_used" );
    function_ee08a4456c7b5cc7( var_cd7e11dc688992d4.mission_ui, var_cd7e11dc688992d4.mission_ui.maxprogress, var_64bb57aa2d6e8b35.players );
    
    if ( player )
    {
        rfid_scene_struct = utility::getstruct( "sag_keycard_access_scene" );
        childthread function_3bcdfac354444f01();
        rfid_scene_struct scene::play( [ player ] );
    }
    
    childthread function_7cef2b2e178f316( var_cd7e11dc688992d4 );
    thread function_149de59b4a4b0b13( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    
    if ( !getdvarint( @"hash_34d9b26e5863ffc4", 0 ) )
    {
        function_351dcb154f801030( var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 );
        function_e18f7c477c480f05( "antenna_fortress_reinforcements_stronghold", var_cd7e11dc688992d4, &function_969d00de63f249ed, &function_2662ac8a9e548247 );
        function_e18f7c477c480f05( "antenna_fortress_reinforcements_stronghold_dawg", var_cd7e11dc688992d4, &function_d0fbd932a6b15efe, &function_2662ac8a9e548247 );
        function_e18f7c477c480f05( "antenna_fortress_reinforcements_ground_vehicles", var_cd7e11dc688992d4, &function_969d00de63f249ed, &function_2662ac8a9e548247, &function_6a21247ea8d6dd7b, &function_9b7c6d0051d6996c );
        var_cd7e11dc688992d4.var_ededefb170ca915f = 1;
        overlord::playconversation( "someone_spike_this_server", var_64bb57aa2d6e8b35.players, 2 );
        
        if ( var_64bb57aa2d6e8b35.players.size > 2 )
        {
            uplink_info = [ [ ( 12666, -29830, 4107 ), ( 12675, -29845, 4053.55 ), 0, "hack_wave_2_mp", 40, "sag_servers_01" ], [ ( 12308.8, -30047, 4107 ), ( 12317.3, -30061.9, 4053.55 ), 0, "hack_wave_4", 40, "sag_servers_02" ], [ ( 12303.8, -29114, 4107 ), ( 12295.1, -29099.1, 4053 ), 0, "hack_wave_5_mp", 40, "sag_servers_03" ] ];
        }
        else
        {
            uplink_info = [ [ ( 12666, -29830, 4107 ), ( 12675, -29845, 4053.55 ), 0, "hack_wave_1", 40, "sag_servers_01" ], [ ( 12308.8, -30047, 4107 ), ( 12317.3, -30061.9, 4053.55 ), 0, "hack_wave_2", 40, "sag_servers_02" ], [ ( 12303.8, -29114, 4107 ), ( 12295.1, -29099.1, 4053.55 ), 0, "hack_wave_5", 40, "sag_servers_03" ] ];
        }
        
        function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_79dc84d8146f79df", var_64bb57aa2d6e8b35.players, uplink_info.size );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", "hint_spike_server", &"sat_ob/hint_spike_server", 10 );
        }
        
        var_c600791254f3c49f = undefined;
        
        if ( !level.var_fe352a40ef1f7efc )
        {
            level.var_fe352a40ef1f7efc = [];
        }
        
        for ( index = 0; index < uplink_info.size ; index++ )
        {
            uplink_position = uplink_info[ index ][ 0 ];
            player_interaction_position = uplink_info[ index ][ 1 ];
            animation_offset = uplink_info[ index ][ 2 ];
            var_515fdafd7ad0a052 = uplink_info[ index ][ 3 ];
            var_d29e179bdca0f7a4 = uplink_info[ index ][ 4 ];
            var_ceb54efa7706c641 = uplink_info[ index ][ 5 ];
            var_138bb1fd34ccf211 = getdvarint( @"hash_9374f8a53645d8", 0 );
            
            if ( var_138bb1fd34ccf211 > 0 )
            {
                var_d29e179bdca0f7a4 = var_138bb1fd34ccf211;
            }
            
            if ( var_515fdafd7ad0a052 && !isdefined( level.var_fe352a40ef1f7efc[ var_515fdafd7ad0a052 ] ) )
            {
                level.var_fe352a40ef1f7efc[ var_515fdafd7ad0a052 ] = 0;
            }
            
            interaction_direction = vectornormalize( ( player_interaction_position[ 0 ], player_interaction_position[ 1 ], uplink_position[ 2 ] ) - uplink_position );
            player_interaction_angles = vectortoangles( interaction_direction );
            player_interaction_position = ( player_interaction_position[ 0 ] + interaction_direction[ 0 ] * animation_offset, player_interaction_position[ 1 ] + interaction_direction[ 1 ] * animation_offset, player_interaction_position[ 2 ] );
            function_ee08a4456c7b5cc7( var_cd7e11dc688992d4.mission_ui, index, var_64bb57aa2d6e8b35.players );
            var_cd7e11dc688992d4.var_e7665325aece18e8 = undefined;
            
            if ( function_36133a06b39806ef( var_cd7e11dc688992d4.sessionsquadid ) && var_ceb54efa7706c641 )
            {
                var_cd7e11dc688992d4.var_e7665325aece18e8 = getentitylessscriptablearray( var_ceb54efa7706c641, #targetname );
            }
            
            function_8687b245e15c1418( var_c600791254f3c49f, 0 );
            function_8687b245e15c1418( var_515fdafd7ad0a052, 1 );
            var_c600791254f3c49f = var_515fdafd7ad0a052;
            
            if ( var_cd7e11dc688992d4.var_c682d4f5f34090b8 )
            {
                var_cd7e11dc688992d4.var_ededefb170ca915f = 1;
                var_cd7e11dc688992d4.var_c682d4f5f34090b8 = 0;
            }
            
            childthread namespace_bbbb94f0356653a2::function_f19b17747f2036c4( [ "nag_spike_server_1" ], 30, 40, "sag_spike_planted", var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
            function_53664df9d6e891c4( var_cd7e11dc688992d4.var_e7665325aece18e8, "base" );
            objective_struct_name = "sagittarius_stronghold_server_" + index;
            interact = function_d7b144a0cdbd7cba( var_cd7e11dc688992d4, uplink_position, undefined, undefined, var_cd7e11dc688992d4, objective_struct_name, undefined, &"sat_ob_activities/contract_sag_spike" );
            interact waittill( #"valid_use", player );
            var_cd7e11dc688992d4 notify( #"sag_spike_planted" );
            
            if ( function_36133a06b39806ef( var_cd7e11dc688992d4.sessionsquadid ) )
            {
                childthread sag_activate_bots( var_cd7e11dc688992d4 );
            }
            
            if ( player )
            {
                insert_scene_struct = { #angles:player_interaction_angles, #origin:player_interaction_position };
                insert_scene_struct scene::play( [ player ], undefined, "sat_mp_ob_sag_usb_interact_insert" );
            }
            
            function_53664df9d6e891c4( var_cd7e11dc688992d4.var_e7665325aece18e8, "active" );
            childthread function_84795ee591f87a39( var_64bb57aa2d6e8b35, var_cd7e11dc688992d4, var_d29e179bdca0f7a4, uplink_position );
            var_cd7e11dc688992d4 waittill( #"hash_4edb024e3b7a0280" );
            
            if ( index == uplink_info.size - 1 )
            {
                function_9978d07cf786e146( var_cd7e11dc688992d4, %"hash_633d00396023afde", var_64bb57aa2d6e8b35.players );
                var_cd7e11dc688992d4 notify( #"hash_4b19242711a637ce" );
            }
            
            function_53664df9d6e891c4( var_cd7e11dc688992d4.var_e7665325aece18e8, "stopped" );
            function_4d7d8a33854919e( var_cd7e11dc688992d4, index, uplink_info.size, var_64bb57aa2d6e8b35 );
            interact = function_d7b144a0cdbd7cba( var_cd7e11dc688992d4, uplink_position, undefined, undefined, undefined, objective_struct_name, undefined, &"sat_ob_activities/contract_sag_recover" );
            interact waittill( #"valid_use", player );
            var_cd7e11dc688992d4 notify( #"sag_spike_grabed" );
            
            if ( player && index < uplink_info.size - 1 )
            {
                pullout_scene_struct = { #angles:player_interaction_angles, #origin:player_interaction_position };
                pullout_scene_struct scene::play( [ player ], undefined, "sat_mp_ob_sag_usb_interact_pullout" );
            }
            
            function_53664df9d6e891c4( var_cd7e11dc688992d4.var_e7665325aece18e8, "off" );
        }
        
        var_cd7e11dc688992d4.var_e7665325aece18e8 = undefined;
        function_8687b245e15c1418( var_c600791254f3c49f, 0 );
        var_c600791254f3c49f = undefined;
    }
    
    level.var_9ff6ee3074298a7 = arrayremove( level.var_9ff6ee3074298a7, var_cd7e11dc688992d4.sessionsquadid );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"sag_stronghold" );
    function_eee59895c53d92a0( var_cd7e11dc688992d4 );
    
    for ( i = 0; i < 5 ; i++ )
    {
        var_500f9cd57c86328e = getentitylessscriptablearray( "sag_servers_0" + i + 1, #targetname );
        
        if ( var_500f9cd57c86328e )
        {
            if ( var_500f9cd57c86328e[ 0 ] getscriptablepartstate( "base" ) == "off" )
            {
                function_53664df9d6e891c4( var_500f9cd57c86328e, "base" );
            }
        }
    }
    
    sagittarius_stronghold_end( player, var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
}

// Namespace ob_activity_sagittarius
// Params 3
// Checksum 0x485af259, Offset: 0x5991
// Size: 0x1b1
function sagittarius_stronghold_end( player, var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 notify( #"sag_stronghold_complete" );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_stronghold_outro", { #timeout:40, #var_ba7c3b8fa9d3823:player, #fadeendnone:1, #countdown:0, #squad:var_64bb57aa2d6e8b35 } );
    wait 1;
    party_leader = var_64bb57aa2d6e8b35.players[ 0 ];
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        if ( player isfireteamleader() )
        {
            party_leader = player;
            break;
        }
    }
    
    playlistid = party_leader function_ba1793aee415985f() ? getdvarint( @"hash_fc7c12392fe5b2d5", 264 ) : getdvarint( @"hash_3c09a7ed650a4b95", 266 );
    level ob_exfil_trans::exfiltrans( party_leader, playlistid, "sat_capricorn_load" );
    
    /#
        iprintlnbold( "<dev string:x1c5>" );
    #/
    
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"capricorn_launch" );
    story_contract_util::achievement_activities( var_64bb57aa2d6e8b35.players, "sat_wc_mission4and5", [ #"capricorn_launch", #"capricorn_complete" ] );
    var_cd7e11dc688992d4 notify( #"completed" );
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xb0d07aa7, Offset: 0x5b4a
// Size: 0x85
function private function_8687b245e15c1418( encounter_tag, set_encounter_tag )
{
    if ( !encounter_tag )
    {
        return;
    }
    
    var_6b932c24dfcaa716 = set_encounter_tag && !function_af1e93bdbbe9cdbe( encounter_tag );
    var_6b932c24dfcaa716 = var_6b932c24dfcaa716 || !set_encounter_tag && level.var_fe352a40ef1f7efc[ encounter_tag ] <= 0;
    
    if ( var_6b932c24dfcaa716 )
    {
        function_a25acb62ddab20e2( encounter_tag, set_encounter_tag );
    }
    
    level.var_fe352a40ef1f7efc[ encounter_tag ] += set_encounter_tag ? 1 : -1;
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x3e29cff8, Offset: 0x5bd7
// Size: 0x8c
function private function_53664df9d6e891c4( server_scriptables, state )
{
    foreach ( server in server_scriptables )
    {
        server setscriptablepartstate( "base", state );
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xb4e4f318, Offset: 0x5c6b
// Size: 0x1ef
function private function_e375dee6bcab318e( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    var_cd7e11dc688992d4 story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"capricorn_complete" );
    var_cd7e11dc688992d4 notify( #"sag_give_loadout", 0 );
    namespace_b451b5202140ccde::setdifficulty( 2, var_64bb57aa2d6e8b35.players );
    namespace_b451b5202140ccde::completed( var_64bb57aa2d6e8b35.players, %"hash_66e1a4d7b3fba908", 1 );
    var_cd7e11dc688992d4.mission_ui = { #difficulty:2, #state:1, #name:%"hash_66e1a4d7b3fba908" };
    interact = function_d7b144a0cdbd7cba( var_cd7e11dc688992d4, ( 1628, -19186, 956 ), undefined, "duration_short" );
    interact waittill( #"valid_use" );
    wait 1;
    party_leader = var_64bb57aa2d6e8b35.players[ 0 ];
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        if ( player isfireteamleader() )
        {
            party_leader = player;
            break;
        }
    }
    
    playlistid = party_leader function_ba1793aee415985f() ? getdvarint( @"hash_fc7c12392fe5b2d5", 264 ) : getdvarint( @"hash_3c09a7ed650a4b95", 266 );
    level ob_exfil_trans::exfiltrans( party_leader, playlistid, "sat_capricorn_load" );
    
    /#
        iprintlnbold( "<dev string:x1c5>" );
    #/
    
    var_cd7e11dc688992d4 notify( #"completed" );
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x517a9ba6, Offset: 0x5e62
// Size: 0x1bd
function private function_177f7001e9898fff( var_cd7e11dc688992d4 )
{
    foreach ( var_1348ae8d95a313d0 in var_cd7e11dc688992d4.objective_marker_ids )
    {
        level ob_story_mission_utils::mission_objective_marker_clear( var_1348ae8d95a313d0 );
    }
    
    foreach ( scriptable in var_cd7e11dc688992d4.objective_scriptables )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            scriptable disablescriptableplayeruse( player );
        }
    }
    
    var_cd7e11dc688992d4.objective_scriptables = [];
    var_cd7e11dc688992d4.objective_marker_ids = [];
    var_cd7e11dc688992d4.objective_circles = [];
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x12ddb5bf, Offset: 0x6027
// Size: 0x327
function private function_d851c0825968ae38( var_cd7e11dc688992d4, player )
{
    player endon( #"disconnect" );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "mission_activated" );
    var_cd7e11dc688992d4 ob_story_mission_utils::objective_marker_show( undefined, [ player ] );
    
    if ( var_cd7e11dc688992d4.var_bca2cec52d03f8c6 )
    {
        var_cd7e11dc688992d4.var_bca2cec52d03f8c6 enablescriptableplayeruse( player );
    }
    
    foreach ( interact in var_cd7e11dc688992d4.interacts )
    {
        interact enableplayeruse( player );
    }
    
    foreach ( circle_objective in var_cd7e11dc688992d4.circle_objectives )
    {
        circle_objective showtoplayer( player );
    }
    
    if ( var_cd7e11dc688992d4.mission_ui )
    {
        namespace_b451b5202140ccde::function_bb923ce693c606f9( var_cd7e11dc688992d4.mission_ui.asset_name, [ player ], { #difficulty:var_cd7e11dc688992d4.mission_ui.difficulty, #maxprogress:var_cd7e11dc688992d4.mission_ui.maxprogress, #state:var_cd7e11dc688992d4.mission_ui.state } );
        function_ee08a4456c7b5cc7( var_cd7e11dc688992d4.mission_ui, var_cd7e11dc688992d4.mission_ui.current_progress, [ player ] );
    }
    
    foreach ( abilitycase in level.var_dd19ba25ac528b3c )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, [ player ] );
    }
    
    foreach ( callback in var_cd7e11dc688992d4.add_player_callbacks )
    {
        profilestart();
        [[ callback ]]( player, var_cd7e11dc688992d4 );
        profilestop();
    }
    
    if ( isdefined( var_cd7e11dc688992d4.loadoutindex ) )
    {
        player thread function_acc9ecf6cb4bb9a6( var_cd7e11dc688992d4.loadoutindex );
    }
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0xf0fddf66, Offset: 0x6356
// Size: 0xec
function private function_4d7d8a33854919e( var_cd7e11dc688992d4, uplink_index, uplinks_size, var_64bb57aa2d6e8b35 )
{
    switch ( uplink_index )
    {
        case 0:
            overlord::playevent( "server_complete_1_alt", var_64bb57aa2d6e8b35.players );
            childthread function_27fea7e9d7a25cd2( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
            break;
        case 1:
            overlord::playevent( "server_complete_2", var_64bb57aa2d6e8b35.players );
            childthread overlord::playconversation( "what_are_the_odds", var_64bb57aa2d6e8b35.players, 2 );
            break;
        case 2:
            overlord::playevent( "server_complete_5", var_64bb57aa2d6e8b35.players );
            childthread namespace_bbbb94f0356653a2::function_f19b17747f2036c4( [ "nag_grab_spike_1", "nag_grab_spike_1" ], 30, 40, "sag_spike_grabed", var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
            break;
    }
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0xb9be4891, Offset: 0x644a
// Size: 0x113
function private function_9978d07cf786e146( var_cd7e11dc688992d4, asset_name, players, maxprogress = 1 )
{
    difficulty = 2;
    state = 2;
    
    if ( var_cd7e11dc688992d4.mission_ui )
    {
        function_ee08a4456c7b5cc7( var_cd7e11dc688992d4.mission_ui, var_cd7e11dc688992d4.mission_ui.maxprogress, players );
        var_cd7e11dc688992d4 namespace_b451b5202140ccde::completed( players, asset_name, state, { #difficulty:difficulty, #maxprogress:maxprogress }, 1.5 );
    }
    else
    {
        var_cd7e11dc688992d4 namespace_b451b5202140ccde::function_bb923ce693c606f9( asset_name, players, { #difficulty:difficulty, #maxprogress:maxprogress, #state:state } );
    }
    
    var_cd7e11dc688992d4.mission_ui = { #state:state, #maxprogress:maxprogress, #difficulty:difficulty, #asset_name:asset_name };
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0xd385b332, Offset: 0x6565
// Size: 0x50
function private function_ee08a4456c7b5cc7( var_9fc548e14e0e7539, current_progress, players )
{
    if ( var_9fc548e14e0e7539.maxprogress )
    {
        mission_ui::function_759924b87215156b( current_progress, var_9fc548e14e0e7539.maxprogress, players );
        var_9fc548e14e0e7539.current_progress = current_progress;
    }
}

// Namespace ob_activity_sagittarius
// Params 8, eflags: 0x4
// Checksum 0xd63acfd0, Offset: 0x65bd
// Size: 0x23a
function private function_d7b144a0cdbd7cba( var_cd7e11dc688992d4, position, interaction_callback, duration, custom_data = undefined, var_b749fae11a9dc28d = undefined, var_33137e3b7d6f2cd7 = undefined, interact_prompt = &"jup_ob_objectives/interact_activate" )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    if ( var_b749fae11a9dc28d )
    {
        objective_struct = utility::getstruct( var_b749fae11a9dc28d );
        
        if ( objective_struct )
        {
            objective_struct.origin = position + ( 0, 0, 16 );
            var_cd7e11dc688992d4 thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_b749fae11a9dc28d, var_33137e3b7d6f2cd7, "", undefined, { #squad:var_cd7e11dc688992d4.sessionsquadid, #team:var_cd7e11dc688992d4.team }, 0, 0, 0, 1 );
        }
        else
        {
            var_b749fae11a9dc28d = undefined;
        }
    }
    
    interact = interaction::register_interact( position, 64, &function_c127e2c7333fb19a, interact_prompt, undefined, undefined, undefined, "HINT_BUTTON" );
    interact.var_4ee47160354594d1 = interaction_callback;
    interact.var_b749fae11a9dc28d = var_b749fae11a9dc28d;
    interact.var_cd7e11dc688992d4 = var_cd7e11dc688992d4;
    interact.custom_data = custom_data;
    
    if ( !isdefined( var_cd7e11dc688992d4.interacts ) )
    {
        var_cd7e11dc688992d4.interacts = [];
    }
    
    var_cd7e11dc688992d4.interacts[ var_cd7e11dc688992d4.interacts.size ] = interact;
    
    if ( isdefined( duration ) )
    {
        interact setuseholdduration( duration );
    }
    
    interact disableplayeruseforallplayers();
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        interact enableplayeruse( player );
    }
    
    return interact;
}

// Namespace ob_activity_sagittarius
// Params 7, eflags: 0x4
// Checksum 0x87088761, Offset: 0x6800
// Size: 0x20c
function private function_2a6ba541e258c5( var_cd7e11dc688992d4, origin, radius, notify_message = undefined, var_b749fae11a9dc28d = undefined, flag_wait_remove_objective = undefined, var_33137e3b7d6f2cd7 = undefined )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    
    if ( notify_message )
    {
        var_cd7e11dc688992d4 utility::ent_flag_clear( notify_message );
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    if ( var_b749fae11a9dc28d )
    {
        objective_struct = utility::getstruct( var_b749fae11a9dc28d );
        
        if ( objective_struct )
        {
            objective_struct.origin = origin;
            var_cd7e11dc688992d4 thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_b749fae11a9dc28d, var_33137e3b7d6f2cd7, "", undefined, { #squad:var_cd7e11dc688992d4.sessionsquadid, #team:var_cd7e11dc688992d4.team }, 0, 0, 0, 1 );
        }
        else
        {
            var_b749fae11a9dc28d = undefined;
        }
    }
    
    while ( true )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distance2dsquared( player.origin, origin ) < radius * radius )
            {
                if ( notify_message )
                {
                    var_cd7e11dc688992d4 utility::ent_flag_set( notify_message );
                }
                
                if ( var_b749fae11a9dc28d )
                {
                    if ( flag_wait_remove_objective )
                    {
                        var_cd7e11dc688992d4 utility::ent_flag_wait( flag_wait_remove_objective );
                    }
                    
                    waypoint_objective_handler::waypoint_objective_handler_cancel( var_b749fae11a9dc28d, { #squad:var_cd7e11dc688992d4.sessionsquadid, #team:var_cd7e11dc688992d4.team } );
                }
                
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0xb7839284, Offset: 0x6a14
// Size: 0x149
function private function_123f3470d175c518( var_cd7e11dc688992d4, origin, radius, use_origin )
{
    circle_spawn_point = origin + vectornormalize( utility::function_9e0df7b136ab833c() ) * radius / 2;
    
    if ( use_origin )
    {
        circle_spawn_point = origin;
    }
    
    circle_objective = spawnquestcircle( "Quest_Ob", circle_spawn_point[ 0 ], circle_spawn_point[ 1 ], radius, undefined );
    
    if ( !isdefined( var_cd7e11dc688992d4.circle_objectives ) )
    {
        var_cd7e11dc688992d4.circle_objectives = [];
    }
    
    var_cd7e11dc688992d4.circle_objectives[ var_cd7e11dc688992d4.circle_objectives.size ] = circle_objective;
    circle_objective hide();
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        circle_objective showtoplayer( player );
    }
    
    return circle_objective;
}

// Namespace ob_activity_sagittarius
// Params 7, eflags: 0x4
// Checksum 0xc6efc93b, Offset: 0x6b66
// Size: 0x16a
function private function_ea8bd1192690d3e4( circle_objective, pin_point_origin, circle_radius, var_6e0c6d8dcf4c621e, var_64bb57aa2d6e8b35, var_731ad32f9ae77d6c, search_radius_mod )
{
    radius = circle_radius;
    current_circle_count = 0;
    
    while ( current_circle_count < var_6e0c6d8dcf4c621e )
    {
        search_radius = radius * radius / 3;
        
        if ( isdefined( search_radius_mod ) )
        {
            search_radius = radius * radius / search_radius_mod;
        }
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( pin_point_origin, player.origin ) <= search_radius )
            {
                radius *= 0.5;
                circle_spawn_point = pin_point_origin + vectornormalize( utility::function_9e0df7b136ab833c() ) * radius * 0.5;
                
                if ( var_731ad32f9ae77d6c )
                {
                    circle_spawn_point = pin_point_origin;
                }
                
                circle_objective.origin = ( circle_spawn_point[ 0 ], circle_spawn_point[ 1 ], radius );
                current_circle_count++;
            }
        }
        
        waitframe();
    }
    
    circle_objective utility::ent_flag_set( "circle_objective_shrinking_completed" );
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0xe231b2e4, Offset: 0x6cd8
// Size: 0xe7
function private function_c127e2c7333fb19a( player )
{
    interact = self;
    interact notify( #"valid_use", player );
    
    if ( isdefined( interact.var_4ee47160354594d1 ) )
    {
        [[ interact.var_4ee47160354594d1 ]]( player, interact.custom_data );
    }
    
    if ( interact.var_b749fae11a9dc28d )
    {
        waypoint_objective_handler::waypoint_objective_handler_cancel( interact.var_b749fae11a9dc28d, { #squad:interact.var_cd7e11dc688992d4.sessionsquadid, #team:interact.var_cd7e11dc688992d4.team } );
    }
    
    interact.var_cd7e11dc688992d4.interacts = arrayremove( interact.var_cd7e11dc688992d4.interacts, interact );
    interact delete();
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x9ca03915, Offset: 0x6dc7
// Size: 0xf5
function private function_351dcb154f801030( var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 )
{
    if ( !var_cd7e11dc688992d4.uplinkprops )
    {
        uplinkprops = { #captureradius:getdvarint( @"scr_uplink_capture_radius", 5000 ) };
        uplinkprops.trigger = spawn( "trigger_radius", ( 12320, -29098, 4000 ), 0, int( uplinkprops.captureradius ), int( uplinkprops.captureradius ) );
        uplinkprops.objidnum = objective_marker_bundle_helper::function_d98e9d627f2d8c28( "sat_ob_objectivemarker_location" );
        objidpoolmanager::objective_show_progress( uplinkprops.objidnum, 1 );
        objidpoolmanager::objective_playermask_hidefromall( uplinkprops.objidnum );
        childthread function_9f61ff54b916b09( uplinkprops.trigger, uplinkprops.captureradius, var_cd7e11dc688992d4 );
        var_cd7e11dc688992d4.uplinkprops = uplinkprops;
    }
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0x5648f4bb, Offset: 0x6ec4
// Size: 0x1cd
function private function_84795ee591f87a39( var_64bb57aa2d6e8b35, var_cd7e11dc688992d4, var_d29e179bdca0f7a4, uplink_position )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    var_cd7e11dc688992d4 endon( #"hash_4edb024e3b7a0280" );
    uplinkprops = var_cd7e11dc688992d4.uplinkprops;
    current_progress = 0;
    
    if ( var_d29e179bdca0f7a4 <= 0 )
    {
        assertmsg( "<dev string:x1d9>" );
        var_d29e179bdca0f7a4 = 20;
    }
    
    objidpoolmanager::update_objective_position( uplinkprops.objidnum, uplink_position );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        objidpoolmanager::objective_playermask_addshowplayer( uplinkprops.objidnum, player );
    }
    
    var_cd7e11dc688992d4.var_20761627f257112b = 1;
    
    while ( true )
    {
        if ( uplinkprops.trigger.nearbyplayers.size > 0 )
        {
            current_progress += level.framedurationseconds;
            objidpoolmanager::objective_set_progress( uplinkprops.objidnum, clamp( current_progress / var_d29e179bdca0f7a4, 0, 1 ) );
            
            if ( current_progress >= var_d29e179bdca0f7a4 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    var_cd7e11dc688992d4.var_20761627f257112b = 0;
    objidpoolmanager::objective_playermask_hidefromall( uplinkprops.objidnum );
    objidpoolmanager::objective_set_progress( uplinkprops.objidnum, 0 );
    var_cd7e11dc688992d4 notify( #"hash_4edb024e3b7a0280" );
}

// Namespace ob_activity_sagittarius
// Params 6, eflags: 0x4
// Checksum 0xb2b415f7, Offset: 0x7099
// Size: 0xbd
function private function_e18f7c477c480f05( encounter_volume_targetname, var_cd7e11dc688992d4, agent_spawned_callback, var_65ed4da14b74c42d, var_780e15b4386ea440, var_829ddd8b0b1fabff )
{
    requestid = ai_spawn_director::lookup_spawn_request( encounter_volume_targetname );
    
    if ( isdefined( requestid ) )
    {
        data = function_9b649316adcccbaa( requestid );
        
        if ( data.status == 1 )
        {
            if ( agent_spawned_callback )
            {
                ai_spawn_director::add_spawned_callback( requestid, agent_spawned_callback, var_cd7e11dc688992d4 );
            }
            
            if ( var_65ed4da14b74c42d )
            {
                ai_spawn_director::function_53289c032f506bb1( requestid, var_65ed4da14b74c42d, var_cd7e11dc688992d4 );
            }
            
            if ( var_780e15b4386ea440 )
            {
                ai_spawn_director::function_c99d360d62c49a9c( requestid, var_780e15b4386ea440, var_cd7e11dc688992d4 );
            }
            
            if ( var_829ddd8b0b1fabff )
            {
                ai_spawn_director::function_5a08798970350207( requestid, var_829ddd8b0b1fabff, var_cd7e11dc688992d4 );
            }
            
            function_ef57f478f96b050c( requestid, 1 );
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0x88c77015, Offset: 0x715e
// Size: 0xd8
function private function_969d00de63f249ed( requestid, var_cd7e11dc688992d4, agent, var_1e29e18b1e9a4ba0 )
{
    data = function_9b649316adcccbaa( requestid );
    
    if ( data && isagent( agent ) )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        
        if ( var_64bb57aa2d6e8b35.players )
        {
            closest_player = function_47c86977a18df38b( var_64bb57aa2d6e8b35.players, agent.origin );
            agent getenemyinfo( closest_player );
            agent forcethreatupdate();
            agent function_fa32376aaa88a7a2( data.origin, data.radius );
        }
    }
    
    level notify( #"hash_8ed2370d7398bf76" );
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0x8e527982, Offset: 0x723e
// Size: 0x81
function private function_d0fbd932a6b15efe( requestid, var_cd7e11dc688992d4, agent, var_1e29e18b1e9a4ba0 )
{
    owner = utility::spawn_tag_origin( agent.origin, agent.angles );
    owner.team = "team_hundred_ninety";
    setupstruct = { #timeout_disabled:1 };
    agent dawg::dawgpostinit( owner, setupstruct );
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xa8be1d45, Offset: 0x72c7
// Size: 0x21, Type: bool
function private function_2662ac8a9e548247( requestid, var_cd7e11dc688992d4 )
{
    return level.var_9ff6ee3074298a7.size == 0;
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x8408ac79, Offset: 0x72f1
// Size: 0x34, Type: bool
function private function_6a21247ea8d6dd7b( requestid, var_cd7e11dc688992d4 )
{
    if ( var_cd7e11dc688992d4.var_ededefb170ca915f )
    {
        var_cd7e11dc688992d4.var_ededefb170ca915f = 0;
        return true;
    }
    
    return false;
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xe82861a6, Offset: 0x732e
// Size: 0x23
function private function_9b7c6d0051d6996c( requestid, var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4.var_c682d4f5f34090b8 = 1;
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0xcf704b60, Offset: 0x7359
// Size: 0xa0
function private function_149de59b4a4b0b13( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    level endon( #"game_ended" );
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    hostiles_alert_vo_struct = namespace_bbbb94f0356653a2::function_3a6b015435485777( [ "hostiles_alert_1", "hostiles_alert_2", "hostiles_alert_3", "hostiles_alert_4" ] );
    
    while ( true )
    {
        level waittill( #"hash_8ed2370d7398bf76" );
        thread namespace_bbbb94f0356653a2::function_b3c7509b373055bc( hostiles_alert_vo_struct, var_64bb57aa2d6e8b35.players, 5 );
        wait 15;
    }
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x81c9d2a5, Offset: 0x7401
// Size: 0xda
function private function_5818be31fe9030f5( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    thread function_2a6ba541e258c5( var_cd7e11dc688992d4, ( 12056, -29494, 4410 ), 600, "sag_stronghold_entered" );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "sag_stronghold_entered" );
    childthread overlord::playevent( "find_the_main_terminal", var_64bb57aa2d6e8b35.players );
    childthread namespace_bbbb94f0356653a2::function_f19b17747f2036c4( [ "nag_find_server_1" ], 35, 50, "sag_rfid_reached", var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    thread function_2a6ba541e258c5( var_cd7e11dc688992d4, level.sag_rfid_reader.origin, 200, "sag_rfid_reached" );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "sag_rfid_reached" );
    childthread overlord::playevent( "heres_the_terminal", var_64bb57aa2d6e8b35.players );
    childthread namespace_bbbb94f0356653a2::function_f19b17747f2036c4( [ "nag_use_card_1" ], 35, 50, "sag_rfid_used", var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
}

// Namespace ob_activity_sagittarius
// Params 2, eflags: 0x4
// Checksum 0x3904d84f, Offset: 0x74e3
// Size: 0x149
function private function_27fea7e9d7a25cd2( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    while ( true )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            ai_array = getaiarrayinradius( player.origin, 400 );
            
            foreach ( ai in ai_array )
            {
                if ( isalive( ai ) && ai.type != "zombie" )
                {
                    thread overlord::playconversation( "im_starting_to_think", var_64bb57aa2d6e8b35.players );
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0xf94fcc7a, Offset: 0x7634
// Size: 0x132
function private function_9f61ff54b916b09( trigger, radius, var_cd7e11dc688992d4 )
{
    level endon( #"game_ended" );
    trigger endon( #"delete" );
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    trigger.nearbyplayers = [];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( trigger.nearbyplayers, player ) || !arraycontains( var_64bb57aa2d6e8b35.players, player ) )
        {
            continue;
        }
        
        if ( var_cd7e11dc688992d4.var_20761627f257112b )
        {
            objidpoolmanager::objective_playermask_addshowplayer( var_cd7e11dc688992d4.uplinkprops.objidnum, player );
        }
        
        trigger.nearbyplayers[ trigger.nearbyplayers.size ] = player;
        thread function_fbb8372480114be4( trigger, player, radius, var_cd7e11dc688992d4 );
    }
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0xf6b1a4c7, Offset: 0x776e
// Size: 0x116
function private function_fbb8372480114be4( trigger, player, radius, var_cd7e11dc688992d4 )
{
    trigger endon( #"delete" );
    player endon( #"disconnect" );
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    
    while ( isalive( player ) && isdefined( trigger ) && distancesquared( trigger.origin, player.origin ) < radius * radius )
    {
        wait 0.2;
    }
    
    trigger.nearbyplayers = arrayremove( trigger.nearbyplayers, player );
    
    if ( trigger.nearbyplayers.size < 0 )
    {
        level thread overlord::playevent( "players_leave_server_radius", teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid ).players );
    }
    
    objidpoolmanager::objective_playermask_hidefrom( var_cd7e11dc688992d4.uplinkprops.objidnum, player );
}

// Namespace ob_activity_sagittarius
// Params 1
// Checksum 0x453e5ec1, Offset: 0x788c
// Size: 0x5c
function function_38cceab373548cbc( var_cd7e11dc688992d4 )
{
    if ( !isdefined( var_cd7e11dc688992d4.spawned_bots ) )
    {
        var_cd7e11dc688992d4.spawned_bots = [];
    }
    
    var_b019719ed237b270 = utility::getstructarray( "hack_ambush_guildbot_spawnpoint", "targetname" );
    var_cd7e11dc688992d4.spawned_bots = story_contract_util::spawn_bots_folded( var_b019719ed237b270, "sag_ambush" );
}

// Namespace ob_activity_sagittarius
// Params 1
// Checksum 0xd35b7a00, Offset: 0x78f0
// Size: 0x8e
function sag_activate_bots( var_cd7e11dc688992d4 )
{
    wait 3;
    
    foreach ( bot in var_cd7e11dc688992d4.spawned_bots )
    {
        bot notify( #"sag_ambush" );
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x2aaeee1a, Offset: 0x7986
// Size: 0x10b
function private function_cdfe39187377b8f3( var_cd7e11dc688992d4 )
{
    vtol_trigger = getent( "sag_intro_vtol_trigger", #targetname );
    
    if ( vtol_trigger )
    {
        vtol_spawns = utility::getstructarray( "sag_intro_vtol_spawn", "script_noteworthy" );
        vtol_trigger waittill( #"trigger" );
        
        if ( level.var_80cdaf8fb770f0de )
        {
            return;
        }
        
        level.var_80cdaf8fb770f0de = 1;
        thread function_1d4b6c5210de7862();
        
        foreach ( vtol_spawn in vtol_spawns )
        {
            if ( vtol_spawn.targetname )
            {
                var_cd7e11dc688992d4 childthread ob_story_mission_utils::function_273dfd9583646854( vtol_spawn.targetname, undefined, 0, 0, 150, 180, 0, 80, 40 );
            }
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x9b10188, Offset: 0x7a99
// Size: 0xf
function private function_1d4b6c5210de7862()
{
    wait 20;
    level.var_80cdaf8fb770f0de = 0;
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x16e482cc, Offset: 0x7ab0
// Size: 0x362
function private sagittarius_music( mission )
{
    level endon( #"game_ended" );
    self notify( #"hash_89a7d04b767c4897" );
    self endon( #"hash_89a7d04b767c4897" );
    mission endon( #"reset" );
    squad = self;
    assert( snd::issquad( squad ) );
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    
    if ( !arraycontains( [ "sag_intro", "sag_mini_boss", "sag_stronghold" ], var_950c5eed6692bff6.ddl_bit ) )
    {
        return;
    }
    
    mission waittill( #"sag_give_loadout" );
    waittillframeend();
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    assert( isstruct( var_950c5eed6692bff6 ) && isstring( var_950c5eed6692bff6.ddl_bit ) );
    
    switch ( var_950c5eed6692bff6.ddl_bit )
    {
        case #"hash_501f528366644f2b":
        default:
            level utility::flag_wait( "ob_infil_completed" );
            mission waittill( #"sagittarius_intro_bink_complete" );
            snd_ob::squad_music( squad, "underscore_oneshots_a" );
        case #"hash_8860c431a3c394d4":
            story_contract_util::function_800aae15896dfec6( squad.players, #"sag_mini_boss" );
            
            if ( getdvarint( @"hash_377c5b80178d41f1", 0 ) < 1 )
            {
                mission utility::ent_flag_wait( "investigation_waypoint_reached" );
                wait 1.2;
                snd_ob::squad_music_with_cut( squad, "mx_avalon_contract_fail_e", -30, 155, 1, 16, 8 );
                mission waittill( #"hash_62cef73c0e699b02" );
            }
            
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_f_lp", 5, 120, 12, 24, 24 );
            mission utility::ent_flag_wait( "hologram_scanned" );
            mission waittill( #"hash_8b447625fbb572ca" );
            snd_ob::squad_music_stop( squad );
            wait 2;
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_c_lp", 4, 110, 17, 32, 32 );
            mission waittill( #"boss_fight_completed", var_3168f7303670a541, corpse_angles );
            snd_ob::squad_music_stop( squad );
            mission waittill( #"keycard_acquired", keycard_player );
            wait 0.8;
            snd_ob::squad_music( squad, "mx_avalon_contract_accept_c" );
        case #"hash_3e23d6343e1cd2e5":
            story_contract_util::function_800aae15896dfec6( squad.players, #"sag_stronghold" );
            trigger_radius = spawn( "trigger_radius", ( 12000, -30000, 1800 ), 0, 5200, 6000 );
            trigger_radius snd::waittill_squad_trigger( squad );
            trigger_radius delete();
            trigger_radius = undefined;
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_c_lp", 4, 90, 2, 32, 48 );
            mission waittill( #"sag_rfid_used" );
            mission waittill( #"sag_spike_planted" );
            snd_ob::squad_music( squad, "mx_avalon_combat_b_lp" );
            mission waittill( #"hash_4b19242711a637ce" );
            wait 1.33333;
            snd_ob::squad_music( squad, "mx_avalon_contract_accept_b" );
            break;
    }
}

/#

    // Namespace ob_activity_sagittarius
    // Params 0
    // Checksum 0xdd810fb3, Offset: 0x7e1a
    // Size: 0x5, Type: dev
    function function_bc361a72e83df6c9()
    {
        
    }

#/

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0xfda0e34d, Offset: 0x7e27
// Size: 0x5b
function private function_3263181e5e21e7ff( var_cd7e11dc688992d4, drone, spawn_options )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    drone waittill( #"death" );
    is_main_drone = drone ob_flying_drone::is_main_drone();
    thread spawn_drone( var_cd7e11dc688992d4, 60, is_main_drone, spawn_options );
}

// Namespace ob_activity_sagittarius
// Params 4, eflags: 0x4
// Checksum 0xf0a53e56, Offset: 0x7e8a
// Size: 0xca
function private spawn_drone( var_cd7e11dc688992d4, delay_time, is_main_drone, spawn_options )
{
    drone = undefined;
    wait delay_time;
    
    if ( is_main_drone )
    {
        drone = ob_flying_drone::function_d664e23d9508b462( spawn_options );
        drone ob_flying_drone::function_e0de4dce57ae487();
        drone thread ob_flying_drone::function_dbc3536438aea5e0();
        drone thread ob_flying_drone::drone_movebehavior();
        drone thread function_c2a1a725ce145532();
        
        /#
            drone thread ob_flying_drone::function_5fc6b44c9edd444a();
        #/
    }
    else
    {
        drone = ob_flying_drone::spawn_helper_drone( spawn_options.var_cdffe119ed60d14d, [ spawn_options.spawnpos ], spawn_options.target, spawn_options );
    }
    
    if ( drone && spawn_options.respawn_on_death )
    {
        thread function_3263181e5e21e7ff( var_cd7e11dc688992d4, drone, spawn_options );
    }
    
    return drone;
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x7e94deb3, Offset: 0x7f5d
// Size: 0x3e
function private function_c2a1a725ce145532()
{
    self endon( #"main_drone_destroyed" );
    self endon( #"orb_cleaned_up" );
    self endon( #"death" );
    utility::waittill_any( "drone_first_damage", "player_scanned" );
    thread function_626c84bb868d8100();
}

// Namespace ob_activity_sagittarius
// Params 0, eflags: 0x4
// Checksum 0x94d684e2, Offset: 0x7fa3
// Size: 0x78
function private function_626c84bb868d8100()
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone endon( #"orb_cleaned_up" );
    drone endon( #"death" );
    drone ob_flying_drone::function_b62d57c03a13139d();
    drone utility::waittill_any_timeout( drone.var_4922a62c04b53c20, "engage_phase" );
    drone ob_flying_drone::function_5366327c25ea5eb2();
    level.var_4e5b26fefe68335e thread ob_flying_drone::function_6395a1838cd983f5( drone, "turret" );
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0xd5137612, Offset: 0x8023
// Size: 0x1c0
function private function_13259fcdad7a338e( var_cd7e11dc688992d4 )
{
    level.doorstrings[ "locked_no_key" ][ "sag_stronghold_door" ] = &"sat_ob_activities/contract_sag_stronghold_door_locked";
    door_root = utility::getstruct( "sag_stronghold_door_root", "targetname" );
    stronghold_doors = getentitylessscriptablearray( undefined, undefined, door_root.origin, door_root.radius, "door" );
    lock_requests = utility::getstructarray( "sag_stronghold_locked_door", "targetname" );
    
    foreach ( request in lock_requests )
    {
        door_scriptables = [];
        door_scriptables = namespace_2745d12b842cc671::function_f4d67875159a0119( request, door_scriptables, "sag_stronghold_door", 0, 1, stronghold_doors, 150 );
        
        foreach ( door in door_scriptables )
        {
            if ( arraycontains( var_cd7e11dc688992d4.stronghold_locked_doors, door ) )
            {
                continue;
            }
            
            thread function_1fa87feb84f73c9( var_cd7e11dc688992d4, door, request );
            var_cd7e11dc688992d4.stronghold_locked_doors = arraycombineunique( var_cd7e11dc688992d4.stronghold_locked_doors, [ door ] );
        }
    }
}

// Namespace ob_activity_sagittarius
// Params 3, eflags: 0x4
// Checksum 0x9f2c9417, Offset: 0x81eb
// Size: 0x15e
function private function_1fa87feb84f73c9( var_cd7e11dc688992d4, door, door_lock_request )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    level endon( #"game_ended" );
    
    if ( !isdefined( door.var_ff2df1cef4017193 ) )
    {
        door.var_ff2df1cef4017193 = 0;
    }
    
    if ( door.var_ff2df1cef4017193 > 0 )
    {
        door.var_ff2df1cef4017193++;
        return;
    }
    
    door scriptabledoorclose();
    
    while ( !door scriptabledoorisclosed() )
    {
        waitframe();
    }
    
    vehicles = vehicle_getarrayinradius( door.origin, 200 );
    
    foreach ( vehicle in vehicles )
    {
        vehicle.dontspawnhusk = 1;
        thread vehicle::death( vehicle );
    }
    
    door.keyname = "sag_stronghold_door";
    door scriptabledoorlock();
    door.locked = 1;
    door.var_ff2df1cef4017193++;
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x469aa689, Offset: 0x8351
// Size: 0x87
function private function_7cef2b2e178f316( var_cd7e11dc688992d4 )
{
    foreach ( door in var_cd7e11dc688992d4.stronghold_locked_doors )
    {
        sag_unlock_door( door );
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x875cd472, Offset: 0x83e0
// Size: 0x2b
function private sag_unlock_door( door )
{
    if ( door function_4f79c45e0fd47b7f() )
    {
        namespace_2745d12b842cc671::unlockscriptabledoor( door );
        door.locked = 0;
    }
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0x31571fc, Offset: 0x8413
// Size: 0xc4
function private function_eee59895c53d92a0( var_cd7e11dc688992d4 )
{
    foreach ( door in var_cd7e11dc688992d4.stronghold_locked_doors )
    {
        if ( door.var_ff2df1cef4017193 == 1 )
        {
            sag_unlock_door( door );
        }
        
        door.var_ff2df1cef4017193 = max( door.var_ff2df1cef4017193 - 1, 0 );
    }
    
    var_cd7e11dc688992d4.stronghold_locked_doors = [];
}

// Namespace ob_activity_sagittarius
// Params 1, eflags: 0x4
// Checksum 0xc500a6ca, Offset: 0x84df
// Size: 0xb7
function private function_cddb50034003950e( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    
    if ( getdvarint( @"hash_71f9d7fe7576e5c8", 0 ) )
    {
        return;
    }
    
    utility::flag_wait( "sag_cs_init_complete" );
    
    if ( !getdvarint( @"hash_1b7e9f422c8375e4", 0 ) )
    {
        if ( !isdefined( level.sag_oob_volumes ) )
        {
            level.sag_oob_volumes = getnoentvolumearray( "sag_oob_volume", #targetname );
        }
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    childthread story_contract_util::function_cddb50034003950e( var_64bb57aa2d6e8b35, level.sag_oob_volumes );
}

/#

    // Namespace ob_activity_sagittarius
    // Params 1, eflags: 0x4
    // Checksum 0x5de98c78, Offset: 0x859e
    // Size: 0x6f, Type: dev
    function private function_d8fee8117384959a( player )
    {
        player endon( #"disconnect" );
        buttondown = 0;
        
        while ( true )
        {
            if ( player buttonpressed( "<dev string:x229>" ) )
            {
                if ( !buttondown )
                {
                    if ( !level.player )
                    {
                        level.player = player;
                    }
                    
                    benchmark_mp_utils::function_6cf247353c5bcf3();
                }
                
                buttondown = 1;
            }
            else
            {
                buttondown = 0;
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_sagittarius
    // Params 1, eflags: 0x4
    // Checksum 0x2055a5bb, Offset: 0x8615
    // Size: 0x281, Type: dev
    function private function_518eee3bd007cea9( params )
    {
        level notify( #"hash_a74718855eb44491" );
        level endon( #"hash_a74718855eb44491" );
        
        if ( !level.players[ 0 ] )
        {
            return;
        }
        
        level.players[ 0 ] endon( #"disconnect" );
        area_index = int( params[ 0 ] );
        var_17011eaaeed2dd22 = int( params[ 1 ] );
        locations = level.var_326b134b5d097db8[ area_index ].var_5b37ae8285315e61[ var_17011eaaeed2dd22 ];
        
        foreach ( location in locations )
        {
            agent = dospawnaitype( "<dev string:x22f>", location.origin, location.angles, 0, 0, 1, 0, "<dev string:x243>" );
            waitframe();
            origin = ob_activity_sagittarius_sniper_boss::function_4590e1d8b89b0fdf( location.origin, agent );
            agent forceteleport( origin, location.angles, 100000 );
            agent ai::set_death_function( &ob_activity_sagittarius_sniper_boss::boss_death_function );
            agent.deathanimmode = "<dev string:x257>";
            agent.noragdoll = 1;
            agent.ignoreall = 1;
            agent.health = 10;
            agent.allowlongdeath = 0;
            agent enabletraversals( 0 );
            agent utility::set_movement_speed( 0 );
            agent.scripted_mode = 1;
            agent.ignoreme = 1;
            level.players[ 0 ] setorigin( location.origin );
            agent waittill( #"death" );
            [ var_3168f7303670a541, corpse_angles ] = function_a387c7ed9820a793( agent, 90 );
            
            while ( !level.players[ 0 ] buttonpressed( "<dev string:x261>" ) )
            {
                printtoscreen2d( 600, 300, "<dev string:x267>", ( 1, 0, 0 ), 1.5, 1 );
                waitframe();
            }
        }
    }

    // Namespace ob_activity_sagittarius
    // Params 1, eflags: 0x4
    // Checksum 0x6acce005, Offset: 0x889e
    // Size: 0x3df, Type: dev
    function private function_462e71b64ad07c87( params )
    {
        level notify( #"hash_19c598a6a9e30bad" );
        level endon( #"hash_19c598a6a9e30bad" );
        
        if ( !level.players[ 0 ] )
        {
            return;
        }
        
        level.players[ 0 ] endon( #"disconnect" );
        area_index = int( params[ 0 ] );
        var_17011eaaeed2dd22 = int( params[ 1 ] );
        is_auto_test = int( params[ 2 ] );
        locations = level.var_326b134b5d097db8[ area_index ].var_5b37ae8285315e61[ var_17011eaaeed2dd22 ];
        debug_name = level.var_326b134b5d097db8[ area_index ].debug_targetnames[ var_17011eaaeed2dd22 ];
        var_cd7e11dc688992d4 = level.var_2d8511c2818cdd93[ level.players[ 0 ].sessionsquadid ];
        
        if ( level.var_67b34813a92818bc && level.var_67b34813a92818bc != -1 )
        {
            function_9c33c17f1c093741( level.var_67b34813a92818bc );
            level.var_67b34813a92818bc = undefined;
        }
        
        file_id = -1;
        var_35e23ee0e0bed49b = 1;
        
        if ( is_auto_test )
        {
            file_name = "<dev string:x282>" + debug_name + "<dev string:x28c>" + getsystemtime() + "<dev string:x28e>";
            folder_name = "<dev string:x293>";
            file_id = function_b70280649f0c0c0d( file_name, "<dev string:x2a3>", folder_name );
            level.var_67b34813a92818bc = file_id;
            var_35e23ee0e0bed49b = int( benchmark_mp_utils::function_dc6ca849abef4a37( level.players[ 0 ], "<dev string:x2a9>", 1, 1000, 0 ) );
        }
        
        for ( index = 0; index < var_35e23ee0e0bed49b ; index++ )
        {
            if ( file_id != -1 )
            {
                function_ca002d660d981cd( file_id, "<dev string:x2cb>" + index + 1 + "<dev string:x2d2>" + debug_name );
            }
            
            foreach ( location in locations )
            {
                start_time = gettime();
                angles = ( 0, randomintrange( 0, 361 ), 0 );
                origin = ob_activity_sagittarius_sniper_boss::function_4590e1d8b89b0fdf( location.origin, level.players[ 0 ] );
                [ hologram, success ] = level.players[ 0 ] ob_activity_sagittarius_sniper_boss::deploy_hologram( var_cd7e11dc688992d4, origin, angles, 0 );
                end_time = gettime();
                level.players[ 0 ] setorigin( origin );
                
                if ( !is_auto_test )
                {
                    while ( !level.players[ 0 ] buttonpressed( "<dev string:x261>" ) )
                    {
                        printtoscreen2d( 600, 300, "<dev string:x267>", ( 1, 0, 0 ), 1.5, 1 );
                        waitframe();
                    }
                    
                    while ( level.players[ 0 ] buttonpressed( "<dev string:x261>" ) )
                    {
                        waitframe();
                    }
                }
                
                hologram thread combat_hologram::combatholo_destroy( undefined, 1 );
                
                if ( file_id != -1 )
                {
                    function_ca002d660d981cd( file_id, ( success ? "<dev string:x2d6>" : "<dev string:x2e0>" ) + "<dev string:x2ea>" + origin + "<dev string:x2f4>" + angles + "<dev string:x2fe>" + ( end_time - start_time ) / 1000 + "<dev string:x30c>" );
                }
            }
            
            if ( file_id != -1 )
            {
                function_ca002d660d981cd( file_id, "<dev string:x30e>" );
            }
        }
        
        if ( file_id != -1 )
        {
            function_de6ee02f9fb0e262( folder_name + "<dev string:x6d>" + file_name );
            function_9c33c17f1c093741( file_id );
        }
    }

#/
