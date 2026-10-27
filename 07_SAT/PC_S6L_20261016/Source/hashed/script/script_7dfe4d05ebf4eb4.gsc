// script_7dfe4d05ebf4eb4  (hash_07dfe4d05ebf4eb4.gscc) (size: 849 Bytes / 0x351 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7b643e6 (3350610918)
// size ...... 849 (0x351)
// includes .. 3   (offset: 0x315)
// strings ... 3   (offset: 0x32d)
// dev strs .. 0   (offset: 0x351)
// exports ... 5   (offset: 0x189)
// cseg ...... 0xbf + 0xca (0x189)
// imports ... 7   (offset: 0x251)
// animtree1 . 0   (offset: 0x351)
// animtree2 . 0   (offset: 0x351)
#using script_4610d4deaba537e;
#using script_54a05cbb2455bc6f;
#using scripts\common\system;

#namespace ztron_fate_friendship;

// Namespace ztron_fate_friendship
// Params 0, eflags: 0x5
// Checksum 0xe2aecced, Offset: 0xdd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_fate_friendship", #"ztron_fate", undefined, &init );
}

// Namespace ztron_fate_friendship
// Params 0
// Checksum 0xbff244aa, Offset: 0x106
// Size: 0x2d
function init()
{
    ztron_fate::function_4b268a9ddf9d18b4( 3, #"friendship", &activate, &deactivate, "ztron_fate_rock_friendship", "sat_zm_ztron_props_fate_friendship", "dx_zm_ztr4_anno_anz4_d4fatefrnd" );
}

// Namespace ztron_fate_friendship
// Params 1
// Checksum 0x429535e2, Offset: 0x13b
// Size: 0x1e
function activate( loadgame )
{
    self.var_d21be8eb8db6c764 = namespace_3d206415c2287a2b::addchicken( 1, 0 );
}

// Namespace ztron_fate_friendship
// Params 0
// Checksum 0x1a13b378, Offset: 0x161
// Size: 0x28
function deactivate()
{
    if ( self.var_d21be8eb8db6c764 )
    {
        self.var_d21be8eb8db6c764 namespace_3d206415c2287a2b::chickenkill();
        self.var_d21be8eb8db6c764 = undefined;
    }
}

