// script_73cee2c0b86c6204  (hash_73cee2c0b86c6204.gscc) (size: 4950 Bytes / 0x1356 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbfcbfb93 (3217816467)
// size ...... 4950 (0x1356)
// includes .. 8   (offset: 0x128e)
// strings ... 9   (offset: 0x12ce)
// dev strs .. 2   (offset: 0x133e)
// exports ... 11  (offset: 0xc02)
// cseg ...... 0x109 + 0xaf9 (0xc02)
// imports ... 42  (offset: 0xdba)
// animtree1 . 0   (offset: 0x1356)
// animtree2 . 0   (offset: 0x1356)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_8849960825a32a32;

// Namespace namespace_8849960825a32a32
// Params 0, eflags: 0x5
// Checksum 0x30e34414, Offset: 0x127
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_2c0e8f115cbb05cd", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_8849960825a32a32
// Params 0
// Checksum 0x7a44893e, Offset: 0x150
// Size: 0x20
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"killbox", #"arenaspawn", &function_2d51dc666cebde27 );
}

// Namespace namespace_8849960825a32a32
// Params 0
// Checksum 0x6c6ed84b, Offset: 0x178
// Size: 0xb1
function function_2d51dc666cebde27()
{
    level.ztron.var_374a93870b654657 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "killbox" );
    
    foreach ( trap in traps )
    {
        function_c7756360860ab12d( trap );
    }
}

// Namespace namespace_8849960825a32a32
// Params 2
// Checksum 0x7d0369e2, Offset: 0x231
// Size: 0x1b8
function function_c7756360860ab12d( trap, page = 0 )
{
    if ( !trap.initialized )
    {
        assert( isdefined( trap.script_parameters ), "<dev string:x24>" );
        args = strtok( trap.script_parameters, ";" );
        assert( args.size >= 4, "<dev string:x46>" );
        trap.type = args[ 0 ];
        trap.length = int( args[ 1 ] );
        trap.width = int( args[ 2 ] );
        trap.height = int( args[ 3 ] );
        trap.teleport = 1;
        
        if ( args.size > 4 )
        {
            trap.teleport = int( args[ 4 ] );
        }
        
        trap.damage = 50;
        trap.tickrate = 1;
        trap.is_trigger_radius = 0;
        
        if ( args.size > 5 )
        {
            trap.damage = int( args[ 5 ] );
        }
        
        if ( args.size > 6 )
        {
            trap.tickrate = int( args[ 6 ] );
        }
        
        if ( args.size > 7 )
        {
            trap.is_trigger_radius = int( args[ 7 ] );
        }
        
        trap.initialized = 1;
    }
    
    if ( page )
    {
        level.ztron.var_374a93870b654657[ level.ztron.var_374a93870b654657.size ] = trap;
        return;
    }
    
    function_c5044f1eb51e8c52( trap );
}

// Namespace namespace_8849960825a32a32
// Params 3
// Checksum 0x578eb1fe, Offset: 0x3f1
// Size: 0xa5
function function_c5044f1eb51e8c52( trap, paged = 0, modelname )
{
    if ( isdefined( modelname ) )
    {
        hazard_model = utility::spawn_model( modelname, trap.origin, trap.angles );
        
        if ( isdefined( hazard_model ) )
        {
            hazard_model.targetname = "hazard";
            hazard_model.hazardtype = "killbox";
        }
        
        trap.script_model = hazard_model;
    }
    
    trap.paged = paged;
    trap thread function_462ce48069da165f();
    return trap;
}

