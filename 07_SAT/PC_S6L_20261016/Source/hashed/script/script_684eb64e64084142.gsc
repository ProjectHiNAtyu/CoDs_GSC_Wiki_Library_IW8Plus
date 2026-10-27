// script_684eb64e64084142  (hash_684eb64e64084142.gscc) (size: 5237 Bytes / 0x1475 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1683dc91 (377740433)
// size ...... 5237 (0x1475)
// includes .. 7   (offset: 0x136d)
// strings ... 15  (offset: 0x13a5)
// dev strs .. 0   (offset: 0x1475)
// exports ... 16  (offset: 0xb4d)
// cseg ...... 0x19d + 0x9b0 (0xb4d)
// imports ... 50  (offset: 0xdcd)
// animtree1 . 0   (offset: 0x1475)
// animtree2 . 0   (offset: 0x1475)
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_rock_slide;

// Namespace ztron_hazard_rock_slide
// Params 0, eflags: 0x5
// Checksum 0x5a0a4479, Offset: 0x1bb
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_rock_slide", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_rock_slide
// Params 0
// Checksum 0x10f3f436, Offset: 0x1e4
// Size: 0x62
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"rock_slide", #"create", &function_f31c9ced099a8eba );
    ztron_hazard::function_6f661fac5fd31f1( #"rock_slide", #"arenaspawn", &function_9b86e9770e8a51f5 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_rock_slide_rolling_lp", "evt_ztron_hazard_rockslide_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_rock_slide_hit", "evt_ztron_hazard_rockslide_impact" );
}

// Namespace ztron_hazard_rock_slide
// Params 0
// Checksum 0xa89c32fa, Offset: 0x24e
// Size: 0x9c
function function_9b86e9770e8a51f5()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "rock_slide" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_f31c9ced099a8eba( var_4d080f710fb8349e );
    }
}

// Namespace ztron_hazard_rock_slide
// Params 2
// Checksum 0xbbfd0bf0, Offset: 0x2f2
// Size: 0x1e
function function_f31c9ced099a8eba( trap, paged )
{
    thread function_afc8d34f6fd12af5( trap );
}

