// script_26c221dbf6b6d9f1  (hash_26c221dbf6b6d9f1.gscc) (size: 1037 Bytes / 0x40d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x356adb72 (896195442)
// size ...... 1037 (0x40d)
// includes .. 3   (offset: 0x3d1)
// strings ... 3   (offset: 0x3e9)
// dev strs .. 0   (offset: 0x40d)
// exports ... 4   (offset: 0x1f9)
// cseg ...... 0x88 + 0x171 (0x1f9)
// imports ... 11  (offset: 0x299)
// animtree1 . 0   (offset: 0x40d)
// animtree2 . 0   (offset: 0x40d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\system;

#namespace namespace_8af9e49601260c0f;

// Namespace namespace_8af9e49601260c0f
// Params 0, eflags: 0x5
// Checksum 0x8469e0f3, Offset: 0xa6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_d9d452697611cb28", undefined, undefined, &post_main );
}

// Namespace namespace_8af9e49601260c0f
// Params 0, eflags: 0x4
// Checksum 0x71745868, Offset: 0xc7
// Size: 0xf
function private post_main()
{
    level zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
}

// Namespace namespace_8af9e49601260c0f
// Params 1, eflags: 0x4
// Checksum 0x19431b71, Offset: 0xde
// Size: 0x11a
function private function_17fdfda41f9aa95a( dmg_struct )
{
    if ( dmg_struct.sweapon.basename != "sat_sm_serval_mp" )
    {
        return dmg_struct.idamage;
    }
    
    if ( dmg_struct.smeansofdeath != "MOD_MELEE" )
    {
        return dmg_struct.idamage;
    }
    
    if ( !dmg_struct.objweapon hasattachmenthash( %"hash_6867e986d0f605d2" ) )
    {
        return dmg_struct.idamage;
    }
    
    idamage = dmg_struct.idamage;
    current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    boss_round = isalive( self ) ? zombie_utils::get_zombie_round_difficulty() : undefined;
    
    if ( isdefined( boss_round ) )
    {
        var_4feed796664d10af = int( max( current_round, boss_round ) );
    }
    else
    {
        var_4feed796664d10af = current_round;
    }
    
    base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", var_4feed796664d10af );
    
    if ( isdefined( base_zombie_max_health ) )
    {
        idamage = max( base_zombie_max_health * 1, idamage );
    }
    
    return idamage;
}

