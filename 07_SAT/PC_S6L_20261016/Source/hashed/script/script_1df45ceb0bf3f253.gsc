// script_1df45ceb0bf3f253  (hash_1df45ceb0bf3f253.gscc) (size: 5878 Bytes / 0x16f6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc3ad51b (3426407707)
// size ...... 5878 (0x16f6)
// includes .. 10  (offset: 0x155a)
// strings ... 24  (offset: 0x15aa)
// dev strs .. 0   (offset: 0x16f6)
// exports ... 17  (offset: 0xd52)
// cseg ...... 0x21d + 0xb35 (0xd52)
// imports ... 47  (offset: 0xffa)
// animtree1 . 0   (offset: 0x16f6)
// animtree2 . 0   (offset: 0x16f6)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\mp\ai_vehicle_patrol;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\flags;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace namespace_ddf564e165b3abd3;

// Namespace namespace_ddf564e165b3abd3
// Params 1
// Checksum 0x388d3f89, Offset: 0x23b
// Size: 0x139
function dmztask_getspawndata( data )
{
    flags::function_2f3408423ccc9b2e( "vehicle_patrol_paths_selected" );
    level.convoyattack = spawnstruct();
    level.convoyattack.speed = getdvarfloat( @"scr_dmz_convoy_attack_speed", 20 );
    level.convoyattack.usetruck = getdvarint( @"hash_ceaf6d7a5f1db16e", 1 );
    level.var_9166dae2aa6330df = [];
    
    foreach ( p in level.var_295138bb09cc4de )
    {
        p.origin = p.path[ 0 ].origin;
        level.var_9166dae2aa6330df[ level.var_9166dae2aa6330df.size ] = p;
    }
    
    activity_manager::function_f61a1f535aab4194( data, &function_9ef0aeab654737a3, level.var_9166dae2aa6330df );
}

// Namespace namespace_ddf564e165b3abd3
// Params 2
// Checksum 0x9d950dfb, Offset: 0x37c
// Size: 0xf1
function function_9ef0aeab654737a3( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_dff7d18ec6544b2a;
    task.funcs[ "onTeamAssigned" ] = &function_a4ab6ee68486c2f9;
    task.funcs[ "onPlayerJoined" ] = &function_6e93d05837296158;
    task.funcs[ "onPlayerRemoved" ] = &function_907b4d36c6dee233;
    task.funcs[ "onTeamStart" ] = &function_fe5d96f8ca388993;
    task.funcs[ "onCancel" ] = &function_4706c4664a8c30b2;
    task.node = node;
    task.ref = "dmz_convoy_attack";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    return task;
}

// Namespace namespace_ddf564e165b3abd3
// Params 0
// Checksum 0xf78b643a, Offset: 0x476
// Size: 0x23f
function function_dff7d18ec6544b2a()
{
    if ( !isdefined( self.node ) )
    {
        return;
    }
    
    dmz_task_utils::function_b3476f99a8e21fa2( self.node.origin + ( 0, 0, 60 ) );
    
    if ( !vehicle::is_loaded( %"hash_406987d5bb9cf080" ) )
    {
        dmz_task_utils::task_ended();
        return;
    }
    
    self.activity.origin = self.node.origin;
    self.caches = [];
    self.node.initai = 1;
    self.node.spawntype = "GAME_MODE";
    self.node.team = "team_hundred_ninety_four";
    self.node.showheadicon = 1;
    
    if ( level.convoyattack.usetruck )
    {
        self.vehicle = function_eb82c01876e6aa5f();
    }
    else
    {
        self.vehicle = function_8a64ee467ed155f8();
    }
    
    objidpoolmanager::update_objective_onentity( self.icon, self.vehicle );
    thread function_9c4c9461b8a198ca();
    self.vehicle vehicle_ai::function_c439ae025b2bf434();
    self.node.direction = 1;
    self.node.index = 0;
    self.vehicle setconfigvalue( "p2p", "brakeAtGoal", 0 );
    self.vehicle setconfigvalue( "p2p", "goalThreshold", level.convoyattack.speed * 4 );
    self.vehicle setconfigvalue( "p2p", "steeringMultiplier", 2.5 );
    self.vehicle setconfigvalue( "p2p", "stuckTime", 4 );
    self.vehicle.pathdata = self.node;
    self.vehicle thread vehicle_ai::follow_path_struct( self.node, level.convoyattack.speed );
}

// Namespace namespace_ddf564e165b3abd3
// Params 1
// Checksum 0xd4dea1e5, Offset: 0x6bd
// Size: 0xc
function function_6e93d05837296158( player )
{
    
}

// Namespace namespace_ddf564e165b3abd3
// Params 1
// Checksum 0x1083aa7, Offset: 0x6d1
// Size: 0xc
function function_907b4d36c6dee233( player )
{
    
}

// Namespace namespace_ddf564e165b3abd3
// Params 1
// Checksum 0x87189e14, Offset: 0x6e5
// Size: 0xc
function function_4706c4664a8c30b2( team )
{
    
}

// Namespace namespace_ddf564e165b3abd3
// Params 1
// Checksum 0x975bc2b7, Offset: 0x6f9
// Size: 0x1a
function function_a4ab6ee68486c2f9( team )
{
    dmz_task_utils::task_showsplashtoteam( "dmz_convoy_attack_assigned", team );
}

// Namespace namespace_ddf564e165b3abd3
// Params 1
// Checksum 0x5dbafdc, Offset: 0x71b
// Size: 0xc
function function_fe5d96f8ca388993( team )
{
    
}

// Namespace namespace_ddf564e165b3abd3
// Params 0
// Checksum 0xcbbee394, Offset: 0x72f
// Size: 0x9
function dmztask_cleanup()
{
    dmz_task_utils::function_3ff46488beb193c7();
}

