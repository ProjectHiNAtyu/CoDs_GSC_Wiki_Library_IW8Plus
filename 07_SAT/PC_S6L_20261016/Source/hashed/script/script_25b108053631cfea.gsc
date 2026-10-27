// script_25b108053631cfea  (hash_25b108053631cfea.gscc) (size: 3148 Bytes / 0xc4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf66ad48b (4134196363)
// size ...... 3148 (0xc4c)
// includes .. 6   (offset: 0xb98)
// strings ... 10  (offset: 0xbc8)
// dev strs .. 0   (offset: 0xc4c)
// exports ... 8   (offset: 0x710)
// cseg ...... 0x17b + 0x595 (0x710)
// imports ... 29  (offset: 0x850)
// animtree1 . 0   (offset: 0xc4c)
// animtree2 . 0   (offset: 0xc4c)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_hazard_aether_slate;

// Namespace ztron_hazard_aether_slate
// Params 0, eflags: 0x5
// Checksum 0x41b5432a, Offset: 0x199
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_aether_slate", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_aether_slate
// Params 0
// Checksum 0xb6da2fd6, Offset: 0x1c2
// Size: 0x71
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"aether_slate", #"create", &function_78680fa5375dd7c0 );
    ztron_hazard::function_6f661fac5fd31f1( #"aether_slate", #"arenaspawn", &function_23e1e9ee882b41b3 );
    utility::add_fx( "ztron_aether_slate", "vfx_sat_zm_occlusion_trap_cam" );
    utility::add_fx( "ztron_aether_slate_explo", "vfx_t10_levels_zm_topaz_wwq_husk_explo_1" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_aether_slate_explode", "exp_opal_fungus_lrg" );
}

// Namespace ztron_hazard_aether_slate
// Params 0
// Checksum 0x42339049, Offset: 0x23b
// Size: 0x9c
function function_23e1e9ee882b41b3()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "aether_slate" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_78680fa5375dd7c0( var_4d080f710fb8349e );
    }
}

// Namespace ztron_hazard_aether_slate
// Params 2
// Checksum 0xe6d88df6, Offset: 0x2df
// Size: 0x1e
function function_78680fa5375dd7c0( trap, paged )
{
    thread function_6d31c386abccf39( trap );
}

// Namespace ztron_hazard_aether_slate
// Params 1
// Checksum 0x24a7443, Offset: 0x305
// Size: 0x10a
function function_6d31c386abccf39( trap )
{
    level endon( #"ztron_game_is_over" );
    trap endon( #"destroy_hazard" );
    model = utility::spawn_model( "sat_zm_ztron_props_dark_aether_mushroom_02", trap.origin, trap.angles ?? ( 0, 0, 0 ) );
    trap.model = model;
    trigger = spawn( "trigger_rotatable_radius", trap.origin, 0, 40, 20 );
    trigger.angles = trap.angles ?? ( 0, 0, 0 );
    trap.trigger = trigger;
    trigger.owner = trap;
    trigger thread triggerwatcher( trap, model );
    trap thread function_3f55cd43aaaf9bc8();
    
    /#
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            trigger thread ztron_debug::drawtrigger();
        }
    #/
}

// Namespace ztron_hazard_aether_slate
// Params 2
// Checksum 0x140f136, Offset: 0x417
// Size: 0x1c6
function triggerwatcher( trap, model )
{
    self endon( #"death" );
    trap endon( #"destroy_hazard" );
    model endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent.owner ) && isdefined( ent.owner.ztron.vehicle ) )
        {
            if ( !isdefined( ent.owner.aetherfx ) )
            {
                ent.owner.aetherfx = utility::spawn_tag_origin( ent.origin, ent.angles );
                ent.owner.aetherfx showtoplayer( ent.owner );
            }
            
            if ( !isdefined( ent.owner.var_6bcccdeed67ed43d ) || ent.owner.var_6bcccdeed67ed43d <= gettime() )
            {
                playfxontag( utility::getfx( "ztron_aether_slate" ), ent.owner.aetherfx, "tag_origin" );
                ent.owner.var_6bcccdeed67ed43d = gettime() + 5000;
            }
            
            ztron_sound::ztron_playsound( "ztron_hazard_aether_slate_explode", model.origin );
            playfx( utility::getfx( "ztron_aether_slate_explo" ), trap.origin );
            model hide();
            wait 10;
            model show();
        }
    }
}

// Namespace ztron_hazard_aether_slate
// Params 0
// Checksum 0x2ef7b42e, Offset: 0x5e5
// Size: 0x12b
function function_3f55cd43aaaf9bc8()
{
    self notify( #"hash_67f9b54af59ea542" );
    self endon( #"hash_67f9b54af59ea542" );
    level endon( #"ztron_game_is_over" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    self waittill( #"destroy_hazard" );
    
    if ( isdefined( self.model ) )
    {
        self.model delete();
        self.model = undefined;
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.aetherfx ) )
        {
            player.aetherfx delete();
            player.aetherfx = undefined;
            player.var_6bcccdeed67ed43d = undefined;
        }
    }
}

