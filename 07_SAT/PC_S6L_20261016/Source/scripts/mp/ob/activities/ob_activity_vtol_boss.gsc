// scripts\mp\ob\activities\ob_activity_vtol_boss.gsc  (hash_2dae20b59dc20773.gscc) (size: 45292 Bytes / 0xb0ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdb2e43d9 (3677242329)
// size ...... 45292 (0xb0ec)
// includes .. 36  (offset: 0xa994)
// strings ... 94  (offset: 0xaab4)
// dev strs .. 13  (offset: 0xb044)
// exports ... 91  (offset: 0x7364)
// cseg ...... 0x91b + 0x6a49 (0x7364)
// imports ... 318 (offset: 0x819c)
// animtree1 . 0   (offset: 0xb0ec)
// animtree2 . 0   (offset: 0xb0ec)
#using script_3ec57c71b0b61f00;
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_gunship_heli;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\skills\skill_damage_upgrade;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\vehicles\damage;

#namespace ob_activity_vtol_boss;

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x5
// Checksum 0x39dc8f89, Offset: 0x939
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_vtol_boss", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x29ce4ffd, Offset: 0x962
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_VTOL_BOSS", &vtol_activity_init );
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0x82425bc7, Offset: 0x97d
// Size: 0xd6
function vtol_activity_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_VTOL_BOSS", 0, &vtol_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_VTOL_BOSS", 1, &vtol_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_VTOL_BOSS", 2, &vtol_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_VTOL_BOSS", 3, &vtol_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_VTOL_BOSS", 4, &function_d63c897d3a1169fd );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_21ed21c114f49a26, "REV_OB_VTOL_BOSS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_c709d4b09c391831, "REV_OB_VTOL_BOSS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_6608a2489cfed22d, "REV_OB_VTOL_BOSS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_d9501f8c80bb2614, "REV_OB_VTOL_BOSS" );
    utility::registersharedfunc( #"vtol_boss_activity", #"hash_57c3ad8e12c378d1", &function_3e31d9ffd4e6b2e7 );
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xcadc338b, Offset: 0xa5b
// Size: 0x34b
function vtol_activity_setup()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_participation::function_5e5913e13bf9cb28( self );
    activity_participation::function_3edfb79e1bae6698( self );
    
    if ( !isdefined( activityinstance.var_91c91f4a631c481d ) )
    {
        activityinstance.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    }
    
    activityinstance.ref_struct = utility::getstruct( self.varianttag, "script_noteworthy" );
    activityinstance.handler_list = [ "mars" ];
    activityinstance.selectedhandler = "_" + utility::array_random( activityinstance.handler_list );
    activityinstance.difficulty_region = region_difficulty_manager::get_region_difficulty( activityinstance.ref_struct.origin );
    activityinstance.activitycenter = activity_instance_common::function_776ee11e7acc64a5( self );
    activityinstance.var_93ef2703b55eae57 = [];
    activityinstance.var_dcfee9bbb5135a78 = "Search_Area_WorldEvent_Ob";
    activityinstance function_7d6adfa61ce7cec2();
    waitframe();
    activity_definition_utils::function_a0a94881bc380bbf( 0, self, { #players:self.playerparticipants } );
    ob_activity_vo_utility::function_49fac09ad2950d3d( activityinstance, "vtol_event_unlock_vtol_global" + activityinstance.selectedhandler );
    activity_instance_common::function_46135a69bddfec2c( activityinstance );
    thread function_d62b05b970385444();
    
    if ( getdvarint( @"hash_a5bad54d6ac9cd", 0 ) == 0 )
    {
        self waittill( #"hash_ac1988c51a71f526" );
    }
    else
    {
        wait 1;
    }
    
    activityinstance namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, activityinstance.numhacked, 3 );
    ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "vtol_laptop_hack_complete" + activityinstance.selectedhandler );
    hud_util::showsplashtoall( #"hash_79ce17c59187bf1f" );
    wait 0.5;
    activity_definition_utils::function_a0a94881bc380bbf( 1, self, { #players:self.playerparticipants } );
    nonparticipants = arrayremove( level.players, activityinstance.playerparticipants );
    ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "vtol_rally_reveal_vtol_local" + activityinstance.selectedhandler );
    ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "vtol_rally_reveal_vtol_global" + activityinstance.selectedhandler, nonparticipants );
    self.var_dc21504e32f2eda6 = spawnscriptable( "sat_ob_activity_vtol_boss_marker", activityinstance.vtol_spawn_struct.origin );
    activityinstance game_utility::questcircle_create( "Search_Area_WorldEvent_Ob", activityinstance.vtol_spawn_struct.origin, 4000 );
    activityinstance game_utility::questcircle_showtoall();
    thread _vtol_spawn_watcher();
    self waittill( #"hash_d7707b25f56ea34c" );
    wait 0.5;
    hud_util::showsplashtoall( #"hash_f3b363c01fb8d3ec" );
    
    if ( getdvarint( @"hash_76c6ef2ecb2ae796", 0 ) == 0 )
    {
        thread function_617daf35b984900d();
        self waittill( #"hash_1db0a38fb82da0ae" );
    }
    
    vtol_boss_setup();
    ob_activity_vo_utility::function_3a48100939e009e9( self, "vtol_fight" );
    activity_definition_utils::function_a0a94881bc380bbf( 2, self, { #players:self.playerparticipants } );
    thread function_3484b0db83658d8c();
    thread function_4e2f7c0117ba838a();
    thread _vtol_boss_fight_timer();
    thread function_92d4610be4105ef1();
    thread function_6b6c06ba55a0602c();
    thread function_451bd5cc5f09343b();
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x370c61ba, Offset: 0xdae
// Size: 0x34d
function private function_7d6adfa61ce7cec2()
{
    if ( !self.var_3db3bf10b57cde83 )
    {
        logstring( "[ACTIVITY][VTOL_BOSS] Error - tried to spawn VTOL Boss without a valid variant tag!" );
    }
    
    if ( !isdefined( self.varianttag ) )
    {
        self.varianttag = "VTOL_BOSS_MI_TRAINING";
    }
    
    laptop_groups = utility::getstructarray( "VTOL_BOSS_LAPTOP_GROUP", "script_noteworthy" );
    laptoplocs = [];
    group = utility::array_random( laptop_groups );
    
    if ( getdvarint( @"hash_75f2471616f6078c", 0 ) == 1 )
    {
        laptoparray = utility::getstructarray( group.targetname, "target" );
    }
    else
    {
        laptoparray = getentitylessscriptablearray( group.targetname, #target );
    }
    
    vtolarray = utility::getstructarray( group.target, "targetname" );
    self.vtol_spawn_struct = utility::array_random( vtolarray );
    encounter_name = "ai_encounter:enc_vtol_boss_laptop_guards";
    
    foreach ( var_f2d88eb01fe50328 in laptoparray )
    {
        if ( getdvarint( @"hash_75f2471616f6078c", 0 ) == 1 )
        {
            laptop = spawnscriptable( "sat_ob_activity_vtol_boss_laptop", var_f2d88eb01fe50328.origin, var_f2d88eb01fe50328.angles );
        }
        else
        {
            laptop = var_f2d88eb01fe50328;
        }
        
        scriptable::scriptable_addusedcallbackbypart( "sat_ob_activity_vtol_boss_laptop", &function_213e0dcd9bee515 );
        laptop setscriptablepartstate( "sat_ob_activity_vtol_boss_laptop", "visibile_usable" );
        laptop.activity_instance = self;
        laptop.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_vtol_laptop_marker", 0, 0 );
        objidpoolmanager::update_objective_position( laptop.objidnum, laptop.origin );
        objidpoolmanager::update_objective_state( laptop.objidnum, "invisible" );
        objidpoolmanager::objective_playermask_hidefromall( laptop.objidnum );
        
        if ( !laptop game_utility::questcircle_exists() )
        {
            origin = utility::function_7afe366c29a77c34( laptop.origin, 700 );
            radius = 1500;
            laptop game_utility::questcircle_create( "Search_Area_WorldEvent_Ob", origin, radius );
            laptop.marker = spawnscriptable( "sat_ob_activity_vtol_boss_laptop_marker", origin );
            laptop.marker setscriptablepartstate( "objective_marker", "visible" );
        }
        
        if ( self.var_91c91f4a631c481d )
        {
            laptop.request_id = activity_ai_encounters::function_eb8506829193f5eb( encounter_name, laptop.origin, 2024, 1, 1, 1, 2 );
            activity_ai_encounters::function_52d1342183200a8f( laptop.request_id, &vtol_on_ai_spawn );
            activity_ai_encounters::function_6bf4ff2fbde584ee( laptop.request_id, &function_94f79640ae3be6bf, laptop );
        }
        
        self.var_93ef2703b55eae57 = arraycombineunique( self.var_93ef2703b55eae57, [ laptop ] );
        laptop childthread function_e252c3496ee6f92();
        laptop childthread function_5dfae2f5cfcf4ff3();
        laptop childthread function_407c8508aadaa04b();
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x8c28ae6e, Offset: 0x1103
// Size: 0x24c
function private function_451bd5cc5f09343b()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    activityinstance.chopper waittill( #"death" );
    
    if ( self.chopper game_utility::questcircle_exists() )
    {
        self.chopper game_utility::questcircle_hidefromall();
    }
    
    damage_utility::unregister_vehicle_damage_callback( &function_f329cea31484089d );
    function_9822f86e5e63b20d();
    wait 3;
    adjustedspawnpos = getclosestpointonnavmesh( function_d63c897d3a1169fd() );
    spawnoptions = { #critical:1, #var_18608bd8660b3a19:0, #var_cce4312374b1b531:level.gametypebundle.var_cce4312374b1b531, #dropradiusscale:1, #var_8d4f327170228364:0, #var_23d3495c57d61bdf:0, #baseangles:( 0, 0, 0 ), #baseorigin:adjustedspawnpos, #spawnpositionindex:0 };
    exotic_loot = common_item::function_61c2c0251e742ffd( %"hash_44b1a671abff99a8", undefined, spawnoptions );
    legendary_loot = common_item::function_61c2c0251e742ffd( %"hash_2d9fa275d787ec2b", undefined, spawnoptions );
    
    if ( exotic_loot )
    {
        playfx( utility::getfx( "vfx_sat_ob_gameplay_chest_spawn" ), exotic_loot.origin );
        
        foreach ( player in activityinstance.playerparticipants )
        {
            exotic_loot.pingindex = player calloutmarkerping::function_920a63c06abdefe8( exotic_loot.index );
        }
        
        /#
            if ( getdvarint( @"scr_debug_activity_vtol", 0 ) )
            {
                sphere( adjustedspawnpos, 100, ( 1, 1, 0 ), 0, level.frameduration * 10 );
            }
        #/
    }
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x8ca67ec6, Offset: 0x1357
// Size: 0x7b
function private _vtol_boss_fight_timer()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    timeremaining = 600;
    
    while ( timeremaining > 0 )
    {
        /#
            timeremaining = function_354fe7b04b309c11( timeremaining );
        #/
        
        activity_definition_utils::updatetimer( timeremaining, activityinstance );
        timeremaining--;
        wait 1;
    }
    
    activityinstance.chopper thread namespace_7161222aac9ca916::chopper_flyaway();
}

/#

    // Namespace ob_activity_vtol_boss
    // Params 1, eflags: 0x4
    // Checksum 0x8c63c47d, Offset: 0x13da
    // Size: 0x44, Type: dev
    function private function_354fe7b04b309c11( timeremaining )
    {
        if ( getdvarint( @"hash_63346bb7e2419e5a", 0 ) > 0 )
        {
            timeremaining = getdvarint( @"hash_63346bb7e2419e5a", 0 );
            setdvar( @"hash_63346bb7e2419e5a", 0 );
        }
        
        return timeremaining;
    }

#/

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x96c86e29, Offset: 0x1426
// Size: 0xc5
function private function_617daf35b984900d()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    timeremaining = 30;
    
    while ( timeremaining > 0 )
    {
        /#
            timeremaining = function_354fe7b04b309c11( timeremaining );
        #/
        
        playersinrange = getplayersinradius( activityinstance.vtol_spawn_struct.origin, 10000 );
        var_5025545ee3b09b34 = arrayremove( playersinrange, activityinstance.playerparticipants );
        activity_participation::function_fb0ec90aaf6d4c61( activityinstance, var_5025545ee3b09b34, "PlayerJoinedInteract" );
        activity_definition_utils::updatetimer( timeremaining, activityinstance );
        timeremaining--;
        wait 1;
    }
    
    activityinstance notify( #"hash_1db0a38fb82da0ae" );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x1e0061c1, Offset: 0x14f3
// Size: 0x8f
function private function_92d4610be4105ef1()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        groundpos = activityinstance function_d63c897d3a1169fd();
        playersinrange = getplayersinradius( groundpos, 10000 );
        var_5025545ee3b09b34 = arrayremove( playersinrange, activityinstance.playerparticipants );
        activity_participation::function_fb0ec90aaf6d4c61( activityinstance, var_5025545ee3b09b34, "PlayerJoinedInteract" );
        wait 1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0xf9be0d7f, Offset: 0x158a
// Size: 0x133
function private function_6b6c06ba55a0602c()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance.chopper endon( #"death" );
    level endon( #"game_ended" );
    wait 10;
    
    while ( true )
    {
        groundpos = function_d63c897d3a1169fd();
        
        /#
            if ( getdvarint( @"scr_debug_activity_vtol", 0 ) )
            {
                sphere( groundpos, 100, ( 0, 1, 1 ), 0, level.frameduration );
                circle( groundpos, 12000, ( 0, 0, 1 ), ( 1, 0, 1 ), 0, level.frameduration );
                circle( groundpos, 10000, ( 0, 0, 1 ), ( 0, 1, 0 ), 0, level.frameduration );
            }
        #/
        
        playersinrange = getplayersinradius( groundpos, 12000 );
        var_726d33884138285d = arrayremove( activityinstance.playerparticipants, playersinrange );
        activity_participation::function_dd782fbeb3b07e39( activityinstance, var_726d33884138285d, 1 );
        wait 1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x29e2cea, Offset: 0x16c5
// Size: 0x5f8
function private function_e252c3496ee6f92()
{
    activityinstance = self.activity_instance;
    var_b1003875c8bad21c = [];
    self.revealedplayers = [];
    self.nearplayers = [];
    
    while ( true )
    {
        state = self getscriptablepartstate( "sat_ob_activity_vtol_boss_laptop" );
        var_9e72cd5117442c1f = [];
        dontremove = 0;
        
        if ( state == "visibile_usable" )
        {
            self.playersinrange = getplayersinradius( self.marker.origin, 1500 );
            self.var_f1c51aef6d3579c5 = getplayersinradius( self.marker.origin, 2100 );
            var_ab27c71e47c3c13f = arrayremove( self.playersinrange, var_b1003875c8bad21c );
            var_5025545ee3b09b34 = arrayremove( self.playersinrange, activityinstance.playerparticipants );
            var_c4b2dd5e012b9d63 = getplayersinradius( self.origin, 350 );
            var_ca6cc28a65f65ec0 = arrayremove( self.playersinrange, var_c4b2dd5e012b9d63 );
            var_a043c2339cec58ad = arrayremove( self.var_f1c51aef6d3579c5, self.playersinrange );
            
            if ( var_ab27c71e47c3c13f.size > 0 )
            {
                ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "vtol_approach_laptop" + activityinstance.selectedhandler, var_ab27c71e47c3c13f );
                var_b1003875c8bad21c = arraycombineunique( var_ab27c71e47c3c13f, var_b1003875c8bad21c );
                
                if ( !isdefined( activityinstance.numhacked ) )
                {
                    activityinstance.numhacked = 0;
                }
                
                activityinstance namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, activityinstance.numhacked, 3 );
            }
            
            foreach ( player in var_5025545ee3b09b34 )
            {
                activity_participation::function_bc67362dace4370c( activityinstance, player, "PlayerJoinedProximity" );
                self.nearplayers = arraycombineunique( self.nearplayers, [ player ] );
            }
            
            foreach ( player in self.playersinrange )
            {
                if ( arraycontains( var_c4b2dd5e012b9d63, player ) )
                {
                    var_9e72cd5117442c1f = arraycombineunique( var_9e72cd5117442c1f, [ player.sessionsquadid ] );
                    
                    foreach ( squadid in var_9e72cd5117442c1f )
                    {
                        squad = level.squaddata[ player.team ][ squadid ].players;
                        
                        foreach ( member in squad )
                        {
                            game_utility::questcircle_hidefromplayer( member );
                            objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, member );
                            self.revealedplayers = arraycombineunique( self.revealedplayers, [ member ] );
                        }
                    }
                    
                    continue;
                }
                
                if ( arraycontains( var_ca6cc28a65f65ec0, player ) && !arraycontains( self.revealedplayers, player ) )
                {
                    game_utility::questcircle_showtoplayer( player );
                    objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
                }
            }
            
            foreach ( player in var_a043c2339cec58ad )
            {
                if ( !arraycontains( self.playersinrange, player ) )
                {
                    game_utility::questcircle_hidefromplayer( player );
                    objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
                    squadmatesinrange = arrayintersection( level.squaddata[ player.team ][ player.sessionsquadid ].players, self.playersinrange );
                    
                    if ( !squadmatesinrange.size > 0 )
                    {
                        foreach ( laptop in activityinstance.var_93ef2703b55eae57 )
                        {
                            if ( arraycontains( laptop.playersinrange, player ) )
                            {
                                dontremove = 1;
                            }
                        }
                        
                        if ( !dontremove )
                        {
                            objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
                            activity_participation::function_61aa2b2879f2c0a2( activityinstance, player );
                            self.nearplayers = arrayremove( self.nearplayers, player );
                            self.revealedplayers = arrayremove( self.revealedplayers, player );
                        }
                    }
                }
            }
        }
        else if ( state == "visible_disabled" )
        {
            return;
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x6f0a62eb, Offset: 0x1cc5
// Size: 0x8f
function private _vtol_spawn_watcher()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_participation::function_a45fd1c5cc774007( self );
    activity_participation::function_adecd3e45b4e2277( self );
    thread function_a85d5f7f680b8adf();
    
    for ( playersinrange = []; playersinrange.size == 0 ; playersinrange = getplayersinradius( activityinstance.vtol_spawn_struct.origin, 4000 ) )
    {
        wait 1;
    }
    
    self notify( #"hash_d7707b25f56ea34c" );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0xf5866627, Offset: 0x1d5c
// Size: 0x172
function private function_d62b05b970385444()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    thread function_285855193ef365b6();
    
    if ( !isdefined( activityinstance.numhacked ) )
    {
        activityinstance.numhacked = 0;
    }
    
    while ( true )
    {
        self waittill( #"laptop_hacked" );
        activityinstance.numhacked++;
        activityinstance namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, activityinstance.numhacked, 3 );
        
        if ( activityinstance.numhacked >= 3 )
        {
            activityinstance notify( #"hash_ac1988c51a71f526" );
            
            foreach ( laptop in self.var_93ef2703b55eae57 )
            {
                laptop game_utility::questcircle_hidefromall();
                
                if ( laptop.marker )
                {
                    laptop.marker freescriptable();
                }
            }
            
            return;
        }
        
        ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "vtol_laptop_hack_success" + activityinstance.selectedhandler + "_" + activityinstance.numhacked );
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x73bb55dd, Offset: 0x1ed6
// Size: 0x126
function private function_285855193ef365b6()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"hash_ac1988c51a71f526" );
    activityinstance thread function_23db9e49ca849c64();
    level endon( #"game_ended" );
    timeremaining = 720;
    
    while ( timeremaining > 0 )
    {
        /#
            timeremaining = function_354fe7b04b309c11( timeremaining );
        #/
        
        activity_definition_utils::updatetimer( timeremaining, activityinstance );
        timeremaining--;
        wait 1;
    }
    
    do
    {
        var_a186bb5160856a1a = 0;
        
        foreach ( player in activityinstance.playerparticipants )
        {
            if ( player && player.hackinglaptop )
            {
                var_a186bb5160856a1a = 1;
            }
        }
        
        if ( var_a186bb5160856a1a )
        {
            waitframe();
        }
    }
    while ( var_a186bb5160856a1a );
    
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x55b46204, Offset: 0x2004
// Size: 0x89
function private function_23db9e49ca849c64()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance waittill( #"hash_ac1988c51a71f526" );
    activityvariantdefinition = activityinstance activity_definition_utils::function_837a0c8626c9b419();
    var_f2d9e7c8174d06a3 = activity_definition_utils::function_d32fa66f2924c90d( activityvariantdefinition );
    var_641e35580847346e = function_43b5ed5a14a56573( #"scriptbundle_uiactivityinfo", var_f2d9e7c8174d06a3 );
    activity_definition_utils::updateprogress( 0, activityinstance, 0 );
    activity_definition_utils::updatetimer( 0, activityinstance );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0xf644933e, Offset: 0x2095
// Size: 0xdb
function private function_5dfae2f5cfcf4ff3()
{
    activity_instance = self.activity_instance;
    bot_spawns = utility::function_b7f3d374aa10aa51( activity_instance.varianttag + "_bot_spawn", "targetname", self.origin, 1000 );
    self.spawned_bots = story_contract_util::spawn_bots_folded( bot_spawns, "activate" );
    
    foreach ( bot in self.spawned_bots )
    {
        bot.var_6fb8224240879ded = 1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0xf5a724f6, Offset: 0x2178
// Size: 0x10d
function private function_df8a1063624ddf17()
{
    activityinstance = self.activity_instance;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( self.minions.size > self.var_b1b8f43272fe42fd - 2 )
    {
        self.minions = utility::array_removedead_or_dying( self.minions );
        wait 0.1;
    }
    
    foreach ( bot in self.spawned_bots )
    {
        bot ob_humans::function_5bc0e59d126a6295( "difficulty_darkaether" );
        bot notify( #"activate" );
    }
    
    self notify( #"activate" );
}

// Namespace ob_activity_vtol_boss
// Params 2, eflags: 0x4
// Checksum 0xc32bd743, Offset: 0x228d
// Size: 0x5f
function private function_94f79640ae3be6bf( requestid, laptop )
{
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    laptop.minions = var_41f9287c4987add7.ai;
    laptop.var_b1b8f43272fe42fd = var_41f9287c4987add7.ai.size;
    laptop thread function_df8a1063624ddf17();
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x967aa4c5, Offset: 0x22f4
// Size: 0x76
function private function_407c8508aadaa04b()
{
    activityinstance = self.activity_instance;
    self waittill( #"activate" );
    juggerbot_request_id = self.activity_instance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_vtol_boss_laptop_bots", self.origin, 1024, 1, 1, 1, 2 );
    self.activity_instance activity_ai_encounters::function_52d1342183200a8f( juggerbot_request_id, &vtol_on_ai_spawn, self.activity_instance );
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xe14676bb, Offset: 0x2372
// Size: 0x6c4
function vtol_boss_setup()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activitycenter = self.vtol_spawn_struct.origin;
    activityvariantdefinition = activity_definition_utils::function_837a0c8626c9b419();
    activityinstance.variantdef = activity_definition_utils::function_9129cd8075c85c09( activityvariantdefinition );
    assert( isdefined( activityinstance.variantdef.settings ), "<dev string:x24>" + self.varianttag );
    var_95bc51a48e0002d8 = spatial_zone_container::function_f7fc3e6c249a8256( self, "Awareness_Zone" );
    var_50055ffc7bf83dd3 = spatial_zone_container::function_231d9e91d8ef7b5f( var_95bc51a48e0002d8[ 0 ] );
    activityinstance.variantdef.settings.generalsettings.var_50055ffc7bf83dd3 = var_50055ffc7bf83dd3;
    function_1c4c7ef874191be2( "vtol_boss_fight", activitycenter, 3000, 1 );
    
    if ( flags::gameflagexists( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    level.averagealliesz = 0;
    level.var_adaaa86b7b5a18b6 = getdvarint( @"hash_6e84d26c89e579da", 12000 );
    level.var_1c413c0f520b77a1 = getdvarint( @"hash_995dd383d134e9ed", 10000 );
    level.var_be17f6f2696e1d1a = getdvarint( @"hash_45da2e0688e80016", 5000 );
    level.var_99cc0ae0a9c90f54 = self.customsettings.var_99cc0ae0a9c90f54;
    level.killstreakweaponmap[ "sat_vtol_warship_proj_ob" ] = "chopper_gunner";
    level.missilelauncherlocklength = getdvarint( @"hash_c40d074c7d323a6d", 200 );
    lockradius = getdvarint( @"hash_b2918f4636c4654b", 80 );
    level.var_59584ca20ff01a28 = lockradius * lockradius;
    chopperinstance = spawnstruct();
    chopperinstance.var_b2596b0f06a9e7a1 = [];
    chopperinstance.bossname = activityinstance.variantdef.settings.generalsettings.bossname;
    chopperinstance.spawned = 0;
    chopperinstance.spawnloc = activitycenter;
    chopperinstance.var_8c78435105a9f582 = 1;
    chopperinstance.activity = self;
    chopperinstance.tetherradius = getdvarfloat( @"hash_39e058cab79adf46", var_50055ffc7bf83dd3 );
    chopperinstance.var_2ce8baa3c076d66c = chopperinstance.tetherradius * chopperinstance.tetherradius;
    chopperinstance.var_330cc8c49ebc685a = &vtol_updatethreat;
    chopperinstance.customobjectivemarker = activityinstance.variantdef.settings.generalsettings.gunshipobjectivemarker;
    chopperinstance.var_9d9ce002531e526a = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_sat_ob_we_vtol_boss" );
    patrolstartnode = spawnstruct();
    patrolstartnode.origin = utility::getrandompointincircle( activitycenter, var_50055ffc7bf83dd3 );
    patrolstartnode.origin += ( 0, 0, activityinstance.variantdef.settings.generalsettings.spawnheight );
    chopperinstance.patrolpath = patrolstartnode;
    chopperinstance function_2dd6661a76cb0e5c( activityinstance.variantdef.settings );
    chopperinstance ob_activity_gunship_heli::chopper_spawn();
    chopper = chopperinstance.chopper;
    chopper.var_e04a45f44c2452c5 = 1;
    chopper.var_427a73f754717c12 = spawnstruct();
    chopper.var_427a73f754717c12.activitycenter = activitycenter;
    chopper.var_427a73f754717c12.activityradius = var_50055ffc7bf83dd3;
    chopper.var_427a73f754717c12.var_90cc11534d7b28d1 = var_50055ffc7bf83dd3 * var_50055ffc7bf83dd3;
    chopper.ob_boss_healthbar_priority = 1;
    activityinstance.chopper = chopper;
    chopper.activityinstance = activityinstance;
    
    if ( !isdefined( chopper.maxhealth ) )
    {
        chopper.maxhealth = chopper.maxhealth;
    }
    
    damage_utility::register_vehicle_damage_callback( &function_f329cea31484089d );
    damage::set_post_mod_damage_callback( chopper vehicle::get_ref(), &function_ce2c3682f1766af9 );
    chopper.funcs[ "attack" ] = &function_6340f1037786416d;
    chopper.funcs[ "idle" ] = &function_914f5b35d37920b;
    chopper.funcs[ "strafe" ] = &function_7f9512cc60fef438;
    chopper.funcs[ "patrol" ] = &function_e435d676ff44fd2f;
    chopper.var_4dd1731c54a1396b = 1;
    chopper.var_99b1fba9fe682ecd = &function_933191060fa62335;
    chopper.attackfunc = &vtol_attack;
    chopper.tetherfunc = &function_2677dfb56c3d05b3;
    chopper vehicle_allowplayerstandon( 0 );
    level musicbank_utility::function_5aca66c390aa347d( activityinstance.playerparticipants, #"boss_loop" );
    activityinstance vtol_boss_healthbar_show( activityinstance.playerparticipants );
    chopper function_fed98f16389a4d61( 0, 1 );
    chopper.var_6251a8e53e73cdf2 = 0;
    chopper.flaresreservecount = 0;
    
    if ( !chopperinstance.chopper game_utility::questcircle_exists() )
    {
        origin = activitycenter;
        radius = chopperinstance.tetherradius;
        chopperinstance.chopper game_utility::questcircle_create( "Search_Area_WorldEvent_Ob", origin, radius );
    }
    
    if ( activityinstance game_utility::questcircle_exists() )
    {
        activityinstance game_utility::questcircle_hidefromall();
    }
    
    if ( activityinstance.var_dc21504e32f2eda6 )
    {
        activityinstance.var_dc21504e32f2eda6 freescriptable();
    }
    
    foreach ( player in activityinstance.playerparticipants )
    {
        chopperinstance.chopper game_utility::questcircle_showtoplayer( player );
    }
    
    spatial_zone_container::function_39b907f49cc2d987( activityinstance, "Awareness_Zone" );
    chopper thread function_2409045f0b53b404();
    chopper thread function_e638f61ec097144a();
    thread function_114a446f68c0aa26();
    
    /#
        chopper thread function_2fa75289103726d8( self );
    #/
}

/#

    // Namespace ob_activity_vtol_boss
    // Params 1, eflags: 0x4
    // Checksum 0xe2d8e0ed, Offset: 0x2a3e
    // Size: 0xd6, Type: dev
    function private function_2fa75289103726d8( activityinstance )
    {
        activityinstance endon( #"activity_ended" );
        activityinstance endon( #"instance_destroyed" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( isalive( self ) )
        {
            if ( getdvarint( @"scr_vtol_boss_force_kill", 0 ) )
            {
                player = activityinstance.playerparticipants[ 0 ];
                
                if ( player )
                {
                    damageamount = self.health;
                    self.var_7037157e68c4992b = damageamount;
                    idflags = 65536;
                    self dodamage( damageamount, self.origin, player, player, "<dev string:x52>", undefined, undefined, undefined, idflags );
                }
                
                setdvar( @"scr_vtol_boss_force_kill", 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xb59c10a3, Offset: 0x2b1c
// Size: 0x44
function vtol_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    /#
        activity_instance thread debug_draw();
    #/
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x60>" );
    #/
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xd0fc3649, Offset: 0x2b68
// Size: 0x19e
function vtol_activity_ended()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    nonparticipants = arrayremove( level.players, activity_instance.playerparticipants );
    
    if ( self.successfullycompleted )
    {
        ob_activity_vo_utility::function_3a48100939e009e9( self, "vtol_event_resolution_vtol_local_success" + activity_instance.selectedhandler );
        ob_activity_vo_utility::function_3a48100939e009e9( self, "vtol_event_resolution_vtol_global_success" + activity_instance.selectedhandler, nonparticipants );
    }
    else
    {
        ob_activity_vo_utility::function_3a48100939e009e9( self, "vtol_event_resolution_vtol_local_fail" + activity_instance.selectedhandler );
        ob_activity_vo_utility::function_3a48100939e009e9( self, "vtol_event_resolution_vtol_global_fail" + activity_instance.selectedhandler, nonparticipants );
    }
    
    thread vtol_boss_healthbar_hide( activity_instance.playerparticipants );
    
    if ( self.var_dc21504e32f2eda6 )
    {
        self.var_dc21504e32f2eda6 freescriptable();
    }
    
    foreach ( laptop in self.var_93ef2703b55eae57 )
    {
        if ( laptop.marker )
        {
            laptop.marker freescriptable();
        }
    }
    
    activity_cleanup();
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x71>" + ( istrue( self.successfullycompleted ) ? "<dev string:x7b>" : "<dev string:x85>" ) );
    #/
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xda2d1a99, Offset: 0x2d0e
// Size: 0xe1
function function_d63c897d3a1169fd()
{
    if ( self.chopper && isalive( self.chopper ) )
    {
        belowvtol = self.chopper.origin - ( 0, 0, 500 );
        centerpoint = getgroundposition( belowvtol, 10 );
    }
    else if ( self.vtol_spawn_struct )
    {
        centerpoint = self.vtol_spawn_struct.origin;
    }
    else if ( isdefined( self.s_center ) )
    {
        centerpoint = self.s_center.origin;
    }
    
    if ( self.chopper && self.chopper game_utility::questcircle_exists() && isdefined( centerpoint ) )
    {
        self.chopper game_utility::questcircle_move( centerpoint );
    }
    
    return centerpoint;
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xe6782b51, Offset: 0x2df8
// Size: 0x23
function vtol_activity_destroy()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_cleanup();
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x76ac8842, Offset: 0x2e23
// Size: 0xdc
function private activity_cleanup()
{
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    function_71799ce2c69ce5a9( "vtol_boss_fight", undefined );
    damage_utility::unregister_vehicle_damage_callback( &function_f329cea31484089d );
    thread vtol_boss_healthbar_hide( self.playerparticipants );
    function_9822f86e5e63b20d();
    
    if ( isdefined( self.encounter_id ) )
    {
        function_b43716082f77e5e5( self.encounter_id );
    }
    
    foreach ( laptop in self.var_93ef2703b55eae57 )
    {
        laptop setscriptablepartstate( "sat_ob_activity_vtol_boss_laptop", "hidden" );
        laptop game_utility::questcircle_hidefromall();
    }
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0xe5bac2e1, Offset: 0x2f07
// Size: 0x137
function function_21ed21c114f49a26( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    if ( self.chopper && isalive( self.chopper ) )
    {
        level musicbank_utility::function_5aca66c390aa347d( player_list, #"boss_loop" );
        vtol_boss_healthbar_show( relevant_info_struct.playerlist );
    }
    
    /#
        playernamestring = "<dev string:x8c>";
        
        foreach ( player in player_list )
        {
            newplayer = player.name ? player.name : "<dev string:x8d>";
            playernamestring += newplayer;
        }
        
        iprintlnbold( "<dev string:x8f>" + playernamestring + "<dev string:x98>" );
    #/
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x3d43be74, Offset: 0x3046
// Size: 0x185
function function_c709d4b09c391831( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    level musicbank_utility::function_4f253fd35ec68cbc( player_list, #"boss_loop" );
    
    foreach ( player in player_list )
    {
        if ( self.chopper )
        {
            self.chopper.potentialtargets = [];
        }
    }
    
    vtol_boss_healthbar_hide( relevant_info_struct.playerlist );
    
    /#
        playernamestring = "<dev string:x8c>";
        
        foreach ( player in player_list )
        {
            newplayer = player.name ? player.name : "<dev string:x8d>";
            playernamestring += newplayer;
        }
        
        iprintlnbold( "<dev string:x8f>" + playernamestring + "<dev string:xb2>" );
    #/
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x109b8ba8, Offset: 0x31d3
// Size: 0x23
function function_6608a2489cfed22d( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0xf5e46fad, Offset: 0x31fe
// Size: 0x23
function function_d9501f8c80bb2614( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0x82bccf9b, Offset: 0x3229
// Size: 0xb2
function function_a85d5f7f680b8adf()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.1;
        awareness_zone_sphere = spatial_zone_container::function_f7fc3e6c249a8256( self, "Awareness_Zone" );
        awareness_zone_radius = spatial_zone_container::function_231d9e91d8ef7b5f( awareness_zone_sphere[ 0 ] );
        awareness_zone_center = spatial_zone_container::function_46a131256b075dc1( self, "Awareness_Zone" );
        addplayers = arrayremove( getplayersinradius( awareness_zone_center, awareness_zone_radius, undefined, 0, self.playerparticipants ), self.playerparticipants );
        
        if ( addplayers )
        {
            activity_participation::function_fb0ec90aaf6d4c61( self, addplayers, "PlayerJoinedProximity" );
        }
    }
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xbc5578ce, Offset: 0x32e3
// Size: 0xca
function private function_2dd6661a76cb0e5c( customsettings )
{
    self.var_cb5c81589a3b29d2 = "veh_sat_mil_vtol_ob_gunship_boss";
    self.var_3574b7a060d661f5 = 1;
    self.customsettings = spawnstruct();
    self.customsettings.var_d48f656b4c16b294 = 0;
    self.customsettings.var_7fd09c2690a2b64e = 0;
    self.customsettings.var_35b35d059b17b988 = 1;
    self.customsettings.spawnheight = customsettings.generalsettings.spawnheight;
    self.customsettings.allsettings = customsettings;
    self.customsettings.var_604624b4907944f4 = &function_f48676d459ca4838;
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x3de80c91, Offset: 0x33b5
// Size: 0x7e3
function function_f48676d459ca4838( chopperinstance )
{
    settings = chopperinstance.customsettings.allsettings;
    self.var_3574b7a060d661f5 = 1;
    self.customsettings = spawnstruct();
    self.customsettings.var_db391e86c6c1bbc2 = settings.patrolsettings.patrolradius;
    self.customsettings.var_fac96037b76d75b5 = settings.patrolsettings.var_90a8c9b37151f440;
    activityradius = self.customsettings.var_db391e86c6c1bbc2;
    
    if ( self.customsettings.var_fac96037b76d75b5 )
    {
        activityradius = chopperinstance.tetherradius;
    }
    
    self.customsettings.var_71c157fd182f8458 = getdvarint( @"hash_6e84d26c89e579da", settings.healthsettings.starthealth );
    self.customsettings.var_adaaa86b7b5a18b6 = getdvarint( @"hash_6e84d26c89e579da", settings.healthsettings.maxhealth );
    self.customsettings.var_6aaa9c03e8db7b24 = settings.combatsettings.disablemovement;
    self.customsettings.var_b1e200832fd554ae = settings.combatsettings.disablestealth;
    self.customsettings.var_fd2f429d8eb128ef = settings.combatsettings.var_c26567aee1906403;
    self.customsettings.var_9275920438b54a87 = settings.combatsettings.shootsettings.var_be3882be7289a754;
    self.customsettings.var_9298800438db6aa9 = settings.combatsettings.shootsettings.var_978fe09f18db5fba;
    self.customsettings.var_c582f0f1f598788e = settings.combatsettings.shootsettings.var_a6c11a6dc4ed5a4f;
    self.customsettings.var_da9d0112ff45d16b = settings.combatsettings.shootsettings.var_e9adc2c838dc58a9;
    self.customsettings.var_2f16bd070318a5fc = settings.combatsettings.shootsettings.var_7806d13806b18a5c;
    self.customsettings.var_49088ab73aaaed5d = settings.combatsettings.shootsettings.var_708529168519f541;
    self.customsettings.var_c915f7191eab3985 = settings.combatsettings.shootsettings.var_1e613daf2d20fbe3;
    self.customsettings.var_cb4eb8c06cf8f81a = settings.combatsettings.shootsettings.var_c0d0cfb350168a0;
    self.customsettings.var_c915f4191eab32ec = settings.combatsettings.shootsettings.var_91785115409d4f1a;
    self.customsettings.var_cb4eb9c06cf8fa4d = settings.combatsettings.shootsettings.var_5d87b332f63e5b9d;
    self.customsettings.var_c915f5191eab351f = settings.combatsettings.shootsettings.var_af1861db4d4e9edb;
    self.customsettings.var_be66493a0af3ae59 = settings.combatsettings.shootsettings.var_be66493a0af3ae59;
    self.customsettings.var_29782ffdc8e14c0a = self.customsettings.var_be66493a0af3ae59 * self.customsettings.var_be66493a0af3ae59;
    self.customsettings.var_f4b39c20d56e1253 = settings.combatsettings.shootsettings.var_f4b39c20d56e1253;
    self.customsettings.var_c056e49b6917e6a8 = self.customsettings.var_f4b39c20d56e1253 * self.customsettings.var_f4b39c20d56e1253;
    self.customsettings.var_2ce76ea25a7b9a92 = settings.combatsettings.evasionsettings.var_55a84ece88299136;
    self.customsettings.var_30e822e05a62d18 = settings.combatsettings.evasionsettings.var_1695f8fb0ec795c;
    self.customsettings.var_3af52aec42865514 = settings.combatsettings.evasionsettings.var_3a2aeb03162a22b8;
    self.customsettings.var_4d3f02ced63a1752 = settings.combatsettings.strafesettings.strafedist;
    self.customsettings.var_a50a3f2cdb233c52 = settings.combatsettings.strafesettings.strafeheight;
    self.customsettings.var_9afedb2928bda858 = settings.combatsettings.strafesettings.var_262070fec6f01c78;
    self.customsettings.var_1b807c86f79fc8d6 = settings.combatsettings.limits.var_f41eba2aca1518df;
    self.customsettings.var_c15d0d0ad1e767fb = settings.combatsettings.limits.var_30b7ea56b4b852e2;
    self.customsettings.var_3375c4f7793b4ccb = settings.combatsettings.limits.var_380e2dbf6992b9d8;
    self.customsettings.var_ef819189ba3c6250 = activityradius + settings.awarenesssettings.warningradius;
    self.customsettings.var_df788885d88bb8d2 = settings.rewardsettings.shoulddroploot;
    self.customsettings.var_1fcb74c159018522 = settings.rewardsettings.crateheight;
    self.customsettings.var_81f5c922c8cbfad4 = settings.rewardsettings.rewardcrate;
    self.customsettings.var_1be27c807e9e9d09 = settings.generalsettings.repositiontime;
    self.customsettings.var_5d384f08300c7057 = 0;
    self.customsettings.spawnheight = settings.generalsettings.spawnheight;
    self.customsettings.var_99cc0ae0a9c90f54 = settings.generalsettings.var_3e93fc9ea6ac7df4;
    self.customsettings.var_ac384fdf4664f6cc = 1;
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x70549328, Offset: 0x3ba0
// Size: 0x150
function private function_e435d676ff44fd2f()
{
    self endon( #"death" );
    self endon( #"state_change" );
    self clearlookatent();
    self setneargoalnotifydist( 300 );
    
    if ( !self.fpatrol )
    {
        self vehicle_setspeed( 20, 20 );
    }
    
    self.fpatrol = 0;
    thread function_2409045f0b53b404();
    
    if ( !isdefined( self.next_target ) )
    {
        self.next_target = self.patrolstartnode;
    }
    
    namespace_7161222aac9ca916::chopper_movetolocation( self.next_target, self.patrolwaittime > 0, ( 0, 0, 0 ) );
    self.next_target = spawnstruct();
    self.next_target.origin = utility::getrandompointincircle( self.var_427a73f754717c12.activitycenter, self.var_427a73f754717c12.activityradius );
    self.next_target.origin += ( 0, 0, self.customsettings.spawnheight );
    wait self.patrolwaittime;
    self vehicle_setspeed( self.originalspeed, self.originalaccel );
    namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0xc
// Checksum 0xed41a9d7, Offset: 0x3cf8
// Size: 0x6f
function private function_2409045f0b53b404()
{
    self notify( #"hash_3a47526fbcb108af" );
    self endon( #"hash_3a47526fbcb108af" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    while ( true )
    {
        target = function_45ee5ddd23a38c43();
        
        if ( target )
        {
            namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "attack" );
            break;
        }
        
        wait 1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0x6378c56e, Offset: 0x3d6f
// Size: 0x271
function vtol_updatethreat()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    while ( true )
    {
        self.potentialtargets = [];
        warnradius = namespace_7161222aac9ca916::function_5834da79eb51fa88();
        
        foreach ( player in level.players )
        {
            threatdistance = distance2d( self.origin, player.origin );
            
            if ( threatdistance < warnradius )
            {
                if ( !namespace_7161222aac9ca916::function_15ef53278f060bfe( player ) )
                {
                    threatamount = 1 - threatdistance / warnradius;
                    threatamount *= function_b674ede1388f21be();
                    player.var_676e491f4192d042 = threatamount;
                    self.potentialtargets[ self.potentialtargets.size ] = player;
                    
                    /#
                        if ( getdvarint( @"hash_b6a2dd28e9f3c4db", 0 ) == 1 )
                        {
                            print3d( player.origin + ( 0, 0, 62 ), threatamount, ( 1, 1, 1 ), 1, 1, 20, 1 );
                            sphere( player.origin, 24, ( 0, 1, 0 ), 1, 20 );
                        }
                    #/
                }
                
                continue;
            }
            
            /#
                if ( getdvarint( @"hash_b6a2dd28e9f3c4db", 0 ) == 1 )
                {
                    sphere( player.origin, 24, ( 1, 1, 1 ), 1, 20 );
                }
            #/
        }
        
        healthpct = self.currenthealth / self.maxhealth;
        
        if ( !self.lowhealthwarning && healthpct < 0.4 )
        {
            self.lowhealthwarning = 1;
            ob_activity_vo_utility::function_3a48100939e009e9( self.activityinstance.activity, "vtol_cloaking_device_down" + self.activityinstance.activity.selectedhandler );
        }
        
        if ( !self.currenttarget )
        {
            wait 1;
            continue;
        }
        
        wait 5;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xf35ff206, Offset: 0x3fe8
// Size: 0x14a
function function_45ee5ddd23a38c43()
{
    highestthreat = 0;
    self.currenttarget = undefined;
    
    foreach ( target in self.potentialtargets )
    {
        if ( target.var_676e491f4192d042 && target.var_676e491f4192d042 > highestthreat )
        {
            highestthreat = target.var_676e491f4192d042;
            self.currenttarget = target;
            
            /#
                if ( getdvarint( @"hash_b6a2dd28e9f3c4db", 0 ) == 1 )
                {
                    print3d( self.currenttarget.origin + ( 0, 0, 62 ), "<dev string:xca>", ( 1, 1, 1 ), 1, 1, 20, 1 );
                    sphere( self.currenttarget.origin, 48, ( 1, 0, 0 ), 1, 20 );
                }
            #/
        }
    }
    
    return self.currenttarget;
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xd6340d34, Offset: 0x413b
// Size: 0x9b
function function_914f5b35d37920b()
{
    self endon( #"death" );
    self endon( #"state_change" );
    
    if ( self.strafing )
    {
        self notify( #"strafe_end" );
        self vehicle_setspeed( self.originalspeed, self.accel );
        self.strafing = 0;
    }
    
    ob_activity_gunship_heli::function_b71ee8a9ad29e3ea( self );
    
    if ( self.stayidle )
    {
        return;
    }
    
    target = function_45ee5ddd23a38c43();
    
    if ( target )
    {
        namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "attack" );
        return;
    }
    
    namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "patrol" );
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0x9a74b9ca, Offset: 0x41de
// Size: 0x50
function function_6340f1037786416d()
{
    self endon( #"death" );
    self endon( #"state_change" );
    level endon( #"game_ended" );
    self.fpatrol = 1;
    
    if ( !vtol_attack( self.currenttarget ) )
    {
        namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
    }
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x9805c54d, Offset: 0x4236
// Size: 0x181
function vtol_attack( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    level endon( #"game_ended" );
    
    if ( !target )
    {
        return 0;
    }
    
    var_aab48ad601a760ab = target.origin;
    var_be3882be7289a754 = self.customsettings.var_9275920438b54a87;
    var_978fe09f18db5fba = self.customsettings.var_9298800438db6aa9;
    self.shouldshoot = 1;
    thread function_a394b5d7f7564479( target );
    
    while ( true )
    {
        target = function_45ee5ddd23a38c43();
        
        if ( isdefined( target ) )
        {
            self setturrettargetvec( target.origin );
            self setturretscriptcontrolled( 1, 0 );
            
            if ( function_933191060fa62335() )
            {
                self.gunattacks = 0;
                namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "strafe" );
                return 1;
            }
            
            if ( vtol_turretlookingattarget( target ) )
            {
                ob_activity_gunship_heli::function_86c1334ea4ea9021( target, randomfloatrange( var_be3882be7289a754, var_978fe09f18db5fba ) );
            }
        }
        
        if ( namespace_7161222aac9ca916::function_15ef53278f060bfe( target ) )
        {
            namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
            return 0;
        }
        
        var_427a73f754717c12 = self.var_427a73f754717c12;
        
        if ( var_427a73f754717c12 )
        {
            if ( distance2dsquared( var_427a73f754717c12.activitycenter, target.origin ) > var_427a73f754717c12.var_90cc11534d7b28d1 )
            {
                namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
                return 0;
            }
        }
        
        wait 3;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0x47f408e7, Offset: 0x43bf
// Size: 0x64
function function_7f9512cc60fef438()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    target = self.currenttarget;
    
    if ( target )
    {
        namespace_7161222aac9ca916::function_b7c8e62904e632c( target, 4000, 8, randomint( 360 ), 1000 );
    }
    
    namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x941db7c2, Offset: 0x442b
// Size: 0x253
function private function_a345bbbe1beb0a8()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    level endon( #"game_ended" );
    missiletags = [ "tag_fx_missiles_right", "tag_fx_rockets_right", "tag_fx_missiles_left", "tag_fx_rockets_left" ];
    missilestates = [ "fire_missile_4", "fire_missile_4", "fire_missile_1", "fire_missile_1" ];
    missilestarttime = getdvarfloat( @"hash_3af6fc2e4fbf347", 1.5 );
    wait missilestarttime;
    shots = 0;
    var_bb38677f731d7a35 = getdvarint( @"hash_15db5adf0585c859", 12 );
    var_7806d13806b18a5c = getdvarfloat( @"hash_3af6fc2e4fbf347", 0.3 );
    missilespitch = getdvarfloat( @"hash_38909f314d1175d0", 32.5 );
    missileoffset = getdvarfloat( @"hash_ef325f199de6d4b5", 400 );
    missilecooldown = getdvarfloat( @"hash_d6b373fbd09ae353", 6 );
    
    while ( true )
    {
        while ( shots < var_bb38677f731d7a35 )
        {
            pitchangles = ( missilespitch, self.angles[ 1 ], 0 );
            var_614260aaf8f69a08 = self gettagorigin( missiletags[ 1 ] ) + anglestoforward( pitchangles ) * 200;
            var_5d88509d1ece9b99 = self gettagorigin( missiletags[ 1 ] ) + anglestoforward( pitchangles ) * 1000;
            missileright = weapon_utility::_magicbullet( self.missileweapon, var_614260aaf8f69a08, var_5d88509d1ece9b99, self );
            self setscriptablepartstate( missilestates[ 1 ], "on", 0 );
            wait var_7806d13806b18a5c;
            var_baece2beb8c3f959 = self gettagorigin( missiletags[ 3 ] ) + anglestoforward( pitchangles ) * 200;
            var_8cac471c45ae8448 = self gettagorigin( missiletags[ 3 ] ) + anglestoforward( pitchangles ) * 1000;
            missileleft = weapon_utility::_magicbullet( self.missileweapon, var_baece2beb8c3f959, var_8cac471c45ae8448, self );
            self setscriptablepartstate( missilestates[ 3 ], "on", 0 );
            wait var_7806d13806b18a5c;
            shots += 2;
        }
        
        shots = 0;
        wait missilecooldown;
    }
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0xa1228301, Offset: 0x4686
// Size: 0x1f0
function function_a394b5d7f7564479( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    target endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self setlookatent( target );
    var_bf12ea1737d9ff1 = 0;
    timer = 0;
    var_524b407d18547602 = self.customsettings.var_1b807c86f79fc8d6;
    var_745d403df399ee97 = self.customsettings.var_29782ffdc8e14c0a;
    var_191e2d3ae4f1bf15 = self.customsettings.var_c056e49b6917e6a8;
    repositiontime = self.customsettings.var_1be27c807e9e9d09;
    
    while ( true )
    {
        if ( !self.strafing )
        {
            if ( !( isdefined( target ) && isdefined( target.origin ) ) )
            {
                namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
            }
            
            contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0 );
            canseetarget = trace::ray_trace_passed( target.origin, self.origin, self.ignorelist, contentsoverride );
            
            if ( timer > repositiontime || !canseetarget || distance2dsquared( target.origin, self.origin ) > var_745d403df399ee97 || distance2dsquared( target.origin, self.origin ) < var_191e2d3ae4f1bf15 )
            {
                timer = 0;
                
                if ( !namespace_7161222aac9ca916::function_d8d365ee7036c02d( target, 3000, 8, randomint( 360 ) ) )
                {
                    var_bf12ea1737d9ff1++;
                    
                    if ( var_bf12ea1737d9ff1 > var_524b407d18547602 )
                    {
                        namespace_7161222aac9ca916::function_5593697f8fdd7ac6( "idle" );
                    }
                }
            }
        }
        
        timer += 0.5;
        wait 0.5;
    }
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xd9c68f24, Offset: 0x487e
// Size: 0xa6
function private function_2677dfb56c3d05b3( var_c434259132da2463 )
{
    if ( self.var_427a73f754717c12 )
    {
        var_2ce8baa3c076d66c = self.var_427a73f754717c12.var_90cc11534d7b28d1;
        activitycenter = self.var_427a73f754717c12.activitycenter;
        
        if ( distance2dsquared( activitycenter, var_c434259132da2463 ) > var_2ce8baa3c076d66c )
        {
            var_ec0430ac7f32cbf = var_c434259132da2463 - activitycenter;
            var_8c018271cdf7e08a = vectornormalize( var_ec0430ac7f32cbf );
            newposition = activitycenter + var_8c018271cdf7e08a * self.var_427a73f754717c12.activityradius;
            return newposition;
        }
    }
    
    return var_c434259132da2463;
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xef787e2a, Offset: 0x492d
// Size: 0x6e, Type: bool
function private vtol_turretlookingattarget( target )
{
    var_f9c5d56a87a91cf0 = 0.8;
    turretforward = anglestoforward( self gettagangles( "tag_flash" ) );
    targetdisplace = vectornormalize( target.origin - self gettagorigin( "tag_flash" ) );
    var_48d3b195ec36a36b = vectordot( turretforward, targetdisplace );
    return var_48d3b195ec36a36b >= var_f9c5d56a87a91cf0;
}

// Namespace ob_activity_vtol_boss
// Params 2
// Checksum 0xcde640a7, Offset: 0x49a4
// Size: 0xe8
function function_fed98f16389a4d61( value, init )
{
    namespace_7161222aac9ca916::function_bfaacd2d206fbda3( value );
    self.var_c3c4d711e69d5ab9 = value;
    players = self.activityinstance.playerparticipants;
    
    if ( !init )
    {
        foreach ( player in players )
        {
            if ( !isplayer( player ) || !isalive( player ) )
            {
                continue;
            }
            
            self.activityinstance thread update_boss_healthbar( player );
        }
    }
    
    function_42dd388557dd3a41( value );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0xd94428fe, Offset: 0x4a94
// Size: 0x2d
function private function_cb235ba405c7b3fa()
{
    shadowchoppers = [];
    shadowchoppers[ 0 ] = level.var_af7274c3f142fc8c;
    shadowchoppers[ 1 ] = level.var_13aa67f16e6b8ff9;
    return shadowchoppers.size;
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x2e65675, Offset: 0x4aca
// Size: 0xeb, Type: bool
function private function_933191060fa62335()
{
    if ( self.var_eb9e6f73f9883591 )
    {
        var_b1d47fac7c785b9b = gettime() - self.var_eb9e6f73f9883591;
        var_bc16b078f3f67c35 = getdvarint( @"hash_aa1b12cbc3e27ddd", 30000 );
        
        if ( var_b1d47fac7c785b9b < var_bc16b078f3f67c35 )
        {
            return false;
        }
        
        self.var_eb9e6f73f9883591 = undefined;
    }
    
    if ( self.damagestate >= 3 )
    {
        return false;
    }
    
    if ( self.var_6251a8e53e73cdf2 && function_cb235ba405c7b3fa() < 2 )
    {
        var_f4db23ff43361e97 = getdvarint( @"hash_d6f3ed27176a829f", 2 );
    }
    else
    {
        self.var_6251a8e53e73cdf2 = 0;
        var_f4db23ff43361e97 = self.customsettings.var_c582f0f1f598788e;
    }
    
    var_92dc6df4dc2e67be = self.customsettings.var_da9d0112ff45d16b;
    return var_92dc6df4dc2e67be > 0 && self.gunattacks >= var_f4db23ff43361e97;
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0x55f44962, Offset: 0x4bbe
// Size: 0x5b
function private function_42dd388557dd3a41( value )
{
    if ( self.shieldactive == value )
    {
        return;
    }
    
    self.shieldactive = value;
    scriptable_state = self.shieldactive ? "shield_fx_activate" : "shield_fx_deactivate";
    self setscriptablepartstate( "shield", scriptable_state, 1 );
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xf2c53cb8, Offset: 0x4c21
// Size: 0xa9
function private function_e638f61ec097144a( setlights = 0 )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"strafe_init" );
        
        if ( level.var_679b2cb4aec6cf81 )
        {
            wait level.var_679b2cb4aec6cf81;
        }
        
        thread ob_activity_gunship_heli::function_7337edb76b4495ea( self );
        
        if ( setlights )
        {
            ob_activity_gunship_heli::function_9cde1a77d22afe7f( self, 0 );
        }
        
        self waittill( #"strafe_start" );
        thread ob_activity_gunship_heli::function_b71ee8a9ad29e3ea( self );
        
        if ( setlights )
        {
            ob_activity_gunship_heli::function_9cde1a77d22afe7f( self, 1 );
        }
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x68be7f2e, Offset: 0x4cd2
// Size: 0x24, Type: bool
function private function_7d8df4159099e1f8()
{
    return self.currentstate == "attack" || self.currentstate == "strafe";
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0xcc06acac, Offset: 0x4cff
// Size: 0x24
function function_b674ede1388f21be()
{
    if ( self.var_3574b7a060d661f5 )
    {
        return self.customsettings.var_fd2f429d8eb128ef;
    }
    
    return 10;
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0x80a3c094, Offset: 0x4d2c
// Size: 0x1cb
function function_114a446f68c0aa26()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    chopper = activityinstance.chopper;
    var_6a119688804ee69e = [];
    var_6a119688804ee69e[ var_6a119688804ee69e.size ] = "ai_encounter:enc_vtol_boss_reinforcements";
    var_6a119688804ee69e[ var_6a119688804ee69e.size ] = "ai_encounter:enc_vtol_boss_bot_reinforcements";
    
    while ( true )
    {
        if ( isdefined( activityinstance.chopperminions ) )
        {
            activityinstance.chopperminions = utility::array_removedead_or_dying( activityinstance.chopperminions );
        }
        
        if ( chopper function_7d8df4159099e1f8() && ( !isdefined( activityinstance.chopperminions ) || activityinstance.chopperminions.size < 9 ) )
        {
            var_649a6b50d02e0164 = getclosestpointonnavmesh( chopper.origin );
            nearbyplayers = getplayersinradius( var_649a6b50d02e0164, 9000 );
            spawnencounter = undefined;
            spawnplayers = nearbyplayers;
            
            if ( nearbyplayers.size == 0 )
            {
                var_964878de46bb8a41 = function_b6b8f4dfc279f16b( chopper, var_649a6b50d02e0164 );
                
                if ( var_964878de46bb8a41.size > 0 )
                {
                    spawnplayers = var_964878de46bb8a41;
                    spawnencounter = "ai_encounter:enc_vtol_boss_far_reinforcements";
                }
                else
                {
                    wait 0.5;
                    continue;
                }
            }
            
            if ( !isdefined( spawnencounter ) )
            {
                spawnencounter = utility::array_random( var_6a119688804ee69e );
            }
            
            players_average_origin = utility::function_11a2ebb045201379( spawnplayers );
            var_445a565a34690c78 = activity_ai_encounters::function_eb8506829193f5eb( spawnencounter, players_average_origin, 3000, 1, 1, 1, 0 );
            activity_ai_encounters::function_52d1342183200a8f( var_445a565a34690c78, &vtol_on_ai_spawn, activityinstance );
            activity_ai_encounters::function_6bf4ff2fbde584ee( var_445a565a34690c78, &function_b6dda30a673e7ef2, activityinstance );
            var_dac56af8a7bc9a3d = getdvarint( @"hash_b9eb2e6677ee4d24", 50 );
            wait var_dac56af8a7bc9a3d;
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 2
// Checksum 0x19dd9710, Offset: 0x4eff
// Size: 0x6e
function function_b6dda30a673e7ef2( requestid, activityinstance )
{
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    
    if ( !isdefined( activityinstance.chopperminions ) )
    {
        activityinstance.chopperminions = [];
    }
    
    activityinstance.chopperminions = arraycombineunique( utility::array_removedead_or_dying( activityinstance.chopperminions ), var_41f9287c4987add7.ai );
}

// Namespace ob_activity_vtol_boss
// Params 2, eflags: 0x4
// Checksum 0xbbba89ed, Offset: 0x4f75
// Size: 0x120
function private function_b6b8f4dfc279f16b( chopper, baseorigin )
{
    result = [];
    checked = [];
    
    for ( guid = chopper.var_dffce5f0eeb96ff0; isdefined( guid ) && isdefined( chopper.threatlist[ guid ] ) ; guid = info.down )
    {
        if ( arraycontains( checked, guid ) )
        {
            break;
        }
        
        checked[ checked.size ] = guid;
        info = chopper.threatlist[ guid ];
        var_35849803cd924ebf = 81000000;
        var_2f58cac11a5943a5 = 225000000;
        
        if ( isplayer( info.player ) && isalive( info.player ) )
        {
            playerdist = distancesquared( info.player.origin, baseorigin );
            
            if ( playerdist > var_35849803cd924ebf && playerdist < var_2f58cac11a5943a5 )
            {
                result[ result.size ] = info.player;
            }
        }
    }
    
    return result;
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xfb0657be, Offset: 0x509e
// Size: 0x3b1, Type: bool
function private function_ce2c3682f1766af9( data )
{
    immune = self.is_immune;
    
    if ( immune )
    {
        data.damage = 0;
    }
    else
    {
        var_9a7859ec3774529a = getdvarfloat( @"hash_600e5e9b0ad79cbb", 5 );
        
        if ( var_9a7859ec3774529a > 1 )
        {
            var_a1a5f70985734ffc = function_923fcd3a277b1e00( data, var_9a7859ec3774529a );
        }
    }
    
    data.damage = clamp( data.damage, 0, getdvarfloat( @"hash_42405576a1a27a8a", 100000 ) );
    self.currenthealth -= data.damage;
    self.health = int( self.currenthealth );
    
    if ( isplayer( data.attacker ) )
    {
        damage_utility::function_723dcec170ec23be( data.attacker );
        
        if ( immune )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, "tag_origin", undefined, undefined, 0, data.point, 1, undefined, undefined, var_a1a5f70985734ffc, undefined );
        }
        else if ( self.customsettings.var_99cc0ae0a9c90f54 )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, data.hitloc, data.meansofdeath, data.objweapon, int( data.damage ), data.point, 0, undefined, var_a1a5f70985734ffc, 0 );
        }
    }
    
    if ( self.activityinstance )
    {
        players = self.activityinstance.playerparticipants;
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) || !isalive( player ) )
            {
                continue;
            }
            
            self.activityinstance thread update_boss_healthbar( player );
        }
    }
    
    damagethresholds = [ getdvarfloat( @"hash_e7f254849a845c11", 0.65 ), getdvarfloat( @"hash_9a9647d8570a8598", 0.35 ), getdvarfloat( @"hash_840d75e01a62a14a", 0.2 ) ];
    self.var_359ce29c63efe084 = damagethresholds;
    
    if ( ob_activity_gunship_heli::function_dda29d646f236cac() )
    {
        switch ( self.damagestate )
        {
            case 0:
                self.damagestate = 1;
                self setscriptablepartstate( "body_damage_light", "on", 0 );
                break;
            case 1:
                self.damagestate = 2;
                self setscriptablepartstate( "body_damage_medium", "on", 0 );
                break;
            case 2:
                self.damagestate = 3;
                self setscriptablepartstate( "body_damage_heavy", "on", 0 );
                
                if ( getdvarint( @"hash_8b612b1f52c4e7db", 1 ) )
                {
                    finalspeedscale = getdvarfloat( @"hash_db049f9325427187", 1.05 );
                    self vehicle_setspeed( self.originalspeed * finalspeedscale, self.accel * finalspeedscale );
                    thread function_a345bbbe1beb0a8();
                }
                
                break;
            case 3:
            default:
                break;
        }
    }
    
    return true;
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x6b704161, Offset: 0x5458
// Size: 0x241
function function_f329cea31484089d( damagestruct )
{
    idamage = damagestruct.damage;
    
    if ( self.activityinstance && self.activityinstance.type == "REV_OB_VTOL_BOSS" )
    {
        if ( isplayer( damagestruct.attacker ) )
        {
            if ( isexplosivedamagemod( damagestruct.meansofdeath ) )
            {
                idamage *= getdvarfloat( @"hash_8ae68623b5b46a8f", 4 );
            }
            else if ( damagestruct.objweapon.basenamehash == %"sat_ks_annihilator" )
            {
                idamage *= getdvarfloat( @"hash_fba1251c275a504f", 0.5 );
            }
            else if ( damagestruct.objweapon.basenamehash == %"death_machine_sat_ob" )
            {
                idamage *= getdvarfloat( @"hash_df61cb1234d1d064", 0.5 );
            }
            else
            {
                idamage *= getdvarfloat( @"hash_3db39bb8be3f849e", 3 );
            }
            
            idamage = function_7852f2a8ff218c90( damagestruct.attacker, idamage, self.activityinstance );
            var_d134e157b9d384e3 = { #smeansofdeath:damagestruct.meansofdeath, #idamage:idamage, #sweapon:damagestruct.objweapon, #objweapon:damagestruct.objweapon, #einflictor:damagestruct.inflictor, #eattacker:damagestruct.attacker };
            
            if ( level.var_37f0dad872bed468 && utility::issharedfuncdefined( #"zombie", #"hash_8a860cb98efd603a" ) )
            {
                scaleddamage = utility::callsharedfunc( #"zombie", #"hash_8a860cb98efd603a", var_d134e157b9d384e3 );
                
                if ( scaleddamage != -1 )
                {
                    idamage = scaleddamage;
                    var_d134e157b9d384e3.idamage = idamage;
                }
            }
            
            scaleddamage = skill_damage_upgrade::function_e164d2298e7c1492( var_d134e157b9d384e3 );
            
            if ( scaleddamage != -1 )
            {
                idamage = scaleddamage;
            }
        }
        
        damage_utility::function_723dcec170ec23be( damagestruct.attacker );
    }
    
    return idamage;
}

// Namespace ob_activity_vtol_boss
// Params 3, eflags: 0x4
// Checksum 0xe0fa6d28, Offset: 0x56a2
// Size: 0xe3
function private function_7852f2a8ff218c90( player, indamage, activityinstance )
{
    outdamage = 0.1;
    
    if ( arraycontains( activityinstance.playerparticipants, player ) )
    {
        awareness_zone_sphere = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "Awareness_Zone" );
        awareness_zone_radius = spatial_zone_container::function_231d9e91d8ef7b5f( awareness_zone_sphere[ 0 ] );
        abandon_zone_sphere = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "Proximity_Abandon_Zone" );
        abandon_zone_radius = spatial_zone_container::function_231d9e91d8ef7b5f( abandon_zone_sphere[ 0 ] );
        playerdistance = distance2d( abandon_zone_sphere[ 0 ].origin, player.origin );
        damageratio = clamp( ( abandon_zone_radius - playerdistance ) / ( abandon_zone_radius - awareness_zone_radius ), 0.1, 1 );
        outdamage = indamage * damageratio;
    }
    
    return outdamage;
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xdb136017, Offset: 0x578e
// Size: 0x131
function private update_boss_healthbar( player )
{
    if ( !self.chopper )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        if ( !player.var_71c37977095602df )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_advanced_guild_vtol", self.chopper );
        }
        else if ( player.var_71c37977095602df == "ob_boss_advanced_guild_vtol" )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
        else if ( player ob_story_mission_utils::function_6ec505041dcea08e( self.chopper ) )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_advanced_guild_vtol", self.chopper );
        }
    }
    else if ( player ob_story_mission_utils::function_6ec505041dcea08e( self.chopper ) )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_advanced_guild_vtol", self.chopper );
    }
    
    if ( player.var_71c37977095602df == "ob_boss_advanced_guild_vtol" )
    {
        if ( self.chopper.is_immune )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        else
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xcad285e, Offset: 0x58c7
// Size: 0xf6
function private vtol_boss_healthbar_show( players )
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.chopper ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( isplayer( player ) && isalive( player ) )
        {
            activityinstance thread update_boss_healthbar( player );
            
            if ( self.chopper game_utility::questcircle_exists() )
            {
                self.chopper game_utility::questcircle_showtoplayer( player );
            }
        }
    }
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0x92d03393, Offset: 0x59c5
// Size: 0xe3
function private vtol_boss_healthbar_hide( players )
{
    activityinstance = self;
    level endon( #"game_ended" );
    
    foreach ( player in players )
    {
        if ( isplayer( player ) )
        {
            if ( player.var_71c37977095602df == "ob_boss_advanced_guild_vtol" )
            {
                player ob_story_mission_utils::function_5a707116af438c92();
            }
            
            if ( self.chopper && self.chopper game_utility::questcircle_exists() )
            {
                self.chopper game_utility::questcircle_hidefromplayer( player );
            }
        }
    }
}

// Namespace ob_activity_vtol_boss
// Params 4, eflags: 0x4
// Checksum 0xddab5574, Offset: 0x5ab0
// Size: 0x43
function private vtol_on_ai_spawn( requestid, goal_volume, agent, data )
{
    agent.var_6fb8224240879ded = 1;
    agent ob_humans::function_5bc0e59d126a6295( "difficulty_darkaether" );
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x8eee01a7, Offset: 0x5afb
// Size: 0x167
function private function_3484b0db83658d8c()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    level.var_af7274c3f142fc8c = undefined;
    level.var_13aa67f16e6b8ff9 = undefined;
    thread function_3284eb70ad90d9f0();
    boss = activityinstance.chopper;
    
    while ( true )
    {
        boss waittill( #"camo_on" );
        spawnedchopper = undefined;
        
        if ( !level.var_af7274c3f142fc8c )
        {
            spawnedchopper = vtol_spawn_shadow( boss.origin, boss.angles );
            spawnedchopper.shadowid = 0;
            level.var_af7274c3f142fc8c = spawnedchopper;
        }
        else if ( !level.var_13aa67f16e6b8ff9 )
        {
            spawnedchopper = vtol_spawn_shadow( boss.origin, boss.angles );
            spawnedchopper.shadowid = 1;
            level.var_13aa67f16e6b8ff9 = spawnedchopper;
        }
        
        if ( spawnedchopper )
        {
            spawnedchopper setscriptablepartstate( "spawn", "on_all", 0 );
            spawnedchopper thread ob_activity_gunship_heli::chopper_initscriptable();
            spawnedchopper thread namespace_7161222aac9ca916::function_9106137eab34ff48();
            spawnedchopper thread function_2ecc7a41041c152b( activityinstance );
        }
        
        if ( level.var_af7274c3f142fc8c && level.var_13aa67f16e6b8ff9 )
        {
            boss function_fed98f16389a4d61( 1 );
        }
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0xcfc99a44, Offset: 0x5c6a
// Size: 0x1a
function private function_3284eb70ad90d9f0()
{
    utility::waittill_any( "activity_ended", "instance_destroyed" );
    function_9822f86e5e63b20d();
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x9fde5fa, Offset: 0x5c8c
// Size: 0x28f
function private function_4e2f7c0117ba838a()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    repositiontime = 1;
    
    while ( true )
    {
        shadowchoppers = [];
        shadowchoppers[ 0 ] = level.var_af7274c3f142fc8c;
        shadowchoppers[ 1 ] = level.var_13aa67f16e6b8ff9;
        boss = activityinstance.chopper;
        
        foreach ( shadow in shadowchoppers )
        {
            if ( shadow && shadow.state == "following" )
            {
                var_3e9120209a37b332 = shadow.angles;
                var_e953e2ebbdfaed18 = shadow.origin;
                
                if ( boss )
                {
                    if ( boss.angles )
                    {
                        var_3e9120209a37b332 = boss.angles;
                    }
                    
                    if ( boss.origin )
                    {
                        var_e953e2ebbdfaed18 = boss.origin;
                    }
                }
                
                var_7d81e244cdc904e4 = ( 0, var_3e9120209a37b332[ 1 ], 0 );
                var_b7e295786fca3ba7 = anglestoright( var_7d81e244cdc904e4 );
                
                if ( shadow.shadowid == 0 )
                {
                    var_5ed53cb93e03a4bc = var_b7e295786fca3ba7 * 2000;
                }
                else if ( shadow.shadowid == 1 )
                {
                    var_5ed53cb93e03a4bc = var_b7e295786fca3ba7 * -2000;
                }
                
                targetlocation = var_e953e2ebbdfaed18 + var_5ed53cb93e03a4bc;
                
                /#
                    if ( getdvarint( @"hash_b6a2dd28e9f3c4db", 0 ) == 1 )
                    {
                        sphere( targetlocation, 100, ( 0, 1, 0 ), 1, 5 );
                    }
                #/
                
                stopatgoal = boss && boss.currentstate == "patrol";
                shadow setvehgoalpos( targetlocation, stopatgoal );
                
                if ( stopatgoal )
                {
                    shadow setgoalyaw( var_3e9120209a37b332[ 1 ] );
                    shadow vehicle_setspeed( getdvarfloat( @"hash_16c4a146ae95197a", 50 ), 80, 80 );
                    continue;
                }
                
                shadow vehicle_setspeed( getdvarfloat( @"hash_736719ee37d850e7", 75 ), 80, 80 );
            }
        }
        
        wait repositiontime;
    }
}

// Namespace ob_activity_vtol_boss
// Params 2
// Checksum 0xb63fb254, Offset: 0x5f23
// Size: 0x21c
function vtol_spawn_shadow( location, angles )
{
    choppervehicle = %"hash_df8ee90eb12ed0e";
    spawndata = spawnstruct();
    spawndata.origin = location;
    spawndata.angles = angles;
    spawndata.team = "team_hundred_ninety";
    spawndata vehicle_spawn::set_flag( 10 );
    chopper = vehicle::spawn( choppervehicle, spawndata );
    chopper vehicle_setspeed( getdvarfloat( @"hash_736719ee37d850e7", 75 ), 90, 90 );
    chopper sethoverparams( 50, 60, 50 );
    chopper function_d2b8ee2e1275daaf( 1 );
    chopper forcenetfieldhighlod( 1 );
    chopper setneargoalnotifydist( 250 );
    chopper setyawspeed( 180, 90 );
    chopper setmaxpitchroll( 20, 20 );
    chopper vehicle_allowplayerstandon( 0 );
    var_a346cbd10878dc33 = getdvarint( @"hash_5b3b9e7c8eeec7c2", 100000 );
    chopper.currenthealth = var_a346cbd10878dc33;
    chopper.health = var_a346cbd10878dc33;
    chopper.maxhealth = var_a346cbd10878dc33;
    chopper.missileweapon = makeweapon( "sat_vtol_warship_proj_ob_boss" );
    chopper.crashoffset = 250;
    healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_6ed4fde0ed0bcf9b" );
    chopper.healthbarsettingsid = healthbarsettingsid;
    chopper.var_24954f14e27b448d = 1;
    chopper.bosschopper = self.chopper;
    chopper.ignorelist = [];
    chopper.ignorelist[ chopper.ignorelist.size ] = chopper;
    chopper.ignorelist[ chopper.ignorelist.size ] = chopper.bosschopper;
    damage::set_post_mod_damage_callback( chopper vehicle::get_ref(), &function_7b12659bbb669384 );
    damage::set_death_callback( chopper vehicle::get_ref(), &function_3ea7df7bc788a1b7 );
    return chopper;
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x4e07b58c, Offset: 0x6148
// Size: 0x22
function private function_1dd52bf5a76fb675()
{
    if ( self )
    {
        self dodamage( self.currenthealth + 1000, self.origin );
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x696acc7c, Offset: 0x6172
// Size: 0x3d
function private function_9822f86e5e63b20d()
{
    if ( level.var_af7274c3f142fc8c )
    {
        level.var_af7274c3f142fc8c function_1dd52bf5a76fb675();
        return;
    }
    
    if ( level.var_13aa67f16e6b8ff9 )
    {
        level.var_13aa67f16e6b8ff9 function_1dd52bf5a76fb675();
    }
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0x6f042b89, Offset: 0x61b7
// Size: 0xbb
function private function_3ea7df7bc788a1b7( data )
{
    if ( self.iscrashing || self.dead )
    {
        return;
    }
    
    if ( self == level.var_af7274c3f142fc8c )
    {
        level.var_af7274c3f142fc8c = undefined;
    }
    else if ( self == level.var_13aa67f16e6b8ff9 )
    {
        level.var_13aa67f16e6b8ff9 = undefined;
    }
    
    if ( self.bosschopper && self.bosschopper.is_immune )
    {
        self.bosschopper thread function_fed98f16389a4d61( 0 );
        self.bosschopper.var_eb9e6f73f9883591 = gettime();
    }
    
    self.dead = 1;
    thread ob_activity_gunship_heli::chopper_handledeathdamage( data );
    return 1;
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xc9aa3e43, Offset: 0x627b
// Size: 0xef
function private function_2ecc7a41041c152b( activityinstance )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self.state = "spawned";
    thread function_2d89fc92eec74b80();
    goal = self.origin + anglestoforward( self.angles ) * 5000 + ( 0, 0, randomfloatrange( -150, 500 ) );
    self vehicle_helisetai( goal, 60, 50, 25, 1, 0, 0, 0, 0, 1, 0, 0, 1 );
    utility::waittill_any( "near_goal", "goal" );
    self.state = "following";
    thread function_68daa4b4d7923e34();
    thread function_cf4597ea6b09b640();
    
    while ( true )
    {
        if ( function_1d3525994c11c59a() )
        {
            function_2d89fc92eec74b80();
            wait 10;
            continue;
        }
        
        wait 1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x3e119d53, Offset: 0x6372
// Size: 0x5d
function private function_cf4597ea6b09b640()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    while ( true )
    {
        if ( function_1d3525994c11c59a() )
        {
            thread function_7f940a2c932c47fc();
            wait 4;
            self notify( #"stop_shooting" );
            wait 8;
        }
        else
        {
            self clearturrettarget( 0 );
        }
        
        wait 1;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x965c03d4, Offset: 0x63d7
// Size: 0x76
function private function_7f940a2c932c47fc()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    self endon( #"stop_shooting" );
    self setturretscriptcontrolled( 1, 0 );
    
    while ( true )
    {
        if ( self.attacktarget )
        {
            self setturrettargetent( self.attacktarget );
            
            while ( self function_7cc4e445cca9566f( 0 ) != 1 )
            {
                waitframe();
            }
            
            self requestfireweapon( 0 );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0xb7a70c4, Offset: 0x6455
// Size: 0x287
function private function_2d89fc92eec74b80()
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    missiletags = [ "tag_fx_missiles_right", "tag_fx_rockets_right", "tag_fx_missiles_left", "tag_fx_rockets_left" ];
    missilestates = [ "fire_missile_4", "fire_missile_4", "fire_missile_1", "fire_missile_1" ];
    missilestarttime = getdvarfloat( @"hash_179c35d7a689c114", 2.25 );
    wait missilestarttime;
    shots = 0;
    var_bb38677f731d7a35 = getdvarint( @"hash_2ba27322bd0daae0", 4 );
    var_7806d13806b18a5c = getdvarfloat( @"hash_179c35d7a689c114", 0.666 );
    missilespitch = getdvarfloat( @"hash_7863b1ac5fdb7a5", 32.5 );
    missileoffset = getdvarfloat( @"hash_acecfd190a538c06", 350 );
    
    while ( shots < var_bb38677f731d7a35 )
    {
        pitchangles = ( missilespitch, self.angles[ 1 ], 0 );
        var_614260aaf8f69a08 = self gettagorigin( missiletags[ 1 ] ) + anglestoforward( pitchangles ) * 200;
        var_5d88509d1ece9b99 = self gettagorigin( missiletags[ 1 ] ) + anglestoforward( pitchangles ) * 1000;
        
        if ( self.attacktarget )
        {
            var_614260aaf8f69a08 = self gettagorigin( missiletags[ 1 ] );
            var_5d88509d1ece9b99 = self.attacktarget.origin - ( 0, 0, missileoffset );
        }
        
        missileright = weapon_utility::_magicbullet( self.missileweapon, var_614260aaf8f69a08, var_5d88509d1ece9b99, self );
        wait 0.333;
        var_baece2beb8c3f959 = self gettagorigin( missiletags[ 3 ] ) + anglestoforward( pitchangles ) * 200;
        var_8cac471c45ae8448 = self gettagorigin( missiletags[ 3 ] ) + anglestoforward( pitchangles ) * 1000;
        
        if ( self.attacktarget )
        {
            var_baece2beb8c3f959 = self gettagorigin( missiletags[ 3 ] );
            var_8cac471c45ae8448 = self.attacktarget.origin - ( 0, 0, missileoffset );
        }
        
        missileleft = weapon_utility::_magicbullet( self.missileweapon, var_baece2beb8c3f959, var_8cac471c45ae8448, self );
        self setscriptablepartstate( missilestates[ 1 ], "on", 0 );
        self setscriptablepartstate( missilestates[ 3 ], "on", 0 );
        shots += 2;
        wait var_7806d13806b18a5c;
    }
}

// Namespace ob_activity_vtol_boss
// Params 0, eflags: 0x4
// Checksum 0x52fd8672, Offset: 0x66e4
// Size: 0x2b, Type: bool
function private function_1d3525994c11c59a()
{
    return self.attacktarget && self.bosschopper && self.bosschopper function_7d8df4159099e1f8();
}

// Namespace ob_activity_vtol_boss
// Params 1, eflags: 0x4
// Checksum 0xf279acb, Offset: 0x6718
// Size: 0x24c, Type: bool
function private function_7b12659bbb669384( data )
{
    if ( isplayer( data.attacker ) )
    {
        var_a1a5f70985734ffc = function_923fcd3a277b1e00( data );
        damage_utility::function_723dcec170ec23be( data.attacker );
        var_d134e157b9d384e3 = { #smeansofdeath:data.meansofdeath, #idamage:data.damage, #sweapon:data.objweapon, #objweapon:data.objweapon, #einflictor:data.inflictor, #eattacker:data.attacker };
        
        if ( isexplosivedamagemod( var_d134e157b9d384e3.smeansofdeath ) )
        {
            var_d134e157b9d384e3.idamage *= getdvarfloat( @"hash_bd9e70b5ce4be39a", 3 );
        }
        else
        {
            var_d134e157b9d384e3.idamage *= getdvarfloat( @"hash_9d296e613f870939", 3 );
        }
        
        if ( level.var_37f0dad872bed468 && utility::issharedfuncdefined( #"zombie", #"hash_8a860cb98efd603a" ) )
        {
            scaleddamage = utility::callsharedfunc( #"zombie", #"hash_8a860cb98efd603a", var_d134e157b9d384e3 );
            
            if ( scaleddamage != -1 )
            {
                data.damage = scaleddamage;
            }
        }
        
        scaleddamage = skill_damage_upgrade::function_e164d2298e7c1492( var_d134e157b9d384e3 );
        
        if ( scaleddamage != -1 )
        {
            data.damage = scaleddamage;
        }
        
        data.damage = clamp( data.damage, 0, getdvarfloat( @"hash_42405576a1a27a8a", 100000 ) );
        
        if ( isplayer( data.attacker ) )
        {
            if ( true )
            {
                mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, data.hitloc, data.meansofdeath, data.objweapon, int( data.damage ), data.point, 0, undefined, var_a1a5f70985734ffc, 0 );
            }
        }
    }
    
    return true;
}

// Namespace ob_activity_vtol_boss
// Params 0
// Checksum 0x8c91b5e4, Offset: 0x696d
// Size: 0x1a7
function function_68daa4b4d7923e34()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    while ( true )
    {
        warnradius = self.bosschopper namespace_7161222aac9ca916::function_5834da79eb51fa88();
        players = function_628bac9faa9d1e86( level.players, self.origin );
        
        foreach ( player in players )
        {
            if ( distance2d( self.origin, player.origin ) < warnradius )
            {
                if ( !namespace_7161222aac9ca916::function_15ef53278f060bfe( player ) )
                {
                    self.attacktarget = player;
                    break;
                }
            }
        }
        
        if ( !function_1d3525994c11c59a() )
        {
            if ( self.attacktarget )
            {
                self.attacktarget = undefined;
                self clearlookatent();
            }
            
            wait 1;
            continue;
        }
        
        if ( !self.attacktarget )
        {
            if ( self.bosschopper && self.bosschopper.currenttarget )
            {
                self.attacktarget = self.bosschopper.currenttarget;
                self setlookatent( self.attacktarget );
            }
            
            wait 1;
            continue;
        }
        
        self setlookatent( self.attacktarget );
        wait 5;
    }
}

// Namespace ob_activity_vtol_boss
// Params 2, eflags: 0x4
// Checksum 0xb9625154, Offset: 0x6b1c
// Size: 0x118, Type: bool
function private function_923fcd3a277b1e00( data, scale )
{
    thrusterradius = 125;
    var_33b5b37d59099f58 = thrusterradius * 0.5;
    var_c7beb966f4f78b7f = thrusterradius * thrusterradius;
    tagoffset = anglestoright( self.angles ) * var_33b5b37d59099f58;
    var_f7620ec70e55c31e = self gettagorigin( "tag_engine_ri_rotate_animate" ) + tagoffset;
    var_f76218c70e55d91c = self gettagorigin( "tag_engine_le_rotate_animate" ) - tagoffset;
    var_9a7859ec3774529a = scale ?? getdvarfloat( @"hash_1cd6439c01ed84c2", 10 );
    
    if ( distancesquared( data.point, var_f7620ec70e55c31e ) < var_c7beb966f4f78b7f )
    {
        data.damage *= var_9a7859ec3774529a;
        return true;
    }
    else if ( distancesquared( data.point, var_f76218c70e55d91c ) < var_c7beb966f4f78b7f )
    {
        data.damage *= var_9a7859ec3774529a;
        return true;
    }
    
    return false;
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x6f84b6aa, Offset: 0x6c3d
// Size: 0x15
function function_3e31d9ffd4e6b2e7( activityinstance )
{
    function_babd34fe09dc1bdc( activityinstance );
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0xa969b498, Offset: 0x6c5a
// Size: 0x116
function function_babd34fe09dc1bdc( activityinstance )
{
    crate_model = spawn( "script_model", self.origin );
    crate_model setmodel( "military_carepackage_03_ob" );
    crate_model unlink();
    crate_model physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    bodyid = crate_model physics_getbodyid( 0 );
    physics_setbodycenterofmassnormal( bodyid, ( 0, 0, -1 ) );
    crate_model.physicsactivated = 1;
    var_7efd2ef630bd1000 = spawnscriptable( "ob_loot_cache_crate", self.origin );
    var_7efd2ef630bd1000 scriptablesetparententity( crate_model, ( 0, 0, 40 ) );
    var_7efd2ef630bd1000 setscriptablepartstate( "body", #"closed_usable" );
    common_cache::fillcontentsfromlist( var_7efd2ef630bd1000, "ob_sat_items_activity_vtol_boss", 4 );
    playfx( utility::getfx( "vfx_sat_ob_gameplay_chest_spawn" ), var_7efd2ef630bd1000.origin );
    var_7efd2ef630bd1000 thread function_67151111b7196d5a( crate_model );
    var_7efd2ef630bd1000 thread function_32e0783a9f8a1ce6( crate_model );
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x20867fff, Offset: 0x6d78
// Size: 0x1c
function function_13d2be80b39dab83( activityinstance )
{
    self setscriptablepartstate( "body", "closed_usable" );
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x2a67a051, Offset: 0x6d9c
// Size: 0x32
function function_67151111b7196d5a( crate_model )
{
    level endon( #"game_ended" );
    crate_model endon( #"hash_1d7b8700129563d3" );
    wait 180;
    crate_model childthread function_ef2c025616df34d5( self );
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0x89c85c2c, Offset: 0x6dd6
// Size: 0xe1
function function_32e0783a9f8a1ce6( crate_model )
{
    level endon( #"game_ended" );
    crate_model endon( #"hash_1d7b8700129563d3" );
    
    while ( true )
    {
        items_remaining = 0;
        
        foreach ( item in self.contents )
        {
            items_remaining += item.quantity;
        }
        
        if ( items_remaining == 0 )
        {
            self freescriptable();
            crate_model thread function_ef2c025616df34d5();
            crate_model notify( #"hash_1d7b8700129563d3" );
        }
        
        wait 5;
    }
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0xe4fcb036, Offset: 0x6ebf
// Size: 0x5d
function function_ef2c025616df34d5( scriptable )
{
    while ( true )
    {
        playersinradius = getplayersinradius( self.origin, 2000 );
        
        if ( playersinradius.size == 0 )
        {
            if ( isdefined( scriptable ) )
            {
                scriptable freescriptable();
            }
            
            self delete();
            self notify( #"hash_1d7b8700129563d3" );
        }
        
        wait 10;
    }
}

// Namespace ob_activity_vtol_boss
// Params 6, eflags: 0x4
// Checksum 0x3135180e, Offset: 0x6f24
// Size: 0xc9
function private function_213e0dcd9bee515( instance, part, state, player, bautouse, usestring )
{
    activity_instance = instance.activity_instance;
    var_a8839a94f36d1f2e = isplayer( player ) && isalive( player ) && !player.inlaststand && !player isreloading() && !player isgestureplaying() && !player.hackinglaptop && !player.using_device;
    
    if ( !activity_instance || !var_a8839a94f36d1f2e )
    {
        return;
    }
    
    instance thread function_1ae0623387cbb8ef( player, activity_instance );
}

// Namespace ob_activity_vtol_boss
// Params 2
// Checksum 0x6c74efe4, Offset: 0x6ff5
// Size: 0x88
function function_1ae0623387cbb8ef( player, activity_instance )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self disablescriptableplayeruse( player );
    thread function_511fd230730d5b97( player, activity_instance );
    player waittill( #"hash_19853cc365aaeb5f" );
    
    if ( player && self && !self.hackcompleted )
    {
        self enablescriptableplayeruse( player );
    }
}

// Namespace ob_activity_vtol_boss
// Params 2, eflags: 0x4
// Checksum 0x3c8f2222, Offset: 0x7085
// Size: 0xb4
function private function_511fd230730d5b97( hackingplayer, activity_instance )
{
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    hackingplayer.hackinglaptop = self;
    self.hackcompleted = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", hackingplayer, 5, undefined, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( hackingplayer )
    {
        hackingplayer.hackinglaptop = undefined;
        hackingplayer notify( #"hash_19853cc365aaeb5f" );
    }
    
    self.activity_instance notify( #"activate" );
    
    if ( self.hackcompleted )
    {
        thread function_dfebebbac86dd845( activity_instance );
    }
}

// Namespace ob_activity_vtol_boss
// Params 1
// Checksum 0xe974547a, Offset: 0x7141
// Size: 0xfc
function function_dfebebbac86dd845( activity_instance )
{
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    partstate = self getscriptablepartstate( #"sat_ob_activity_vtol_boss_laptop", 1 );
    
    if ( partstate && partstate != "visible_disabled" )
    {
        self function_7653c765b6c7b815();
        self setscriptablepartstate( "sat_ob_activity_vtol_boss_laptop", "visible_disabled" );
        self.marker setscriptablepartstate( "objective_marker", "hidden" );
        self.marker freescriptable();
        objidpoolmanager::objective_playermask_hidefromall( self.objidnum );
        namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.objidnum );
        game_utility::questcircle_hidefromall();
        waitframe();
        activity_instance notify( #"laptop_hacked" );
        wait 3.5;
        activity_participation::function_dd782fbeb3b07e39( activity_instance, self.var_f1c51aef6d3579c5 );
        self.playersinrange = [];
        self.var_f1c51aef6d3579c5 = [];
    }
}

/#

    // Namespace ob_activity_vtol_boss
    // Params 0, eflags: 0x4
    // Checksum 0xe48fc553, Offset: 0x7245
    // Size: 0xc4, Type: dev
    function private debug_draw()
    {
        level endon( #"game_ended" );
        activitycenter = activity_instance_common::function_776ee11e7acc64a5( self );
        var_95bc51a48e0002d8 = spatial_zone_container::function_f7fc3e6c249a8256( self, "<dev string:xd1>" );
        var_50055ffc7bf83dd3 = spatial_zone_container::function_231d9e91d8ef7b5f( var_95bc51a48e0002d8[ 0 ] );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_activity_vtol", 0 ) )
            {
                utility::draw_circle( activitycenter, var_50055ffc7bf83dd3, ( 0, 1, 0 ) );
                
                if ( self.ref_struct )
                {
                    utility::draw_circle( self.ref_struct.origin, self.ref_struct.radius, ( 1, 1, 0 ) );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_vtol_boss
    // Params 1, eflags: 0x4
    // Checksum 0x5ff66d6b, Offset: 0x7311
    // Size: 0x53, Type: dev
    function private function_8eeb50e8ea4082ae( text )
    {
        if ( !getdvarint( @"scr_debug_activity_vtol", 0 ) )
        {
            return;
        }
        
        print3d( activity_instance_common::function_776ee11e7acc64a5( self ) + ( 0, 0, 150 ), text, ( 1, 0, 0 ), 1, 1, 100, 1 );
    }

#/
