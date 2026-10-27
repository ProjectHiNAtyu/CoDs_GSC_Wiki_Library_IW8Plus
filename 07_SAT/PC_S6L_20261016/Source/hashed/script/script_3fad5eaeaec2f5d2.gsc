// script_3fad5eaeaec2f5d2  (hash_3fad5eaeaec2f5d2.gscc) (size: 3338 Bytes / 0xd0a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1b59f82 (4055211906)
// size ...... 3338 (0xd0a)
// includes .. 7   (offset: 0xc4a)
// strings ... 10  (offset: 0xc82)
// dev strs .. 0   (offset: 0xd0a)
// exports ... 9   (offset: 0x716)
// cseg ...... 0xfc + 0x61a (0x716)
// imports ... 34  (offset: 0x87e)
// animtree1 . 0   (offset: 0xd0a)
// animtree2 . 0   (offset: 0xd0a)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_droplight;

// Namespace ztron_hazard_droplight
// Params 0, eflags: 0x5
// Checksum 0x4fe45a94, Offset: 0x11a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_droplight", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_droplight
// Params 0
// Checksum 0x2dca9fee, Offset: 0x143
// Size: 0x4f
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"droplight", #"create", &function_507a3c9c1817738b );
    ztron_hazard::function_6f661fac5fd31f1( #"droplight", #"arenaspawn", &function_9806b1229b190935 );
    ztron_sound::function_4ac735395b173fe( "droplight_explosion_OS", "evt_ztron_hazard_droplight_explo" );
}

// Namespace ztron_hazard_droplight
// Params 2
// Checksum 0x646dc51b, Offset: 0x19a
// Size: 0x5a
function function_507a3c9c1817738b( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_f0eadc2d67dd8591[ level.ztron.var_f0eadc2d67dd8591.size ] = trap;
        return;
    }
    
    function_89887d6003a712cc( trap, page );
}

// Namespace ztron_hazard_droplight
// Params 0
// Checksum 0xec056e37, Offset: 0x1fc
// Size: 0xb1
function function_9806b1229b190935()
{
    level.ztron.var_f0eadc2d67dd8591 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "droplight" );
    
    foreach ( trap in traps )
    {
        function_507a3c9c1817738b( trap );
    }
}

// Namespace ztron_hazard_droplight
// Params 2
// Checksum 0xeb644d70, Offset: 0x2b5
// Size: 0xe9
function function_89887d6003a712cc( trap, paged )
{
    var_4d080f710fb8349e = utility::spawn_model( %"t10_lighting_chandelier_iron_01_double_short_ztron", trap.origin, trap.angles );
    var_4d080f710fb8349e setcandamage( 1 );
    var_4d080f710fb8349e.maxhealth = 80;
    var_4d080f710fb8349e.health = var_4d080f710fb8349e.maxhealth;
    var_4d080f710fb8349e solid();
    trap.var_4d080f710fb8349e = var_4d080f710fb8349e;
    vfxscriptable = spawnscriptable( "ztron_droplight_vfx", trap.origin + ( 0, 0, -110 ), trap.angles );
    vfxscriptable setscriptablepartstate( "light", "on" );
    trap.vfxscriptable = vfxscriptable;
    var_4d080f710fb8349e thread function_2c587df6e340c28d( trap );
}

// Namespace ztron_hazard_droplight
// Params 0, eflags: 0xc
// Checksum 0xc8cd78ee, Offset: 0x3a6
// Size: 0x7d
function private function_530ce0277561a6b()
{
    self notify( #"hash_c0e87b737ab1fc2d" );
    self endon( #"hash_c0e87b737ab1fc2d" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    waitframe();
    
    if ( isdefined( self.var_4d080f710fb8349e ) )
    {
        self.var_4d080f710fb8349e delete();
    }
    
    if ( isdefined( self.vfxscriptable ) )
    {
        self.vfxscriptable setscriptablepartstate( "light", "off" );
        self.vfxscriptable freescriptable();
    }
}

// Namespace ztron_hazard_droplight
// Params 1
// Checksum 0x556df0a, Offset: 0x42b
// Size: 0x20a
function function_2c587df6e340c28d( trap )
{
    trap endon( #"destroy_hazard" );
    trap thread function_530ce0277561a6b();
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( isdefined( attacker ) && damage >= 0 )
        {
            var_3f23721405e49c19 = damage > self.health ? self.health : damage;
            ztron_util::function_eb8ba16055d6da7c( attacker, self, "none", meansofdeath, objweapon, var_3f23721405e49c19, point, undefined, undefined, 0, 0 );
        }
        
        if ( self.health <= 0 )
        {
            if ( isdefined( trap.vfxscriptable ) )
            {
                trap.vfxscriptable setscriptablepartstate( "light", "off" );
                trap.vfxscriptable freescriptable();
            }
            
            crashpoint = ztron_util::function_3fe38741460a4a49( self.origin, -8 );
            traveltime = sqrt( ( self.origin[ 2 ] - crashpoint[ 2 ] - 160 ) * 384 * 2 + squared( 10 ) ) / 384 - 0.0260417;
            self movegravity( ( 0, 0, 10 ), traveltime );
            wait traveltime;
            playfx( utility::getfx( "ztron_nuke" ), crashpoint );
            ztron_sound::ztron_playsound( "droplight_explosion_OS", crashpoint );
            function_9490ef10972cc39d( crashpoint, 200 );
            
            /#
                if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
                {
                    ztron_debug::drawsphere( crashpoint, 180, 3, ( 1, 0, 0 ) );
                }
            #/
            
            thread ztron_util::deletemedelay( 0.1 );
            break;
        }
    }
}

// Namespace ztron_hazard_droplight
// Params 2, eflags: 0x4
// Checksum 0x42397ae0, Offset: 0x63d
// Size: 0xd9
function private function_9490ef10972cc39d( origin, radius )
{
    aigroup = getaiarrayinradius( origin, radius );
    processed = 0;
    
    foreach ( ai in aigroup )
    {
        if ( ai.ztron.boss )
        {
            continue;
        }
        
        ai thread ztron_util::function_ea0a0be5c5468c48( 0.1, undefined, "MOD_ELEMENTAL_ELEC", 0 );
        processed++;
        
        if ( processed > 5 )
        {
            processed = 0;
            waitframe();
        }
    }
}

