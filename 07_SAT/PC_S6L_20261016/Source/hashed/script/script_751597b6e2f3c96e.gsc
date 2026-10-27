// script_751597b6e2f3c96e  (hash_751597b6e2f3c96e.gscc) (size: 1138 Bytes / 0x472 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x435ddc1f (1130224671)
// size ...... 1138 (0x472)
// includes .. 3   (offset: 0x432)
// strings ... 3   (offset: 0x44a)
// dev strs .. 0   (offset: 0x472)
// exports ... 6   (offset: 0x1f2)
// cseg ...... 0x8f + 0x163 (0x1f2)
// imports ... 12  (offset: 0x2e2)
// animtree1 . 0   (offset: 0x472)
// animtree2 . 0   (offset: 0x472)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\armor;

#namespace zm_bgb_armor_gettin;

// Namespace zm_bgb_armor_gettin
// Params 0, eflags: 0x5
// Checksum 0x169de256, Offset: 0xad
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "armor_gettin", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_armor_gettin
// Params 0
// Checksum 0x2410812e, Offset: 0xd2
// Size: 0x21
function __init__()
{
    bgb::register( "armor_gettin", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace zm_bgb_armor_gettin
// Params 0
// Checksum 0x9060968f, Offset: 0xfb
// Size: 0x16
function activation()
{
    function_fdbe2cad6d8bb7e7();
    armor::function_164c824617d7e8d7( armor::function_db9ebf086f67fe92() );
}

// Namespace zm_bgb_armor_gettin
// Params 0
// Checksum 0x47b59e9e, Offset: 0x119
// Size: 0x5c, Type: bool
function validation()
{
    if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        return false;
    }
    
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 669;
    
    if ( self.armorhealth >= var_3dc0c4e27d22d986 && armor::function_917d57b2f6b9d879() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_bgb_armor_gettin
// Params 1
// Checksum 0xc27d4c5, Offset: 0x17e
// Size: 0x74
function function_fdbe2cad6d8bb7e7( platecarrierlevel )
{
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 669;
    self.platecarrierlevel = 3;
    self.maxarmorhealth = var_3dc0c4e27d22d986;
    armor::setarmorhealth( var_3dc0c4e27d22d986 );
    self setclientomnvar( "ui_armor_current_level", self.platecarrierlevel );
    self playsoundtoplayer( #"hash_5d23ab82236e9d91", self );
}

