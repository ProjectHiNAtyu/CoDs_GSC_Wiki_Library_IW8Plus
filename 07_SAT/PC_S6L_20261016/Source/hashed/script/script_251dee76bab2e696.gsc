// script_251dee76bab2e696  (hash_251dee76bab2e696.gscc) (size: 811 Bytes / 0x32b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb70fe76 (4218486390)
// size ...... 811 (0x32b)
// includes .. 2   (offset: 0x2f7)
// strings ... 3   (offset: 0x307)
// dev strs .. 0   (offset: 0x32b)
// exports ... 5   (offset: 0x1a3)
// cseg ...... 0xb5 + 0xee (0x1a3)
// imports ... 5   (offset: 0x26b)
// animtree1 . 0   (offset: 0x32b)
// animtree2 . 0   (offset: 0x32b)
#using script_54a05cbb2455bc6f;
#using scripts\common\system;

#namespace ztron_fate_medic;

// Namespace ztron_fate_medic
// Params 0, eflags: 0x5
// Checksum 0xa0327afa, Offset: 0xd3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_fate_medic", #"ztron_fate", undefined, &init );
}

// Namespace ztron_fate_medic
// Params 0
// Checksum 0x44ced493, Offset: 0xfc
// Size: 0x2e
function init()
{
    ztron_fate::function_4b268a9ddf9d18b4( 6, #"medic", &activate, &deactivate, "ztron_fate_rock_medic", "sat_zm_ztron_props_fate_medic", "dx_zm_ztr4_anno_anz4_d4fatedvch", 0 );
}

// Namespace ztron_fate_medic
// Params 1
// Checksum 0x5a92b68e, Offset: 0x132
// Size: 0x3b
function activate( loadgame )
{
    self.ztron.healthRegenScale = 2.5;
    self.ztron.var_eeeeba1fb45eb3ce = 5;
}

// Namespace ztron_fate_medic
// Params 0
// Checksum 0xc03d7b4d, Offset: 0x175
// Size: 0x2e
function deactivate()
{
    self.ztron.healthRegenScale = 1;
    self.ztron.var_eeeeba1fb45eb3ce = 1;
}

