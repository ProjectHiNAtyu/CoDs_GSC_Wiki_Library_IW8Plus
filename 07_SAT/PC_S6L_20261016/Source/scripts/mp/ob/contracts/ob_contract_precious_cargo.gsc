// scripts\mp\ob\contracts\ob_contract_precious_cargo.gsc  (hash_74840acabe6780a2.gscc) (size: 44211 Bytes / 0xacb3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe364cfee (3815034862)
// size ...... 44211 (0xacb3)
// includes .. 39  (offset: 0xa3ff)
// strings ... 108 (offset: 0xa537)
// dev strs .. 15  (offset: 0xabff)
// exports ... 92  (offset: 0x6f3f)
// cseg ...... 0x926 + 0x6619 (0x6f3f)
// imports ... 312 (offset: 0x7d9f)
// animtree1 . 0   (offset: 0xacb3)
// animtree2 . 0   (offset: 0xacb3)
#using script_60cd1c57e94be8d7;
#using script_6e05fdc2c6f5fa06;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_spawn;
#using scripts\mp\ai_behavior;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_convoy_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_activity_instance_common;
#using scripts\mp\ob\systems\ob_music;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;

#namespace ob_contract_precious_cargo;

// Namespace ob_contract_precious_cargo
// Params 0, eflags: 0x5
// Checksum 0x88be92a0, Offset: 0x944
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_90e2daae0f53ae94", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_contract_precious_cargo
// Params 0, eflags: 0x4
// Checksum 0x8270c9bc, Offset: 0x96d
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_CONTRACT_PRECIOUS_CARGO", &precious_cargo_activity_type_init );
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x9e241291, Offset: 0x988
// Size: 0xbd
function precious_cargo_activity_type_init()
{
    setdvar( @"hash_3061dc07aba9108", 0 );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_PRECIOUS_CARGO", 0, &precious_cargo_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_PRECIOUS_CARGO", 1, &precious_cargo_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_PRECIOUS_CARGO", 2, &precious_cargo_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_PRECIOUS_CARGO", 3, &precious_cargo_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_PRECIOUS_CARGO", 4, &function_fd967cc0edaf9f96 );
    activity_common::function_944074f3079c1d4e( "REV_OB_CONTRACT_PRECIOUS_CARGO", 5, &function_a3d96f670a1bf96c );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_c7871b7129e9c0c8, "REV_OB_CONTRACT_PRECIOUS_CARGO" );
    
    if ( !isdefined( level.var_6185eb2ed44f2649 ) )
    {
        zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
        level.var_6185eb2ed44f2649 = 1;
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xa79f847f, Offset: 0xa4d
// Size: 0x16e
function precious_cargo_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !isdefined( level.var_209035fc1e63a988 ) )
    {
        level.var_209035fc1e63a988 = utility::getstructarray( "heli_reinforceNode", "script_noteworthy" );
    }
    
    if ( !isdefined( level.var_ed667fc31da4622e ) )
    {
        level.var_ed667fc31da4622e = utility::getstructarray( "precious_cargo_end", "targetname" );
    }
    
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    self.var_f4a8e02d94ead646 = 0;
    var_5c048b6d7b414502 = utility::getstructarray( self.varianttag, "target" );
    self.encounter_centers = [];
    
    foreach ( struct in var_5c048b6d7b414502 )
    {
        if ( struct.targetname == "ai_encounter_center" )
        {
            self.encounter_centers[ self.encounter_centers.size ] = struct;
        }
    }
    
    self.spawnedvehicles = [];
    function_f58cf3ea3b58232e();
    function_ae1ba66a9f6aa998();
    waitframe();
    function_bf149612e565959a();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xd3a0068c, Offset: 0xbc3
