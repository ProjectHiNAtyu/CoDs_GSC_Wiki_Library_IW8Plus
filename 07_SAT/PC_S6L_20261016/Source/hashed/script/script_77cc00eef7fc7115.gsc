// script_77cc00eef7fc7115  (hash_77cc00eef7fc7115.gscc) (size: 705 Bytes / 0x2c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31577365 (827814757)
// size ...... 705 (0x2c1)
// includes .. 1   (offset: 0x2ad)
// strings ... 1   (offset: 0x2b5)
// dev strs .. 0   (offset: 0x2c1)
// exports ... 5   (offset: 0x159)
// cseg ...... 0x7b + 0xde (0x159)
// imports ... 5   (offset: 0x221)
// animtree1 . 0   (offset: 0x2c1)
// animtree2 . 0   (offset: 0x2c1)
#using scripts\common\callbacks;

#namespace specialty_explosive_regen_delay;

// Namespace specialty_explosive_regen_delay
// Params 0, eflags: 0x1
// Checksum 0x76e1cdc8, Offset: 0x99
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_explosive_regen_delay
// Params 1
// Checksum 0x99d9c083, Offset: 0xb9
// Size: 0x3a
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_explosive_regen_delay", &function_1c25b53ceb39d98d, &function_377915185d430a1e, [] );
    }
}

// Namespace specialty_explosive_regen_delay
// Params 0
// Checksum 0xc3eace75, Offset: 0xfb
// Size: 0x40
function function_1c25b53ceb39d98d()
{
    bundle = self.var_9842326056fd7207;
    self.var_b06fceab0526c3b1 = bundle.var_5b59012c3fc0e141 ?? getdvarfloat( @"hash_dcefbf9575257226", 5 );
}

// Namespace specialty_explosive_regen_delay
// Params 0
// Checksum 0xcbe40d87, Offset: 0x143
// Size: 0x16
function function_377915185d430a1e()
{
    self.var_b06fceab0526c3b1 = undefined;
    self.var_937517417ea57909 = undefined;
}

