// script_765e03d786b4ec4  (hash_0765e03d786b4ec4.gscc) (size: 2703 Bytes / 0xa8f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5082ccd (84421837)
// size ...... 2703 (0xa8f)
// includes .. 7   (offset: 0x9df)
// strings ... 9   (offset: 0xa17)
// dev strs .. 0   (offset: 0xa8f)
// exports ... 7   (offset: 0x5e3)
// cseg ...... 0x10c + 0x4d7 (0x5e3)
// imports ... 26  (offset: 0x6fb)
// animtree1 . 0   (offset: 0xa8f)
// animtree2 . 0   (offset: 0xa8f)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_fireball;

// Namespace ztron_hazard_fireball
// Params 0, eflags: 0x5
// Checksum 0x8acc71b4, Offset: 0x12a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_fireball", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_fireball
// Params 0
// Checksum 0x4c8dba8e, Offset: 0x153
// Size: 0x4f
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"fireball", #"create", &function_f8b3e1f72186d094 );
    ztron_hazard::function_6f661fac5fd31f1( #"fireball", #"arenaspawn", &function_5efc8ea63b8db9bb );
    ztron_sound::function_4ac735395b173fe( "ztron_fireball_emit", "zmb_ztron_fireball_emit" );
}

// Namespace ztron_hazard_fireball
// Params 0
// Checksum 0x2f714546, Offset: 0x1aa
// Size: 0x4a
function function_307b74ef26cc307f()
{
    self notify( #"hash_e46ff54a43f0c4d8" );
    self endon( #"hash_e46ff54a43f0c4d8" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    waitframe();
    
    if ( isdefined( self.var_4d080f710fb8349e ) )
    {
        self.var_4d080f710fb8349e delete();
    }
}

// Namespace ztron_hazard_fireball
// Params 2
// Checksum 0x59f97505, Offset: 0x1fc
// Size: 0x11d
function function_f8b3e1f72186d094( trap, paged )
{
    trap.weapon = level.ztron.fireballweapon;
    
    if ( isdefined( trap.script_parameters ) )
    {
        toks = strtok( trap.script_parameters, ";" );
        
        if ( toks.size > 0 )
        {
            trap.model = toks[ 0 ];
            
            if ( toks[ 1 ] == "gravity" )
            {
                trap.weapon = level.ztron.var_f8817e403683ca16;
            }
        }
    }
    
    if ( !isdefined( trap.model ) )
    {
        trap.model = "ztron_fireball_trap";
    }
    
    var_4d080f710fb8349e = utility::spawn_model( trap.model, trap.origin, trap.angles );
    trap.var_4d080f710fb8349e = var_4d080f710fb8349e;
    trap.velocity = 200;
    trap thread function_2ddd57986a26b331();
    return trap;
}

// Namespace ztron_hazard_fireball
// Params 0
// Checksum 0x5545cf8d, Offset: 0x322
// Size: 0xf7
function function_5efc8ea63b8db9bb()
{
    level.ztron.var_803907f9bdaeaa4d = [];
    level.ztron.fireballweapon = makeweapon( "sat_la_ztron_fireball" );
    level.ztron.var_f8817e403683ca16 = makeweapon( "sat_la_ztron_fireball_gravity" );
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "fireball" );
    }
    
    foreach ( trap in traps )
    {
        function_f8b3e1f72186d094( trap );
    }
}

// Namespace ztron_hazard_fireball
// Params 0
// Checksum 0xbead11b5, Offset: 0x421
// Size: 0x1c2
function function_2ddd57986a26b331()
{
    self notify( #"hash_4e0249c75e956ac1" );
    self endon( #"hash_4e0249c75e956ac1" );
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    thread function_307b74ef26cc307f();
    
    if ( !isdefined( self.var_4d080f710fb8349e ) )
    {
        self notify( #"destroy_hazard" );
        return;
    }
    
    self.var_4d080f710fb8349e endon( #"death" );
    waitframe();
    
    if ( self.var_4d080f710fb8349e tagexists( "tag_flash_lvl3_le" ) )
    {
        origin = self.var_4d080f710fb8349e gettagorigin( "tag_flash_lvl3_le" );
        angles = self.var_4d080f710fb8349e gettagangles( "tag_flash_lvl3_le" );
    }
    else
    {
        origin = self.var_4d080f710fb8349e.origin;
        angles = self.var_4d080f710fb8349e.angles;
    }
    
    basevelocity = self.velocity;
    veljitter = self.velocity * 0.08;
    minwait = 5;
    maxwait = 10;
    
    while ( true )
    {
        closestplayer = ztron_util::function_5daccb5b5c655ae5( origin, 1800 );
        
        if ( !isdefined( closestplayer ) )
        {
            wait 2;
            continue;
        }
        
        for ( rounds = randomint( 3 ) + 1; rounds > 0 ; rounds-- )
        {
            launchvector = 10000 * anglestoforward( angles );
            ztron_sound::ztron_playsound( "ztron_fireball_emit", undefined, self.var_4d080f710fb8349e );
            magicbullet( self.weapon, origin, origin + launchvector );
            wait randomfloatrange( 1, 4 );
        }
        
        wait randomfloatrange( minwait, maxwait );
    }
}

