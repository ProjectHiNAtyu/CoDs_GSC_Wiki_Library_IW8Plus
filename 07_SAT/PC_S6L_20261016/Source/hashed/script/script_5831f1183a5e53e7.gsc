// script_5831f1183a5e53e7  (hash_5831f1183a5e53e7.gscc) (size: 3574 Bytes / 0xdf6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc857f125 (3361206565)
// size ...... 3574 (0xdf6)
// includes .. 10  (offset: 0xca6)
// strings ... 18  (offset: 0xcf6)
// dev strs .. 0   (offset: 0xdf6)
// exports ... 7   (offset: 0x71a)
// cseg ...... 0x22e + 0x4ec (0x71a)
// imports ... 39  (offset: 0x832)
// animtree1 . 0   (offset: 0xdf6)
// animtree2 . 0   (offset: 0xdf6)
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace namespace_5402119d06199aaa;

// Namespace namespace_5402119d06199aaa
// Params 0, eflags: 0x5
// Checksum 0x35c5f1f8, Offset: 0x24c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_86bdf5d6dc75f529", #"ztron_item", undefined, &init );
}

// Namespace namespace_5402119d06199aaa
// Params 0
// Checksum 0xd1a85936, Offset: 0x275
// Size: 0x77
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"clock", #"use", &useclock );
    utility::add_fx( "timeshift", "vfx_sat_zm_powerup_timeshift_ztron" );
    utility::add_fx( "timeshift_fade", "vfx_sat_zm_powerup_timeshift_fade_ztron" );
    utility::add_fx( "timeshift_contact", "vfx_sat_zm_powerup_timeshift_impact_ztron" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_clock_active_lp", "evt_ztron_pickup_clock_active_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_clock_active_end", "evt_ztron_pickup_clock_active_end" );
}

// Namespace namespace_5402119d06199aaa
// Params 1, eflags: 0x4
// Checksum 0x64119635, Offset: 0x2f4
// Size: 0x212
function private useclock( params )
{
    player = params.player;
    item = params.scriptable;
    hitp = ztron_util::function_3fe38741460a4a49( item.origin );
    origin = ( item.origin[ 0 ], item.origin[ 1 ], hitp[ 2 ] );
    clock = utility::spawn_model( "sat_zm_ztron_props_clock", origin );
    clock.targetname = "clock";
    ztron_sound::ztron_playsound( "ztron_pickup_clock_active_lp", undefined, clock );
    clock playloopsound( "zmb_pwup_clock_loop" );
    trigger = spawn( "trigger_radius", clock.origin, 9, 245, 100 );
    trigger.targetname = "clockTrigger";
    trigger enablelinkto();
    trigger linkto( clock );
    timetowait = player ztron_player_utility::function_10777122eee28fa8( 20 );
    
    /#
        trigger thread clock_debug();
    #/
    
    fxorg = utility::function_1808878d1c511ce8( clock.origin, ( 0, 0, 0 ) );
    playfxontag( utility::getfx( "timeshift" ), fxorg, "tag_origin" );
    clock thread ztron_util::function_b59665f20a2dbee( 0.6, 0 );
    trigger thread timeshifter();
    var_d6e9778e6b9b6d1a = player utility::waittill_any_timeout( timetowait, "ztron_exit_taken", "ztron_teleporter_taken" );
    playfx( utility::getfx( "timeshift_fade" ), fxorg.origin );
    wait 0.6;
    stopfxontag( utility::getfx( "timeshift" ), fxorg, "tag_origin" );
    ztron_sound::ztron_stopsound( clock );
    ztron_sound::ztron_playsound( "ztron_pickup_clock_active_end", undefined, clock );
    wait 1;
    
    if ( isdefined( clock ) )
    {
        clock delete();
    }
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
    
    if ( isdefined( fxorg ) )
    {
        fxorg delete();
    }
}

// Namespace namespace_5402119d06199aaa
// Params 0, eflags: 0x4
// Checksum 0xc15ff613, Offset: 0x50e
// Size: 0xd1
function private timeshifter()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( guy.timeshifted )
        {
            continue;
        }
        
        if ( !isagent( guy ) )
        {
            continue;
        }
        
        if ( guy.var_6ebd75f51df9cf2f || guy.ztron.boss )
        {
            continue;
        }
        
        if ( ai::is_doing_traversal( guy ) )
        {
            continue;
        }
        
        if ( guy isragdoll() )
        {
            continue;
        }
        
        if ( !isalive( guy ) || guy.health <= 0 )
        {
            continue;
        }
        
        if ( guy.team != zm_utility::get_zombie_team() )
        {
            continue;
        }
        
        guy thread timeshiftme( self );
    }
}

// Namespace namespace_5402119d06199aaa
// Params 1, eflags: 0xc
// Checksum 0x2c7847e7, Offset: 0x5e7
// Size: 0xdd
function private timeshiftme( trigger )
{
    self notify( #"hash_b9fd2962f7d0a5f4" );
    self endon( #"hash_b9fd2962f7d0a5f4" );
    self endon( #"death" );
    self.timeshifted = 1;
    ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "timeshift_contact" ), self, "tag_origin" );
    asm::function_d82cb83c9c260d49( 0.25 );
    asm::function_24133a663bba593c();
    
    while ( isalive( self ) && isdefined( trigger ) && self istouching( trigger ) )
    {
        /#
        #/
        
        wait 0.5;
    }
    
    ztron_vfx::aistopfxontag( utility::getfx( "timeshift_contact" ), self, "tag_origin" );
    wait 0.75;
    asm::function_d82cb83c9c260d49( self.ztron.anim_rate ?? 1 );
    asm::function_24133a663bba593c();
    self.timeshifted = undefined;
}

/#

    // Namespace namespace_5402119d06199aaa
    // Params 0
    // Checksum 0xf9f8cee3, Offset: 0x6cc
    // Size: 0x4e, Type: dev
    function clock_debug()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_ztron_clock", 0 ) )
            {
                drawtrigger( self, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
