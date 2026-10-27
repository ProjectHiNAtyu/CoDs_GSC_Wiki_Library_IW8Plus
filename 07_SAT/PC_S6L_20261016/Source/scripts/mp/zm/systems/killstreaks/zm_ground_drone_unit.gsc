// scripts\mp\zm\systems\killstreaks\zm_ground_drone_unit.gsc  (hash_6fec215853279416.gscc) (size: 3122 Bytes / 0xc32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f94c51a (1335149850)
// size ...... 3122 (0xc32)
// includes .. 5   (offset: 0xb76)
// strings ... 10  (offset: 0xb9e)
// dev strs .. 0   (offset: 0xc32)
// exports ... 12  (offset: 0x622)
// cseg ...... 0x13b + 0x4e7 (0x622)
// imports ... 30  (offset: 0x802)
// animtree1 . 0   (offset: 0xc32)
// animtree2 . 0   (offset: 0xc32)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_ground_drone_unit;

// Namespace zm_ground_drone_unit
// Params 0, eflags: 0x5
// Checksum 0x32c2573d, Offset: 0x159
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_ground_drone_unit", undefined, &__init__, undefined );
}

// Namespace zm_ground_drone_unit
// Params 0
// Checksum 0x38571f76, Offset: 0x17a
// Size: 0xa
function __init__()
{
    level thread init_zm_ground_drone_unit();
}

// Namespace zm_ground_drone_unit
// Params 0
// Checksum 0x79994600, Offset: 0x18c
// Size: 0xc1
function init_zm_ground_drone_unit()
{
    utility::flag_wait( "ground_drone_unit_initialized" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ground_drone_unit", "veh_sat_mil_drone_gdu_zm", #"large" );
    utility::registersharedfunc( #"gdu", #"gdu_spawn_start", &gdu_spawn_start );
    utility::registersharedfunc( #"gdu", #"gdu_premodifydamage", &gdu_premodifydamage );
    utility::registersharedfunc( #"gdu", #"hash_639342328e0ad856", &function_b8ec834e0b1c0875 );
    utility::registersharedfunc( #"gdu", #"hash_bd7316aff22a0e6d", &function_b1608b5d0ce35d96 );
    level._effect[ "portal_spawn" ] = loadfxasset( "vfx_t10_gameplay_zm_trials_machine_spawn" );
    level thread register_on_kill_medal();
}

// Namespace zm_ground_drone_unit
// Params 1
// Checksum 0xce370ba0, Offset: 0x255
// Size: 0x5d
function gdu_premodifydamage( data )
{
    if ( isplayer( data.inflictor ) )
    {
        if ( level.teambased && self.team == data.inflictor.team )
        {
            data.damage = 0;
            return 1;
        }
    }
}

// Namespace zm_ground_drone_unit
// Params 0, eflags: 0x4
// Checksum 0x233165ce, Offset: 0x2bb
// Size: 0x62
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = "ground_drone_unit";
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_ground_drone_unit
// Params 4, eflags: 0x4
// Checksum 0xbff4c005, Offset: 0x325
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "ground_drone_unit", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "ground_drone_unit" ] ) && self.rapidkill_data[ "ground_drone_unit" ].rapidkill_count === 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_swarm" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "ground_drone_unit", victim );
    }
}

// Namespace zm_ground_drone_unit
// Params 6
// Checksum 0x7b86482c, Offset: 0x41c
// Size: 0xa6
function gdu_spawn_start( droneowner, targetlocation, spawnlocation, bundle, streakinfo, plane )
{
    spawnlocation = ( spawnlocation[ 0 ], spawnlocation[ 1 ], airdrop::getscriptedhelidropheight( undefined, droneowner ) );
    portalscriptable = spawnscriptable( "sat_zm_spawn_portal", spawnlocation + ( 0, 0, 20 ) );
    portalscriptable setscriptablepartstate( "portal", "on" );
    playfx( level._effect[ "portal_spawn" ], spawnlocation );
    wait 2;
    thread function_3c3a8aaa848506c0( portalscriptable );
    return spawnlocation;
}

// Namespace zm_ground_drone_unit
// Params 1
// Checksum 0xd642bbbe, Offset: 0x4cb
// Size: 0x2b
function function_3c3a8aaa848506c0( portalscriptable )
{
    wait 10;
    portalscriptable setscriptablepartstate( "portal", "sound_off" );
    waitframe();
    portalscriptable freescriptable();
}

// Namespace zm_ground_drone_unit
// Params 1, eflags: 0x4
// Checksum 0x29494227, Offset: 0x4fe
// Size: 0x28
function private function_b8ec834e0b1c0875( pos )
{
    zone_struct = zone_manager::function_90e5c3e2272b0130( pos );
    return function_e8ef9022f2a09143( zone_struct );
}

// Namespace zm_ground_drone_unit
// Params 1, eflags: 0x4
// Checksum 0xae369311, Offset: 0x52f
// Size: 0x56, Type: bool
function private function_e8ef9022f2a09143( zone_struct )
{
    if ( level.var_cc4f3ae072c8b107 && zone_struct.zone_name && arraycontains( level.var_cc4f3ae072c8b107, zone_struct.zone_name ) )
    {
        return false;
    }
    
    return zone_struct && zone_struct.is_enabled;
}

// Namespace zm_ground_drone_unit
// Params 0, eflags: 0x4
// Checksum 0x734d1cf8, Offset: 0x58e
// Size: 0x93
function private function_b1608b5d0ce35d96()
{
    if ( isvector( self.origin ) )
    {
        do
        {
            offset = ( randomintrange( -1200, 1200 ), randomintrange( -1200, 1200 ), 0 );
            pos = getclosestpointonnavmesh( self.origin + offset );
            zone_struct = zone_manager::function_90e5c3e2272b0130( pos );
            
            if ( function_e8ef9022f2a09143( zone_struct ) )
            {
                return { #origin:pos };
            }
            
            count = ( count ?? 0 ) + 1;
        }
        while ( count < 5 );
    }
}

