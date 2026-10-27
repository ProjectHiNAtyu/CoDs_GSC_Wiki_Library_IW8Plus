// scripts\mp\wildcards\wildcard_flyswatter.gsc  (hash_7b5c8025ed56677e.gscc) (size: 517 Bytes / 0x205 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50a3a333 (1352901427)
// size ...... 517 (0x205)
// includes .. 1   (offset: 0x1e1)
// strings ... 2   (offset: 0x1e9)
// dev strs .. 0   (offset: 0x205)
// exports ... 3   (offset: 0x131)
// cseg ...... 0x95 + 0x9c (0x131)
// imports ... 2   (offset: 0x1a9)
// animtree1 . 0   (offset: 0x205)
// animtree2 . 0   (offset: 0x205)
#using scripts\common\callbacks;

#namespace wildcard_flyswatter;

// Namespace wildcard_flyswatter
// Params 0, eflags: 0x5
// Checksum 0xed01d3b3, Offset: 0xb3
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_f60601811546e928 );
}

// Namespace wildcard_flyswatter
// Params 1
// Checksum 0x99180a2c, Offset: 0xd3
// Size: 0x5e
function function_f60601811546e928( params )
{
    bundle = level.wildcardbundles[ "wildcard_flyswatter" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "wildcard_flyswatter", undefined, undefined, [ "specialty_tertiary_allow_launchers" ] );
    }
}