// Namespace namespace_8849960825a32a32
// Params 0, eflags: 0xc
// Checksum 0xdc6c71b0, Offset: 0x49f
// Size: 0x186
function private function_462ce48069da165f()
{
    self notify( #"hash_8ee990b4b573c4ab" );
    self endon( #"hash_8ee990b4b573c4ab" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    thread function_d1ba6c9514a77801();
    wait randomfloatrange( 0.1, 3 );
    
    while ( true )
    {
        if ( self.is_trigger_radius )
        {
            self.trigger = spawn( "trigger_radius", self.origin, 0, self.length, self.height );
            self.trigger.owner = self;
        }
        else
        {
            self.trigger = spawn( "trigger_box", self.origin, 0, ( self.length, self.width, self.height ), ( self.length, self.width, self.height ) + ( 1, 1, 1 ) );
            self.trigger.owner = self;
        }
        
        if ( !isdefined( self.trigger ) )
        {
            wait 0.2;
            continue;
        }
        
        /#
            level thread function_baa28cbf09701b35( self.trigger );
        #/
        
        self.trigger thread function_2938bb5b2afce33( self );
        wait 1;
        
        if ( isdefined( self.trigger ) )
        {
            self.trigger triggerenable();
            
            while ( isdefined( self.trigger ) )
            {
                wait 0.25;
            }
        }
    }
}

// Namespace namespace_8849960825a32a32
// Params 1, eflags: 0xc
// Checksum 0xa7dd7245, Offset: 0x62d
// Size: 0x23b
function private function_2938bb5b2afce33( trap )
{
    self notify( #"hash_84fc2f49a887f7d2" );
    self endon( #"hash_84fc2f49a887f7d2" );
    level endon( #"ztron_game_is_over" );
    self endon( #"death", #"destroy_hazard", #"hazard_trigger_released" );
    tickrate = ( trap.tickrate ?? 1 ) * 1000;
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( guy.no_hazards || guy.ztron.boss || player::isinlaststand( guy ) )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( !isdefined( guy.var_853f69efe60b3a4b ) )
        {
            guy.var_853f69efe60b3a4b = 0;
        }
        
        time = gettime();
        
        if ( guy.var_853f69efe60b3a4b > gettime() )
        {
            continue;
        }
        
        guy.var_853f69efe60b3a4b = time + tickrate;
        
        if ( isplayer( guy ) )
        {
            guy dodamage( ( trap.damage ?? guy.health ) + 100, guy.origin, self );
            guy playrumbleonentity( "damage_light" );
        }
        else
        {
            guy thread ztron_util::function_ea0a0be5c5468c48( 0.1, undefined, undefined, 0 );
        }
        
        level notify( #"hash_46fa6c5088941b95", guy );
        
        if ( isplayer( guy ) && trap.arena && trap.teleport && ztron_main::function_4da200e9b8d58a3c() == 1 && isdefined( level.ztron.active_arena ) )
        {
            currentarena = level.ztron.arenas[ level.ztron.currentarena ];
            spot = currentarena ztron_arena::function_8c2aa5e7037af31c( guy.origin );
            guy setorigin( spot.origin );
        }
    }
}

// Namespace namespace_8849960825a32a32
// Params 0, eflags: 0xc
// Checksum 0xa0e16c85, Offset: 0x870
// Size: 0xbc
function private function_d1ba6c9514a77801()
{
    self notify( #"hash_4795f949515077c5" );
    self endon( #"hash_4795f949515077c5" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard", permshutdown );
    
    if ( self.paged && permshutdown )
    {
        arrayremove( level.ztron.var_374a93870b654657, self );
        ztron_debug::debugmsg( "Deleting killbox trap permenently at:" + self.origin );
    }
    
    waitframe();
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model delete();
    }
}

// Namespace namespace_8849960825a32a32
// Params 0, eflags: 0xc
// Checksum 0x513b8356, Offset: 0x934
// Size: 0x269
function private function_b8b4b831e529185b()
{
    self notify( #"hash_19031461f275ae1f" );
    self endon( #"hash_19031461f275ae1f" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        wait 0.5;
        
        foreach ( trap in level.ztron.var_374a93870b654657 )
        {
            time = gettime();
            
            if ( time < trap.var_941a66dc0dd02b70 )
            {
                continue;
            }
            
            trap.var_941a66dc0dd02b70 = time + 2000 + randomint( 600 );
            
            if ( !trap.active )
            {
                activate = 0;
                
                if ( isdefined( trap.closestsentient ) )
                {
                    distsq = distancesquared( trap.origin, trap.closestsentient.origin );
                    
                    if ( distsq < squared( 3200 ) )
                    {
                        activate = 1;
                    }
                }
                
                if ( !activate )
                {
                    trap.closestsentient = ztron_util::function_5daccb5b5c655ae5( trap.origin, 3200 );
                    
                    if ( isdefined( trap.closestsentient ) )
                    {
                        activate = 1;
                    }
                    else
                    {
                        trap.closestsentient = ztron_util::function_5659cc5e67df6dfe( trap.origin, 1200 );
                        
                        if ( isdefined( trap.closestsentient ) )
                        {
                            activate = 1;
                        }
                    }
                }
                
                if ( activate )
                {
                    function_c5044f1eb51e8c52( trap, 1 );
                    trap.var_941a66dc0dd02b70 += 5000;
                    ztron_debug::debugmsg( "Paging IN killbox trap at:" + trap.origin );
                }
                
                continue;
            }
            
            trap.closestsentient = ztron_util::function_3b544615f0db8722( trap.origin, 3600 );
            permshutdown = 0;
            
            if ( !isdefined( trap.closestsentient ) )
            {
                trap notify( #"destroy_hazard", permshutdown );
                ztron_debug::debugmsg( "Paging out killbox trap at:" + trap.origin );
            }
        }
    }
}

/#

    // Namespace namespace_8849960825a32a32
    // Params 1, eflags: 0x4
    // Checksum 0xf9712e44, Offset: 0xba5
    // Size: 0x5d, Type: dev
    function private function_baa28cbf09701b35( trigger )
    {
        level endon( #"ztron_game_is_over" );
        
        while ( isdefined( trigger ) )
        {
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                drawtrigger( trigger, ( 1, 0, 0 ), 0, 0, 0, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

#/
