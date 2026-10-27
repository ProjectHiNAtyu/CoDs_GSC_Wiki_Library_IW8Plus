// script_382adc28cdadbba9  (hash_382adc28cdadbba9.gscc) (size: 433 Bytes / 0x1b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9883f385 (2558784389)
// size ...... 433 (0x1b1)
// includes .. 1   (offset: 0x19d)
// strings ... 1   (offset: 0x1a5)
// dev strs .. 0   (offset: 0x1b1)
// exports ... 3   (offset: 0xed)
// cseg ...... 0x7d + 0x70 (0xed)
// imports ... 2   (offset: 0x165)
// animtree1 . 0   (offset: 0x1b1)
// animtree2 . 0   (offset: 0x1b1)
#using scripts\common\callbacks;

#namespace specialty_improved_field_upgrades;

// Namespace specialty_improved_field_upgrades
// Params 0, eflags: 0x1
// Checksum 0x79bd954e, Offset: 0x9b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_improved_field_upgrades
// Params 1
// Checksum 0x387347bb, Offset: 0xbb
// Size: 0x32
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_improved_field_upgrades", undefined, undefined, [] );
    }
}

