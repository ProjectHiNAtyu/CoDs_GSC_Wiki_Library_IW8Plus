// script_3872c3ea415659ec  (hash_3872c3ea415659ec.gscc) (size: 3745 Bytes / 0xea1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a0ecef5 (2584661749)
// size ...... 3745 (0xea1)
// includes .. 13  (offset: 0xdad)
// strings ... 11  (offset: 0xe15)
// dev strs .. 0   (offset: 0xea1)
// exports ... 10  (offset: 0x86d)
// cseg ...... 0x191 + 0x6dc (0x86d)
// imports ... 33  (offset: 0x9fd)
// animtree1 . 0   (offset: 0xea1)
// animtree2 . 0   (offset: 0xea1)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_bf4ac6e5e2190959;

// Namespace namespace_bf4ac6e5e2190959
// Params 0, eflags: 0x5
// Checksum 0xbc83d9ef, Offset: 0x1af
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_54b15e048e61f730", #"ztron_item", undefined, &init );
}

// Namespace namespace_bf4ac6e5e2190959
// Params 0
// Checksum 0x488a70a3, Offset: 0x1d8
// Size: 0x6d
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"motorcycle", #"use", &usemotorcycle );
    ztron_item::function_5844a9c240f7dc8d( #"motorcycle", #"canautouse", &canautouse );
    ztron_sound::function_4ac735395b173fe( "motorcycle_item_pickup_activated_OS", "evt_ztron_pickup_hind_consumed" );
    utility::registersharedfunc( %"hash_665b43758bdf7d56", #"exitStart", &function_c2e6fb469d748e69 );
}

// Namespace namespace_bf4ac6e5e2190959
// Params 1
// Checksum 0xe87b9b5f, Offset: 0x24d
// Size: 0x48, Type: bool
function canautouse( params )
{
    return !isdefined( self.ztron.vehicle ) && !isdefined( self.ztron.vehicleblocked ) && !self.inlaststand;
}

// Namespace namespace_bf4ac6e5e2190959
// Params 6
// Checksum 0x99f81472, Offset: 0x29e
// Size: 0x6c
function function_c2e6fb469d748e69( vehicle, seatid, newseatid, player, data, specialexit )
{
    navpoint = player ztron_util::function_4693a81423b56106( vehicle.origin );
    
    if ( isdefined( navpoint ) )
    {
        data.exitposition = navpoint;
    }
}

// Namespace namespace_bf4ac6e5e2190959
// Params 1, eflags: 0x4
// Checksum 0xef6b1171, Offset: 0x312
// Size: 0x241
function private usemotorcycle( params )
{
    level endon( #"ztron_game_is_over" );
    owner = params.player;
    owner endon( #"disconnect" );
    
    if ( !isdefined( owner ) || isdefined( owner.ztron.vehicle ) || owner.ztron.vehicleblocked )
    {
        return;
    }
    
    var_8c4886ff9e8d8082 = spawnstruct();
    var_8c4886ff9e8d8082.player = owner;
    var_8c4886ff9e8d8082.origin = params.scriptable.origin;
    var_8c4886ff9e8d8082.angles = params.scriptable.angles;
    
    if ( !level.ztron.var_74a3707334cfe144 )
    {
        if ( owner.ztron.var_a4c2f70bbc713f98 )
        {
            owner notify( #"ztron_playerdumpfps" );
            waitframe();
        }
    }
    
    if ( !isdefined( owner.ztron ) )
    {
        owner.ztron = spawnstruct();
    }
    
    var_526d9013c0688b83 = owner function_62a414239707200f();
    
    if ( !isdefined( var_526d9013c0688b83 ) )
    {
        return;
    }
    
    ztron_sound::ztron_playsound( "motorcycle_item_pickup_activated_OS", var_526d9013c0688b83.origin );
    owner.ztron.vehicle = var_526d9013c0688b83;
    var_526d9013c0688b83 thread ztron_util::function_1544885c712921f8( owner );
    owner.ztron.vehicleblocked = 1;
    owner ztron_player_utility::playerinvulnerability( 1 );
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    duration = itemdata.duration ?? 30;
    
    if ( isdefined( level.ztron.thewild ) )
    {
        duration += 10;
    }
    
    owner thread motorcyclewatchtimeout( duration );
    owner thread function_c83d87c2111dced9();
    thread utility::callsharedfunc( #"motorcycle", #"used", var_8c4886ff9e8d8082 );
    
    if ( ztron_main::function_4da200e9b8d58a3c() != 3 )
    {
        owner ztron_ui::function_787d89891b886acf( "VEH_EXIT_HINT" );
    }
}

// Namespace namespace_bf4ac6e5e2190959
// Params 0, eflags: 0x4
// Checksum 0x91e4139d, Offset: 0x55b
// Size: 0x168
function private function_62a414239707200f()
{
    vehiclespawndata = spawnstruct();
    vehiclespawndata.origin = self.origin + ( 0, 0, 85 );
    vehiclespawndata.angles = self.angles;
    vehiclespawndata.script_modelname = "veh_ztron_sat_mil_us_motorcycle_" + self.ztron.color;
    faildata = spawnstruct();
    var_526d9013c0688b83 = vehicle::spawn( "veh_cer_port_civ_lnd_dirt_bike_ztron", vehiclespawndata );
    
    if ( !isdefined( var_526d9013c0688b83 ) )
    {
        ztron_debug::debugmsg( " ztron spawnZtronHelicopter failed for player:" + self.name + " reason:" + faildata.fail, 1 );
        return;
    }
    
    var_526d9013c0688b83.team = self.team;
    var_526d9013c0688b83.owner = self;
    var_526d9013c0688b83.var_9ba75406da00630d = 1;
    var_526d9013c0688b83.no_shell_eject = 1;
    var_526d9013c0688b83.var_f4cb64a84a917d5b = 1;
    var_526d9013c0688b83.forcefp = 0;
    var_526d9013c0688b83.var_826c7bc2c0346845 = 1;
    var_526d9013c0688b83.godmode = 1;
    level thread vehicle_occupancy::enter( var_526d9013c0688b83, "driver", self, undefined, 1 );
    var_526d9013c0688b83 makeunusable();
    var_526d9013c0688b83.health = 9999999;
    return var_526d9013c0688b83;
}

// Namespace namespace_bf4ac6e5e2190959
// Params 1
// Checksum 0x6078e2a0, Offset: 0x6cc
// Size: 0x48
function motorcyclewatchtimeout( time )
{
    self endon( #"disconnect" );
    self endon( #"motorcycle_destroyed" );
    level endon( #"ztron_game_is_over" );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    wait time;
    function_2c68fd546360b653();
}

// Namespace namespace_bf4ac6e5e2190959
// Params 0
// Checksum 0xdb9133cf, Offset: 0x71c
// Size: 0x43
function function_c83d87c2111dced9()
{
    self endon( #"disconnect" );
    self endon( #"motorcycle_destroyed" );
    level endon( #"ztron_game_is_over" );
    utility::waittill_any( "ztron_player_dump_vehicle", "ztron_exit_taken", "ztron_teleporter_taken" );
    function_2c68fd546360b653();
}

// Namespace namespace_bf4ac6e5e2190959
// Params 1, eflags: 0x4
// Checksum 0x51266044, Offset: 0x767
// Size: 0x106
function private function_2c68fd546360b653( callexist = 1 )
{
    var_526d9013c0688b83 = self.ztron.vehicle;
    self endon( #"disconnect" );
    ztron_player_utility::playerinvulnerability( 0, 1 );
    
    if ( callexist && isdefined( var_526d9013c0688b83 ) )
    {
        vehicle_occupancy::exit( var_526d9013c0688b83, "driver", self, undefined, 1 );
    }
    
    self.ignoreme = 0;
    self.ztron.vehicle = undefined;
    self.ztron.var_fe6f1fc8ee223cf0 = undefined;
    self.ztron.var_538334d0040b7d5f = gettime();
    self.ztron.dmggrace = self.ztron.var_538334d0040b7d5f + 1000;
    thread ztron_player_utility::function_985a085be4ea0ba4( 1 );
    
    if ( isdefined( var_526d9013c0688b83 ) )
    {
        vehicle_tracking::delete_vehicle( var_526d9013c0688b83 );
    }
    
    thread ztron_player::function_9886753b3100ebd0();
    self notify( #"motorcycle_destroyed" );
}

