// script_9d7b1b99a878301  (hash_09d7b1b99a878301.gscc) (size: 3408 Bytes / 0xd50 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef963065 (4019597413)
// size ...... 3408 (0xd50)
// includes .. 5   (offset: 0xcb0)
// strings ... 7   (offset: 0xcd8)
// dev strs .. 2   (offset: 0xd38)
// exports ... 11  (offset: 0x798)
// cseg ...... 0xdb + 0x6bd (0x798)
// imports ... 30  (offset: 0x950)
// animtree1 . 0   (offset: 0xd50)
// animtree2 . 0   (offset: 0xd50)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_hazard_moving_platform;

// Namespace ztron_hazard_moving_platform
// Params 0, eflags: 0x5
// Checksum 0x5e796ce5, Offset: 0xf9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_moving_platform", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_moving_platform
// Params 0
// Checksum 0xcf725e4e, Offset: 0x122
// Size: 0x51
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"moving_platform", #"create", &function_6da16b59b27b1d28 );
    ztron_hazard::function_6f661fac5fd31f1( #"moving_platform", #"arenaspawn", &function_3e5edc472bf2fc26 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_moving_platform_lp", "evt_ztron_hazard_moving_platform_lp", 1 );
}

// Namespace ztron_hazard_moving_platform
// Params 2
// Checksum 0x6c3c420f, Offset: 0x17b
// Size: 0x62
function function_6da16b59b27b1d28( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_b76839bcabb566c4[ level.ztron.var_b76839bcabb566c4.size ] = trap;
        return;
    }
    
    function_1e2210d0aea2cda9( trap );
    function_5aff0f6748b42c3f( trap );
}

// Namespace ztron_hazard_moving_platform
// Params 0
// Checksum 0x6e16553c, Offset: 0x1e5
// Size: 0xb1
function function_3e5edc472bf2fc26()
{
    level.ztron.var_b76839bcabb566c4 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "moving_platform" );
    
    foreach ( trap in traps )
    {
        function_6da16b59b27b1d28( trap );
    }
}

