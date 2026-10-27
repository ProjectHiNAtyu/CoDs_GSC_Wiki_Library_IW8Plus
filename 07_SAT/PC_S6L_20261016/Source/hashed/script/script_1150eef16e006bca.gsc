// script_1150eef16e006bca  (hash_1150eef16e006bca.gscc) (size: 492 Bytes / 0x1ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd3278a7 (3442636967)
// size ...... 492 (0x1ec)
// includes .. 2   (offset: 0x1dc)
// strings ... 0   (offset: 0x1ec)
// dev strs .. 0   (offset: 0x1ec)
// exports ... 3   (offset: 0xf4)
// cseg ...... 0x58 + 0x9c (0xf4)
// imports ... 4   (offset: 0x16c)
// animtree1 . 0   (offset: 0x1ec)
// animtree2 . 0   (offset: 0x1ec)
#using scripts\common\callbacks;
#using scripts\mp\damage_range_indicator;

#namespace namespace_b0ad4e0810767396;

// Namespace namespace_b0ad4e0810767396
// Params 0, eflags: 0x1
// Checksum 0xcc8e9866, Offset: 0x76
// Size: 0x18
function autoexec main()
{
    level callback::add( #"player_weapon_change", &function_ad0387179f45f874 );
}

// Namespace namespace_b0ad4e0810767396
// Params 1, eflags: 0x4
// Checksum 0x59c21154, Offset: 0x96
// Size: 0x5e
function private function_ad0387179f45f874( params )
{
    if ( params.weapon hasattachmenthash( %"hash_683c9162818743d8" ) )
    {
        thread damage_range_indicator::function_f0076932d98e2191();
        self.var_ad0387179f45f874 = 1;
        return;
    }
    
    if ( self.var_ad0387179f45f874 )
    {
        self notify( #"hash_b5fcbc77ee7be0ee" );
        self.var_ad0387179f45f874 = undefined;
    }
}

