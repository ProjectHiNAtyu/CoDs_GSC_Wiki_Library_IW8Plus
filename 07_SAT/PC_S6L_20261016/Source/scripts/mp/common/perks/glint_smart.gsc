// scripts\mp\common\perks\glint_smart.gsc  (hash_2014a3229f6ed9f8.gscc) (size: 584 Bytes / 0x248 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ff61973 (536222067)
// size ...... 584 (0x248)
// includes .. 1   (offset: 0x234)
// strings ... 1   (offset: 0x23c)
// dev strs .. 0   (offset: 0x248)
// exports ... 5   (offset: 0xfc)
// cseg ...... 0x71 + 0x8b (0xfc)
// imports ... 4   (offset: 0x1c4)
// animtree1 . 0   (offset: 0x248)
// animtree2 . 0   (offset: 0x248)
#using scripts\common\callbacks;

#namespace glint_smart;

// Namespace glint_smart
// Params 0, eflags: 0x1
// Checksum 0x5b4d3bbd, Offset: 0x8f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_cb394207d02fee2a );
}

// Namespace glint_smart
// Params 1
// Checksum 0x130991b4, Offset: 0xaf
// Size: 0x39
function function_cb394207d02fee2a( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_glint_smart", &function_ef3bae4b2eb34153, &function_29403771e2524fda );
    }
}

// Namespace glint_smart
// Params 0, eflags: 0x4
// Checksum 0x5aa7780c, Offset: 0xf0
// Size: 0x2
function private function_ef3bae4b2eb34153()
{
    
}

// Namespace glint_smart
// Params 0, eflags: 0x4
// Checksum 0xf09d83e7, Offset: 0xfa
// Size: 0x2
function private function_29403771e2524fda()
{
    
}

