// script_7d5674d66b32200f  (hash_7d5674d66b32200f.gscc) (size: 3126 Bytes / 0xc36 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4cc1f1c9 (1287778761)
// size ...... 3126 (0xc36)
// includes .. 6   (offset: 0xb6a)
// strings ... 12  (offset: 0xb9a)
// dev strs .. 0   (offset: 0xc36)
// exports ... 10  (offset: 0x6b2)
// cseg ...... 0xf3 + 0x5bf (0x6b2)
// imports ... 28  (offset: 0x842)
// animtree1 . 0   (offset: 0xc36)
// animtree2 . 0   (offset: 0xc36)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_e75c308a3c565d13;

// Namespace namespace_e75c308a3c565d13
// Params 0, eflags: 0x5
// Checksum 0x448d63df, Offset: 0x111
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ff7043b8cc49d13e", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_e75c308a3c565d13
// Params 0
// Checksum 0x7a0a1237, Offset: 0x13a
// Size: 0x3e
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"oil_trap", #"create", &function_fb91e54bc822db5e );
    ztron_hazard::function_6f661fac5fd31f1( #"oil_trap", #"arenaspawn", &function_8a7187e7bbd2bd94 );
}

// Namespace namespace_e75c308a3c565d13
// Params 2
// Checksum 0x480d73c8, Offset: 0x180
// Size: 0x5a
function function_fb91e54bc822db5e( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_246b28cb2b4b1bc8[ level.ztron.var_246b28cb2b4b1bc8.size ] = trap;
        return;
    }
    
    function_1cec8313c0bcfef3( trap, page );
}

// Namespace namespace_e75c308a3c565d13
// Params 0
// Checksum 0xaff80a0c, Offset: 0x1e2
// Size: 0xb1
function function_8a7187e7bbd2bd94()
{
    level.ztron.var_246b28cb2b4b1bc8 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "oil_trap" );
    
    foreach ( trap in traps )
    {
        function_fb91e54bc822db5e( trap );
    }
}

// Namespace namespace_e75c308a3c565d13
// Params 2
// Checksum 0x26cd1ae2, Offset: 0x29b
// Size: 0x92
function function_1cec8313c0bcfef3( trap, paged )
{
    hazard = utility::spawn_model( %"t10_zm_oil_trap_full_fxanim", trap.origin, trap.angles );
    hazard setcandamage( 1 );
    hazard.maxhealth = 100;
    hazard.health = hazard.maxhealth;
    hazard solid();
    trap.hazard = hazard;
    trap thread function_3085d13d8bce63fc();
}

// Namespace namespace_e75c308a3c565d13
// Params 0, eflags: 0xc
// Checksum 0x3736bdac, Offset: 0x335
// Size: 0x80
function private function_530ce0277561a6b()
{
    self notify( #"hash_525e6f36470d7ba3" );
    self endon( #"hash_525e6f36470d7ba3" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    waitframe();
    
    if ( isdefined( self.hazard ) )
    {
        self.hazard delete();
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger triggerdisable();
    }
}

// Namespace namespace_e75c308a3c565d13
// Params 0
// Checksum 0x48171e64, Offset: 0x3bd
// Size: 0x1ae
function function_3085d13d8bce63fc()
{
    self notify( #"hash_fb066fea9e456f21" );
    self endon( #"hash_fb066fea9e456f21" );
    self endon( #"destroy_hazard" );
    thread function_530ce0277561a6b();
    
    while ( true )
    {
        self.hazard waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( isdefined( attacker ) && damage >= 0 )
        {
            var_3f23721405e49c19 = damage > self.hazard.health ? self.hazard.health : damage;
            ztron_util::function_eb8ba16055d6da7c( attacker, self.hazard, "none", meansofdeath, objweapon, var_3f23721405e49c19, point, undefined, undefined, 0, 0 );
        }
        
        if ( self.hazard.health <= 0 )
        {
            self.hazard thread ztron_util::deletemedelay();
            self.scriptable = spawnscriptable( %"t10_zm_oil_trap_contraption", self.origin, self.angles );
            thread function_57f5c45fbab7529e();
            break;
        }
    }
    
    trigger = ztron_util::function_95ca81ff822c3de4( "oil_trap_trigger_slow", #targetname );
    trigger triggerenable();
    self.trigger = trigger;
    trigger thread function_a98f25d5f136f545( self );
}

// Namespace namespace_e75c308a3c565d13
// Params 0
// Checksum 0x3e08fe71, Offset: 0x573
// Size: 0xad
function function_57f5c45fbab7529e()
{
    self endon( #"destroy_hazard" );
    self.scriptable setscriptablepartstate( "base", "activate" );
    self.scriptable setscriptablepartstate( "sound", "pour_on" );
    self.scriptable setscriptablepartstate( "sound_ground_pool", "sound_on" );
    wait 22;
    self.scriptable setscriptablepartstate( "base", "cooldown" );
    self.scriptable setscriptablepartstate( "sound", "pour_off" );
    self.scriptable setscriptablepartstate( "sound_ground_pool", "sound_off" );
    self notify( #"hash_516c46751efb4567" );
}

// Namespace namespace_e75c308a3c565d13
// Params 1, eflags: 0x4
// Checksum 0x2f3387f5, Offset: 0x628
// Size: 0x8a
function private function_a98f25d5f136f545( trap )
{
    trap endon( #"destroy_hazard" );
    trap endon( #"hash_516c46751efb4567" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( ent.no_hazards || ent.ztron.boss )
        {
            continue;
        }
        
        if ( isagent( ent ) )
        {
            ent thread ztron_enemy_ai::function_bc65bed6aed12009( 3, 0.5 );
        }
    }
}

