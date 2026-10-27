// scripts\mp\gametypes\ob_gametype_story_mission.gsc  (hash_402f53cf5a70b357.gscc) (size: 22115 Bytes / 0x5663 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa921f3ef (2837574639)
// size ...... 22115 (0x5663)
// includes .. 31  (offset: 0x51ab)
// strings ... 49  (offset: 0x52a3)
// dev strs .. 18  (offset: 0x5587)
// exports ... 64  (offset: 0x30b3)
// cseg ...... 0x430 + 0x2c83 (0x30b3)
// imports ... 192 (offset: 0x3ab3)
// animtree1 . 0   (offset: 0x5663)
// animtree2 . 0   (offset: 0x5663)
#using script_16ea1b94f0f381b3;
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using script_7eb3c0a46440cc6c;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\dialogue_speaker;
#using scripts\common\save;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\elim;
#using scripts\mp\gametypes\ob;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;
#using scripts\mp\telemetry_coop;

#namespace ob_gametype_story_mission;

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x79ee24d, Offset: 0x44e
// Size: 0x20b
function main()
{
    function_5e3806c5d39995e2();
    level.var_539c069e9c881d35 = &init;
    level.var_4ff066f519fa9449 = &function_32114e935f496880;
    level.var_10459e4184c44ea4 = &function_82b7113c91892e85;
    level.var_b3e0b38145c782a3 = &function_effb274e1e64bcfc;
    level.var_1885dec6f8399bd0 = &function_22985587ffdd1a68;
    level.var_c57ff57d8b66d391 = 1;
    level thread init();
    level.var_6488d1fb560a08fb = function_9f1e246e38a43444();
    level.var_91466c5be0885e53 = 1;
    ob::main();
    
    /#
        level.var_8b324f76eefee199 = &function_a218cde1c6260be2;
        level.var_b6c6978dacab8f7b = &function_23e93443efaab71e;
    #/
    
    utility::registersharedfunc( #"coop", #"hash_ef677de46ca0c35", &function_4ed8e794289fc666 );
    utility::registersharedfunc( #"coop", #"hash_c28de838cda2f4da", &function_4cded001aa8458fb );
    
    if ( ( level.var_bb86f77304f193c4.var_6708d7a570f5945b ?? "MissionFail" ) != "MissionFail" )
    {
        level.onsquadeliminated = &function_1fb9ccca3958dbb2;
    }
    
    level.var_9a7facf0cbad27fd = &function_9142baea1cccc1ed;
    level callback::callback( #"register_activity_variant_definitions" );
    
    /#
        level thread ob_story_mission_dev::function_4e8cfeac80565812();
    #/
    
    thread telemetry_coop::init();
    callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"hash_4e0cfe1df091e586", &function_e48ca021c27d049d );
    activity_common::function_2dd4f07fa5c3e911( "ActivityBegin", &function_d75c7c1c7a10b8f1 );
    level elim::function_1bd2057248452f5e( 1 );
    level init_squad_size_scaling();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_346e2100fa4e4a03", &function_23e93443efaab71e );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_47760e45e98451fc", &function_e01fa1da504c3b9a );
    level.allowfauxdeath = 0;
    utility::registersharedfunc( #"ob_gametype_story_mission", #"hash_b065bf3f05c1b1e2", &function_5bfc61f98c2501a5 );
    level.var_ddb0652fbf187f6e = 1;
    level.onplayerconnect = &function_4e45995586ddbe38;
    setdvarifuninitialized( @"hash_230131298ecf6660", 2000 );
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xcf93c29d, Offset: 0x661
// Size: 0x30
function private function_22985587ffdd1a68( params )
{
    level.infilcompleted = 1;
    level utility::flag_set( "ob_infil_completed" );
    callback::callback( "on_ob_infil_complete" );
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xee5fd107, Offset: 0x699
// Size: 0x46
function private function_4e45995586ddbe38( player )
{
    assert( isplayer( player ), "<dev string:x24>" );
    ob::onplayerconnect( player );
    player setclientdvar( @"ui_opensummary", getdvarint( @"hash_b96228242dc09e3e", 0 ) );
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x30db7d5d, Offset: 0x6e7
// Size: 0x23, Type: bool
function private ob_story_mission_activity_name()
{
    return level.activity_array[ level.activity_index ][ "activity_name" ] ?? "<unknown>";
}

// Namespace ob_gametype_story_mission/event_c91584356d5d4265
// Params 0, eflags: 0x20
// Checksum 0x43e55c1f, Offset: 0x713
// Size: 0x24
function event_handler[event_c91584356d5d4265] function_a8aa6906b5ff9d68()
{
    activityname = ob_story_mission_activity_name();
    function_a3c0c640dcc68f63( #"activity", activityname );
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x684622dd, Offset: 0x73f
// Size: 0xd4
function private function_5e3806c5d39995e2()
{
    setdvar( @"hash_9bb82c2a874ffc6d", 1 );
    setdvar( @"hash_97016f0844118818", 0 );
    setdvar( @"ai_spawn_director_dynamic_ambient_encounters", 0 );
    setdvar( @"hash_c5a52a0ae6ed1529", 2000 );
    setdvar( @"hash_c69456bc853363e0", 1 );
    setdvarifuninitialized( @"hash_550484f2b30cf121", 1 );
    setdvarifuninitialized( @"hash_1661f35e34f544eb", 1 );
    setdvar( @"hash_2fe0283b419ff08a", 1 );
    setdvar( @"g_clientfirewhileinvisiblekicksplayer", 0 );
    setdvarifuninitialized( @"hash_4af72e5b55859fa9", 1 );
    
    /#
        devtimelimit = getdvarint( @"scr_devchangetimelimit", -1 );
        
        if ( devtimelimit < 0 )
        {
            setdevdvar( @"scr_devchangetimelimit", 0 );
        }
    #/
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x158750b6, Offset: 0x81b
// Size: 0xac
function private function_9f1e246e38a43444()
{
    map_name = level.mapinfobundle.mapname;
    
    if ( isdefined( map_name ) )
    {
        switch ( map_name )
        {
            case #"hash_fb5b52497f18b4f2":
                return "leo_launch";
            case #"hash_aa57751870ed56c8":
                return "aries_launch";
            case #"hash_155fc6a1623fc995":
                return "capricorn_launch";
            case #"hash_73a439379493fc99":
                return "virgo_launch";
            case #"hash_81327b83385c34a5":
                return "gemini_launch";
            case #"hash_4d2fb3330f72cfb4":
                return "libra_launch";
            default:
                break;
        }
    }
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0xf07a400c, Offset: 0x8cf
// Size: 0x1a
function init()
{
    /#
        adddebugcommand( "<dev string:x4a>" );
    #/
    
    self.var_8afd2d97bc4003e4 = 1;
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0x1ae31659, Offset: 0x8f1
// Size: 0x15
function player_loadout_save( save_field_name )
{
    ob_story_mission_utils::player_loadout_save( save_field_name );
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0xd5adf57a, Offset: 0x90e
// Size: 0x1b
function function_4ed8e794289fc666()
{
    assert( isplayer( self ) );
    thread player_loadout_save( "ob_sm_checkpoint_loadout" );
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x4acd5d16, Offset: 0x931
// Size: 0x4d
function function_4cded001aa8458fb()
{
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    restoredloadout = save::player_get_data( "ob_sm_checkpoint_loadout" );
    
    if ( isdefined( restoredloadout ) )
    {
        ob_story_mission_utils::load_player_loadout( self, restoredloadout );
        self.var_b8cfeb206bb587fc = 1;
    }
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x55502206, Offset: 0x986
// Size: 0x1b
function function_79b85152b04adf1f()
{
    assert( isplayer( self ) );
    thread player_loadout_save( "ob_sm_checkpoint_laststand" );
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0xb3d84c6d, Offset: 0x9a9
// Size: 0x48
function function_58db9c7cee228798()
{
    assert( isplayer( self ) );
    restoredloadout = save::player_get_data( "ob_sm_checkpoint_laststand" );
    
    if ( !isdefined( restoredloadout ) )
    {
        restoredloadout = save::player_get_data( "ob_sm_checkpoint_loadout" );
    }
    
    if ( isdefined( restoredloadout ) )
    {
        ob_story_mission_utils::load_player_loadout( self, restoredloadout );
    }
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x24cc0bb1, Offset: 0x9f9
// Size: 0xd7
function function_bdac21d30de781da()
{
    assert( isplayer( self ) );
    var_850001ba16258e16 = 1;
    a_squad_players = squad_utility::getsquadmembers();
    a_squad_players = function_5713d46873b29625( a_squad_players );
    
    foreach ( player in a_squad_players )
    {
        if ( isalive( player ) && player.sessionstate == "playing" )
        {
            if ( player.game_extrainfo & 256 )
            {
                continue;
            }
            
            var_850001ba16258e16 = 0;
            break;
        }
    }
    
    return var_850001ba16258e16;
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xb7608e16, Offset: 0xad9
// Size: 0x314, Type: bool
function private function_32114e935f496880()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2.14748e+09, -2.14748e+09, -2.14748e+09 );
    level.squadspawnpointsets = [];
    ground_trace_start_height = 100;
    ground_trace_drop_height = 100;
    ground_trace_radius = 32;
    ob_player_spawn_classname = "mp_ob_spawn_start";
    start_activity = toupper( start_activity_get() );
    have_start_activity = start_activity != "" && start_activity != "UNDEFINED";
    var_afd5a968e27dae5f = getspawnarray( ob_player_spawn_classname );
    squadspawnpoints = [];
    var_38661a89fb25fc54 = level.mapinfobundle.productionmap && issubstr( level.mapinfobundle.gametypes ?? "", "story" );
    
    foreach ( spawnpoint in var_afd5a968e27dae5f )
    {
        level.spawnmins = spawnlogic::expandmins( level.spawnmins, spawnpoint.origin );
        level.spawnmaxs = spawnlogic::expandmaxs( level.spawnmaxs, spawnpoint.origin );
        
        if ( have_start_activity && spawnpoint.script_noteworthy != start_activity )
        {
            continue;
        }
        
        if ( !playerlogic::is_water_spawn( spawnpoint.origin ) )
        {
            v_ground = getgroundposition( spawnpoint.origin, ground_trace_radius, ground_trace_drop_height, ground_trace_start_height );
            
            if ( v_ground && spawnpoint.origin[ 2 ] < v_ground[ 2 ] )
            {
                spawnpoint.v_original_origin = spawnpoint.origin;
                spawnpoint.origin = v_ground;
            }
            else if ( var_38661a89fb25fc54 && ( !v_ground || v_ground && spawnpoint.origin[ 2 ] > v_ground[ 2 ] && spawnpoint.origin[ 2 ] - v_ground[ 2 ] >= ground_trace_drop_height ) )
            {
                assertmsg( "<dev string:x61>" + start_activity + "<dev string:x63>" + spawnpoint.origin );
            }
        }
        
        squadspawnpoints[ squadspawnpoints.size ] = spawnpoint;
    }
    
    if ( var_38661a89fb25fc54 )
    {
        assert( squadspawnpoints.size >= level.maxsquadsize, "<dev string:x94>" + ob_player_spawn_classname + "<dev string:xa1>" + start_activity + "<dev string:xce>" + squadspawnpoints.size + "<dev string:xd9>" + level.maxsquadsize + "<dev string:xec>" );
    }
    
    level.squadspawnpointsets[ 0 ] = squadspawnpoints;
    level.obspawnarray = [];
    spawnlogic::finalizemap();
    return true;
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x72bb9b24, Offset: 0xdf6
// Size: 0x130, Type: bool
function private function_effb274e1e64bcfc( player )
{
    assert( isplayer( player ) );
    
    if ( !level.gametypebundle.var_76d11c34dc9ca0bf )
    {
        return false;
    }
    
    if ( level utility::flag( "squad_play_begin" ) == 0 )
    {
        return false;
    }
    
    anyonespawned = 0;
    
    foreach ( otherplayer in level.players )
    {
        if ( otherplayer.sessionstate != "spectator" )
        {
            anyonespawned = 1;
            break;
        }
    }
    
    if ( !anyonespawned )
    {
        return false;
    }
    
    activityname = ob_story_mission_activity_name();
    var_d27dfde942bc52d1 = level.var_bc6897c06376ba35[ activityname ];
    
    if ( !var_d27dfde942bc52d1 )
    {
        player.var_76d11c34dc9ca0bf = 1;
        player.spawnedasspectator = 1;
        return true;
    }
    
    return false;
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0x17250ce, Offset: 0xf2f
// Size: 0x6d
function activity_type_init( ob_activity_name )
{
    activity_common::function_944074f3079c1d4e( level.current_activity_name, 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( level.current_activity_name, 2, &activity_ended );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, level.current_activity_name );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, level.current_activity_name );
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0xe7cb30b5, Offset: 0xfa4
// Size: 0x46
function activity_setup()
{
    level.current_activity = undefined;
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0x7dbf6385, Offset: 0xff2
// Size: 0x32
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    self notify( #"hash_7d4cf90a73514395" );
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0xdb1da9dd, Offset: 0x102c
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0x23568f11, Offset: 0x1082
// Size: 0xc
function player_joined_activity( relevant_info_struct )
{
    
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0xda82c655, Offset: 0x1096
// Size: 0xc
function player_left_activity( relevant_info_struct )
{
    
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x71837c52, Offset: 0x10aa
// Size: 0xa6
function function_a535ecaaab8427b7()
{
    activity_name = start_activity_get();
    level thread activity_dvar_monitor( activity_name );
    story_mission_player_ready_check();
    
    foreach ( player in level.players )
    {
        player function_88ce0712f3ddff2b();
    }
    
    waittillframeend();
    function_920a32d79864afc9( activity_name );
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0xed125d2, Offset: 0x1158
// Size: 0x6b
function function_b69ee4ccc5e7a2ae( startpoint_activity_name )
{
    assert( isdefined( startpoint_activity_name ) );
    level.var_a382d6287e313bba = startpoint_activity_name;
    spawnstructs = get_player_spawn_starts( level.var_a382d6287e313bba );
    
    if ( spawnstructs.size > 0 && isstruct( spawnstructs[ 0 ] ) && isdefined( spawnstructs[ 0 ].origin ) )
    {
        ob_story_mission_utils::set_revive_spawns( spawnstructs );
    }
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0x24a007f5, Offset: 0x11cb
// Size: 0x24b
function function_ea3b18bcb9d3712c( startpoint_activity_name )
{
    level endon( #"story_mission_startpoint_called" );
    utility::flag_wait( "ai_spawn_director_initialized" );
    utility::flag_wait( "squad_play_begin" );
    is_startpoint_start = 1;
    function_b69ee4ccc5e7a2ae( startpoint_activity_name );
    level.activity_index = level.activity_name_array[ startpoint_activity_name ][ "index" ];
    level utility::flag_wait( "player_ready_check" );
    
    for ( i = level.activity_index; i < level.activity_array.size ; i++ )
    {
        activityname = level.activity_array[ i ][ "activity_name" ];
        level.activity_index = level.activity_array[ i ][ "index" ];
        noscreenfx = i == 0 || level.coop_reload != 0;
        ob::function_b2d4c209cff8d689( level.players, level.activity_power_tier[ activityname ], noscreenfx );
        
        if ( !ob::nightmare() && isdefined( level.activity_story_contract[ activityname ] ) )
        {
            story_contract_util::mark_complete( level.players, level.activity_story_contract[ activityname ] );
        }
        
        function_7f13f428fbfac6fc( activityname );
        ob_story_mission_utils::set_global_region_difficulty( level.activity_difficulty[ activityname ] );
        activity_instance = function_13e5713a964f6b0d( activityname, activityname, is_startpoint_start );
        is_startpoint_start = 0;
        squad = teams::function_72b89edf6b47c40a( level.players[ 0 ] );
        
        if ( squad )
        {
            squad.percentcomplete = i / ( level.activity_array.size - 1 );
            
            foreach ( player in squad.players )
            {
                player setclientomnvar( "ui_ob_mission_complete_percentage", squad.percentcomplete );
            }
        }
        
        activity_instance waittill( #"hash_7d4cf90a73514395" );
        cleanup_current_activity();
    }
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x1642f0d3, Offset: 0x141e
// Size: 0x1da
function private function_d75c7c1c7a10b8f1( relevantinfostruct )
{
    activityinstance = self;
    activitymoment = relevantinfostruct.activitymoment;
    
    if ( activitymoment == "ActivityBegin" && isdefined( activityinstance.type ) )
    {
        function_b69ee4ccc5e7a2ae( activityinstance.type );
    }
    
    if ( level.var_c50d61acef71b3a3[ activityinstance.type ] )
    {
        function_e01fa1da504c3b9a();
    }
    
    if ( isarray( level.players ) && isdefined( level.outbreakdata ) )
    {
        foreach ( player in level.players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            level.mapindex = level.mapindex ?? -1;
            
            if ( level.mapindex < 0 )
            {
                maptable = getmapnamesforgamemode();
                
                if ( isdefined( maptable ) )
                {
                    level.mapindex = function_f02c63b99c9614c9( maptable, level.mapname ?? "" ) ?? -1;
                }
            }
            
            player setplayerdata( level.outbreakdata, "missionContinue", "map", level.mapindex );
            player setplayerdata( level.outbreakdata, "missionContinue", "start", level.activity_index ?? -1 );
            player setplayerdata( level.outbreakdata, "missionContinue", "playlist", getplaylistid() );
        }
    }
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xaa8cbec7, Offset: 0x1600
// Size: 0x85
function private function_e01fa1da504c3b9a( parms )
{
    foreach ( player in level.players )
    {
        player thread function_53bd6710a606e0a();
    }
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xbfc878a7, Offset: 0x168d
// Size: 0xf
function private function_82b7113c91892e85()
{
    level utility::flag_wait( "story_mission_party_check_complete" );
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x4651bcf6, Offset: 0x16a4
// Size: 0x115
function private function_7f13f428fbfac6fc( startpoint_activity_name )
{
    missiondata = utility::callsharedfunc( #"save", #"mission_get_data" );
    
    if ( isdefined( missiondata ) )
    {
        if ( missiondata.activity_current != startpoint_activity_name )
        {
            foreach ( player in level.players )
            {
                player.var_27fd0d2a449557bf = undefined;
                player.var_755ed09478df002 = undefined;
                
                if ( player.sessionstate == "playing" )
                {
                    player utility::callsharedfunc( #"coop", #"hash_ef677de46ca0c35" );
                }
            }
            
            save::function_422a0e1d525c7257();
        }
        
        missiondata.activity_current = ob_story_mission_utils::validate_activity_name( startpoint_activity_name );
    }
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x8f2d423d, Offset: 0x17c1
// Size: 0x157
function function_4cb6bbb828dc347d()
{
    if ( level.var_4cb6bbb828dc347d || function_9ff5a5ba55728756() )
    {
        return;
    }
    
    missiondata = utility::callsharedfunc( #"save", #"mission_get_data" );
    
    if ( isdefined( missiondata.activity_current ) )
    {
        foreach ( player in level.players )
        {
            if ( player.sessionstate == "playing" )
            {
                player telemetry_coop::player_death_event( "was_killed" );
                player thread challenges::function_267b9750fac691c1();
            }
            
            player telemetry_coop::player_death_event( "was_wiped" );
        }
        
        level notify( #"activity_dvar_monitor" );
        setdvar( @"ob_sm_reload", 1 );
        setdvar( @"hash_d5d17ffd60db08fc", level.players.size );
        start_activity_set( missiondata.activity_current );
        missiondata.var_9c49f989244a10d1 = 1;
        level.var_4cb6bbb828dc347d = 1;
        map_restart( 1 );
    }
}

// Namespace ob_gametype_story_mission
// Params 2
// Checksum 0xc87fef58, Offset: 0x1920
// Size: 0x325
function add_start( activity_name, options )
{
    regiondifficulty = options.difficulty;
    var_191c73a8b440065c = options.power;
    var_ceec1187bd7a80cb = options.joinspawn ?? 0;
    var_8504ec12ea75e5d0 = options.var_41cf7da898eb883 ?? 0;
    progressspawn = options.progressspawn ?? 1;
    story_contract = options.storycontract;
    forceloadout = options.forceloadout ?? 0;
    
    if ( ob::nightmare() )
    {
        setdvar( @"hash_b10ac56024891c37", 5 );
        setdvar( @"hash_5e1b3bfc576b756", 1 );
        setdvar( @"hash_8a8ff6ed00ccc7a", 1 );
        regiondifficulty = 6;
        var_191c73a8b440065c = "libra_complete";
    }
    
    if ( !isdefined( level.activity_array ) )
    {
        level.activity_array = [];
    }
    
    if ( isstring( story_contract ) )
    {
        story_contract = getxhash( story_contract );
    }
    
    level.var_cc108054db3da739 = regiondifficulty ?? level.var_cc108054db3da739 ?? 1;
    level.var_f7374e0d443a0f83 = var_191c73a8b440065c ?? level.var_f7374e0d443a0f83 ?? "leo_launch";
    
    if ( isdefined( options.loadout ) )
    {
        loadout_index = options.loadout.index;
        loadout_rarity = options.loadout.rarity;
        level.var_401e11219204bca8 = loadout_index ?? level.var_401e11219204bca8 ?? 0;
        level.var_d752e93d5df524a3 = loadout_rarity ?? level.var_d752e93d5df524a3 ?? level.var_cc108054db3da739;
        level.var_bc5d95b7b8715a85 = { #var_f91170067a6d805c:options.loadout.var_f91170067a6d805c, #rarity:level.var_d752e93d5df524a3, #index:level.var_401e11219204bca8 };
    }
    else
    {
        level.var_bc5d95b7b8715a85 = level.var_bc5d95b7b8715a85 ?? { #rarity:1, #index:0 };
    }
    
    array = function_b8b9a9cfcefd512d( activity_name );
    level.activity_array[ level.activity_array.size ] = array;
    level.activity_name_array[ activity_name ] = array;
    level.activity_difficulty[ activity_name ] = level.var_cc108054db3da739;
    level.activity_power_tier[ activity_name ] = level.var_f7374e0d443a0f83;
    level.var_bc6897c06376ba35[ activity_name ] = var_ceec1187bd7a80cb;
    level.var_5cc84d07fa47a2af[ activity_name ] = var_8504ec12ea75e5d0;
    level.var_9bef01ac1984cb4[ activity_name ] = forceloadout;
    level.var_c50d61acef71b3a3[ activity_name ] = progressspawn;
    level.activity_loadout[ activity_name ] = level.var_bc5d95b7b8715a85;
    level.activity_story_contract[ activity_name ] = story_contract;
}

/#

    // Namespace ob_gametype_story_mission
    // Params 0
    // Checksum 0x8fb38c89, Offset: 0x1c4d
    // Size: 0xae, Type: dev
    function function_aaee996f5214b375()
    {
        devgui::function_9082edeb5db93280( "<dev string:xef>" );
        
        foreach ( startpoint in level.activity_array )
        {
            devgui::function_cd4e263c1f3018ae( startpoint[ "<dev string:x111>" ], "<dev string:x11f>" + "<dev string:x12b>" + startpoint[ "<dev string:x111>" ], &function_24e8d33629a4bd36 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xd5d99ee8, Offset: 0x1d03
// Size: 0x107
function private function_920a32d79864afc9( activity_name )
{
    level notify( #"story_mission_startpoint_called" );
    level utility::flag_set( "flag_story_mission_startpoint_called" );
    cleanup_current_activity();
    startpoint_activity_name = activity_name;
    
    if ( getdvarint( @"fpstool_run" ) || getdvarint( @"prof_gameplaygfx" ) )
    {
        setdvar( @"hash_46467383874e22fd", activity_name );
    }
    
    missiondata = utility::callsharedfunc( #"save", #"mission_get_data" );
    
    if ( !missiondata.var_9c49f989244a10d1 )
    {
        dev_startpoint = ob::function_1737d21aae7148d2();
        
        if ( dev_startpoint != "default" )
        {
            startpoint_activity_name = dev_startpoint;
        }
    }
    
    level coop::function_84a4cb79f12b855();
    a_s_start = get_player_spawn_starts( startpoint_activity_name );
    
    if ( isdefined( a_s_start ) && isarray( level.players ) )
    {
        coop::teleport_players( level.players, a_s_start );
    }
    
    function_ea3b18bcb9d3712c( startpoint_activity_name );
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x45d0b1dd, Offset: 0x1e12
// Size: 0x14b
function private activity_dvar_monitor( activity_name )
{
    level endon( #"game_ended" );
    level endon( #"activity_dvar_monitor" );
    current_activity = activity_name;
    
    while ( true )
    {
        current_start_activity = start_activity_get();
        
        if ( current_start_activity != current_activity )
        {
            next_activity = current_start_activity;
            
            if ( isdefined( level.activity_name_array[ current_start_activity ] ) )
            {
                current_activity = current_start_activity;
                level thread function_920a32d79864afc9( current_activity );
            }
            else
            {
                assertmsg( next_activity + "<dev string:x12d>" );
                start_activity_set( current_activity );
            }
        }
        
        if ( getdvarint( @"ob_sm_reload", 0 ) == 1 )
        {
            setdvar( @"ob_sm_reload", 0 );
            level notify( #"last_stand_map_restart" );
            
            foreach ( player in level.players )
            {
                player damage_effects::onexitdeathsdoor();
            }
            
            wait 0.1;
            thread function_4cb6bbb828dc347d();
        }
        
        waitframe();
    }
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xff41de93, Offset: 0x1f65
// Size: 0x1c
function private start_activity_set( start_activity )
{
    setdvar( @"ob_sm_start", start_activity );
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xe04b9e8f, Offset: 0x1f89
// Size: 0x6a
function private start_activity_get()
{
    firstactivity = level.activity_array[ 0 ][ "activity_name" ];
    setdvarifuninitialized( @"ob_sm_start", firstactivity );
    start_activity = getdvar( @"ob_sm_start" );
    
    if ( tolower( start_activity ) == "spawn" )
    {
        start_activity = firstactivity ?? start_activity;
    }
    
    start_activity = ob_story_mission_utils::validate_activity_name( start_activity );
    return start_activity;
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xac7fb0d7, Offset: 0x1ffc
// Size: 0x24
function private function_24e8d33629a4bd36( params )
{
    activity_name = params[ 0 ];
    start_activity_set( activity_name );
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x743880f9, Offset: 0x2028
// Size: 0x37
function private function_b8b9a9cfcefd512d( activity_name )
{
    array = [];
    array[ "activity_name" ] = activity_name;
    array[ "index" ] = level.activity_array.size;
    return array;
}

// Namespace ob_gametype_story_mission
// Params 2, eflags: 0x4
// Checksum 0x28c1a226, Offset: 0x2068
// Size: 0x32
function private cleanup_current_activity( cleanup_radius, var_3112e7aaad668534 )
{
    if ( isdefined( level.current_activity ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( level.current_activity );
    }
}

// Namespace ob_gametype_story_mission
// Params 3
// Checksum 0x20230918, Offset: 0x20a2
// Size: 0x9e
function function_13e5713a964f6b0d( activity_type, variant_tag, is_startpoint_start = 0 )
{
    additionalspawndata = { #is_startpoint_start:is_startpoint_start };
    level.current_activity = activity_instance_common::createactivityinstance( activity_type, variant_tag, undefined, additionalspawndata );
    
    /#
        iprintlnbold( "<dev string:x146>" + activity_type );
    #/
    
    if ( isdefined( level.players ) )
    {
        activity_participation::function_fb0ec90aaf6d4c61( level.current_activity, level.players );
    }
    
    utility::flag_clear( "flag_story_mission_startpoint_called" );
    return level.current_activity;
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0x9498f6b9, Offset: 0x2149
// Size: 0x216
function on_player_spawned( params )
{
    self endon( #"disconnect" );
    
    if ( !level.run_player_ready_check )
    {
        utility::flag_set( "story_mission_party_check_complete" );
    }
    
    if ( !utility::flag( "story_mission_party_check_complete" ) )
    {
        function_72a20681265953cc();
    }
    
    thread ob::function_86ef6f9996499233();
    dialogue_speaker::function_5a819ae5d4855fc9();
    is_initial_spawn = !self.wasrevived;
    
    if ( is_initial_spawn && ob::nightmare() )
    {
        var_d72cd7643b60619b = common_item::function_c4c43ebb7aa636dc( "killstreak" );
        
        if ( var_d72cd7643b60619b && var_d72cd7643b60619b.count > 0 )
        {
            self.var_80b4ca5db77982c1 = var_d72cd7643b60619b;
            common_item::function_bbba261e6fdc7e52( "killstreak", { #count:var_d72cd7643b60619b.count } );
        }
        
        utility::delaythread( 1, &function_749d845927c03946 );
    }
    
    if ( !level.var_9668852e8a58f4fb )
    {
        while ( !isdefined( level.current_activity ) )
        {
            waitframe();
        }
        
        if ( !ob::nightmare() && isdefined( level.var_8ff57499f0d46359 ) )
        {
            story_contract_util::function_8b11db0fe2323bee( level.var_8ff57499f0d46359 );
        }
        
        if ( !self.wasrevived )
        {
            coop::teleport_players( [ self ], level.on_player_spawned_starts );
            self.wasrevived = undefined;
        }
        
        activity_participation::function_fb0ec90aaf6d4c61( level.current_activity, [ self ] );
        
        /#
            if ( getdvarint( @"hash_6430560bc1ca31b1", 0 ) )
            {
                thread ob_story_mission_utils::function_c512e98688e4e357( self );
            }
        #/
        
        if ( getdvarint( @"hash_83571f4204668bf4", 0 ) == 1 )
        {
            thread ob_story_mission_utils::function_56b8e693a8061a3d( self );
        }
        
        if ( getdvarint( @"hash_a5bc4354be7c0fe7", 1 ) == 1 && ( !isdefined( self.primaryweapons[ 0 ] ) || isnullweapon( self.primaryweapons[ 0 ] ) || self.primaryweapons[ 0 ].classname == "fist" ) )
        {
            thread ob_story_mission_utils::function_4657f38861c52871( "sat_sm_zebra", "sat_pi_atlas" );
        }
        
        utility::ent_flag_set( "ob_sm_player_in_position" );
    }
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x428befac, Offset: 0x2367
// Size: 0x7f
function function_749d845927c03946()
{
    self notify( #"hash_ade7ac47f675fae4" );
    self endon( #"hash_ade7ac47f675fae4" );
    self endon( #"disconnect" );
    self notify( #"equipment_recharge" );
    supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, 0 );
    
    if ( level.var_b7e70fa484e134dc && self.tacticalsuper )
    {
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded( undefined, #"tactical" ), undefined, 0, undefined, undefined, undefined, #"tactical" );
    }
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0x253ba1bf, Offset: 0x23ee
// Size: 0x1fb
function get_player_spawn_starts( activity_name )
{
    a_spawn_points = getspawnarray( "mp_ob_spawn_start" );
    a_s_start = [];
    
    foreach ( spawn_point in a_spawn_points )
    {
        if ( spawn_point.script_noteworthy == activity_name )
        {
            a_s_start[ a_s_start.size ] = spawn_point;
        }
    }
    
    if ( a_s_start.size == 0 )
    {
        /#
            iprintln( "<dev string:x159>" );
        #/
        
        return;
    }
    else if ( level.var_5cc84d07fa47a2af[ activity_name ] )
    {
        a_s_start = arraysort( a_s_start, undefined, &function_ccdacd9f1ae0b310 );
    }
    else if ( getdvarint( @"hash_ffbd82cbb1c53080", 0 ) )
    {
        /#
            iprintln( "<dev string:x196>" );
        #/
        
        sortedarray = [];
        
        for ( index = 0; index < a_s_start.size ; index++ )
        {
            foreach ( item in a_s_start )
            {
                if ( item.target == string( index ) )
                {
                    sortedarray[ sortedarray.size ] = item;
                }
            }
        }
        
        if ( sortedarray.size > 0 )
        {
            a_s_start = sortedarray;
            i_position = getdvarint( @"scr_spawn_position_choice", 0 );
            
            if ( i_position > 0 && isdefined( a_s_start[ i_position ] ) )
            {
                chosen_spawn_start = a_s_start[ i_position ];
                a_s_start[ i_position ] = a_s_start[ 0 ];
                a_s_start[ 0 ] = chosen_spawn_start;
            }
        }
    }
    
    return a_s_start;
}

// Namespace ob_gametype_story_mission
// Params 2, eflags: 0x4
// Checksum 0x7f108e80, Offset: 0x25f2
// Size: 0x34, Type: bool
function private function_ccdacd9f1ae0b310( a, b )
{
    return int( a.target ) < int( b.target );
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0xbd888371, Offset: 0x262f
// Size: 0x143
function function_951e15447cade3c3( arr_requestid )
{
    if ( isdefined( arr_requestid ) )
    {
        level notify( #"hash_bea779b9f18f59ab" );
        
        foreach ( requestid in arr_requestid )
        {
            requestdata = function_9b649316adcccbaa( requestid );
            
            if ( isdefined( requestdata ) )
            {
                function_ef57f478f96b050c( requestid, 0 );
                ai_spawn_director::cancel_spawn_request( requestid, 1 );
                
                foreach ( ai in requestdata.ai )
                {
                    ai.diequietly = 1;
                    ai.nocorpse = 1;
                    ai kill();
                }
            }
        }
    }
}

// Namespace ob_gametype_story_mission
// Params 1
// Checksum 0xa4ccb8e6, Offset: 0x277a
// Size: 0xe, Type: bool
function function_9b991061f96ab4f7( v_origin )
{
    return true;
}

/#

    // Namespace ob_gametype_story_mission
    // Params 1
    // Checksum 0xdff066ff, Offset: 0x2791
    // Size: 0x19, Type: dev
    function function_e7e6b5241a21f205( params )
    {
        iprintlnbold( "<dev string:x1c5>" );
    }

#/

// Namespace ob_gametype_story_mission
// Params 2
// Checksum 0xcbac9617, Offset: 0x27b2
// Size: 0x20e
function function_1fb9ccca3958dbb2( a_squad_players, var_958151dbd0f282ec )
{
    if ( var_958151dbd0f282ec )
    {
        return;
    }
    
    playingcount = 0;
    
    foreach ( player in a_squad_players )
    {
        player coop::function_eb6e09941acb48e9();
        
        if ( player.sessionstate == "playing" )
        {
            playingcount++;
        }
    }
    
    if ( playingcount > 0 )
    {
        wait 1;
    }
    
    nofail = getdvarint( @"hash_4af72e5b55859fa9", 1 ) == 2;
    
    foreach ( player in a_squad_players )
    {
        if ( nofail )
        {
            player function_53bd6710a606e0a();
            continue;
        }
        
        level thread game_utility::fadetoblackforplayer( player, 1, playingcount > 0 ? 0.5 : 0 );
        player setclientdvar( @"hash_cb4dbcc0d4238fdf", 1 );
    }
    
    if ( nofail )
    {
        return;
    }
    
    level notify( #"last_stand_map_restart" );
    
    foreach ( player in a_squad_players )
    {
        player thread damage_effects::onexitdeathsdoor();
    }
    
    if ( playingcount > 0 )
    {
        wait 0.75;
    }
    else
    {
        wait 0.1;
    }
    
    level thread function_4cb6bbb828dc347d();
}

// Namespace ob_gametype_story_mission
// Params 2, eflags: 0x4
// Checksum 0x3d4ee856, Offset: 0x29c8
// Size: 0x5f
function private function_9142baea1cccc1ed( spectatedplayer, locationoverride )
{
    assert( isplayer( self ) );
    respawnlocation = ob_laststand::function_c1ff5f7338491b7( spectatedplayer, locationoverride );
    
    if ( !respawnlocation.success || level.var_1fe9ae2fed8cc836 )
    {
        respawnlocation = get_spawn_start_struct( respawnlocation );
    }
    
    return respawnlocation;
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xa2ba2811, Offset: 0x2a30
// Size: 0x81
function private get_spawn_start_struct( var_cd70627ca77f529a )
{
    assert( isplayer( self ) );
    player = self;
    activitystarts = level.on_player_spawned_starts;
    
    if ( isarray( activitystarts ) && isdefined( player.sessionuimemberindex ) )
    {
        squadmemberindex = int( clamp( player.sessionuimemberindex ?? 0, 0, activitystarts.size - 1 ) );
        return activitystarts[ squadmemberindex ];
    }
    
    return var_cd70627ca77f529a;
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x2c316de7, Offset: 0x2aba
// Size: 0x7d
function function_53bd6710a606e0a()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( isplayer( self ) );
    player = self;
    
    if ( player.sessionstate == "playing" && player.inlaststand )
    {
        player thread function_71ff58ec1ea94ec8( &laststand::exit, "last_stand_revived", player );
        return;
    }
    
    if ( player.sessionstate != "playing" )
    {
        player thread function_4698cc0a9eeccd7();
        return;
    }
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0xc
// Checksum 0xc4fe8551, Offset: 0x2b3f
// Size: 0x8a
function private function_4698cc0a9eeccd7()
{
    self notify( #"hash_77a9631261a18994" );
    self endon( #"hash_77a9631261a18994" );
    self endon( #"death_or_disconnect" );
    var_253335d37df209dc = getdvarint( @"hash_230131298ecf6660", 0 );
    
    if ( self.var_8aee7d81428d098e )
    {
        timesince = gettime() - self.var_8aee7d81428d098e;
        
        if ( timesince < var_253335d37df209dc )
        {
            wait ( var_253335d37df209dc - timesince ) / 1000;
        }
        
        self.var_8aee7d81428d098e = undefined;
    }
    
    thread function_71ff58ec1ea94ec8( &teamrevive::respawn );
}

// Namespace ob_gametype_story_mission
// Params 3, eflags: 0x4c variadic
// Checksum 0xba48717d, Offset: 0x2bd1
// Size: 0xb0
function private function_71ff58ec1ea94ec8( respawnfunc, ... )
{
    self notify( #"hash_5d82b33c04483008" );
    self endon( #"hash_5d82b33c04483008" );
    assert( isplayer( self ) );
    assert( isfunction( respawnfunc ) );
    player = self;
    player endon( #"disconnect" );
    player [[ respawnfunc ]]( flat_args( vararg, varargcount ) );
    
    while ( player.sessionstate != "playing" )
    {
        waitframe();
    }
    
    waitframe();
    s_start = player get_spawn_start_struct();
    
    if ( isdefined( s_start ) )
    {
        coop::teleport_player( player, s_start );
    }
}

/#

    // Namespace ob_gametype_story_mission
    // Params 0, eflags: 0x4
    // Checksum 0xf5fd82ab, Offset: 0x2c89
    // Size: 0x8a, Type: dev
    function private function_a218cde1c6260be2()
    {
        activitynames = [];
        
        foreach ( actname, actstruct in level.activity_name_array )
        {
            activitynames[ activitynames.size ] = actname;
        }
        
        return activitynames;
    }

#/

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x6ae454e2, Offset: 0x2d1b
// Size: 0x157
function private function_23e93443efaab71e( params )
{
    activityname = params[ 0 ] ?? "???";
    
    if ( isdefined( level.activity_name_array[ activityname ] ) )
    {
        /#
            level thread ob::function_e1170951b62312fc( level.players, activityname );
        #/
        
        setdvar( @"start", activityname );
    }
    else
    {
        setdvar( @"start", "default" );
        setdvar( @"hash_364afa6c813448af", "default" );
    }
    
    level notify( #"last_stand_map_restart" );
    
    foreach ( player in level.players )
    {
        player thread damage_effects::onexitdeathsdoor();
        player stopcinematicforplayer();
    }
    
    wait 0.1;
    setdvar( @"ob_sm_reload", 2 );
    setdvar( @"hash_d5d17ffd60db08fc", level.players.size );
    setdvar( @"hash_10a81f3d3159dfd6", level.players.size );
    map_restart();
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x3470aed2, Offset: 0x2e7a
// Size: 0x30
function private story_mission_player_ready_check()
{
    level.run_player_ready_check = 1;
    
    if ( utility::flag( "story_mission_party_check_complete" ) )
    {
        return;
    }
    
    level coop::player_ready_check();
    utility::flag_set( "story_mission_party_check_complete" );
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x68201396, Offset: 0x2eb2
// Size: 0x15
function private function_72a20681265953cc()
{
    val::set( "story_mission_lock", "freezecontrols", 1 );
}

// Namespace ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xd2fc1ed7, Offset: 0x2ecf
// Size: 0xe
function private function_88ce0712f3ddff2b()
{
    val::reset_all( "story_mission_lock" );
}

// Namespace ob_gametype_story_mission
// Params 0
// Checksum 0x1b41ba92, Offset: 0x2ee5
// Size: 0x56
function init_squad_size_scaling()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    function_a25acb62ddab20e2( "squad_size_large", 1 );
    
    if ( getdvarint( @"hash_f8331ad7ff441fb2", 1 ) )
    {
        callback::add( #"player_spawned", &function_43008c4ae1605b4b );
        callback::add( #"player_disconnect", &function_43008c4ae1605b4b );
    }
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x8ca0d583, Offset: 0x2f43
// Size: 0xcd
function private function_43008c4ae1605b4b( params )
{
    player_count = level.players.size;
    function_a25acb62ddab20e2( "squad_size_small", 0 );
    function_a25acb62ddab20e2( "squad_size_large", 0 );
    
    switch ( player_count )
    {
        case 1:
        case 2:
            difficulty_tag = "squad_size_small";
            level.is_squad_size_small = 1;
            break;
        case 3:
        case 4:
            difficulty_tag = "squad_size_large";
            level.is_squad_size_small = 0;
            break;
        default:
            difficulty_tag = "squad_size_small";
            level.is_squad_size_small = 1;
            break;
    }
    
    function_a25acb62ddab20e2( difficulty_tag, 1 );
}

// Namespace ob_gametype_story_mission
// Params 2
// Checksum 0x8f8fb602, Offset: 0x3018
// Size: 0x58
function function_bdbb24f577154fa7( str_suit, b_disableskydive = 0 )
{
    if ( isdefined( str_suit ) )
    {
        player::_setsuit( str_suit );
        self skydive_autodeployoff();
    }
    
    if ( b_disableskydive )
    {
        self skydive_setbasejumpingstatus( 0 );
        self skydive_setdeploymentstatus( 0 );
        return;
    }
    
    self skydive_setbasejumpingstatus( 1 );
    self skydive_setdeploymentstatus( 1 );
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x4b189a79, Offset: 0x3078
// Size: 0x1f
function private function_5bfc61f98c2501a5( player )
{
    if ( player )
    {
        player thread player_loadout_save( "ob_sm_checkpoint_loadout" );
    }
}

// Namespace ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xeca22078, Offset: 0x309f
// Size: 0x14
function private function_e48ca021c27d049d( params )
{
    level coop::function_84a4cb79f12b855();
}

