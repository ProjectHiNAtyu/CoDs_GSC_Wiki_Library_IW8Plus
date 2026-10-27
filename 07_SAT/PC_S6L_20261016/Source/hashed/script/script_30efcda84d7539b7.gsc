// script_30efcda84d7539b7  (hash_30efcda84d7539b7.gscc) (size: 6724 Bytes / 0x1a44 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1105d98d (285596045)
// size ...... 6724 (0x1a44)
// includes .. 8   (offset: 0x1928)
// strings ... 14  (offset: 0x1968)
// dev strs .. 0   (offset: 0x1a44)
// exports ... 23  (offset: 0xf54)
// cseg ...... 0x17e + 0xdd6 (0xf54)
// imports ... 52  (offset: 0x12ec)
// animtree1 . 0   (offset: 0x1a44)
// animtree2 . 0   (offset: 0x1a44)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_fungus;

// Namespace ztron_hazard_fungus
// Params 0, eflags: 0x5
// Checksum 0x8d2219c4, Offset: 0x19c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_fungus", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x43d83b43, Offset: 0x1c5
// Size: 0x64
function init()
{
    level.ztron.var_ef14d0f5480327cd = 0;
    ztron_hazard::function_6f661fac5fd31f1( #"hazard_fungus", #"create", &createhazard );
    ztron_hazard::function_6f661fac5fd31f1( #"hazard_fungus", #"arenaspawn", &arenahazard );
    utility::add_fx( "ztron_spores_fx", "vfx_sat_zm_parasite_hive_exp_ztron" );
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x8eb35ac5, Offset: 0x231
// Size: 0xce
function arenahazard()
{
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "hazard_fungus" );
    
    if ( traps.size > 0 )
    {
        var_91d1499c80900333 = arrayrandomize( traps );
        
        foreach ( trap in var_91d1499c80900333 )
        {
            trap.canactivated = &function_fa792c6dbdaddb48;
            trap thread activatefungus();
            trap thread fungusdeathwatcher();
        }
    }
}

// Namespace ztron_hazard_fungus
// Params 2
// Checksum 0x406a5ed9, Offset: 0x307
// Size: 0x38
function createhazard( trap, page )
{
    trap.canactivated = &function_dec103e75f19b97c;
    trap thread function_ec67c688a1061cc8();
    trap thread fungusdeathwatcher();
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0xe155d1cf, Offset: 0x347
// Size: 0x46, Type: bool
function function_fa792c6dbdaddb48()
{
    return level.ztron.var_ef14d0f5480327cd < ( level.ztron.active_arena.var_50cd3f3dd72a4817 ?? 3 ) && !self.activated;
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x235be6e, Offset: 0x396
// Size: 0x1e, Type: bool
function function_dec103e75f19b97c()
{
    return gettime() >= self.var_2d8041df79adb2db && !self.activated;
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0xd07ba9d5, Offset: 0x3bd
// Size: 0x5d
function function_ec67c688a1061cc8()
{
    self notify( #"hash_bcd2e9302e8b7872" );
    self endon( #"hash_bcd2e9302e8b7872" );
    level endon( #"game_reset" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    self.var_2d8041df79adb2db = gettime();
    
    while ( true )
    {
        thread activatefungus();
        wait 1;
    }
}

// Namespace ztron_hazard_fungus
// Params 1
// Checksum 0x40864564, Offset: 0x422
// Size: 0x2e
function function_e4213d20013a2c58( delay )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    wait delay;
    thread activatefungus();
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x29dc5821, Offset: 0x458
// Size: 0x77
function activatefungus()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    
    if ( !isdefined( self.fungus ) )
    {
        self.fungus = utility::spawn_model( "ztron_hazard_fungus_fxanim_sm", self.origin, self.angles );
    }
    
    if ( isdefined( self.canactivated ) && self [[ self.canactivated ]]() )
    {
        function_ad9901df5119f7b();
        thread function_bce3ed23709b957a();
    }
}

// Namespace ztron_hazard_fungus
// Params 1
// Checksum 0x9e7bcba4, Offset: 0x4d7
// Size: 0x50
function function_6227e98dcb12364c( sporesenabled )
{
    self.fungus enableaimassist();
    self.fungus.sporesenabled = sporesenabled;
    self.fungus setcandamage( 1 );
    thread function_6729ef659ab956e7( self.fungus );
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0xbe48023, Offset: 0x52f
// Size: 0x187
function function_bce3ed23709b957a()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    self endon( #"explode" );
    self.fungus setscriptablepartstate( "fungus_base", "grow" );
    function_6227e98dcb12364c( 0 );
    wait 0.25;
    self.fungus delete();
    self.fungus = utility::spawn_model( "ztron_hazard_fungus_fxanim_med", self.origin, self.angles );
    function_6227e98dcb12364c( 0 );
    wait 2;
    self.fungus setscriptablepartstate( "fungus_base", "grow" );
    wait 0.25;
    self.fungus delete();
    self.fungus = utility::spawn_model( "ztron_hazard_fungus_fxanim_lg", self.origin, self.angles );
    function_6227e98dcb12364c( 1 );
    
    if ( !isdefined( self.trigger ) )
    {
        self.trigger = spawn( "trigger_rotatable_radius", self.fungus.origin, 0, 80, 30 );
        self.trigger.owner = self;
        self.trigger.angles = self.angles;
    }
    
    childthread function_2ff4e20b5c5cc3bc( self.trigger );
    
    /#
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            childthread drawtrigger( self.trigger );
        }
    #/
}

// Namespace ztron_hazard_fungus
// Params 1
// Checksum 0xac53a1af, Offset: 0x6be
// Size: 0xa9
function function_6729ef659ab956e7( fungus )
{
    self notify( #"hash_9839c3e4d2cec59e" );
    self endon( #"hash_9839c3e4d2cec59e" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    fungus.health = 200;
    
    while ( isdefined( fungus ) && fungus.health > 0 )
    {
        fungus waittill( #"damage", amount, attacker );
        fungus.health -= amount;
    }
    
    childthread fungusexplode();
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x599f6ac4, Offset: 0x76f
// Size: 0x1c4
function fungusexplode()
{
    self notify( #"hash_dd5614923ba6e6e8" );
    self endon( #"hash_dd5614923ba6e6e8" );
    var_abda563a96628c94 = self.origin + ( 0, 0, 50 );
    playersinradius = getplayersinradius( var_abda563a96628c94, 80 );
    
    foreach ( player in playersinradius )
    {
        if ( !isalive( player ) || player.no_hazards || player vehicle::is_vehicle() )
        {
            continue;
        }
        
        player dodamage( 50, var_abda563a96628c94, undefined, undefined, "MOD_EXPLOSIVE" );
    }
    
    ztron_util::function_7e8b8153f3f2566( var_abda563a96628c94, 80, 50, undefined, "MOD_EXPLOSIVE" );
    activatespore = self.fungus.sporesenabled;
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.fungus ) )
    {
        self.fungus delete();
    }
    
    self.fungus = utility::spawn_model( "ztron_hazard_fungus_fxanim_sm", self.origin, self.angles );
    self.fungus setscriptablepartstate( "alive_or_death", "death" );
    function_35dc4173d19d64b2();
    function_e7ab712c045bf13d();
    
    if ( activatespore )
    {
        thread createspores();
    }
    
    self notify( #"explode" );
}

// Namespace ztron_hazard_fungus
// Params 0, eflags: 0x4
// Checksum 0x1ef8a22f, Offset: 0x93b
// Size: 0xea
function private function_e7ab712c045bf13d()
{
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "hazard_fungus" );
        var_91d1499c80900333 = arrayrandomize( traps );
        
        foreach ( trap in var_91d1499c80900333 )
        {
            if ( !trap.activated && !trap.delayactivate )
            {
                trap.delayactivate = 1;
                trap thread function_e4213d20013a2c58( 10 );
                break;
            }
        }
    }
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0xc59a2727, Offset: 0xa2d
// Size: 0x63
function function_1c578e9f72d1bd35()
{
    self notify( #"hash_2ab85996f1737c33" );
    self endon( #"hash_2ab85996f1737c33" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    self endon( #"explode" );
    self.fungus setscriptablepartstate( "fungus_base", "shaking" );
    wait 1.5;
    thread fungusexplode();
}

// Namespace ztron_hazard_fungus
// Params 1
// Checksum 0x723dac34, Offset: 0xa98
// Size: 0x9a
function function_2ff4e20b5c5cc3bc( trigger )
{
    self notify( #"hash_50dea4efbddfb8a2" );
    self endon( #"hash_50dea4efbddfb8a2" );
    trigger endon( #"death" );
    self endon( #"destroy_hazard" );
    self endon( #"explode" );
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( ent.no_hazards )
        {
            continue;
        }
        
        if ( isplayer( ent ) || ent vehicle::is_vehicle() )
        {
            thread function_1c578e9f72d1bd35();
            return;
        }
    }
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x8a685087, Offset: 0xb3a
// Size: 0xf2
function fungusdeathwatcher()
{
    self notify( #"hash_a4320b85b9ceea95" );
    self endon( #"hash_a4320b85b9ceea95" );
    level endon( #"ztron_game_is_over" );
    childthread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.fungus ) )
    {
        self.fungus delete();
        self.fungus = undefined;
    }
    
    if ( isdefined( self.fxorg ) )
    {
        stopfxontag( utility::getfx( "ztron_spores_fx" ), self.fxorg, "tag_origin" );
        self.fxorg.trigger delete();
        self.fxorg delete();
        self.fxorg = undefined;
    }
    
    if ( self.activated )
    {
        function_35dc4173d19d64b2();
    }
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x9c8be89b, Offset: 0xc34
// Size: 0x35
function function_ad9901df5119f7b()
{
    level.ztron.var_ef14d0f5480327cd++;
    self.activated = 1;
    self.delayactivate = 0;
    self.var_2d8041df79adb2db = undefined;
}

// Namespace ztron_hazard_fungus
// Params 0
// Checksum 0x3101ce84, Offset: 0xc71
// Size: 0x31
function function_35dc4173d19d64b2()
{
    level.ztron.var_ef14d0f5480327cd--;
    self.activated = 0;
    self.var_2d8041df79adb2db = gettime() + 10000;
}

// Namespace ztron_hazard_fungus
// Params 1
// Checksum 0xd9dc2538, Offset: 0xcaa
// Size: 0x17e
function createspores( position )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    
    if ( !isdefined( self.fxorg ) )
    {
        self.fxorg = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self.fxorg.trigger = spawn( "trigger_rotatable_radius", self.origin, 0, 70, 30 );
        self.fxorg.trigger.angles = self.angles;
        
        /#
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                childthread drawtrigger( self.fxorg.trigger, ( 0, 0, 1 ) );
            }
        #/
    }
    
    playfxontag( utility::getfx( "ztron_spores_fx" ), self.fxorg, "tag_origin" );
    thread sporeswatcher( self.fxorg.trigger );
    wait 8;
    
    if ( isdefined( self.fxorg ) )
    {
        stopfxontag( utility::getfx( "ztron_spores_fx" ), self.fxorg, "tag_origin" );
        self.fxorg.trigger delete();
        self.fxorg delete();
        self.fxorg = undefined;
    }
}

// Namespace ztron_hazard_fungus
// Params 1
// Checksum 0xb2ee8d57, Offset: 0xe30
// Size: 0x9c
function sporeswatcher( trigger )
{
    self notify( #"hash_bc2a5d0d0f4ac4ca" );
    self endon( #"hash_bc2a5d0d0f4ac4ca" );
    trigger endon( #"death" );
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( ent.no_hazards || ent.ztron.boss )
        {
            continue;
        }
        
        if ( isagent( ent ) || isplayer( ent ) )
        {
            ent thread ztron_enemy_ai::function_bc65bed6aed12009( 3 );
        }
    }
}

/#

    // Namespace ztron_hazard_fungus
    // Params 2
    // Checksum 0xc263f9be, Offset: 0xed4
    // Size: 0x80, Type: dev
    function drawtrigger( trigger, color )
    {
        self notify( #"hash_25c8e9b90bf29f72" );
        self endon( #"hash_25c8e9b90bf29f72" );
        level endon( #"ztron_game_is_over" );
        self endon( #"destroy_hazard" );
        
        while ( isdefined( trigger ) )
        {
            drawtrigger( trigger, color ?? ( 0, 1, 0 ), 0, 0, 0, color ?? ( 0, 1, 0 ) );
            waitframe();
        }
    }

#/
