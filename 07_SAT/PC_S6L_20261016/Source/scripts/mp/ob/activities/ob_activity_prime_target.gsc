// scripts\mp\ob\activities\ob_activity_prime_target.gsc  (hash_76d5a2ef1004624b.gscc) (size: 9097 Bytes / 0x2389 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8114ef23 (2165632803)
// size ...... 9097 (0x2389)
// includes .. 17  (offset: 0x21d9)
// strings ... 22  (offset: 0x2261)
// dev strs .. 0   (offset: 0x2389)
// exports ... 27  (offset: 0x150d)
// cseg ...... 0x23d + 0x12d0 (0x150d)
// imports ... 73  (offset: 0x1945)
// animtree1 . 0   (offset: 0x2389)
// animtree2 . 0   (offset: 0x2389)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_prime_target;

// Namespace ob_activity_prime_target
// Params 0, eflags: 0x5
// Checksum 0xf342e333, Offset: 0x25b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_prime_target", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_prime_target
// Params 0, eflags: 0x4
// Checksum 0xce390492, Offset: 0x284
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_PRIME_TARGET", &prime_target_activity_type_init );
}

// Namespace ob_activity_prime_target
// Params 0
// Checksum 0x1e5b116f, Offset: 0x29f
// Size: 0x8c
function prime_target_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_PRIME_TARGET", 0, &prime_target_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_PRIME_TARGET", 1, &prime_target_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_PRIME_TARGET", 2, &prime_target_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_PRIME_TARGET", 3, &prime_target_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_PRIME_TARGET", 5, &function_8062aa7db47639d4 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_a2a8f7585dcd7829, "REV_OB_PRIME_TARGET" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_297a9a4a4c8b609, "REV_OB_PRIME_TARGET" );
}

// Namespace ob_activity_prime_target
// Params 0
// Checksum 0x9164106d, Offset: 0x333
// Size: 0x114
function prime_target_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    self.handler_list = [ "karm", "mars" ];
    ref_struct = utility::getstruct( self.varianttag, "script_noteworthy" );
    
    if ( ref_struct )
    {
        activity_instance.encounter_spawntarget = ref_struct;
        activity_instance.difficulty_region = region_difficulty_manager::get_region_difficulty( ref_struct.origin );
    }
    else
    {
        activity_instance.difficulty_region = "difficulty_easy";
    }
    
    thread setup_drones();
    activity_participation::function_a45fd1c5cc774007( self );
    activity_instance.encounter_id = function_1521d30229f250f9();
    activity_instance_common::function_46135a69bddfec2c( self );
    
    if ( !isdefined( activity_instance.objidnum ) )
    {
        activity_instance.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_primetarget", 0, 1 );
    }
}

// Namespace ob_activity_prime_target
// Params 0
// Checksum 0x3f9a705c, Offset: 0x44f
// Size: 0x29
function prime_target_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
}

// Namespace ob_activity_prime_target
// Params 0
// Checksum 0x74244d12, Offset: 0x480
// Size: 0x10f
function function_1521d30229f250f9()
{
    self endon( #"activity_ended" );
    
    if ( !isdefined( self.var_91c91f4a631c481d ) )
    {
        self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    }
    
    encountername = "PRIME_TARGET_WHITEBOX_enc_vol";
    
    if ( self.var_91c91f4a631c481d )
    {
        var_8570213e503964fc = utility::array_random( self.var_91c91f4a631c481d.minionencounters );
        self.minion_request_id = activity_ai_encounters::function_92b671064b0b1ce2( self.varianttag + "_enc_vol", 1, 1, 1, 2 );
        activity_ai_encounters::function_6bf4ff2fbde584ee( self.minion_request_id, &finished_spawning_guards, self );
        var_d7d1d36dc878ea81 = utility::array_random( self.var_91c91f4a631c481d.bossencounters );
        self.boss_request_id = activity_ai_encounters::function_92b671064b0b1ce2( self.varianttag + "_boss_enc_vol", 1, 1, 1, 2 );
        activity_ai_encounters::function_6bf4ff2fbde584ee( self.boss_request_id, &finished_spawning_boss, self );
        return self.boss_request_id;
    }
}

// Namespace ob_activity_prime_target
// Params 1
// Checksum 0xa4f3ce2b, Offset: 0x598
// Size: 0x58
function prime_target_activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.primetarget.interact_target )
    {
        activity_instance.primetarget.interact_target delete();
    }
}

