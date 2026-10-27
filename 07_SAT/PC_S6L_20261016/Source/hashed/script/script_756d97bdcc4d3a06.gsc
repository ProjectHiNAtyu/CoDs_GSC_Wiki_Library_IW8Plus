// script_756d97bdcc4d3a06  (hash_756d97bdcc4d3a06.gscc) (size: 3453 Bytes / 0xd7d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x703159cb (1882282443)
// size ...... 3453 (0xd7d)
// includes .. 7   (offset: 0xcb5)
// strings ... 8   (offset: 0xced)
// dev strs .. 3   (offset: 0xd59)
// exports ... 11  (offset: 0x771)
// cseg ...... 0x118 + 0x659 (0x771)
// imports ... 32  (offset: 0x929)
// animtree1 . 0   (offset: 0xd7d)
// animtree2 . 0   (offset: 0xd7d)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_2c67144a48009054;

// Namespace namespace_2c67144a48009054
// Params 0, eflags: 0x5
// Checksum 0x8262011a, Offset: 0x136
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_cf0968878c1b5c87", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_2c67144a48009054
// Params 0
// Checksum 0x42634a10, Offset: 0x15f
// Size: 0x4f
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"bump_mushroom", #"create", &create_bump_mushroom );
    ztron_hazard::function_6f661fac5fd31f1( #"bump_mushroom", #"arenaspawn", &function_67b7b730c3deb945 );
    ztron_sound::function_4ac735395b173fe( "ztron_bump_mushroom_hit", "evt_ztron_mushroom_bounce" );
}

// Namespace namespace_2c67144a48009054
// Params 0
// Checksum 0x7d5b6e59, Offset: 0x1b6
// Size: 0xca
function function_67b7b730c3deb945()
{
    if ( !isdefined( level.ztron.active_arena ) )
    {
        return;
    }
    
    level.ztron.var_3a0f2eb4309a99ad = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "bump_mushroom" );
    
    foreach ( trap in traps )
    {
        create_bump_mushroom( trap );
    }
}

// Namespace namespace_2c67144a48009054
// Params 2
// Checksum 0x4a9338f2, Offset: 0x288
// Size: 0x59
function create_bump_mushroom( trap, paged = 0 )
{
    if ( paged )
    {
        level.ztron.var_3a0f2eb4309a99ad[ level.ztron.var_3a0f2eb4309a99ad.size ] = trap;
        return;
    }
    
    function_4d711bee0c662534( trap );
}

// Namespace namespace_2c67144a48009054
// Params 2, eflags: 0x4
// Checksum 0xeda1b87c, Offset: 0x2e9
// Size: 0x72
function private function_4d711bee0c662534( trap, paged = 0 )
{
    if ( !isdefined( trap ) )
    {
        return;
    }
    
    hazard = trap function_31f494692c1b11c0( "sat_zm_ztron_props_dark_aether_mushroom_01", trap.origin, trap.angles );
    trap.script_model = hazard;
    trap.paged = paged;
    return trap;
}

// Namespace namespace_2c67144a48009054
// Params 3, eflags: 0x4
// Checksum 0xa3c8594d, Offset: 0x364
// Size: 0x5f
function private function_31f494692c1b11c0( model, origin, angles )
{
    hazard = utility::spawn_model( model, origin, angles );
    
    if ( !isdefined( hazard ) )
    {
        return;
    }
    
    hazard.hazardtype = "bump_mushroom";
    hazard disconnectpaths();
    thread function_e538c9db824366cd( hazard );
    return hazard;
}

// Namespace namespace_2c67144a48009054
// Params 1, eflags: 0xc
// Checksum 0x7130441e, Offset: 0x3cc
// Size: 0x57
function private function_e538c9db824366cd( hazard )
{
    self notify( #"hash_571c45d7178a2692" );
    self endon( #"hash_571c45d7178a2692" );
    level endon( #"ztron_game_is_over" );
    self endon( #"death", #"destroy_hazard" );
    thread function_39ec2ecdeae1bea( hazard );
    thread hazard_triggerwatch( hazard );
}

// Namespace namespace_2c67144a48009054
// Params 1, eflags: 0xc
// Checksum 0xf293989b, Offset: 0x42b
// Size: 0x176
function private hazard_triggerwatch( hazard )
{
    self notify( #"hash_dcee74d75967aac4" );
    self endon( #"hash_dcee74d75967aac4" );
    self endon( #"death", #"destroy_hazard" );
    hazard.offset = ( 0, 0, 176 );
    hazard.trigger = spawn( "trigger_radius", self.origin + hazard.offset, 0, 144, 64 );
    hazard.trigger.owner = hazard;
    hazard.script_noteworthy = "hazard_mushroom";
    
    /#
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            hazard.trigger thread ztron_debug::drawtrigger();
        }
    #/
    
    while ( true )
    {
        hazard.trigger waittill( #"trigger", ent );
        
        if ( ent.origin[ 2 ] < hazard.trigger.origin[ 2 ] )
        {
            continue;
        }
        
        if ( isplayer( ent.owner ) && isdefined( ent.owner.ztron.vehicle ) )
        {
            ent.owner thread function_6696567b9146f17b();
            wait 1;
        }
    }
}

// Namespace namespace_2c67144a48009054
// Params 1, eflags: 0x4
// Checksum 0xaea73cce, Offset: 0x5a9
// Size: 0x16b
function private function_6696567b9146f17b( duration = 3 )
{
    vehicle = self.ztron.vehicle;
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle endon( #"death" );
    vehicle notify( #"interupt_change_speed" );
    vehicle endon( #"interupt_change_speed" );
    utility::ent_flag_set( "vehicle_change_speed" );
    var_d1cd6c2d8086cdb = "mushroom";
    vehicle thread ztron_util::function_5bd5e2f5c01a2138( getdvarfloat( @"hash_ffb269eee72f6481", 1.2 ), 1, var_d1cd6c2d8086cdb );
    velocity = vehicle vehicle_getvelocity();
    var_abaeb2779e3915b8 = getdvarfloat( @"hash_434c62c3182fb759", 500 );
    deltavelocity = var_abaeb2779e3915b8 - velocity[ 2 ];
    
    if ( deltavelocity > 0 )
    {
        impulseforce = vehicle ztron_util::function_9737472712bf3b7e( deltavelocity );
        vehicle vehphys_impulse( ( 0, 0, 1 ), impulseforce, 1 );
        ztron_sound::ztron_playsound( "ztron_bump_mushroom_hit", vehicle.origin );
        println( "<dev string:x24>" + velocity + "<dev string:x4c>" + deltavelocity + "<dev string:x5d>" + impulseforce );
    }
    
    wait duration;
    vehicle thread ztron_util::function_5bd5e2f5c01a2138( undefined, 1, var_d1cd6c2d8086cdb );
    utility::ent_flag_init( "vehicle_change_speed" );
}

// Namespace namespace_2c67144a48009054
// Params 1, eflags: 0x4
// Checksum 0x291edc64, Offset: 0x71c
// Size: 0x55
function private function_39ec2ecdeae1bea( hazard )
{
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    self waittill( #"destroy_hazard" );
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model thread ztron_util::deletemedelay();
        self.script_model = undefined;
    }
}

