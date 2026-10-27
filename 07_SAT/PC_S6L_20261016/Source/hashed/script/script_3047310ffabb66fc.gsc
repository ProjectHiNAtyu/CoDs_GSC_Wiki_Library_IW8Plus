// script_3047310ffabb66fc  (hash_3047310ffabb66fc.gscc) (size: 4131 Bytes / 0x1023 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc9e77ed (3701372909)
// size ...... 4131 (0x1023)
// includes .. 6   (offset: 0xfa3)
// strings ... 6   (offset: 0xfd3)
// dev strs .. 0   (offset: 0x1023)
// exports ... 11  (offset: 0x973)
// cseg ...... 0xca + 0x8a9 (0x973)
// imports ... 39  (offset: 0xb2b)
// animtree1 . 0   (offset: 0x1023)
// animtree2 . 0   (offset: 0x1023)
#using scripts\common\system;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_hazard_dragonhead;

// Namespace ztron_hazard_dragonhead
// Params 0, eflags: 0x5
// Checksum 0xaea4a6e3, Offset: 0xe8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_dragonhead", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_dragonhead
// Params 0
// Checksum 0x3ca56a0f, Offset: 0x111
// Size: 0x3e
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"dragonhead", #"create", &function_8f80fc5b1a48cb85 );
    ztron_hazard::function_6f661fac5fd31f1( #"dragonhead", #"arenaspawn", &function_add48b392897b0f7 );
}

// Namespace ztron_hazard_dragonhead
// Params 0
// Checksum 0xb3cbbe59, Offset: 0x157
// Size: 0xb1
function function_add48b392897b0f7()
{
    level.ztron.var_68e0142638093d41 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "dragonhead" );
    
    foreach ( trap in traps )
    {
        function_8f80fc5b1a48cb85( trap );
    }
}

// Namespace ztron_hazard_dragonhead
// Params 2
// Checksum 0x300b9a1a, Offset: 0x210
// Size: 0x59
function function_8f80fc5b1a48cb85( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_68e0142638093d41[ level.ztron.var_68e0142638093d41.size ] = trap;
        return;
    }
    
    function_d87988141d82d604( trap );
}

// Namespace ztron_hazard_dragonhead
// Params 2
// Checksum 0x2685a97e, Offset: 0x271
// Size: 0x1a3
function function_d87988141d82d604( trap, paged = 0 )
{
    trap.scriptable_name = "ztron_dragonhead";
    trap.minwait = 3;
    trap.maxwait = 3;
    trap.minduration = 4;
    trap.maxduration = 7;
    
    if ( isdefined( trap.script_parameters ) )
    {
        args = strtok( trap.script_parameters, ";" );
        
        if ( args.size > 0 )
        {
            trap.scriptable_name = args[ 0 ];
        }
        
        if ( args.size > 1 )
        {
            trap.minwait = float( args[ 1 ] );
        }
        
        if ( args.size > 2 )
        {
            trap.maxwait = float( args[ 2 ] );
        }
        
        if ( args.size > 3 )
        {
            trap.minduration = float( args[ 3 ] );
        }
        
        if ( args.size > 4 )
        {
            trap.maxduration = float( args[ 4 ] );
        }
    }
    
    var_4d080f710fb8349e = spawnscriptable( trap.scriptable_name, trap.origin, trap.angles );
    var_4d080f710fb8349e.hazardtype = "dragonhead";
    trap.scriptable = var_4d080f710fb8349e;
    trap.damage = 50;
    trap.tickrate = 1;
    trap.paged = paged;
    trap thread function_3fe3d0af0e0f7155();
    return trap;
}

