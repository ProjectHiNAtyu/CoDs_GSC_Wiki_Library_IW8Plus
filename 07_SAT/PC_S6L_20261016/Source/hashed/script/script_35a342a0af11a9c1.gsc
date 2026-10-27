// script_35a342a0af11a9c1  (hash_35a342a0af11a9c1.gscc) (size: 6007 Bytes / 0x1777 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x424e089d (1112410269)
// size ...... 6007 (0x1777)
// includes .. 7   (offset: 0x161b)
// strings ... 19  (offset: 0x1653)
// dev strs .. 0   (offset: 0x1777)
// exports ... 16  (offset: 0xd77)
// cseg ...... 0x23e + 0xb39 (0xd77)
// imports ... 52  (offset: 0xff7)
// animtree1 . 0   (offset: 0x1777)
// animtree2 . 0   (offset: 0x1777)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\weapons\weap_jetgun;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_barrel;

// Namespace ztron_hazard_barrel
// Params 0, eflags: 0x5
// Checksum 0xf0c9137c, Offset: 0x25c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_barrel", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_barrel
// Params 0
// Checksum 0x4251e6e7, Offset: 0x285
// Size: 0x84
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"explo_barrel", #"create", &function_7aa6c319632dfb08 );
    ztron_hazard::function_6f661fac5fd31f1( #"explo_barrel", #"arenaspawn", &function_4faea93ecf5fa77e );
    ztron_sound::function_4ac735395b173fe( "barrel_explo", "evt_ztron_hazard_redbarrel_explosion" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_redbarrel_ignite", "evt_ztron_hazard_redbarrel_ignite" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_redbarrel_warning", "evt_ztron_hazard_redbarrel_warning" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_redbarrel_fuse_lp", "evt_ztron_hazard_redbarrel_fuse_lp", 1 );
}

// Namespace ztron_hazard_barrel
// Params 0
// Checksum 0xefb1e1af, Offset: 0x311
// Size: 0xb1
function function_4faea93ecf5fa77e()
{
    level.ztron.var_95086e2475901c6a = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "explo_barrel" );
    
    foreach ( trap in traps )
    {
        function_7aa6c319632dfb08( trap );
    }
}

// Namespace ztron_hazard_barrel
// Params 2
// Checksum 0x26cad11c, Offset: 0x3ca
// Size: 0x59
function function_7aa6c319632dfb08( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_95086e2475901c6a[ level.ztron.var_95086e2475901c6a.size ] = trap;
        return;
    }
    
    function_d7d7e597d487d1ed( trap );
}

