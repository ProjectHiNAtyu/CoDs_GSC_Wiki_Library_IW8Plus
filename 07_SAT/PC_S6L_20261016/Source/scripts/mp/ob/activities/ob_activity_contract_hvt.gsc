// scripts\mp\ob\activities\ob_activity_contract_hvt.gsc  (hash_4ebbdc008a635c2d.gscc) (size: 24613 Bytes / 0x6025 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc958c02f (3378036783)
// size ...... 24613 (0x6025)
// includes .. 28  (offset: 0x5ad5)
// strings ... 68  (offset: 0x5bb5)
// dev strs .. 18  (offset: 0x5f3d)
// exports ... 49  (offset: 0x3ec5)
// cseg ...... 0x710 + 0x37b5 (0x3ec5)
// imports ... 169 (offset: 0x466d)
// animtree1 . 0   (offset: 0x6025)
// animtree2 . 0   (offset: 0x6025)
#using script_16ea1b94f0f381b3;
#using script_22aa38b6bedad90a;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\stealth\utility;
#using scripts\common\script;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\at_mine;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_music;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_contract_hvt;

// Namespace ob_activity_contract_hvt
// Params 0, eflags: 0x5
// Checksum 0xe3668d88, Offset: 0x72e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f8b4c55ff7217f8e", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_contract_hvt
// Params 0, eflags: 0x4
// Checksum 0x22301f69, Offset: 0x757
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_CONTRACT_HVT", &hvt_activity_type_init );
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0xb5cc2c53, Offset: 0x772
// Size: 0xb5
function hvt_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_HVT", 0, &contract_hvt_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_HVT", 1, &contract_hvt_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_HVT", 2, &contract_hvt_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_HVT", 3, &function_5cb583c25a06ddc2 );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_HVT", 4, &function_d36698c8c8078cb5 );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_HVT", 5, &function_f6df66a4581624c2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_dd5f9b97aaa151bb, "REV_OB_CONTRACT_HVT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_f7804f07728b5c1b, "REV_OB_CONTRACT_HVT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_7de9982c032c39c7, "REV_OB_CONTRACT_HVT" );
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0xbe8fe329, Offset: 0x82f
// Size: 0x493
function contract_hvt_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.difficulty_tier = ob_activity_definition_utils::function_ee700758cb24d61f( self.varianttag );
    self.hvtcount = self.var_91c91f4a631c481d.hvtcount;
    
    if ( !function_ced91adb6b90acdc() )
    {
        return;
    }
    
    self.master_struct = utility::getstruct( self.varianttag, "script_noteworthy" );
    self.hvt_spawnpoints = [];
    self.trap_spawnpoints = [];
    self.var_b06de14f9ac851a5 = [];
    self.bodyguard_encounter_struct = undefined;
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.master_struct.origin );
    
    foreach ( struct in utility::getstructarray( self.master_struct.target, "targetname" ) )
    {
        switch ( struct.script_noteworthy )
        {
            case #"hash_fc080b7822842783":
                self.hvt_spawnpoints[ self.hvt_spawnpoints.size ] = struct;
                break;
            case #"hash_6bbee1972ee0a8e8":
                self.bodyguard_encounter_struct = struct;
            case #"hash_74e2f521aa352a6a":
            case #"hash_bfabb834c595ff16":
                self.trap_spawnpoints[ self.trap_spawnpoints.size ] = struct;
                break;
            default:
                assertmsg( "<dev string:x24>" + struct.origin + "<dev string:x40>" );
                break;
        }
    }
    
    foreach ( hvt_spawnpoint in self.hvt_spawnpoints )
    {
        foreach ( struct in utility::getstructarray( hvt_spawnpoint.target, "targetname" ) )
        {
            if ( !isdefined( struct.script_noteworthy ) )
            {
                continue;
            }
            
            switch ( struct.script_noteworthy )
            {
                case #"hash_74e2f521aa352a6a":
                case #"hash_bfabb834c595ff16":
                    self.trap_spawnpoints[ self.trap_spawnpoints.size ] = struct;
                    break;
                case #"hash_272a7509df5a3a0":
                    self.var_b06de14f9ac851a5[ self.var_b06de14f9ac851a5.size ] = struct;
                    break;
                case #"hash_43093d1144da5061":
                    break;
                default:
                    break;
            }
        }
        
        hvt_spawnpoint.enter_trigger = getnoentvolumearray( hvt_spawnpoint.target, #targetname )[ 0 ];
        assert( isdefined( hvt_spawnpoint.enter_trigger ), "<dev string:x68>" + hvt_spawnpoint.origin );
    }
    
    waitframe();
    activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ self.id ] ?? [];
    
    foreach ( joiner in activityjoininteracts )
    {
        joiner thread function_71f0aa2038cf2b14( self );
    }
    
    self.hvt_spawned = 0;
    function_785d41eccdfa9afb();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x75c99b4c, Offset: 0xcca
