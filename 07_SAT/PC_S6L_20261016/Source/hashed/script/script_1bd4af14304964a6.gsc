// script_1bd4af14304964a6  (hash_1bd4af14304964a6.gscc) (size: 473 Bytes / 0x1d9)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e89b960 (2391390560)
// size ...... 473 (0x1d9)
// includes .. 0   (offset: 0x1cd)
// strings ... 1   (offset: 0x1cd)
// dev strs .. 0   (offset: 0x1d9)
// exports ... 3   (offset: 0x119)
// cseg ...... 0x78 + 0xa1 (0x119)
// imports ... 2   (offset: 0x191)
// animtree1 . 0   (offset: 0x1d9)
// animtree2 . 0   (offset: 0x1d9)
#namespace namespace_2bbb671b69e96192;

// Namespace namespace_2bbb671b69e96192
// Params 0, eflags: 0x1
// Checksum 0xe869e77b, Offset: 0x96
// Size: 0x2d
function autoexec init()
{
    if ( !isdefined( level.var_79987b283d0c90da ) )
    {
        level.var_79987b283d0c90da = [];
    }
    
    level.var_79987b283d0c90da[ "t10_sn_p08_ultiger_rec_vault" ] = &weapon_inspect;
}

// Namespace namespace_2bbb671b69e96192
// Params 1, eflags: 0x4
// Checksum 0x66430b69, Offset: 0xcb
// Size: 0x4e
function private weapon_inspect( weapon )
{
    self endon( #"death_or_disconnect" );
    self setscriptablepartstate( #"hash_136280dc04cdcc01", #"error" );
    wait 2.2;
    self setscriptablepartstate( #"hash_136280dc04cdcc01", #"normal" );
}

