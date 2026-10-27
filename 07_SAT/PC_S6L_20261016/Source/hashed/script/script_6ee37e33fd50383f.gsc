// script_6ee37e33fd50383f  (hash_6ee37e33fd50383f.gscc) (size: 1961 Bytes / 0x7a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41f736c0 (1106720448)
// size ...... 1961 (0x7a9)
// includes .. 3   (offset: 0x749)
// strings ... 4   (offset: 0x761)
// dev strs .. 1   (offset: 0x79d)
// exports ... 7   (offset: 0x409)
// cseg ...... 0x90 + 0x379 (0x409)
// imports ... 19  (offset: 0x521)
// animtree1 . 0   (offset: 0x7a9)
// animtree2 . 0   (offset: 0x7a9)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_bgb_flavor_hex;

// Namespace zm_bgb_flavor_hex
// Params 0, eflags: 0x5
// Checksum 0x5c8da970, Offset: 0xae
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "flavor_hex", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_flavor_hex
// Params 0
// Checksum 0x9fe1476b, Offset: 0xd3
// Size: 0x3f
function __init__()
{
    bgb::register( "flavor_hex", "activated", 1, undefined, undefined, &validation, &activation );
    utility::registersharedfunc( #"bgb", #"hash_45ed0fa0c5ff853d", &function_fc00ecaa26c7c25c );
}

// Namespace zm_bgb_flavor_hex
// Params 0
// Checksum 0xd2dac2dd, Offset: 0x11a
// Size: 0x9
function activation()
{
    thread function_7e891573d0642e7a();
}

// Namespace zm_bgb_flavor_hex
// Params 0
// Checksum 0x668512cb, Offset: 0x12b
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

// Namespace zm_bgb_flavor_hex
// Params 0
// Checksum 0x66a00cb8, Offset: 0x138
// Size: 0x29f
function function_7e891573d0642e7a()
{
    self endon( #"disconnect" );
    var_ad0adb31b9b40489 = [];
    var_e97a4f4962bc3f25 = bgb::get_bgb_slot( "flavor_hex" );
    
    foreach ( key, bgb in level.gobblegums )
    {
        if ( level.players.size < 2 && key == #"near_death_experience" )
        {
            continue;
        }
        
        if ( bgb.rarity === "Ultra" && key )
        {
            var_ad0adb31b9b40489[ var_ad0adb31b9b40489.size ] = key;
        }
    }
    
    foreach ( bgb in self.var_b02f6e7abbbc8a84 )
    {
        if ( arraycontains( var_ad0adb31b9b40489, bgb ) )
        {
            var_ad0adb31b9b40489 = arrayremove( var_ad0adb31b9b40489, bgb );
        }
    }
    
    foreach ( bgb in level.var_7dcdb497cf0b70a7 )
    {
        if ( arraycontains( var_ad0adb31b9b40489, bgb ) )
        {
            var_ad0adb31b9b40489 = arrayremove( var_ad0adb31b9b40489, bgb );
        }
    }
    
    var_ec8f22d0f9fe1f80 = utility::array_random( var_ad0adb31b9b40489 );
    
    if ( isxhash( var_ec8f22d0f9fe1f80 ) )
    {
        keys = getarraykeys( level.bgb );
        
        foreach ( key in keys )
        {
            if ( getxhash( key ) === var_ec8f22d0f9fe1f80 )
            {
                var_ec8f22d0f9fe1f80 = key;
            }
        }
    }
    
    self waittill( "bgb_update_take_" + "flavor_hex" );
    self.var_4317de3baf10e68d[ 0 ] = var_ec8f22d0f9fe1f80;
    bgb::set_action_slot( var_e97a4f4962bc3f25, var_ec8f22d0f9fe1f80, 1, 0 );
}

// Namespace zm_bgb_flavor_hex
// Params 1
// Checksum 0x6928125e, Offset: 0x3df
// Size: 0x2a
function function_fc00ecaa26c7c25c( var_b4fc895a9ffa7b8f )
{
    assert( isarray( var_b4fc895a9ffa7b8f ), "<dev string:x24>" );
    level.var_7dcdb497cf0b70a7 = var_b4fc895a9ffa7b8f;
}

