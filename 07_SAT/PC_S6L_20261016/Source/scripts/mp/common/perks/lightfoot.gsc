// scripts\mp\common\perks\lightfoot.gsc  (hash_7b3e3ab2a55760ce.gscc) (size: 455 Bytes / 0x1c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a93f4c2 (714339522)
// size ...... 455 (0x1c7)
// includes .. 1   (offset: 0x1af)
// strings ... 1   (offset: 0x1b7)
// dev strs .. 0   (offset: 0x1c7)
// exports ... 3   (offset: 0xff)
// cseg ...... 0x6f + 0x90 (0xff)
// imports ... 2   (offset: 0x177)
// animtree1 . 0   (offset: 0x1c7)
// animtree2 . 0   (offset: 0x1c7)
#using scripts\common\callbacks;

#namespace lightfoot;

// Namespace lightfoot
// Params 0, eflags: 0x1
// Checksum 0xe11f2470, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_cdd400da4e3e8cf1 );
}

// Namespace lightfoot
// Params 1
// Checksum 0x7a0ea170, Offset: 0xad
// Size: 0x52
function function_cdd400da4e3e8cf1( params )
{
    bundle = level.perkbundles[ "specialty_lightfoot" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_lightfoot" );
    }
}

