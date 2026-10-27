// scripts\mp\ob\activities\ob_activity_possessed_convoy.gsc  (hash_7e4edb928dc95bc2.gscc) (size: 47677 Bytes / 0xba3d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6aa19e79 (1788976761)
// size ...... 47677 (0xba3d)
// includes .. 40  (offset: 0xb041)
// strings ... 110 (offset: 0xb181)
// dev strs .. 22  (offset: 0xb92d)
// exports ... 94  (offset: 0x7741)
// cseg ...... 0xa2a + 0x6d17 (0x7741)
// imports ... 332 (offset: 0x85f1)
// animtree1 . 0   (offset: 0xba3d)
// animtree2 . 0   (offset: 0xba3d)
#using script_5dc2c78e95ce5a77;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_spawn;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_strike_boss_shared;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_convoy_util;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;

#namespace ob_activity_possessed_convoy;

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x5
// Checksum 0x8f2bc321, Offset: 0xa48
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_possessed_convoy", #"activity_common", &function_2e8a5c986bf29933, undefined );
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x1ee8f9c9, Offset: 0xa71
// Size: 0x13
function private function_2e8a5c986bf29933()
{
    activity_common::registeractivitytype( "REV_OB_POSSESSED_CONVOY", &activity_init );
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xb27d07db, Offset: 0xa8c
// Size: 0x16d
function private activity_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_POSSESSED_CONVOY", 0, &possessed_convoy_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_POSSESSED_CONVOY", 1, &possessed_convoy_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_POSSESSED_CONVOY", 2, &possessed_convoy_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_POSSESSED_CONVOY", 3, &possessed_convoy_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &on_player_joined_activity, "REV_OB_POSSESSED_CONVOY" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &on_player_left_activity, "REV_OB_POSSESSED_CONVOY" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerFocusedOnActivity", &activity_player_focus, "REV_OB_POSSESSED_CONVOY" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLoseFocusedOnActivity", &function_729b53f772f3cd08, "REV_OB_POSSESSED_CONVOY" );
    level._effect[ "vfx_possessed_convoy_vehicle_smoke" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core_smoke" );
    level._effect[ "vfx_possessed_convoy_vehicle_destroyed" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core_spawn" );
    level._effect[ "vfx_possessed_convoy_core" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core" );
    level._effect[ "vfx_possessed_convoy_core_trail" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core_trail" );
    level._effect[ "vfx_possessed_convoy_core_impact" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core_impact" );
    level._effect[ "vfx_possessed_convoy_boss_spawn" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core_boss_spawn_blast" );
    level._effect[ "vfx_possessed_convoy_boss_cradle" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core_boss_ambient" );
    level._effect[ "vfx_possessed_convoy_boss_leg" ] = loadfxasset( "vfx_sat_wc_cradle_vehicle_core_boss_amb_leg" );
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x16c07a72, Offset: 0xc01
// Size: 0x3ab
function private possessed_convoy_activity_setup()
{
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.a_vh_convoy = [];
    self.a_ai_convoy = [];
    self.a_loot_caches = [];
    self.nd_spline_start = undefined;
    self.s_center = utility::getstruct( self.varianttag, "targetname" );
    
    if ( !self.s_center )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    self.nd_spline_start = function_614c083b1ed89223();
    assert( self.nd_spline_start, "<dev string:x24>" );
    function_7c841807160cd009( activityvariantdefinition );
    
    if ( !self.s_center )
    {
        assertmsg( "<dev string:x4e>" + self.varianttag + "<dev string:x8a>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    self.str_stealth_group = "sg_" + self.varianttag;
    
    if ( !function_ff2498f19618e5fa( self.str_stealth_group ) )
    {
        stealthinitgroup( self.str_stealth_group );
    }
    
    /#
        iprintln( "<dev string:x98>" + self.varianttag );
    #/
    
    self.var_d5ed03421f78dd64 = 0;
    self.var_f904fd9fe7b07a23 = 0;
    self.a_vh_ground = [];
    self.n_veh_speed = self.defaultspeed;
    
    if ( !level.var_e553079b4cb3ab15 )
    {
        if ( !level.var_c258c37af5be1295 )
        {
            var_7c763fccabe32674 = [];
            regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
            
            foreach ( region in regions )
            {
                if ( !level.var_e607236b193eb0c1.activityinstances[ self.category ][ region.index ] )
                {
                    continue;
                }
                
                instances = level.var_e607236b193eb0c1.activityinstances[ self.category ][ region.index ][ self.type ];
                
                if ( !instances )
                {
                    continue;
                }
                
                foreach ( _instance in instances )
                {
                    var_7c763fccabe32674[ var_7c763fccabe32674.size ] = _instance.name;
                }
            }
            
            level.var_c258c37af5be1295 = utility::array_random( var_7c763fccabe32674 );
        }
        
        if ( self.varianttag != level.var_c258c37af5be1295 )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    }
    
    start_time = self.min_start_time;
    
    if ( self.max_start_time > self.min_start_time )
    {
        start_time = randomintrange( self.min_start_time, self.max_start_time );
    }
    
    start_time = get_override_setting( "start_wait", start_time );
    
    if ( start_time )
    {
        wait start_time;
    }
    
    level.var_e553079b4cb3ab15 = 1;
    thread function_e0a33c63135e5652();
    self waittill( #"possessed_convoy_ready" );
    function_d76ad68a7ccfd2db();
    activity_definition_utils::function_a0a94881bc380bbf( 0, self );
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, self.a_vh_ground.size );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xb9d1d812, Offset: 0xfb4
// Size: 0x15c
function private possessed_convoy_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread function_4787d393f31ccaf0();
    thread function_63eb981bb55153b7();
    thread function_1bcd8f3bb0880b12();
    thread function_43dc512863e62872();
    
    foreach ( convoy_vehicle in self.a_vh_ground )
    {
        ob_convoy_util::function_9846981f8d3b8539( convoy_vehicle );
    }
    
    self waittill( #"all_vehicle_destroyed", boss_spawn_origin );
    self.activity_boss_phase = 1;
    wait 1;
    activity_definition_utils::function_a0a94881bc380bbf( 1, self );
    activity_definition_utils::updateprogress( 0, self, 1 );
    ob_activity_strike_boss_shared::function_faeba2b042cc0dd6( self );
    waittime = 2;
    
    if ( self.vfx_move_time )
    {
        waittime = max( waittime, self.vfx_move_time - 2 );
    }
    
    wait waittime;
    thread possessed_convoy_spawn_boss( boss_spawn_origin );
    self waittill( #"boss_killed" );
    self.boss_killed = 1;
    function_7e78683b28a5b7b4();
    wait 4;
    function_125852f491cf7e5d();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xeefaef90, Offset: 0x1118
// Size: 0x9
function private possessed_convoy_activity_end()
{
    possessed_convoy_cleanup();
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xa6c88870, Offset: 0x1129
// Size: 0x9
function private possessed_convoy_activity_destroy()
{
    possessed_convoy_cleanup();
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xa89e15c1, Offset: 0x113a
// Size: 0x22e
function private possessed_convoy_cleanup()
{
    if ( self.var_e814baa69305ee8a )
    {
        ob_convoy_util::function_27eb33c611286cd9( self.var_e814baa69305ee8a );
        self.var_e814baa69305ee8a = undefined;
    }
    
    if ( self.a_vh_ground )
    {
        foreach ( vehicle in self.a_vh_ground )
        {
            function_64ac8c4e752f4dca( vehicle.var_7cb62ed461d8c370, 1 );
            activity_ai_encounters::function_1010ba035d94f9f1( vehicle.var_7cb62ed461d8c370 );
            vehicle dodamage( vehicle.health, vehicle.origin, vehicle, vehicle, "MOD_CRUSH" );
            vehicle.vehicle_marker_objid = undefined;
            vehicle.var_ca0aadbba0844940 = undefined;
        }
        
        self.a_vh_ground = undefined;
    }
    
    foreach ( var_4b47655c33f51e24 in self.var_504cde334f2cc087 )
    {
        var_4b47655c33f51e24 delete();
    }
    
    self.var_504cde334f2cc087 = undefined;
    
    if ( self.boss_spawn_vfx )
    {
        self.boss_spawn_vfx delete();
        self.boss_spawn_vfx = undefined;
    }
    
    if ( self.var_f5c7f59b645e1f2c )
    {
        self.var_f5c7f59b645e1f2c = undefined;
    }
    
    game_utility::questcircle_delete();
    
    if ( self.spatialzonecontainer )
    {
        spatial_zone_container::function_4f9fccd04a537897( self.spatialzonecontainer, "boss_fight_zone" );
        spatial_zone_container::function_ddcd5f35f0032b25( self.spatialzonecontainer, "boss_fight_zone", self.spatial_zone_struct );
        self.spatialzonecontainer = undefined;
    }
    
    hide_boss_healthbar( self.playerparticipants );
    ob_activity_strike_boss_shared::function_61aa7b6027b4191e( self );
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x4e7ec720, Offset: 0x1370
// Size: 0xbc
function private on_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( self.boss )
    {
        update_boss_healthbar( player_list );
    }
    
    if ( isdefined( self.objidnum ) )
    {
        foreach ( player in player_list )
        {
            objective_addclienttomask( self.objidnum, player );
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xd32f115e, Offset: 0x1434
// Size: 0x121
function private on_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    hide_boss_healthbar( player_list );
    
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in player_list )
        {
            game_utility::questcircle_hidefromplayer( player );
        }
    }
    
    if ( isdefined( self.objidnum ) )
    {
        foreach ( player in player_list )
        {
            objective_removeclientfrommask( self.objidnum, player );
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xe55f4248, Offset: 0x155d
// Size: 0x90
function private activity_player_focus( relevantinfostruct )
{
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in relevantinfostruct.playerlist )
        {
            game_utility::questcircle_showtoplayer( player );
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x36a9d64e, Offset: 0x15f5
// Size: 0x90
function private function_729b53f772f3cd08( relevantinfostruct )
{
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in relevantinfostruct.playerlist )
        {
            game_utility::questcircle_hidefromplayer( player );
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0x83e4ae89, Offset: 0x168d
// Size: 0x1a4
function function_614c083b1ed89223()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_ca257099ad30b077 = self.s_center game_utility_mp::get_linked_vehicle_nodes();
    var_ca257099ad30b077 = arrayrandomize( var_ca257099ad30b077 );
    
    foreach ( startnode in var_ca257099ad30b077 )
    {
        player = function_47c86977a18df38b( level.players, startnode.origin, 1500 );
        
        if ( player )
        {
            continue;
        }
        
        players = player_utility::script_getplayersinradius( startnode.origin, 3000 );
        
        if ( players.size == 0 )
        {
            return startnode;
        }
        
        foreach ( player in players )
        {
            var_8eba82ead0f19157 = trace::ray_trace_passed( player geteye(), startnode.origin + ( 0, 0, 30 ), [ player ] );
            
            if ( var_8eba82ead0f19157 == 0 )
            {
                return startnode;
            }
        }
    }
    
    return utility::array_random( var_ca257099ad30b077 );
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x24e6306, Offset: 0x183a
// Size: 0x1c5
function function_7c841807160cd009( convoyparams )
{
    self.difficulty_region = "difficulty5";
    
    if ( !convoyparams )
    {
        assertmsg( "<dev string:xbb>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    self.ai_team = convoyparams.aiteam ?? "team_hundred_ninety";
    self.slowspeed = convoyparams.slowspeed ?? 12;
    self.highspeed = convoyparams.highspeed ?? 25;
    self.disablecaralarm = convoyparams.disablecaralarm;
    self.defaultspeed = self.slowspeed;
    self.var_7d7a32be78c7fc98 = [];
    
    for ( i = 0; i < convoyparams.convoyvehicles.size ; i++ )
    {
        self.var_7d7a32be78c7fc98[ i ] = spawnstruct();
        self.var_7d7a32be78c7fc98[ i ].riderencounter = "ai_encounter:" + convoyparams.convoyvehicles[ i ].variant_object.riderencounter;
        self.var_7d7a32be78c7fc98[ i ].vehicleref = convoyparams.convoyvehicles[ i ].variant_object.vehicle;
    }
    
    self.var_2c7df72824504573 = 0;
    self.var_124d37318b71248a = convoyparams.var_b0e7811b12bc18cd;
    self.var_124d37318b71248a = get_override_setting( "min_boss_damage_ratio", self.var_124d37318b71248a );
    self.min_start_time = convoyparams.minstarttime;
    self.max_start_time = convoyparams.maxstarttime;
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0xc11063b2, Offset: 0x1a07
// Size: 0x6f
function function_e0a33c63135e5652()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_6faf532ba54370ae = self.nd_spline_start;
    
    while ( true )
    {
        wait 1;
        players = player_utility::script_getplayersinradius( var_6faf532ba54370ae.origin, 2000 );
        
        if ( players.size == 0 )
        {
            break;
        }
    }
    
    self notify( #"possessed_convoy_ready" );
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0x9bee1999, Offset: 0x1a7e
// Size: 0x194
function function_d76ad68a7ccfd2db()
{
    self.a_vh_ground = possessed_convoy_vehicle_spawn();
    self.a_vh_convoy = arraycombine( self.a_vh_convoy, self.a_vh_ground );
    self.var_d5ed03421f78dd64 = self.a_vh_convoy.size;
    self.spawned_vehicles = self.a_vh_convoy;
    self.a_vh_ground = utility::array_sort_by_script_index( self.a_vh_ground );
    
    foreach ( convoy_vehicle in self.a_vh_ground )
    {
        convoy_vehicle thread function_9ce1e03040093ca9( self );
        convoy_vehicle thread ob_convoy_util::function_2159092914a60ce0();
        
        foreach ( rider in convoy_vehicle.riders )
        {
            rider.lastvehicle = convoy_vehicle;
        }
    }
    
    thread function_57bb4ee3aafa6aa5();
    ob_convoy_util::init_vehicle_callback();
    self.var_e814baa69305ee8a = ob_convoy_util::function_8ccf719b775fd5a0( self.a_vh_ground );
}

// Namespace ob_activity_possessed_convoy
// Params 2
// Checksum 0x702939a6, Offset: 0x1c1a
// Size: 0x5b9
function possessed_convoy_vehicle_spawn( var_1ebf041fca0a7187, vehicle_ref_override )
{
    vehiclearray = [];
    spawndata = spawnstruct();
    spawndata.angles = self.nd_spline_start.angles;
    spawndata.team = self.ai_team;
    spawndata.initai = 1;
    spawndata vehicle_spawn::prevent_respawn();
    spawndata.var_499a16b493ff31ed = 1;
    spawndata.triggerrecycle = 1;
    offsetdirection = vectornormalize( anglestoforward( self.nd_spline_start.angles ) * ( 1, 1, 0 ) );
    offsetstep = 640;
    self.convoydata = [];
    
    for ( index = 0; index < self.var_7d7a32be78c7fc98.size ; index++ )
    {
        var_77c8c5497c88f2e4 = randomfloatrange( 10, 35 );
        var_1b299177a948cca7 = offsetstep + var_77c8c5497c88f2e4;
        spawndata.origin = self.nd_spline_start.origin - offsetdirection * index * var_1b299177a948cca7 + ( 0, 0, 100 );
        vehicle = undefined;
        self.convoydata[ index ] = spawnstruct();
        vehicle = vehicle::spawn( self.var_7d7a32be78c7fc98[ index ].vehicleref, spawndata );
        assert( vehicle, "<dev string:xf0>" );
        var_b3585af3ed752977 = getdvarfloat( @"hash_b28aec22f9245ae7", 1.43 );
        vehicle forcenetfieldhighlod( 1 );
        vehicle.riders = [];
        vehicle.unloadque = [];
        vehicle.unload_group = "all";
        vehicle.maxhealth *= var_b3585af3ed752977;
        vehicle.health = vehicle.maxhealth;
        vehicle utility::ent_flag_init( "armored_convoy_spawned" );
        vehicle vehicle_aianim::handle_attached_guys();
        turrets = vehicle::get_turrets( vehicle );
        
        if ( turrets.size > 0 )
        {
            turretkey = getarraykey( turrets, 0 );
            vehicle.mgturret = [];
            vehicle.mgturret[ 0 ] = turrets[ turretkey ];
            vehicle turret::function_2e0a246d12d5e047( &function_d327ab4c0ad1af1 );
            vehicle turret::function_40a195262f7f99ab( 1, level.teamnamelist );
            vehicle.var_8d709d1797b48f07 = 1;
        }
        
        possessed_convoy_spawn_riders( self, self.convoydata[ index ], spawndata.origin, index, vehicle );
        assert( self.convoydata[ index ].var_20b91e17abb8a3a8.size > 0, "<dev string:x10f>" );
        vehicledata = vehicle::get_data( self.var_7d7a32be78c7fc98[ index ].vehicleref );
        
        if ( self.convoydata[ index ].var_20b91e17abb8a3a8.size > vehicledata.aiseats.size )
        {
            errormsg = "Error - AI encounter " + self.var_7d7a32be78c7fc98[ index ].riderencounter;
            errormsg = errormsg + " spawned " + self.convoydata[ index ].var_20b91e17abb8a3a8.size;
            errormsg = errormsg + " riders, but vehicle " + self.var_7d7a32be78c7fc98[ index ].vehicleref;
            errormsg = errormsg + " has only " + vehicledata.aiseats.size + " seats!";
            assertmsg( errormsg );
        }
        
        vehicle.script_index = index;
        vehicle.var_3a92d7abfab8b5d9 = 0;
        vehicle.var_1f9d76cca64c48f6 = 1;
        
        if ( self.disablecaralarm )
        {
            vehicle.playedcaralarm = 1;
        }
        
        vehicle.var_a5f34fcc4fb8b328 = 0;
        vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
        function_3eba74df17ff1b63( vehicle, 0 );
        vehicle.var_ca0aadbba0844940 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_activity_possessed_convoy_vehicle_tac_map_marker", 0, 0 );
        objidpoolmanager::update_objective_onentity( vehicle.var_ca0aadbba0844940, vehicle );
        objidpoolmanager::update_objective_setzoffset( vehicle.var_ca0aadbba0844940, 200 );
        setup_hovercard( vehicle.var_ca0aadbba0844940 );
        vehicle.vehicle_marker_objid = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_activity_possessed_convoy_vehicle_marker", 0, 1 );
        objidpoolmanager::update_objective_onentity( vehicle.vehicle_marker_objid, vehicle );
        objidpoolmanager::update_objective_setzoffset( vehicle.vehicle_marker_objid, 200 );
        objective_showtoplayersinmask( vehicle.vehicle_marker_objid );
        objective_removeallfrommask( vehicle.vehicle_marker_objid );
        playfxontag( utility::getfx( "vfx_possessed_convoy_vehicle_smoke" ), vehicle, "tag_attach" );
        vehicle setscriptablepartstate( #"single", #"vehicle_unusable_pingable" );
        vehicle function_dcec66d7b085ac29();
        vehicle.attractor = zombie_attractor_manager::add_attractor( vehicle, 4, 2000, 0, undefined, &function_b9bad04b80b67f19 );
        vehicle.attractor.ownervehicle = vehicle;
        vehicle.attractor.skipteamcheck = 1;
        vehicle thread function_55953ac4e7f96bc8( self );
        vehicle thread possessed_convoy_vehicle_death_watcher( self );
        vehicle thread function_8a47a3111e9ff27a( self );
        vehicle thread function_151f845316f5e109( self );
        thread activity_participation::function_d041ee0ec570299d( vehicle );
        vehiclearray[ vehiclearray.size ] = vehicle;
        waitframe();
    }
    
    return vehiclearray;
}

// Namespace ob_activity_possessed_convoy
// Params 3
// Checksum 0xb4f7e467, Offset: 0x21dc
// Size: 0x1bd
function function_dcec66d7b085ac29( var_3c09ff595c6166a9 = 1, addpath = 1, var_d2b2b98d77c9c0 = 0 )
{
    if ( var_3c09ff595c6166a9 )
    {
        if ( !self hascomponent( "p2p" ) )
        {
            self addcomponent( "p2p" );
        }
    }
    
    if ( addpath )
    {
        if ( !self hascomponent( "path" ) )
        {
            self addcomponent( "path" );
        }
    }
    
    if ( var_d2b2b98d77c9c0 )
    {
        if ( !self hascomponent( "animator" ) )
        {
            self addcomponent( "animator" );
        }
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self function_eb88c4e66edbc855( "p2p", "checkStuck", 0 );
        self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
        self function_eb88c4e66edbc855( "p2p", "automaticNormal", 1 );
        self function_eb88c4e66edbc855( "p2p", "brakeOnGoalGasbrake", 1 );
        self function_eb88c4e66edbc855( "p2p", "goalPoint", self.origin );
        self function_eb88c4e66edbc855( "p2p", "goalThreshold", 200 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedThreshold", 1 );
        self function_eb88c4e66edbc855( "p2p", "automaticFastTopspeedFraction", 1 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 2 );
        self function_eb88c4e66edbc855( "p2p", "gasToStopMovement", 0.9 );
        self function_eb88c4e66edbc855( "p2p", "steeringMultiplier", 2 );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self function_eb88c4e66edbc855( "path", "radiusToStep", 300 );
    }
    
    self.dontunloadonend = 1;
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x8a203308, Offset: 0x23a1
// Size: 0x50, Type: bool
function private function_d327ab4c0ad1af1( target, turretindex )
{
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( target.notarget )
    {
        return false;
    }
    
    if ( target.inlaststand )
    {
        return false;
    }
    
    if ( target supers_mp::function_60dbd7e2f1b02c22() )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xbc262a9d, Offset: 0x23fa
// Size: 0x62d
function private function_57bb4ee3aafa6aa5()
{
    self notify( #"hash_7757e429b76edc18" );
    self endon( #"hash_7757e429b76edc18" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"under_attack" );
    self endon( #"unloaded" );
    assert( self.a_vh_convoy );
    assert( self.a_vh_ground );
    assert( self.n_veh_speed );
    thread function_6cc16cd7159dc72();
    
    while ( self.a_vh_ground.size > 1 )
    {
        self.a_vh_convoy = function_46f9072493651dc9( self.a_vh_convoy );
        self.a_vh_ground = function_46f9072493651dc9( self.a_vh_ground );
        convoyvehicles = self.a_vh_ground;
        
        if ( self.var_e814baa69305ee8a.traffic_paused )
        {
            waitframe();
            continue;
        }
        
        /#
            drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
            
            if ( drawdebug )
            {
                for ( index = 0; index < convoyvehicles.size ; index++ )
                {
                    print3d( convoyvehicles[ index ].origin, "<dev string:x124>" + convoyvehicles[ index ].veh_speed + "<dev string:x125>" + self.n_veh_speed, ( 1, 1, 1 ), 1, 1, 1, 1 );
                }
            }
        #/
        
        var_4adbd49fa8ee3cb5 = convoyvehicles[ 0 ].var_c533293b01e34038 < 2250000;
        
        if ( self.n_veh_speed == 0 || convoyvehicles[ 0 ].veh_speed < self.n_veh_speed * 0.8 || var_4adbd49fa8ee3cb5 )
        {
            if ( var_4adbd49fa8ee3cb5 )
            {
                for ( index = 0; index < convoyvehicles.size ; index++ )
                {
                    if ( convoyvehicles[ index ].p2p_speed > self.n_veh_speed )
                    {
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( self.n_veh_speed ) );
                        convoyvehicles[ index ].p2p_speed = self.n_veh_speed;
                    }
                }
            }
            
            waitframe();
            continue;
        }
        
        offsetpositions = [];
        offsetdistance = 640;
        projectedpositions = [];
        
        for ( index = 0; index < convoyvehicles.size ; index++ )
        {
            if ( index > 0 )
            {
                leadorigin = convoyvehicles[ index - 1 ].origin;
                leadforward = vectornormalize( anglestoforward( convoyvehicles[ index - 1 ].angles * ( 0, 1, 0 ) ) );
                offsetpositions[ offsetpositions.size ] = leadorigin - leadforward * offsetdistance;
                vehicledirection = convoyvehicles[ index ].origin - leadorigin;
                var_45f4531f94229ec5 = vectordot2( vehicledirection, leadforward, 0 );
                projectedpositions[ projectedpositions.size ] = leadorigin + leadforward * var_45f4531f94229ec5;
                continue;
            }
            
            offsetpositions[ offsetpositions.size ] = convoyvehicles[ index ].origin;
            projectedpositions[ projectedpositions.size ] = convoyvehicles[ index ].origin;
        }
        
        if ( offsetpositions.size > 1 )
        {
            /#
                drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                
                if ( drawdebug )
                {
                    for ( index = 1; index < offsetpositions.size ; index++ )
                    {
                        color = ( 1, 0.5, 0.1 );
                        line( convoyvehicles[ index - 1 ].origin, offsetpositions[ index ], color, 1, 0, 1 );
                        sphere( offsetpositions[ index ], 10, color, 0, 1 );
                    }
                }
            #/
            
            for ( index = 1; index < projectedpositions.size ; index++ )
            {
                if ( convoyvehicles[ index ].var_d92971aa060653fd )
                {
                    continue;
                }
                
                leadforward = vectornormalize( anglestoforward( convoyvehicles[ index - 1 ].angles * ( 0, 1, 0 ) ) );
                var_986b7951e7bc00e1 = vectornormalize( projectedpositions[ index ] - offsetpositions[ index ] );
                var_415e27a7dd8fa602 = vectordot2( var_986b7951e7bc00e1, leadforward, 0 );
                vehicleforward = vectornormalize( anglestoforward( convoyvehicles[ index ].angles * ( 0, 1, 0 ) ) );
                var_505aba861041d728 = vectordot2( vehicleforward, leadforward, 0 );
                
                if ( var_505aba861041d728 > 0 )
                {
                    if ( var_415e27a7dd8fa602 > cos( 45 ) )
                    {
                        newspeed = self.n_veh_speed * 0.9;
                        
                        if ( index > 1 && convoyvehicles[ index - 1 ].p2p_speed )
                        {
                            newspeed = convoyvehicles[ index - 1 ].p2p_speed * 0.9;
                        }
                        
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( newspeed ) );
                        convoyvehicles[ index ].p2p_speed = newspeed;
                    }
                    else if ( !var_4adbd49fa8ee3cb5 )
                    {
                        newspeed = self.n_veh_speed * 1.1;
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( newspeed ) );
                        convoyvehicles[ index ].p2p_speed = newspeed;
                    }
                }
                else if ( !var_4adbd49fa8ee3cb5 )
                {
                    var_a5c3db95671ed9af = distance2dsquared( convoyvehicles[ index - 1 ].origin, convoyvehicles[ index ].origin );
                    
                    if ( var_a5c3db95671ed9af > 1000000 )
                    {
                        newspeed = self.n_veh_speed * 1.1;
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( newspeed ) );
                        convoyvehicles[ index ].p2p_speed = newspeed;
                    }
                }
                
                /#
                    drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                    
                    if ( drawdebug )
                    {
                        color = ( 1, 0.75, 0.8 );
                        
                        if ( var_415e27a7dd8fa602 > cos( 45 ) )
                        {
                            color = ( 0, 1, 0 );
                        }
                        
                        line( projectedpositions[ index ], convoyvehicles[ index ].origin, color, 1, 0, 1 );
                        
                        if ( var_505aba861041d728 > 0 )
                        {
                            sphere( projectedpositions[ index ], 8, color, 0, 1 );
                        }
                    }
                #/
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_possessed_convoy
// Params 2
// Checksum 0xdb23b835, Offset: 0x2a2f
// Size: 0x53
function function_3eba74df17ff1b63( vehicle, var_bed9b53b2f85501d )
{
    instancedataforvehicle = vehicle_interact::get_instance_data( vehicle, undefined, 1 );
    
    if ( !instancedataforvehicle )
    {
        return;
    }
    
    if ( var_bed9b53b2f85501d )
    {
        if ( instancedataforvehicle.disabledbyallow <= 0 )
        {
            return;
        }
    }
    
    vehicle_interact::allow_use( vehicle, var_bed9b53b2f85501d );
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x4dbd739, Offset: 0x2a8a
// Size: 0x36
function private setup_hovercard( objidnum )
{
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hash_21da4a0171c69d1" );
    function_3f1a6a0ae5901866( objidnum, hovercardid );
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x929729c4, Offset: 0x2ac8
// Size: 0x1e5
function function_55953ac4e7f96bc8( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"leavepath_unload" );
    n_distance = 16000000;
    
    if ( !isdefined( activityinstance.var_35f3ffa518fd410e ) )
    {
        activityinstance.var_35f3ffa518fd410e = 0;
    }
    
    while ( true )
    {
        if ( self.isdestroyed )
        {
            return;
        }
        
        self waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        
        if ( isplayer( attackerplayer ) )
        {
            activityinstance function_52488353fe53e7b8( attackerplayer );
        }
        
        if ( isplayer( attacker ) && distancesquared( self.origin, attacker.origin ) <= n_distance && !activityinstance.var_35f3ffa518fd410e )
        {
            activityinstance notify( #"under_attack" );
            activityinstance.var_35f3ffa518fd410e = 1;
            function_89d3ca1269040368( activityinstance, 0, attacker );
        }
        
        if ( self.health < self.maxhealth * 0.5 )
        {
            self notify( #"damage_heavy" );
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x1103c95a, Offset: 0x2cb5
// Size: 0x11a
function function_151f845316f5e109( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"leavepath_unload" );
    
    while ( true )
    {
        if ( self.isdestroyed )
        {
            return;
        }
        
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent, collzone );
        
        if ( ent.streakinfo && ent.streakinfo.streakname == "remote_turret" )
        {
            ent dodamage( ent.maxhealth, ent.origin, self, self, "MOD_CRUSH" );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_possessed_convoy
// Params 3
// Checksum 0x8762491c, Offset: 0x2dd7
// Size: 0x33
function function_89d3ca1269040368( activity_instance, var_7e84a1b2d6501f11, attacker )
{
    activity_instance ob_activity_utility::function_894ac80e038636c5( "wcaconvoyfight", [ attacker ] );
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xc591e470, Offset: 0x2e12
// Size: 0x243
function possessed_convoy_vehicle_death_watcher( activityinstance )
{
    self endon( #"entitydeleted" );
    self waittill( #"death" );
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.vehicle_marker_objid );
    self.vehicle_marker_objid = undefined;
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_ca0aadbba0844940 );
    self.var_ca0aadbba0844940 = undefined;
    earthquake( 0.5, 1, self.origin, 1500 );
    stopfxontag( utility::getfx( "vfx_possessed_convoy_vehicle_smoke" ), self, "tag_origin" );
    
    if ( activity_instance_common::getactivitystate( activityinstance ) == "Active" )
    {
        activityinstance notify( #"vfx_move_stop" );
        function_64ac8c4e752f4dca( self.var_7cb62ed461d8c370, 1 );
        activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_7cb62ed461d8c370 );
        activityinstance.a_vh_ground = arrayremove( activityinstance.a_vh_ground, self );
        
        if ( activityinstance.a_vh_ground.size == 0 )
        {
            angle = randomfloat( 360 );
            boss_spawn_origin = ( self.origin[ 0 ] + 500 * cos( angle ), self.origin[ 1 ] + 500 * sin( angle ), self.origin[ 2 ] );
            boss_spawn_origin = getclosestpointonnavmesh( boss_spawn_origin );
            activityinstance.boss_spawn_origin = boss_spawn_origin;
            activityinstance notify( #"all_vehicle_destroyed", boss_spawn_origin );
        }
        
        progress = activityinstance.var_7d7a32be78c7fc98.size - activityinstance.a_vh_ground.size;
        progress = max( 0, progress );
        activity_definition_utils::updateprogress( progress, activityinstance );
        var_4b47655c33f51e24 = spawn( "script_model", self.origin + ( 0, 0, 100 ) );
        var_4b47655c33f51e24 setmodel( "tag_origin" );
        playfxontag( utility::getfx( "vfx_possessed_convoy_vehicle_destroyed" ), var_4b47655c33f51e24, "tag_origin" );
        
        if ( !isdefined( activityinstance.var_504cde334f2cc087 ) )
        {
            activityinstance.var_504cde334f2cc087 = [];
        }
        
        activityinstance.var_504cde334f2cc087[ activityinstance.var_504cde334f2cc087.size ] = var_4b47655c33f51e24;
        activityinstance function_d7ac5ab3846e73fa();
        activityinstance thread function_e7a6e3115fd5d2ca( var_4b47655c33f51e24 );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x11313c6d, Offset: 0x305d
// Size: 0x265
function function_e7a6e3115fd5d2ca( var_4b47655c33f51e24 )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_4b47655c33f51e24 endon( #"death" );
    var_4b47655c33f51e24 endon( #"entitydeleted" );
    var_4b47655c33f51e24 moveto( var_4b47655c33f51e24.origin + ( 0, 0, 100 ), 0.5 );
    wait 0.5;
    playfxontag( utility::getfx( "vfx_possessed_convoy_core" ), var_4b47655c33f51e24, "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_core_trail" ), var_4b47655c33f51e24, "tag_origin" );
    wait 0.5;
    stopfxontag( utility::getfx( "vfx_possessed_convoy_vehicle_destroyed" ), var_4b47655c33f51e24, "tag_origin" );
    is_last_vehicle = 0;
    
    if ( self.a_vh_ground.size == 0 )
    {
        is_last_vehicle = 1;
    }
    
    while ( true )
    {
        closest_point = self.boss_spawn_origin;
        target_ent = undefined;
        
        foreach ( vehicle in self.a_vh_ground )
        {
            if ( !closest_point || distance2dsquared( var_4b47655c33f51e24.origin, vehicle.origin ) < distance2dsquared( var_4b47655c33f51e24.origin, closest_point ) )
            {
                target_ent = vehicle;
                closest_point = vehicle.origin;
            }
        }
        
        if ( !closest_point )
        {
            assert( closest_point, "<dev string:x127>" );
            return;
        }
        
        movetime = self.vfx_move_time;
        
        if ( is_last_vehicle )
        {
            movetime -= 1;
        }
        
        thread function_6c658cbe87d25d30( var_4b47655c33f51e24, var_4b47655c33f51e24.origin, closest_point, target_ent, movetime );
        results = utility::waittill_any_ents_return_params( self, "vfx_move_stop", var_4b47655c33f51e24, "vfx_move_finished" );
        
        if ( results[ "message" ] == "vfx_move_finished" )
        {
            break;
        }
    }
    
    wait 2;
    stopfxontag( utility::getfx( "vfx_possessed_convoy_core_impact" ), var_4b47655c33f51e24, "tag_origin" );
    self.var_504cde334f2cc087 = arrayremove( self.var_504cde334f2cc087, var_4b47655c33f51e24 );
    var_4b47655c33f51e24 delete();
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0x9e6049a0, Offset: 0x32ca
// Size: 0x180
function function_d7ac5ab3846e73fa()
{
    longest_time = 0;
    
    foreach ( var_4b47655c33f51e24 in self.var_504cde334f2cc087 )
    {
        closest_point = self.boss_spawn_origin;
        
        foreach ( vehicle in self.a_vh_ground )
        {
            if ( !closest_point || distance2dsquared( var_4b47655c33f51e24.origin, vehicle.origin ) < distance2dsquared( var_4b47655c33f51e24.origin, closest_point ) )
            {
                closest_point = vehicle.origin;
            }
        }
        
        move_time = distance2d( closest_point, var_4b47655c33f51e24.origin ) / 1000;
        
        if ( move_time > longest_time )
        {
            longest_time = move_time;
        }
    }
    
    longest_time = max( 2, longest_time );
    self.vfx_move_time = longest_time;
}

// Namespace ob_activity_possessed_convoy
// Params 5
// Checksum 0x838817bc, Offset: 0x3452
// Size: 0x280
function function_6c658cbe87d25d30( var_4b47655c33f51e24, start_pos, end_pos, target_ent, duration )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"vfx_move_stop" );
    var_4b47655c33f51e24 endon( #"death" );
    var_4b47655c33f51e24 endon( #"entitydeleted" );
    var_5101094910e8d1bf = vectornormalize( anglestoleft( vectortoangles( end_pos - start_pos ) ) );
    curve_horizontal_offset = var_5101094910e8d1bf * 150 * randomfloatrange( -1, 1 );
    curve_vertical_offset = ( 0, 0, randomint( 50 ) * 2 + 50 );
    control_pos = ( start_pos + end_pos ) / 2 + curve_horizontal_offset + curve_vertical_offset;
    should_debug = 0;
    
    /#
        should_debug = function_a5cd5a36ccebe58( "<dev string:x142>", 0 );
        
        if ( should_debug )
        {
            sphere( control_pos, 15, ( 1, 0, 0 ), 0, int( duration * 10 / level.framedurationseconds ) );
        }
    #/
    
    start_point = start_pos;
    control_point = control_pos;
    end_point = end_pos;
    t = 0;
    move_start = gettime();
    
    while ( true )
    {
        if ( target_ent )
        {
            end_point = target_ent.origin + ( 0, 0, 80 );
        }
        
        t = ( gettime() - move_start ) / 1000 / duration;
        
        if ( t < 1 )
        {
            position = utility::get_bezier_position( t, start_point, end_point, control_point );
            move_dir = position - var_4b47655c33f51e24.origin;
            
            if ( lengthsquared( move_dir ) > 1 )
            {
                var_4b47655c33f51e24 rotateto( vectortoangles( move_dir ), level.framedurationseconds );
            }
            
            var_4b47655c33f51e24 moveto( position, level.framedurationseconds );
            var_4b47655c33f51e24 waittill( #"movedone" );
            continue;
        }
        
        var_4b47655c33f51e24 moveto( end_point, level.framedurationseconds );
        var_4b47655c33f51e24 waittill( #"movedone" );
        break;
    }
    
    stopfxontag( utility::getfx( "vfx_possessed_convoy_core" ), var_4b47655c33f51e24, "tag_origin" );
    stopfxontag( utility::getfx( "vfx_possessed_convoy_core_trail" ), var_4b47655c33f51e24, "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_core_impact" ), var_4b47655c33f51e24, "tag_origin" );
    var_4b47655c33f51e24 notify( #"vfx_move_finished" );
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xa73fad60, Offset: 0x36da
// Size: 0xbf
function function_8a47a3111e9ff27a( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"vehicle_unloaded" );
    
    while ( !self.driver )
    {
        /#
            iprintln( "<dev string:x14c>" );
        #/
        
        waitframe();
    }
    
    msg = utility::waittill_any_ents_return( self.driver, "death", self, "damage_heavy" );
    self notify( #"leavepath_unload" );
    thread function_b81a8841894e0b37( activityinstance );
    activityinstance.a_vh_convoy = arrayremove( activityinstance.a_vh_convoy, self );
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x9f13356f, Offset: 0x37a1
// Size: 0x22d
function function_b81a8841894e0b37( activityinstance )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    crash_speed = 35;
    var_b363a8cdd38c8d76 = 768;
    
    /#
        iprintln( "<dev string:x166>" );
    #/
    
    var_8c8c13c3c3a794e1 = randomfloatrange( 25, 35 );
    var_21de78005a63c185 = utility::cointoss() ? -1 * var_8c8c13c3c3a794e1 : var_8c8c13c3c3a794e1;
    var_287dd1eda5e53859 = ( var_b363a8cdd38c8d76, 0, 0 );
    var_bfa40987498bbd16 = self.angles + ( 0, var_21de78005a63c185, 0 );
    var_84fbfb33b1b6b884 = self.origin + rotatevector( var_287dd1eda5e53859, var_bfa40987498bbd16 );
    var_84fbfb33b1b6b884 = getgroundposition( var_84fbfb33b1b6b884, 128 );
    self notify( #"path_updated" );
    self stoppath();
    self removecomponent( "path" );
    activityinstance.var_e814baa69305ee8a.vehicles = arrayremove( activityinstance.var_e814baa69305ee8a.vehicles, self );
    waitframe();
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 2 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 8 );
    self function_eb88c4e66edbc855( "p2p", "automaticFast", 1 );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( crash_speed ) );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", var_84fbfb33b1b6b884 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 50 );
    self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
    utility::waittill_any_timeout( 5, "goal", "near_goal", "path_blocked" );
    self removecomponent( "p2p" );
    function_3e16b2c5db9ffdc();
    waitframe();
    
    if ( self.riders.size )
    {
        thread function_7038cd5e6c37cf57();
        self endon( #"death" );
        utility::waittill_notify_or_timeout( "unloaded", 8 );
        ob_convoy_util::ob_spawn_cover_nodes();
        thread ob_convoy_util::function_8d8088d29dcb67a2();
    }
    
    self.var_a5f34fcc4fb8b328 = 1;
    self notify( #"vehicle_unloaded" );
    function_6b8c8c5465a95f28( activityinstance );
    self vehicleclearanims();
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x5e63dd6d, Offset: 0x39d6
// Size: 0xae
function function_9ce1e03040093ca9( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    var_6faf532ba54370ae = activityinstance.nd_spline_start;
    nodeindex = getvehiclenodeindex( var_6faf532ba54370ae.targetname, #targetname );
    waitframe();
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( activityinstance.n_veh_speed ) );
    self function_eb88c4e66edbc855( "path", "radiantId", nodeindex );
    thread function_41ea77e8bc3ef9db( var_6faf532ba54370ae );
    self vehicle_turnengineon();
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xd5d86589, Offset: 0x3a8c
// Size: 0x127
function function_41ea77e8bc3ef9db( node )
{
    assert( node || self.attachedpath, "<dev string:x179>" );
    self notify( #"newpath" );
    
    if ( node )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !pathstart )
    {
        return;
    }
    
    self endon( #"newpath" );
    self endon( #"death" );
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = vehicle_paths::get_path_getfunc( pathstart );
    dist_sq = 40000;
    
    while ( nextpoint )
    {
        if ( !isstruct( nextpoint ) )
        {
            vehicle_paths::node_wait( nextpoint, lastpoint, get_func );
        }
        else
        {
            vehicle_paths::struct_wait( nextpoint, lastpoint, dist_sq );
        }
        
        vehicle_paths::trigger_process_node( nextpoint );
        self.currentnode = nextpoint;
        lastpoint = nextpoint;
        nextpoint = get_nextpoint( get_func, nextpoint );
        
        if ( !nextpoint )
        {
            nextpoint = lastpoint;
            break;
        }
    }
    
    self notify( #"reached_dynamic_path_end" );
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x39822010, Offset: 0x3bbb
// Size: 0x89
function private get_nextpoint( get_func, point )
{
    if ( isstring( self.veh_pathdir ) && self.veh_pathdir == "reverse" )
    {
        return point.prevpoint;
    }
    else if ( !point.target )
    {
        return;
    }
    
    next_point = [[ get_func ]]( point );
    
    if ( !next_point )
    {
        assertmsg( "<dev string:x19e>" + point.origin );
    }
    
    return next_point;
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x39fef5c5, Offset: 0x3c4d
// Size: 0x24f
function private function_6cc16cd7159dc72()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"reached_path_end" );
    wait 5;
    
    while ( self.a_vh_convoy.size > 0 )
    {
        if ( self.var_e814baa69305ee8a.traffic_paused )
        {
            wait 0.1;
            continue;
        }
        
        foreach ( vehicle in self.a_vh_convoy )
        {
            if ( vehicle )
            {
                if ( !vehicle.lastposition )
                {
                    vehicle.lastposition = vehicle.origin;
                    vehicle.stucktime = 0;
                    continue;
                }
                
                var_4a9cacebf4290aee = vehicle.lastposition - vehicle.origin;
                difference = length2d( var_4a9cacebf4290aee );
                
                if ( difference < 15 )
                {
                    vehicle.stucktime += 0.1;
                    
                    /#
                        sphere( vehicle.origin, 50, ( 1, 0, 0 ), 0, 100 );
                    #/
                }
                else
                {
                    vehicle.stucktime = 0;
                    vehicle.lastposition = vehicle.origin;
                }
                
                /#
                    drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                    
                    if ( drawdebug && vehicle.stucktime > 0 )
                    {
                        print3d( vehicle getcentroid() + ( 0, 0, 100 ), string( vehicle.stucktime ), ( 1, 1, 0 ), 1, 1, 1, 0 );
                    }
                #/
                
                if ( vehicle.stucktime > 2 )
                {
                    vehicle thread function_184d46820753ddf( self );
                    self.a_vh_convoy = arrayremove( self.a_vh_convoy, vehicle );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x2e9c4bc9, Offset: 0x3ea4
// Size: 0x162
function private function_184d46820753ddf( activityinstance )
{
    crash_speed = self vehicle_getspeed();
    var_b363a8cdd38c8d76 = randomfloatrange( 150, 225 );
    var_8c8c13c3c3a794e1 = randomfloatrange( 15, 30 );
    var_21de78005a63c185 = utility::cointoss() ? -1 * var_8c8c13c3c3a794e1 : var_8c8c13c3c3a794e1;
    var_287dd1eda5e53859 = ( var_b363a8cdd38c8d76, 0, 0 );
    var_bfa40987498bbd16 = self.angles + ( 0, var_21de78005a63c185, 0 );
    var_84fbfb33b1b6b884 = self.origin + rotatevector( var_287dd1eda5e53859, var_bfa40987498bbd16 );
    var_84fbfb33b1b6b884 = getgroundposition( var_84fbfb33b1b6b884, 128 );
    self notify( #"path_updated" );
    self stoppath();
    self removecomponent( "path" );
    waitframe();
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( crash_speed ) );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", var_84fbfb33b1b6b884 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 50 );
    self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
    utility::waittill_any_timeout( 2, "goal", "near_goal", "path_blocked" );
    function_f18c679d55f1971d( activityinstance );
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xa2a939e9, Offset: 0x400e
// Size: 0x13d
function private function_f18c679d55f1971d( activityinstance )
{
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( 0 ) );
    self vehicle_setspeedimmediate( 0, 1, 1 );
    self vehicle_cleardrivingstate();
    
    if ( self hascomponent( "p2p" ) )
    {
        self removecomponent( "p2p" );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self removecomponent( "path" );
    }
    
    if ( self hascomponent( "animator" ) )
    {
        self removecomponent( "animator" );
    }
    
    self vehphys_parkingbrake( 1 );
    
    if ( activityinstance.var_e814baa69305ee8a )
    {
        activityinstance.var_e814baa69305ee8a.vehicles = arrayremove( activityinstance.var_e814baa69305ee8a.vehicles, self );
    }
    
    waitframe();
    function_3e16b2c5db9ffdc();
    
    if ( self.riders.size )
    {
        thread function_7038cd5e6c37cf57();
        self endon( #"death" );
        utility::waittill_notify_or_timeout( "unloaded", 8 );
        ob_convoy_util::ob_spawn_cover_nodes();
        thread ob_convoy_util::function_8d8088d29dcb67a2();
    }
    
    self.var_1f9d76cca64c48f6 = undefined;
    self.var_a5f34fcc4fb8b328 = 1;
    self notify( #"vehicle_unloaded" );
    function_6b8c8c5465a95f28( activityinstance );
    self vehicleclearanims();
    self vehphys_parkingbrake( 0 );
}

// Namespace ob_activity_possessed_convoy
// Params 5
// Checksum 0x4b622274, Offset: 0x4153
// Size: 0x1ef
function possessed_convoy_spawn_riders( activityinstance, convoydata, origin, vehicleindex, vehicle )
{
    assert( vehicleindex >= 0 && vehicleindex < activityinstance.var_7d7a32be78c7fc98.size, "<dev string:x1f2>" );
    convoydata.var_7cb62ed461d8c370 = activityinstance activity_ai_encounters::function_eb8506829193f5eb( activityinstance.var_7d7a32be78c7fc98[ vehicleindex ].riderencounter, origin, 128, 1, 1, 1, 2 );
    vehicle.var_7cb62ed461d8c370 = convoydata.var_7cb62ed461d8c370;
    function_c505198907e0d306( convoydata.var_7cb62ed461d8c370, vehicle );
    function_1a9d724a960fa19d( convoydata.var_7cb62ed461d8c370, "difficulty5", 1 );
    
    if ( !convoydata.var_c7c801fd0b2bf1ee )
    {
        convoydata.var_20b91e17abb8a3a8 = [];
    }
    
    if ( convoydata.var_7cb62ed461d8c370 )
    {
        activityinstance activity_ai_encounters::function_52d1342183200a8f( convoydata.var_7cb62ed461d8c370, &function_8939a62bb5e35a11, convoydata );
        function_64ac8c4e752f4dca( convoydata.var_7cb62ed461d8c370, 0 );
        activityinstance activity_ai_encounters::function_48582991402cac50( convoydata.var_7cb62ed461d8c370, 1 );
        ai_spawn_director::function_3ce5298df1143d67( "FinishedSpawningBucket", convoydata.var_7cb62ed461d8c370 );
        
        foreach ( agent in convoydata.var_20b91e17abb8a3a8 )
        {
            agent thread function_db7d1ff08f6dc559( activityinstance );
            activityinstance thread activity_participation::function_d041ee0ec570299d( agent );
            activityinstance.a_ai_convoy[ activityinstance.a_ai_convoy.size ] = agent;
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 4
// Checksum 0xf470ed27, Offset: 0x434a
// Size: 0x90
function function_8939a62bb5e35a11( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    
    if ( isalive( agent ) )
    {
        convoydata = userdata;
        agent.vehiclerunexit = 1;
        agent.var_437f238159c83b57 = 1;
        agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
        convoydata.var_20b91e17abb8a3a8[ convoydata.var_20b91e17abb8a3a8.size ] = agent;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x30b9d07c, Offset: 0x43e2
// Size: 0x38
function function_db7d1ff08f6dc559( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    childthread ai_death_watcher( activityinstance );
    childthread function_4934c05f6b2d609b( activityinstance );
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x9ac49272, Offset: 0x4422
// Size: 0x66
function ai_death_watcher( activityinstance )
{
    while ( true )
    {
        self waittill( #"death", attacker );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        
        if ( isplayer( attackerplayer ) )
        {
            activityinstance function_52488353fe53e7b8( attackerplayer );
        }
        
        break;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x54907e15, Offset: 0x4490
// Size: 0x6f
function function_4934c05f6b2d609b( activityinstance )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bulletwhizby", attacker );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        
        if ( isplayer( attackerplayer ) )
        {
            activityinstance function_52488353fe53e7b8( attackerplayer );
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0x20e58f55, Offset: 0x4507
// Size: 0x15b
function function_7038cd5e6c37cf57()
{
    foreach ( rider in self.riders )
    {
        if ( !utility::is_dead_or_dying( rider ) )
        {
            rider thread ob_activity_utility::function_798aace978e876b();
            turret = rider getturret();
            
            if ( turret )
            {
                if ( utility::flag( "stealth_enabled" ) && rider.stealth && rider.stealth_enabled )
                {
                    rider setstealthstate( "combat" );
                }
            }
            else
            {
                if ( !rider.vehicle_position && rider.script_startingposition )
                {
                    rider.vehicle_position = rider.script_startingposition;
                }
                
                if ( rider.vehicle_position )
                {
                    rider thread function_8257ae157ff3bbe9( self.origin );
                    thread vehicle_aianim::guy_unload( rider, rider.vehicle_position );
                }
            }
            
            n_wait = randomfloatrange( 0.2, 0.3 );
            wait n_wait;
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xd19502c3, Offset: 0x466a
// Size: 0x63
function function_8257ae157ff3bbe9( var_465b20e0d8be9bfd )
{
    self endon( #"death" );
    self waittill( #"unloaded" );
    
    if ( utility::flag( "stealth_enabled" ) && self.stealth && self.stealth_enabled )
    {
        self setstealthstate( "combat" );
    }
    
    self setgoalpos( var_465b20e0d8be9bfd, 750 );
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x1b0c4a26, Offset: 0x46d5
// Size: 0x7e
function private function_4787d393f31ccaf0()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        msg = utility::waittill_any_in_array_return( [ "under_attack", "ai_combat", "out_of_combat_30s" ] );
        
        if ( msg == "out_of_combat_30s" )
        {
            function_8dc57f5fcd654012( self.slowspeed );
            continue;
        }
        
        function_8dc57f5fcd654012( self.highspeed );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 2
// Checksum 0x8af5f506, Offset: 0x475b
// Size: 0x104
function function_8dc57f5fcd654012( speed, b_ground_only = 1 )
{
    if ( b_ground_only == 1 )
    {
        vehicles = self.a_vh_ground;
    }
    else
    {
        vehicles = self.a_vh_convoy;
    }
    
    foreach ( vehicle in vehicles )
    {
        self.n_veh_speed = speed;
        
        if ( !vehicle )
        {
            continue;
        }
        
        if ( vehicle hascomponent( "p2p" ) )
        {
            vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speed ) );
            vehicle.p2p_speed = speed;
            continue;
        }
        
        vehicle vehicle_setspeed( speed );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0x13f2cde3, Offset: 0x4867
// Size: 0x14d
function function_63eb981bb55153b7()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_ea5b7a595a1f4f3 = 0;
    
    while ( true )
    {
        var_daf2d1bb3db839f7 = 0;
        
        foreach ( ai in self.a_ai_convoy )
        {
            if ( isalive( ai ) && ai isincombat() )
            {
                var_daf2d1bb3db839f7 = 1;
                
                if ( !self.var_ea5b7a595a1f4f3 )
                {
                    self.var_ea5b7a595a1f4f3 = 1;
                    self.var_11e6443c6810c92e = undefined;
                    self notify( #"ai_combat" );
                }
                
                break;
            }
        }
        
        if ( !var_daf2d1bb3db839f7 && self.var_ea5b7a595a1f4f3 )
        {
            if ( !self.var_11e6443c6810c92e )
            {
                self.var_11e6443c6810c92e = gettime();
            }
            
            if ( gettime() - self.var_11e6443c6810c92e >= 30000 )
            {
                self.var_ea5b7a595a1f4f3 = 0;
                self notify( #"out_of_combat_30s" );
            }
        }
        
        wait 0.5;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0x4235103c, Offset: 0x49bc
// Size: 0x9e
function function_1bcd8f3bb0880b12()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    foreach ( convoy_vehicle in self.a_vh_ground )
    {
        convoy_vehicle thread function_cf674b664e62a61c( self );
        convoy_vehicle thread function_8a46f7e2300f3118( self );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xbddfa0f4, Offset: 0x4a62
// Size: 0xfd
function function_8a46f7e2300f3118( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    while ( true )
    {
        results = utility::waittill_any_ents_return_params( self, "death", self, "vehicle_unloaded", activityinstance, "out_of_combat_30s" );
        
        if ( results[ "message" ] == "death" )
        {
            if ( self.var_a38bf2dfb444a1ff )
            {
                activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_a38bf2dfb444a1ff.request_id );
                self.var_a38bf2dfb444a1ff = undefined;
            }
            
            if ( self.var_b5c479a3dc39429a )
            {
                activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_b5c479a3dc39429a.request_id );
                self.var_b5c479a3dc39429a = undefined;
            }
            
            return;
        }
        
        if ( self.var_a38bf2dfb444a1ff )
        {
            activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_a38bf2dfb444a1ff.request_id );
            self.var_a38bf2dfb444a1ff = undefined;
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x772cbd50, Offset: 0x4b67
// Size: 0x73
function function_cf674b664e62a61c( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"vehicle_unloaded" );
    
    while ( true )
    {
        msg = activityinstance utility::waittill_any_return( "ai_combat" );
        
        if ( msg == "ai_combat" )
        {
            thread function_8bd312228cbb0ee3( activityinstance );
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0xa868c155, Offset: 0x4be2
// Size: 0xde
function function_5835b62b323af208()
{
    pathstart = self.attachedpath;
    get_func = vehicle_paths::get_path_getfunc( pathstart );
    nextpoint = get_nextpoint( get_func, self.currentnode );
    
    if ( nextpoint )
    {
        nextpoint = get_nextpoint( get_func, nextpoint );
    }
    
    var_bc67b7b536fe0843 = self.angles;
    _origin = self.origin;
    
    if ( nextpoint )
    {
        _origin = nextpoint.origin;
        var_bc67b7b536fe0843 = nextpoint.angles;
    }
    
    offset = 200;
    
    if ( randomint( 2 ) == 0 )
    {
        offset = -200;
    }
    
    right = anglestoright( var_bc67b7b536fe0843 );
    spawn_origin = _origin + right * offset;
    spawn_origin = getclosestpointonnavmesh( spawn_origin );
    return spawn_origin;
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xfe224b1a, Offset: 0x4cc9
// Size: 0x199
function function_8bd312228cbb0ee3( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"vehicle_unloaded" );
    activityinstance endon( #"out_of_combat_30s" );
    
    while ( true )
    {
        hasencounter = 0;
        
        if ( self.var_a38bf2dfb444a1ff )
        {
            if ( distance2dsquared( self.origin, self.var_a38bf2dfb444a1ff.origin ) < 250000 )
            {
                hasencounter = 1;
            }
        }
        
        if ( !hasencounter )
        {
            _ai_encounter_struct = spawnstruct();
            spawn_origin = function_5835b62b323af208();
            _ai_encounter_struct.origin = spawn_origin;
            request_id = activityinstance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_possessed_convoy_flood", spawn_origin, 5, 1, 0, 1, 2 );
            ai_spawn_director::function_c99d360d62c49a9c( request_id, &function_1da4cd860cdb0fdd, [ self, _ai_encounter_struct ] );
            ai_spawn_director::function_53289c032f506bb1( request_id, &function_26b39e4eb75b8e00, [ self, _ai_encounter_struct ] );
            activityinstance activity_ai_encounters::function_52d1342183200a8f( request_id, &function_ff7016fc59e3b855, [ self, _ai_encounter_struct, activityinstance ] );
            function_64ac8c4e752f4dca( request_id, 1 );
            _ai_encounter_struct.request_id = request_id;
            
            if ( self.var_a38bf2dfb444a1ff )
            {
                activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_a38bf2dfb444a1ff.request_id );
                self.var_a38bf2dfb444a1ff = undefined;
            }
            
            self.var_a38bf2dfb444a1ff = _ai_encounter_struct;
        }
        
        wait 15;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0x64390a03, Offset: 0x4e6a
// Size: 0x1d2, Type: bool
function private function_1da4cd860cdb0fdd( requestid, userdata, agent, data )
{
    vehicle = userdata[ 0 ];
    _ai_encounter_struct = userdata[ 1 ];
    
    if ( !vehicle || vehicle.var_a5f34fcc4fb8b328 )
    {
        return false;
    }
    
    if ( distance2dsquared( vehicle.origin, _ai_encounter_struct.origin ) >= 4000000 )
    {
        return false;
    }
    
    currenttime = gettime();
    
    if ( !_ai_encounter_struct.lastspawntime || currenttime - _ai_encounter_struct.lastspawntime >= 15000 )
    {
        _ai_encounter_struct.lastspawntime = currenttime;
        var_4c6516944983d5d8 = function_da26e38f24f90f2f( requestid );
        _ai_encounter_struct.spawncount = 3 - var_4c6516944983d5d8;
        all_ai_array = getaiarrayinradius( _ai_encounter_struct.origin, 2500 );
        convoy_ai_array = [];
        
        foreach ( zombie in all_ai_array )
        {
            if ( zombie.ownervehicle )
            {
                convoy_ai_array[ convoy_ai_array.size ] = zombie;
            }
        }
        
        countlimit = 10 - convoy_ai_array.size;
        _ai_encounter_struct.spawncount = min( countlimit, _ai_encounter_struct.spawncount );
    }
    
    if ( _ai_encounter_struct.spawncount <= 0 )
    {
        return false;
    }
    
    _ai_encounter_struct.spawncount--;
    return true;
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0x3f515272, Offset: 0x5045
// Size: 0x83, Type: bool
function private function_26b39e4eb75b8e00( requestid, userdata, agent, data )
{
    vehicle = userdata[ 0 ];
    _ai_encounter_struct = userdata[ 1 ];
    
    if ( !vehicle )
    {
        return true;
    }
    
    if ( _ai_encounter_struct.lastspawntime && distance2dsquared( vehicle.origin, _ai_encounter_struct.origin ) >= 4000000 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0x3738b24, Offset: 0x50d1
// Size: 0xb7
function private function_ff7016fc59e3b855( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    vehicle = userdata[ 0 ];
    activityinstance = userdata[ 2 ];
    
    if ( isalive( agent ) )
    {
        agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
        agent.ownervehicle = vehicle;
        agent.spawntime = gettime();
        agent.var_437f238159c83b57 = 1;
        agent callback::add( #"on_ai_killed", &on_ai_killed, activityinstance );
        agent thread ai_damage_watcher( activityinstance );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x7f25b3c1, Offset: 0x5190
// Size: 0x5f
function private on_ai_killed( params, activityinstance )
{
    eattacker = params.eattacker;
    attackerplayer = isplayer( eattacker ) ? eattacker : eattacker.owner;
    
    if ( attackerplayer )
    {
        activityinstance function_52488353fe53e7b8( attackerplayer, 0 );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xcbd1732d, Offset: 0x51f7
// Size: 0x97
function private ai_damage_watcher( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        activityinstance function_52488353fe53e7b8( attackerplayer, 0 );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 2
// Checksum 0x699e4ecf, Offset: 0x5296
// Size: 0x187, Type: bool
function function_b9bad04b80b67f19( attractor, zombie )
{
    if ( zombie.var_bd22ba6c600a23a3 )
    {
        return false;
    }
    
    if ( zombie.enemy )
    {
        if ( !zombie.ownervehicle )
        {
            return false;
        }
        
        if ( zombie.ownervehicle.var_a5f34fcc4fb8b328 )
        {
            return false;
        }
        
        if ( distance2dsquared( zombie.enemy.origin, zombie.origin ) <= distance2dsquared( zombie.ownervehicle.origin, zombie.origin ) && distance2dsquared( zombie.enemy.origin, zombie.origin ) <= 640000 )
        {
            return false;
        }
    }
    
    if ( isalive( zombie ) && attractor )
    {
        if ( !zombie.forceattractor && zombie.ownervehicle == attractor.ownervehicle )
        {
            if ( gettime() - zombie.spawntime <= 15000 )
            {
                return true;
            }
            else if ( distance2dsquared( zombie.ownervehicle.origin, zombie.origin ) < 4000000 )
            {
                return true;
            }
        }
        else if ( zombie.ownervehicle && zombie.forceattractor == attractor )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_possessed_convoy
// Params 0
// Checksum 0x105ae6bc, Offset: 0x5426
// Size: 0xb8
function function_3e16b2c5db9ffdc()
{
    var_255232a5c5895cf6 = getaiarrayinradius( self.origin, 500 );
    
    foreach ( zombie in var_255232a5c5895cf6 )
    {
        if ( zombie.ownervehicle && !zombie.forceattractor )
        {
            zombie.forceattractor = self.attractor;
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x7c24f80f, Offset: 0x54e6
// Size: 0xaf
function function_6b8c8c5465a95f28( activityinstance )
{
    self.var_b5c479a3dc39429a = spawnstruct();
    request_id = activityinstance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_possessed_convoy_flood", self.origin, 200, 1, 0, 1, 2 );
    self.var_b5c479a3dc39429a.request_id = request_id;
    ai_spawn_director::function_c99d360d62c49a9c( request_id, &function_bd4347e30dedd5d2, [ self ] );
    ai_spawn_director::function_53289c032f506bb1( request_id, &function_478d32aea78a42fd, [ self ] );
    activityinstance activity_ai_encounters::function_52d1342183200a8f( request_id, &function_828f14a287e569ee, [ self, activityinstance ] );
    function_64ac8c4e752f4dca( request_id, 1 );
    thread function_e6393dba06ac1f12( activityinstance );
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0xca267a5a, Offset: 0x559d
// Size: 0x145, Type: bool
function private function_bd4347e30dedd5d2( requestid, userdata, agent, data )
{
    vehicle = userdata[ 0 ];
    _ai_encounter_struct = vehicle.var_b5c479a3dc39429a;
    
    if ( !vehicle )
    {
        return false;
    }
    
    if ( !_ai_encounter_struct.hasspawned )
    {
        _ai_encounter_struct.hasspawned = 1;
        all_ai_array = getaiarrayinradius( vehicle.origin, 2500 );
        convoy_ai_array = [];
        
        foreach ( zombie in all_ai_array )
        {
            if ( zombie.ownervehicle )
            {
                convoy_ai_array[ convoy_ai_array.size ] = zombie;
            }
        }
        
        _ai_encounter_struct.spawncount = 5 - convoy_ai_array.size;
    }
    
    if ( _ai_encounter_struct.spawncount <= 0 )
    {
        return false;
    }
    
    _ai_encounter_struct.spawncount--;
    return true;
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0x62ef5e35, Offset: 0x56eb
// Size: 0x40, Type: bool
function private function_478d32aea78a42fd( requestid, userdata, agent, data )
{
    vehicle = userdata[ 0 ];
    
    if ( !vehicle )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0xfb012618, Offset: 0x5734
// Size: 0xbe
function private function_828f14a287e569ee( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    vehicle = userdata[ 0 ];
    activityinstance = userdata[ 1 ];
    
    if ( isalive( agent ) )
    {
        agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
        agent.ownervehicle = vehicle;
        agent.forceattractor = vehicle.attractor;
        agent.var_437f238159c83b57 = 1;
        agent callback::add( #"on_ai_killed", &on_ai_killed, activityinstance );
        agent thread ai_damage_watcher( activityinstance );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x9bb972e5, Offset: 0x57fa
// Size: 0x64
function function_e6393dba06ac1f12( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    level waittill( "ai_encounter_despawning_" + self.var_b5c479a3dc39429a.request_id );
    self.var_b5c479a3dc39429a.hasspawned = 0;
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xeeaf9e72, Offset: 0x5866
// Size: 0x1e3
function possessed_convoy_spawn_boss( boss_spawn_origin )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_4b47655c33f51e24 = spawn( "script_model", boss_spawn_origin );
    var_4b47655c33f51e24 setmodel( "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_boss_spawn" ), var_4b47655c33f51e24, "tag_origin" );
    self.boss_spawn_vfx = var_4b47655c33f51e24;
    wait 2.8;
    request_id = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_possessed_convoy_boss", boss_spawn_origin, 1, 1, 0, 1, 0 );
    activity_ai_encounters::function_48582991402cac50( request_id, 1 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &boss_spawned_callback, self );
    function_64ac8c4e752f4dca( request_id, 0 );
    game_utility::questcircle_create( "Toxin_Bomb_Boss_Ob", boss_spawn_origin, 2000 );
    game_utility::questcircle_hidefromall();
    focused_players = activity_definition_utils::function_9a67de09579cf0a2();
    
    foreach ( player in focused_players )
    {
        game_utility::questcircle_showtoplayer( player );
    }
    
    spatialzonecontainer = spawnstruct();
    spatialzonecontainer.var_8339fb4f2d23dabf = spatial_zone_container::function_bf9b65032b29d653();
    spatialzonecontainer.activityinstance = self;
    spatial_zone_container::function_5252f95edcf9e32c( spatialzonecontainer, "boss_fight_zone", &boss_fight_zone_get_center, [ self ] );
    self.spatial_zone_struct = spatial_zone_container::function_847140d2863dfbf8( spatialzonecontainer, "boss_fight_zone", undefined, 2000, 1 );
    spatial_zone_container::function_3b687b8681411c9f( spatialzonecontainer, "boss_fight_zone", &possessed_convoy_boss_fight_zone );
    self.spatialzonecontainer = spatialzonecontainer;
    wait 5;
    self.boss_spawn_vfx delete();
    self.boss_spawn_vfx = undefined;
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xfc90c6ad, Offset: 0x5a51
// Size: 0x8e
function private function_bdd726d8cd503150()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"boss_killed" );
    self.boss endon( #"death" );
    
    while ( true )
    {
        game_utility::questcircle_move( self.boss.origin );
        objidpoolmanager::update_objective_position( self.objidnum, self.boss.origin + ( 0, 0, 200 ) );
        waitframe();
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x3648acd8, Offset: 0x5ae7
// Size: 0x64
function private boss_fight_zone_get_center( activityinstance )
{
    if ( activityinstance.boss )
    {
        activityinstance.boss_fight_zone_center = activityinstance.boss.origin;
    }
    
    if ( activityinstance.boss_fight_zone_center )
    {
        return activityinstance.boss_fight_zone_center;
    }
    
    return activityinstance.boss_spawn_origin;
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0x55fc80b1, Offset: 0x5b53
// Size: 0xaf
function possessed_convoy_boss_fight_zone( params )
{
    if ( !params.enteredzone )
    {
        params.player thread possessed_convoy_remove_player( self.activityinstance );
    }
    else
    {
        params.player notify( #"enter_boss_fight_zone" );
    }
    
    if ( self.activityinstance.var_946a5a954be1335b && self.activityinstance.var_946a5a954be1335b[ params.player getentitynumber() ] )
    {
        self.activityinstance.var_946a5a954be1335b[ params.player getentitynumber() ] = undefined;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1
// Checksum 0xb58b6f2, Offset: 0x5c0a
// Size: 0x4b
function possessed_convoy_remove_player( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death_or_disconnect" );
    self endon( #"enter_boss_fight_zone" );
    wait 2;
    activity_participation::function_61aa2b2879f2c0a2( activityinstance, self );
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0x31c43e6e, Offset: 0x5c5d
// Size: 0x474
function private boss_spawned_callback( requestid, userdata, agent, data )
{
    activity_instance = userdata;
    agent._blackboard.var_b213ded5043dfa2b = agent.origin;
    agent._blackboard.var_8d11b98561e1eb81 = 100;
    agent._blackboard.var_8d34ab856208146f = 400;
    agent.suppress_minimap_icon = 1;
    agent.spawn_point = agent.origin;
    agent.var_a13bed1ac47e1b2c = 1;
    agent.disable_spawn_vfx = 1;
    agent.var_397efe49c831b963 = 1;
    agent.disallow_knockdown = 1;
    agent.var_437f238159c83b57 = 1;
    agent.ignore_perk_reduce_explosion_damage = 1;
    agent utility::ent_flag_set( "callisto_charge_disable_ledge_drop" );
    agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
    agent callback::add( #"on_ai_killed", &on_boss_killed, activity_instance );
    agent thread boss_damage_watcher( activity_instance );
    activity_instance.boss = agent;
    
    if ( !isdefined( activity_instance.var_e45112c70c3b2a70 ) )
    {
        activity_instance.var_e45112c70c3b2a70 = { #radius:3000, #origin:agent.origin };
    }
    
    activity_instance setup_activity_objective_marker();
    activity_instance setup_boss_objective_marker( agent );
    activity_instance create_boss_healthbar( agent );
    activity_instance.var_2c7df72824504573 = agent.health;
    activity_instance thread function_bdd726d8cd503150();
    activity_instance thread function_31fa84baab4abfb7();
    activity_instance thread function_b569eae03a609f80();
    activity_instance thread function_12fa995bfbb5301f();
    var_4b47655c33f51e24 = spawn( "script_model", agent.origin + ( 0, 0, 100 ) );
    var_4b47655c33f51e24 setmodel( "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_boss_cradle" ), var_4b47655c33f51e24, "tag_origin" );
    var_4b47655c33f51e24 linkto( agent, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    agent.var_4b47655c33f51e24 = var_4b47655c33f51e24;
    var_1bb0796a92aa365f = spawn( "script_model", agent.origin + ( 0, 0, 100 ) );
    var_1bb0796a92aa365f setmodel( "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), var_1bb0796a92aa365f, "tag_origin" );
    var_1bb0796a92aa365f linkto( agent, "j_palm_ri", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    agent.var_1bb0796a92aa365f = var_1bb0796a92aa365f;
    var_1bb07a6a92aa3892 = spawn( "script_model", agent.origin + ( 0, 0, 100 ) );
    var_1bb07a6a92aa3892 setmodel( "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), var_1bb07a6a92aa3892, "tag_origin" );
    var_1bb07a6a92aa3892 linkto( agent, "j_palm_le", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    agent.var_1bb07a6a92aa3892 = var_1bb07a6a92aa3892;
    var_1bb07b6a92aa3ac5 = spawn( "script_model", agent.origin + ( 0, 0, 100 ) );
    var_1bb07b6a92aa3ac5 setmodel( "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), var_1bb07b6a92aa3ac5, "tag_origin" );
    var_1bb07b6a92aa3ac5 linkto( agent, "j_ball_ri", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    agent.var_1bb07b6a92aa3ac5 = var_1bb07b6a92aa3ac5;
    var_1bb0746a92aa2b60 = spawn( "script_model", agent.origin + ( 0, 0, 100 ) );
    var_1bb0746a92aa2b60 setmodel( "tag_origin" );
    playfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), var_1bb0746a92aa2b60, "tag_origin" );
    var_1bb0746a92aa2b60 linkto( agent, "j_ball_le", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    agent.var_1bb0746a92aa2b60 = var_1bb0746a92aa2b60;
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xfc3641ff, Offset: 0x60d9
// Size: 0x1e8
function private function_31fa84baab4abfb7()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"boss_killed" );
    self.boss endon( #"death" );
    self.var_164b72a540d9e2fc = 0;
    self.var_7c1732b0c055fa33 = 0;
    self.var_da76755357df425b = [];
    self.var_a7d15888ac29b39e = [];
    self.var_47caaff8e9ff990 = 0;
    self.var_c67b9fff13fe632b = 0;
    
    while ( true )
    {
        currenttime = gettime();
        var_a7c2348fecd77429 = player_utility::script_getplayersinradius( self.boss.origin, 2000 );
        
        if ( var_a7c2348fecd77429.size > 0 )
        {
            if ( currenttime - self.var_164b72a540d9e2fc > 60000 && self.var_da76755357df425b.size < 2 && self.var_47caaff8e9ff990 + self.var_da76755357df425b.size < 4 )
            {
                self.var_164b72a540d9e2fc = currenttime;
                var_3b8162822795abe3 = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_possessed_convoy_boss_hvt_flood", self.boss.origin, 500, 1, 0, 1, 0 );
                activity_ai_encounters::function_52d1342183200a8f( var_3b8162822795abe3, &function_44a817c0e1c3e534, [ self, 1 ] );
            }
            
            if ( currenttime - self.var_7c1732b0c055fa33 > 5000 && self.var_a7d15888ac29b39e.size < 20 && self.var_c67b9fff13fe632b + self.var_a7d15888ac29b39e.size < 100 )
            {
                self.var_7c1732b0c055fa33 = currenttime;
                flood_request_id = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_possessed_convoy_boss_flood", self.boss.origin, 500, 1, 0, 1, 0 );
                activity_ai_encounters::function_52d1342183200a8f( flood_request_id, &function_44a817c0e1c3e534, [ self, 0 ] );
            }
        }
        
        wait 1;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xa9e5f9a2, Offset: 0x62c9
// Size: 0x6d
function private function_b569eae03a609f80()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"boss_killed" );
    self.boss endon( #"death" );
    
    while ( true )
    {
        if ( self.boss function_c607805e62ad17af() >= 5000 )
        {
            self.boss notify( #"spawn_bees" );
        }
        
        wait 2;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 4, eflags: 0x4
// Checksum 0xcab0bac2, Offset: 0x633e
// Size: 0xde
function private function_44a817c0e1c3e534( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activityinstance = userdata[ 0 ];
    var_8035279fe7a4be04 = userdata[ 1 ];
    
    if ( isalive( agent ) )
    {
        agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
        agent callback::add( #"on_ai_killed", &function_8e2dc438f10dba3, [ activityinstance, var_8035279fe7a4be04, requestid ] );
        agent.var_437f238159c83b57 = 1;
        
        if ( var_8035279fe7a4be04 )
        {
            activityinstance.var_da76755357df425b[ activityinstance.var_da76755357df425b.size ] = agent;
            return;
        }
        
        activityinstance.var_a7d15888ac29b39e[ activityinstance.var_a7d15888ac29b39e.size ] = agent;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x9f5f0120, Offset: 0x6424
// Size: 0xd5
function private function_8e2dc438f10dba3( params, userdata )
{
    activityinstance = userdata[ 0 ];
    var_8035279fe7a4be04 = userdata[ 1 ];
    requestid = userdata[ 2 ];
    
    if ( var_8035279fe7a4be04 )
    {
        activityinstance.var_da76755357df425b = arrayremove( activityinstance.var_da76755357df425b, self );
    }
    else
    {
        activityinstance.var_a7d15888ac29b39e = arrayremove( activityinstance.var_a7d15888ac29b39e, self );
    }
    
    var_4c6516944983d5d8 = function_da26e38f24f90f2f( requestid );
    
    if ( var_4c6516944983d5d8 <= 1 )
    {
        activityinstance activity_ai_encounters::function_1010ba035d94f9f1( requestid );
    }
    
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    if ( var_8035279fe7a4be04 )
    {
        activityinstance.var_47caaff8e9ff990++;
        return;
    }
    
    activityinstance.var_c67b9fff13fe632b++;
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x328a3925, Offset: 0x6501
// Size: 0x2de
function private function_12fa995bfbb5301f()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.boss endon( #"death" );
    boss = self.boss;
    combat_area = self.var_e45112c70c3b2a70;
    
    while ( true )
    {
        is_oob = distance2d( boss.origin, combat_area.origin ) > combat_area.radius;
        
        /#
            if ( function_a5cd5a36ccebe58( "<dev string:x22e>", 0 ) )
            {
                reference_point = level.players[ 0 ].origin;
                
                foreach ( boss_return_point in self.var_2e18d2ace34ed3c )
                {
                    color = ( 1, 0, 0 );
                    reference_distance = "<dev string:x124>";
                    
                    if ( reference_point )
                    {
                        reference_distance = distance2d( reference_point, boss_return_point );
                        
                        if ( reference_distance <= 7000 )
                        {
                            color = ( 0, 0, 1 );
                        }
                    }
                    
                    sphere( boss_return_point, 50, color, 0, 1 );
                    cylinder( boss_return_point, boss_return_point + ( 0, 0, 10 ), 7000, color, 0, 1 );
                    print3d( boss_return_point, "<dev string:x237>" + reference_distance, color, 1, 1, 1 );
                }
                
                cylinder( combat_area.origin, combat_area.origin + ( 0, 0, 10 ), combat_area.radius, ( 1, 1, 0 ), 0, 1 );
                print3d( combat_area.origin, "<dev string:x24a>" + combat_area.radius, ( 1, 1, 0 ), 1, 1, 1 );
            }
        #/
        
        if ( is_oob )
        {
            if ( boss val::get( "push_player" ) )
            {
                boss namespace_7bf9c7d90634c36f::stop_charge();
            }
            
            return_point = function_60f1bf665f6d65ed();
            
            if ( return_point )
            {
                return_point = getclosestpointonnavmesh( return_point, boss );
                
                /#
                    if ( function_a5cd5a36ccebe58( "<dev string:x22e>", 0 ) )
                    {
                        debug_draw_frames = 600;
                        
                        if ( return_point )
                        {
                            sphere( return_point, 50, ( 1, 0, 0 ), 0, debug_draw_frames );
                            print3d( return_point, "<dev string:x263>", ( 0, 1, 0 ), 1, 1, debug_draw_frames );
                        }
                    }
                #/
                
                if ( !boss function_86e8446c583cf643( return_point ) )
                {
                    wait 10;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x205fcce2, Offset: 0x67e7
// Size: 0x7c
function private function_60f1bf665f6d65ed()
{
    boss = self.boss;
    return_point = boss.spawn_point;
    
    if ( self.var_2e18d2ace34ed3c.size && distance2d( boss.origin, boss.spawn_point ) > 7000 )
    {
        return_point = utility::function_4325398d215ecda5( boss.origin, self.var_2e18d2ace34ed3c, 7000 );
    }
    
    return return_point;
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x3e0a0e4c, Offset: 0x686c
// Size: 0x1a3
function private function_86e8446c583cf643( position )
{
    agent = self;
    agent endon( #"death" );
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent clearbtgoal( 3 );
    wait randomfloatrange( 1, 2 );
    agent setbtgoalpos( 0, position );
    agent setbtgoalpos( 1, position );
    agent setbtgoalradius( 0, 256 );
    agent setbtgoalradius( 1, 256 );
    agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "oob", 1000 );
    
    while ( true )
    {
        msg = agent utility::waittill_any_timeout( 1, "goal", "bad_path", "goal_reached", "bt_goal" );
        
        if ( msg != "timeout" )
        {
            if ( msg == "bad_path" )
            {
                /#
                    debugstar( agent.origin, ( 1, 0, 0 ), 10000, "<dev string:x279>", 1 );
                    debugstar( position, ( 1, 0, 0 ), 10000, "<dev string:x287>", 1 );
                #/
                
                bad_path = 1;
            }
            else
            {
                goalreached = 1;
            }
        }
        
        if ( bad_path || goalreached || distance( agent.origin, position ) <= 256 )
        {
            break;
        }
    }
    
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent clearbtgoal( 3 );
    agent setbtgoalradius( 0, 24 );
    agent clearenemy();
    agent zombie_utils::function_a8ce00e0448cb6f0( undefined, "oob", 1000 );
    return goalreached;
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x3f117532, Offset: 0x6a18
// Size: 0x22f
function private on_boss_killed( params, activityinstance )
{
    eattacker = params.eattacker;
    attackerplayer = isplayer( eattacker ) ? eattacker : eattacker.owner;
    activityinstance function_137ecc3aa80a8dc7( attackerplayer, params.idamage );
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activityinstance.var_f5c7f59b645e1f2c );
    activityinstance.reward_pos = activityinstance.boss.origin;
    activityinstance.var_f5c7f59b645e1f2c = undefined;
    activityinstance.boss = undefined;
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activityinstance.objidnum );
    activityinstance.objidnum = undefined;
    stopfxontag( utility::getfx( "vfx_possessed_convoy_boss_cradle" ), self.var_4b47655c33f51e24, "tag_origin" );
    self.var_4b47655c33f51e24 unlink();
    self.var_4b47655c33f51e24 delete();
    self.var_4b47655c33f51e24 = undefined;
    stopfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), self.var_1bb0796a92aa365f, "tag_origin" );
    self.var_1bb0796a92aa365f unlink();
    self.var_1bb0796a92aa365f delete();
    self.var_1bb0796a92aa365f = undefined;
    stopfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), self.var_1bb07a6a92aa3892, "tag_origin" );
    self.var_1bb07a6a92aa3892 unlink();
    self.var_1bb07a6a92aa3892 delete();
    self.var_1bb07a6a92aa3892 = undefined;
    stopfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), self.var_1bb07b6a92aa3ac5, "tag_origin" );
    self.var_1bb07b6a92aa3ac5 unlink();
    self.var_1bb07b6a92aa3ac5 delete();
    self.var_1bb07b6a92aa3ac5 = undefined;
    stopfxontag( utility::getfx( "vfx_possessed_convoy_boss_leg" ), self.var_1bb0746a92aa2b60, "tag_origin" );
    self.var_1bb0746a92aa2b60 unlink();
    self.var_1bb0746a92aa2b60 delete();
    self.var_1bb0746a92aa2b60 = undefined;
    activityinstance notify( #"boss_killed" );
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xd59ac7e6, Offset: 0x6c4f
// Size: 0x97
function private boss_damage_watcher( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        activityinstance function_137ecc3aa80a8dc7( attackerplayer, damage );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xb5f6280d, Offset: 0x6cee
// Size: 0x45
function private setup_boss_objective_marker( agent )
{
    self.var_f5c7f59b645e1f2c = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_possessed_convoy_boss", 0, 1 );
    setup_hovercard( self.var_f5c7f59b645e1f2c );
    objidpoolmanager::update_objective_onentity( self.var_f5c7f59b645e1f2c, agent );
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x7b5680f, Offset: 0x6d3b
// Size: 0xc9
function private function_137ecc3aa80a8dc7( player, damage )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    boss_fight_zone_center = boss_fight_zone_get_center( self );
    
    if ( self.spatial_zone_struct && distance2d( boss_fight_zone_center, player.origin ) <= self.spatial_zone_struct.radius )
    {
        activity_participation::function_bc67362dace4370c( self, player, "PlayerJoinedDamage" );
    }
    
    if ( !isdefined( self.var_d37b5fa0bcc48a74 ) )
    {
        self.var_d37b5fa0bcc48a74 = [];
    }
    
    var_d37b5fa0bcc48a74 = self.var_d37b5fa0bcc48a74;
    
    if ( !isdefined( var_d37b5fa0bcc48a74[ player getxuid() ] ) )
    {
        var_d37b5fa0bcc48a74[ player getxuid() ] = 0;
    }
    
    var_d37b5fa0bcc48a74[ player getxuid() ] += damage;
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x3aa01d14, Offset: 0x6e0c
// Size: 0x258
function private function_7e78683b28a5b7b4()
{
    if ( self.var_124d37318b71248a > 0 )
    {
        var_77013cab2cfe49a5 = [];
        var_ce8e547981b990fb = [];
        var_bfd2870910858fe = self.var_124d37318b71248a * self.var_2c7df72824504573 / 100;
        
        foreach ( player in self.playerparticipants )
        {
            var_3f000c9156465fcf = self.var_d37b5fa0bcc48a74[ player getxuid() ];
            
            if ( !var_3f000c9156465fcf || var_3f000c9156465fcf < var_bfd2870910858fe )
            {
                var_77013cab2cfe49a5[ player getxuid() ] = player;
                continue;
            }
            
            var_ce8e547981b990fb[ player getxuid() ] = player;
        }
        
        foreach ( player in var_77013cab2cfe49a5 )
        {
            squadcredit = 0;
            squad = teams::function_72b89edf6b47c40a( player );
            
            foreach ( squadmate in squad.players )
            {
                if ( squadmate == player )
                {
                    continue;
                }
                
                if ( isplayer( var_ce8e547981b990fb[ squadmate getxuid() ] ) )
                {
                    squadcredit = 1;
                    break;
                }
            }
            
            if ( !squadcredit )
            {
                var_3f000c9156465fcf = self.var_d37b5fa0bcc48a74[ player getxuid() ];
                logstring( "[POSSESSED CONVOY] player " + player.name + " removed from activity rewards due to insufficient boss damage: " + ( var_3f000c9156465fcf ?? 0 ) + " / " + self.var_2c7df72824504573 );
                activity_participation::function_61aa2b2879f2c0a2( self, player );
            }
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x3ca05b04, Offset: 0x706c
// Size: 0x11c
function private function_125852f491cf7e5d()
{
    spawn_pos = self.reward_pos + ( 0, 0, 100 );
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( spawn_pos );
    exotic_weapon = common_item::function_61c2c0251e742ffd( %"hash_6746660b468e32bb", undefined, spawn_options );
    exotic_weapon.scriptable_index = exotic_weapon getscriptableindex();
    ob_item_select::function_1dfd8b3bc8e33dd8( exotic_weapon );
    ob_item_select::function_923ddf97f6cdbee( exotic_weapon, self.playerparticipants );
    
    foreach ( player in self.playerparticipants )
    {
        ping_id = player calloutmarkerping::function_920a63c06abdefe8( exotic_weapon.scriptable_index );
        player calloutmarkerping_hide( ping_id );
        player calloutmarkerping_show( ping_id, player );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xd080fa9e, Offset: 0x7190
// Size: 0x63
function private create_boss_healthbar( boss )
{
    self.boss_healthbar_asset = "ob_boss_callisto";
    self.current_boss = boss;
    boss.ob_boss_healthbar_priority = 1;
    boss.activityinstance = self;
    boss callback::add( "on_zombie_ai_damaged", &function_7f4f2763d6ce8403 );
    update_boss_healthbar( self.playerparticipants );
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xc3bce4bc, Offset: 0x71fb
// Size: 0x3d
function private function_7f4f2763d6ce8403( params )
{
    visible_players = self.activityinstance.playerparticipants;
    self.activityinstance update_boss_healthbar( visible_players );
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0xa1f42d63, Offset: 0x7240
// Size: 0x7e
function private update_boss_healthbar( players )
{
    foreach ( player in players )
    {
        thread function_8878a4153f4ddcbd( player );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x6e8620b2, Offset: 0x72c6
// Size: 0xd9
function private function_8878a4153f4ddcbd( player )
{
    if ( !self.current_boss )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        if ( !player.var_71c37977095602df )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( self.boss_healthbar_asset, self.current_boss );
        }
        else if ( player.var_71c37977095602df == self.boss_healthbar_asset )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
    }
    
    if ( player.var_71c37977095602df == self.boss_healthbar_asset )
    {
        if ( self.current_boss.immune || self.current_boss getaiblackboarddynamic( "immune" ) )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 1, eflags: 0x4
// Checksum 0x6fca3be1, Offset: 0x73a7
// Size: 0x96
function private hide_boss_healthbar( players )
{
    foreach ( player in players )
    {
        if ( player.var_71c37977095602df == self.boss_healthbar_asset )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
        }
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0x7327c5d1, Offset: 0x7445
// Size: 0x106
function private function_43dc512863e62872()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        currenttime = gettime();
        var_a3ecbe36b238bb54 = [];
        
        foreach ( playerdamageinfo in self.var_946a5a954be1335b )
        {
            if ( playerdamageinfo.player )
            {
                if ( currenttime - playerdamageinfo.var_64df9b854c2153d7 >= 60000 )
                {
                    activity_participation::function_61aa2b2879f2c0a2( self, playerdamageinfo.player );
                    continue;
                }
                
                var_a3ecbe36b238bb54[ playerdamageinfo.player getentitynumber() ] = playerdamageinfo;
            }
        }
        
        self.var_946a5a954be1335b = var_a3ecbe36b238bb54;
        wait 1;
    }
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x9f48c635, Offset: 0x7553
// Size: 0xc5
function private function_52488353fe53e7b8( player, var_a3dfc106574c437c = 1 )
{
    if ( !isplayer( player ) || self.activity_boss_phase )
    {
        return;
    }
    
    currenttime = gettime();
    
    if ( !isdefined( self.var_946a5a954be1335b ) )
    {
        self.var_946a5a954be1335b = [];
    }
    
    playerdamageinfo = self.var_946a5a954be1335b[ player getentitynumber() ];
    
    if ( !playerdamageinfo )
    {
        playerdamageinfo = spawnstruct();
        playerdamageinfo.player = player;
    }
    
    playerdamageinfo.var_64df9b854c2153d7 = currenttime;
    self.var_946a5a954be1335b[ player getentitynumber() ] = playerdamageinfo;
    
    if ( var_a3dfc106574c437c )
    {
        activity_participation::function_bc67362dace4370c( self, player, "PlayerJoinedDamage" );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 0, eflags: 0x4
// Checksum 0xd7d563cc, Offset: 0x7620
// Size: 0xc4
function private setup_activity_objective_marker()
{
    self.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_activity_possessed_convoy_vehicle_tac_map_marker", 0, 0 );
    setup_hovercard( self.objidnum );
    function_38b84cb3d4357dd7( self.objidnum );
    objective_hidefromplayersinmask( self.objidnum );
    
    foreach ( player in self.playerparticipants )
    {
        objective_addclienttomask( self.objidnum, player );
    }
}

// Namespace ob_activity_possessed_convoy
// Params 2, eflags: 0x4
// Checksum 0x40c9b4b2, Offset: 0x76ec
// Size: 0x2a
function private get_override_setting( name, defaultvalue )
{
    return getdvarint( hashcat( @"hash_417fb929c79e35f4", name ), defaultvalue );
}

/#

    // Namespace ob_activity_possessed_convoy
    // Params 2, eflags: 0x4
    // Checksum 0x4e2ec27a, Offset: 0x771f
    // Size: 0x22, Type: dev
    function private function_a5cd5a36ccebe58( name, defaultvalue )
    {
        return get_override_setting( name, defaultvalue );
    }

#/