// Namespace ztron_hazard_moving_platform
// Params 0
// Checksum 0x5d779e46, Offset: 0x29e
// Size: 0x4e
function function_208b616a4eeeb967()
{
    self notify( #"hash_46a8388bf4127377" );
    self endon( #"hash_46a8388bf4127377" );
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    ztron_sound::ztron_stopsound( self );
    wait 0.5;
    self delete();
}

// Namespace ztron_hazard_moving_platform
// Params 1
// Checksum 0x47c10f1e, Offset: 0x2f4
// Size: 0x1b3
function function_1e2210d0aea2cda9( trap )
{
    var_2c5099d703c7da38 = [];
    args = strtok( trap.script_label, ";" );
    trap.moving_mode = 0;
    
    if ( args.size > 0 )
    {
        if ( args[ 0 ] == "loop" )
        {
            trap.moving_mode = 0;
        }
        else if ( args[ 0 ] == "reverse" )
        {
            trap.moving_mode = 1;
        }
    }
    
    if ( args.size > 1 )
    {
        trap.model = args[ 1 ];
    }
    
    if ( args.size > 2 )
    {
        trap.forcespeed = float( args[ 2 ] );
    }
    
    for ( var_8eb4e8e8198e4341 = trap; true ; var_8eb4e8e8198e4341 = next_node )
    {
        if ( !isdefined( var_8eb4e8e8198e4341 ) || arraycontains( var_2c5099d703c7da38, var_8eb4e8e8198e4341 ) )
        {
            assert( 0, "<dev string:x24>" );
            break;
        }
        
        var_2c5099d703c7da38[ var_2c5099d703c7da38.size ] = var_8eb4e8e8198e4341;
        args = strtok( var_8eb4e8e8198e4341.script_parameters, ";" );
        assert( args.size < 4, "<dev string:x3f>" );
        var_8eb4e8e8198e4341.var_c6db5c05a5f1e16e = float( args[ 0 ] );
        
        if ( !isdefined( trap.forcespeed ) )
        {
            var_8eb4e8e8198e4341.var_9b703e3ad83159ff = float( args[ 1 ] );
        }
        
        if ( !isdefined( var_8eb4e8e8198e4341.target ) )
        {
            break;
        }
        
        next_node = utility::getstruct( var_8eb4e8e8198e4341.target, "targetname" );
        
        if ( !isdefined( next_node ) )
        {
            break;
        }
        
        next_node.pre_node = var_8eb4e8e8198e4341;
        var_8eb4e8e8198e4341.next_node = next_node;
    }
}

// Namespace ztron_hazard_moving_platform
// Params 2
// Checksum 0x888224fd, Offset: 0x4af
// Size: 0x94
function function_5aff0f6748b42c3f( trap, paged = 0 )
{
    trap.moving_state = 0;
    modelname = trap.model ?? %"decor_dock_platform_64x128_ztron";
    var_4d080f710fb8349e = trap function_6d8d0bed3d9f36cd( modelname, trap.origin, trap.angles );
    trap.script_model = var_4d080f710fb8349e;
    trap.paged = paged;
    return trap;
}

// Namespace ztron_hazard_moving_platform
// Params 3
// Checksum 0x7ac60fd8, Offset: 0x54c
// Size: 0x65
function function_6d8d0bed3d9f36cd( modelname, origin, angles )
{
    var_4d080f710fb8349e = utility::spawn_model( modelname, origin, angles );
    
    if ( isdefined( var_4d080f710fb8349e ) )
    {
        var_4d080f710fb8349e.hazardtype = "moving_platform";
        var_4d080f710fb8349e setcandamage( 0 );
        var_4d080f710fb8349e solid();
        thread function_ab7a138d5123d51e( var_4d080f710fb8349e );
    }
    
    return var_4d080f710fb8349e;
}

// Namespace ztron_hazard_moving_platform
// Params 2
// Checksum 0x8cf3a011, Offset: 0x5ba
// Size: 0xc7
function getnextnode( var_8eb4e8e8198e4341, var_d300066df6a9a7ae = 1 )
{
    if ( self.moving_state == 0 )
    {
        next_node = var_8eb4e8e8198e4341.next_node;
    }
    else
    {
        next_node = var_8eb4e8e8198e4341.pre_node;
    }
    
    if ( !isdefined( next_node ) && var_d300066df6a9a7ae )
    {
        if ( self.moving_mode == 1 )
        {
            if ( isdefined( self.reverse_callback ) )
            {
                self [[ self.reverse_callback ]]();
            }
            
            self.moving_state = self.moving_state == 0 ? 1 : 0;
            next_node = getnextnode( var_8eb4e8e8198e4341, 0 );
        }
        else if ( self.moving_mode == 0 )
        {
            next_node = self;
        }
    }
    
    return next_node;
}

// Namespace ztron_hazard_moving_platform
// Params 1
// Checksum 0x8537d67f, Offset: 0x68a
// Size: 0x10e
function function_ab7a138d5123d51e( moving_platform )
{
    self notify( #"hash_3524e304917bd7b3" );
    self endon( #"hash_3524e304917bd7b3" );
    moving_platform endon( #"death" );
    moving_platform thread function_208b616a4eeeb967();
    
    for ( var_8eb4e8e8198e4341 = self; true ; var_8eb4e8e8198e4341 = next_node )
    {
        if ( !isdefined( var_8eb4e8e8198e4341 ) )
        {
            break;
        }
        
        next_node = getnextnode( var_8eb4e8e8198e4341 );
        
        if ( !next_node )
        {
            break;
        }
        
        wait var_8eb4e8e8198e4341.var_c6db5c05a5f1e16e;
        ztron_sound::ztron_playsound( "ztron_hazard_moving_platform_lp", undefined, moving_platform );
        nextorigin = next_node.origin;
        move_time = undefined;
        
        if ( isdefined( self.forcespeed ) )
        {
            move_time = length( nextorigin - moving_platform.origin ) / self.forcespeed;
        }
        else
        {
            move_time = var_8eb4e8e8198e4341.var_9b703e3ad83159ff;
        }
        
        moving_platform moveto( nextorigin, move_time );
        moving_platform waittill( #"movedone" );
        ztron_sound::ztron_stopsound( moving_platform );
    }
}

