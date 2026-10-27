// script_2735c38ed9db8b1f  (hash_2735c38ed9db8b1f.gscc) (size: 507 Bytes / 0x1fb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe454b19e (3830755742)
// size ...... 507 (0x1fb)
// includes .. 1   (offset: 0x1d7)
// strings ... 2   (offset: 0x1df)
// dev strs .. 0   (offset: 0x1fb)
// exports ... 3   (offset: 0x127)
// cseg ...... 0x8b + 0x9c (0x127)
// imports ... 2   (offset: 0x19f)
// animtree1 . 0   (offset: 0x1fb)
// animtree2 . 0   (offset: 0x1fb)
#using scripts\common\callbacks;

#namespace specialty_munitions_two;

// Namespace specialty_munitions_two
// Params 0, eflags: 0x1
// Checksum 0x7b9ac0c5, Offset: 0xa9
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_d9ea7d008ac32376 );
}

// Namespace specialty_munitions_two
// Params 1
// Checksum 0x7e01d457, Offset: 0xc9
// Size: 0x5e
function function_d9ea7d008ac32376( params )
{
    bundle = level.perkbundles[ "specialty_munitions_2" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_munitions_2", undefined, undefined, [ "specialty_twoprimaries" ] );
    }
}

