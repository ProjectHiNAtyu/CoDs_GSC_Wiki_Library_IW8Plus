// scripts\common\ai\aitypes\zombie_viper\zombie_viper_metabones.gsc  (hash_12290be6aff9c37b.gscc) (size: 1120 Bytes / 0x460 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a9afb8d (2593848205)
// size ...... 1120 (0x460)
// includes .. 4   (offset: 0x3e0)
// strings ... 7   (offset: 0x400)
// dev strs .. 0   (offset: 0x460)
// exports ... 4   (offset: 0x20c)
// cseg ...... 0xb8 + 0x154 (0x20c)
// imports ... 11  (offset: 0x2ac)
// animtree1 . 0   (offset: 0x460)
// animtree2 . 0   (offset: 0x460)
#using script_338ec3ea121b70eb;
#using scripts\common\ai\aitypes\zombie_viper\zombie_viper_shield;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_viper_metabones;

// Namespace zombie_viper_metabones
// Params 0, eflags: 0x1
// Checksum 0x90d3783b, Offset: 0xd6
// Size: 0x2f
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_viper";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
    metabone::function_7b57cab1f2311c7b( var_fb56e56d94279338, &on_metabone_damaged_not_destroyed );
}

// Namespace zombie_viper_metabones
// Params 1, eflags: 0x4
// Checksum 0x62ff604b, Offset: 0x10d
// Size: 0x9e
function private on_metabone_destroyed( params )
{
    if ( params.metabone_name == "tesla_coil_left" || params.metabone_name == "tesla_coil_right" )
    {
        zombie_viper_shield::function_db73948dc02ab553( params.metabone_name );
    }
    
    metabone::set_metabone_state( params.metabone_name, "destroyed" );
    utility::function_32b24db3127bff40( params.metabone_name, "destroyed" );
    zombie_viper_asm::cause_special_pain();
    
    if ( params.metabone_name == "helmet" )
    {
        metabone::set_metabone_active( "head_bot", 1 );
    }
}

// Namespace zombie_viper_metabones
// Params 1, eflags: 0x4
// Checksum 0x59bd7d69, Offset: 0x1b3
// Size: 0x59
function private on_metabone_damaged_not_destroyed( params )
{
    if ( ( params.metabone_name == "tesla_coil_left" || params.metabone_name == "tesla_coil_right" ) && metabone::get_metabone_state_name( params.metabone_name ) == "on" )
    {
        zombie_viper_shield::function_6628f4ddea2e4b67( params );
    }
}

