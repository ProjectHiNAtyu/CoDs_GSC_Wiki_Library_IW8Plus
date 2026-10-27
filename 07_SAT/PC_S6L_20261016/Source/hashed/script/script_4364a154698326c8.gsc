// script_4364a154698326c8  (hash_4364a154698326c8.gscc) (size: 898 Bytes / 0x382 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c89a533 (1820960051)
// size ...... 898 (0x382)
// includes .. 2   (offset: 0x35a)
// strings ... 2   (offset: 0x36a)
// dev strs .. 0   (offset: 0x382)
// exports ... 6   (offset: 0x182)
// cseg ...... 0x82 + 0x100 (0x182)
// imports ... 8   (offset: 0x272)
// animtree1 . 0   (offset: 0x382)
// animtree2 . 0   (offset: 0x382)
#using scripts\common\callbacks;
#using scripts\mp\weapons;

#namespace specialty_reload_on_melee;

// Namespace specialty_reload_on_melee
// Params 0, eflags: 0x1
// Checksum 0xaa9d0e06, Offset: 0xa0
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_reload_on_melee
// Params 1
// Checksum 0x5d632f6d, Offset: 0xc0
// Size: 0x39
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reload_on_melee", &function_f2ea879dd5c2e9e, &function_ae2b9db844ee1b89 );
    }
}

// Namespace specialty_reload_on_melee
// Params 0
// Checksum 0xabe8bc9c, Offset: 0x101
// Size: 0x18
function function_f2ea879dd5c2e9e()
{
    level callback::add( #"on_ai_damaged", &function_8500b60c0046ecf2 );
}

// Namespace specialty_reload_on_melee
// Params 0
// Checksum 0xaa810c64, Offset: 0x121
// Size: 0x18
function function_ae2b9db844ee1b89()
{
    level callback::remove( #"on_ai_damaged", &function_8500b60c0046ecf2 );
}

// Namespace specialty_reload_on_melee
// Params 1
// Checksum 0xb8c8291b, Offset: 0x141
// Size: 0x41
function function_8500b60c0046ecf2( params )
{
    if ( params.smeansofdeath == "MOD_MELEE" )
    {
        params.eattacker weapons::function_937faff615744271( params.eattacker getcurrentweapon() );
    }
}

