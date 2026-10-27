// script_7b63cf61bfdefb8b  (hash_7b63cf61bfdefb8b.gscc) (size: 2765 Bytes / 0xacd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75585008 (1968721928)
// size ...... 2765 (0xacd)
// includes .. 6   (offset: 0xa4d)
// strings ... 6   (offset: 0xa7d)
// dev strs .. 0   (offset: 0xacd)
// exports ... 11  (offset: 0x58d)
// cseg ...... 0x109 + 0x484 (0x58d)
// imports ... 27  (offset: 0x745)
// animtree1 . 0   (offset: 0xacd)
// animtree2 . 0   (offset: 0xacd)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_28bb5847dc0a2b7f;

// Namespace namespace_28bb5847dc0a2b7f
// Params 0, eflags: 0x5
// Checksum 0x5180d1d8, Offset: 0x127
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_89239f01f418bc5a", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 0
// Checksum 0xbb1166, Offset: 0x150
// Size: 0x4f
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"fragile_platform", #"create", &function_b65f559fca67622b );
    ztron_hazard::function_6f661fac5fd31f1( #"fragile_platform", #"arenaspawn", &function_c2019e52c7b715a8 );
    ztron_sound::function_4ac735395b173fe( "ztron_fragile_platform_broken", "evt_ztron_platform_break" );
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 0
// Checksum 0xeb080d1d, Offset: 0x1a7
// Size: 0x9c
function function_c2019e52c7b715a8()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "fragile_platform" );
    
    foreach ( hazard in hazards )
    {
        function_b65f559fca67622b( hazard );
    }
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 2
// Checksum 0xde4ec1c1, Offset: 0x24b
// Size: 0xb0
function function_b65f559fca67622b( trapstruct, paged )
{
    trapstruct.var_71e2674e906f0599 = 1.5;
    trapstruct.var_5f97ae50c80852c6 = 3;
    trapstruct.trigger = spawn( "trigger_box", trapstruct.origin + ( 0, 0, 4 ), 0, ( 32, 64, 8 ), ( 32, 64, 8 ) );
    trapstruct.trigger.owner = trapstruct;
    trapstruct thread function_6054f2e2557102f();
    hazard_spawn_model( trapstruct );
    hazard_activate_trigger( trapstruct );
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 3
// Checksum 0x83d895a3, Offset: 0x303
// Size: 0xbb
function function_bffb9bfb6ecd194d( enteringentity, trigger, payload )
{
    payload endon( #"destroy_hazard" );
    trigger notify( #"hash_73537c07898a047a" );
    wait payload.var_71e2674e906f0599 - 0.2;
    playfx( utility::getfx( "ztron_fall_hundred_broken_platform" ), payload.origin, payload.angles );
    ztron_sound::ztron_playsound( "ztron_fragile_platform_broken", payload.origin );
    wait 0.2;
    payload.script_model delete();
    wait payload.var_5f97ae50c80852c6;
    hazard_spawn_model( payload );
    hazard_activate_trigger( payload );
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 3
// Checksum 0x59a08c91, Offset: 0x3c6
// Size: 0x2b, Type: bool
function function_5369ca5d580fef13( var_11bf9622e9646279, trigger, payload )
{
    if ( isplayer( var_11bf9622e9646279 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 1, eflags: 0x4
// Checksum 0xf5886524, Offset: 0x3fa
// Size: 0x75
function private hazard_spawn_model( trapstruct )
{
    trapstruct.script_model = utility::spawn_model( "decor_dock_platform_ai_64x128_dmg_ztron", trapstruct.origin, trapstruct.angles );
    trapstruct.script_model.hazardtype = "fragile_platform";
    trapstruct.script_model setcandamage( 0 );
    trapstruct.script_model solid();
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 1, eflags: 0x4
// Checksum 0xc4ff6b79, Offset: 0x477
// Size: 0x44
function private hazard_activate_trigger( trapstruct )
{
    trigger::makeenterexittrigger( trapstruct.trigger, &function_bffb9bfb6ecd194d, undefined, undefined, undefined, &function_5369ca5d580fef13, trapstruct );
    
    /#
        trapstruct thread debug_draw_trigger( trapstruct.trigger );
    #/
}

// Namespace namespace_28bb5847dc0a2b7f
// Params 0
// Checksum 0xaf629384, Offset: 0x4c3
// Size: 0x60
function function_6054f2e2557102f()
{
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger notify( #"hash_73537c07898a047a" );
        self.trigger delete();
    }
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model delete();
    }
}

/#

    // Namespace namespace_28bb5847dc0a2b7f
    // Params 1, eflags: 0x4
    // Checksum 0x2892788, Offset: 0x52b
    // Size: 0x62, Type: dev
    function private debug_draw_trigger( trigger )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"destroy_hazard" );
        trigger endon( #"hash_73537c07898a047a" );
        
        while ( isdefined( trigger ) )
        {
            drawtrigger( trigger, ( 1, 0, 0 ), 0, 0, 0, ( 1, 0, 0 ) );
            waitframe();
        }
    }

#/
