// script_69ccf03a1800b6be  (hash_69ccf03a1800b6be.gscc) (size: 3483 Bytes / 0xd9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4032c56e (1077069166)
// size ...... 3483 (0xd9b)
// includes .. 12  (offset: 0xcbb)
// strings ... 10  (offset: 0xd1b)
// dev strs .. 0   (offset: 0xd9b)
// exports ... 10  (offset: 0x79b)
// cseg ...... 0x14b + 0x650 (0x79b)
// imports ... 32  (offset: 0x92b)
// animtree1 . 0   (offset: 0xd9b)
// animtree2 . 0   (offset: 0xd9b)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_f9b89a38ef3363db;

// Namespace namespace_f9b89a38ef3363db
// Params 0, eflags: 0x5
// Checksum 0xbc6e83d3, Offset: 0x169
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_55b971eee9a22f57", #"ztron_item", undefined, &init );
}

// Namespace namespace_f9b89a38ef3363db
// Params 0
// Checksum 0x4b84cc86, Offset: 0x192
// Size: 0x5c
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"sat_firefly_pluto", #"use", &function_bf476366135f4d1e );
    ztron_item::function_5844a9c240f7dc8d( #"sat_firefly_pluto", #"canautouse", &canautouse );
    utility::registersharedfunc( %"hash_27037d40e620d881", #"exitStart", &function_bd8abdf4a4bd22c9 );
}

// Namespace namespace_f9b89a38ef3363db
// Params 1, eflags: 0x4
// Checksum 0xe551f1d9, Offset: 0x1f6
// Size: 0x48, Type: bool
function private canautouse( params )
{
    return !isdefined( self.ztron.vehicle ) && !isdefined( self.ztron.vehicleblocked ) && !self.inlaststand;
}

// Namespace namespace_f9b89a38ef3363db
// Params 6, eflags: 0x4
// Checksum 0x325c6b71, Offset: 0x247
// Size: 0x6c
function private function_bd8abdf4a4bd22c9( vehicle, seatid, newseatid, player, data, specialexit )
{
    navpoint = player ztron_util::function_4693a81423b56106( vehicle.origin );
    
    if ( isdefined( navpoint ) )
    {
        data.exitposition = navpoint;
    }
}

// Namespace namespace_f9b89a38ef3363db
// Params 1, eflags: 0x4
// Checksum 0x336ceb09, Offset: 0x2bb
// Size: 0x179
function private function_bf476366135f4d1e( params )
{
    owner = params.player;
    
    if ( !isdefined( owner ) || isdefined( owner.ztron.vehicle ) || owner.ztron.vehicleblocked )
    {
        return;
    }
    
    level endon( #"ztron_game_is_over" );
    
    if ( !isdefined( owner.ztron ) )
    {
        owner.ztron = spawnstruct();
    }
    
    owner.ztron.vehicleblocked = 1;
    owner ztron_player_utility::playerinvulnerability( 1 );
    car = owner function_4f907c2f2eaa98ad();
    car thread ztron_util::function_1544885c712921f8( owner );
    owner.ztron.vehicleblocked = undefined;
    owner.ztron.vehicle = car;
    bundlename = common_item::function_e044c3e813daec3a( params.bundle );
    duration = level.ztron.itemdef.itemdata[ bundlename ].duration ?? 30;
    
    if ( isdefined( level.ztron.thewild ) )
    {
        duration += 10;
    }
    
    owner thread function_492218a6a07a794d( duration );
    owner thread function_3234a76c40d8bfb0();
}

// Namespace namespace_f9b89a38ef3363db
// Params 0, eflags: 0x4
// Checksum 0x96172dd0, Offset: 0x43c
// Size: 0x19c
function private function_4f907c2f2eaa98ad()
{
    vehiclespawndata = spawnstruct();
    vehiclespawndata.origin = self.origin + ( 0, 0, 100 );
    vehiclespawndata.angles = self.angles;
    vehiclespawndata.script_modelname = "xcomp_veh_ztron_sat_firefly_pluto_" + self.ztron.color;
    faildata = spawnstruct();
    car = vehicle::spawn( "veh_ztron_sat_firefly_pluto", vehiclespawndata );
    
    if ( !isdefined( car ) )
    {
        ztron_debug::debugmsg( " ztron spawnZtronHelicopter failed for player:" + self.name + " reason:" + faildata.fail, 1 );
        return;
    }
    
    entnum = car getentitynumber();
    car.team = self.team;
    car.owner = self;
    car.var_9ba75406da00630d = 1;
    car.no_shell_eject = 1;
    car.var_f4cb64a84a917d5b = 1;
    car.forcefp = 0;
    car.var_826c7bc2c0346845 = 1;
    car.godmode = 1;
    waitframe();
    level thread vehicle_occupancy::enter( car, "driver", self, undefined, 1 );
    val::set( "ztron_vehicle", "damage", 0 );
    car makeunusable();
    car.maxhealth = 9999999;
    car.health = 9999999;
    return car;
}

// Namespace namespace_f9b89a38ef3363db
// Params 1, eflags: 0x4
// Checksum 0x51bf0cf, Offset: 0x5e1
// Size: 0x48
function private function_492218a6a07a794d( time )
{
    self endon( #"disconnect" );
    self endon( #"hash_ef8228c75b12b23" );
    level endon( #"ztron_game_is_over" );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    wait time;
    function_361679df62f2b0e9();
}

// Namespace namespace_f9b89a38ef3363db
// Params 0, eflags: 0x4
// Checksum 0xc836bba0, Offset: 0x631
// Size: 0x43
function private function_3234a76c40d8bfb0()
{
    self endon( #"disconnect" );
    self endon( #"hash_ef8228c75b12b23" );
    level endon( #"ztron_game_is_over" );
    utility::waittill_any( "ztron_player_dump_vehicle", "ztron_exit_taken", "ztron_teleporter_taken" );
    function_361679df62f2b0e9();
}

// Namespace namespace_f9b89a38ef3363db
// Params 1, eflags: 0x4
// Checksum 0x429a0977, Offset: 0x67c
// Size: 0x11f
function private function_361679df62f2b0e9( callexist = 1 )
{
    car = self.ztron.vehicle;
    
    if ( isdefined( car ) )
    {
        car makeusable();
    }
    
    self endon( #"disconnect" );
    ztron_player_utility::playerinvulnerability( 0, 1 );
    
    if ( callexist && isdefined( car ) )
    {
        vehicle_occupancy::exit( car, "driver", self, undefined, 1 );
    }
    
    self.ignoreme = 0;
    self.ztron.vehicle = undefined;
    self.ztron.var_fe6f1fc8ee223cf0 = undefined;
    self.ztron.var_538334d0040b7d5f = gettime();
    self.ztron.dmggrace = self.ztron.var_538334d0040b7d5f + 1000;
    val::reset_all( "ztron_vehicle" );
    thread ztron_player_utility::turnPlayerShieldOn( 1 );
    
    if ( isdefined( car ) )
    {
        vehicle_tracking::delete_vehicle( car );
    }
    
    thread ztron_player::function_9886753b3100ebd0();
    self notify( #"hash_ef8228c75b12b23" );
}

