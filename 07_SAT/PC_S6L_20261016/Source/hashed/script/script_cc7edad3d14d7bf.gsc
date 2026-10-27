// script_cc7edad3d14d7bf  (hash_0cc7edad3d14d7bf.gscc) (size: 6075 Bytes / 0x17bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd1e9a64 (4246641252)
// size ...... 6075 (0x17bb)
// includes .. 12  (offset: 0x15c7)
// strings ... 27  (offset: 0x1627)
// dev strs .. 0   (offset: 0x17bb)
// exports ... 10  (offset: 0xe67)
// cseg ...... 0x310 + 0xb57 (0xe67)
// imports ... 48  (offset: 0xff7)
// animtree1 . 0   (offset: 0x17bb)
// animtree2 . 0   (offset: 0x17bb)
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_hazard_electric_pole;

// Namespace ztron_hazard_electric_pole
// Params 0, eflags: 0x5
// Checksum 0xc7c4bcc, Offset: 0x32e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_electric", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_electric_pole
// Params 0
// Checksum 0x74008709, Offset: 0x357
// Size: 0x95
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"elec_pole", #"create", &function_5af93e037365b05e );
    ztron_hazard::function_6f661fac5fd31f1( #"elec_pole", #"arenaspawn", &function_69787e8ad98dba91 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pole_warning", "evt_ztron_hazard_pole_warning" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pole_lp", "evt_ztron_hazard_pole_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pole_on", "evt_ztron_hazard_pole_on" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pole_off", "evt_ztron_hazard_pole_off" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pole_impact", "evt_ztron_hazard_pole_impact" );
}

