// script_c1dff4493e5a65f  (hash_0c1dff4493e5a65f.gscc) (size: 929 Bytes / 0x3a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x374678c5 (927365317)
// size ...... 929 (0x3a1)
// includes .. 1   (offset: 0x36d)
// strings ... 3   (offset: 0x375)
// dev strs .. 0   (offset: 0x3a1)
// exports ... 5   (offset: 0x20d)
// cseg ...... 0xcd + 0x140 (0x20d)
// imports ... 5   (offset: 0x2d5)
// animtree1 . 0   (offset: 0x3a1)
// animtree2 . 0   (offset: 0x3a1)
#using scripts\common\callbacks;

#namespace specialty_expanded_minimap;

// Namespace specialty_expanded_minimap
// Params 0, eflags: 0x1
// Checksum 0x9fd4715, Offset: 0xeb
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_expanded_minimap
// Params 1
// Checksum 0x2ffdc6f8, Offset: 0x10b
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_expanded_minimap", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_expanded_minimap
// Params 0
// Checksum 0x419dd432, Offset: 0x14d
// Size: 0x72
function setspecialty()
{
    self.var_96fbcffb1397c172 = self.var_9842326056fd7207.var_96fbcffb1397c172 ?? 1;
    self.var_aaad5cd4d2512022 = self.var_9842326056fd7207.var_aaad5cd4d2512022 ?? 1;
    self setclientomnvar( "ui_specialty_expanded_minimap_map_scale", self.var_96fbcffb1397c172 );
    self setclientomnvar( "ui_specialty_expanded_minimap_icon_scale", self.var_aaad5cd4d2512022 );
}

// Namespace specialty_expanded_minimap
// Params 0
// Checksum 0x8a9ee54e, Offset: 0x1c7
// Size: 0x46
function unsetspecialty()
{
    self.var_96fbcffb1397c172 = 1;
    self.var_aaad5cd4d2512022 = 1;
    self setclientomnvar( "ui_specialty_expanded_minimap_map_scale", self.var_96fbcffb1397c172 );
    self setclientomnvar( "ui_specialty_expanded_minimap_icon_scale", self.var_aaad5cd4d2512022 );
}

