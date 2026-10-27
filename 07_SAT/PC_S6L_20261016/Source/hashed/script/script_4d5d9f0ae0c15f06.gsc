// script_4d5d9f0ae0c15f06  (hash_4d5d9f0ae0c15f06.gscc) (size: 2981 Bytes / 0xba5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xebfd55e1 (3959248353)
// size ...... 2981 (0xba5)
// includes .. 5   (offset: 0xb59)
// strings ... 3   (offset: 0xb81)
// dev strs .. 0   (offset: 0xba5)
// exports ... 13  (offset: 0x5b5)
// cseg ...... 0x93 + 0x522 (0x5b5)
// imports ... 32  (offset: 0x7bd)
// animtree1 . 0   (offset: 0xba5)
// animtree2 . 0   (offset: 0xba5)
#using script_35a342a0af11a9c1;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_4285c5b23a8f58a6;

// Namespace namespace_4285c5b23a8f58a6
// Params 0, eflags: 0x5
// Checksum 0x5cf2c0b6, Offset: 0xb1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a1441c7bb7f8059f", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_4285c5b23a8f58a6
// Params 0
// Checksum 0xb4755309, Offset: 0xda
// Size: 0x3e
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"oil_tank", #"create", &function_93cd6ca71dc217bf );
    ztron_hazard::function_6f661fac5fd31f1( #"oil_tank", #"arenaspawn", &function_57bda777bf0205e1 );
}

// Namespace namespace_4285c5b23a8f58a6
// Params 0
// Checksum 0x893d0d49, Offset: 0x120
// Size: 0x9c
function function_57bda777bf0205e1()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "oil_tank" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_93cd6ca71dc217bf( var_4d080f710fb8349e );
    }
}

// Namespace namespace_4285c5b23a8f58a6
// Params 2, eflags: 0x4
// Checksum 0xf9030d10, Offset: 0x1c4
// Size: 0xae
function private function_93cd6ca71dc217bf( trap, paged )
{
    toks = strtok( trap.script_parameters, ";" );
    assert( toks.size >= 2 );
    trap.firstspawntime = int( toks[ 0 ] );
    trap.spawninterval = int( toks[ 1 ] );
    trap.forcetrigger = ztron_util::function_95ca81ff822c3de4( trap.target, #targetname );
    trap thread function_e3fee0d34101fa43();
    
    /#
        thread function_479d3bb29828dc90( trap.forcetrigger );
    #/
}

// Namespace namespace_4285c5b23a8f58a6
// Params 0, eflags: 0x4
// Checksum 0xb9b34e68, Offset: 0x27a
// Size: 0x50
function private function_e3fee0d34101fa43()
{
    level waittill( #"round_begin" );
    level endon( #"round_over" );
    wait self.firstspawntime;
    
    while ( true )
    {
        spawn_barrel( self.origin, self.angles );
        wait self.spawninterval;
    }
}

// Namespace namespace_4285c5b23a8f58a6
// Params 2, eflags: 0x4
// Checksum 0x6bee0ed, Offset: 0x2d2
// Size: 0x72
function private spawn_barrel( origin, angles )
{
    barrel = ztron_hazard_barrel::hazard_spawn_barrel( "decor_barrels_gameplay_flammable_ztron", undefined, origin, angles, 1, 1, 8, 1 );
    barrel physicslaunchserver( barrel.origin, ( 0, 0, 0 ) );
    barrel thread delete_barrel();
    barrel thread function_860972ff8abce409( self.forcetrigger );
}

// Namespace namespace_4285c5b23a8f58a6
// Params 1, eflags: 0xc
// Checksum 0xa8da3ffa, Offset: 0x34c
// Size: 0xd0
function private function_860972ff8abce409( forcetrigger )
{
    self notify( #"hash_3c5969c4c467e45e" );
    self endon( #"hash_3c5969c4c467e45e" );
    self endon( #"death" );
    
    if ( !isdefined( forcetrigger ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( self istouching( forcetrigger ) )
        {
            halfsize = function_decb653c5689e4ca( self.model );
            modelcenter = self.origin + rotatevector( ( 0, 0, halfsize[ 2 ] ), self.angles );
            forward = anglestoforward( forcetrigger.angles );
            self physicslaunchserver( modelcenter, function_db83cdd1ef7e7f4c( forward ) );
            self setscriptablepartstate( #"rotate", #"on" );
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_4285c5b23a8f58a6
// Params 1, eflags: 0x4
// Checksum 0x6e5eb556, Offset: 0x424
// Size: 0x57
function private function_db83cdd1ef7e7f4c( var_6f33643872b0dbe7 )
{
    force = randomfloatrange( 1500, 2000 );
    var_7c21cdf8c2ea49a = randomfloatrange( -45, 45 );
    var_9732cd3a88ee5678 = rotatevector( var_6f33643872b0dbe7, ( 0, var_7c21cdf8c2ea49a, 0 ) );
    var_9732cd3a88ee5678 *= force;
    return var_9732cd3a88ee5678;
}

// Namespace namespace_4285c5b23a8f58a6
// Params 0, eflags: 0x4
// Checksum 0x78b7296a, Offset: 0x484
// Size: 0x2b
function private delete_barrel()
{
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    self waittill( #"destroy_hazard" );
    waitframe();
    self delete();
}

// Namespace namespace_4285c5b23a8f58a6
// Params 1, eflags: 0x4
// Checksum 0x20bc23e8, Offset: 0x4b7
// Size: 0x3d
function private delete_trigger( barrel )
{
    self endon( #"death" );
    thread ztron_util::function_f7544bfa701db406( barrel );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    self waittill( #"destroy_hazard" );
    self delete();
}

// Namespace namespace_4285c5b23a8f58a6
// Params 1, eflags: 0x4
// Checksum 0x5fb18477, Offset: 0x4fc
// Size: 0x53
function private hittrigger( barrel )
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", ent );
        
        if ( isdefined( barrel ) )
        {
            barrel dodamage( 100, barrel.origin );
        }
    }
}

/#

    // Namespace namespace_4285c5b23a8f58a6
    // Params 1, eflags: 0x4
    // Checksum 0x7b0303e8, Offset: 0x557
    // Size: 0x5e, Type: dev
    function private function_479d3bb29828dc90( trigger )
    {
        trigger endon( #"death" );
        
        while ( isdefined( trigger ) )
        {
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
