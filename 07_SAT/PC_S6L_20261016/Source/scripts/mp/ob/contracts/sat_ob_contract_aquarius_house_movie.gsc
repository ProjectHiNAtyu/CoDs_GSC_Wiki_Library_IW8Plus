// scripts\mp\ob\contracts\sat_ob_contract_aquarius_house_movie.gsc  (hash_05659aad2371b54b.gscc) (size: 59158 Bytes / 0xe716 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a265f04 (1244028676)
// size ...... 59158 (0xe716)
// includes .. 38  (offset: 0xd4ca)
// strings ... 267 (offset: 0xd5fa)
// dev strs .. 17  (offset: 0xe646)
// exports ... 149 (offset: 0x918a)
// cseg ...... 0x2116 + 0x7074 (0x918a)
// imports ... 331 (offset: 0xa8d2)
// animtree1 . 0   (offset: 0xe716)
// animtree2 . 0   (offset: 0xe716)
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\devgui;
#using scripts\common\snd\snd_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle_spawn;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\armor;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\sat_ob_contract_aquarius_virus_upload;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\overlord;
#using scripts\mp\snd\snd_ob;

#namespace sat_ob_contract_aquarius_house_movie;

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0, eflags: 0x5
// Checksum 0x1e9afd19, Offset: 0x2134
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_a3fa6f1f84ed5635", undefined, &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0, eflags: 0x4
// Checksum 0x659df9e9, Offset: 0x2155
// Size: 0xfe
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    setdvar( @"hash_c69456bc853363e0", 1 );
    activity_common::registeractivitytype( "REV_OB_AQUARIUS_HOUSE_MOVIE", &activity_type_init );
    level callback::add( #"hash_cc06eb1d45f33a0c", &onplayerjoinsquad );
    level callback::add( #"player_disconnect", &function_7d01d9bdc1a809c5 );
    level callback::add( #"player_leave_squad", &function_7d01d9bdc1a809c5 );
    level callback::add( #"on_spawn_checkpoint_respawn", &function_31e371108b89570d );
    level thread function_a2c3704ae77acb8e();
    level thread function_b5fa21a1182311c2();
    level thread setup_respawn_points();
    classtableentry = getscriptbundle( hashcat( %"classtableentry:", "classtableentry_sat_ob_aqua_default" ) );
    level.aqua_starting_loadout = { #loadout_key:"starting_loadout", #loadout_array:class::function_79947c7814a64d0e( classtableentry ) };
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x6e083770, Offset: 0x225b
// Size: 0x1b3
function function_51dd23c464c98a2a( wipe_struct )
{
    squad = wipe_struct.squad;
    respawnlocations = wipe_struct.respawnlocations;
    squad_players = wipe_struct.a_squad_players;
    
    if ( !level.var_2d3e115d38ca7799 )
    {
        level.var_2d3e115d38ca7799 = [];
    }
    
    level.var_2d3e115d38ca7799 = function_5713d46873b29625( level.var_2d3e115d38ca7799 );
    
    foreach ( player in squad_players )
    {
        origin = player.origin;
        
        if ( player.var_27fd0d2a449557bf )
        {
            origin = player.var_27fd0d2a449557bf;
        }
        
        ai = getaiarrayinradius( origin, 600 );
        level.var_2d3e115d38ca7799 = arraycombineunique( level.var_2d3e115d38ca7799, ai );
    }
    
    foreach ( enemy in level.var_2d3e115d38ca7799 )
    {
        enemy thread function_9298c84d5a948321();
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x26569f98, Offset: 0x2416
// Size: 0x8e
function function_31e371108b89570d( respawn_struct )
{
    squad = respawn_struct.squad;
    spawnpointsused = respawn_struct.spawnpointsused;
    
    if ( story_contract_util::is_active( squad.players[ 0 ], #"aqua_intro" ) )
    {
        if ( isstruct( spawnpointsused[ 0 ] ) && spawnpointsused[ 0 ].targetname == "respawn_points_bar" )
        {
            logstring( "[Aqua Respawn]: Activated Bar Checkpoint " );
            level notify( #"clear_turret" );
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x37c6eb39, Offset: 0x24ac
// Size: 0x24a
function function_738871826351aee3( respawn_struct )
{
    squad = respawn_struct.squad;
    spawnpointsused = respawn_struct.spawnpointsused;
    ai_near_players = [];
    
    foreach ( player in squad.players )
    {
        ai = getaiarrayinradius( player.origin, 600 );
        ai_near_players = arraycombineunique( ai_near_players, [ ai ] );
    }
    
    if ( spawnpointsused[ 0 ].targetname == "respawn_points_post_tablet" )
    {
        if ( ai_near_players )
        {
            foreach ( ai in ai_near_players )
            {
                if ( isalive( ai ) )
                {
                    ai agent_utils::despawnagent();
                }
            }
            
            ai_near_players = function_5713d46873b29625( ai_near_players );
        }
    }
    else if ( spawnpointsused[ 0 ].targetname == "respawn_points_pre_descend" )
    {
        if ( ai_near_players )
        {
            foreach ( ai in ai_near_players )
            {
                if ( isalive( ai ) )
                {
                    ai agent_utils::despawnagent();
                }
            }
            
            ai_near_players = function_5713d46873b29625( ai_near_players );
        }
    }
    else if ( spawnpointsused[ 0 ].targetname == "respawn_points_pre_wave_defend" )
    {
    }
    else if ( spawnpointsused[ 0 ].targetname == "respawn_points_pre_wave_defend_closer" )
    {
    }
    
    utility::flag_set( "squad_respawned" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3, eflags: 0x4
// Checksum 0x458cfd95, Offset: 0x26fe
// Size: 0x83
function private function_7a04fa0665690332( dead_player_origin, min_distance, max_distance )
{
    if ( !isdefined( dead_player_origin ) )
    {
        return;
    }
    
    radius = sqrt( randomfloatrange( squared( min_distance / max_distance ), 1 ) ) * max_distance;
    theta = randomfloat( 360 );
    pos = dead_player_origin + ( cos( theta ) * radius, sin( theta ) * radius, 0 );
    pos = getclosestpointonnavmesh( pos );
    return pos;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x563d8767, Offset: 0x278a
// Size: 0x1c7
function function_9298c84d5a948321()
{
    self endon( #"death" );
    fallback_goal = function_7a04fa0665690332( self.origin, 200, 1000 );
    
    if ( !isdefined( fallback_goal ) )
    {
        fallback_goal = self.origin;
    }
    
    self.og_goalradius = self.goalradius;
    self clearenemy();
    self clearbtgoal( 0 );
    self clearbtgoal( 1 );
    self clearbtgoal( 3 );
    self.ignoreall = 1;
    wait randomfloatrange( 0.2, 1 );
    self setbtgoalpos( 0, fallback_goal );
    self setbtgoalpos( 1, fallback_goal );
    self setbtgoalradius( 0, 32 );
    self setbtgoalradius( 1, 32 );
    self.goalradius = 32;
    goalreached = 0;
    
    while ( true )
    {
        msg = utility::waittill_any_timeout( 1, "goal", "bad_path", "goal_reached", "bt_goal" );
        
        if ( msg != "timeout" )
        {
            if ( msg == "bad_path" )
            {
                /#
                    debugstar( self.origin, ( 1, 0, 0 ), 10000, "<dev string:x24>", 1 );
                #/
                
                /#
                    line( self.origin, fallback_goal, ( 0, 1, 0 ), 1, 0, 20 );
                #/
                
                goalreached = 1;
            }
        }
        
        if ( goalreached || distance( self.origin, fallback_goal ) <= 128 || utility::flag( "squad_respawned" ) )
        {
            break;
        }
    }
    
    utility::flag_wait( "squad_respawned" );
    self.ignoreall = 0;
    self clearenemy();
    self clearbtgoal( 0 );
    self clearbtgoal( 1 );
    self clearbtgoal( 3 );
    self.goalradius = self.og_goalradius;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x1e5db54f, Offset: 0x2959
// Size: 0x74
function function_802650e6461c7eae( vehicle )
{
    vehicle.spawndata.og_script_startinghealth = vehicle.maxhealth;
    vehicle.maxhealth = 3500;
    vehicle.health = vehicle.maxhealth;
    vehicle.spawndata.script_startinghealth = vehicle.maxhealth;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xed15db4f, Offset: 0x29d5
// Size: 0x153
function setup_respawn_points()
{
    level endon( #"game_ended" );
    utility::flag_wait( "aqua_activity_cs_completed" );
    
    if ( level.respawn_points_aqua )
    {
        logstring( "[Aqua Respawn] setup_respawn_points(..) in house_movie entered and returned as level.respawn_points_aqua was defined." );
        logstring( "[Aqua Respawn] in house_movie level.respawn_points_aqua size = " + level.respawn_points_aqua.size );
        return;
    }
    
    array_t = [ "respawn_points_gas_station", "respawn_points_pre_colosseum", "respawn_points_colosseum", "respawn_points_pre_descend", "respawn_points_post_descend", "respawn_points_alt_post_descend", "respawn_points_post_smoke", "respawn_points_bar", "respawn_points_pre_boxing", "respawn_points_post_tablet", "respawn_points_pre_wave_defend", "respawn_points_pre_wave_defend_closer", "respawn_points_outro" ];
    level.respawn_points_aqua = [];
    
    foreach ( t in array_t )
    {
        level.respawn_points_aqua[ t ] = utility::getstructarray( t, "targetname" );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 5
// Checksum 0x30624767, Offset: 0x2b30
// Size: 0x1b5
function function_eff49af9973cb6e3( squad_struct, flag, respawn_target, percentage_complete, endonstr )
{
    level endon( #"game_ended" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    squad_struct endon( #"completed" );
    assert( isfloat( percentage_complete ), "<dev string:x2d>" );
    
    if ( endonstr )
    {
        if ( isarray( endonstr ) )
        {
            foreach ( endonst in endonstr )
            {
                level endon( endonst );
            }
        }
        else
        {
            level endon( endonstr );
        }
    }
    
    utility::flag_wait( flag );
    
    if ( !squad_struct )
    {
        logstring( "[AquaIntro] squad data not defined for flag: " + flag + " targetname: " + respawn_target );
        squad_struct = level.aqua_intro_activity.active_squads[ 0 ];
        logstring( "[AquaIntro] squad data REDEFINED to: " + squad_struct.sessionsquadid );
    }
    
    var_64bb57aa2d6e8b35 = function_8aa672a8312c4734( squad_struct );
    
    if ( !var_64bb57aa2d6e8b35.players )
    {
        logstring( "[AquaIntro] squad_data.players not defined for flag: " + flag + " targetname: " + respawn_target );
    }
    
    if ( var_64bb57aa2d6e8b35.players.size == 0 )
    {
        logstring( "[AquaIntro] squad_data.players size = 0 " );
    }
    
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( respawn_target ) );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x667d3b67, Offset: 0x2ced
// Size: 0xb3
function get_respawn_points( targetname )
{
    logstring( "[Aqua Respawn] get_respawn_points(... ) called for targetname:  " + targetname );
    prefix = "respawn_points_";
    
    if ( utility::flag( "colosseum_interior_rear_decent" ) )
    {
        og_prefix = prefix;
        prefix = "respawn_points_alt_";
        
        if ( !level.respawn_points_aqua[ prefix + targetname ] )
        {
            return level.respawn_points_aqua[ og_prefix + targetname ];
        }
    }
    
    if ( level.respawn_points_aqua[ prefix + targetname ].size == 0 )
    {
        logstring( "[Aqua Respawn] NO RESPAWN POINTS FOUND FOR:  " + prefix + targetname );
        logstring( "[Aqua Respawn] level.respawn_points_aqua array size is  " + level.respawn_points_aqua.size );
    }
    
    return level.respawn_points_aqua[ prefix + targetname ];
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xf0eeac6, Offset: 0x2da9
// Size: 0x48
function function_92cb3995a8ba7ae4( player )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    wait 2;
    player utility::callsharedfunc( #"ob_skill_tracks", #"fixedloadout", 6, 1 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xb875f456, Offset: 0x2df9
// Size: 0x59
function function_a2c3704ae77acb8e()
{
    level endon( #"game_ended" );
    wait 5;
    teststruct = utility::getstruct( "test_aqua_struct", "script_noteworthy" );
    
    while ( !isdefined( teststruct ) )
    {
        teststruct = utility::getstruct( "test_aqua_struct", "script_noteworthy" );
        wait 1;
    }
    
    level utility::flag_set( "aqua_activity_cs_completed" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3, eflags: 0x4
// Checksum 0x77f9cc04, Offset: 0x2e5a
// Size: 0xb5
function private function_82fd4764867299c8( var_cd7e11dc688992d4, players, loadout )
{
    if ( loadout )
    {
        foreach ( player in players )
        {
            if ( player.var_72a935dcbc6f5b86 )
            {
                continue;
            }
            
            function_d626cc76cae468c1( player, loadout );
            player.var_72a935dcbc6f5b86 = 1;
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x21e8784a, Offset: 0x2f17
// Size: 0x30
function function_b5fa21a1182311c2()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_5e8e3629c0822549", 0 ) < 1 )
    {
        return;
    }
    
    level utility::flag_wait( "aqua_activity_cs_completed" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 4
// Checksum 0x40fc2add, Offset: 0x2f4f
// Size: 0x27
function analysis_spawn_func( requestid, instance, agent, ai_data )
{
    
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3
// Checksum 0x6b3d5201, Offset: 0x2f7e
// Size: 0x48
function function_ba064dabf72e2a85( requestid, userdata, shutdowndata )
{
    if ( isdefined( level.test_encounter ) )
    {
        ai_spawn_director::cancel_spawn_request( level.test_encounter );
        level utility::flag_set( "aqua_test_wave_completed" );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3
// Checksum 0xe77f1f63, Offset: 0x2fce
// Size: 0x1e
function function_56e502305a648d66( requestid, activity_instance, agent )
{
    
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x87765805, Offset: 0x2ff4
// Size: 0x36
function function_c809a5274273f7f9( requestid, activity_instance )
{
    if ( getdvarint( @"hash_fa6c20bc1b7a93d6", 0 ) )
    {
        activity_instance.should_spawn_ai = 0;
        return 1;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x5505a2c8, Offset: 0x3032
// Size: 0x2b
function function_37d526203647d7f8( requestid, activity_instance )
{
    if ( getdvarint( @"hash_fa6c20bc1b7a93d6", 0 ) <= 0 )
    {
        return 1;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 4
// Checksum 0xa2547977, Offset: 0x3065
// Size: 0x61
function function_164507a0c432b69f( requestid, userdata, agent, data )
{
    agent.script_noteworthy = data.script_noteworthy;
    agent.nocorpse = 1;
    agent function_fa32376aaa88a7a2( agent.origin, 2000 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xe637ded2, Offset: 0x30ce
// Size: 0x3d
function function_4ca59eb5fd22ddd5( streakname, player )
{
    player thread hud_message::showkillstreaksplash( streakname, player killstreaks::calcstreakcost( streakname ), undefined );
    player killstreaks::awardkillstreak( streakname, "other", undefined, undefined, undefined, undefined, 0 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0xfc32551f, Offset: 0x3113
// Size: 0xb6
function private function_d626cc76cae468c1( player, loadout )
{
    if ( loadout && player.current_loadout_key != loadout.loadout_key )
    {
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, 2, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
    }
    
    player armor::setarmorhealth( player.maxarmorhealth );
    platecount = player armor::function_22290101992e4874();
    platemax = 2;
    var_1fd4f9927be13502 = platemax - platecount;
    player armor::function_164c824617d7e8d7( var_1fd4f9927be13502 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x85ddb05d, Offset: 0x31d1
// Size: 0x32
function function_da2b479ac443c1cf( arr, flag )
{
    utility::array_wait( utility::array_removedead_or_dying( arr ), "death" );
    utility::flag_set( flag );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x15b27971, Offset: 0x320b
// Size: 0x70
function trigger_wait_targetname( targetname, endonstr )
{
    if ( endonstr )
    {
        self endon( endonstr );
    }
    
    struct = utility::getstruct( targetname, "targetname" );
    
    while ( true )
    {
        struct waittill( #"trigger", who );
        
        if ( isplayer( who ) || is_player_vehicle( who ) )
        {
            break;
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x7d1f67ff, Offset: 0x3283
// Size: 0x36, Type: bool
function is_player_vehicle( vehicle )
{
    return vehicle && vehicle.classname == "script_vehicle" && isplayer( vehicle.owner );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xec411dad, Offset: 0x32c2
// Size: 0x23
function function_1a20cc4039eb11a7( targetname, flag )
{
    level endon( flag );
    trigger_wait_targetname( targetname );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x79eeef31, Offset: 0x32ed
// Size: 0xa3
function set_flag_on_targetname_trigger( targetname, var_bcf17e2d3d09bc5a )
{
    if ( var_bcf17e2d3d09bc5a )
    {
        if ( isarray( var_bcf17e2d3d09bc5a ) )
        {
            foreach ( endonstr in var_bcf17e2d3d09bc5a )
            {
                self endon( endonstr );
            }
        }
    }
    
    trigger_wait_targetname( targetname );
    utility::flag_set( targetname );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xd7e413bc, Offset: 0x3398
// Size: 0x16d
function function_2a57585193d4d938()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    utility::flag_wait_all( "ai_spawn_director_initialized", "ai_spawn_director_create_script_processed" );
    thread function_abda880976f214c8( self );
    requestid = ai_spawn_director::lookup_spawn_request( "ai_encounter_aquarius_vehicle_spawnpoint" );
    ai_spawn_director::add_spawned_callback( requestid, &function_e524b62b30228781 );
    function_ef57f478f96b050c( requestid, 1 );
    
    if ( self.playerparticipants.size > 1 )
    {
        multiplayer_spawn_structs = utility::getstructarray( "veh_spawners_4p" );
        players_size = self.playerparticipants.size;
        
        for ( i = 0; i < multiplayer_spawn_structs.size - players_size ; i++ )
        {
            multiplayer_spawn_structs[ i ].count = 0;
        }
        
        ai_spawn_director::array_spawn_function_targetname( "veh_spawners_4p", &function_e524b62b30228781 );
        ai_spawn_director::array_spawn_targetname( "veh_spawners_4p" );
        thread function_b030fe904408e40b();
    }
    
    rpg_spawn_triggers = function_a066610de974e920( "rpg_spawn_trigger", undefined, 1 );
    ai_spawn_director::array_spawn_function_targetname( "rpg_spawners_4p", &function_b0ca8768d24d8ad );
    request_id_kvp = "ai_encounter_aquarius_rpg_interception_solo";
    
    if ( self.playerparticipants.size > 1 )
    {
        request_id_kvp = "ai_encounter_aquarius_rpg_interception";
    }
    
    requestid = ai_spawn_director::lookup_spawn_request( request_id_kvp );
    ai_spawn_director::add_spawned_callback( requestid, &function_b0ca8768d24d8ad );
    rpg_spawn_triggers = function_a066610de974e920( "rpg_spawn_trigger_vehicles", undefined, 1, requestid, undefined, self );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x727122fc, Offset: 0x350d
// Size: 0xb1
function function_b030fe904408e40b()
{
    level endon( #"game_ended" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    wait 5;
    multiplayer_spawn_structs = utility::getstructarray( "veh_spawners_4p" );
    
    foreach ( struct in multiplayer_spawn_structs )
    {
        struct.count = 1;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xf0031422, Offset: 0x35c6
// Size: 0x3f
function function_abda880976f214c8( var_cd7e11dc688992d4 )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    thread function_8e868d0c75280fdb( var_64bb57aa2d6e8b35, 2 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1, eflags: 0x4
// Checksum 0x518efe3f, Offset: 0x360d
// Size: 0xd8
function private on_trigger_func( var_c061c2d8d6e79312 )
{
    if ( !var_c061c2d8d6e79312 )
    {
        return;
    }
    
    mission_structs = level.aqua_intro_activity.active_squads;
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "pre_colosseum" ), 0.2 );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xe0bce7be, Offset: 0x36ed
// Size: 0xd
function ambient_ai_spawned()
{
    self setstealthstate( "idle" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0xc9d7ef13, Offset: 0x3702
// Size: 0xda
function private function_a6279949fcda8fd6( requestid, userdata )
{
    mission_structs = level.aqua_intro_activity.active_squads;
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "pre_colosseum" ), 0.2 );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xa4ee8b5a, Offset: 0x37e4
// Size: 0x3b
function function_d52eb1e5bb607c4e()
{
    level endon( #"hash_e25006d2c6ce08f2" );
    self endon( #"death" );
    self waittill( #"enemy" );
    thread function_edab93d26d4bb2c0( self );
    level notify( #"hash_e25006d2c6ce08f2" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 4
// Checksum 0x1a6b1d13, Offset: 0x3827
// Size: 0x89
function function_e524b62b30228781( requestid, userdata, agent = self, data )
{
    agent thread ai_despawn_on_activity_destroyed();
    agent.script_noteworthy = data.script_noteworthy;
    agent.script_deathflag = "gas_station_dead";
    agent thread ai::ai_deathflag();
    agent.disabledropfromcombat = 1;
    agent thread function_d52eb1e5bb607c4e();
    agent thread function_705818cf3f61d54();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 4
// Checksum 0x35c69bfb, Offset: 0x38b8
// Size: 0xb6
function function_b0ca8768d24d8ad( requestid, userdata, agent = self, data )
{
    agent thread ai_despawn_on_activity_destroyed();
    utility::flag_set( "rpg_interceptors_spawned" );
    agent.script_noteworthy = data.script_noteworthy;
    agent.disabledropfromcombat = 1;
    agent setstealthstate( "combat" );
    agent thread function_edab93d26d4bb2c0( agent, 256, 2000 );
    agent forcethreatupdate();
    var_b2d3fdd84b0be01c = getclosestplayer( agent.origin );
    
    if ( var_b2d3fdd84b0be01c )
    {
        agent getenemyinfo( var_b2d3fdd84b0be01c );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x8dfc0a, Offset: 0x3976
// Size: 0x68
function function_705818cf3f61d54()
{
    self endon( #"enemy" );
    self endon( #"death" );
    level waittill( #"hash_e25006d2c6ce08f2" );
    self setstealthstate( "combat" );
    function_edab93d26d4bb2c0( self );
    self forcethreatupdate();
    var_b2d3fdd84b0be01c = getclosestplayer( self.origin );
    
    if ( var_b2d3fdd84b0be01c )
    {
        self getenemyinfo( var_b2d3fdd84b0be01c );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xd07693fa, Offset: 0x39e6
// Size: 0x2d
function getclosestplayer( origin )
{
    if ( level.players.size == 0 )
    {
        return;
    }
    
    return sortbydistance( level.players, origin )[ 0 ];
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3
// Checksum 0x95c90170, Offset: 0x3a1c
// Size: 0x77
function function_edab93d26d4bb2c0( agent, buffer_override = 120, var_d1e8c3a846450c1d = 1024 )
{
    if ( !isdefined( agent ) || !agent.isactive )
    {
        return;
    }
    
    var_4e878d7d0d490a4d = agent.origin;
    var_c586c93e1fc6087a = var_d1e8c3a846450c1d + buffer_override;
    agent function_fa32376aaa88a7a2( var_4e878d7d0d490a4d, var_c586c93e1fc6087a );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 4
// Checksum 0xd7ddc2de, Offset: 0x3a9b
// Size: 0x89
function function_317931bc0424dba6( owner, origin, angles, delay = 5 )
{
    owner endon( #"death" );
    wait delay;
    streakinfo = killstreak_utility::createstreakinfo( "dawg" );
    streakinfo.team = owner.team;
    streakinfo.var_8caa143e85b803d9 = 1;
    thread dawg_mp::function_d85e6a2236d6e603( owner, origin, angles, streakinfo );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xd487a81, Offset: 0x3b2c
// Size: 0x41
function colosseum_main()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level.default_goalradius = 2048;
    utility::flag_wait_all( "ai_spawn_director_initialized", "ai_spawn_director_create_script_processed" );
    thread colosseum_exterior();
    thread colosseum_interior();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xd039b109, Offset: 0x3b75
// Size: 0x99
function function_2d19542cc158dc01()
{
    if ( self.agent_type == "sat_dawg" )
    {
        return;
    }
    
    self setstealthstate( "combat" );
    
    switch ( level.players.size )
    {
        case 2:
            if ( utility::cointoss() )
            {
                thread function_317931bc0424dba6( self, self.origin, self.angles );
            }
            
            break;
        case 3:
        case 4:
            thread function_317931bc0424dba6( self, self.origin, self.angles );
            break;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 6
// Checksum 0x9ae6f7b0, Offset: 0x3c16
// Size: 0xf9
function function_a066610de974e920( targetname, endonstr, veh_test = 0, requestid, func, activity_instance )
{
    if ( endonstr )
    {
        self endon( endonstr );
    }
    
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    structs = utility::getstructarray( targetname, "targetname" );
    
    foreach ( struct in structs )
    {
        struct thread function_7a58a379b4baccd1( veh_test, requestid, func, activity_instance );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 4
// Checksum 0xbfebc013, Offset: 0x3d17
// Size: 0x16f
function function_7a58a379b4baccd1( veh_test, requestids, func, activity_instance )
{
    self endon( #"death" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( veh_test )
        {
            if ( who.owner && isplayer( who.owner ) )
            {
                break;
            }
        }
        
        if ( isplayer( who ) )
        {
            break;
        }
    }
    
    if ( self.target && activity_instance.playerparticipants.size > 1 )
    {
        ai_spawn_director::array_spawn_targetname( self.target );
    }
    
    if ( requestids )
    {
        if ( isarray( requestids ) )
        {
            foreach ( requestid in requestids )
            {
                function_ef57f478f96b050c( requestid, 1 );
            }
        }
        else
        {
            function_ef57f478f96b050c( requestids, 1 );
        }
    }
    
    if ( func )
    {
        self thread [[ func ]]( who );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xce287f4a, Offset: 0x3e8e
// Size: 0xe
function colosseum_exterior_setup()
{
    teleport_players_to_start( "colosseum_colosseum_exterior_start" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x6f7b3928, Offset: 0x3ea4
// Size: 0x104
function colosseum_exterior()
{
    thread function_d6df69f5a3680c4d( self );
    ai_spawn_director::array_spawn_function_targetname( "exterior_rpg", &colosseum_exterior_spawn );
    ai_spawn_director::array_spawn_function_targetname( "exterior_rpg_4p", &colosseum_exterior_spawn );
    ai_spawn_director::array_spawn_function_targetname( "exterior_sniper", &colosseum_exterior_spawn );
    ai_spawn_director::array_spawn_function_targetname( "exterior_shields", &colosseum_exterior_spawn );
    ai_spawn_director::array_spawn_function_targetname( "gym_entrance_patrol", &colosseum_exterior_spawn );
    ai_spawn_director::array_spawn_function_targetname( "gym_rear_entrance_patrol", &colosseum_exterior_spawn );
    requestid = ai_spawn_director::lookup_spawn_request( "enc_aqua_colosseum_exterior" );
    ai_spawn_director::add_spawned_callback( requestid, &function_18390d0e3f6dc4dc );
    ai_spawn_director::function_5a08798970350207( requestid, &function_117c6e84ac74ee1f );
    function_ef57f478f96b050c( requestid, 1 );
    ai_spawn_director::array_spawn_targetname( "exterior_shields" );
    ai_spawn_director::array_spawn_targetname( "gym_entrance_patrol" );
    ai_spawn_director::array_spawn_targetname( "gym_rear_entrance_patrol" );
    ai_spawn_director::array_spawn_targetname( "exterior_sniper" );
    ai_spawn_director::array_spawn_targetname( "exterior_rpg" );
    
    if ( self.playerparticipants.size > 1 )
    {
        ai_spawn_director::array_spawn_targetname( "exterior_rpg_4p" );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0x28930479, Offset: 0x3fb0
// Size: 0x15c
function private function_117c6e84ac74ee1f( requestid, userdata )
{
    level endon( #"game_ended" );
    level endon( #"colosseum_descent" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    data = function_9b649316adcccbaa( requestid );
    encounter_ai = ai_spawn_director::function_5d069e637e2d0a05( requestid );
    tether_ai = [];
    anchor_ai = undefined;
    level.var_5e7bd351b940c391[ 0 ] = [];
    level.var_5e7bd351b940c391[ 1 ] = [];
    var_1eb4dc97bda91405 = encounter_ai;
    
    if ( !var_1eb4dc97bda91405.size )
    {
        return;
    }
    
    j = int( var_1eb4dc97bda91405.size / 2 );
    
    for ( i = 0; i < j ; i++ )
    {
        level.var_5e7bd351b940c391[ 0 ][ level.var_5e7bd351b940c391[ 0 ].size ] = var_1eb4dc97bda91405[ i ];
    }
    
    for ( i = j; i < var_1eb4dc97bda91405.size ; i++ )
    {
        if ( arraycontains( level.var_5e7bd351b940c391[ 0 ], var_1eb4dc97bda91405[ i ] ) )
        {
            continue;
        }
        
        level.var_5e7bd351b940c391[ 1 ][ level.var_5e7bd351b940c391[ 1 ].size ] = var_1eb4dc97bda91405[ i ];
    }
    
    while ( !ai_spawn_director::function_16096fa7d6fa6642( requestid, 0, 1 ) )
    {
        waitframe();
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xb882b83a, Offset: 0x4114
// Size: 0x99
function colosseum_exterior_spawn()
{
    self enabletraversals( 0 );
    self.disabledropfromcombat = 1;
    thread ai_despawn_on_activity_destroyed();
    
    if ( self.targetname )
    {
        switch ( self.targetname )
        {
            case #"hash_61bfa61ec4ea4b3":
            case #"hash_8ae5498228d0dd20":
                self setstealthstate( "idle" );
                self function_630eac6fd6900a61( "sat_ob_combat" );
                break;
            case #"hash_96f5a4aee73d9ff2":
                thread assign_anchors();
                break;
            case #"hash_c3b7f9c867196bff":
                self function_630eac6fd6900a61( "sat_ob_combat" );
                break;
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x5d5fdfc2, Offset: 0x41b5
// Size: 0x44
function ai_despawn_on_activity_destroyed()
{
    self endon( #"death" );
    level.aqua_intro_activity utility::waittill_any( "activity_ended", "instance_destroyed" );
    self.diequietly = 1;
    self.nocorpse = 1;
    self kill();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x7c34030b, Offset: 0x4201
// Size: 0xc9
function assign_anchors()
{
    self endon( #"death" );
    
    if ( level.shield_spawn )
    {
        return;
    }
    
    level.shield_spawn = 1;
    
    while ( !level.var_5e7bd351b940c391 )
    {
        waitframe();
    }
    
    while ( level.var_5e7bd351b940c391[ level.shields_count ].size == 0 )
    {
        waitframe();
    }
    
    if ( !level.shields_count )
    {
        level.shields_count = 0;
    }
    else
    {
        level.shields_count++;
    }
    
    self.var_d89300bd1ff5b42c = 50;
    self.var_6b9bdc1b2c784c16 = 50;
    self.var_1f427c09ffe756a = 50;
    self.waittimeoverride = 0.1;
    namespace_6280c51a6036a58a::function_6198eaa0deba2b53( self, level.var_5e7bd351b940c391[ level.shields_count ] );
    thread function_a1197bb3c172f9b0();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xfb9a00e1, Offset: 0x42d2
// Size: 0x49
function function_a1197bb3c172f9b0()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.bisincombat )
        {
            break;
        }
        
        waitframe();
    }
    
    self.fixednode = 0;
    ai::unset_forcegoal();
    self.goalradius = level.default_goalradius;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 4
// Checksum 0x2b253eab, Offset: 0x4323
// Size: 0x52
function function_18390d0e3f6dc4dc( requestid, instance, agent, ai_data )
{
    utility::flag_set( "colosseum_exterior_ai_spawned" );
    agent thread ai_despawn_on_activity_destroyed();
    agent enabletraversals( 0 );
    agent.disabledropfromcombat = 1;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x78c444d8, Offset: 0x437d
// Size: 0x6e
function colosseum_interior()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    level thread set_flag_on_targetname_trigger( "colosseum_interior_rear_decent", [ "colosseum_interior_bar_enter", "colosseum_interior_casino_approach", "colosseum_interior_gym_decent" ] );
    thread vo_colosseum_interior();
    thread colosseum_interior_gym();
    thread colosseum_interior_bar();
    thread colosseum_interior_casino();
    thread colosseum_interior_ring();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x570006ba, Offset: 0x43f3
// Size: 0x1e
function vo_colosseum_interior()
{
    thread function_45063cdd06542b13();
    thread vo_gym();
    thread vo_ring();
    thread vo_ring_boss();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xd9d84a2, Offset: 0x4419
// Size: 0x38
function function_45063cdd06542b13()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level trigger_wait_targetname( "colosseum_interior_gym_reached_floor", "colosseum_interior_rear_decent" );
    level.aqua_intro_activity thread function_28506303ef365913();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x82e144c6, Offset: 0x4459
// Size: 0x3b
function vo_gym()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level trigger_wait_targetname( "colosseum_interior_gym_enter", "gym_breadcrumbs_dead" );
    level.aqua_intro_activity thread function_a38ef6e63f7c7610( self, 3 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x8673c3d7, Offset: 0x449c
// Size: 0x35
function vo_ring()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    trigger_wait_targetname( "colosseum_interior_bar_enter" );
    level.aqua_intro_activity thread function_2ebd6733307e2d50( self, 3 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xe316c839, Offset: 0x44d9
// Size: 0x3a
function vo_ring_boss()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    utility::flag_wait( "ring_boss_dead" );
    wait 2;
    level.aqua_intro_activity thread function_26f488e58538a7dd( self, 0 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x42e4d658, Offset: 0x451b
// Size: 0xe
function function_6884ddd02e1721db()
{
    teleport_players_to_start( "colosseum_gym_enter_start" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x8ff89bd5, Offset: 0x4531
// Size: 0x9d
function colosseum_interior_gym()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    ai_spawn_director::array_spawn_function_targetname( "gym_smoke_wall", &function_5f0f2405c944023b );
    ai_spawn_director::array_spawn_function_targetname( "gym_smoke_wall", &function_c9f51da8d7d7764b );
    ai_spawn_director::array_spawn_function_targetname( "gym_smoke_wall_1p", &function_5f0f2405c944023b );
    ai_spawn_director::array_spawn_function_targetname( "gym_smoke_wall_1p", &function_c9f51da8d7d7764b );
    level trigger_wait_targetname( "colosseum_interior_gym_decent", "colosseum_interior_rear_decent" );
    utility::flag_set( "colosseum_descent" );
    ai_spawn_director::array_spawn_targetname( "gym_generic" );
    level trigger_wait_targetname( "colosseum_interior_gym_enter", "gym_breadcrumbs_dead" );
    thread smokescreen_moment();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xa6a9df10, Offset: 0x45d6
// Size: 0xb1
function smokescreen_moment()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    
    if ( utility::flag( "gym_breadcrumbs_dead" ) )
    {
        level thread set_flag_on_targetname_trigger( "colosseum_interior_gym_enter", "gym_smoke_screen_moment_start" );
        utility::flag_wait_or_timeout( "colosseum_interior_gym_enter", 2 );
    }
    
    utility::flag_set( "gym_smoke_screen_moment_start" );
    thread smokescreen_logic( "gym_smoke" );
    wait 2;
    aiarr = [];
    
    if ( level.aqua_intro_activity.playerparticipants.size == 1 )
    {
        aiarr = ai_spawn_director::array_spawn_targetname( "gym_smoke_wall_1p" );
    }
    else
    {
        aiarr = ai_spawn_director::array_spawn_targetname( "gym_smoke_wall" );
    }
    
    function_da2b479ac443c1cf( aiarr, "smoke_wall_dead" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x29f648c8, Offset: 0x468f
// Size: 0xcf
function smokescreen_logic( structtargetname )
{
    for ( i = 0; i < 2 ; i++ )
    {
        smoke_points = utility::getstructarray( structtargetname, "targetname" );
        
        foreach ( point in smoke_points )
        {
            magicgrenademanual( "sat_smoke_grenade_ob", point.origin, ( 0, 0, 0 ), 0.05 );
        }
        
        wait 3;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x58a634b1, Offset: 0x4766
// Size: 0x14
function function_5f0f2405c944023b()
{
    self setstealthstate( "combat" );
    thread ai_despawn_on_activity_destroyed();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xca3bc92f, Offset: 0x4782
// Size: 0x14
function function_c9f51da8d7d7764b()
{
    self.var_ee914ad666562200 = 1;
    thread ai_despawn_on_activity_destroyed();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xc3a0ba90, Offset: 0x479e
// Size: 0xe
function function_774d74c3483f2189()
{
    teleport_players_to_start( "colosseum_bar_enter_start" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xf4e9e27, Offset: 0x47b4
// Size: 0xc1
function colosseum_interior_bar()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    ai_spawn_director::array_spawn_function_targetname( "bar_movers", &function_fd15f67b7b5d5b15 );
    ai_spawn_director::array_spawn_function_targetname( "bar_movers_1p", &function_fd15f67b7b5d5b15 );
    ai_spawn_director::array_spawn_function_targetname( "bar_movers_4p", &function_fd15f67b7b5d5b15 );
    level trigger_wait_targetname( "colosseum_interior_bar_enter", "colosseum_interior_rear_decent" );
    level.aqua_intro_activity ob_activity_utility::ob_activity_spawn_turret( utility::getstruct( "bar_turret_spawn", "targetname" ), &turret_spawn_callback );
    ai_spawn_director::array_spawn_targetname( "bar_movers" );
    
    if ( level.aqua_intro_activity.playerparticipants.size > 1 )
    {
        ai_spawn_director::array_spawn_targetname( "bar_movers_4p" );
        return;
    }
    
    ai_spawn_director::array_spawn_targetname( "bar_movers_1p" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xc0f236e6, Offset: 0x487d
// Size: 0x13
function turret_spawn_callback( turret_spawn_struct )
{
    thread function_58a91a91d3eaab82();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x40149838, Offset: 0x4898
// Size: 0x69
function function_58a91a91d3eaab82()
{
    self notify( #"hash_504299eb991b8ac9" );
    self endon( #"hash_504299eb991b8ac9" );
    self endon( #"death" );
    level endon( #"game_ended" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level waittill( #"clear_turret" );
    logstring( "[Aqua Turret]: Clear Turret called. " );
    self notify( #"kill_turret" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x2cf9b747, Offset: 0x4909
// Size: 0x14
function function_fd15f67b7b5d5b15()
{
    self setstealthstate( "combat" );
    thread ai_despawn_on_activity_destroyed();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x8f16b37f, Offset: 0x4925
// Size: 0xe
function function_bf9df4fbbc4875df()
{
    teleport_players_to_start( "colosseum_casino_enter_start" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x94a8e0ea, Offset: 0x493b
// Size: 0xd3
function colosseum_interior_casino()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    ai_spawn_director::array_spawn_function_targetname( "casino_kickoff", &function_c00d3919aab01f9f );
    ai_spawn_director::array_spawn_function_targetname( "casino_kickoff_1p", &function_c00d3919aab01f9f );
    ai_spawn_director::array_spawn_function_targetname( "casino_kickoff_4p", &function_c00d3919aab01f9f );
    ai_spawn_director::array_spawn_function_targetname( "casino_wave2_4p", &function_c00d3919aab01f9f );
    level trigger_wait_targetname( "colosseum_interior_casino_approach", "colosseum_interior_rear_decent" );
    ai_spawn_director::array_spawn_targetname( "casino_kickoff" );
    
    if ( level.aqua_intro_activity.playerparticipants.size > 1 )
    {
        ai_spawn_director::array_spawn_targetname( "casino_kickoff_4p" );
    }
    else
    {
        ai_spawn_director::array_spawn_targetname( "casino_kickoff_1p" );
    }
    
    if ( utility::flag( "colosseum_interior_rear_decent" ) )
    {
        trigger_wait_targetname( "colosseum_interior_casino_halfway" );
    }
    
    ai_spawn_director::array_spawn_targetname( "casino_wave2_4p" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x2f45009d, Offset: 0x4a16
// Size: 0x39
function function_a2f62be1a5496f5b()
{
    if ( self.script_noteworthy )
    {
        switch ( self.script_noteworthy )
        {
            case #"hash_6af4c2ca440b0956":
                self.fixednode = 1;
                break;
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x16ce3fc7, Offset: 0x4a57
// Size: 0x9c
function function_c00d3919aab01f9f()
{
    self endon( #"death" );
    thread ai_despawn_on_activity_destroyed();
    
    if ( self.targetname )
    {
        switch ( self.targetname )
        {
            case #"hash_e8ed7371a58f6cd5":
                utility::set_movement_speed( 210 );
                break;
            case #"hash_1211692da853d5c2":
            case #"hash_bbb1dae5b0c84ddb":
                utility::set_movement_speed( 210 );
                self waittill( #"goal" );
                self.fixednode = 0;
                self.goalradius = 256;
                break;
        }
    }
    
    self setstealthstate( "combat" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xc458bce8, Offset: 0x4afb
// Size: 0x85
function function_ede6c792cd504354()
{
    self endon( #"death" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    self.goalradius = 64;
    
    while ( true )
    {
        closest_player = sortbydistance( level.aqua_intro_activity.playerparticipants, self.origin )[ 0 ];
        self setgoalpos( closest_player.origin, 64 );
        wait 3;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x3c6af910, Offset: 0x4b88
// Size: 0xe
function colosseum_interior_ring_setup()
{
    teleport_players_to_start( "colosseum_ring_enter_start" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xf1afd672, Offset: 0x4b9e
// Size: 0x133
function colosseum_interior_ring()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    ai_spawn_director::array_spawn_function_targetname( "ring_generic_4p", &function_caae811b54f73082 );
    ai_spawn_director::array_spawn_function_targetname( "ring_generic", &function_caae811b54f73082 );
    ai_spawn_director::array_spawn_function_targetname( "ring_robot", &function_caae811b54f73082 );
    ai_spawn_director::array_spawn_function_targetname( "ring_robot_4p", &function_caae811b54f73082 );
    ai_spawn_director::array_spawn_function_targetname( "ring_boss", &function_caae811b54f73082 );
    trigger_wait_targetname( "trigger_colosseum_interior_ring" );
    thread badplace_logic();
    thread set_flag_on_targetname_trigger( "colosseum_interior_lounge_approach" );
    thread smokescreen_logic( "ring_smoke" );
    utility::flag_wait_or_timeout( "colosseum_interior_lounge_approach", 2 );
    thread function_d5036856bfb08a41( self, 5 );
    
    if ( level.aqua_intro_activity.playerparticipants.size > 1 )
    {
        utility::delaythread( 5, &ai_spawn_director::array_spawn_targetname, "ring_robot_4p" );
    }
    
    ai_spawn_director::array_spawn_targetname( "ring_boss" );
    ai_spawn_director::array_spawn_targetname( "ring_robot" );
    utility::flag_wait_or_timeout( "colosseum_interior_lounge_approach", 10 );
    
    if ( level.aqua_intro_activity.playerparticipants.size > 1 )
    {
        ai_spawn_director::array_spawn_targetname( "ring_generic_4p" );
    }
    
    ai_spawn_director::array_spawn_targetname( "ring_generic" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x83edc3ad, Offset: 0x4cd9
// Size: 0x133
function badplace_logic()
{
    badplace_structs = utility::getstructarray( "robot_bad_place", "targetname" );
    
    foreach ( struct in badplace_structs )
    {
        struct.var_3907c274dc9a6e57 = createnavobstaclebybounds( struct.origin, ( 50, 50, 50 ), struct.angles );
    }
    
    utility::flag_wait( "ring_robots_dead" );
    
    foreach ( struct in badplace_structs )
    {
        destroynavobstacle( struct.var_3907c274dc9a6e57 );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x4cb769ef, Offset: 0x4e14
// Size: 0x106
function function_caae811b54f73082()
{
    self endon( #"death" );
    self.disabledropfromcombat = 1;
    self.goalheight = 64;
    thread ai_despawn_on_activity_destroyed();
    movement_speed = undefined;
    
    if ( self.targetname )
    {
        switch ( self.targetname )
        {
            case #"hash_bc7c474d4d9b89c4":
            case #"hash_d62f9e43f08b10cd":
                childthread function_ede6c792cd504354();
                break;
            case #"hash_56739aa9430e7f05":
                self.var_4f8a92ebabf37ee = 0;
                self waittill( #"goal" );
                self.fixednode = 0;
                self.goalradius = 128;
                break;
            case #"hash_afcb52e0605d3111":
            case #"hash_c00e586b9b5b8d9e":
                self waittill( #"goal" );
                self.fixednode = 0;
                self.goalradius = 256;
                break;
        }
        
        self.dontdroploot = 1;
    }
    
    self setstealthstate( "combat" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xb6e19e05, Offset: 0x4f22
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_HOUSE_MOVIE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_HOUSE_MOVIE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_HOUSE_MOVIE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_HOUSE_MOVIE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_AQUARIUS_HOUSE_MOVIE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_AQUARIUS_HOUSE_MOVIE" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x632c6a9f, Offset: 0x4fa3
// Size: 0x49
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.aqua_intro_activity = activity_instance;
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
    utility::flag_set( "aqua_activity_setup" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x9b312bc1, Offset: 0x4ff4
// Size: 0x65
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.aqua_house_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ activity_instance.varianttag ];
    thread respawn_on_destroyed( activity_instance, activity_instance.varianttag );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xde6ae2bf, Offset: 0x5061
// Size: 0x7e
function colosseum_breadcrumbs( activity_instance, var_cd7e11dc688992d4 )
{
    level endon( #"ring_boss_dead" );
    level endon( #"hash_8ea2d5813fbf0735" );
    thread colosseum_exterior_objectives( activity_instance, var_cd7e11dc688992d4 );
    utility::flag_wait( "colosseum_exterior_obj_done" );
    
    if ( !utility::flag( "colosseum_interior_rear_decent" ) )
    {
        thread colosseum_interior_objectives( activity_instance, var_cd7e11dc688992d4 );
        utility::flag_wait( "colosseum_interior_obj_done" );
    }
    
    thread colosseum_interior_ring_objectives( activity_instance, var_cd7e11dc688992d4 );
    utility::flag_wait( "colosseum_interior_ring_obj_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x95990a38, Offset: 0x50e7
// Size: 0x31d
function colosseum_objectives( activity_instance, var_cd7e11dc688992d4 )
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    logstring( "[AquaIntro] Showing Objective Text on thread ran on player:  " + self.name + " :SID " + var_cd7e11dc688992d4.sessionsquadid );
    level.aqua_intro_activity ob_story_mission_utils::function_b3e9457491e7af72( %"hash_788e0cb57ce53966", activity_instance.playerparticipants, undefined, undefined, 1, 2 );
    thread colosseum_breadcrumbs( activity_instance, var_cd7e11dc688992d4 );
    utility::flag_wait( "ring_boss_dead" );
    interact_struct = utility::getstruct( "laptop_spawn", "script_noteworthy" );
    interact_struct setup_laptop_interact( level.aqua_intro_activity, undefined, var_cd7e11dc688992d4 );
    assert( level.aqua_intro_activity.laptop_scriptable, "<dev string:x6e>" );
    
    if ( !isdefined( level.var_bfcc77ba77980427 ) )
    {
        vertical_offset = 16;
        level.var_bfcc77ba77980427 = level ob_story_mission_utils::function_b9cb179f9577f32a( level.aqua_intro_activity.laptop_scriptable.origin, vertical_offset, function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 ), "sat_ob_objectivemarker_storymissionmain" );
        logstring( "[AquaIntro] Adding objective marker for squad: " + level.var_bfcc77ba77980427 + " :SID " + var_cd7e11dc688992d4.sessionsquadid );
        activity_instance namespace_d7fa4530141146a5::function_e27cc6376feeb35c( level.var_bfcc77ba77980427, 0, 1 );
    }
    else
    {
        level ob_story_mission_utils::objective_marker_show( level.var_bfcc77ba77980427, function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 ) );
        logstring( "[AquaIntro] Showing objective marker for squad: " + level.var_bfcc77ba77980427 + " :SID" + var_cd7e11dc688992d4.sessionsquadid );
    }
    
    squadmembers = function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 );
    
    foreach ( member in squadmembers )
    {
        level.aqua_intro_activity.laptop_scriptable enablescriptableplayeruse( member );
    }
    
    utility::flag_wait( "player_used_aqua_laptop" );
    utility::flag_set( "laptop_interacted" );
    var_64bb57aa2d6e8b35 = function_8aa672a8312c4734( var_cd7e11dc688992d4 );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "post_tablet" ), 0.6 );
    thread function_7bbe59a1d193aca3( var_64bb57aa2d6e8b35 );
    
    if ( level.aqua_intro_activity.laptop_scriptable )
    {
        level.aqua_intro_activity.laptop_scriptable freescriptable();
    }
    
    logstring( "[AquaIntro] Hide objective marker for all players in squad: " + level.var_bfcc77ba77980427 + " :SID " + var_cd7e11dc688992d4.sessionsquadid );
    level ob_story_mission_utils::mission_objective_marker_hide( level.var_bfcc77ba77980427, squadmembers );
    story_contract_util::mark_complete( function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 ), #"aqua_intro" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3
// Checksum 0x1d330128, Offset: 0x540c
// Size: 0x54, Type: bool
function function_9c687beafaa9c227( player, skillref, desiredlevel )
{
    activeskills = player.activeskills;
    
    if ( !isdefined( activeskills ) )
    {
        return false;
    }
    
    if ( activeskills[ skillref ] && activeskills[ skillref ] == desiredlevel )
    {
        return true;
    }
    
    return false;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x33e582b1, Offset: 0x5469
// Size: 0x3e
function function_7bbe59a1d193aca3( var_64bb57aa2d6e8b35 )
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    convo_health_upgrade( var_64bb57aa2d6e8b35 );
    thread function_80bec4787d778a22( var_64bb57aa2d6e8b35 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x66838963, Offset: 0x54af
// Size: 0x194
function colosseum_exterior_objectives( activity_instance, var_cd7e11dc688992d4 )
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    done_notification = "colosseum_exterior_obj_done";
    var_2ec40eb41a3473d8 = "colosseum_exterior_obj_done_for_player";
    var_95744c12a9bd0d73 = "colosseum_enter";
    thread function_dc6ddb8a4427f974();
    logstring( "[AquaIntro] Colosseum Exterior Breadcrumbs Setup for Mission Struct - " );
    logstring( "[AquaIntro] Colosseum Exterior Breadcrumbs Setup for Mission Struct:  Data: squad_leader (" + var_cd7e11dc688992d4.team + ")" );
    logstring( "[AquaIntro] Colosseum Exterior Breadcrumbs Setup for Mission Struct:  Data: team (" + var_cd7e11dc688992d4.team + ")" );
    logstring( "[AquaIntro] Colosseum Exterior Breadcrumbs Setup for Mission Struct:  Data: Session Squad ID (" + var_cd7e11dc688992d4.sessionsquadid + ")" );
    players = function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 );
    
    foreach ( player in players )
    {
        logstring( "[AquaIntro] Colosseum Exterior Breadcrumbs Logic running for players:  player: " + player.name );
    }
    
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_95744c12a9bd0d73, "sat_ob_objectivemarker_location", done_notification, var_2ec40eb41a3473d8, function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 ), 0, 0, undefined, 1 );
    level waittill( done_notification );
    level notify( #"hash_4b4bb1ff0650b314" );
    utility::flag_set( done_notification );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xd111c1eb, Offset: 0x564b
// Size: 0x4a
function function_dc6ddb8a4427f974()
{
    level endon( #"hash_4b4bb1ff0650b314" );
    utility::flag_wait_any( "colosseum_interior_rear_decent", "colosseum_descent", "ring_boss_dead", "colosseum_interior_lounge_approach" );
    level.aqua_intro_activity waypoint_objective_handler::waypoint_objective_handler_cancel( "colosseum_enter" );
    level notify( #"colosseum_exterior_obj_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xac1ea797, Offset: 0x569d
// Size: 0x18b
function colosseum_interior_objectives( activity_instance, var_cd7e11dc688992d4 )
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    done_notification = "colosseum_interior_obj_done";
    var_2ec40eb41a3473d8 = "colosseum_interior_obj_done_for_player";
    var_95744c12a9bd0d73 = "colosseum_interior";
    thread function_3bdaef98175988b6();
    logstring( "[AquaIntro] Colosseum Interior Breadcrumbs Setup for Mission Struct - " );
    logstring( "[AquaIntro] Colosseum Interior Breadcrumbs Setup for Mission Struct:  Data: squad_leader (" + var_cd7e11dc688992d4.team + ")" );
    logstring( "[AquaIntro] Colosseum Interior Breadcrumbs Setup for Mission Struct:  Data: team (" + var_cd7e11dc688992d4.team + ")" );
    logstring( "[AquaIntro] Colosseum Interior Breadcrumbs Setup for Mission Struct:  Data: Session Squad ID (" + var_cd7e11dc688992d4.sessionsquadid + ")" );
    
    foreach ( player in var_cd7e11dc688992d4.players )
    {
        logstring( "[AquaIntro] Colosseum Interior Breadcrumbs Logic running for players:  player: " + player.name );
    }
    
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_95744c12a9bd0d73, "sat_ob_objectivemarker_location", done_notification, var_2ec40eb41a3473d8, function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 ), 0, 0, undefined, 1 );
    level waittill( done_notification );
    level notify( #"hash_626895fe3f3bb6d6" );
    utility::flag_set( done_notification );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x16f267d5, Offset: 0x5830
// Size: 0x45
function function_3bdaef98175988b6()
{
    level endon( #"hash_626895fe3f3bb6d6" );
    utility::flag_wait_any( "laptop_interacted", "colosseum_interior_lounge_approach", "ring_boss_dead" );
    level.aqua_intro_activity waypoint_objective_handler::waypoint_objective_handler_cancel( "colosseum_interior" );
    level notify( #"colosseum_interior_obj_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x62fe7840, Offset: 0x587d
// Size: 0x178
function colosseum_interior_ring_objectives( activity_instance, var_cd7e11dc688992d4 )
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    done_notification = "colosseum_interior_ring_obj_done";
    var_2ec40eb41a3473d8 = "colosseum_interior_ring_obj_done_for_player";
    var_95744c12a9bd0d73 = "colosseum_interior_ring";
    logstring( "[AquaIntro] Colosseum RING Breadcrumbs Setup for Mission Struct - " );
    logstring( "[AquaIntro] Colosseum RING Breadcrumbs Setup for Mission Struct:  Data: squad_leader (" + var_cd7e11dc688992d4.team + ")" );
    logstring( "[AquaIntro] Colosseum RING Breadcrumbs Setup for Mission Struct:  Data: team (" + var_cd7e11dc688992d4.team + ")" );
    logstring( "[AquaIntro] Colosseum RING Breadcrumbs Setup for Mission Struct:  Data: Session Squad ID (" + var_cd7e11dc688992d4.sessionsquadid + ")" );
    
    foreach ( player in var_cd7e11dc688992d4.players )
    {
        logstring( "[AquaIntro] Colosseum RING Breadcrumbs Logic running for players:  player: " + player.name );
    }
    
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_95744c12a9bd0d73, "sat_ob_objectivemarker_location", done_notification, var_2ec40eb41a3473d8, function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 ), 0, 0, undefined, 1 );
    level waittill( done_notification );
    utility::flag_set( done_notification );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xed031021, Offset: 0x59fd
// Size: 0x128
function function_8c603cd5c9c0dff9()
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    utility::flag_wait( "scriptables_ready" );
    utility::array_call( getscriptablearray( "colosseum_scriptable_doors", #targetname ), &setscriptablepartstate, "door", "closed" );
    utility::array_call( getentitylessscriptablearray( "colosseum_scriptable_doors", #targetname ), &setscriptablepartstate, "door", "closed" );
    utility::array_call( getscriptablearray( "colosseum_exit_doors", #script_noteworthy ), &setscriptablepartstate, "door", "invisible" );
    placed_doors = getentitylessscriptablearray( undefined, undefined, ( 44159.8, 22631.3, 290 ), 32, "door" );
    
    foreach ( door in placed_doors )
    {
        door scriptabledoorlock();
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x927d039a, Offset: 0x5b2d
// Size: 0x8b
function setup_fake_starts()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x91>" );
        devgui::add_devgui_func( "<dev string:x9b>", "<dev string:xb4>", &colosseum_exterior_setup, 0 );
        devgui::add_devgui_func( "<dev string:xcd>", "<dev string:xdd>", &function_6884ddd02e1721db, 0 );
        devgui::add_devgui_func( "<dev string:xed>", "<dev string:xfd>", &function_774d74c3483f2189, 0 );
        devgui::add_devgui_func( "<dev string:x10d>", "<dev string:x120>", &function_bf9df4fbbc4875df, 0 );
        devgui::add_devgui_func( "<dev string:x133>", "<dev string:x144>", &colosseum_interior_ring_setup, 0 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xb6f1d6bd, Offset: 0x5bc0
// Size: 0xe8
function teleport_players_to_start( struct_targetname )
{
    /#
        start_point = utility::getstruct( struct_targetname, "<dev string:x155>" );
        
        foreach ( player in level.aqua_intro_activity.playerparticipants )
        {
            point = utility::getrandompointincircle( start_point.origin, start_point.radius );
            point = getclosestpointonnavmesh( point );
            player setorigin( point );
            player setplayerangles( start_point.angles );
        }
    #/
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x25f44df1, Offset: 0x5cb0
// Size: 0x94
function setup_exclusion_zones( activity_instance )
{
    logstring( "[AquaIntro] Adding AISpawnDirectorAddObjectiveLocations" );
    function_1c4c7ef874191be2( "colosseum_exclusion_zone", ( 43770, 25076, 672 ), 4400, 1 );
    function_1c4c7ef874191be2( "junction_exclusion_zone", ( 20842, 20912, 646 ), 2700, 1 );
    function_1c4c7ef874191be2( "cliffside_exclusion_zone", ( 29120, 13806, 646 ), 2000, 1 );
    thread function_cb1874669e655110( "colosseum_exclusion_zone", activity_instance );
    thread function_cb1874669e655110( "junction_exclusion_zone", activity_instance );
    thread function_cb1874669e655110( "cliffside_exclusion_zone", activity_instance );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x88515a39, Offset: 0x5d4c
// Size: 0x3b
function function_cb1874669e655110( zone_name, activity_instance )
{
    level endon( #"game_ended" );
    activity_instance utility::waittill_any( "activity_ended", "instance_destroyed" );
    function_71799ce2c69ce5a9( zone_name );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x964cfe93, Offset: 0x5d8f
// Size: 0x1c6
function onplayerjoinsquad( params )
{
    self notify( #"hash_b6514a3ed361f011" );
    self endon( #"hash_b6514a3ed361f011" );
    player = self;
    player endon( #"disconnect" );
    story_contract_util::waittill_active( player, #"aqua_intro" );
    player thread function_3f8c1ad4f6f4c06c();
    
    if ( is_aqua_intro_complete() )
    {
        return;
    }
    
    var_cd7e11dc688992d4 = level.aqua_intro_activity.active_squads[ player.sessionsquadid ];
    
    if ( !var_cd7e11dc688992d4 )
    {
        logstring( "[AquaIntro] Running aqua main for squad id (" + player.sessionsquadid + ")" );
        logstring( "[AquaIntro] Running aqua main for Player Name (Squad Leader) (" + player.name + ")" );
        var_cd7e11dc688992d4 = { #sessionsquadid:player.sessionsquadid, #team:player.team, #var_d7bca97013a2d5d4:player };
        level.aqua_intro_activity.active_squads[ player.sessionsquadid ] = var_cd7e11dc688992d4;
        thread aqua_main( var_cd7e11dc688992d4 );
        thread function_4d218f5d7a697d97( var_cd7e11dc688992d4, player.sessionsquadid );
    }
    else
    {
        logstring( "[AquaIntro] Mission Struct was active for player: (" + var_cd7e11dc688992d4.var_d7bca97013a2d5d4.name + ")" );
        logstring( "[AquaIntro] Mission Struct Data: squad_leader (" + var_cd7e11dc688992d4.team + ")" );
        logstring( "[AquaIntro] Mission Struct Data: team (" + var_cd7e11dc688992d4.team + ")" );
        logstring( "[AquaIntro] Mission Struct Data: Session Squad ID (" + var_cd7e11dc688992d4.sessionsquadid + ")" );
    }
    
    function_b15c15ecb47f01be( var_cd7e11dc688992d4, player );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x152e8fd7, Offset: 0x5f5d
// Size: 0x9e
function function_3f8c1ad4f6f4c06c()
{
    self notify( #"hash_a72de127c052ba7a" );
    self endon( #"hash_a72de127c052ba7a" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    player = self;
    story_contract_util::waittill_active( player, #"aqua_intro" );
    utility::flag_wait( "aqua_activity_setup" );
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x160>" );
        return;
    }
    
    player utility::ent_flag_wait( "squad_play_begin" );
    function_d626cc76cae468c1( player, level.aqua_starting_loadout );
    utility::flag_wait( "sat_aqua_load_cine_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0x526cd19e, Offset: 0x6003
// Size: 0x392
function private function_b15c15ecb47f01be( var_cd7e11dc688992d4, player )
{
    var_cd7e11dc688992d4 ob_story_mission_utils::objective_marker_show( undefined, [ player ] );
    activity_participation::function_bc67362dace4370c( level.aqua_intro_activity, player, "PlayerJoinedSquad" );
    
    foreach ( interact in var_cd7e11dc688992d4.interacts )
    {
        interact enableplayeruse( player );
    }
    
    foreach ( interact in var_cd7e11dc688992d4.scriptable_interacts )
    {
        interact enablescriptableplayeruse( player );
    }
    
    foreach ( circle_objective in var_cd7e11dc688992d4.circle_objectives )
    {
        circle_objective showtoplayer( player );
    }
    
    if ( var_cd7e11dc688992d4.mission_ui )
    {
    }
    
    if ( var_cd7e11dc688992d4.current_loadout )
    {
        function_d626cc76cae468c1( player, var_cd7e11dc688992d4.current_loadout );
    }
    
    foreach ( abilitycase in level.var_119fe64f857f4bc7 )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, [ player ] );
    }
    
    foreach ( callback in var_cd7e11dc688992d4.add_player_callbacks )
    {
        profilestart();
        [[ callback ]]( player, var_cd7e11dc688992d4 );
        profilestop();
    }
    
    if ( getdvarint( @"hash_3d946ef6f19eb0c9", 0 ) > 0 )
    {
        utility::flag_wait( "ob_infil_completed" );
        wait 2;
        squadmembers = function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 );
        story_contract_util::mark_complete( squadmembers, #"aqua_intro" );
        
        foreach ( player in level.players )
        {
            hcorigin = ( 47290, 30437, 866 );
            player setorigin( hcorigin );
        }
        
        return;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1, eflags: 0x4
// Checksum 0x5eeaddda, Offset: 0x639d
// Size: 0x15f
function private function_7d01d9bdc1a809c5( params )
{
    player = self;
    var_cd7e11dc688992d4 = level.aqua_intro_activity.active_squads[ player.sessionsquadid ];
    is_squad_leader = var_cd7e11dc688992d4.var_d7bca97013a2d5d4 == player;
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
    
    waitframe();
    
    if ( var_cd7e11dc688992d4 && is_squad_leader )
    {
        new_squad_leader = squad_utility::getsquadleader( player_team, session_id );
        
        if ( new_squad_leader )
        {
            var_cd7e11dc688992d4.var_d7bca97013a2d5d4 = new_squad_leader;
            return;
        }
        
        logstring( "[AquaIntro] Resetting for squad ", session_id, " since all players left the match." );
        var_cd7e11dc688992d4 notify( #"squad_left_match" );
        function_216f10c03bf30fc9( var_cd7e11dc688992d4, session_id );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0xfac449a8, Offset: 0x6504
// Size: 0x3a
function private function_4d218f5d7a697d97( var_cd7e11dc688992d4, sessionsquadid )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 waittill( #"completed" );
    function_216f10c03bf30fc9( var_cd7e11dc688992d4, sessionsquadid );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0x6781a66, Offset: 0x6546
// Size: 0x19b
function private function_216f10c03bf30fc9( var_cd7e11dc688992d4, sessionsquadid )
{
    foreach ( circle in var_cd7e11dc688992d4.circle_objectives )
    {
        circle delete();
    }
    
    foreach ( interact in var_cd7e11dc688992d4.interacts )
    {
        interact delete();
    }
    
    foreach ( trigger in var_cd7e11dc688992d4.uplinkprops )
    {
        trigger delete();
    }
    
    var_cd7e11dc688992d4 ob_story_mission_utils::mission_objective_marker_clear();
    level.aqua_intro_activity.active_squads[ sessionsquadid ] = undefined;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xfa60beac, Offset: 0x66e9
// Size: 0x33b
function aqua_main( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    utility::flag_wait( "aqua_activity_setup" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    thread namespace_b19471c739bf2c83::function_c30841c325da9a4c();
    utility::flag_set( "cleanup_prop_only_merc_camps" );
    setup_fake_starts();
    setup_exclusion_zones( level.aqua_intro_activity );
    function_8c603cd5c9c0dff9();
    thread function_a135130088734ca3( var_cd7e11dc688992d4 );
    thread function_45a7634ec3442361( level.aqua_intro_activity );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    var_64bb57aa2d6e8b35 childthread aqua_music( var_cd7e11dc688992d4 );
    childthread aqua_intro( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    utility::flag_wait( "aqua_intro_done" );
    thread colosseum_objectives( level.aqua_intro_activity, var_cd7e11dc688992d4 );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "gas_station" ), 0.1 );
    childthread drone_launcher_hint( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "colosseum_descent", "pre_descend", 0.3, [ "gym_breadcrumbs_dead", "smoke_wall_dead", "bar_movers_dead", "bar_movers_1p_dead", "bar_movers_4p_dead", "casino_kickoff_dead" ] );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "gym_breadcrumbs_dead", "post_descend", 0.35, [ "smoke_wall_dead", "bar_movers_dead", "bar_movers_1p_dead", "bar_movers_4p_dead", "casino_kickoff_dead" ] );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "smoke_wall_dead", "post_smoke", 0.4, [ "bar_movers_dead", "bar_movers_1p_dead", "bar_movers_4p_dead", "casino_kickoff_dead" ] );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "bar_movers_dead", "bar", 0.4, [ "casino_kickoff_dead", "casino_kickoff_1p_dead", "casino_kickoff_4p_dead", "casino_wave2_4p_dead" ] );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "bar_movers_1p_dead", "bar", 0.4, [ "casino_kickoff_dead", "casino_kickoff_1p_dead", "casino_kickoff_4p_dead", "casino_wave2_4p_dead" ] );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "bar_movers_4p_dead", "bar", 0.4, [ "casino_kickoff_dead", "casino_kickoff_1p_dead", "casino_kickoff_4p_dead", "casino_wave2_4p_dead" ] );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "casino_kickoff_dead", "pre_boxing", 0.5, "laptop_interacted" );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "casino_kickoff_1p_dead", "pre_boxing", 0.5, "laptop_interacted" );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "casino_kickoff_4p_dead", "pre_boxing", 0.5, "laptop_interacted" );
    thread function_eff49af9973cb6e3( var_cd7e11dc688992d4, "casino_wave2_4p_dead", "pre_boxing", 0.5, "laptop_interacted" );
    level.aqua_intro_activity childthread function_2a57585193d4d938();
    childthread colosseum_main();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x8ec6f16b, Offset: 0x6a2c
// Size: 0xd
function is_aqua_intro_complete()
{
    return utility::flag( "laptop_interacted" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xbd3787d5, Offset: 0x6a42
// Size: 0x1d7
function aqua_intro( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    var_cd7e11dc688992d4 story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"aqua_intro" );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    level thread function_cddb50034003950e( var_cd7e11dc688992d4 );
    
    foreach ( abilitycase in level.var_119fe64f857f4bc7 )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, var_64bb57aa2d6e8b35.players );
    }
    
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_cin_aqua_intro_flythrough", { #timeout:25, #fadestartnone:1, #countdown:0, #players:var_64bb57aa2d6e8b35.players } );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_aqua_load", { #timeout:43, #fadestartnone:1, #countdown:0, #players:var_64bb57aa2d6e8b35.players } );
    utility::flag_set( "sat_aqua_load_cine_done" );
    var_cd7e11dc688992d4.var_d7bca97013a2d5d4 namespace_78b1c18caf50ee83::function_a6d314bf326b0e52( "aqua_intro" );
    utility::flag_wait( "ob_infil_completed" );
    wait 2;
    thread convo_play_intro_briefing( var_64bb57aa2d6e8b35 );
    level.aqua_intro_activity ob_story_mission_utils::function_b3e9457491e7af72( %"hash_788e0cb57ce53966", [ self ] );
    utility::flag_set( "aqua_intro_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xbf9196cc, Offset: 0x6c21
// Size: 0x3e
function convo_play_intro_briefing( var_64bb57aa2d6e8b35 )
{
    level endon( #"game_ended" );
    wait 1;
    overlord::playconversation( "aqua_infil_colosseum_convo", var_64bb57aa2d6e8b35.players );
    utility::flag_set( "convo_play_intro_briefing_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x25da6d1f, Offset: 0x6c67
// Size: 0x174
function drone_launcher_hint( var_cd7e11dc688992d4, var_64bb57aa2d6e8b35 )
{
    vehicle_supply_cache = utility::getstruct( "vehicle_crate", "targetname" );
    end_time = gettime() + 30000;
    player_arrived = 0;
    min_dist_squared = squared( 2500 );
    
    while ( !player_arrived && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        if ( gettime() > end_time )
        {
            break;
        }
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) && isdefined( vehicle_supply_cache ) )
            {
                f_dist_squared = distance2dsquared( vehicle_supply_cache.origin, player.origin );
                
                if ( f_dist_squared < min_dist_squared )
                {
                    player_arrived = 1;
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    if ( var_64bb57aa2d6e8b35.players.size == 0 )
    {
        return;
    }
    
    var_cd7e11dc688992d4 childthread function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_drone_launcher", &"sat_ob/hint_drone_launcher_gamepad", &"sat_ob/hint_drone_launcher_kbm" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 5
// Checksum 0x1b4e6088, Offset: 0x6de3
// Size: 0x119
function function_fde859de4858f491( players, toast_hint = "hint_wingsuit_deploy", toast_text = &"sat_ob/bigmap_avalon", var_d0f27fc78fd36d9a, delay = 0 )
{
    wait delay;
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            if ( var_d0f27fc78fd36d9a && !player usinggamepad() )
            {
                player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, var_d0f27fc78fd36d9a, 10 );
                continue;
            }
            
            player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, toast_text, 10 );
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0x97c025cf, Offset: 0x6f04
// Size: 0x93
function private function_e74dd638017a22f4( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_e_lp", 0, 120, 2, 16, 16 );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_f_lp", 1, 120, 2, 16, 16 );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1, eflags: 0x4
// Checksum 0xe54600ac, Offset: 0x6f9f
// Size: 0x2fa
function private aqua_music( mission )
{
    level endon( #"game_ended" );
    self notify( #"hash_6d4d4c5e0de6c74b" );
    self endon( #"hash_6d4d4c5e0de6c74b" );
    mission endon( #"reset" );
    squad = self;
    assert( squad.index == mission.sessionsquadid );
    assert( snd::issquad( squad ) );
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    
    if ( !arraycontains( [ "aqua_intro", "aqua_virus", "aqua_complete" ], var_950c5eed6692bff6.ddl_bit ) )
    {
        return;
    }
    
    utility::flag_wait( "aqua_activity_setup" );
    waittillframeend();
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    assert( isstruct( var_950c5eed6692bff6 ) && isstring( var_950c5eed6692bff6.ddl_bit ) );
    
    switch ( var_950c5eed6692bff6.ddl_bit )
    {
        case #"hash_e32da8ba4c7bc478":
        default:
            utility::flag_wait( "ob_infil_completed" );
            story_contract_util::function_800aae15896dfec6( squad.players, #"aqua_intro" );
            utility::flag_wait( "sat_aqua_load_cine_done" );
            snd_ob::squad_music( squad, "underscore_oneshots_a" );
            trigger_radius = spawn( "trigger_radius", ( 44736, 23460, 686 ), 0, 5536, 960 );
            trigger_radius snd::waittill_squad_trigger( squad );
            trigger_radius delete();
            trigger_radius = undefined;
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_e_lp", 5, 138, 1, 28, 42 );
            utility::flag_wait( "colosseum_descent" );
            snd_ob::squad_combat_state( squad, &function_e74dd638017a22f4 );
            utility::flag_wait( "ring_boss_dead" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "player_used_aqua_laptop" );
            snd_ob::squad_music( squad, "mx_avalon_contract_accept_e" );
            wait 8.69565;
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_e_lp", 4, 138, 1, 28, 42 );
        case #"hash_28174bf22c4e7503":
            story_contract_util::function_800aae15896dfec6( squad.players, #"aqua_virus" );
            utility::flag_wait( "interacted_with_samsite_keyboard_aqua_virus" );
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_e_lp", 6, 155, 17, 28, 42 );
        case #"hash_305c4bd9fa706925":
            story_contract_util::function_800aae15896dfec6( squad.players, #"aqua_complete" );
            snd_ob::squad_music( squad, "mx_avalon_contract_success_e" );
            level waittill( #"sam_used" );
            break;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1, eflags: 0x4
// Checksum 0xc36ff21, Offset: 0x72a1
// Size: 0x650
function private function_a135130088734ca3( var_cd7e11dc688992d4 )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    
    if ( !level.var_119fe64f857f4bc7 )
    {
        level.var_119fe64f857f4bc7 = [];
        crate_structs = utility::getstructarray( "aqua_vehicle_section_ability_crate", "targetname" );
        
        foreach ( crate_struct in crate_structs )
        {
            if ( crate_struct )
            {
                if ( crate_struct.script_noteworthy )
                {
                    var_b8200c906b85c972 = strtok( crate_struct.script_noteworthy, " " );
                    
                    if ( !isdefined( var_b8200c906b85c972[ 0 ] ) )
                    {
                        var_b8200c906b85c972[ 0 ] = "super_war_machine";
                    }
                    
                    if ( !isdefined( var_b8200c906b85c972[ 1 ] ) )
                    {
                        var_b8200c906b85c972[ 1 ] = "super_bubble_shield";
                    }
                    
                    crate = ob_item_select::function_95f9ecc2af4693f6( crate_struct.origin, var_b8200c906b85c972[ 0 ], var_b8200c906b85c972[ 1 ], #"default" );
                    ob_item_select::function_1dfd8b3bc8e33dd8( crate );
                    level.var_119fe64f857f4bc7[ level.var_119fe64f857f4bc7.size ] = crate;
                }
            }
        }
        
        crate_structs = utility::getstructarray( "coloseum_interior_ability_case_major", "targetname" );
        
        foreach ( struct in crate_structs )
        {
            abilities = strtok( struct.script_noteworthy, "|" );
            crate = ob_item_select::function_95f9ecc2af4693f6( struct.origin, abilities[ 0 ], abilities[ 1 ], #"default", struct.angles );
            ob_item_select::function_1dfd8b3bc8e33dd8( crate );
            level.var_119fe64f857f4bc7[ level.var_119fe64f857f4bc7.size ] = crate;
        }
        
        crate_structs = utility::getstructarray( "coloseum_interior_ability_case_minor", "targetname" );
        
        foreach ( struct in crate_structs )
        {
            abilities = strtok( struct.script_noteworthy, "|" );
            crate = ob_item_select::function_95f9ecc2af4693f6( struct.origin, abilities[ 0 ], abilities[ 1 ], #"tactical", struct.angles );
            ob_item_select::function_1dfd8b3bc8e33dd8( crate );
            level.var_119fe64f857f4bc7[ level.var_119fe64f857f4bc7.size ] = crate;
        }
        
        crate_structs = utility::getstructarray( "aqua_defense_ability_cache", "targetname" );
        
        foreach ( struct in crate_structs )
        {
            crate = ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_survival_life_drain", "super_drone_launcher", #"default" );
            ob_item_select::function_1dfd8b3bc8e33dd8( crate );
            level.var_119fe64f857f4bc7[ level.var_119fe64f857f4bc7.size ] = crate;
        }
    }
    
    structs = utility::getstructarray( "placed_ammo", "targetname" );
    
    foreach ( struct in structs )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( struct.origin, struct.angles );
        spawnoptions.var_fd47e835523b473f = 1;
        item = common_item::function_61c2c0251e742ffd( %"itemspawnentry:ob_sat_item_ammo", undefined, spawnoptions );
        item thread function_48e3efb3ea4dbc32( level.aqua_intro_activity );
    }
    
    ammo_restock_crate = utility::getstruct( "ammo_restock_crate", "targetname" );
    ammocrate = spawnscriptable( "military_ammo_restock_story", ammo_restock_crate.origin, ammo_restock_crate.angles );
    ammocrate thread function_48e3efb3ea4dbc32( level.aqua_intro_activity );
    equipment_structs = utility::getstructarray( "aqua_equipment", "targetname" );
    
    foreach ( struct in equipment_structs )
    {
        level.var_97db93a6b414090d = 1;
        spawnoptions = common_item::function_bc5ff2958b71a708( struct.origin, struct.angles );
        spawnoptions.var_fd47e835523b473f = 1;
        to_spawn = struct.script_noteworthy;
        
        if ( to_spawn == "ob_sat_item_mini_sentry_sm" )
        {
            to_spawn = "ob_sat_item_mini_sentry";
        }
        
        item = common_item::function_61c2c0251e742ffd( hashcat( %"itemspawnentry:", to_spawn ), 1, spawnoptions );
        item thread function_48e3efb3ea4dbc32( level.aqua_intro_activity );
    }
    
    if ( !utility::flag( "aqua_spawned_supply_caches" ) )
    {
        utility::flag_set( "aqua_spawned_supply_caches" );
        ob_story_mission_utils::function_e6799e9a19df2365( "defend_crates" );
        ob_story_mission_utils::function_e6799e9a19df2365( "colosseum_crates", %"hash_63c27913151b1772" );
        ob_story_mission_utils::function_e6799e9a19df2365( "vehicle_crate", %"hash_63c27913151b1772" );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3
// Checksum 0x6534ac1a, Offset: 0x78f9
// Size: 0x111
function setup_laptop_interact( activity_instance, origin_offset = ( 0, 0, 20 ), var_cd7e11dc688992d4 )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    struct = self;
    laptop_scriptable = spawnscriptable( "sat_ob_aquarius_laptop_scriptable", self.origin + origin_offset, self.angles );
    waitframe();
    
    if ( isdefined( laptop_scriptable ) )
    {
        activity_instance.laptop_scriptable = laptop_scriptable;
        laptop_scriptable setscriptablepartstate( "laptop_model", "visible" );
        laptop_scriptable setscriptablepartstate( "interact", "usable" );
        interaction::register_scriptable_interact( laptop_scriptable, &function_f555801788201cd8 );
        laptop_scriptable function_7653c765b6c7b815();
        laptop_scriptable.var_cd7e11dc688992d4 = var_cd7e11dc688992d4;
        
        if ( !isdefined( var_cd7e11dc688992d4.scriptable_interacts ) )
        {
            var_cd7e11dc688992d4.scriptable_interacts = [];
        }
        
        var_cd7e11dc688992d4.scriptable_interacts[ var_cd7e11dc688992d4.scriptable_interacts.size ] = laptop_scriptable;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x9ff92fd3, Offset: 0x7a12
// Size: 0x165
function function_f555801788201cd8( player )
{
    scriptable = self;
    
    if ( !isplayer( player ) || player.inlaststand || !isalive( player ) || player isreloading() || player isgestureplaying() )
    {
        return;
    }
    
    var_cd7e11dc688992d4 = level.aqua_intro_activity.active_squads[ player.sessionsquadid ];
    assert( isdefined( var_cd7e11dc688992d4 ), "<dev string:x192>" );
    player playsoundtoplayer( "fly_aqua_pickup_tablet", player );
    
    foreach ( member in function_9cdbaea6c78ac37b( var_cd7e11dc688992d4 ) )
    {
        scriptable disablescriptableplayeruse( member );
        member notify( #"hash_ffe69ea0a1997f22" );
    }
    
    scriptable.var_cd7e11dc688992d4.scriptable_interacts = arrayremove( scriptable.var_cd7e11dc688992d4.scriptable_interacts, scriptable );
    utility::flag_set( "player_used_aqua_laptop" );
    var_cd7e11dc688992d4 notify( #"player_used_aqua_laptop" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xe52887e9, Offset: 0x7b7f
// Size: 0x140
function function_71da1d2641051c1( player )
{
    scriptable = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.inlaststand || !isalive( player ) )
    {
        return;
    }
    
    if ( player isgestureplaying() && player isswimming() )
    {
        is_swimming = 1;
    }
    
    if ( !is_swimming && ( player isreloading() || player isgestureplaying() ) )
    {
        return;
    }
    
    squad_struct = level.aqua_intro_activity.active_squads[ player.sessionsquadid ];
    assert( isdefined( squad_struct ), "<dev string:x192>" );
    
    foreach ( member in function_9cdbaea6c78ac37b( squad_struct ) )
    {
        scriptable disablescriptableplayeruse( member );
        member notify( #"hash_ffe69ea0a1997f22" );
    }
    
    squad_struct notify( #"hash_797769f0068ad09a" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x3346749e, Offset: 0x7cc7
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xc8312a83, Offset: 0x7cf5
// Size: 0x236
function function_5a3a3cf897b379b3()
{
    level.var_53153714629116b9 = undefined;
    level.shield_spawn = undefined;
    level.var_5e7bd351b940c391 = undefined;
    level.shields_count = undefined;
    level.modifyvehicledamage = undefined;
    utility::flag_clear( "cleanup_prop_only_merc_camps" );
    utility::flag_clear( "rpg_interceptors_spawned" );
    utility::flag_clear( "colosseum_exterior_ai_spawned" );
    utility::flag_clear( "colosseum_interior_gym_enter" );
    utility::flag_clear( "colosseum_interior_rear_decent" );
    utility::flag_clear( "colosseum_interior_lounge_approach" );
    utility::flag_clear( "aqua_activity_setup" );
    utility::flag_clear( "colosseum_exterior_obj_done" );
    utility::flag_clear( "colosseum_interior_obj_done" );
    utility::flag_clear( "colosseum_interior_ring_obj_done" );
    utility::flag_clear( "player_used_aqua_laptop" );
    utility::flag_clear( "laptop_interacted" );
    utility::flag_clear( "sat_aqua_load_cine_done" );
    utility::flag_clear( "aqua_intro_done" );
    utility::flag_clear( "pre_descend" );
    utility::flag_clear( "post_descend" );
    utility::flag_clear( "post_smoke" );
    utility::flag_clear( "bar" );
    utility::flag_clear( "pre_boxing" );
    utility::flag_clear( "enter_underground_convo_done" );
    utility::flag_clear( "post_tablet_conversation_done" );
    utility::flag_clear( "aqua_virus_started" );
    utility::flag_clear( "sam_site_breadcrumb_obj_done" );
    utility::flag_clear( "interacted_with_samsite_keyboard_aqua_virus" );
    utility::flag_clear( "checkpoint_set_samsite" );
    utility::flag_clear( "squad_respawned" );
    utility::flag_clear( "sam_site_breadcrumbs_setup" );
    utility::flag_clear( "convo_play_intro_briefing_done" );
    utility::flag_clear( "convo_followup_intro_done" );
    utility::flag_clear( "colosseum_descent" );
    utility::flag_clear( "gym_breadcrumbs_dead" );
    utility::flag_clear( "smoke_wall_dead" );
    utility::flag_clear( "bar_movers_dead" );
    utility::flag_clear( "bar_movers_1p_dead" );
    utility::flag_clear( "bar_movers_4p_dead" );
    utility::flag_clear( "casino_kickoff_dead" );
    utility::flag_clear( "casino_kickoff_1p_dead" );
    utility::flag_clear( "casino_kickoff_4p_dead" );
    utility::flag_clear( "casino_wave2_4p_dead" );
    utility::flag_clear( "ring_generics_dead" );
    utility::flag_clear( "ring_robots_dead" );
    utility::flag_clear( "ring_boss_dead" );
    logstring( "[AquaIntro] CLEARED ALL THE FLAGS " );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x455b439b, Offset: 0x7f33
// Size: 0x74
function respawn_on_destroyed( activity, variant )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance waittill( #"instance_destroyed" );
    wait 1;
    
    if ( isdefined( level.aqua_house_info ) )
    {
        logstring( "[AquaIntro] - restarting Activty from level.aqua_house_info" );
        level ob_activity_manager::ob_activity_instance_init( level.aqua_house_info );
        return;
    }
    
    logstring( "[AquaIntro] - FAILED to find level.aqua_house_info" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xe9822c46, Offset: 0x7faf
// Size: 0x220
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( level.aqua_intro_activity.laptop_scriptable )
    {
        level.aqua_intro_activity.laptop_scriptable freescriptable();
        level.aqua_intro_activity.laptop_scriptable = undefined;
    }
    
    placed_doors = getentitylessscriptablearray( undefined, undefined, ( 44159.8, 22631.3, 290 ), 32, "door" );
    
    foreach ( door in placed_doors )
    {
        door scriptabledoorunlock();
    }
    
    level callback::remove( #"on_spawn_checkpoint_respawn", &function_31e371108b89570d );
    mission_structs = activity_instance.active_squads;
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        squad = teams::function_72b89edf6b47c40a( var_cd7e11dc688992d4 );
        
        if ( isdefined( squad ) )
        {
            squad.respawnlocations = undefined;
        }
        
        logstring( "[AquaIntro] Cleaning up Squad Struct for " + var_cd7e11dc688992d4.var_d7bca97013a2d5d4.name );
        var_cd7e11dc688992d4 notify( #"completed" );
    }
    
    logstring( "[AquaIntro] Clearing Active Squads " );
    activity_instance.active_squads = [];
    
    if ( level.var_bfcc77ba77980427 )
    {
        level ob_story_mission_utils::objective_marker_clear( level.var_bfcc77ba77980427 );
        level.var_bfcc77ba77980427 = undefined;
    }
    
    logstring( "[AquaIntro] DESTROYING ACTIVITY " );
    function_5a3a3cf897b379b3();
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xe4b387df, Offset: 0x81d7
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xc489dcc2, Offset: 0x81ef
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x6dbdbf9f, Offset: 0x8245
// Size: 0x42
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    logstring( "[AquaIntro] PLAYER joined ACTIVITY AQUARIUS intro" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x33f730c7, Offset: 0x828f
// Size: 0x13a
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    logstring( "[AquaIntro] PLAYER left ACTIVITY AQUARIUS intro" );
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    if ( !activity_instance.playerparticipants.size )
    {
        level notify( #"hash_8ea2d5813fbf0735" );
        mission_structs = level.aqua_intro_activity.active_squads;
        
        foreach ( var_cd7e11dc688992d4 in mission_structs )
        {
            logstring( "[AquaIntro] Cleaning up Squad Struct in player_left_activity(..) for " + var_cd7e11dc688992d4.var_d7bca97013a2d5d4.name );
            var_cd7e11dc688992d4 notify( #"completed" );
        }
        
        activity_instance.active_squads = [];
        
        if ( activity_instance_common::getactivitystate( activity_instance ) == "Active" )
        {
            activity_instance_common::endactivity( activity_instance, 0 );
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x777c3524, Offset: 0x83d1
// Size: 0x23
function play_dialog_intro( player_participants )
{
    overlord::playconversation( "aqua_infil_colosseum_convo", player_participants );
    function_88edf751cd33a109( player_participants );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x9eff62d4, Offset: 0x83fc
// Size: 0x1a
function function_88edf751cd33a109( player_participants )
{
    overlord::playconversation( "aqua_intro_kagan_conversation", player_participants );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0xd013f51b, Offset: 0x841e
// Size: 0x141
function karma_proximity_trigger_watcher()
{
    self endon( #"death_or_disconnect" );
    karma_proximity_trigger = getnoentvolumearray( "aquarius_intro_karma_proximity_trigger", #targetname )[ 0 ];
    
    if ( karma_proximity_trigger )
    {
        self endon( #"hash_ffe69ea0a1997f22" );
        self endon( #"hash_422b2061ab9efca1" );
        
        while ( true )
        {
            karma_proximity_trigger waittill( #"trigger", ent );
            
            if ( ent == self )
            {
                var_d7bca97013a2d5d4 = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
                squad = var_d7bca97013a2d5d4 squad_utility::getsquadmembers( var_d7bca97013a2d5d4.team, 0 );
                overlord::playevent( "aqua_intro_karma_reached", squad );
                
                foreach ( var_8a958389218cbbb3 in squad )
                {
                    if ( var_8a958389218cbbb3 != self )
                    {
                        var_8a958389218cbbb3 notify( #"hash_422b2061ab9efca1" );
                    }
                }
                
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xe8991e61, Offset: 0x8567
// Size: 0x28
function function_8aa672a8312c4734( squad_struct )
{
    return teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x7e09678e, Offset: 0x8598
// Size: 0x5c
function function_9cdbaea6c78ac37b( squad_struct )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    
    if ( !var_64bb57aa2d6e8b35.players.size )
    {
        squad_struct notify( #"squad_empty" );
    }
    
    return var_64bb57aa2d6e8b35.players;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xfcbae463, Offset: 0x85fd
// Size: 0x37
function function_4631d0ed5d05501d( killstreakref, origin )
{
    ksscriptable = spawnscriptable( killstreakref, origin, ( 0, 0, 0 ) );
    return ksscriptable;
}

/#

    // Namespace sat_ob_contract_aquarius_house_movie
    // Params 4
    // Checksum 0x479d2ae0, Offset: 0x863d
    // Size: 0x79, Type: dev
    function debug_draw_sphere( origin, radius, var_2a5fa9b2868542da, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        level endon( #"game_ended" );
        level endon( var_2a5fa9b2868542da );
        
        if ( getdvarint( @"scr_debug_aqua", 0 ) < 1 )
        {
            return;
        }
        
        while ( true )
        {
            sphere( origin, radius, color, 0, 1 );
            waitframe();
        }
    }

#/

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x88025843, Offset: 0x86be
// Size: 0xb
function get_current_activity()
{
    return level.aqua_intro_activity;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 0
// Checksum 0x56e43d44, Offset: 0x86d2
// Size: 0xca
function get_squad_data_global()
{
    activity = get_current_activity();
    mission_structs = activity.active_squads;
    squad_datas = [];
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        squad_datas[ squad_datas.size ] = var_64bb57aa2d6e8b35;
    }
    
    return squad_datas;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 3
// Checksum 0xe7c903d7, Offset: 0x87a5
// Size: 0x62
function function_1091be44e23ef2ad( squad_struct, delay, flag )
{
    level endon( #"game_ended" );
    
    if ( flag )
    {
        utility::flag_wait( flag );
    }
    
    if ( delay )
    {
        wait delay;
    }
    
    player_participants = function_e16b62019aa8c4f( squad_struct );
    overlord::playconversation( "aqua_infil_colosseum_convo", player_participants );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xda1dae4d, Offset: 0x880f
// Size: 0x83
function function_8e868d0c75280fdb( var_64bb57aa2d6e8b35, delay )
{
    level endon( #"game_ended" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    utility::flag_wait( "convo_play_intro_briefing_done" );
    level squad_vehicle_enter_watcher( 60, "gas_station_dead" );
    
    if ( delay )
    {
        wait delay;
    }
    
    overlord::playconversation( "aqua_stronghold_intro_travel_long", level.aqua_intro_activity.playerparticipants );
    utility::flag_set( "convo_followup_intro_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0xcd967461, Offset: 0x889a
// Size: 0x47
function squad_vehicle_enter_watcher( timeout = 2, endonstr = "stop_squad_vehicle_enter_watcher" )
{
    self endon( #"hash_9898af34d0439e94", endonstr );
    wait timeout;
    self notify( #"hash_9898af34d0439e94" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xcce0a19, Offset: 0x88e9
// Size: 0xfb
function function_e16b62019aa8c4f( squad_struct )
{
    players = [];
    
    if ( !squad_struct )
    {
        global_squads = get_squad_data_global();
        
        foreach ( squad in global_squads )
        {
            if ( squad.players.size > 0 )
            {
                players = arraycombineunique( players, squad.players );
            }
        }
        
        return players;
    }
    
    if ( squad_struct.players && squad_struct.players.size > 0 )
    {
        return squad_struct.players;
    }
    
    if ( players.size == 0 )
    {
        return level.players;
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xc55838f4, Offset: 0x89ec
// Size: 0x18d
function function_d6df69f5a3680c4d( squad_struct )
{
    level endon( #"colosseum_descent" );
    level endon( #"hash_8de77499682d5308" );
    level endon( #"game_ended" );
    level.aqua_intro_activity endon( #"instance_destroyed" );
    spot_trigger = utility::getstruct( "colosseum_spot_trigger", "targetname" );
    
    while ( true )
    {
        spot_trigger waittill( #"trigger", who );
        
        if ( who.owner && isplayer( who.owner ) )
        {
            break;
        }
        
        if ( isplayer( who ) )
        {
            break;
        }
    }
    
    utility::flag_wait_any( "rpg_interceptors_spawned", "colosseum_exterior_ai_spawned" );
    mission_structs = level.aqua_intro_activity.active_squads;
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "pre_colosseum" ), 0.2 );
        thread function_3cc6b8aa11d7f36b( var_64bb57aa2d6e8b35 );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x16510c47, Offset: 0x8b81
// Size: 0x3a
function function_3cc6b8aa11d7f36b( squad_struct )
{
    player_participants = function_e16b62019aa8c4f( squad_struct );
    utility::flag_wait( "convo_followup_intro_done" );
    overlord::playconversation( "aqua_colosseum_reveal", player_participants );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x193ae4f5, Offset: 0x8bc3
// Size: 0x62
function function_a38ef6e63f7c7610( squad_struct, var_704aa5dd244e4fba = 3 )
{
    level endon( #"game_ended" );
    utility::flag_wait( "enter_underground_convo_done" );
    wait var_704aa5dd244e4fba;
    player_participants = function_e16b62019aa8c4f( squad_struct );
    overlord::playconversation( "aqua_underground_early_combat", self.playerparticipants );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x7d1bc775, Offset: 0x8c2d
// Size: 0x4e
function function_26f488e58538a7dd( squad_struct, var_704aa5dd244e4fba = 3 )
{
    level endon( #"game_ended" );
    level endon( #"colosseum_interior_lounge_approach" );
    wait var_704aa5dd244e4fba;
    overlord::playconversation( "aqua_kill_commander", self.playerparticipants );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x832facc7, Offset: 0x8c83
// Size: 0x62
function function_2ebd6733307e2d50( squad_struct, var_704aa5dd244e4fba = 3 )
{
    level endon( #"game_ended" );
    level endon( #"colosseum_interior_lounge_approach" );
    wait var_704aa5dd244e4fba;
    player_participants = function_e16b62019aa8c4f( squad_struct );
    overlord::playconversation( "aqua_underground_combat_encouragement", self.playerparticipants );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2
// Checksum 0x223e8b05, Offset: 0x8ced
// Size: 0xf9
function function_d5036856bfb08a41( squad_struct, var_704aa5dd244e4fba = 3 )
{
    level endon( #"game_ended" );
    wait var_704aa5dd244e4fba;
    mission_structs = level.aqua_intro_activity.active_squads;
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        player_participants = function_e16b62019aa8c4f( var_64bb57aa2d6e8b35 );
        overlord::playconversation( "aqua_underground_encounter_robots", player_participants );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x1d5d5d3a, Offset: 0x8dee
// Size: 0x2d
function function_28506303ef365913( squad_struct )
{
    overlord::playconversation( "aqua_enter_underground_convo", self.playerparticipants );
    utility::flag_set( "enter_underground_convo_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xc2b9d0dd, Offset: 0x8e23
// Size: 0x56
function convo_health_upgrade( squad_struct )
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    player_participants = function_e16b62019aa8c4f( squad_struct );
    overlord::playevent( "tacb_wchealthupgrade", player_participants, 0.25, undefined, 1 );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0xd1dcf490, Offset: 0x8e81
// Size: 0x65
function function_80bec4787d778a22( squad_struct )
{
    level.aqua_intro_activity endon( #"instance_destroyed" );
    level endon( #"hash_8ea2d5813fbf0735" );
    wait 0.5;
    player_participants = function_e16b62019aa8c4f( squad_struct );
    overlord::playconversation( "aqua_after_grabbing_tablet_convo", player_participants, 0.5 );
    utility::flag_set( "post_tablet_conversation_done" );
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x3d3009ab, Offset: 0x8eee
// Size: 0xb8
function function_45a7634ec3442361( activity_instance )
{
    structs = utility::getstructarray( "aqua_veh_sat_medium_truck_mg_ob", "targetname" );
    
    foreach ( struct in structs )
    {
        struct.vehicle = function_51b22f2acf0c668( struct, activity_instance );
        struct.vehicle thread function_48e3efb3ea4dbc32( activity_instance );
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 2, eflags: 0x4
// Checksum 0x678fb479, Offset: 0x8fae
// Size: 0xac
function private function_51b22f2acf0c668( spawn_struct, activity_instance )
{
    spawn_data = { #triggerrecycle:1, #var_499a16b493ff31ed:1, #initai:0, #team:"neutral", #angles:spawn_struct.angles, #origin:spawn_struct.origin };
    spawn_data vehicle_spawn::prevent_respawn();
    spawn_fail = {};
    vehicle = activity_instance ob_resource_manager::activity_spawn_vehicle( %"hash_56311b5cc8c94835", spawn_data, spawn_fail );
    return vehicle;
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1
// Checksum 0x1c68e5ba, Offset: 0x9063
// Size: 0x68
function function_48e3efb3ea4dbc32( activity_instance )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    activity_instance utility::waittill_any( "activity_ended", "instance_destroyed" );
    
    if ( isent( self ) )
    {
        activity_instance ob_resource_manager::function_360d7e0860217cf4( self );
    }
    
    if ( isent( self ) )
    {
        self delete();
        return;
    }
    
    if ( self isscriptableinstance() )
    {
        self freescriptable();
    }
}

// Namespace sat_ob_contract_aquarius_house_movie
// Params 1, eflags: 0x4
// Checksum 0x51516846, Offset: 0x90d3
// Size: 0xb7
function private function_cddb50034003950e( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    var_cd7e11dc688992d4 endon( #"completed" );
    
    if ( getdvarint( @"hash_ac9c0ae5e77db9d5", 0 ) )
    {
        return;
    }
    
    utility::flag_wait( "aqua_activity_setup" );
    
    if ( !getdvarint( @"hash_5991a22fd2856409", 0 ) )
    {
        if ( !isdefined( level.aqua_oob_volumes ) )
        {
            level.aqua_oob_volumes = getnoentvolumearray( "aqua_oob_volume", #targetname );
        }
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    childthread story_contract_util::function_cddb50034003950e( var_64bb57aa2d6e8b35, level.aqua_oob_volumes );
}

