// script_5c83e389220d3e8d  (hash_5c83e389220d3e8d.gscc) (size: 3535 Bytes / 0xdcf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88506545 (2286970181)
// size ...... 3535 (0xdcf)
// includes .. 8   (offset: 0xd0b)
// strings ... 9   (offset: 0xd4b)
// dev strs .. 0   (offset: 0xdcf)
// exports ... 11  (offset: 0x767)
// cseg ...... 0x146 + 0x621 (0x767)
// imports ... 35  (offset: 0x91f)
// animtree1 . 0   (offset: 0xdcf)
// animtree2 . 0   (offset: 0xdcf)
#using script_9d7b1b99a878301;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_saw_blade;

// Namespace ztron_hazard_saw_blade
// Params 0, eflags: 0x5
// Checksum 0x6cc2cfb5, Offset: 0x164
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_saw_blade", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_saw_blade
// Params 0
// Checksum 0xb688f7e4, Offset: 0x18d
// Size: 0x73
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"saw_blade", #"create", &function_efa81853f0c10804 );
    ztron_hazard::function_6f661fac5fd31f1( #"saw_blade", #"arenaspawn", &function_5e9f2b7ad4f05242 );
    utility::add_fx( "ztron_hazard_saw_blade", "vfx_sat_zm_saw_spark_ztron" );
    utility::add_fx( "ztron_hazard_saw_blade_idle", "vfx_sat_zm_saw_idle_spark_ztron" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_saw_blade_lp", "evt_ztron_hazard_sawblade_lp", 1 );
}

// Namespace ztron_hazard_saw_blade
// Params 0
// Checksum 0x5ff8c166, Offset: 0x208
// Size: 0xb1
function function_5e9f2b7ad4f05242()
{
    level.ztron.var_4ed35ea665804a84 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "saw_blade" );
    
    foreach ( trap in traps )
    {
        function_efa81853f0c10804( trap );
    }
}

// Namespace ztron_hazard_saw_blade
// Params 2
// Checksum 0x3e4f62fc, Offset: 0x2c1
// Size: 0x9d
function function_efa81853f0c10804( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_4ed35ea665804a84[ level.ztron.var_4ed35ea665804a84.size ] = trap;
        return;
    }
    
    trap.need_moving = 0;
    
    if ( trap.target )
    {
        trap.need_moving = 1;
        trap.reverse_callback = &function_afd2d792191eff6e;
        ztron_hazard_moving_platform::function_1e2210d0aea2cda9( trap );
    }
    
    function_4deda08a92c5d1c7( trap, page );
}

// Namespace ztron_hazard_saw_blade
// Params 0
// Checksum 0x2aa9f324, Offset: 0x366
// Size: 0x37
function function_afd2d792191eff6e()
{
    self.script_model.angles += ( 0, 180, 0 );
}

// Namespace ztron_hazard_saw_blade
// Params 2
// Checksum 0x38edc302, Offset: 0x3a5
// Size: 0x195
function function_4deda08a92c5d1c7( trap, page )
{
    if ( trap.need_moving )
    {
        ztron_hazard_moving_platform::function_5aff0f6748b42c3f( trap );
        trap.script_model.hazardtype = "saw_blade";
        playfxontag( utility::getfx( "ztron_hazard_saw_blade" ), trap.script_model, "tag_origin" );
    }
    else
    {
        trap.script_model = utility::spawn_model( %"sat_zm_ztron_props_buzzsaw_blade_rotation", trap.origin, trap.angles );
        trap.script_model thread function_c93fb1e58e55875a();
        playfxontag( utility::getfx( "ztron_hazard_saw_blade_idle" ), trap.script_model, "tag_origin" );
    }
    
    trap.script_trigger = spawn( "trigger_rotatable_radius", trap.origin, 0, 36, 5 );
    trap.script_trigger.angles = trap.angles + ( 90, 0, 0 );
    trap.script_trigger.owner = trap;
    trap.script_trigger enablelinkto();
    trap.script_trigger linkto( trap.script_model, "tag_origin" );
    ztron_sound::ztron_playsound( "ztron_hazard_saw_blade_lp", undefined, trap.script_trigger );
    trap thread function_d64ae932a3e3f17a( trap.script_trigger );
}

// Namespace ztron_hazard_saw_blade
// Params 1
// Checksum 0x6c6c3210, Offset: 0x542
// Size: 0xf7
function function_d64ae932a3e3f17a( trigger )
{
    self notify( #"hash_af0bba7635c13461" );
    self endon( #"hash_af0bba7635c13461" );
    trigger endon( #"death" );
    trigger thread function_7202d9526dd6c493();
    
    /#
        trigger thread drawtrigger();
    #/
    
    while ( true )
    {
        trigger waittill( #"trigger", guy );
        
        if ( guy.no_hazards || guy.ztron.boss || !isalive( guy ) )
        {
            continue;
        }
        
        if ( isplayer( guy ) || guy vehicle::is_vehicle() )
        {
            guy dodamage( guy.health + 100, guy.origin, trigger );
            continue;
        }
        
        if ( !guy.marked_for_death )
        {
            guy thread ztron_util::function_ea0a0be5c5468c48( 0.1, undefined, undefined, 0 );
        }
    }
}

// Namespace ztron_hazard_saw_blade
// Params 0
// Checksum 0x63568474, Offset: 0x641
// Size: 0x46
function function_c93fb1e58e55875a()
{
    self notify( #"hash_d979ab004ba9f80a" );
    self endon( #"hash_d979ab004ba9f80a" );
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    wait 0.5;
    self delete();
}

// Namespace ztron_hazard_saw_blade
// Params 0
// Checksum 0xb88bbc6a, Offset: 0x68f
// Size: 0x4e
function function_7202d9526dd6c493()
{
    self notify( #"hash_c264572af2f7e3c1" );
    self endon( #"hash_c264572af2f7e3c1" );
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    ztron_sound::ztron_stopsound( self );
    wait 0.5;
    self delete();
}

/#

    // Namespace ztron_hazard_saw_blade
    // Params 0
    // Checksum 0xb09d1a5, Offset: 0x6e5
    // Size: 0x82, Type: dev
    function drawtrigger()
    {
        self notify( #"hash_e77623d3705956da" );
        self endon( #"hash_e77623d3705956da" );
        level endon( #"ztron_game_is_over" );
        self endon( #"death" );
        self endon( #"destroy_hazard" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                drawtrigger( self, ( 0, 1, 0 ), 0, 1, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
