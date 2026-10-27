// script_1e6ea23f2c4b4da0  (hash_1e6ea23f2c4b4da0.gscc) (size: 5230 Bytes / 0x146e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe217abb4 (3793202100)
// size ...... 5230 (0x146e)
// includes .. 9   (offset: 0x132a)
// strings ... 15  (offset: 0x1372)
// dev strs .. 2   (offset: 0x1456)
// exports ... 14  (offset: 0xb1e)
// cseg ...... 0x16d + 0x9b1 (0xb1e)
// imports ... 51  (offset: 0xd4e)
// animtree1 . 0   (offset: 0x146e)
// animtree2 . 0   (offset: 0x146e)
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_snowman;

// Namespace ztron_hazard_snowman
// Params 0, eflags: 0x5
// Checksum 0x4ea3b465, Offset: 0x18b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_snowman", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_snowman
// Params 0
// Checksum 0x404c453a, Offset: 0x1b4
// Size: 0x4f
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"snowman", #"create", &createhazard );
    ztron_hazard::function_6f661fac5fd31f1( #"snowman", #"arenaspawn", &function_dd69092e9f7a9a58 );
    ztron_sound::function_4ac735395b173fe( "ztron_snowman_fire", "evt_ztron_hazard_snowman_fire" );
}

// Namespace ztron_hazard_snowman
// Params 0
// Checksum 0x373aaa6b, Offset: 0x20b
// Size: 0xca
function function_dd69092e9f7a9a58()
{
    if ( !isdefined( level.ztron.active_arena ) )
    {
        return;
    }
    
    level.ztron.var_e90e0e5087a80eff = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "snowman" );
    
    foreach ( trap in traps )
    {
        createhazard( trap );
    }
}

// Namespace ztron_hazard_snowman
// Params 2
// Checksum 0xc060893c, Offset: 0x2dd
// Size: 0x59
function createhazard( trap, paged = 0 )
{
    if ( paged )
    {
        level.ztron.var_e90e0e5087a80eff[ level.ztron.var_e90e0e5087a80eff.size ] = trap;
        return;
    }
    
    instancehazard( trap );
}

// Namespace ztron_hazard_snowman
// Params 2, eflags: 0x4
// Checksum 0xd8ff4086, Offset: 0x33e
// Size: 0xe1
function private instancehazard( trap, paged )
{
    if ( !isdefined( trap ) )
    {
        return;
    }
    
    var_4d080f710fb8349e = utility::spawn_model( "tag_origin", trap.origin, trap.angles );
    scriptable = spawnscriptable( "ztron_snowman", trap.origin, trap.angles );
    waitframe();
    
    if ( !isdefined( var_4d080f710fb8349e ) )
    {
        scriptable freescriptable();
        return;
    }
    
    scriptable scriptablesetparententity( var_4d080f710fb8349e, ( 0, 0, 0 ), ( 0, 90, 0 ) );
    trap.script_model = var_4d080f710fb8349e;
    trap.scriptable = scriptable;
    trap thread snowmanthink( var_4d080f710fb8349e );
    trap thread function_63fe16e7d08df9e3( var_4d080f710fb8349e );
    trap thread function_530ce0277561a6b( var_4d080f710fb8349e );
    return trap;
}