// Namespace ob_activity_prime_target
// Params 0
// Checksum 0xeb6550cc, Offset: 0x5f8
// Size: 0x30
function prime_target_activity_destroy()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activity_instance.objidnum );
}

// Namespace ob_activity_prime_target
// Params 1
// Checksum 0x2ec18027, Offset: 0x630
// Size: 0x4e
function function_8062aa7db47639d4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace ob_activity_prime_target
// Params 1
// Checksum 0xab1ac7e5, Offset: 0x686
// Size: 0x1b4
function function_a2a8f7585dcd7829( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
    
    if ( !isdefined( self.objidnum ) )
    {
        self.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_primetarget", 0, 1 );
    }
    
    if ( self.targetseen )
    {
        function_702722e54a73d745( self );
        
        foreach ( player in player_list )
        {
            objective_addclienttomask( self.objidnum, player );
        }
        
        objective_showtoplayersinmask( self.objidnum );
    }
    
    if ( !isdefined( self.var_7ed173ac8d70d380 ) )
    {
        self.var_7ed173ac8d70d380 = [];
    }
    
    foreach ( player in player_list )
    {
        function_7ca11c236dfce30e( player );
        
        if ( !arraycontains( self.var_7ed173ac8d70d380, player ) )
        {
            thread ob_activity_vo_utility::function_639b0047db8aec67( self, "prime_target_brief" );
            self.var_7ed173ac8d70d380[ self.var_7ed173ac8d70d380.size ] = player;
        }
    }
}

// Namespace ob_activity_prime_target
// Params 1
// Checksum 0xb2203a96, Offset: 0x842
// Size: 0xa6
function function_297a9a4a4c8b609( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( self.objidnum )
    {
        foreach ( player in player_list )
        {
            objective_removeclientfrommask( self.objidnum, player );
        }
    }
}

// Namespace ob_activity_prime_target
// Params 0, eflags: 0x4
// Checksum 0x2ebf1370, Offset: 0x8f0
// Size: 0x68
function private get_difficulty_index()
{
    switch ( self.difficulty_region )
    {
        case #"hash_7bb2cd766703d463":
            return 0;
        case #"hash_af83e47edfa8900a":
            return 1;
        case #"hash_5343b465e56ec9a4":
            return 2;
        case #"hash_651f76c0ad6741ec":
        case #"hash_c0250ffc2e87f2ff":
            return 3;
        default:
            return 0;
    }
}

// Namespace ob_activity_prime_target
// Params 0, eflags: 0x4
// Checksum 0x66d98a01, Offset: 0x960
// Size: 0x12a
function private setup_drones()
{
    drone_structs = utility::getstructarray( self.varianttag + "_drone_spawnpoint", "targetname" );
    self.drone_spawnpoints = [];
    activity_instance = self;
    
    if ( drone_structs.size )
    {
        self.difficulty_region = region_difficulty_manager::get_region_difficulty( drone_structs[ 0 ].origin );
    }
    
    ob_flying_drone::setup_helper_drones();
    drone_types = [ "shock", "turret", "explosive" ];
    var_cdffe119ed60d14d = utility::array_random( drone_types );
    
    foreach ( drone_struct in drone_structs )
    {
        spawn_path_array = [ drone_struct.origin ];
        thread ob_flying_drone::spawn_helper_drone( var_cdffe119ed60d14d, drone_struct, spawn_path_array );
    }
}

// Namespace ob_activity_prime_target
// Params 2
// Checksum 0x696ef3c1, Offset: 0xa92
// Size: 0x4f
function finished_spawning_guards( requestid, activity_instance )
{
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    thread function_9e2145490f677c56( var_41f9287c4987add7.ai, activity_instance );
    thread function_1d3ef156f9c6be50( var_41f9287c4987add7.ai, activity_instance );
}

