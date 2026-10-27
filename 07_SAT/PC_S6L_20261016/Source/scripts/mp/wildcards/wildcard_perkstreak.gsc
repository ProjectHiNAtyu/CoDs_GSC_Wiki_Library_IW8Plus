// scripts\mp\wildcards\wildcard_perkstreak.gsc  (hash_52010e2fbc341a39.gscc) (size: 554 Bytes / 0x22a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b3e47e4 (457066468)
// size ...... 554 (0x22a)
// includes .. 1   (offset: 0x1fa)
// strings ... 3   (offset: 0x202)
// dev strs .. 0   (offset: 0x22a)
// exports ... 3   (offset: 0x14a)
// cseg ...... 0xa4 + 0xa6 (0x14a)
// imports ... 2   (offset: 0x1c2)
// animtree1 . 0   (offset: 0x22a)
// animtree2 . 0   (offset: 0x22a)
#using scripts\common\callbacks;

#namespace wildcard_perkstreak;

// Namespace wildcard_perkstreak
// Params 0, eflags: 0x5
// Checksum 0xb8cce514, Offset: 0xc2
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_9bd727d93a1d40af );
}

// Namespace wildcard_perkstreak
// Params 1
// Checksum 0x65c4c991, Offset: 0xe2
// Size: 0x68
function function_9bd727d93a1d40af( params )
{
    bundle = level.wildcardbundles[ "wildcard_perkstreak" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "wildcard_perkstreak", undefined, undefined, [ "specialty_perkstreaks", "specialty_no_killstreaks" ], undefined );
    }
}