// Namespace ztron_hazard_snowman
// Params 1, eflags: 0xc
// Checksum 0x6bbd9e89, Offset: 0x428
// Size: 0x44
function private function_6b7b89fbee972527( msg )
{
    self notify( #"hash_7c25e07a601d6eea" );
    self endon( #"hash_7c25e07a601d6eea" );
    self waittill( msg, ent );
    self notify( #"returned", ent );
}

// Namespace ztron_hazard_snowman
// Params 0, eflags: 0xc
// Checksum 0xeadeb2c7, Offset: 0x474
// Size: 0x5e
function private function_14e9ef44f3bad6b7()
{
    self notify( #"hash_90ce455442268fb9" );
    self endon( #"hash_90ce455442268fb9" );
    lifetime = 10;
    
    while ( lifetime > 0 )
    {
        lifetime -= 0.5;
        println( "<dev string:x24>" + lifetime );
        wait 0.5;
    }
    
    self notify( #"hash_8ac3ddd7bf779f83" );
}

// Namespace ztron_hazard_snowman
// Params 1, eflags: 0xc
// Checksum 0xf3d4ed20, Offset: 0x4da
// Size: 0xea
function private function_3c9019478935ca37( duration = 3 )
{
    self notify( #"hash_7314959eb3be3e5d" );
    self endon( #"hash_7314959eb3be3e5d" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.no_hazards || self.ztron.boss )
    {
        return;
    }
    
    if ( self isscriptable() && self getscriptablehaspart( "ltm_mode_fx" ) )
    {
        utility::function_32b24db3127bff40( "ltm_mode_fx", "jh_freeze_on" );
    }
    
    if ( !ztron_hazard::function_8131aea7eb196354( "ztron_snowball" ) )
    {
        ztron_hazard::function_4512b7715789e4cf( "ztron_snowball", 0.5, 1 );
    }
    
    wait duration;
    
    if ( self isscriptable() && self getscriptablehaspart( "ltm_mode_fx" ) )
    {
        utility::function_32b24db3127bff40( "ltm_mode_fx", "jh_freeze_off" );
    }
    
    if ( ztron_hazard::function_8131aea7eb196354( "ztron_snowball" ) )
    {
        ztron_hazard::function_986fc44dada307f4( "ztron_snowball", 1 );
    }
}

// Namespace ztron_hazard_snowman
// Params 1, eflags: 0xc
// Checksum 0xb3efea59, Offset: 0x5cc
// Size: 0xe8
function private function_8935bb92247bcb4( duration = 3 )
{
    self notify( #"hash_64da5737d5b953a6" );
    self endon( #"hash_64da5737d5b953a6" );
    
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( self.no_hazards || self.ztron.boss )
    {
        return;
    }
    
    if ( self isscriptable() && self getscriptablehaspart( "cryofreeze" ) )
    {
        utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_on" );
    }
    
    if ( !effect_slow::function_6fab6266b5f636c3() )
    {
        effect_slow::slow( "ztron_snowball", 0.5, 9999, undefined, undefined, 1, "cold" );
    }
    
    wait duration;
    
    if ( self isscriptable() && self getscriptablehaspart( "cryofreeze" ) )
    {
        utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_shatter" );
    }
    
    if ( effect_slow::function_6fab6266b5f636c3() )
    {
        effect_slow::function_80a4bd13b5ba303a( "ztron_snowball" );
    }
}

// Namespace ztron_hazard_snowman
// Params 0
// Checksum 0x565530e4, Offset: 0x6bc
// Size: 0x1ed
function function_15bcd092f286a6c8()
{
    self notify( #"hash_f53f46d008d31fe" );
    self endon( #"hash_f53f46d008d31fe" );
    self endon( #"hash_8ac3ddd7bf779f83" );
    thread function_14e9ef44f3bad6b7();
    self waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    triggerorigin = origin - ( 0, 0, 25 );
    trigger = spawn( "noent_volume_trigger_radius", triggerorigin, 0, 50, 50 );
    
    /#
        println( "<dev string:x44>" + origin );
        
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            ztron_debug::drawsphere( origin, 50, 1, ( 0, 1, 0 ) );
            trigger thread ztron_debug::drawtrigger();
        }
    #/
    
    zombies = getaiarrayinradius( origin, 150 );
    players = ztron_player_utility::getplayersinradius( origin, 22500 );
    
    foreach ( player in players )
    {
        if ( player istouching( trigger ) )
        {
            player thread function_3c9019478935ca37();
        }
    }
    
    foreach ( zombie in zombies )
    {
        if ( zombie istouching( trigger ) )
        {
            zombie thread function_8935bb92247bcb4();
        }
    }
    
    trigger delete();
}

// Namespace ztron_hazard_snowman
// Params 1, eflags: 0xc
// Checksum 0xe6377ac6, Offset: 0x8b1
// Size: 0x76
function private function_63fe16e7d08df9e3( var_4d080f710fb8349e )
{
    self notify( #"hash_927aa17ef8c2b887" );
    self endon( #"hash_927aa17ef8c2b887" );
    var_4d080f710fb8349e endon( #"death" );
    half_time = 2;
    
    while ( true )
    {
        var_298ec28014bdca69 = var_4d080f710fb8349e.angles + ( 0, 180, 0 );
        var_4d080f710fb8349e rotateto( var_298ec28014bdca69, half_time );
        wait half_time;
    }
}

// Namespace ztron_hazard_snowman
// Params 1, eflags: 0xc
// Checksum 0x67a02761, Offset: 0x92f
// Size: 0x16d
function private snowmanthink( var_4d080f710fb8349e )
{
    self notify( #"hash_642fa187776b272f" );
    self endon( #"hash_642fa187776b272f" );
    level endon( #"ztron_game_is_over" );
    var_4d080f710fb8349e endon( #"death" );
    minwait = 2;
    maxwait = 4;
    
    while ( true )
    {
        closestplayer = ztron_util::function_5daccb5b5c655ae5( var_4d080f710fb8349e.origin, 1800 );
        
        if ( !isdefined( closestplayer ) )
        {
            wait 2;
            continue;
        }
        
        for ( rounds = randomint( 3 ) + 1; rounds > 0 ; rounds-- )
        {
            var_db2ccbc2bfce7c36 = var_4d080f710fb8349e.angles;
            launchdir = anglestoforward( var_db2ccbc2bfce7c36 );
            var_883ef4d2502c5b4 = var_4d080f710fb8349e.origin + ( 0, 0, 52 ) + 20 * launchdir;
            start = var_883ef4d2502c5b4;
            end = start + 10000 * launchdir;
            missile = magicbullet( "sat_snowball_ztron", start, end );
            missile thread ztron_util::function_f7544bfa701db406( var_4d080f710fb8349e );
            missile thread function_15bcd092f286a6c8();
            ztron_sound::ztron_playsound( "ztron_snowman_fire", undefined, self.var_4d080f710fb8349e );
            wait randomfloatrange( 0.5, 1.5 );
        }
        
        wait randomfloatrange( minwait, maxwait );
    }
}

// Namespace ztron_hazard_snowman
// Params 1, eflags: 0x4
// Checksum 0x3f1d3a91, Offset: 0xaa4
// Size: 0x7a
function private function_530ce0277561a6b( var_4d080f710fb8349e )
{
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    self waittill( #"destroy_hazard" );
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model thread ztron_util::deletemedelay();
        self.script_model = undefined;
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
        self.scriptable = undefined;
    }
}