// Namespace ztron_hazard_dragonhead
// Params 0, eflags: 0xc
// Checksum 0x59445a28, Offset: 0x41d
// Size: 0x1d7
function private function_3fe3d0af0e0f7155()
{
    self notify( #"hash_5239a9e0cbde6f21" );
    self endon( #"hash_5239a9e0cbde6f21" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    thread function_39ec2ecdeae1bea();
    wait randomfloatrange( 0.1, 3 );
    
    if ( !isdefined( self.trigger ) )
    {
        self.trigger = spawn( "trigger_radius", self.origin, 0, 60, 150 );
        self.trigger.owner = self;
        
        /#
            self.trigger thread dragonhead_debug();
        #/
    }
    
    while ( true )
    {
        self.scriptable setscriptablepartstate( #"body", #"idle" );
        self.trigger triggerdisable();
        wait randomfloatrange( self.minwait, self.maxwait );
        rotatedpoint = rotatepointaroundvector( ( 0, 0, 1 ), get_trigger_offset( self ), self.angles[ 1 ] - 90 );
        self.trigger.origin = self.origin + rotatedpoint;
        self.trigger thread hazard_kill_think( self );
        self.scriptable setscriptablepartstate( #"body", #"pre_active" );
        wait 2;
        self.scriptable setscriptablepartstate( #"body", #"active" );
        self.trigger triggerenable();
        count = randomfloatrange( self.minduration, self.maxduration );
        
        while ( count > 0 )
        {
            count -= 0.25;
            wait 0.25;
        }
    }
}

// Namespace ztron_hazard_dragonhead
// Params 1, eflags: 0xc
// Checksum 0x1e001bdd, Offset: 0x5fc
// Size: 0x1c0
function private hazard_kill_think( trap )
{
    self notify( #"hash_d0a8fd66470301c8" );
    self endon( #"hash_d0a8fd66470301c8" );
    self endon( #"death" );
    tickrate = ( trap.tickrate ?? 1 ) * 1000;
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", guy );
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( isplayer( guy && player::isinlaststand( guy ) ) )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( guy.no_hazards || guy.ztron.boss )
        {
            continue;
        }
        
        time = gettime();
        
        if ( !isdefined( guy.var_e88a2a8920311baf ) )
        {
            guy.var_e88a2a8920311baf = 0;
        }
        
        if ( guy.var_e88a2a8920311baf > gettime() )
        {
            continue;
        }
        
        guy.var_e88a2a8920311baf = time + tickrate;
        
        if ( isplayer( guy ) )
        {
            guy dodamage( trap.damage ?? guy.health + 100, guy.origin, self, self, "MOD_ELEMENTAL_FIRE" );
            guy playrumbleonentity( "damage_med" );
            guy ztron_vfx::burn();
            
            if ( isdefined( trap.statusfx ) && guy.birthtime != gettime() )
            {
            }
            
            continue;
        }
        
        if ( isai( guy ) )
        {
            guy ztron_vfx::burn();
        }
        
        guy thread ztron_util::function_ea0a0be5c5468c48( randomfloatrange( 0.5, 2.2 ), undefined, "MOD_ELEMENTAL_FIRE", 0 );
    }
}

// Namespace ztron_hazard_dragonhead
// Params 0
// Checksum 0xf015c943, Offset: 0x7c4
// Size: 0xd8
function function_39ec2ecdeae1bea()
{
    self notify( #"hash_585505a0e5cf59da" );
    self endon( #"hash_585505a0e5cf59da" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    
    if ( self.paged )
    {
        level.ztron.var_68e0142638093d41 = arrayremove( level.ztron.var_68e0142638093d41, self );
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
    
    self.trigger = undefined;
    self.scriptable = undefined;
    self.damage = undefined;
    self.tickrate = undefined;
    self.statusfx = undefined;
    self.paged = undefined;
}

// Namespace ztron_hazard_dragonhead
// Params 1, eflags: 0x4
// Checksum 0x4b707862, Offset: 0x8a4
// Size: 0x6d
function private get_trigger_offset( trap )
{
    switch ( trap.scriptable_name )
    {
        case #"hash_4dc2f5b22b2c8d76":
            return ( 0, 170, -150 );
        case #"hash_fbe2ef28bc6853ca":
            return ( 0, 80, -100 );
        default:
            return ( 0, 0, 0 );
    }
}

/#

    // Namespace ztron_hazard_dragonhead
    // Params 0
    // Checksum 0x707a76f9, Offset: 0x919
    // Size: 0x5a, Type: dev
    function dragonhead_debug()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                if ( self function_b0b72d20769d0233() )
                {
                    drawtrigger( self, ( 1, 0, 0 ), 0, 1, 0, ( 1, 0, 0 ) );
                }
            }
            
            waitframe();
        }
    }

#/
