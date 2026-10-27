// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_intel.gsc  (hash_5416fb5fc12ab0d2.gscc) (size: 1528 Bytes / 0x5f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf45e2c1 (3745899201)
// size ...... 1528 (0x5f8)
// includes .. 4   (offset: 0x55c)
// strings ... 10  (offset: 0x57c)
// dev strs .. 0   (offset: 0x5f8)
// exports ... 5   (offset: 0x320)
// cseg ...... 0x126 + 0x1fa (0x320)
// imports ... 13  (offset: 0x3e8)
// animtree1 . 0   (offset: 0x5f8)
// animtree2 . 0   (offset: 0x5f8)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zombie_intel;

#namespace zm_sat_locust_intel;

// Namespace zm_sat_locust_intel
// Params 0, eflags: 0x5
// Checksum 0x9e02d8b4, Offset: 0x144
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_a8a953d3f278c7fc", undefined, &__init__, undefined );
}

// Namespace zm_sat_locust_intel
// Params 0
// Checksum 0x314cc344, Offset: 0x165
// Size: 0x1d
function __init__()
{
    if ( !getdvarint( @"hash_42cdb7fc777fae63", 0 ) )
    {
        return;
    }
    
    level thread intel_setup();
}

// Namespace zm_sat_locust_intel
// Params 0
// Checksum 0xd4380a97, Offset: 0x18a
// Size: 0x46
function intel_setup()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zm_sat_locust_intel_create_script_completed" );
    zm_save::function_1f44a48caae2acbf();
    vent_trigger = getent( "v_it_d", "targetname" );
    vent_trigger thread vent_watcher();
}

// Namespace zm_sat_locust_intel
// Params 0
// Checksum 0xa285896a, Offset: 0x1d8
// Size: 0x148
function vent_watcher()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) )
        {
            if ( smeansofdeath == "MOD_EXPLOSION" || smeansofdeath == "MOD_GRENADE_SPLASH" && !level utility::flag( "vent_intel_spawned" ) )
            {
                level utility::flag_set( "vent_intel_spawned" );
                var_503e9aec49243d84 = utility::getstruct( "p_vt_s" );
                var_1d28a45a94efc2fd = utility::getstruct( "p_vt_l" );
                intel::spawn_intel_at_location( undefined, undefined, var_503e9aec49243d84.origin, var_503e9aec49243d84.angles, "zmintel_sat_locust_document_6", var_1d28a45a94efc2fd.origin );
            }
        }
    }
}

