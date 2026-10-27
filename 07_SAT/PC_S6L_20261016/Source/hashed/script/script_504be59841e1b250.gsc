// script_504be59841e1b250  (hash_504be59841e1b250.gscc) (size: 624 Bytes / 0x270 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa86d894 (2860963988)
// size ...... 624 (0x270)
// includes .. 1   (offset: 0x25c)
// strings ... 1   (offset: 0x264)
// dev strs .. 0   (offset: 0x270)
// exports ... 5   (offset: 0x124)
// cseg ...... 0x83 + 0xa1 (0x124)
// imports ... 4   (offset: 0x1ec)
// animtree1 . 0   (offset: 0x270)
// animtree2 . 0   (offset: 0x270)
#using scripts\common\callbacks;

#namespace specialty_explosive_regen_halt_immunity;

// Namespace specialty_explosive_regen_halt_immunity
// Params 0, eflags: 0x1
// Checksum 0x83899bc7, Offset: 0xa1
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_explosive_regen_halt_immunity
// Params 1
// Checksum 0x19663563, Offset: 0xc1
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_explosive_regen_halt_immunity", &function_4099243f539876bf, &function_6059f2dd5382da06, [] );
    }
}

// Namespace specialty_explosive_regen_halt_immunity
// Params 0
// Checksum 0xdac2e58f, Offset: 0x103
// Size: 0xd
function function_4099243f539876bf()
{
    self.explosiveregenhaltimmunity = 1;
}

// Namespace specialty_explosive_regen_halt_immunity
// Params 0
// Checksum 0x2320b442, Offset: 0x118
// Size: 0xc
function function_6059f2dd5382da06()
{
    self.explosiveregenhaltimmunity = 0;
}