// Namespace ztron_hazard_electric_pole
// Params 0
// Checksum 0x756c9e95, Offset: 0x3f4
// Size: 0x192
function function_732223363bd67390()
{
    self notify( #"hash_3e0d9dc33e9d5097" );
    self endon( #"hash_3e0d9dc33e9d5097" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    utility::waittill_any_ents( self, "destroy_hazard", level, "destroy_hazard_pole" );
    self.shutting_down = 1;
    
    if ( self.paged )
    {
        level.ztron.var_2112ccb034c41d2c = arrayremove( level.ztron.var_2112ccb034c41d2c, self );
    }
    
    if ( isdefined( self.script_models ) )
    {
        foreach ( model in self.script_models )
        {
            model notify( #"destroy_hazard" );
            
            if ( isdefined( model ) )
            {
                if ( isdefined( model.trigger ) )
                {
                    model.trigger delete();
                }
                
                stopfxontag( model.var_2b250b983872f1b2, model, "tag_origin" );
                stopfxontag( model.var_7c6c1fd5e7ec0b2, model, "tag_origin" );
                stopfxontag( model.fx_trap_active, model, "tag_origin" );
                ztron_sound::ztron_stopsound( model );
                waitframe();
                model delete();
            }
        }
        
        self.script_models = undefined;
    }
    
    self.shutting_down = undefined;
}

// Namespace ztron_hazard_electric_pole
// Params 4
// Checksum 0xeff24d36, Offset: 0x58e
// Size: 0xae
function function_5af93e037365b05e( trap, page = 0, origin, angles )
{
    if ( page )
    {
        level.ztron.var_2112ccb034c41d2c[ level.ztron.var_2112ccb034c41d2c.size ] = trap;
        return;
    }
    
    var_f9cd5cbcdb7bf574 = function_26b48882ff839ed7( trap, 0, origin, angles );
    
    if ( isdefined( var_f9cd5cbcdb7bf574 ) )
    {
        level.ztron.arena_poles[ level.ztron.arena_poles.size ] = var_f9cd5cbcdb7bf574;
        return var_f9cd5cbcdb7bf574;
    }
}

// Namespace ztron_hazard_electric_pole
// Params 0
// Checksum 0x2342e26c, Offset: 0x644
// Size: 0x41
function function_52058b3337155884()
{
    level.ztron.arena_poles = function_5713d46873b29625( level.ztron.arena_poles );
    return level.ztron.arena_poles.size;
}

// Namespace ztron_hazard_electric_pole
// Params 0
// Checksum 0xd0404fb, Offset: 0x68e
// Size: 0x1d0
function function_69787e8ad98dba91()
{
    level.ztron.var_2112ccb034c41d2c = [];
    level.ztron.arena_poles = [];
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        effectiveround = level.ztron.roundnumber;
        
        if ( level.ztron.blitzmode )
        {
            effectiveround = level.ztron.roundnumber * 4;
        }
        
        if ( effectiveround < 5 )
        {
            return;
        }
        
        cluster_count = clamp( 1 + randomint( 2 + int( ( effectiveround - 4 ) / 5 ) ), 1, 40 );
        cluster_count = int( cluster_count );
        maxpoles = level.ztron.active_arena.var_74dcc18e9abdfa37;
        
        if ( cluster_count > maxpoles )
        {
            cluster_count = maxpoles;
        }
        
        if ( cluster_count <= 0 )
        {
            return;
        }
    }
    
    pole_locations = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "elec_pole" );
    
    if ( pole_locations.size == 0 )
    {
        return;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        while ( cluster_count )
        {
            trap = pole_locations[ randomint( pole_locations.size ) ];
            
            if ( trap.shutting_down )
            {
                waitframe();
                continue;
            }
            
            cluster_count--;
            radius = isdefined( trap.radius ) ? int( trap.radius ) : 85;
            origin = trap.origin + ( randomintrange( radius * -1, radius ), randomintrange( radius * -1, radius ), 0 );
            
            if ( isdefined( origin ) )
            {
                function_5af93e037365b05e( trap, 0, origin );
            }
        }
    }
}

// Namespace ztron_hazard_electric_pole
// Params 4
// Checksum 0xd989acca, Offset: 0x866
// Size: 0x156
function function_26b48882ff839ed7( trap, paged = 0, origin = trap.origin, angles )
{
    if ( !isdefined( angles ) )
    {
        if ( isdefined( trap ) )
        {
            angles = trap.angles;
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
    }
    
    var_4d080f710fb8349e = utility::spawn_model( %"sat_zm_ztron_props_electrical_pole", origin, angles );
    
    if ( isdefined( var_4d080f710fb8349e ) )
    {
        var_4d080f710fb8349e notsolid();
        var_4d080f710fb8349e.isoneshot = 1;
        var_4d080f710fb8349e.var_2b250b983872f1b2 = utility::getfx( "ztron_hazard_electric_trap_red" );
        var_4d080f710fb8349e.var_7c6c1fd5e7ec0b2 = utility::getfx( "ztron_hazard_electric_trap_green" );
        var_4d080f710fb8349e.fx_trap_active = utility::getfx( "ztron_hazard_electric_trap_active" );
        var_4d080f710fb8349e thread function_a0f9049cde7e10aa( trap );
        
        if ( isdefined( trap ) )
        {
            if ( !isdefined( trap.script_models ) )
            {
                trap.script_models = [];
            }
            
            trap.script_models[ trap.script_models.size ] = var_4d080f710fb8349e;
        }
    }
    else
    {
        return;
    }
    
    if ( isdefined( trap ) )
    {
        trap.paged = paged;
        trap thread function_732223363bd67390();
    }
    
    return var_4d080f710fb8349e;
}

// Namespace ztron_hazard_electric_pole
// Params 1
// Checksum 0x5f17168f, Offset: 0x9c5
// Size: 0x146
function function_a0f9049cde7e10aa( trap )
{
    self endon( #"death", #"destroy_hazard" );
    self.active = 0;
    stopfxontag( self.var_2b250b983872f1b2, self, "tag_origin" );
    playfxontag( self.var_7c6c1fd5e7ec0b2, self, "tag_origin" );
    
    while ( true )
    {
        wait randomfloatrange( 5, 15 );
        stopfxontag( self.var_7c6c1fd5e7ec0b2, self, "tag_origin" );
        playfxontag( self.var_2b250b983872f1b2, self, "tag_origin" );
        ztron_sound::ztron_playsound( "ztron_hazard_pole_warning", undefined, self );
        wait 2;
        stopfxontag( self.var_2b250b983872f1b2, self, "tag_origin" );
        playfxontag( self.fx_trap_active, self, "tag_origin" );
        ztron_sound::ztron_playsound( "ztron_hazard_pole_on", undefined, self );
        ztron_sound::ztron_playsound( "ztron_hazard_pole_lp", undefined, self );
        self.active = 1;
        thread function_d45a1859f2009909( trap );
        wait randomfloatrange( 4, 10 );
        self.active = 0;
        ztron_sound::ztron_stopsound( self );
        ztron_sound::ztron_playsound( "ztron_hazard_pole_off", undefined, self );
        stopfxontag( self.fx_trap_active, self, "tag_origin" );
        playfxontag( self.var_7c6c1fd5e7ec0b2, self, "tag_origin" );
    }
}

// Namespace ztron_hazard_electric_pole
// Params 1
// Checksum 0x9aa1dad1, Offset: 0xb13
// Size: 0x354
function function_d45a1859f2009909( trap )
{
    self endon( #"death", #"destroy_hazard" );
    
    while ( isdefined( self ) && self.active )
    {
        if ( !isdefined( self.trigger ) )
        {
            trigger_radius = trap.trigger_radius ?? 32;
            trigger_height = trap.trigger_height ?? 150;
            self.trigger = spawn( "noent_volume_trigger_rotatable_radius", self.origin, 0, trigger_radius, trigger_height );
            self.trigger.angles = trap.angles ?? ( 0, 0, 0 );
            self.trigger thread ztron_util::function_36239518d8da65f0( self, "death" );
            
            /#
                if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
                {
                    self.trigger thread ztron_debug::drawtrigger();
                }
            #/
        }
        
        result = self.trigger zm_utility::function_1c9c2fe2e9936f90( 0.25 );
        
        if ( isstring( result ) && result == "timeout" )
        {
            continue;
        }
        
        if ( isdefined( result ) )
        {
            if ( !isdefined( result.ztron ) )
            {
                continue;
            }
            
            if ( result.no_hazards )
            {
                continue;
            }
            
            if ( result.var_c74f88d55ddb2df0 )
            {
                continue;
            }
            
            if ( !isdefined( result.ztron.var_94870e86c4278904 ) )
            {
                result.ztron.var_94870e86c4278904 = 0;
            }
            
            curtime = gettime();
            
            if ( curtime < result.ztron.var_94870e86c4278904 )
            {
                continue;
            }
            
            playfxontag( utility::getfx( "ztron_hazard_electric" ), result, "tag_origin" );
            
            if ( result.ztron.var_1bcec1b9cd2716d8 )
            {
                continue;
            }
            
            if ( isplayer( result ) && result.ztron.var_2588c7465d7536b2 & 1024 )
            {
                if ( result issprintsliding() )
                {
                    continue;
                }
            }
            
            result.ztron.var_94870e86c4278904 = curtime + 1500;
            ztron_sound::ztron_playsound( "ztron_hazard_pole_impact", self.origin );
            
            if ( isplayer( result ) || result vehicle::is_vehicle() )
            {
                result dodamage( result.health + 100, result.origin, self, self, "MOD_ELEMENTAL_ELEC" );
                continue;
            }
            
            if ( result tagexists( "j_spine4" ) )
            {
                ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "ztron_hazard_electric_shock" ), result, "j_spine4" );
            }
            
            if ( result tagexists( "j_eyeball_le" ) )
            {
                ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "ztron_hazard_electric_shock_eyes" ), result, "j_eyeball_le" );
            }
            
            ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "ztron_hazard_electric_shock_ground" ), result, "tag_origin" );
            result zombie_stun::stun_ai( 1 );
            result thread ztron_util::function_ea0a0be5c5468c48( 1, undefined, "MOD_ELEMENTAL_ELEC", 0 );
        }
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
}

