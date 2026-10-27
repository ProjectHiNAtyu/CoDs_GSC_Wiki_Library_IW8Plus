// scripts\mp\zm\maps\zm_sat_mantis\systems\zm_sat_mantis_intel.gsc  (hash_1fc2dba09f9ecfab.gscc) (size: 2490 Bytes / 0x9ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6dead3f1 (1844106225)
// size ...... 2490 (0x9ba)
// includes .. 5   (offset: 0x8ca)
// strings ... 16  (offset: 0x8f2)
// dev strs .. 0   (offset: 0x9ba)
// exports ... 8   (offset: 0x5a6)
// cseg ...... 0x1f2 + 0x3b4 (0x5a6)
// imports ... 15  (offset: 0x6e6)
// animtree1 . 0   (offset: 0x9ba)
// animtree2 . 0   (offset: 0x9ba)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zombie_intel;

#namespace zm_sat_mantis_intel;

// Namespace zm_sat_mantis_intel
// Params 0, eflags: 0x5
// Checksum 0x79138a87, Offset: 0x210
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_ee754642c62ea65a", undefined, &__init__, undefined );
}

// Namespace zm_sat_mantis_intel
// Params 0
// Checksum 0xc09f75bc, Offset: 0x231
// Size: 0x1d
function __init__()
{
    if ( !getdvarint( @"hash_bb4d4e9d5661c0f9", 0 ) )
    {
        return;
    }
    
    level thread intel_setup();
}

// Namespace zm_sat_mantis_intel
// Params 0
// Checksum 0x6ed01466, Offset: 0x256
// Size: 0xd9
function intel_setup()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zm_sat_mantis_intel_create_script_completed" );
    zm_save::function_1f44a48caae2acbf();
    level.var_576311e16725542b = utility::getstruct( "chalk_d_1" );
    level.var_576312e16725565e = utility::getstruct( "chalk_d_2" );
    level.var_576313e167255891 = utility::getstruct( "chalk_d_3" );
    level.var_576314e167255ac4 = utility::getstruct( "chalk_d_4" );
    utility::spawn_model( "sat_zm_intel_mantis_doc_05", level.var_576311e16725542b.origin, level.var_576311e16725542b.angles );
    wait 5;
    level.chalk_drawing_1 = zm_quest::function_91f9590e98d57ff6( level.var_576311e16725542b.origin, &function_9407baa28b9d4c8f, &chalk_hint, "medium_anyanglefov" );
}

// Namespace zm_sat_mantis_intel
// Params 2
// Checksum 0x7e4a4c64, Offset: 0x337
// Size: 0x40
function chalk_hint( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_intel/chalk_interact", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_mantis_intel
// Params 1
// Checksum 0x482a0ef8, Offset: 0x380
// Size: 0xb1
function function_9407baa28b9d4c8f( player )
{
    level.chalk_drawing_1 freescriptable();
    intel::spawn_intel_at_location( undefined, undefined, level.var_576311e16725542b.origin, level.var_576311e16725542b.angles, "zmintel_sat_mantis_audiolog_7" );
    utility::spawn_model( "sat_zm_intel_mantis_doc_08", level.var_576312e16725565e.origin, level.var_576312e16725565e.angles );
    level.chalk_drawing_2 = zm_quest::function_91f9590e98d57ff6( level.var_576312e16725565e.origin, &function_db602eb2641aac94, &chalk_hint, "medium_anyanglefov" );
}

// Namespace zm_sat_mantis_intel
// Params 1
// Checksum 0xd5d68f7f, Offset: 0x439
// Size: 0xb1
function function_db602eb2641aac94( player )
{
    level.chalk_drawing_2 freescriptable();
    intel::spawn_intel_at_location( undefined, undefined, level.var_576312e16725565e.origin, level.var_576312e16725565e.angles, "zmintel_sat_mantis_audiolog_8" );
    utility::spawn_model( "sat_zm_intel_mantis_doc_07", level.var_576313e167255891.origin, level.var_576313e167255891.angles );
    level.chalk_drawing_3 = zm_quest::function_91f9590e98d57ff6( level.var_576313e167255891.origin, &function_56ba94979f94ddf9, &chalk_hint, "medium_anyanglefov" );
}

// Namespace zm_sat_mantis_intel
// Params 1
// Checksum 0x32e8d912, Offset: 0x4f2
// Size: 0xb4
function function_56ba94979f94ddf9( player )
{
    level.chalk_drawing_3 freescriptable();
    intel::spawn_intel_at_location( undefined, undefined, level.var_576313e167255891.origin, level.var_576313e167255891.angles, "zmintel_sat_mantis_audiolog_9" );
    utility::spawn_model( "sat_zm_intel_mantis_doc_06", level.var_576314e167255ac4.origin, level.var_576314e167255ac4.angles );
    intel::spawn_intel_at_location( undefined, undefined, level.var_576314e167255ac4.origin, level.var_576314e167255ac4.angles, "zmintel_sat_mantis_audiolog_10" );
}