// Size: 0x286
function function_bf149612e565959a()
{
    activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ self.id ] ?? [];
    assert( activityjoininteracts.size == 1 );
    joininteract = activityjoininteracts[ 0 ];
    self.joinerscriptable = joininteract;
    joininteract setscriptablepartstate( #"nexus_activity_joiner_phone", #"hidden" );
    self.difficulty_region = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( self ) );
    ob_contract_ui_widget::function_3b7d5e996ba0c975( ob_activity_definition_utils::function_e55fda458ce2c4cc( self ), self.playerparticipants );
    ob_activity_instance_common::function_9c6b2d04234d7b5e( self, joininteract );
    
    /#
        checkoutofbounds = getdvarint( @"hash_96bf67bf0c6433f9", 0 );
        validposition = function_be4318402c9c1594( joininteract.origin );
        var_9119dfd5b0f6b135 = distance( validposition, joininteract.origin ) > 100;
        
        if ( checkoutofbounds && var_9119dfd5b0f6b135 )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    #/
    
    while ( true )
    {
        nearbyplayers = getplayersinradius( joininteract.origin, 5000 );
        
        if ( !nearbyplayers.size )
        {
            spawndata = spawnstruct();
            spawndata.origin = joininteract.origin;
            spawndata.angles = joininteract.angles;
            spawndata vehicle_spawn::prevent_respawn();
            spawndata.var_499a16b493ff31ed = 1;
            spawndata.triggerrecycle = 1;
            self.starter_vehicle = ob_resource_manager::activity_spawn_vehicle( %"hash_56311b5cc8c94835", spawndata );
            function_b7c1479decde7d2( self.starter_vehicle, 0 );
            self.starter_vehicle vehicleshowonminimap( 0 );
            self.starter_vehicle vehicle_damage::set_can_damage( 0 );
            self.starter_vehicle utility::function_7c10ea82c1e305b8( #"single", #"vehicle_unusable" );
            self.spawnedvehicles[ self.spawnedvehicles.size ] = self.starter_vehicle;
            self.starter_vehicle thread function_f9a7634cd79cc335( self );
            joininteract setscriptablepartstate( #"nexus_activity_joiner_phone", #"visible" );
            joininteract utility::scriptable_setparententity( self.starter_vehicle, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            break;
        }
        
        wait 0.5;
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x775ebbd, Offset: 0xe51
// Size: 0x168
function function_f9a7634cd79cc335( activity_instance )
{
    activity_instance endon( #"ActivityBegin" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    noticed_players = [];
    
    while ( true )
    {
        msg = utility::waittill_any_timeout( 1, "death", "vehicle_deleted" );
        
        if ( msg != "timeout" || !self || vehicle::is_destroyed() )
        {
            script::demoforcesre( "The starter vehicle for the precious cargo contract has been destroyed unexpectedly " + activity_instance.varianttag );
            break;
        }
        
        players_array = getplayersinradius( self.origin, 1000 );
        
        foreach ( player in players_array )
        {
            if ( player::isreallyalive( player ) )
            {
                squad_members_nearby = player ob_activity_utility::function_468428fa3b477b54();
                broadcast_targets = arrayremove( squad_members_nearby, noticed_players );
                
                if ( broadcast_targets.size )
                {
                    noticed_players = arraycombineunique( noticed_players, broadcast_targets );
                    activity_instance thread ob_activity_utility::function_894ac80e038636c5( "wcpvepreccargobriefalert", broadcast_targets );
                }
            }
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x5f14c7fb, Offset: 0xfc1
// Size: 0xa2
function precious_cargo_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_activity_utility::function_894ac80e038636c5( "wcpvepreciouscargobrief" );
    level ob_music::function_96d2da3192b28f8f( self, &function_1dd68b8826ec50a8, [ self ] );
    
    if ( self.encounter_centers )
    {
        self.numagents = 0;
        thread function_f71d093ed802d1d0();
    }
    
    self.joinerscriptable utility::scriptable_clearparententity();
    function_b7c1479decde7d2( self.starter_vehicle, 1 );
    self.starter_vehicle vehicleshowonminimap( 1 );
    self.starter_vehicle vehicle_damage::set_can_damage( 1 );
    function_990013511a502756();
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x6e887a3, Offset: 0x106b
// Size: 0x206
function precious_cargo_activity_end()
{
    self endon( #"instance_destroyed" );
    level ob_music::function_be4c0727a998b18b( self );
    ob_convoy_util::function_27eb33c611286cd9( self.var_e814baa69305ee8a );
    self.var_e814baa69305ee8a = undefined;
    
    if ( self.targetvehicle )
    {
        self.targetvehicle vehicle_settopspeedforward( self.targetvehicle.var_52dfac12181e4ef9 );
        self.targetvehicle vehicle_settopspeedreverse( self.targetvehicle.var_80f99dc346cf1422 );
    }
    
    if ( self.end )
    {
        self.end.inuse = 0;
    }
    
    if ( isdefined( self.enemyvtol ) )
    {
        self.enemyvtol thread [[ self.vtoldata.flyaway ]]();
    }
    
    function_ff10e052bbd1394();
    
    if ( self.var_5b82bf749a80e42f )
    {
        namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_5b82bf749a80e42f );
    }
    
    if ( self.var_113d2549e36bbe54 )
    {
        foreach ( id in self.var_113d2549e36bbe54 )
        {
            namespace_d7fa4530141146a5::function_501e44ea1cb9219d( id );
        }
    }
    
    if ( isdefined( self.a_vh_convoy ) )
    {
        foreach ( vehicle in self.a_vh_convoy )
        {
            vehicle notify( #"activity_end" );
            vehicle function_bfe8c35fbb6bc63c( self );
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xb7589179, Offset: 0x1279
// Size: 0x13e
function function_776b6ee239e293bd()
{
    level ob_music::function_be4c0727a998b18b( self );
    
    if ( isdefined( self.spawnedvehicles ) )
    {
        foreach ( vehicle in self.spawnedvehicles )
        {
            vehicle thread ob_activity_utility::function_16f13e7feb0abb24( 3000 );
        }
    }
    
    if ( isdefined( self.enemyvtol ) )
    {
        self.enemyvtol thread [[ self.vtoldata.flyaway ]]();
    }
    
    foreach ( emp_grenade in self.emp_grenades )
    {
        common_item::function_869d7676e359a627( emp_grenade );
    }
    
    thread activity_ai_encounters::function_cb88eba0bb17a5e4();
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x2df90514, Offset: 0x13bf
// Size: 0x45
function precious_cargo_activity_destroy()
{
    if ( self.var_e814baa69305ee8a )
    {
        ob_convoy_util::function_27eb33c611286cd9( self.var_e814baa69305ee8a );
    }
    
    function_ff10e052bbd1394();
    level thread function_3604220db3a0a0cf( self.scriptable_covers, self );
    ob_activity_utility::ob_disable_cover_nodes();
    function_776b6ee239e293bd();
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x528109b1, Offset: 0x140c
// Size: 0x8
function function_fd967cc0edaf9f96()
{
    return function_cdaa1d99e3a3ba24();
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x7c5d8a5c, Offset: 0x141d
// Size: 0x69
function function_cdaa1d99e3a3ba24()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    centerpoint = undefined;
    
    if ( self.a_vh_convoy.size > 0 )
    {
        vehicle = self.targetvehicle;
        
        if ( isalive( vehicle ) )
        {
            centerpoint = self.targetvehicle.origin;
        }
    }
    
    return centerpoint;
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x764fc8e2, Offset: 0x148f
// Size: 0x7b
function function_1dd68b8826ec50a8( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    centerpoint = undefined;
    
    if ( activityinstance.a_vh_convoy.size > 0 )
    {
        vehicle = activityinstance.targetvehicle;
        
        if ( isalive( vehicle ) )
        {
            centerpoint = activityinstance.targetvehicle.origin;
        }
    }
    
    return centerpoint;
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0xab0a0df9, Offset: 0x1513
// Size: 0x8c
function function_a3d96f670a1bf96c( relevantinfostruct )
{
    offset = ( -100, 250, 0 );
    reward_struct = spawnstruct();
    navmeshpos = getclosestpointonnavmesh( self.end.origin + offset );
    reward_struct.origin = utility::drop_to_ground( navmeshpos );
    reward_struct.angles = self.end.angles;
    return reward_struct;
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xaa233c7a, Offset: 0x15a8
// Size: 0xb
function function_53995ed9b5653fc4()
{
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x283626a1, Offset: 0x15bb
// Size: 0x23
function function_c7871b7129e9c0c8( relevant_info_struct )
{
    ob_activity_utility::function_894ac80e038636c5( "wcpvepreccarabandon", relevant_info_struct.playerlist );
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xe29589e7, Offset: 0x15e6
// Size: 0x283
function function_f58cf3ea3b58232e()
{
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    var_5c048b6d7b414502 = utility::getstructarray( self.varianttag, "target" );
    
    foreach ( struct in var_5c048b6d7b414502 )
    {
        if ( struct.script_noteworthy == "precious_cargo_spawn_vehicle" )
        {
            self.friendly_vehicle_node = struct;
        }
    }
    
    self.a_vh_convoy = [];
    self.a_ai_convoy = [];
    self.a_loot_caches = [];
    self.nd_spline_start = undefined;
    self.s_center = utility::getstruct( self.varianttag, "targetname" );
    
    if ( !self.s_center )
    {
        assertmsg( "<dev string:x24>" + self.varianttag + "<dev string:x5e>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    var_5c048b6d7b414502 = utility::getstructarray( self.varianttag, "target" );
    self.horde_spawns = [];
    
    foreach ( struct in var_5c048b6d7b414502 )
    {
        if ( struct.targetname == "precious_cargo_horde" )
        {
            self.horde_spawn = struct;
            self.horde_spawns[ self.horde_spawns.size ] = self.horde_spawn;
        }
    }
    
    function_f74d37856555967a( activityvariantdefinition );
    self.str_stealth_group = "sg_" + self.varianttag;
    
    if ( !isdefined( function_ff2498f19618e5fa( self.str_stealth_group ) ) )
    {
        stealthinitgroup( self.str_stealth_group );
    }
    
    /#
        iprintln( "<dev string:x6c>" + self.varianttag );
    #/
    
    self.var_d5ed03421f78dd64 = 0;
    self.var_f904fd9fe7b07a23 = 0;
    self.a_vh_ground = [];
    self.n_veh_speed = self.defaultspeed;
    function_35600a38e1b1f484();
    ob_convoy_util::init_vehicle_callback();
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x608b9201, Offset: 0x1871
// Size: 0xf8
function function_ae1ba66a9f6aa998()
{
    emp_spawn_structs = utility::getstructarray( "lootable_emp_" + self.varianttag, "targetname" );
    self.emp_grenades = [];
    
    foreach ( emp_spawn_struct in emp_spawn_structs )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( emp_spawn_struct.origin );
        spawnoptions.var_fd47e835523b473f = 1;
        emp_grenade = common_item::function_325e28c0fb65c36a( "equip_emp", 2, spawnoptions );
        self.emp_grenades = arraycombineunique( self.emp_grenades, [ emp_grenade ] );
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x4776dafe, Offset: 0x1971
// Size: 0x1a5
function function_675457f1e24d6bc2()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_ca257099ad30b077 = self.s_center game_utility_mp::get_linked_vehicle_nodes();
    var_ca257099ad30b077 = arrayrandomize( var_ca257099ad30b077 );
    
    foreach ( startnode in var_ca257099ad30b077 )
    {
        player = function_47c86977a18df38b( level.players, startnode.origin, 1500 );
        
        if ( isdefined( player ) )
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

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0xc3b71fa5, Offset: 0x1b1f
// Size: 0x2f4
function function_f74d37856555967a( activityvariantdefinition )
{
    self.ai_team = activityvariantdefinition.aiteam ?? "team_hundred_ninety";
    self.var_5488f8dc3e113708 = activityvariantdefinition.lightratio ?? 0.75;
    self.var_128b623ecd6c2715 = activityvariantdefinition.mediumratio ?? 0.5;
    self.var_3834e5fcc52d11e1 = activityvariantdefinition.heavyratio ?? 0.25;
    self.slowspeed = activityvariantdefinition.slowspeed ?? 12;
    self.medspeed = activityvariantdefinition.medspeed ?? 16;
    self.highspeed = activityvariantdefinition.highspeed ?? 25;
    self.var_8c0b9efa3145cbb4 = istrue( activityvariantdefinition.var_8c0b9efa3145cbb4 );
    self.var_6659ca8173670617 = activityvariantdefinition.var_6659ca8173670617 ?? "EXIT_VEHICLE";
    
    if ( isdefined( activityvariantdefinition ) )
    {
        switch ( activityvariantdefinition.defaultspeed )
        {
            case #"hash_3019364f12fc7058":
                self.defaultspeed = self.slowspeed;
                break;
            case #"hash_17bcce6c9cdcaab9":
                self.defaultspeed = self.medspeed;
                break;
            case #"hash_4fda5219ac1d2d5d":
                self.defaultspeed = self.highspeed;
                break;
            default:
                self.defaultspeed = self.slowspeed;
                break;
        }
        
        self.var_7d7a32be78c7fc98 = [];
        
        for ( i = 0; i < activityvariantdefinition.convoyvehicles.size ; i++ )
        {
            self.var_7d7a32be78c7fc98[ i ] = spawnstruct();
            self.var_7d7a32be78c7fc98[ i ].riderencounter = "ai_encounter:" + activityvariantdefinition.convoyvehicles[ i ].variant_object.riderencounter;
            self.var_7d7a32be78c7fc98[ i ].vehicleref = activityvariantdefinition.convoyvehicles[ i ].variant_object.vehicle;
        }
        
        targetindex = int( activityvariantdefinition.convoyvehicles.size / 2 );
        var_7477b724bbb47325 = spawnstruct();
        var_7477b724bbb47325.riderencounter = "ai_encounter:" + activityvariantdefinition.targetvehicle.riderencounter;
        var_7477b724bbb47325.vehicleref = activityvariantdefinition.targetvehicle.vehicle;
        var_7477b724bbb47325.istarget = 1;
        arrayinsert( self.var_7d7a32be78c7fc98, var_7477b724bbb47325, targetindex );
        return;
    }
    
    self.defaultspeed = self.slowspeed;
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x429e4f72, Offset: 0x1e1b
// Size: 0x11
function function_35600a38e1b1f484()
{
    self.vtoldata = namespace_cf9a4f547edbca10::function_879241d6eca278b();
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x6e663e56, Offset: 0x1e34
// Size: 0xef
function function_990013511a502756()
{
    self.numagents = 0;
    function_c0bbe0e9b39fcbe3();
    thread function_1277462f658ec78e( self.playerparticipants[ 0 ], 1 );
    thread precious_cargo_setup_cover();
    thread function_bad6a34103e1a7af();
    thread function_a682390f15e4bf1c();
    thread function_e2761ea797e3ee0d();
    thread function_9eddf41fc064fc4e();
    self.var_e814baa69305ee8a = ob_convoy_util::function_8ccf719b775fd5a0( self.a_vh_ground );
    
    /#
        thread function_f1eb3689129b0cfd();
    #/
    
    wait 5;
    
    foreach ( vehicle in self.a_vh_ground )
    {
        ob_convoy_util::function_9846981f8d3b8539( vehicle );
    }
    
    thread monitor_intercept();
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x489d0320, Offset: 0x1f2b
// Size: 0x19f
function function_c0bbe0e9b39fcbe3( var_63044e94c4414735 )
{
    self.a_vh_ground = precious_cargo_vehicle_spawn( var_63044e94c4414735 );
    self.a_vh_convoy = arraycombine( self.a_vh_convoy, self.a_vh_ground );
    self.var_d5ed03421f78dd64 = self.a_vh_convoy.size;
    self.spawnedvehicles = arraycombine( self.spawnedvehicles, self.a_vh_convoy );
    self.a_vh_ground = utility::array_sort_by_script_index( self.a_vh_ground );
    thread function_3cbef36e9c2b2966();
    thread function_baf97f43dcf03e72();
    
    foreach ( convoy_vehicle in self.a_vh_ground )
    {
        convoy_vehicle thread function_d99c3d25ec4c8974( self );
        convoy_vehicle thread ob_convoy_util::function_2159092914a60ce0();
        vehicle_interact::allow_use( convoy_vehicle, 0 );
        
        foreach ( rider in convoy_vehicle.riders )
        {
            rider.lastvehicle = convoy_vehicle;
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 1, eflags: 0x4
// Checksum 0x3976cbcc, Offset: 0x20d2
// Size: 0xbc
function private function_77ece7b5ae679543( var_2ce6b8a691499a8 )
{
    newarray = [];
    
    foreach ( var_bb002b9a21dfc5dc in var_2ce6b8a691499a8 )
    {
        if ( !isalive( var_bb002b9a21dfc5dc ) || !isalive( var_bb002b9a21dfc5dc.driver ) || var_bb002b9a21dfc5dc vehicle_damage::get_state() == "heavy" )
        {
            continue;
        }
        
        newarray[ newarray.size ] = var_bb002b9a21dfc5dc;
    }
    
    return newarray;
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xc594ddfa, Offset: 0x2197
// Size: 0x6a
function function_a682390f15e4bf1c()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( self.a_vh_ground.size > 1 )
    {
        self.a_vh_convoy = function_77ece7b5ae679543( self.a_vh_convoy );
        self.a_vh_ground = function_77ece7b5ae679543( self.a_vh_ground );
        waitframe();
    }
    
    self notify( #"all_vehicles_destroyed" );
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0xa9111ee4, Offset: 0x2209
// Size: 0x54
function function_b7c1479decde7d2( vehicle, var_bed9b53b2f85501d )
{
    instancedataforvehicle = vehicle_interact::get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
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

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x60497675, Offset: 0x2265
// Size: 0x582
function precious_cargo_vehicle_spawn( var_63044e94c4414735 )
{
    if ( !isdefined( self.nd_spline_start ) )
    {
        self.nd_spline_start = function_675457f1e24d6bc2();
        
        if ( !isdefined( self.nd_spline_start ) )
        {
            script::demoforcesre( "Precious Cargo - could not find a start vehicle node in " + self.varianttag );
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    }
    
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
    offsetstart = 1;
    
    if ( self.nd_spline_start.targetname == "SUPPLY_CHAIN_Q2_phase_3_1" )
    {
        offsetstep = 400;
        offsetstart = 0;
    }
    
    self.convoydata = [];
    
    for ( index = 0; index < self.var_7d7a32be78c7fc98.size ; index++ )
    {
        var_77c8c5497c88f2e4 = randomfloatrange( 10, 35 );
        var_1b299177a948cca7 = offsetstep + var_77c8c5497c88f2e4;
        spawndata.origin = self.nd_spline_start.origin - offsetdirection * ( index + offsetstart ) * var_1b299177a948cca7 + ( 0, 0, 100 );
        vehicle = undefined;
        self.convoydata[ index ] = spawnstruct();
        vehicle_ref = self.var_7d7a32be78c7fc98[ index ].vehicleref;
        
        if ( isdefined( var_63044e94c4414735 ) && self.var_7d7a32be78c7fc98[ index ].istarget )
        {
            vehicle_ref = var_63044e94c4414735;
        }
        
        vehicle = ob_resource_manager::activity_spawn_vehicle( vehicle_ref, spawndata );
        assert( isdefined( vehicle ), "<dev string:x8d>" );
        vehicle.riders = [];
        vehicle.unloadque = [];
        vehicle.unload_group = "all";
        vehicledata = vehicle::get_data( self.var_7d7a32be78c7fc98[ index ].vehicleref );
        
        if ( !isdefined( vehicledata.ai ) || !vehicledata.ai.supportsai )
        {
            assertmsg( "<dev string:xbd>" + getxhashsourcename( self.var_7d7a32be78c7fc98[ index ].vehicleref ) );
        }
        
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
        
        precious_cargo_spawn_riders( self, self.convoydata[ index ], spawndata.origin, index, vehicle );
        assert( self.convoydata[ index ].var_20b91e17abb8a3a8.size > 0, "<dev string:xdf>" );
        
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
        vehicle.var_a5f34fcc4fb8b328 = 0;
        vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
        vehicle function_cc9426900a483604();
        vehicle thread function_5757dede554fe5c3( self );
        vehicle thread function_6e56f88af4c6cedd( self );
        vehicle thread ob_convoy_util::function_9ce1eb1748c8b4fa();
        
        if ( self.var_7d7a32be78c7fc98[ index ].istarget )
        {
            vehicle.istarget = 1;
            self.targetvehicle = vehicle;
            thread function_8106f0d394dba93c();
            vehicle thread precious_cargo_vehicle_death_watcher( self );
            vehicle thread function_dcf9f04b64ab6cb5( self );
        }
        
        vehiclearray[ vehiclearray.size ] = vehicle;
        waitframe();
    }
    
    self.targetvehicle.var_52dfac12181e4ef9 = self.targetvehicle vehicle_gettopspeedforward();
    self.targetvehicle.var_80f99dc346cf1422 = self.targetvehicle vehicle_gettopspeedreverse();
    thread function_d27264724f512efa();
    return vehiclearray;
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0x4df022cd, Offset: 0x27f0
// Size: 0x50, Type: bool
function function_d327ab4c0ad1af1( target, turretindex )
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

// Namespace ob_contract_precious_cargo
// Params 3
// Checksum 0x76ace5f6, Offset: 0x2849
// Size: 0x1cf
function function_cc9426900a483604( var_3c09ff595c6166a9 = 1, addpath = 1, var_d2b2b98d77c9c0 = 0 )
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
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 1 );
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

// Namespace ob_contract_precious_cargo
// Params 5
// Checksum 0x8da138dc, Offset: 0x2a20
// Size: 0x1d9
function precious_cargo_spawn_riders( activityinstance, convoydata, origin, vehicleindex, vehicle )
{
    assert( vehicleindex >= 0 && vehicleindex < activityinstance.var_7d7a32be78c7fc98.size, "<dev string:xf4>" );
    convoydata.var_7cb62ed461d8c370 = activityinstance activity_ai_encounters::function_eb8506829193f5eb( activityinstance.var_7d7a32be78c7fc98[ vehicleindex ].riderencounter, origin, 128, 1, 0, 1, 2 );
    vehicle.var_7cb62ed461d8c370 = convoydata.var_7cb62ed461d8c370;
    function_c505198907e0d306( convoydata.var_7cb62ed461d8c370, vehicle );
    function_ef57f478f96b050c( convoydata.var_7cb62ed461d8c370, 1, 1 );
    
    if ( !isdefined( convoydata.var_c7c801fd0b2bf1ee ) )
    {
        convoydata.var_20b91e17abb8a3a8 = [];
    }
    
    if ( isdefined( convoydata.var_7cb62ed461d8c370 ) )
    {
        activityinstance activity_ai_encounters::function_52d1342183200a8f( convoydata.var_7cb62ed461d8c370, &function_762b9a7c99fd71c4, convoydata );
        function_64ac8c4e752f4dca( convoydata.var_7cb62ed461d8c370, 0 );
        activityinstance activity_ai_encounters::function_48582991402cac50( convoydata.var_7cb62ed461d8c370, 1 );
        ai_spawn_director::function_3ce5298df1143d67( "FinishedSpawningBucket", convoydata.var_7cb62ed461d8c370 );
        
        foreach ( agent in convoydata.var_20b91e17abb8a3a8 )
        {
            activityinstance.a_ai_convoy[ activityinstance.a_ai_convoy.size ] = agent;
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 4
// Checksum 0xbef4088e, Offset: 0x2c01
// Size: 0x74
function function_762b9a7c99fd71c4( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    
    if ( isalive( agent ) )
    {
        convoydata = userdata;
        agent.vehiclerunexit = 1;
        convoydata.var_20b91e17abb8a3a8[ convoydata.var_20b91e17abb8a3a8.size ] = agent;
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x25e28705, Offset: 0x2c7d
// Size: 0xde
function function_540e9915450e72bd()
{
    var_6e25320a09102b32 = self.varianttag + "_end_point_reinforcement_ground_1";
    self.var_3f53c52e152ba6f0 = activity_ai_encounters::function_92b671064b0b1ce2( var_6e25320a09102b32, 1, 0, 1, 2 );
    
    if ( self.var_3f53c52e152ba6f0 )
    {
        function_1a9d724a960fa19d( self.var_3f53c52e152ba6f0, "ground_1", 1 );
        ai_spawn_director::add_spawned_callback( self.var_3f53c52e152ba6f0, &function_c6c7b4ef713e5, [ self ] );
    }
    
    var_6e25310a091028ff = self.varianttag + "_end_point_reinforcement_ground_2";
    self.var_3f53c82e152bad89 = activity_ai_encounters::function_92b671064b0b1ce2( var_6e25310a091028ff, 1, 0, 1, 2 );
    
    if ( self.var_3f53c82e152bad89 )
    {
        function_1a9d724a960fa19d( self.var_3f53c82e152bad89, "ground_2", 1 );
        ai_spawn_director::add_spawned_callback( self.var_3f53c82e152bad89, &function_c6c7b4ef713e5, [ self ] );
    }
}

// Namespace ob_contract_precious_cargo
// Params 4
// Checksum 0x8c1afd89, Offset: 0x2d63
// Size: 0x5b
function function_c6c7b4ef713e5( requestid, userdata, agent, data )
{
    activity_instance = userdata[ 0 ];
    activity_instance.reinforce_ai[ activity_instance.reinforce_ai.size ] = agent;
    agent thread function_7f5352a2f8ddf6c6( activity_instance );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0xb50abb0c, Offset: 0x2dc6
// Size: 0x88
function function_7f5352a2f8ddf6c6( activity_instance )
{
    self endon( #"death" );
    self setstealthstate( "combat" );
    
    if ( activity_instance.playerparticipants.size > 0 )
    {
        var_95b86e61b2c6a7 = utility::array_random( activity_instance.playerparticipants );
        self getenemyinfo( var_95b86e61b2c6a7 );
        self.favoriteenemy = var_95b86e61b2c6a7;
        self forcethreatupdate();
    }
    
    ob_activity_utility::function_311417deee5b4c1c();
    thread ai_behavior::behavior_combatRushOrigin( self, activity_instance.end, 128, 64 );
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x8d0095b8, Offset: 0x2e56
// Size: 0xf6
function function_e2761ea797e3ee0d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"target_driver_down" );
    thread function_e5f5bc7cf6df68();
    
    if ( self.var_6659ca8173670617 == "EXIT_VEHICLE" )
    {
        utility::waittill_any( "vehicle_down", "under_attack", "precious_cargo_stuck" );
        function_169d636eb13de865();
        return;
    }
    
    if ( issubstr( self.var_6659ca8173670617, "KEEP_DRIVING" ) )
    {
        shouldboost = issubstr( self.var_6659ca8173670617, "_HIGH_SPEED" );
        
        while ( true )
        {
            msg = utility::waittill_any_in_array_return( [ "under_attack", "precious_cargo_stuck", "player_near_cargo" ] );
            
            if ( msg == "precious_cargo_stuck" )
            {
                function_169d636eb13de865();
                break;
            }
            
            if ( shouldboost )
            {
                shouldboost = 0;
                function_cd5847b7b71c2db3( self.highspeed );
            }
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0xd7b59fb4, Offset: 0x2f54
// Size: 0x75
function function_a7d0deda28edda56( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"entitydeleted" );
    activityinstance.vehicle waittill( #"vehicle_allow_use" );
    
    while ( self.preventleave )
    {
        wait 0.2;
    }
    
    self.readytoleave = 1;
    self notify( #"hash_8182ff35fd9e24b8" );
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x4d06c2cc, Offset: 0x2fd1
// Size: 0x117
function function_e5f5bc7cf6df68()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"player_near_cargo" );
    
    while ( true )
    {
        if ( !self.targetvehicle || self.targetvehicle vehicle::is_destroyed() )
        {
            break;
        }
        
        foreach ( player in self.playerparticipants )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( distance2dsquared( self.targetvehicle.origin, player.origin ) < 1000000 )
            {
                ob_activity_utility::function_894ac80e038636c5( "wcpvepreciouscconvoy" );
                self notify( #"player_near_cargo" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x493b8561, Offset: 0x30f0
// Size: 0x6c
function function_9eddf41fc064fc4e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.targetvehicle endon( #"death" );
    self.targetvehicle waittill( #"vehicle_allow_use" );
    self.end = function_c1f0a3e9ac3cd880( self.targetvehicle.origin );
    thread function_7173a491eb97d903();
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x8735d0a3, Offset: 0x3164
// Size: 0x288
function monitor_intercept()
{
    if ( !self.targetvehicle )
    {
        return;
    }
    
    foreach ( vehicle in self.a_vh_convoy )
    {
        vehicle physics_registerforcollisioncallback();
    }
    
    if ( getdvarint( @"hash_3a2d4f17dd9ba711", 1 ) )
    {
        /#
            self.targetvehicle thread ob_convoy_util::function_8f20be5c36d00164();
        #/
        
        save_chance = 0.2;
        
        switch ( self.difficulty_region )
        {
            case #"hash_af83e47edfa8900a":
                save_chance = 0.3;
                break;
            case #"hash_5343b465e56ec9a4":
                save_chance = 0.4;
                break;
            case #"hash_651f76c0ad6741ec":
                save_chance = 0.6;
                break;
            default:
                break;
        }
        
        foreach ( vehicle in self.a_vh_convoy )
        {
            if ( getdvarint( @"hash_bf1df78d1e7799fa", 1 ) )
            {
                vehicle.pit_config = { #save_chance:save_chance };
            }
            
            vehicle thread ob_convoy_util::function_4b9cb0a28bb6273f();
        }
        
        thread function_8d05c3a2f3ffa54e( self.targetvehicle );
    }
    
    thread monitor_intercept_low_speed( self.targetvehicle );
    utility::waittill_any( "activity_ended", "instance_destroyed", "precious_cargo_stuck", "precious_cargo_reach_goal", "target_driver_down" );
    
    if ( self.a_vh_convoy )
    {
        foreach ( vehicle in self.a_vh_convoy )
        {
            if ( !vehicle vehicle::is_husk() )
            {
                vehicle notify( #"stop_pit" );
                vehicle physics_unregisterforcollisioncallback();
            }
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 1, eflags: 0x4
// Checksum 0x80fdf0d6, Offset: 0x33f4
// Size: 0xdf
function private function_8d05c3a2f3ffa54e( vehicle )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"precious_cargo_stuck" );
    self endon( #"precious_cargo_reach_goal" );
    self endon( #"target_driver_down" );
    vehicle endon( #"death" );
    var_7cca01653297820b = 1000;
    
    while ( true )
    {
        vehicle waittill( #"pit_begin" );
        var_a3134a10ccbf4e13 = gettime();
        
        while ( true )
        {
            waitframe();
            var_ea0e1ee7c3381d4e = gettime() - var_a3134a10ccbf4e13;
            
            if ( var_ea0e1ee7c3381d4e >= var_7cca01653297820b )
            {
                break;
            }
            
            speedmph = vehicle vehicle_getspeed();
            
            if ( speedmph <= 3 )
            {
                self.stop_reason = "intercept_pit";
                self notify( #"precious_cargo_stuck" );
                return;
            }
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 1, eflags: 0x4
// Checksum 0xabe07adb, Offset: 0x34db
// Size: 0x13a
function private monitor_intercept_low_speed( vehicle )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"precious_cargo_stuck" );
    self endon( #"precious_cargo_reach_goal" );
    self endon( #"target_driver_down" );
    vehicle endon( #"death" );
    var_7cca01653297820b = 3000;
    var_d1e3bc7dcf76c225 = 8;
    
    while ( true )
    {
        vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        var_8e3652cb7d1ea936 = gettime();
        
        while ( true )
        {
            waitframe();
            speed = vehicle vehicle_getspeed();
            
            if ( speed > var_d1e3bc7dcf76c225 )
            {
                break;
            }
            
            var_ea0e1ee7c3381d4e = gettime() - var_8e3652cb7d1ea936;
            
            if ( var_ea0e1ee7c3381d4e >= var_7cca01653297820b )
            {
                self.stop_reason = "intercept_low_speed";
                self notify( #"precious_cargo_stuck" );
                return;
            }
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xcd4d3c71, Offset: 0x361d
// Size: 0x242
function function_bad6a34103e1a7af()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"precious_cargo_stuck" );
    self endon( #"precious_cargo_reach_goal" );
    self.targetvehicle endon( #"leavepath_unload" );
    wait 5;
    
    while ( !self.convoy_engaged )
    {
        if ( self.var_e814baa69305ee8a.traffic_paused )
        {
            wait 0.1;
            continue;
        }
        
        foreach ( vehicle in self.a_vh_convoy )
        {
            if ( isdefined( vehicle ) )
            {
                if ( !isdefined( vehicle.lastposition ) )
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
                }
                else
                {
                    vehicle.stucktime = 0;
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
                    self.stop_reason = "stuck";
                    self notify( #"precious_cargo_stuck" );
                }
                
                vehicle.lastposition = vehicle.origin;
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x4456f50c, Offset: 0x3867
// Size: 0x14d
function function_6e56f88af4c6cedd( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"unloaded" );
    
    while ( !isdefined( self.driver ) )
    {
        /#
            iprintln( "<dev string:x130>" );
        #/
        
        waitframe();
    }
    
    msg = utility::waittill_any_ents_return( self.driver, "death", self, "damage_heavy" );
    self notify( #"leavepath_unload" );
    thread function_62f5b4ce70e890c( activityinstance );
    
    if ( self.istarget )
    {
        foreach ( vehicle in activityinstance.a_vh_ground )
        {
            if ( vehicle != self && vehicle.riders )
            {
                vehicle thread function_62f5b4ce70e890c( activityinstance );
            }
        }
        
        activityinstance notify( #"target_driver_down" );
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x5b2d4b72, Offset: 0x39bc
// Size: 0x8e
function precious_cargo_vehicle_death_watcher( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"entitydeleted" );
    self waittill( #"death" );
    earthquake( 0.5, 1, self.origin, 1500 );
    
    if ( activityinstance.type == "REV_OB_CONTRACT_PRECIOUS_CARGO" )
    {
        activityinstance ob_activity_utility::function_894ac80e038636c5( "wcpvepreciouscargofail", undefined, undefined, undefined, undefined, &function_a3639c2dca24c91e );
        activityinstance function_53995ed9b5653fc4();
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x63139dcd, Offset: 0x3a52
// Size: 0x107
function function_dcf9f04b64ab6cb5( activityinstance )
{
    activityinstance endon( #"instance_destroyed" );
    self endon( #"entitydeleted" );
    
    while ( !self.target_vehicle_gunner )
    {
        waitframe();
        
        foreach ( rider in self.riders )
        {
            if ( rider.using_vehicle_turret )
            {
                self.target_vehicle_gunner = rider;
                break;
            }
        }
    }
    
    self.target_vehicle_gunner endon( #"death" );
    self waittill( #"player_enter_vehicle" );
    
    if ( self.target_vehicle_gunner.using_vehicle_turret )
    {
        self.target_vehicle_gunner kill();
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x787044ad, Offset: 0x3b61
// Size: 0x5c
function function_fd1b700f7887418b( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self waittill( #"death" );
    activityinstance notify( #"vtol_destroyed" );
    activityinstance ob_activity_utility::function_894ac80e038636c5( "directhit" );
    activityinstance.var_f4a8e02d94ead646 = 1;
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x6e771dad, Offset: 0x3bc5
// Size: 0x1c5
function function_5757dede554fe5c3( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"leavepath_unload" );
    self endon( #"engage" );
    var_2747cdcc610c7fd4 = [];
    n_distance = 16000000;
    activityinstance.var_35f3ffa518fd410e = 0;
    
    while ( true )
    {
        if ( self.isdestroyed )
        {
            return;
        }
        
        self waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( attacker ) && distancesquared( self.origin, attacker.origin ) <= n_distance && !activityinstance.var_35f3ffa518fd410e )
        {
            activityinstance notify( #"under_attack" );
            activityinstance.var_35f3ffa518fd410e = 1;
        }
        
        var_2f393a8537efceb6 = getdvarfloat( @"hash_6ba964aebf3a05d4", 0.75 );
        
        if ( self.health < self.maxhealth * var_2f393a8537efceb6 )
        {
            self notify( #"damage_heavy" );
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_contract_precious_cargo
// Params 0, eflags: 0x4
// Checksum 0x199c9e43, Offset: 0x3d92
// Size: 0x60c
function private function_3cbef36e9c2b2966()
{
    self notify( #"hash_a95f0a22266b696f" );
    self endon( #"hash_a95f0a22266b696f" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"unloaded" );
    self endon( #"precious_cargo_stuck" );
    self endon( #"precious_cargo_reach_goal" );
    assert( isdefined( self.a_vh_convoy ) );
    assert( isdefined( self.a_vh_ground ) );
    assert( isdefined( self.n_veh_speed ) );
    
    while ( self.a_vh_ground.size > 1 )
    {
        self.a_vh_ground = function_5713d46873b29625( self.a_vh_ground );
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
                    print3d( convoyvehicles[ index ].origin, "<dev string:x14a>" + convoyvehicles[ index ].veh_speed + "<dev string:x14b>" + self.n_veh_speed, ( 1, 1, 1 ), 1, 1, 1, 1 );
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
                        
                        if ( index > 1 && isdefined( convoyvehicles[ index - 1 ].p2p_speed ) )
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

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xf94f8e77, Offset: 0x43a6
// Size: 0x531
function function_7173a491eb97d903()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.targetvehicle vehicleshowonminimap( 1 );
    self.targetvehicle.godmode = 0;
    self.targetvehicle utility::ent_flag_init( self.type );
    areaorigin = self.targetvehicle.origin;
    techodriver = undefined;
    
    while ( !isdefined( techodriver ) || !arraycontains( self.playerparticipants, techodriver ) )
    {
        techodriver = vehicle_occupancy::get_driver( self.targetvehicle, 1 );
        wait 0.1;
    }
    
    self.targetvehicle notify( #"hash_832af53d22232490" );
    objidpoolmanager::update_objective_position( self.var_21fb6576cbe2a679, self.end.origin );
    objidpoolmanager::objective_set_play_intro( self.var_21fb6576cbe2a679, 1 );
    objidpoolmanager::update_objective_description( self.var_21fb6576cbe2a679, &"sat_ob_activities/objective_extraction_point" );
    ob_contract_ui_widget::function_33c02efd4a127b9e( 1, self.playerparticipants );
    self.target = self.targetvehicle;
    function_64270a334c6a4029( undefined, 150 );
    
    foreach ( occupant in self.targetvehicle.occupants )
    {
        objidpoolmanager::objective_playermask_hidefrom( self.targetvehicle.var_ebc1fba7906655b0, occupant );
    }
    
    while ( isdefined( self.targetvehicle ) && distance2dsquared( self.targetvehicle.origin, areaorigin ) < 2250000 )
    {
        wait 0.1;
    }
    
    self.teams = [ self.playerparticipants[ 0 ].team ];
    var_1d847054e3aef4b0 = { #var_606f01dce2492f65:1, #var_cec48ccf7bfb7369:1, #hashighvis:1, #isattacking:1, #var_24954f14e27b448d:1, #maxhealth:getdvarint( @"hash_9c5e5c8918697acd", 8100 ), #target:self.targetvehicle, #spawnpoint:( self.targetvehicle.origin + self.end.origin ) * 0.5 };
    self.enemyvtol = self [[ self.vtoldata.spawn ]]( var_1d847054e3aef4b0 );
    self.enemyvtol.var_7b10f1c2e1202450 = 1;
    self.enemyvtol.var_b3dff6739efc2294 = 120;
    self.enemyvtol thread [[ self.vtoldata.var_2f436ee6869ef2b2 ]]( self.playerparticipants[ 0 ], 1, "ob_precious_cargo_end_point_marker" );
    objidpoolmanager::update_objective_description( self.enemyvtol.vtolid, &"sat_ob_activities/objective_guild_vtol" );
    self.enemyvtol thread function_fd1b700f7887418b( self );
    self.enemyvtol vehicle_turnengineon();
    self.targetvehicle.var_2e2ed02cfb0c625d = techodriver.team;
    self.targetvehicle makeentitysentient( self.targetvehicle.var_2e2ed02cfb0c625d );
    self.targetvehicle makeentitynomeleetarget();
    thread function_9c0070abe94f450f();
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_21fb6576cbe2a679 );
    self.var_21fb6576cbe2a679 = undefined;
    self.targetvehicle.chased = 1;
    
    foreach ( occupant in self.targetvehicle.occupants )
    {
        objidpoolmanager::objective_playermask_hidefrom( self.targetvehicle.var_ebc1fba7906655b0, occupant );
    }
    
    wait 2;
    ob_activity_utility::function_894ac80e038636c5( "wcpvepreciouscargovtol" );
    thread function_f6864b43200e8768();
    self waittill( #"cargo_delivered" );
    
    if ( isdefined( self.targetvehicle ) )
    {
        function_b7c1479decde7d2( self.targetvehicle, 0 );
        self.targetvehicle vehicleshowonminimap( 0 );
        self.targetvehicle utility::ent_flag_init( "cargo_delivered" );
    }
    
    ob_activity_utility::function_894ac80e038636c5( "wcpvepreciouscarsuccess", undefined, undefined, undefined, undefined, &function_a3639c2dca24c91e );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x5b9f69a6, Offset: 0x48df
// Size: 0x37
function function_a3639c2dca24c91e( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcpvepreciouscarsuccess_voss" || var_73f4f05f29c6770a == "wcpvepreciouscargofail_voss" )
    {
        return [ "wcpvepreciouscargoclapback", "wcpveprcscargolastword" ];
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x98870f53, Offset: 0x491f
// Size: 0x1c2
function function_c1f0a3e9ac3cd880( start )
{
    destinations = utility::get_array_of_closest( start, level.var_ed667fc31da4622e, undefined, undefined, 40000, 15000 );
    
    if ( destinations.size > 0 )
    {
        destinations = arrayrandomize( destinations );
        
        foreach ( dest in destinations )
        {
            if ( self.difficulty_region == region_difficulty_manager::get_region_difficulty( dest.origin ) && is_end_point_valid( dest ) )
            {
                dest.inuse = 1;
                return dest;
            }
        }
    }
    
    var_17d135168fb0b8c5 = 10000;
    destinations = utility::get_array_of_closest( start, level.var_ed667fc31da4622e, undefined, undefined, 40000 + var_17d135168fb0b8c5, 15000 - var_17d135168fb0b8c5 );
    destinations = arrayrandomize( destinations );
    
    foreach ( dest in destinations )
    {
        if ( self.difficulty_region == region_difficulty_manager::get_region_difficulty( dest.origin ) && is_end_point_valid( dest ) )
        {
            dest.inuse = 1;
            return dest;
        }
    }
    
    return utility::array_random( level.var_ed667fc31da4622e );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x12aeac7b, Offset: 0x4aea
// Size: 0x4d, Type: bool
function is_end_point_valid( endpoint )
{
    if ( endpoint.inuse )
    {
        return false;
    }
    
    possible_barricades = entity::getentitiesinradius( endpoint.origin, 120, undefined, undefined, trace::create_vehicle_contents() );
    
    if ( possible_barricades.size )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_contract_precious_cargo
// Params 5
// Checksum 0x258e9ca1, Offset: 0x4b40
// Size: 0xac
function function_97236387ca88aed3( start, var_9d5b4b250824f655, dests, mindist, maxdist )
{
    var_280cc49c9a8ad043 = start + var_9d5b4b250824f655 * 10000;
    destinations = utility::get_array_of_closest( var_280cc49c9a8ad043, dests, undefined, undefined, maxdist, mindist );
    
    if ( destinations.size > 0 )
    {
        return destinations[ 0 ];
    }
    
    if ( !isdefined( self.enemyend ) )
    {
        var_17d135168fb0b8c5 = 10000;
        destinations = utility::get_array_of_closest( var_280cc49c9a8ad043, level.var_787c5800cfc5bec9, undefined, undefined, maxdist + var_17d135168fb0b8c5, mindist - var_17d135168fb0b8c5 );
        
        if ( destinations.size > 0 )
        {
            return destinations[ 0 ];
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0x53796560, Offset: 0x4bf4
// Size: 0x60
function function_523f458d517fee35( offsets, axes )
{
    x_axis = axes[ "forward" ];
    y_axis = axes[ "right" ];
    var_50f0a8bfb3128a6c = axes[ "up" ];
    return offsets[ 0 ] * x_axis + offsets[ 1 ] * y_axis + offsets[ 2 ] * var_50f0a8bfb3128a6c;
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x7ffb6af2, Offset: 0x4c5d
// Size: 0x7b
function function_f71d093ed802d1d0()
{
    foreach ( center in self.encounter_centers )
    {
        function_b73e90ada04d3c5( center );
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x19c167f5, Offset: 0x4ce0
// Size: 0x8b
function function_b73e90ada04d3c5( center )
{
    var_a4c086caa1cbfd68 = "ai_encounter:" + center.script_noteworthy;
    requestid = activity_ai_encounters::function_eb8506829193f5eb( var_a4c086caa1cbfd68, center.origin, center.radius, 1, 0, 1, 0 );
    
    if ( isdefined( requestid ) )
    {
        function_1a9d724a960fa19d( requestid, center.script_parameters, 1 );
        activity_ai_encounters::function_52d1342183200a8f( requestid, &function_48065f055eb47aca, [ self, center ] );
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x304d329d, Offset: 0x4d73
// Size: 0x49
function function_17fdfda41f9aa95a( params )
{
    if ( self.var_aeba340c898b16db )
    {
        if ( isdefined( self.attractor ) )
        {
            if ( isplayer( params.eattacker ) )
            {
                zombie_attractor_manager::remove_attractor( self.attractor );
            }
        }
    }
    
    return -1;
}

// Namespace ob_contract_precious_cargo
// Params 4
// Checksum 0xe7ef7536, Offset: 0x4dc5
// Size: 0x98
function function_48065f055eb47aca( requestid, userdata, agent, data )
{
    activity = userdata[ 0 ];
    center = userdata[ 1 ];
    agent endon( #"death" );
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    
    if ( isalive( agent ) )
    {
        activity thread function_ab5e30fc49e7e86( agent );
        activity.numagents += 1;
    }
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0x4a94b387, Offset: 0x4e65
// Size: 0x69
function function_e753903a81ddb43e( agent, center )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    agent endon( #"death" );
    
    if ( center )
    {
        agent setstealthstate( "hunt" );
        agent forcethreatupdate();
        agent.angles = center.angles;
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x259ac3de, Offset: 0x4ed6
// Size: 0x47
function function_ab5e30fc49e7e86( agent )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    agent waittill( #"death" );
    self.numagents -= 1;
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0x266b62c, Offset: 0x4f25
// Size: 0x67, Type: bool
function precious_cargo_validator( attractor, zombie )
{
    if ( isdefined( zombie.var_bd22ba6c600a23a3 ) )
    {
        return false;
    }
    
    if ( isdefined( zombie.enemy ) )
    {
        return false;
    }
    
    if ( isalive( zombie ) && isdefined( attractor ) )
    {
        zombie.var_aeba340c898b16db = 1;
        zombie.attractor = attractor;
        return true;
    }
    
    return false;
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xccb3529c, Offset: 0x4f95
// Size: 0x78
function function_8106f0d394dba93c()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.targetvehicle endon( #"death" );
    
    while ( true )
    {
        wait 1;
        
        if ( self.targetvehicle.health < self.targetvehicle.maxhealth / 4 )
        {
            thread ob_activity_utility::function_894ac80e038636c5( "wcpvepreciouscargoheavyda" );
            break;
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x345d0880, Offset: 0x5015
// Size: 0xee
function function_d27264724f512efa()
{
    level endon( #"game_ended" );
    self endon( #"cargo_delivered" );
    self.targetvehicle endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_8cf54a11b36b099a = 0;
    
    while ( true )
    {
        if ( isdefined( self.targetvehicle ) && isdefined( self.targetvehicle.occupants ) )
        {
            driver = vehicle_occupancy::get_driver( self.targetvehicle, 1 );
            
            if ( isdefined( driver ) )
            {
                self.targetvehicle notify( #"player_enter_vehicle" );
                
                if ( !arraycontains( self.playerparticipants, driver ) )
                {
                    function_53995ed9b5653fc4();
                    return;
                }
                else if ( !var_8cf54a11b36b099a )
                {
                    ob_activity_utility::function_894ac80e038636c5( "wcpvepreccargdeliver" );
                    var_8cf54a11b36b099a = 1;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x5437f16f, Offset: 0x510b
// Size: 0x14e
function function_9c0070abe94f450f()
{
    level endon( #"game_ended" );
    self.targetvehicle endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_9eaddc66829ed9af = 0;
    var_590673e2ca0def9c = 40000;
    
    if ( isdefined( self.end.radius ) )
    {
        var_590673e2ca0def9c = self.end.radius * self.end.radius;
    }
    
    while ( true )
    {
        wait 0.1;
        has_arrived = distancesquared( self.targetvehicle.origin, self.end.origin ) <= var_590673e2ca0def9c;
        
        if ( has_arrived && self.var_f4a8e02d94ead646 )
        {
            if ( self.targetvehicle.var_ebc1fba7906655b0 )
            {
                namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.targetvehicle.var_ebc1fba7906655b0 );
                self.targetvehicle.var_ebc1fba7906655b0 = undefined;
            }
            
            vehicle_occupancy::eject_all_occupants( self.targetvehicle );
            break;
        }
    }
    
    waitframe();
    self notify( #"cargo_delivered" );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x2538f77b, Offset: 0x5261
// Size: 0x337
function function_eb150e7a907fc21f( activityinstance )
{
    self endon( #"death" );
    self endon( #"flyaway" );
    self.guardvehicle = undefined;
    var_8d8a136092f7362d = 40;
    firerate = 0.125;
    
    while ( true )
    {
        players = activityinstance.playerparticipants;
        
        if ( players )
        {
            foreach ( player in players )
            {
                if ( player::isaliveandnotinlaststand( player ) )
                {
                    results = trace::ray_trace( self.origin, player.origin, [ self, self.turret, self.var_795c9a23417e649c, self.var_bf973a4d1cadadc9, self.guardvehicle ] );
                    
                    if ( distance( results[ "position" ], player.origin ) < 100 )
                    {
                        if ( namespace_cf9a4f547edbca10::function_43ac45f2bf4fe748( player.origin ) )
                        {
                            shots = 0;
                            accumulatedtime = 0;
                            totaltime = 0;
                            self.turret.targetent.origin = player.origin;
                            
                            while ( shots < var_8d8a136092f7362d && player::isaliveandnotinlaststand( player ) )
                            {
                                if ( totaltime > 5 )
                                {
                                    break;
                                }
                                
                                if ( self.health <= 0 )
                                {
                                    return;
                                }
                                
                                self setlookatent( player );
                                
                                if ( namespace_cf9a4f547edbca10::function_43ac45f2bf4fe748( player.origin ) )
                                {
                                    results = trace::ray_trace( self.origin, player.origin, [ self, self.turret, self.var_795c9a23417e649c, self.var_bf973a4d1cadadc9, self.guardvehicle ] );
                                    
                                    if ( distance( results[ "position" ], player.origin ) < 100 )
                                    {
                                        self.turret.targetent.origin = player.origin;
                                        
                                        if ( self.turret turretcantarget( self.turret.targetent.origin ) )
                                        {
                                            self.turret snaptotargetentity( self.turret.targetent );
                                        }
                                        
                                        accumulatedtime += level.framedurationseconds;
                                        
                                        while ( accumulatedtime > 0 )
                                        {
                                            accumulatedtime -= firerate;
                                            self.turret shootturret();
                                            shots++;
                                        }
                                    }
                                }
                                
                                totaltime += level.framedurationseconds;
                                waitframe();
                            }
                            
                            wait 3;
                        }
                    }
                    
                    break;
                }
            }
            
            waitframe();
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 2, eflags: 0x4
// Checksum 0xc404c4f4, Offset: 0x55a0
// Size: 0x59
function private function_99e7cf90c59368fe( currenthealth, maxhealth )
{
    percentagecomplete = currenthealth / maxhealth * 100;
    var_4168e1b0a662402e = clamp( percentagecomplete, 0, 100 );
    var_4168e1b0a662402e = int( var_4168e1b0a662402e );
    ob_contract_ui_widget::function_572260f3b30f1e52( 1, var_4168e1b0a662402e, 100, self.playerparticipants );
}

// Namespace ob_contract_precious_cargo
// Params 0, eflags: 0x4
// Checksum 0xa2794c81, Offset: 0x5601
// Size: 0x88
function private function_cd573ddaafcb5653()
{
    start_health = self.enemyvtol.health;
    function_99e7cf90c59368fe( start_health, start_health );
    
    while ( true )
    {
        msg = self.enemyvtol utility::waittill_any_return( "damage", "death", "explode", "crashing" );
        function_99e7cf90c59368fe( self.enemyvtol.health, start_health );
        
        if ( msg != "damage" )
        {
            return;
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x366d4cab, Offset: 0x5691
// Size: 0x1c6
function function_f6864b43200e8768()
{
    level endon( #"game_ended" );
    self.targetvehicle endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_contract_ui_widget::function_724ff866fa7fb742( "REV_OB_CONTRACT_PRECIOUS_CARGO_DESTROY_CHASING_VEHICLE" );
    ob_contract_ui_widget::function_33c02efd4a127b9e( 0, self.playerparticipants );
    childthread function_cd573ddaafcb5653();
    self.enemyvtol waittill( #"death" );
    ob_contract_ui_widget::function_33c02efd4a127b9e( 1, self.playerparticipants );
    assert( !self.var_21fb6576cbe2a679 );
    self.var_21fb6576cbe2a679 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "ob_precious_cargo_end_point_marker", 0, 1 );
    objidpoolmanager::update_objective_position( self.var_21fb6576cbe2a679, self.end.origin );
    objidpoolmanager::update_objective_description( self.var_21fb6576cbe2a679, &"sat_ob_activities/objective_extraction_point" );
    self.targetvehicle.chased = 0;
    
    foreach ( player in self.playerparticipants )
    {
        if ( arraycontains( self.targetvehicle.occupants, player ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.targetvehicle.var_ebc1fba7906655b0, player );
            continue;
        }
        
        objidpoolmanager::objective_playermask_addshowplayer( self.targetvehicle.var_ebc1fba7906655b0, player );
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x5f6b04b8, Offset: 0x585f
// Size: 0x101
function function_6960c78676d73a75()
{
    camp_locations = utility::getstructarray( "agent_camp", "targetname" );
    self.var_1f52d9d308723a1c = [];
    
    if ( camp_locations )
    {
        foreach ( camp in camp_locations )
        {
            var_4764b4b3131cd907 = string( self.targetvehicle.var_ebc1fba7906655b0 ) + camp.targetname + "_" + camp.script_noteworthy;
            function_1c4c7ef874191be2( var_4764b4b3131cd907, camp.origin, 3000, 1 );
            self.var_1f52d9d308723a1c[ self.var_1f52d9d308723a1c.size ] = var_4764b4b3131cd907;
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xb02ab0e4, Offset: 0x5968
// Size: 0x1d
function function_ff10e052bbd1394()
{
    if ( isdefined( self.last_objective_name ) )
    {
        function_71799ce2c69ce5a9( self.last_objective_name );
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xbe281906, Offset: 0x598d
// Size: 0x50
function precious_cargo_setup_cover()
{
    self endon( #"activity_ended" );
    msg = self.varianttag + "_setup_cover";
    level notify( msg );
    var_edd0cb6e9ee724e9 = "cargo_cover_" + self.varianttag;
    function_a315cc5d1dee425a( var_edd0cb6e9ee724e9 );
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0xb7c71b13, Offset: 0x59e5
// Size: 0x4d
function function_a315cc5d1dee425a( var_ffa9ec4fe50962c4, var_f2e5e4db54322ef6 )
{
    var_9619e4874be30e30 = utility::getstructarray( var_ffa9ec4fe50962c4, "targetname" );
    
    if ( var_9619e4874be30e30.size == 0 )
    {
        return var_9619e4874be30e30;
    }
    
    self.pending_cover_structs = var_9619e4874be30e30;
    thread function_56b5a3f3b79c11a3( var_f2e5e4db54322ef6 );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0xda63d19, Offset: 0x5a3a
// Size: 0x1ac
function function_56b5a3f3b79c11a3( var_f2e5e4db54322ef6 )
{
    self endon( #"activity_ended" );
    self.scriptable_covers = [];
    
    while ( self.pending_cover_structs.size > 0 )
    {
        var_1a92cc9f15bf3d19 = [];
        
        foreach ( cover in self.pending_cover_structs )
        {
            foreach ( player in level.players )
            {
                cansee = player trace::can_see_origin( cover.origin + ( 0, 0, 50 ), undefined, undefined, undefined, 0 );
                
                if ( cansee )
                {
                    var_1a92cc9f15bf3d19[ var_1a92cc9f15bf3d19.size ] = cover;
                    break;
                }
            }
        }
        
        okay_cover_structs = arrayremove( self.pending_cover_structs, var_1a92cc9f15bf3d19 );
        ob_soldier_util::function_ae8fc52786f384b7( okay_cover_structs, var_f2e5e4db54322ef6 );
        self.scriptable_covers = arraycombine( self.scriptable_covers, okay_cover_structs );
        self.pending_cover_structs = var_1a92cc9f15bf3d19;
        wait 3;
    }
    
    waitframe();
    ob_activity_utility::ob_enable_cover_nodes();
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0xfad69df9, Offset: 0x5bee
// Size: 0x1c3
function function_3604220db3a0a0cf( scriptable_covers, activity_instance )
{
    level endon( #"game_end" );
    msg = activity_instance.varianttag + "_setup_cover";
    level endon( msg );
    
    if ( scriptable_covers.size )
    {
        while ( scriptable_covers.size > 0 )
        {
            var_1a92cc9f15bf3d19 = [];
            
            foreach ( cover in scriptable_covers )
            {
                foreach ( player in level.players )
                {
                    cansee = player trace::can_see_origin( cover.origin + ( 0, 0, 50 ), undefined, undefined, undefined, 0 );
                    inrange = distancesquared( player.origin, cover.origin ) < 25000000;
                    
                    if ( cansee || inrange )
                    {
                        var_1a92cc9f15bf3d19[ var_1a92cc9f15bf3d19.size ] = cover;
                        break;
                    }
                }
            }
            
            okay_cover_structs = arrayremove( scriptable_covers, var_1a92cc9f15bf3d19 );
            ob_soldier_util::function_3604220db3a0a0cf( okay_cover_structs );
            scriptable_covers = var_1a92cc9f15bf3d19;
            wait 3;
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0x264858aa, Offset: 0x5db9
// Size: 0xc7
function function_d99c3d25ec4c8974( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    var_6faf532ba54370ae = activityinstance.nd_spline_start;
    nodeindex = getvehiclenodeindex( var_6faf532ba54370ae.targetname, #targetname );
    
    if ( isdefined( self ) )
    {
        self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( activityinstance.n_veh_speed ) );
        self.p2p_speed = activityinstance.n_veh_speed;
        self function_eb88c4e66edbc855( "path", "radiantId", nodeindex );
        self vehicle_turnengineon();
        thread function_b5e9532f9f9d07c2( var_6faf532ba54370ae, activityinstance );
    }
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0xea0f589, Offset: 0x5e88
// Size: 0x15e
function function_b5e9532f9f9d07c2( node, activityinstance )
{
    assert( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x14d>" );
    self notify( #"newpath" );
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    self endon( #"newpath" );
    self endon( #"death" );
    activityinstance endon( #"precious_cargo_reach_goal" );
    pathpoint = pathstart;
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = vehicle_paths::get_path_getfunc( pathstart );
    dist_sq = 40000;
    
    while ( isdefined( nextpoint ) )
    {
        if ( !isstruct( nextpoint ) )
        {
            vehicle_paths::node_wait( nextpoint, lastpoint, get_func );
        }
        else
        {
            vehicle_paths::struct_wait( nextpoint, lastpoint, dist_sq );
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        vehicle_paths::trigger_process_node( nextpoint );
        self.currentnode = nextpoint;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        lastpoint = nextpoint;
        nextpoint = get_nextpoint( get_func, nextpoint );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            break;
        }
    }
    
    activityinstance notify( #"precious_cargo_reach_goal" );
}

// Namespace ob_contract_precious_cargo
// Params 0, eflags: 0x4
// Checksum 0x86ddc00e, Offset: 0x5fee
// Size: 0xc6
function private function_baf97f43dcf03e72()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"unloaded" );
    self endon( #"precious_cargo_stuck" );
    self waittill( #"precious_cargo_reach_goal" );
    
    foreach ( vehicle in self.a_vh_convoy )
    {
        vehicle notify( #"reached_dynamic_path_end" );
        vehicle thread function_bfe8c35fbb6bc63c( self );
    }
}

// Namespace ob_contract_precious_cargo
// Params 2, eflags: 0x4
// Checksum 0x804ffbe0, Offset: 0x60bc
// Size: 0x8a
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
    
    if ( !isdefined( next_point ) )
    {
        assertmsg( "<dev string:x172>" + point.origin );
    }
    
    return next_point;
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0x8bbec273, Offset: 0x614f
// Size: 0xfb
function function_cd5847b7b71c2db3( speed, b_ground_only = 1 )
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
        
        if ( vehicle hascomponent( "p2p" ) )
        {
            vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speed ) );
            vehicle.p2p_speed = speed;
            continue;
        }
        
        vehicle vehicle_setspeed( speed );
    }
}

// Namespace ob_contract_precious_cargo
// Params 1, eflags: 0x4
// Checksum 0xdb12f5a3, Offset: 0x6252
// Size: 0x162
function private function_e94532ee2156b562( activityinstance )
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
    function_bfe8c35fbb6bc63c( activityinstance );
}

// Namespace ob_contract_precious_cargo
// Params 0, eflags: 0x4
// Checksum 0x7cb75a9c, Offset: 0x63bc
// Size: 0x175
function private function_169d636eb13de865()
{
    var_22f2ba557caf1adf = self.a_vh_convoy;
    self.convoy_engaged = 1;
    
    /#
        if ( getdvarint( @"hash_959bc8918394ee37", 0 ) )
        {
            debugstar( self.targetvehicle.origin, ( 1, 1, 1 ), 2000, "<dev string:x1c6>" + self.stop_reason, 1 );
        }
    #/
    
    if ( self.stop_reason == "intercept_pit" )
    {
        var_4fd5817efcea9acc = randomfloatrange( level.framedurationseconds, 0.5 );
        wait var_4fd5817efcea9acc;
        self.targetvehicle notify( #"engage" );
        self.targetvehicle thread function_bfe8c35fbb6bc63c( self, randomfloatrange( 1, 2 ) );
    }
    
    foreach ( vehicle in var_22f2ba557caf1adf )
    {
        if ( !vehicle.var_a5f34fcc4fb8b328 )
        {
            vehicle notify( #"engage" );
            vehicle thread function_e94532ee2156b562( self );
        }
        
        n_wait = randomfloatrange( 0.5, 1.1 );
        wait n_wait;
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0xa1561c47, Offset: 0x6539
// Size: 0x160
function function_9ea59fa73c0eb978()
{
    foreach ( rider in self.riders )
    {
        if ( !utility::is_dead_or_dying( rider ) )
        {
            rider thread ob_activity_utility::function_798aace978e876b();
            turret = rider getturret();
            
            if ( isdefined( turret ) )
            {
                if ( utility::flag( "stealth_enabled" ) && isdefined( rider.stealth ) && rider.stealth_enabled )
                {
                    rider setstealthstate( "combat" );
                }
            }
            else
            {
                if ( !isdefined( rider.vehicle_position ) && isdefined( rider.script_startingposition ) )
                {
                    rider.vehicle_position = rider.script_startingposition;
                }
                
                if ( isdefined( rider.vehicle_position ) )
                {
                    rider thread function_5d73206d6d0c0fa4( self.origin );
                    thread vehicle_aianim::guy_unload( rider, rider.vehicle_position );
                }
            }
            
            n_wait = randomfloatrange( 0.2, 0.3 );
            wait n_wait;
        }
    }
}

// Namespace ob_contract_precious_cargo
// Params 2, eflags: 0x4
// Checksum 0xc9e90352, Offset: 0x66a1
// Size: 0x1af
function private function_bfe8c35fbb6bc63c( activityinstance, time_to_wait )
{
    self endon( #"death" );
    
    if ( self.var_a5f34fcc4fb8b328 )
    {
        return;
    }
    
    self.var_a5f34fcc4fb8b328 = 1;
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
    
    if ( activityinstance.var_e814baa69305ee8a )
    {
        activityinstance.var_e814baa69305ee8a.vehicles = arrayremove( activityinstance.var_e814baa69305ee8a.vehicles, self );
    }
    
    self vehphys_parkingbrake( 1 );
    
    if ( time_to_wait )
    {
        wait time_to_wait;
    }
    else
    {
        waitframe();
    }
    
    if ( self.riders.size )
    {
        if ( activityinstance.var_8c0b9efa3145cbb4 )
        {
            function_64ac8c4e752f4dca( self.var_7cb62ed461d8c370, 1 );
            activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_7cb62ed461d8c370 );
        }
        
        function_9ea59fa73c0eb978();
        self endon( #"death" );
        utility::waittill_notify_or_timeout( "unloaded", 8 );
        ob_convoy_util::ob_spawn_cover_nodes();
        thread ob_convoy_util::function_8d8088d29dcb67a2();
    }
    
    self.var_1f9d76cca64c48f6 = undefined;
    utility::self_func( "vehicleClearAnims" );
    vehicle_occupancy::set_team( self, "neutral" );
    self notify( #"vehicle_allow_use" );
    activityinstance function_b7c1479decde7d2( self, 1 );
    self vehicleclearanims();
    self vehphys_parkingbrake( 0 );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0xe67f54be, Offset: 0x6858
// Size: 0x2c4
function function_62f5b4ce70e890c( activityinstance )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    
    if ( self.var_a5f34fcc4fb8b328 )
    {
        return;
    }
    
    self.var_a5f34fcc4fb8b328 = 1;
    b_last_vehicle = 0;
    
    if ( self.script_index == activityinstance.a_vh_ground.size - 1 )
    {
        b_last_vehicle = 1;
    }
    
    crash_speed = activityinstance.slowspeed;
    var_b363a8cdd38c8d76 = 192;
    
    /#
        iprintln( "<dev string:x1d5>" );
    #/
    
    var_8c8c13c3c3a794e1 = randomfloatrange( 10, 20 );
    var_21de78005a63c185 = utility::cointoss() ? -1 * var_8c8c13c3c3a794e1 : var_8c8c13c3c3a794e1;
    var_287dd1eda5e53859 = ( var_b363a8cdd38c8d76, 0, 0 );
    var_bfa40987498bbd16 = self.angles + ( 0, var_21de78005a63c185, 0 );
    var_84fbfb33b1b6b884 = self.origin + rotatevector( var_287dd1eda5e53859, var_bfa40987498bbd16 );
    var_84fbfb33b1b6b884 = getgroundposition( var_84fbfb33b1b6b884, 128 );
    self notify( #"path_updated" );
    self stoppath();
    self removecomponent( "path" );
    
    if ( activityinstance.var_e814baa69305ee8a )
    {
        activityinstance.var_e814baa69305ee8a.vehicles = arrayremove( activityinstance.var_e814baa69305ee8a.vehicles, self );
    }
    
    waitframe();
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
    self function_eb88c4e66edbc855( "p2p", "automaticFast", 1 );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( crash_speed ) );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", var_84fbfb33b1b6b884 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 50 );
    self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
    utility::waittill_any_timeout( 5, "goal", "near_goal", "path_blocked" );
    self removecomponent( "p2p" );
    waitframe();
    activityinstance notify( #"vehicle_down" );
    
    if ( self.riders.size )
    {
        if ( activityinstance.var_8c0b9efa3145cbb4 )
        {
            function_64ac8c4e752f4dca( self.var_7cb62ed461d8c370, 1 );
            activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_7cb62ed461d8c370 );
        }
        
        function_9ea59fa73c0eb978();
        self endon( #"death" );
        utility::waittill_notify_or_timeout( "unloaded", 8 );
        ob_convoy_util::ob_spawn_cover_nodes();
        thread ob_convoy_util::function_8d8088d29dcb67a2();
    }
    
    utility::self_func( "vehicleClearAnims" );
    vehicle_occupancy::set_team( self, "neutral" );
    self notify( #"vehicle_allow_use" );
    activityinstance function_b7c1479decde7d2( self, 1 );
}

// Namespace ob_contract_precious_cargo
// Params 1
// Checksum 0xa9505a94, Offset: 0x6b24
// Size: 0x64
function function_5d73206d6d0c0fa4( var_465b20e0d8be9bfd )
{
    self endon( #"death" );
    self waittill( #"unload" );
    
    if ( utility::flag( "stealth_enabled" ) && isdefined( self.stealth ) && self.stealth_enabled )
    {
        self setstealthstate( "combat" );
    }
    
    self setgoalpos( var_465b20e0d8be9bfd, 750 );
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0x377ff0e3, Offset: 0x6b90
// Size: 0xcf
function function_64270a334c6a4029( objectivebundle, objectivezoffset )
{
    self.targetvehicle.var_ebc1fba7906655b0 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( objectivebundle ?? "ob_precious_cargo_end_point_marker", 0, 1 );
    
    if ( !objectivebundle )
    {
        objidpoolmanager::update_objective_description( self.targetvehicle.var_ebc1fba7906655b0, &"sat_ob_activities/objective_cargo_vehicle" );
    }
    else
    {
        objidpoolmanager::update_objective_description( self.targetvehicle.var_ebc1fba7906655b0, &"sat_ob_activities/objective_supply_truck" );
    }
    
    objidpoolmanager::update_objective_onentity( self.targetvehicle.var_ebc1fba7906655b0, self.targetvehicle );
    
    if ( objectivezoffset )
    {
        objidpoolmanager::update_objective_setzoffset( self.targetvehicle.var_ebc1fba7906655b0, objectivezoffset );
    }
}

// Namespace ob_contract_precious_cargo
// Params 4
// Checksum 0x52fef8c3, Offset: 0x6c67
// Size: 0x9b
function function_4e6fda26f9b30aa2( var_8c953eb201608663, shouldping, objectivebundle, objectivezoffset )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 2.4;
    thread function_64270a334c6a4029( objectivebundle, objectivezoffset );
    
    if ( isdefined( var_8c953eb201608663 ) && shouldping )
    {
        wait 2;
        var_8c953eb201608663 calloutmarkerping::function_5d7b7302e94b97c2( self.targetvehicle.var_ebc1fba7906655b0, self.targetvehicle.origin + ( 0, 0, 60 ) );
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x72c55f43, Offset: 0x6d0a
// Size: 0x5d
function function_80d66fe79213cedd()
{
    self.var_21fb6576cbe2a679 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "ob_precious_cargo_end_point_marker", 0, 1 );
    objidpoolmanager::update_objective_onentity( self.var_21fb6576cbe2a679, self.targetvehicle );
    objidpoolmanager::update_objective_setzoffset( self.var_21fb6576cbe2a679, 150 );
    objidpoolmanager::update_objective_description( self.var_21fb6576cbe2a679, &"sat_ob_activities/objective_cargo_vehicle" );
}

// Namespace ob_contract_precious_cargo
// Params 2
// Checksum 0x1786f74d, Offset: 0x6d6f
// Size: 0x7c
function function_1277462f658ec78e( var_8c953eb201608663, shouldping )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 2.4;
    thread function_80d66fe79213cedd();
    
    if ( isdefined( var_8c953eb201608663 ) && shouldping )
    {
        wait 2;
        var_8c953eb201608663 calloutmarkerping::function_5d7b7302e94b97c2( self.var_21fb6576cbe2a679, self.targetvehicle.origin + ( 0, 0, 60 ) );
    }
}

// Namespace ob_contract_precious_cargo
// Params 0
// Checksum 0x7c131766, Offset: 0x6df3
// Size: 0xae
function function_6acb71990a57a368()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.targetvehicle endon( #"hash_832af53d22232490" );
    
    while ( true )
    {
        if ( !self.a_vh_ground )
        {
            wait 1;
            continue;
        }
        
        if ( self.last_objective_name )
        {
            function_71799ce2c69ce5a9( self.last_objective_name );
        }
        
        self.last_objective_location = activity_instance_common::function_776ee11e7acc64a5( self );
        self.last_objective_name = "precious_cargo_center" + string( self.var_21fb6576cbe2a679 );
        function_1c4c7ef874191be2( self.last_objective_name, self.last_objective_location, 3000, 1 );
        wait 3;
    }
}

/#

    // Namespace ob_contract_precious_cargo
    // Params 0
    // Checksum 0x63139830, Offset: 0x6ea9
    // Size: 0x96, Type: dev
    function function_f1eb3689129b0cfd()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        self.targetvehicle endon( #"hash_832af53d22232490" );
        
        if ( !getdvarint( @"hash_8148f523096c4aa2", 0 ) )
        {
            return;
        }
        
        while ( true )
        {
            end = function_c1f0a3e9ac3cd880( self.targetvehicle.origin );
            assert( isdefined( end ), "<dev string:x1e8>" + self.targetvehicle.origin );
            waitframe();
        }
    }

#/