// Namespace ob_activity_prime_target
// Params 2
// Checksum 0xf768d86a, Offset: 0xae9
// Size: 0x127
function finished_spawning_boss( requestid, activity_instance )
{
    activity_instance endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    level endon( #"game_ended" );
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    activity_instance.boss = var_41f9287c4987add7.ai;
    
    if ( var_41f9287c4987add7 && var_41f9287c4987add7.ai.size > 0 )
    {
        primetarget = utility::array_random( activity_instance.boss );
        activity_instance.primetarget = primetarget;
        primetarget.activity_instance = activity_instance;
        primetarget.activityboss = 1;
        primetarget thread function_95cc7a3181b74225( requestid );
        primetarget callback::add( #"on_ai_killed", &on_boss_killed );
        activity_instance thread function_75ac49c1ad97db29();
        function_9e2145490f677c56( var_41f9287c4987add7.ai, activity_instance );
        thread function_1d3ef156f9c6be50( var_41f9287c4987add7.ai, activity_instance );
        function_702722e54a73d745( activity_instance );
        return;
    }
    
    activity_instance_common::endactivity( activity_instance, 0 );
}

// Namespace ob_activity_prime_target
// Params 2
// Checksum 0xa9d8c152, Offset: 0xc18
// Size: 0xd3
function function_9e2145490f677c56( agents, activity_instance )
{
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    level endon( #"game_ended" );
    
    foreach ( agent in agents )
    {
        if ( !agent.patroldata )
        {
            thread ai_spawn_director::_wander( agent, agent.goalradius, 0, agent.goalpos );
        }
    }
}

// Namespace ob_activity_prime_target
// Params 2
// Checksum 0xa73098f7, Offset: 0xcf3
// Size: 0x92
function function_1d3ef156f9c6be50( agents, activity_instance )
{
    foreach ( agent in agents )
    {
        thread agent_death_monitor( agent, activity_instance );
        thread agent_damage_monitor( agent, activity_instance );
    }
}

// Namespace ob_activity_prime_target
// Params 2
// Checksum 0xce3d5489, Offset: 0xd8d
// Size: 0x67
function agent_death_monitor( agent, activity_instance )
{
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    agent waittill( #"death", attacker );
    
    if ( arraycontains( activity_instance.playerparticipants, attacker ) )
    {
        activity_instance function_7ca11c236dfce30e( attacker );
    }
}

// Namespace ob_activity_prime_target
// Params 2
// Checksum 0x46077c19, Offset: 0xdfc
// Size: 0x89
function agent_damage_monitor( agent, activity_instance )
{
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    self endon( #"death" );
    
    while ( isalive( agent ) )
    {
        agent waittill( #"damage", amount, attacker );
        
        if ( arraycontains( activity_instance.playerparticipants, attacker ) )
        {
            activity_instance function_7ca11c236dfce30e( attacker );
        }
    }
}

// Namespace ob_activity_prime_target
// Params 1
// Checksum 0xbae9cbdc, Offset: 0xe8d
// Size: 0x3c
function function_7ca11c236dfce30e( player )
{
    if ( !isdefined( self.var_fe1f3bc99d60c415 ) )
    {
        self.var_fe1f3bc99d60c415 = [];
    }
    
    self.var_fe1f3bc99d60c415[ player.guid ] = gettime();
}

// Namespace ob_activity_prime_target
// Params 1
// Checksum 0x82c16941, Offset: 0xed1
// Size: 0x99
function function_702722e54a73d745( activity_instance )
{
    if ( activity_instance.primetarget && isalive( activity_instance.primetarget ) )
    {
        objidpoolmanager::update_objective_onentity( activity_instance.objidnum, activity_instance.primetarget );
        objidpoolmanager::objective_set_play_intro( activity_instance.objidnum, 0 );
        objidpoolmanager::update_objective_setzoffset( activity_instance.objidnum, 100 );
        return;
    }
    
    if ( activity_instance.playerparticipants.size == 0 )
    {
        activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activity_instance.objidnum );
    }
}

// Namespace ob_activity_prime_target
// Params 0
// Checksum 0x70b7ac18, Offset: 0xf72
// Size: 0x2ef
function function_75ac49c1ad97db29()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        if ( isalive( activity_instance.primetarget ) )
        {
            for ( remainingplayers = activity_instance.playerparticipants; remainingplayers.size > 0 ; remainingplayers = arrayremove( remainingplayers, playersquad ) )
            {
                squadabandoned = 1;
                player = utility::array_get_first_item( remainingplayers );
                playersquad = activity_player_common::function_44ef43ff1f6d21d4( player );
                
                foreach ( squadmember in playersquad )
                {
                    if ( distance2dsquared( squadmember.origin, activity_instance.encounter_spawntarget.origin ) < 36000000 || activity_instance.var_fe1f3bc99d60c415[ squadmember.guid ] && gettime() - activity_instance.var_fe1f3bc99d60c415[ squadmember.guid ] < 20000 )
                    {
                        squadabandoned = 0;
                        break;
                    }
                }
                
                if ( squadabandoned )
                {
                    activity_participation::function_1b2fcd30f5842df5( activity_instance, player, 2 );
                    activity_instance.var_fe1f3bc99d60c415[ player.guid ] = undefined;
                }
            }
            
            playersnearby = getplayersinradius( activity_instance.encounter_spawntarget.origin, 3000 );
            var_5025545ee3b09b34 = arrayremove( playersnearby, activity_instance.playerparticipants );
            
            if ( level.var_fc42d3458476acb.var_29efdb6c1417ca1 && level.var_fc42d3458476acb.var_29efdb6c1417ca1.size > 0 )
            {
                var_5025545ee3b09b34 = arrayremove( var_5025545ee3b09b34, level.var_fc42d3458476acb.var_29efdb6c1417ca1 );
            }
            
            activity_participation::function_fb0ec90aaf6d4c61( activity_instance, var_5025545ee3b09b34, "PlayerJoinedProximity" );
            
            if ( !activity_instance.targetseen )
            {
                foreach ( player in playersnearby )
                {
                    if ( player hastacvis( activity_instance.primetarget ) )
                    {
                        activity_instance.targetseen = 1;
                        activity_instance thread function_f8a7c8fb84532b9();
                    }
                    
                    break;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_activity_prime_target
// Params 0, eflags: 0xc
// Checksum 0xacc8e8f9, Offset: 0x1269
// Size: 0x56
function private function_f8a7c8fb84532b9()
{
    self notify( #"hash_f4da96ea3d4a30a0" );
    self endon( #"hash_f4da96ea3d4a30a0" );
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 1;
    activity_player_broadcasting::function_cb4750c84882dd07( "prime_target_located", self.playerparticipants );
}

// Namespace ob_activity_prime_target
// Params 1, eflags: 0xc
// Checksum 0x1209f4fa, Offset: 0x12c7
// Size: 0x98
function private function_95cc7a3181b74225( requestid )
{
    self notify( #"hash_d65d845655bf96d0" );
    self endon( #"hash_d65d845655bf96d0" );
    self.activity_instance endon( #"instance_destroyed" );
    self.activity_instance endon( #"activity_ended" );
    activity_instance = self.activity_instance;
    level endon( #"game_ended" );
    self endon( #"pt_despawn" );
    self waittill( #"death" );
    activity_instance thread function_a042d1f16aac996e( self.lastattacker );
}

// Namespace ob_activity_prime_target
// Params 1, eflags: 0x4
// Checksum 0xfffaa9cb, Offset: 0x1367
// Size: 0x2a
function private on_boss_killed( params )
{
    if ( self.death_source == "despawn" )
    {
        self notify( #"pt_despawn" );
    }
}

// Namespace ob_activity_prime_target
// Params 1, eflags: 0xc
// Checksum 0x4c032bf, Offset: 0x1399
// Size: 0x174
function private function_a042d1f16aac996e( attacker )
{
    self notify( #"hash_b57f90d1099d3d8b" );
    self endon( #"hash_b57f90d1099d3d8b" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( attacker && ( isplayer( attacker ) || attacker.owner && isplayer( attacker.owner ) ) )
    {
        lastplayerattacker = attacker;
        
        if ( attacker.owner )
        {
            lastplayerattacker = attacker.owner;
        }
        
        if ( !arraycontains( self.playerparticipants, lastplayerattacker ) )
        {
            playersquad = activity_player_common::function_44ef43ff1f6d21d4( attacker );
            
            foreach ( player in playersquad )
            {
                activity_participation::function_bc67362dace4370c( self, player, "PlayerJoinedInteract" );
            }
            
            var_5dea8c6374f5a67c = 1;
        }
        
        if ( var_5dea8c6374f5a67c )
        {
            waitframe();
        }
    }
    
    if ( self.playerparticipants.size > 0 )
    {
        thread ob_activity_vo_utility::function_639b0047db8aec67( self, "prime_target_success" );
        activity_instance_common::endactivity( self, 1 );
        return;
    }
    
    activity_instance_common::function_9aeeabe50fc9cc3e( self );
}

