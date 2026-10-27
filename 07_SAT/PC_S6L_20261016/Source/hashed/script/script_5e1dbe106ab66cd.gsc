// script_5e1dbe106ab66cd  (hash_05e1dbe106ab66cd.gscc) (size: 790 Bytes / 0x316 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4267be18 (1114095128)
// size ...... 790 (0x316)
// includes .. 1   (offset: 0x302)
// strings ... 1   (offset: 0x30a)
// dev strs .. 0   (offset: 0x316)
// exports ... 6   (offset: 0x14a)
// cseg ...... 0x74 + 0xd6 (0x14a)
// imports ... 7   (offset: 0x23a)
// animtree1 . 0   (offset: 0x316)
// animtree2 . 0   (offset: 0x316)
#using scripts\common\callbacks;

#namespace specialty_no_killstreaks;

// Namespace specialty_no_killstreaks
// Params 0, eflags: 0x5
// Checksum 0x9d9cacc4, Offset: 0x92
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_6e11cc74221486f3 );
}

// Namespace specialty_no_killstreaks
// Params 1
// Checksum 0xeec7ac52, Offset: 0xb2
// Size: 0x39
function function_6e11cc74221486f3( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_no_killstreaks", &function_a6d8527e3c42e59c, &function_b55dfa7fc1655247 );
    }
}

// Namespace specialty_no_killstreaks
// Params 0, eflags: 0x4
// Checksum 0xc859d6a, Offset: 0xf3
// Size: 0x17
function private function_a6d8527e3c42e59c()
{
    callback::add( #"hash_62785a5e7e758499", &function_5d2f362cccc3afbf );
}

// Namespace specialty_no_killstreaks
// Params 0, eflags: 0x4
// Checksum 0xdec2d92, Offset: 0x112
// Size: 0x17
function private function_b55dfa7fc1655247()
{
    callback::remove( #"hash_62785a5e7e758499", &function_5d2f362cccc3afbf );
}

// Namespace specialty_no_killstreaks
// Params 1
// Checksum 0x63dc89eb, Offset: 0x131
// Size: 0x19
function function_5d2f362cccc3afbf( params )
{
    params.var_d9f054ec9d2d6bdd = 0;
}

