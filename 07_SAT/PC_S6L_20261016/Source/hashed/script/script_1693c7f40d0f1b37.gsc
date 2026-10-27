// script_1693c7f40d0f1b37  (hash_1693c7f40d0f1b37.gscc) (size: 691 Bytes / 0x2b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf293085d (4069722205)
// size ...... 691 (0x2b3)
// includes .. 1   (offset: 0x293)
// strings ... 2   (offset: 0x29b)
// dev strs .. 0   (offset: 0x2b3)
// exports ... 5   (offset: 0x15b)
// cseg ...... 0x7f + 0xdc (0x15b)
// imports ... 4   (offset: 0x223)
// animtree1 . 0   (offset: 0x2b3)
// animtree2 . 0   (offset: 0x2b3)
#using scripts\common\callbacks;

#namespace specialty_hack;

// Namespace specialty_hack
// Params 0, eflags: 0x1
// Checksum 0x7f4afb0, Offset: 0x9d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_hack
// Params 1
// Checksum 0x544ee4b6, Offset: 0xbd
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_hack", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_hack
// Params 0
// Checksum 0x4ff0ef8f, Offset: 0xff
// Size: 0x48
function setspecialty()
{
    self.hackdistance = self.var_9842326056fd7207.var_7d48ea6010f6b055 ?? 300;
    self.hackingdevice = self.var_9842326056fd7207.hackhackingdevice ?? "ks_remote_hack_mp";
}

// Namespace specialty_hack
// Params 0
// Checksum 0x8ef76917, Offset: 0x14f
// Size: 0xc
function unsetspecialty()
{
    self.hackdistance = undefined;
}

