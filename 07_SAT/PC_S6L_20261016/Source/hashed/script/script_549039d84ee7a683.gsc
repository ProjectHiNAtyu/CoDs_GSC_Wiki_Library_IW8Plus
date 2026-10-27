// script_549039d84ee7a683  (hash_549039d84ee7a683.gscc) (size: 4913 Bytes / 0x1331 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44b88dc (72059100)
// size ...... 4913 (0x1331)
// includes .. 7   (offset: 0x1241)
// strings ... 14  (offset: 0x1279)
// dev strs .. 0   (offset: 0x1331)
// exports ... 10  (offset: 0xb8d)
// cseg ...... 0x1c2 + 0x9cb (0xb8d)
// imports ... 45  (offset: 0xd1d)
// animtree1 . 0   (offset: 0x1331)
// animtree2 . 0   (offset: 0x1331)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_flogger;

// Namespace ztron_hazard_flogger
// Params 0, eflags: 0x5
// Checksum 0xdffefb49, Offset: 0x1e0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_flogger", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_flogger
// Params 0
// Checksum 0x1d6eb572, Offset: 0x209
// Size: 0x84
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"flogger", #"create", &function_f91630ded89ad41a );
    ztron_hazard::function_6f661fac5fd31f1( #"flogger", #"arenaspawn", &function_eb5bbc5bb206e944 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_flogger_eng_start", "evt_ztron_hazard_flogger_eng_start" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_flogger_eng_loop", "evt_ztron_hazard_flogger_eng_loop", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_flogger_eng_stop", "evt_ztron_hazard_flogger_eng_stop" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_flogger_impact", "evt_ztron_hazard_flogger_impact" );
}

// Namespace ztron_hazard_flogger
// Params 0
// Checksum 0x5dbc4302, Offset: 0x295
// Size: 0xb1
function function_eb5bbc5bb206e944()
{
    level.ztron.var_8b8d2de78e07aa9e = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "flogger" );
    
    foreach ( trap in traps )
    {
        function_f91630ded89ad41a( trap );
    }
}

// Namespace ztron_hazard_flogger
// Params 2
// Checksum 0x234b8c15, Offset: 0x34e
// Size: 0x59
function function_f91630ded89ad41a( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_8b8d2de78e07aa9e[ level.ztron.var_8b8d2de78e07aa9e.size ] = trap;
        return;
    }
    
    function_6b768bb0cd876d65( trap );
}

// Namespace ztron_hazard_flogger
// Params 2
// Checksum 0x71362fbd, Offset: 0x3af
// Size: 0x166
function function_6b768bb0cd876d65( trap, paged = 0 )
{
    var_4d080f710fb8349e = utility::spawn_model( "sat_zm_trap_flogger", trap.origin, trap.angles );
    var_4d080f710fb8349e.hazardtype = "flogger";
    trap.script_model = var_4d080f710fb8349e;
    trap.paged = paged;
    trap.trigger = [];
    trap.var_d727c0db76a4d2c = 1;
    trap.minwait = 3;
    trap.maxwait = 5;
    trap.var_8c3d9355fa7cf03b = 11;
    
    if ( isdefined( trap.script_parameters ) )
    {
        args = strtok( trap.script_parameters, ";" );
        
        if ( args.size > 0 )
        {
            trap.var_d727c0db76a4d2c = float( args[ 0 ] );
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
            trap.var_8c3d9355fa7cf03b = int( args[ 3 ] );
        }
    }
    
    trap thread function_57d96e9d431c55e8();
    return trap;
}