// Size: 0xe4
function function_71f0aa2038cf2b14( activity_instance )
{
    activity_instance endon( #"ActivityBegin" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.joiner_trigger = spawn( "noent_volume_trigger_radius", self.origin, 0, 1000, 200 );
    noticed_players = [];
    
    while ( true )
    {
        activity_instance.joiner_trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && player::isreallyalive( ent ) )
        {
            squad_members_nearby = ent ob_activity_utility::function_468428fa3b477b54();
            broadcast_targets = arrayremove( squad_members_nearby, noticed_players );
            
            if ( broadcast_targets.size )
            {
                noticed_players = arraycombineunique( noticed_players, broadcast_targets );
                activity_instance thread ob_activity_utility::function_894ac80e038636c5( "wcpvehvtdrone", broadcast_targets );
            }
        }
    }
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x3a8235a4, Offset: 0xdb6
// Size: 0xf7
function contract_hvt_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( self.master_struct ) )
    {
        iprintlnbold( "Hvt contract named [ " + self.varianttag + " ]  is currently being maintenanced, comming soon." );
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    namespace_b451b5202140ccde::function_3b7d5e996ba0c975( ob_activity_definition_utils::function_e55fda458ce2c4cc( self ), self.playerparticipants );
    namespace_b451b5202140ccde::function_855fd697c30b090c( 0 );
    namespace_b451b5202140ccde::function_9025afff14ea9bee( self.hvtcount );
    ob_activity_utility::function_894ac80e038636c5( "wcpvehvtbrief" );
    function_514c0f530e19e8fa();
    self.var_45508395ef6c00e1 = [];
    self.killedhvt = 0;
    ob_music::function_859fd7ab75f367c2( activity_instance );
    function_3daa2878c45d70df();
    function_4d0cc070a08c653f();
    function_19cfa1ba96d68f70();
    thread function_6d9da23594d26e2c();
    
    while ( self.killedhvt < self.hvtcount )
    {
        waitframe();
    }
    
    contract_hvt_succeeded();
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x6f009909, Offset: 0xeb5
// Size: 0x186
function function_4d0cc070a08c653f()
{
    var_c9eabfcfc379c01b = self.hvt_spawnpoints[ 0 ].origin[ 2 ] + 600;
    marker_origin = ( self.master_struct.origin[ 0 ], self.master_struct.origin[ 1 ], var_c9eabfcfc379c01b );
    self.big_circle_marker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_hvt", 0, 0 );
    objidpoolmanager::update_objective_position( self.big_circle_marker, marker_origin );
    objidpoolmanager::update_objective_description( self.big_circle_marker, &"sat_ob_activities/objective_hvt_area" );
    objective_showtoplayersinmask( self.big_circle_marker );
    objective_removeallfrommask( self.big_circle_marker );
    main_player = undefined;
    
    foreach ( player in self.playerparticipants )
    {
        if ( isalive( player ) && !main_player )
        {
            main_player = player;
        }
        
        function_421ca151b2062260( player, 1 );
    }
    
    if ( !isdefined( main_player ) )
    {
        return;
    }
    
    thread function_e56c00b301ef3d44( main_player, 1, self.big_circle_marker, self.master_struct.origin );
}

// Namespace ob_activity_contract_hvt
// Params 4
// Checksum 0xbe3d8726, Offset: 0x1043
// Size: 0x53
function function_e56c00b301ef3d44( player, delay_time, var_1348ae8d95a313d0, marker_origin )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait delay_time;
    
    if ( isdefined( player ) )
    {
        player calloutmarkerping::function_5d7b7302e94b97c2( var_1348ae8d95a313d0, marker_origin );
    }
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x5964d919, Offset: 0x109e
// Size: 0x24
function function_785d41eccdfa9afb()
{
    self.traps = spawnstruct();
    self.traps.mines = [];
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x62e8aca2, Offset: 0x10ca
// Size: 0xe8
function function_7fbacc9459d03d41( hvt )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    spawn_struct = hvt.spawn_struct;
    var_615f54d257e0c5d1 = hvt.var_615f54d257e0c5d1;
    hvt waittill( #"death" );
    level spatial_zone_container::function_ddcd5f35f0032b25( self, "music_awareness_zone", var_615f54d257e0c5d1 );
    self.killedhvt++;
    self.var_45508395ef6c00e1 = arrayremove( self.var_45508395ef6c00e1, hvt );
    thread namespace_d7fa4530141146a5::function_501e44ea1cb9219d( spawn_struct.var_1348ae8d95a313d0 );
    self notify( #"hash_2e6f058853edf4dd" );
    namespace_b451b5202140ccde::function_855fd697c30b090c( self.killedhvt );
    
    if ( self.killedhvt == self.hvtcount )
    {
        self.rewardspawnlocation = hvt.origin;
    }
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x84938526, Offset: 0x11ba
// Size: 0x2f
function contract_hvt_succeeded()
{
    activity_instance = self;
    ob_activity_utility::function_894ac80e038636c5( "wcpvehvtsuccess", undefined, undefined, undefined, undefined, &function_5080f1ae602fb9dc );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x1aeef08e, Offset: 0x11f1
// Size: 0x2b
function function_5080f1ae602fb9dc( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcpvehvtsuccess_voss" )
    {
        return [ "wcpvehvtclapback", "wcpvehvtlastword" ];
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0xd9b37902, Offset: 0x1225
// Size: 0x1a0
function function_f1750127a47998ea( hvt )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    hvt endon( #"ai_seen" );
    hvt endon( #"death" );
    
    while ( true )
    {
        foreach ( player in self.playerparticipants )
        {
            dist = distancesquared( player.origin, hvt.origin );
            
            if ( dist < squared( 2000 ) && utility::within_fov( player.origin, player getplayerangles(), hvt.origin, 0.966 ) )
            {
                sightcheck_origin = ( hvt.origin[ 0 ], hvt.origin[ 1 ], hvt.origin[ 2 ] + 50 );
                eyepos = player geteye();
                waitframe();
                
                if ( sighttracepassed( eyepos, sightcheck_origin, 1, player, hvt ) )
                {
                    hvt.seen = 1;
                    function_19ec1276a1aae0ca( hvt );
                    hvt notify( #"ai_seen" );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0xd3e1a06b, Offset: 0x13cd
// Size: 0x67
function function_d79c902ea887a49( hvt )
{
    hvt_marker_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_hvt_boss", 0, 0 );
    objidpoolmanager::update_objective_onentity( hvt_marker_id, hvt );
    objidpoolmanager::update_objective_description( hvt_marker_id, &"sat_ob_activities/objective_hvt" );
    objective_showtoplayersinmask( hvt_marker_id );
    objective_removeallfrommask( hvt_marker_id );
    hvt.spawn_struct.var_1348ae8d95a313d0 = hvt_marker_id;
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x1cf1a9c3, Offset: 0x143c
// Size: 0x12c
function hvt_think( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"death" );
    self setbtgoalstationary( 4 );
    enter_trigger = self.spawn_struct.enter_trigger;
    
    if ( !isdefined( enter_trigger ) )
    {
        assertmsg( "<dev string:x9c>" + self.origin );
        return;
    }
    
    enter_trigger thread watch_player_approach( activity_instance, self );
    thread function_f2579707219ac88( activity_instance );
    utility::function_687d8d65c40a5f86( "combat", &function_6952a5c94151c1eb );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "player_approach", "damage", "guards_down", "hvt_stealth_event" );
        self notify( #"unfreezed" );
        self.unfreezed = 1;
        
        /#
            if ( getdvarint( @"hash_e95032023f170d47", 1 ) )
            {
                debugstar( self.origin, ( 1, 1, 0 ), 800, "<dev string:xd0>" + msg, 0.7 );
            }
        #/
        
        self clearbtgoal( 4 );
        return;
    }
}

// Namespace ob_activity_contract_hvt
// Params 2
// Checksum 0x4a7231d, Offset: 0x1570
// Size: 0x137
function watch_player_approach( activity_instance, hvt )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    hvt endon( #"death" );
    hvt endon( #"unfreezed" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) && !ent vehicle::is_vehicle() )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            var_de8a698c54e1b4c2 = 0;
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) )
                {
                    var_de8a698c54e1b4c2 = 1;
                }
            }
            
            if ( !var_de8a698c54e1b4c2 )
            {
                continue;
            }
        }
        
        hvt notify( #"player_approach" );
        return;
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x9745039b, Offset: 0x16af
// Size: 0x91
function function_6952a5c94151c1eb( var_3a722e056be190b2 )
{
    if ( self.unfreezed )
    {
        return;
    }
    
    foreach ( event in self.watch_events )
    {
        self addaieventlistener( event );
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0xf1dedec0, Offset: 0x1748
// Size: 0x33d
function function_f2579707219ac88( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"unfreezed" );
    self.watch_events = [ "sight", "saw_corpse", "bulletwhizby", "object_whizby", "projectile_ping", "throwingknife_whizby", "grenade danger", "grenade_ping", "explosion", "explosion_small", "decoy_grenade" ];
    distance_override = [ "decoy_grenade":256, "explosion_small":256, "explosion":256, "grenade danger":256, "grenade_ping":256 ];
    
    foreach ( event in self.watch_events )
    {
        self addaieventlistener( event );
    }
    
    while ( true )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        self waittill( #"ai_events", events );
        
        if ( !utility::ent_flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        foreach ( event in events )
        {
            /#
                if ( getdvarint( @"hash_e95032023f170d47", 0 ) )
                {
                    debugstar( event.origin, ( 0, 0, 1 ), 100, "<dev string:xde>" + event.type, 0.7 );
                }
            #/
            
            if ( arraycontains( self.watch_events, event.type ) )
            {
                dist = distance_override[ event.type ];
                
                if ( dist && distancesquared( event.origin, self.origin ) > dist * dist )
                {
                    continue;
                }
                
                /#
                    if ( getdvarint( @"hash_e95032023f170d47", 1 ) )
                    {
                        debugstar( event.origin + ( 0, 0, 30 ), ( 1, 1, 0 ), 800, "<dev string:xe7>" + event.type, 0.7 );
                        line( self.origin, event.origin + ( 0, 0, 30 ), ( 1, 1, 0 ), 1, 0, 800 );
                    }
                #/
                
                self notify( #"hvt_stealth_event" );
                break;
            }
        }
    }
}

// Namespace ob_activity_contract_hvt
// Params 4
// Checksum 0xb9807562, Offset: 0x1a8d
// Size: 0x5b
function function_bd699fe433e50d16( requestid, userdata, agent, data )
{
    /#
        print3d( agent.origin, "<dev string:xf4>", ( 1, 1, 0 ), 0.9, 0.7, 3600, 1 );
    #/
}

// Namespace ob_activity_contract_hvt
// Params 2
// Checksum 0xca88d0e0, Offset: 0x1af0
// Size: 0x37e
function function_d3d1f8f2530044ba( requestid, userdata )
{
    activity_instance = userdata[ 0 ];
    spawn_struct = userdata[ 1 ];
    
    if ( !isdefined( activity_instance ) || activity_instance.state != "Active" )
    {
        script::demoforcesre( "[HVT] hvt group spawned but activity is not in active state!" );
        return;
    }
    
    data = function_9b649316adcccbaa( requestid );
    hvt = undefined;
    body_guards = [];
    
    foreach ( agent in data.ai )
    {
        if ( isalive( agent ) )
        {
            is_hvt = agent.directorspawndata.spawnfilter == #"hvt_jugg";
            
            if ( is_hvt )
            {
                hvt = agent;
                hvt.spawn_struct = spawn_struct;
                hvt.var_e94a0381e288005e = #"juggerbot_hvt";
                agent.activityboss = 1;
                activity_instance.var_45508395ef6c00e1[ activity_instance.var_45508395ef6c00e1.size ] = hvt;
                hvt.var_615f54d257e0c5d1 = level spatial_zone_container::function_847140d2863dfbf8( activity_instance, "music_awareness_zone", hvt.origin, 2500 );
                
                foreach ( player in activity_instance.playerparticipants )
                {
                    outline::outlineenableforplayer( hvt, player, "sat_ob_activity_stronghold_boss_outline", "level_script" );
                }
                
                activity_instance thread function_7fbacc9459d03d41( hvt );
                continue;
            }
            
            body_guards[ body_guards.size ] = agent;
            
            /#
                print3d( agent.origin, "<dev string:xfd>", ( 0, 1, 1 ), 0.9, 0.7, 3600, 1 );
            #/
        }
    }
    
    if ( isdefined( hvt ) )
    {
        hvt.body_guards = body_guards;
        
        foreach ( agent in hvt.body_guards )
        {
            agent.hvt = hvt;
            agent agent_utils::function_1874e18b42e6d814( &function_943d8dd3946c8611 );
        }
    }
    else
    {
        activity_instance.killedhvt++;
        activity_instance namespace_b451b5202140ccde::function_855fd697c30b090c( activity_instance.killedhvt );
        script::demoforcesre( "[HVT] hvt group spawned but no hvt alive! encounter:" + data.encounterbundle + data.origin );
    }
    
    activity_instance.hvt_spawned++;
    
    if ( activity_instance.hvt_spawned >= activity_instance.hvtcount )
    {
        activity_instance notify( #"all_hvt_spawned" );
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0xbd34b867, Offset: 0x1e76
// Size: 0x12f
function function_943d8dd3946c8611( dmg_struct )
{
    if ( isalive( self.hvt ) && self.hvt.body_guards && dmg_struct.idamage >= self.health )
    {
        alive_count = 0;
        
        foreach ( agent in self.hvt.body_guards )
        {
            if ( isalive( agent ) && agent != self )
            {
                alive_count++;
            }
        }
        
        if ( alive_count <= 3 )
        {
            self.hvt notify( #"guards_down" );
        }
        
        self.hvt.body_guards = arrayremove( self.hvt.body_guards, self );
    }
    
    return -1;
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0xa2a20961, Offset: 0x1fae
// Size: 0x20f
function function_19cfa1ba96d68f70()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"hash_d60f4c5ebbb538c" );
    quickspawn = getdvarint( @"hash_3db2eebf7ffb7b43", 0 );
    hvt_spawn_points = function_59c51b346780fb30();
    
    if ( hvt_spawn_points.size < self.hvtcount )
    {
        assertmsg( "<dev string:x109>" );
        activity_instance_common::endactivity( activity_instance, 0 );
        function_5cb583c25a06ddc2();
        return;
    }
    
    /#
        thread hvt_debug_func();
    #/
    
    if ( quickspawn )
    {
        spawn_hvt( hvt_spawn_points );
    }
    
    self.boss_revealed = 0;
    
    while ( !self.boss_revealed )
    {
        foreach ( player in self.playerparticipants )
        {
            if ( distance2dsquared( player.origin, self.master_struct.origin ) <= squared( self.circleradius ) )
            {
                if ( !quickspawn )
                {
                    spawn_hvt( hvt_spawn_points );
                }
                
                foreach ( hvt in self.var_45508395ef6c00e1 )
                {
                    if ( isalive( hvt ) && isdefined( hvt.spawn_struct ) )
                    {
                        function_d79c902ea887a49( hvt );
                    }
                }
                
                self.boss_revealed = 1;
                self notify( #"hash_d60f4c5ebbb538c" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_contract_hvt
// Params 2, eflags: 0x4
// Checksum 0x435f5790, Offset: 0x21c5
// Size: 0x137
function private function_a4cdfe7e9b41e14c( player, isvisible )
{
    if ( !isdefined( self.var_f66fedb97aef24a ) )
    {
        self.var_f66fedb97aef24a = [];
    }
    
    was_visible = arraycontains( self.var_f66fedb97aef24a, player );
    
    if ( was_visible == isvisible )
    {
        return;
    }
    
    foreach ( hvt in self.var_45508395ef6c00e1 )
    {
        var_1348ae8d95a313d0 = hvt.spawn_struct.var_1348ae8d95a313d0;
        
        if ( var_1348ae8d95a313d0 )
        {
            if ( isvisible )
            {
                namespace_d7fa4530141146a5::function_7c5730b9151d91( [ player ], var_1348ae8d95a313d0 );
                self.var_f66fedb97aef24a[ self.var_f66fedb97aef24a.size ] = player;
                continue;
            }
            
            namespace_d7fa4530141146a5::function_831cf83f2b250537( [ player ], var_1348ae8d95a313d0 );
            self.var_f66fedb97aef24a = arrayremove( self.var_f66fedb97aef24a, player );
        }
    }
}

// Namespace ob_activity_contract_hvt
// Params 2, eflags: 0x4
// Checksum 0x7d2e13d, Offset: 0x2304
// Size: 0xd0
function private function_421ca151b2062260( player, isvisible )
{
    if ( !isdefined( self.var_22bfaf81d930e0f0 ) )
    {
        self.var_22bfaf81d930e0f0 = [];
    }
    
    was_visible = arraycontains( self.var_22bfaf81d930e0f0, player );
    
    if ( was_visible == isvisible )
    {
        return;
    }
    
    if ( !game_utility::questcircle_exists() )
    {
        return;
    }
    
    if ( isvisible )
    {
        namespace_d7fa4530141146a5::function_7c5730b9151d91( [ player ], self.big_circle_marker );
        game_utility::questcircle_showtoplayer( player );
        self.var_22bfaf81d930e0f0[ self.var_22bfaf81d930e0f0.size ] = player;
        return;
    }
    
    namespace_d7fa4530141146a5::function_831cf83f2b250537( [ player ], self.big_circle_marker );
    game_utility::questcircle_hidefromplayer( player );
    self.var_22bfaf81d930e0f0 = arrayremove( self.var_22bfaf81d930e0f0, player );
}

// Namespace ob_activity_contract_hvt
// Params 1, eflags: 0x4
// Checksum 0xb0ad3f3b, Offset: 0x23dc
// Size: 0x141
function private function_bce9037b484ee476( player )
{
    if ( !isdefined( self.var_22bfaf81d930e0f0 ) )
    {
        self.var_22bfaf81d930e0f0 = [];
    }
    
    if ( !isdefined( self.var_f66fedb97aef24a ) )
    {
        self.var_f66fedb97aef24a = [];
    }
    
    if ( !isdefined( self.var_543ae12d7a379111 ) )
    {
        self.var_543ae12d7a379111 = [];
    }
    
    is_player_in_circle = distance2dsquared( player.origin, self.master_struct.origin ) <= squared( self.circleradius );
    var_7d5851a1566d61b = arraycontains( self.var_22bfaf81d930e0f0, player );
    var_6d0d773899b5aaa7 = arraycontains( self.var_f66fedb97aef24a, player );
    
    if ( is_player_in_circle )
    {
        if ( !var_6d0d773899b5aaa7 )
        {
            function_a4cdfe7e9b41e14c( player, 1 );
        }
        
        if ( var_7d5851a1566d61b )
        {
            function_421ca151b2062260( player, 0 );
        }
        
        if ( !arraycontains( self.var_543ae12d7a379111, player ) )
        {
            ob_activity_utility::function_894ac80e038636c5( "wcpvehvtintelsecure", [ player ] );
            self.var_543ae12d7a379111[ self.var_543ae12d7a379111.size ] = player;
        }
        
        return;
    }
    
    if ( !var_7d5851a1566d61b )
    {
        function_421ca151b2062260( player, 1 );
    }
    
    if ( var_6d0d773899b5aaa7 )
    {
        function_a4cdfe7e9b41e14c( player, 0 );
    }
}

// Namespace ob_activity_contract_hvt
// Params 0, eflags: 0x4
// Checksum 0x7e3218b, Offset: 0x2525
// Size: 0xa1
function private function_6d9da23594d26e2c()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        foreach ( player in self.playerparticipants )
        {
            function_bce9037b484ee476( player );
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_contract_hvt
// Params 1, eflags: 0x4
// Checksum 0x2a719b93, Offset: 0x25ce
// Size: 0x1a8
function private spawn_hvt( hvt_spawn_points )
{
    self.hvt_encounters = [];
    
    for ( i = 0; i < self.hvtcount ; i++ )
    {
        spawn_struct = hvt_spawn_points[ i ];
        
        /#
            if ( !isdefined( spawn_struct.radius ) )
            {
                iprintlnbold( "<dev string:x152>" );
            }
        #/
        
        encounter_name = spawn_struct.script_parameters ?? "sat_ob_contract_hvt_encounter_hvt";
        var_b7e6d2d89bfacd6 = spawn_struct.radius ?? 2000;
        var_6bad780df9856ad8 = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:" + encounter_name, spawn_struct.origin, var_b7e6d2d89bfacd6, 1, 0, 1, 2 );
        function_64ac8c4e752f4dca( var_6bad780df9856ad8, 0 );
        activity_ai_encounters::function_6bf4ff2fbde584ee( var_6bad780df9856ad8, &function_d3d1f8f2530044ba, [ self, spawn_struct ] );
        self.hvt_encounters[ self.hvt_encounters.size ] = var_6bad780df9856ad8;
    }
    
    self waittill( #"all_hvt_spawned" );
    trap_owner = ob_activity_utility::function_d12ca4c58fe5faf0();
    thread function_4020e6e2f32d2ab8( hvt_spawn_points, trap_owner );
    
    foreach ( hvt in self.var_45508395ef6c00e1 )
    {
        thread function_f1750127a47998ea( hvt );
        hvt thread hvt_think( self );
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x637f83de, Offset: 0x277e
// Size: 0xdc
function contract_hvt_patrol( var_edbd4062d5dad4a2 )
{
    self endon( #"engaging" );
    self endon( #"death" );
    self clearbtgoal( 4 );
    patroltarget = var_edbd4062d5dad4a2;
    
    while ( true )
    {
        waitframe();
        self setbtgoalpos( 4, getclosestpointonnavmesh( patroltarget.origin ) );
        
        while ( distance2dsquared( self.origin, patroltarget.origin ) > squared( 200 ) )
        {
            waitframe();
        }
        
        var_14cfd715a8b90058 = undefined;
        
        if ( isdefined( patroltarget.target ) )
        {
            var_14cfd715a8b90058 = utility::getstruct( patroltarget.target, "targetname" );
        }
        
        if ( isdefined( var_14cfd715a8b90058 ) )
        {
            patroltarget = var_14cfd715a8b90058;
            continue;
        }
        
        self function_fa32376aaa88a7a2( self.origin, 5000 );
        self setbtgoalstationary( 4 );
        break;
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0xd188ba12, Offset: 0x2862
// Size: 0x10e
function function_ca280f0ae2aa14e6( is_hvt = 1 )
{
    hvtsubclass = is_hvt ? "ob_tactician_hvt" : "ob_soldier";
    
    if ( isdefined( self.script_parameters ) )
    {
        switch ( self.script_parameters )
        {
            case #"hash_2453c9ffec9f5c20":
                hvtsubclass = "ob_juggernaut_hvt";
                break;
            case #"hash_6191aaef9f922f96":
                hvtsubclass = "ob_commander_hvt";
                break;
            case #"hash_62809a88ac559a3b":
                hvtsubclass = "ob_hvt_bodyguard_cqb";
                break;
            case #"hash_739c251d9f76a270":
                hvtsubclass = "ob_sniper";
                break;
            case #"hash_d5d252eb91d1700b":
                hvtsubclass = "zombie_mangler_hvt";
                break;
            case #"hash_57f1e1130e644c8e":
                hvtsubclass = "zombie_mimic_hvt";
                break;
            case #"hash_eb2d6ae532806496":
                hvtsubclass = "zombie_ghoul";
                break;
            default:
                break;
        }
    }
    
    aitype = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( hvtsubclass );
    return aitype;
}

// Namespace ob_activity_contract_hvt
// Params 2
// Checksum 0x8e652962, Offset: 0x2979
// Size: 0x2b1
function function_4020e6e2f32d2ab8( hvtspawnpoints, owner )
{
    foreach ( struct in self.trap_spawnpoints )
    {
        if ( isdefined( struct.targetname ) )
        {
            if ( struct.targetname == self.master_struct.target )
            {
                struct.should_spawn_trap = 1;
                continue;
            }
            
            foreach ( p in hvtspawnpoints )
            {
                if ( struct.targetname == p.target )
                {
                    struct.should_spawn_trap = 1;
                    break;
                }
            }
        }
    }
    
    foreach ( struct in self.trap_spawnpoints )
    {
        if ( !struct.should_spawn_trap )
        {
            continue;
        }
        
        if ( struct.script_noteworthy == "sentry" )
        {
            if ( self.difficulty_region != "difficulty_easy" )
            {
                struct.allowemp = 1;
                struct.var_b9ac62a4e325b4be = #"killstreak";
                ob_activity_utility::ob_activity_spawn_turret( struct, undefined, owner, 0, 1 );
            }
            
            continue;
        }
        
        if ( struct.script_noteworthy == "mine" )
        {
            mine = ob_soldier_util::ob_mine_spawn( struct.origin, undefined, owner, undefined, struct.angles, 1 );
            
            if ( getdvarint( @"hash_d670f137f06e577f", 0 ) )
            {
                ob_resource_manager::function_4d956586279ad989( mine );
            }
            
            self.traps.mines[ self.traps.mines.size ] = mine;
        }
    }
}

// Namespace ob_activity_contract_hvt
// Params 2
// Checksum 0x7aa8d863, Offset: 0x2c32
// Size: 0x153
function function_70148327f63c5f4c( hvt, hvtspawnpoint )
{
    hvt.var_de26f3e8433e0a1d = [];
    
    foreach ( struct in self.var_b06de14f9ac851a5 )
    {
        if ( struct.targetname != hvtspawnpoint.target )
        {
            continue;
        }
        
        agent_type = struct function_ca280f0ae2aa14e6( 0 );
        agent = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( agent_type[ 0 ], struct.origin, struct.angles, "team_hundred_ninety" );
        agent.hvt_master = hvt;
        hvt.var_de26f3e8433e0a1d[ hvt.var_de26f3e8433e0a1d.size ] = agent;
        
        /#
            if ( isdefined( agent ) )
            {
                print3d( agent.origin, "<dev string:xfd>", ( 0, 1, 1 ), 0.9, 0.7, 3600, 1 );
            }
        #/
    }
}

// Namespace ob_activity_contract_hvt
// Params 0, eflags: 0x4
// Checksum 0x3d20e814, Offset: 0x2d8d
// Size: 0x1df
function private function_514c0f530e19e8fa()
{
    var_f53b9668ae989029 = self.bodyguard_encounter_struct;
    
    if ( isdefined( var_f53b9668ae989029 ) )
    {
        encounter_name = var_f53b9668ae989029.script_parameters;
        var_b7e6d2d89bfacd6 = var_f53b9668ae989029.radius ?? 2000;
        
        if ( isdefined( encounter_name ) )
        {
            self.var_3b81e97c7cad4f5a = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:" + encounter_name, var_f53b9668ae989029.origin, var_b7e6d2d89bfacd6, 1, 0, 1, 2 );
            
            if ( isdefined( self.var_3b81e97c7cad4f5a ) )
            {
                userdata = spawnstruct();
                userdata.var_1cbf42a60beddd7f = self;
                activity_ai_encounters::function_52d1342183200a8f( self.var_3b81e97c7cad4f5a, &function_bd699fe433e50d16, userdata );
            }
        }
    }
    
    self.scriptable_blockers = [];
    blocker_name = "hvt_blocker_" + self.varianttag;
    scriptables = getentitylessscriptablearray( blocker_name, "targetname" );
    
    foreach ( scriptable in scriptables )
    {
        if ( isdefined( scriptable.classname ) && issubstr( scriptable.classname, "scriptable_blocker" ) )
        {
            scriptable utility::function_32b24db3127bff40( "state", "visible" );
            self.scriptable_blockers[ self.scriptable_blockers.size ] = scriptable;
        }
    }
    
    var_edd0cb6e9ee724e9 = "hvt_cover_" + self.varianttag;
    self.scriptable_covers = ob_soldier_util::function_a315cc5d1dee425a( var_edd0cb6e9ee724e9 );
    waitframe();
    ob_activity_utility::ob_enable_cover_nodes();
}

// Namespace ob_activity_contract_hvt
// Params 0, eflags: 0x4
// Checksum 0xb885e671, Offset: 0x2f74
// Size: 0x310
function private function_59c51b346780fb30()
{
    var_da7420b0bbfab014 = arrayrandomize( self.hvt_spawnpoints );
    hvt_spawnpoints = [];
    spawnpoint_label = undefined;
    
    /#
        var_a63af39d5ec11874 = getdvar( @"hash_41025d66893ffece", "<dev string:x1ac>" );
        
        if ( var_a63af39d5ec11874 != "<dev string:x1ac>" )
        {
            foreach ( p in var_da7420b0bbfab014 )
            {
                if ( p.script_label == var_a63af39d5ec11874 )
                {
                    spawnpoint_label = var_a63af39d5ec11874;
                    break;
                }
            }
            
            if ( !isdefined( spawnpoint_label ) )
            {
                iprintlnbold( "<dev string:x1ad>" + var_a63af39d5ec11874 + "<dev string:x1cf>" );
            }
            else
            {
                iprintlnbold( "<dev string:x1d2>" + var_a63af39d5ec11874 + "<dev string:x1cf>" );
            }
        }
    #/
    
    foreach ( p in var_da7420b0bbfab014 )
    {
        /#
            print3d( p.origin, p.script_label ?? "<dev string:x1e8>", ( 1, 0, 0 ), 1, 1, 3600, 1 );
        #/
        
        if ( !isdefined( spawnpoint_label ) || p.script_label == spawnpoint_label )
        {
            hvt_spawnpoints[ hvt_spawnpoints.size ] = p;
            
            /#
                print3d( p.origin + ( 0, 0, 30 ), "<dev string:x1f8>", ( 0, 1, 0 ), 1, 1, 3600, 1 );
            #/
            
            if ( !isdefined( spawnpoint_label ) && isdefined( p.script_label ) )
            {
                spawnpoint_label = p.script_label;
            }
            
            if ( hvt_spawnpoints.size >= self.hvtcount )
            {
                break;
            }
        }
    }
    
    if ( hvt_spawnpoints.size < self.hvtcount )
    {
        left_spawnpoints = arrayremove( var_da7420b0bbfab014, hvt_spawnpoints );
        
        foreach ( p in left_spawnpoints )
        {
            hvt_spawnpoints[ hvt_spawnpoints.size ] = p;
            
            /#
                print3d( p.origin + ( 0, 0, 30 ), "<dev string:x1f8>", ( 0, 1, 0 ), 1, 1, 3600, 1 );
            #/
            
            if ( hvt_spawnpoints.size == self.hvtcount )
            {
                break;
            }
        }
    }
    
    return hvt_spawnpoints;
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x2b479f62, Offset: 0x328d
// Size: 0x160
function contract_hvt_activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    level ob_music::function_be4c0727a998b18b( activity_instance );
    function_298ff085d8113e29();
    
    if ( isdefined( self.hvt_encounters ) )
    {
        foreach ( encounter in self.hvt_encounters )
        {
            function_b43716082f77e5e5( encounter );
        }
    }
    
    if ( isdefined( self.var_3b81e97c7cad4f5a ) )
    {
        function_b43716082f77e5e5( self.var_3b81e97c7cad4f5a );
    }
    
    if ( self.var_45508395ef6c00e1 )
    {
        foreach ( hvt in self.var_45508395ef6c00e1 )
        {
            if ( isalive( hvt ) )
            {
                hvt clearbtgoal( 4 );
            }
        }
    }
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x5eda7f30, Offset: 0x33f5
// Size: 0x1d4
function function_5cb583c25a06ddc2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    level ob_music::function_be4c0727a998b18b( activity_instance );
    function_298ff085d8113e29();
    
    if ( self.var_45508395ef6c00e1 )
    {
        foreach ( hvt in self.var_45508395ef6c00e1 )
        {
            hvt kill();
        }
    }
    
    ob_soldier_util::function_3604220db3a0a0cf( self.scriptable_covers );
    ob_activity_utility::ob_disable_cover_nodes();
    
    foreach ( blocker in self.scriptable_blockers )
    {
        blocker utility::function_32b24db3127bff40( "state", "Hidden" );
    }
    
    foreach ( mine in self.traps.mines )
    {
        if ( isdefined( mine ) )
        {
            mine thread at_mine::at_mine_destroy();
        }
    }
    
    ob_activity_utility::function_1467dab20b2d22();
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x9930b714, Offset: 0x35d1
// Size: 0x23
function function_d36698c8c8078cb5()
{
    if ( isdefined( self.master_struct ) )
    {
        return self.master_struct.origin;
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x515cf9b2, Offset: 0x35fd
// Size: 0x63
function function_f6df66a4581624c2( relevantinfostruct )
{
    var_c786523ebe9c85c0 = 1;
    rewardspawnlocation = self.rewardspawnlocation ?? self.playerparticipants[ 0 ].origin;
    var_983974fc347bb3cb = ob_activity_rewards::function_f23d5e30cd73e104( rewardspawnlocation, var_c786523ebe9c85c0, self.riftoffset );
    return var_983974fc347bb3cb;
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x9bd61834, Offset: 0x3669
// Size: 0xb0
function function_dd5f9b97aaa151bb( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( !self.boss_revealed && isdefined( self.big_circle_marker ) )
    {
        foreach ( player in player_list )
        {
            function_421ca151b2062260( player, 1 );
        }
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x7b7e5d31, Offset: 0x3721
// Size: 0x9e
function function_f7804f07728b5c1b( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        function_a4cdfe7e9b41e14c( player, 0 );
        function_421ca151b2062260( player, 0 );
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x5d254c49, Offset: 0x37c7
// Size: 0x23
function function_7de9982c032c39c7( relevant_info_struct )
{
    ob_activity_utility::function_894ac80e038636c5( "wcpvehvtabandon", relevant_info_struct.playerlist );
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x1c6829dc, Offset: 0x37f2
// Size: 0x65
function function_3daa2878c45d70df()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    waitframe();
    self.circleradius = self.master_struct.radius ?? 3000;
    game_utility::questcircle_create( "Search_Area_Contract_Ob", self.master_struct.origin, self.circleradius );
}

// Namespace ob_activity_contract_hvt
// Params 4
// Checksum 0xddced1bb, Offset: 0x385f
// Size: 0x12f
function function_680831729806ee54( var_897dae3075ed501f, origin, radius, hvt )
{
    if ( !isdefined( self.hvt_circles ) )
    {
        self.hvt_circles = [];
    }
    
    modified_origin = utility::getrandompointincircle( origin, 800 );
    var_683d73e5f436dc89 = spawnstruct();
    var_683d73e5f436dc89 game_utility::questcircle_create( var_897dae3075ed501f, modified_origin, radius );
    
    foreach ( player in self.playerparticipants )
    {
        var_683d73e5f436dc89 game_utility::questcircle_showtoplayer( player );
    }
    
    hvt.mapcircle = var_683d73e5f436dc89.mapcircle;
    var_683d73e5f436dc89.spawnpoint_height = hvt.origin[ 2 ];
    self.hvt_circles[ self.hvt_circles.size ] = var_683d73e5f436dc89;
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0xa8ab9872, Offset: 0x3996
// Size: 0xb3
function function_298ff085d8113e29()
{
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
    
    if ( isdefined( self.hvt_circles ) && self.hvt_circles.size > 0 )
    {
        foreach ( var_fcb964ac6f23a112 in self.hvt_circles )
        {
            if ( var_fcb964ac6f23a112 game_utility::questcircle_exists() )
            {
                var_fcb964ac6f23a112 game_utility::questcircle_delete();
            }
        }
    }
}

// Namespace ob_activity_contract_hvt
// Params 1
// Checksum 0x813f8a58, Offset: 0x3a51
// Size: 0xe2
function function_19ec1276a1aae0ca( hvt )
{
    if ( !isdefined( hvt.mapcircle ) )
    {
        return;
    }
    
    if ( isdefined( self.hvt_circles ) && self.hvt_circles.size > 0 )
    {
        foreach ( var_fcb964ac6f23a112 in self.hvt_circles )
        {
            if ( var_fcb964ac6f23a112.mapcircle == hvt.mapcircle )
            {
                var_fcb964ac6f23a112 game_utility::questcircle_delete();
                hvt.mapcircle = undefined;
                return;
            }
        }
        
        hvt game_utility::questcircle_delete();
    }
}

// Namespace ob_activity_contract_hvt
// Params 0
// Checksum 0x90dac83a, Offset: 0x3b3b
// Size: 0x76, Type: bool
function function_ced91adb6b90acdc()
{
    var_3b734c3528e0386f = utility::getstructarray( self.varianttag, "script_noteworthy" );
    
    if ( var_3b734c3528e0386f.size != 1 )
    {
        if ( var_3b734c3528e0386f.size == 0 )
        {
            logstring( "HVT contract [ " + self.varianttag + " ] is not prpoerly set, make sure all Radiant entities assembled in new format " );
        }
        else
        {
            logstring( "Duplicated master struct for HVT contract [ " + self.varianttag + " ] is detected, makesure the old hvt structure in Radiant be deleted and recompile the map " );
        }
        
        activity_instance_common::function_46135a69bddfec2c( self );
        return false;
    }
    
    return true;
}

/#

    // Namespace ob_activity_contract_hvt
    // Params 0
    // Checksum 0x50470212, Offset: 0x3bba
    // Size: 0x1b0, Type: dev
    function hvt_debug_func()
    {
        activity_instance = self;
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_f390306e771dad03", 0 ) == 1 )
            {
                foreach ( hvt in self.var_45508395ef6c00e1 )
                {
                    sphere( hvt.origin, 30, ( 0, 1, 0 ) );
                    
                    if ( isdefined( hvt.script_stealthgroup ) )
                    {
                        print3d( hvt.origin + ( 0, 0, 15 ), "<dev string:x208>" + hvt.script_stealthgroup );
                    }
                }
            }
            
            if ( getdvarint( @"scr_hvt_kill_one", 0 ) == 1 )
            {
                setdvar( @"scr_hvt_kill_one", 0 );
                
                foreach ( hvt in self.var_45508395ef6c00e1 )
                {
                    if ( isalive( hvt ) )
                    {
                        hvt kill();
                        break;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_contract_hvt
    // Params 0
    // Checksum 0x76bcaddb, Offset: 0x3d72
    // Size: 0xbb, Type: dev
    function joiner_debug_draw()
    {
        activity_instance = self.activity_instance;
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_f390306e771dad03", 0 ) == 1 )
            {
                sphere( self.origin, 20, ( 0, 1, 0 ) );
                var_163cfb28145ba080 = anglestoforward( self.angles ) * 10;
                line( self.origin, self.origin + var_163cfb28145ba080, ( 0.9, 0.7, 0.6 ) );
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_contract_hvt
    // Params 0
    // Checksum 0x3d3da98f, Offset: 0x3e35
    // Size: 0x90, Type: dev
    function jugg_debug()
    {
        self endon( #"death" );
        
        while ( true )
        {
            bt_stay = getdvarint( @"hash_d78cd64e35bc256c", -1 );
            
            if ( bt_stay != -1 )
            {
                setdvar( @"hash_d78cd64e35bc256c", -1 );
                self setbtgoalstationary( bt_stay );
            }
            
            bt_clear = getdvarint( @"hash_9897125fee85c93e", -1 );
            
            if ( bt_clear != -1 )
            {
                setdvar( @"hash_9897125fee85c93e", -1 );
                self clearbtgoal( bt_clear );
            }
            
            wait 1;
        }
    }

#/
