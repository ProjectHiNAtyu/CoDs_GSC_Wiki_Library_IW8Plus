// script_4c975b4a3db50a06  (hash_4c975b4a3db50a06.gscc) (size: 634 Bytes / 0x27a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc822018 (209854488)
// size ...... 634 (0x27a)
// includes .. 1   (offset: 0x266)
// strings ... 1   (offset: 0x26e)
// dev strs .. 0   (offset: 0x27a)
// exports ... 5   (offset: 0x12e)
// cseg ...... 0x74 + 0xba (0x12e)
// imports ... 4   (offset: 0x1f6)
// animtree1 . 0   (offset: 0x27a)
// animtree2 . 0   (offset: 0x27a)
#using scripts\common\callbacks;

#namespace specialty_gas_damage_mod;

// Namespace specialty_gas_damage_mod
// Params 0, eflags: 0x1
// Checksum 0x15729e88, Offset: 0x92
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_gas_damage_mod
// Params 1
// Checksum 0xe19aca69, Offset: 0xb2
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_gas_damage_mod", &function_269a0e60e8e4acc2, &function_bb5a1e97765e5f0f, [] );
    }
}

// Namespace specialty_gas_damage_mod
// Params 0
// Checksum 0x3a21c3b3, Offset: 0xf4
// Size: 0x26
function function_269a0e60e8e4acc2()
{
    self.var_a5ac861674d151de = self.var_9842326056fd7207.var_53856aa3bce16192 ?? -0.1;
}

// Namespace specialty_gas_damage_mod
// Params 0
// Checksum 0x34a391e6, Offset: 0x122
// Size: 0xc
function function_bb5a1e97765e5f0f()
{
    self.var_a5ac861674d151de = undefined;
}