// Namespace ztron_hazard_rock_slide
// Params 1
// Checksum 0xe55f2edb, Offset: 0x318
// Size: 0x1fd
function function_afc8d34f6fd12af5( trap )
{
    level endon( #"ztron_game_is_over" );
    trap endon( #"destroy_hazard" );
    nextpos = utility::getstruct( trap.target, "targetname" );
    trap.spawn_interval = 5;
    trap.free_fall_delay = 2;
    trap.destructtype = "lava_explo";
    
    if ( isdefined( trap.script_parameters ) )
    {
        parameters = strtok( trap.script_parameters, ";" );
        
        if ( parameters.size > 0 )
        {
            trap.spawn_interval = float( parameters[ 0 ] );
        }
        
        if ( parameters.size > 1 )
        {
            trap.free_fall_delay = float( parameters[ 1 ] );
        }
        
        if ( parameters.size > 2 )
        {
            trap.destructtype = parameters[ 2 ];
        }
    }
    
    while ( true )
    {
        rock = utility::spawn_model( "sat_zm_ztron_props_ball_rock", trap.origin, trap.angles );
        trigger = spawn( "trigger_radius", rock.origin + ( 0, 0, -25 ), 0, 50, 55 );
        trigger.owner = rock;
        rock.trigger = trigger;
        rock.velocity = 220;
        rock.players = [];
        rock.trap = trap;
        
        /#
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                rock thread function_17302de81528af17( trigger, trap );
            }
        #/
        
        rock thread rock_death_watcher( trap );
        rock thread function_97ca1aeb571599e( trigger, trap );
        rock thread trigger_target_watcher( trigger, trap );
        rock thread rock_rotater( trap );
        rock thread function_3b8eeff007d3cf9a( nextpos );
        wait trap.spawn_interval;
    }
}

// Namespace ztron_hazard_rock_slide
// Params 0
// Checksum 0xbc4e3957, Offset: 0x51d
// Size: 0x4f
function lavaexplosion()
{
    vfx_scriptable = spawnscriptable( "scriptable_zombie_triton_lava_bomb_aoe", self.origin + ( 0, 0, 32 ) );
    
    if ( vfx_scriptable )
    {
        vfx_scriptable thread function_1b1d36bddb2d52f1( 4 );
        vfx_scriptable setscriptablepartstate( "impact", "impact" );
    }
}

// Namespace ztron_hazard_rock_slide
// Params 1
// Checksum 0xa29c0bd5, Offset: 0x574
// Size: 0x25
function function_1b1d36bddb2d52f1( delays )
{
    wait delays;
    self setscriptablepartstate( "impact", "off" );
    self freescriptable();
}

// Namespace ztron_hazard_rock_slide
// Params 1
// Checksum 0x7dae3b4f, Offset: 0x5a1
// Size: 0x5d
function rock_death_watcher( trap )
{
    self endon( #"death" );
    trap thread ztron_hazard::function_4d643b159a80c647();
    trap waittill( #"destroy_hazard" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    if ( isdefined( self ) )
    {
        ztron_sound::ztron_stopsound( self );
        self delete();
    }
}

// Namespace ztron_hazard_rock_slide
// Params 2
// Checksum 0x46d773be, Offset: 0x606
// Size: 0x6d
function function_97ca1aeb571599e( trigger, trap )
{
    self endon( #"death" );
    trigger endon( #"death" );
    trap endon( #"destroy_hazard" );
    
    while ( isdefined( self ) && isdefined( trigger ) )
    {
        trigger.origin = self.origin + ( 0, 0, -25 );
        waitframe();
    }
}

// Namespace ztron_hazard_rock_slide
// Params 2
// Checksum 0xfc146762, Offset: 0x67b
// Size: 0x1ee
function trigger_target_watcher( trigger, trap )
{
    self endon( #"death" );
    trigger endon( #"death" );
    trap endon( #"destroy_hazard" );
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( ent.no_hazards || ent.ztron.boss )
        {
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            if ( !arraycontains( self.players, ent ) )
            {
                self.players[ self.players.size ] = ent;
                dmg = ent.maxhealth / 2;
                var_c317dd212509d1a0 = dmg >= ent.health;
                
                if ( isdefined( self.direction ) && !var_c317dd212509d1a0 )
                {
                    var_3df44f796978c518 = ent.origin - self.origin;
                    anglebias = math::anglebetweenvectors( self.direction, var_3df44f796978c518 );
                    
                    if ( anglebias < 90 )
                    {
                        ent utility::knockback_flat( var_3df44f796978c518, 1500 );
                    }
                }
                
                ent dodamage( dmg, ent.origin, self, trigger, "MOD_IMPACT" );
                ent playrumbleonentity( "damage_heavy" );
                ztron_sound::ztron_playsound( "ztron_hazard_rock_slide_hit", ent.origin );
            }
            
            continue;
        }
        
        if ( ent.team != level.players[ 0 ].team )
        {
            var_3df44f796978c518 = ent.origin - self.origin;
            ent thread ztron_util::function_afa1f6a404783c8a( var_3df44f796978c518, 10000 );
            ztron_sound::ztron_playsound( "ztron_hazard_rock_slide_hit", ent.origin );
        }
    }
}

// Namespace ztron_hazard_rock_slide
// Params 1
// Checksum 0x100996b8, Offset: 0x871
// Size: 0xb2
function function_3b8eeff007d3cf9a( pos )
{
    self endon( #"death" );
    ztron_sound::ztron_playsound( "ztron_hazard_rock_slide_rolling_lp", undefined, self );
    move_to_next_pos( pos );
    rock_slide_launch();
    ztron_sound::ztron_stopsound( self );
    
    if ( isdefined( self.trap.free_fall_delay ) )
    {
        wait self.trap.free_fall_delay;
    }
    
    if ( self.trap.destructtype == "lava_explo" )
    {
        lavaexplosion();
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ztron_hazard_rock_slide
// Params 1
// Checksum 0x3e41a78b, Offset: 0x92b
// Size: 0xd0
function move_to_next_pos( pos )
{
    if ( !( isdefined( pos ) && isdefined( self ) ) )
    {
        return;
    }
    
    time = 2;
    self.direction = pos.origin - self.origin;
    
    if ( self.velocity != 0 )
    {
        time = clamp( distance( pos.origin, self.origin ) / self.velocity, 0.25, 2 );
    }
    
    self moveto( pos.origin, time );
    wait time;
    
    if ( isdefined( pos.target ) )
    {
        nextpos = utility::getstruct( pos.target, "targetname" );
        move_to_next_pos( nextpos );
    }
}

// Namespace ztron_hazard_rock_slide
// Params 0
// Checksum 0x7ed09fad, Offset: 0xa03
// Size: 0x5e
function rock_slide_launch()
{
    if ( isdefined( self ) && isdefined( self.direction ) )
    {
        vec = vectornormalize( self.direction );
        self physicslaunchserver( self.origin + ( 0, 0, 10 ), vec * 800 + ( 0, 0, -150 ) );
    }
}

// Namespace ztron_hazard_rock_slide
// Params 1
// Checksum 0x915f2c4f, Offset: 0xa69
// Size: 0x3b
function rock_rotater( trap )
{
    self endon( #"death" );
    trap endon( #"destroy_hazard" );
    
    while ( isdefined( self ) )
    {
        self rotateroll( 90, 0.7 );
        waitframe();
    }
}

/#

    // Namespace ztron_hazard_rock_slide
    // Params 2, eflags: 0x4
    // Checksum 0xd512e044, Offset: 0xaac
    // Size: 0xa1, Type: dev
    function private function_17302de81528af17( trigger, trap )
    {
        level endon( #"ztron_game_is_over" );
        trap endon( #"destroy_hazard" );
        
        while ( isdefined( trigger ) )
        {
            if ( isdefined( self.direction ) )
            {
                line( trigger.origin, trigger.origin + self.direction * 50, ( 0, 1, 0 ) );
            }
            
            drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            waitframe();
        }
    }

#/