// Namespace ztron_hazard_barrel
// Params 0
// Checksum 0x2efa4922, Offset: 0x42b
// Size: 0x7a
function function_15ada21adea99bfa()
{
    self notify( #"hash_350249f54d4b8970" );
    self endon( #"hash_350249f54d4b8970" );
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    stopfxontag( utility::getfx( "ztron_barrel_fire" ), self, "tag_origin" );
    stopfxontag( utility::getfx( "ztron_barrel_fire_top" ), self, "tag_origin" );
    ztron_sound::ztron_stopsound( self );
    wait 0.5;
    self delete();
}

// Namespace ztron_hazard_barrel
// Params 0, eflags: 0x4
// Checksum 0x6fcf16c9, Offset: 0x4ad
// Size: 0x1b
function private function_2b41fd5a66cc804()
{
    level waittill( #"arena_round_leaving" );
    self notify( #"destroy_hazard" );
}

// Namespace ztron_hazard_barrel
// Params 3
// Checksum 0x3300a38d, Offset: 0x4d0
// Size: 0x2c8
function function_e9ee3270d8320341( fusetime, var_aa2f6296a24a5adc = 1, var_6c1a138f995e6e8f )
{
    self notify( #"hash_d6e4889725019f24" );
    self endon( #"hash_d6e4889725019f24" );
    self endon( #"death" );
    self.fusing = 1;
    childthread function_2b41fd5a66cc804();
    playfxontag( utility::getfx( "ztron_barrel_fire_top" ), self, "tag_origin" );
    ztron_sound::ztron_playsound( "ztron_hazard_redbarrel_ignite", self.origin );
    ztron_sound::ztron_playsound( "ztron_hazard_redbarrel_fuse_lp", undefined, self );
    var_b83e873ca2013e32 = gettime() + fusetime * 1000;
    stage1 = var_b83e873ca2013e32 - 4500;
    var_6d7f0d0b96556ab3 = 0;
    
    while ( true )
    {
        time = gettime();
        
        if ( time >= var_b83e873ca2013e32 )
        {
            break;
        }
        
        result = function_7feaf895937aebd( 0.5 );
        
        if ( result.damage > 0 )
        {
            if ( result.meansofdeath == "MOD_EXPLOSIVE" )
            {
                var_be810749c96d2cdd = 4000 * var_aa2f6296a24a5adc;
            }
            else
            {
                var_be810749c96d2cdd = 1000 * var_aa2f6296a24a5adc;
            }
            
            var_b83e873ca2013e32 -= var_be810749c96d2cdd;
            stage1 -= var_be810749c96d2cdd;
        }
        
        if ( !var_6d7f0d0b96556ab3 && time > stage1 )
        {
            var_6d7f0d0b96556ab3 = 1;
            playfxontag( utility::getfx( "ztron_explosive_warning_light" ), self, "tag_origin" );
            ztron_sound::ztron_playsound( "ztron_hazard_redbarrel_warning", undefined, self );
        }
    }
    
    wait randomfloatrange( 0.1, 1 );
    self notsolid();
    playfxontag( utility::getfx( "ztron_explode_red_barrel" ), self, "tag_origin" );
    stopfxontag( utility::getfx( "ztron_barrel_fire_top" ), self, "tag_origin" );
    stopfxontag( utility::getfx( "ztron_explosive_warning_light" ), self, "tag_origin" );
    ztron_sound::ztron_playsound( "barrel_explo", self.origin );
    ztron_sound::ztron_stopsound( self );
    self setcandamage( 0 );
    ztron_util::radialdamage( self.origin + ( 0, 0, 15 ), 60, 160, 200, 65 * level.ztron.roundnumber );
    physicsexplosionsphere( self.origin, 384, 256, 100 );
    self disableaimassist();
    
    if ( isdefined( self.dest_model ) )
    {
        self setmodel( self.dest_model );
        self solid();
        self physicslaunchserver( self.origin, ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 5 ) );
        wait 1;
        playfxontag( utility::getfx( "ztron_barrel_fire" ), self, "tag_origin" );
        self notsolid();
        thread ztron_util::deletemedelay( 0.5 );
        return;
    }
    
    waitframe();
    self delete();
}

// Namespace ztron_hazard_barrel
// Params 1
// Checksum 0x7fccc04, Offset: 0x7a0
// Size: 0x4e
function function_7feaf895937aebd( timeout )
{
    notifystruct = spawnstruct();
    resultstruct = spawnstruct();
    thread function_f2b2fda026d8da1b( notifystruct, resultstruct );
    thread barrel_waittill_timeout( notifystruct, timeout );
    notifystruct waittill( #"waittill_proc" );
    return resultstruct;
}

// Namespace ztron_hazard_barrel
// Params 2
// Checksum 0x5704e57a, Offset: 0x7f7
// Size: 0xa8
function function_f2b2fda026d8da1b( notifystruct, resultstruct )
{
    notifystruct endon( #"waittill_proc" );
    self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
    resultstruct.damage = damage;
    resultstruct.attacker = attacker;
    resultstruct.dir = direction_vec;
    resultstruct.meansofdeath = meansofdeath;
    notifystruct notify( #"waittill_proc" );
}

// Namespace ztron_hazard_barrel
// Params 2
// Checksum 0xcea0163b, Offset: 0x8a7
// Size: 0x32
function barrel_waittill_timeout( notifystruct, timeout )
{
    notifystruct endon( #"waittill_proc" );
    wait timeout;
    notifystruct notify( #"waittill_proc" );
}

// Namespace ztron_hazard_barrel
// Params 1, eflags: 0x4
// Checksum 0x76210bef, Offset: 0x8e1
// Size: 0x33, Type: bool
function private function_c11d3b31f28ff0ae( meansofdeath )
{
    if ( meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_hazard_barrel
// Params 3, eflags: 0x4
// Checksum 0x529f6875, Offset: 0x91d
// Size: 0x13e
function private getimpulse( attacker, meansofdeath, dir )
{
    impulse = dir + ( 0, 0, 5 );
    
    if ( function_c11d3b31f28ff0ae( meansofdeath ) )
    {
        return ( impulse * 30 );
    }
    
    var_87ea1567421eedd1 = 6;
    
    if ( !isplayer( attacker ) )
    {
        return ( impulse * var_87ea1567421eedd1 );
    }
    
    currentweapon = attacker getcurrentweapon();
    
    if ( !isnullweapon( currentweapon ) )
    {
        impulse = ( dir[ 0 ], dir[ 1 ], 0 );
        
        switch ( currentweapon.basenamehash )
        {
            case %"sat_la_ztronpable3_mp":
                var_87ea1567421eedd1 = 1500;
                break;
            case %"sat_ar_ztrondg2_mp":
            case %"sat_pi_ztronraygun_mp":
                var_87ea1567421eedd1 = 800;
                break;
            case %"sat_la_ztronwarmachine_mp":
                var_87ea1567421eedd1 = 1500;
                break;
            case %"sat_la_ztroncrossbow_mp":
                var_87ea1567421eedd1 = 1300;
                break;
            case %"sat_lm_ztronlmg_mp":
            case %"sat_lm_ztrondeathmachine_mp":
            case %"sat_sh_ztronshotgun_mp":
                var_87ea1567421eedd1 = 1200;
                break;
            default:
                var_87ea1567421eedd1 = 800;
                break;
        }
    }
    
    return impulse * var_87ea1567421eedd1;
}

// Namespace ztron_hazard_barrel
// Params 4
// Checksum 0x35aa86d2, Offset: 0xa64
// Size: 0x145
function function_e589d3e643949b6( damaged = 0, barrel, fusetime = 8, var_aa2f6296a24a5adc = 1 )
{
    self notify( #"hash_43900fe3b62a15dd" );
    self endon( #"hash_43900fe3b62a15dd" );
    barrel endon( #"death" );
    barrel thread function_15ada21adea99bfa();
    
    if ( damaged && !barrel.fusing )
    {
        barrel thread function_e9ee3270d8320341( fusetime, var_aa2f6296a24a5adc );
    }
    
    while ( true )
    {
        barrel waittill( #"damage", amt, attacker, dir, point, meansofdeath );
        
        if ( !damaged )
        {
            barrel connectpaths();
            
            if ( !barrel.fusing )
            {
                barrel thread function_e9ee3270d8320341( fusetime, var_aa2f6296a24a5adc );
            }
        }
        
        if ( isdefined( dir ) )
        {
            impulse = getimpulse( attacker, meansofdeath, vectornormalize( dir ) );
            
            if ( function_c11d3b31f28ff0ae( meansofdeath ) )
            {
                fusetime -= 7;
            }
            
            barrel physicslaunchserver( barrel.origin, impulse );
        }
    }
}

// Namespace ztron_hazard_barrel
// Params 8
// Checksum 0xb154b9ed, Offset: 0xbb1
// Size: 0xed
function hazard_spawn_barrel( model, destmodel, origin, angles, disconnect = 1, damage = 0, fusetime, var_aa2f6296a24a5adc = 1 )
{
    var_4d080f710fb8349e = utility::spawn_model( model, origin, angles );
    weap_jetgun::function_d997e6e75c25fc99( var_4d080f710fb8349e );
    
    if ( isdefined( var_4d080f710fb8349e ) )
    {
        var_4d080f710fb8349e.dest_model = destmodel;
        var_4d080f710fb8349e.hazardtype = "barrel";
        var_4d080f710fb8349e setcandamage( 1 );
        var_4d080f710fb8349e.health = 100000;
        var_4d080f710fb8349e solid();
        
        if ( disconnect )
        {
            var_4d080f710fb8349e disconnectpaths();
        }
        
        var_4d080f710fb8349e enableaimassist();
        thread function_e589d3e643949b6( damage, var_4d080f710fb8349e, 8, var_aa2f6296a24a5adc );
    }
    
    return var_4d080f710fb8349e;
}

// Namespace ztron_hazard_barrel
// Params 3
// Checksum 0xc68b3cec, Offset: 0xca7
// Size: 0xcf
function function_d7d7e597d487d1ed( trap, paged = 0, modelname = %"decor_barrels_gameplay_flammable_ztron" )
{
    if ( isdefined( trap.script_string ) )
    {
        args = strtok( trap.script_string, ";" );
        
        if ( isdefined( args[ 0 ] ) )
        {
            modelname = args[ 0 ];
        }
        
        if ( isdefined( args[ 1 ] ) )
        {
            destmodel = args[ 1 ];
        }
    }
    
    var_4d080f710fb8349e = trap hazard_spawn_barrel( modelname, destmodel, trap.origin, trap.angles );
    trap.script_model = var_4d080f710fb8349e;
    trap.paged = paged;
    return trap;
}