// Namespace namespace_ddf564e165b3abd3
// Params 0
// Checksum 0xcf2ec420, Offset: 0x740
// Size: 0x48
function function_6fd7183a0ca499fd()
{
    dmztask_cleanup();
    
    if ( isdefined( self.teams[ 0 ] ) )
    {
        dmz_task_utils::function_e533421ccebd7d79( self.teams[ 0 ] );
        dmz_task_utils::task_showsplashtoteam( "dmz_convoy_attack_success", self.teams[ 0 ] );
    }
    
    dmz_task_utils::task_ended();
}

// Namespace namespace_ddf564e165b3abd3
// Params 0
// Checksum 0x6f7e31fe, Offset: 0x790
// Size: 0x31
function function_9c4c9461b8a198ca()
{
    self endon( #"task_ended" );
    self.vehicle waittill( #"death" );
    function_6e4e7bf577cc08a2();
    thread function_6fd7183a0ca499fd();
}

// Namespace namespace_ddf564e165b3abd3
// Params 0
// Checksum 0x7c3ac60f, Offset: 0x7c9
// Size: 0x1d3
function function_8a64ee467ed155f8()
{
    vehicle = vehicle::spawn( %"hash_406987d5bb9cf080", self.node );
    vehicle.var_1f4f9d64c04f05db = 1;
    vehicle.task = self;
    vehicle.var_d1c265e59db4d5bf = 1;
    poiname = poi::poi_findpoioriginisin( self.node.origin, 0, 1 );
    agenttypes = utility::callsharedfunc( #"ground", #"hash_fcd7e9fa4cb0879c", %"hash_406987d5bb9cf080" );
    spawners = utility::callsharedfunc( #"ground", #"hash_c96151abc06cb1c1", %"hash_406987d5bb9cf080", 4, agenttypes, self.node.origin, poiname, "absolute" );
    riders = utility::callsharedfunc( #"ground", #"spawnriders", spawners, 4, undefined, "absolute", "convoy_attack", "convoy_attack", "team_hundred_ninety_four", undefined, %"hash_406987d5bb9cf080", poiname );
    
    if ( riders.size > 0 )
    {
        foreach ( rider in riders )
        {
            rider.var_f60cb46dafea871e = 1;
        }
    }
    
    if ( isdefined( riders[ 1 ] ) )
    {
        riders[ 1 ] setstealthstate( "combat" );
    }
    
    vehicle vehicle_ai::load( riders, 1, 1 );
    return vehicle;
}

// Namespace namespace_ddf564e165b3abd3
// Params 2
// Checksum 0xa0bdfbbe, Offset: 0x9a5
// Size: 0x9e
function function_6aa032aa029cd500( offset, angles )
{
    worldpos = coordtransform( offset, self.origin, self.angles );
    worldangles = combineangles( self.angles, angles );
    cache = spawnscriptable( "br_loot_cache_convoy_attack", worldpos, angles );
    cache scriptablesetparententity( self, offset, angles );
    self.task.caches[ self.task.caches.size ] = cache;
}

// Namespace namespace_ddf564e165b3abd3
// Params 0
// Checksum 0xf2ae7be2, Offset: 0xa4b
// Size: 0x20b
function function_eb82c01876e6aa5f()
{
    vehicle = vehicle::spawn( %"hash_77eba5cf011bc16c", self.node );
    vehicle.var_1f4f9d64c04f05db = 1;
    vehicle.task = self;
    vehicle.var_d1c265e59db4d5bf = 1;
    poiname = poi::poi_findpoioriginisin( self.node.origin, 0, 1 );
    agenttypes = utility::callsharedfunc( #"ground", #"hash_fcd7e9fa4cb0879c", %"hash_77eba5cf011bc16c" );
    spawners = utility::callsharedfunc( #"ground", #"hash_c96151abc06cb1c1", %"hash_77eba5cf011bc16c", 7, agenttypes, self.node.origin, poiname, "absolute" );
    riders = utility::callsharedfunc( #"ground", #"spawnriders", spawners, 7, undefined, "absolute", "convoy_attack", "convoy_attack", "team_hundred_ninety_four", undefined, "veh9_mil_cargo_truck_convoy_attack", poiname );
    
    if ( riders.size > 0 )
    {
        vehicle thread function_482a584feb007dd4( riders[ 0 ] );
        
        foreach ( rider in riders )
        {
            rider.var_f60cb46dafea871e = 1;
        }
    }
    
    vehicle vehicle_ai::load( riders, 1, 1 );
    vehicle function_6aa032aa029cd500( ( 33, 23, 10 ), ( 0, 90, 0 ) );
    vehicle function_6aa032aa029cd500( ( 33, -23, 10 ), ( 0, 90, 0 ) );
    return vehicle;
}

// Namespace namespace_ddf564e165b3abd3
// Params 0
// Checksum 0x3d0ce236, Offset: 0xc5f
// Size: 0x9b
function function_6e4e7bf577cc08a2()
{
    if ( self.openedcaches )
    {
        return;
    }
    
    self.openedcaches = 1;
    
    foreach ( cache in self.caches )
    {
        cache setscriptablepartstate( "body", "closed_usable" );
    }
}

// Namespace namespace_ddf564e165b3abd3
// Params 1, eflags: 0x4
// Checksum 0xc35408ef, Offset: 0xd02
// Size: 0x50
function private function_482a584feb007dd4( driver )
{
    self endon( #"death" );
    self endon( #"unloaded" );
    driver waittill( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.task function_6e4e7bf577cc08a2();
    ai_vehicle_patrol::unload();
}

