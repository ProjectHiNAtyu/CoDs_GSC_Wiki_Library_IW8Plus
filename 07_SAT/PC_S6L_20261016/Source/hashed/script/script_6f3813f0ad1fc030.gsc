// script_6f3813f0ad1fc030  (hash_6f3813f0ad1fc030.gscc) (size: 1616 Bytes / 0x650 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe7b4895e (3887368542)
// size ...... 1616 (0x650)
// includes .. 3   (offset: 0x5f4)
// strings ... 5   (offset: 0x60c)
// dev strs .. 0   (offset: 0x650)
// exports ... 8   (offset: 0x31c)
// cseg ...... 0xc8 + 0x254 (0x31c)
// imports ... 14  (offset: 0x45c)
// animtree1 . 0   (offset: 0x650)
// animtree2 . 0   (offset: 0x650)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\destructibles\destructibles;

#namespace zm_sat_mantis_destructibles;

// Namespace zm_sat_mantis_destructibles
// Params 0, eflags: 0x5
// Checksum 0x602a5a92, Offset: 0xe6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_55347e07429e3bf8", #"destructibles", undefined, &init );
}

// Namespace zm_sat_mantis_destructibles
// Params 0
// Checksum 0xe5833a47, Offset: 0x10f
// Size: 0x28
function init()
{
    if ( level.mapname != "zm_sat_mantis" )
    {
        return;
    }
    
    utility::flag_wait( "destructibles_ready" );
    thread setup_souleater_cyst();
}

// Namespace zm_sat_mantis_destructibles
// Params 0, eflags: 0x4
// Checksum 0x5b7996c3, Offset: 0x13f
// Size: 0xb5
function private setup_souleater_cyst()
{
    destructible::waittill_ready( "sat_destructible_souleater_cyst_01" );
    cysts = destructible::function_c28a5f35d1a84d43( "sat_destructible_souleater_cyst_01" );
    
    foreach ( cyst in cysts )
    {
        if ( !cyst destructible::function_31ba46fce3c9ee93() )
        {
            cyst destructible::function_12e4a9779677a8b8( "destructible_destroyed", { #execute:&function_f20d47192d6eabe6 } );
        }
    }
}

// Namespace zm_sat_mantis_destructibles
// Params 1, eflags: 0x4
// Checksum 0x95b593ce, Offset: 0x1fc
// Size: 0x1c
function private function_f20d47192d6eabe6( params )
{
    if ( function_b901aa28ccca4505() )
    {
        thread function_745c123f3b76858e();
    }
}

// Namespace zm_sat_mantis_destructibles
// Params 0
// Checksum 0xa23e1656, Offset: 0x220
// Size: 0x11
function function_c44fb2c07b6fd897()
{
    return { #execute:&function_f20d47192d6eabe6 };
}

// Namespace zm_sat_mantis_destructibles
// Params 0, eflags: 0x4
// Checksum 0x8cfb0173, Offset: 0x23a
// Size: 0x9d, Type: bool
function private function_b901aa28ccca4505()
{
    cysts = destructible::function_c28a5f35d1a84d43( "sat_destructible_souleater_cyst_01" );
    
    foreach ( cyst in cysts )
    {
        if ( !cyst destructible::is_destroyed() && !cyst destructible::function_31ba46fce3c9ee93() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_mantis_destructibles
// Params 0, eflags: 0x4
// Checksum 0xfeb726ae, Offset: 0x2e0
// Size: 0x3c
function private function_745c123f3b76858e()
{
    level waittill( #"timetravel_done", timeline );
    
    if ( timeline == "past" )
    {
        level notify( #"hash_189a83da9f8382d3" );
        return;
    }
    
    function_745c123f3b76858e();
}

