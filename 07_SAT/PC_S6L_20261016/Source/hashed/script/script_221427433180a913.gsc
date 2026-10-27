// script_221427433180a913  (hash_221427433180a913.gscc) (size: 639 Bytes / 0x27f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50ecc02e (1357692974)
// size ...... 639 (0x27f)
// includes .. 1   (offset: 0x22f)
// strings ... 3   (offset: 0x237)
// dev strs .. 3   (offset: 0x25b)
// exports ... 2   (offset: 0x187)
// cseg ...... 0x8e + 0xf9 (0x187)
// imports ... 3   (offset: 0x1d7)
// animtree1 . 0   (offset: 0x27f)
// animtree2 . 0   (offset: 0x27f)
#using scripts\asm\asm;

#namespace namespace_b41e632cbe1b5a96;

// Namespace namespace_b41e632cbe1b5a96
// Params 3
// Checksum 0xd27ea7f6, Offset: 0xac
// Size: 0xda
function function_68aa07e5adc990f1( asmname, statename, params )
{
    switch ( self.var_d07937101f7ccc9f )
    {
        case 2:
            alias = "two_tornadoes";
            break;
        case 3:
            alias = "three_tornadoes";
            break;
        case 4:
            alias = "four_tornadoes";
            break;
        default:
            assert( 0, "<dev string:x24>" + self.var_d07937101f7ccc9f );
            break;
    }
    
    assert( asm::asm_hasalias( statename, alias ), "<dev string:x50>" + statename + "<dev string:x5b>" + alias );
    tornadoanim = asm::asm_chooseanim( asmname, statename, alias );
    return tornadoanim;
}