// Namespace ztron_hazard_flogger
// Params 0, eflags: 0xc
// Checksum 0x48ac9c04, Offset: 0x51e
// Size: 0x31f
function private function_57d96e9d431c55e8()
{
    self notify( #"hash_f6248ef53d63696c" );
    self endon( #"hash_f6248ef53d63696c" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    thread function_39ec2ecdeae1bea();
    self.script_model solid();
    length = 10;
    self.triggers = [];
    triggersize = ( 12, 70, 12 );
    
    for ( i = 0; i < 2 ; i++ )
    {
        trigger = spawn( "trigger_box", self.origin, 0, triggersize, triggersize + ( 1, 1, 1 ) );
        trigger.owner = self;
        trigger.isoneshot = 1;
        trigger enablelinkto();
        trigger triggerdisable();
        self.triggers[ self.triggers.size ] = trigger;
        
        /#
            trigger thread flogger_debug();
        #/
    }
    
    tag = "tag_origin";
    self.triggers[ 0 ] linkto( self.script_model, tag, ( -100, 0, 0 ), ( 0, 0, 0 ) );
    self.triggers[ 1 ] linkto( self.script_model, tag, ( 100, 0, 0 ), ( 0, 0, 0 ) );
    var_c3718cea45e640da = self.var_d727c0db76a4d2c;
    length /= var_c3718cea45e640da;
    
    while ( true )
    {
        ztron_sound::ztron_playsound( "ztron_hazard_flogger_eng_start", undefined, self.script_model );
        wait 1;
        
        foreach ( trigger in self.triggers )
        {
            trigger triggerenable();
            trigger thread hazard_kill_think( self );
        }
        
        ztron_sound::ztron_playsound( "ztron_hazard_flogger_eng_loop", undefined, self.script_model );
        self.script_model rotatepitch( -360 * self.var_8c3d9355fa7cf03b, length, 0.5, 0.5 );
        wait length;
        ztron_sound::ztron_stopsound( self.script_model );
        ztron_sound::ztron_playsound( "ztron_hazard_flogger_eng_stop", undefined, self.script_model );
        
        foreach ( trigger in self.triggers )
        {
            trigger triggerdisable();
        }
        
        wait randomfloatrange( self.minwait, self.maxwait );
    }
}

// Namespace ztron_hazard_flogger
// Params 1, eflags: 0xc
// Checksum 0xd7278dec, Offset: 0x845
// Size: 0x1bb
function private hazard_kill_think( trap )
{
    self notify( #"hash_a90b248cf760d9c7" );
    self endon( #"hash_a90b248cf760d9c7" );
    self endon( #"death", #"hazard_trigger_released" );
    var_7050a0443beaccd4 = 6000;
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", guy );
        
        if ( isdefined( guy ) )
        {
            if ( !isdefined( guy.var_fe7c8f5f718fd9d5 ) )
            {
                guy.var_fe7c8f5f718fd9d5 = 0;
            }
            
            if ( guy.var_fe7c8f5f718fd9d5 < gettime() )
            {
                guy.var_fe7c8f5f718fd9d5 = gettime() + 500;
            }
            
            if ( guy.no_hazards || guy.ztron.boss )
            {
                continue;
            }
            
            if ( isplayer( guy ) || guy vehicle::is_vehicle() )
            {
                guy dodamage( ( trap.damage ?? guy.health ) + 100, guy.origin, self );
                guy playrumbleonentity( "damage_heavy" );
                continue;
            }
            
            if ( !guy.no_ragdoll )
            {
                v_centroid = guy getcentroid();
                var_484a3a34fdafad8 = vectornormalize( v_centroid - self.origin );
                var_484a3a34fdafad8 *= 512;
                var_484a3a34fdafad8 = ( var_484a3a34fdafad8[ 0 ], var_484a3a34fdafad8[ 1 ], randomintrange( 128, 200 ) );
                guy thread ztron_util::function_afa1f6a404783c8a( var_484a3a34fdafad8, var_7050a0443beaccd4 );
                continue;
            }
            
            guy.forceannihilate = 1;
            
            if ( !guy.marked_for_death )
            {
                guy thread ztron_util::function_ea0a0be5c5468c48( 0.5, undefined, undefined, 0 );
            }
        }
    }
}

// Namespace ztron_hazard_flogger
// Params 0
// Checksum 0x10613965, Offset: 0xa08
// Size: 0x123
function function_39ec2ecdeae1bea()
{
    self notify( #"hash_a1050bcef46b02d3" );
    self endon( #"hash_a1050bcef46b02d3" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    
    if ( self.paged )
    {
        level.ztron.var_8b8d2de78e07aa9e = arrayremove( level.ztron.var_8b8d2de78e07aa9e, self );
    }
    
    if ( isdefined( self.triggers ) )
    {
        foreach ( trigger in self.triggers )
        {
            trigger delete();
        }
        
        self.triggers = undefined;
    }
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model delete();
        self.script_model = undefined;
    }
    
    self.paged = undefined;
}

/#

    // Namespace ztron_hazard_flogger
    // Params 0
    // Checksum 0xa5e95349, Offset: 0xb33
    // Size: 0x5a, Type: dev
    function flogger_debug()
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
