// script_6c9e04236b2b0469  (hash_6c9e04236b2b0469.gscc) (size: 758 Bytes / 0x2f6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbfba697d (3216664957)
// size ...... 758 (0x2f6)
// includes .. 4   (offset: 0x2c6)
// strings ... 1   (offset: 0x2e6)
// dev strs .. 0   (offset: 0x2f6)
// exports ... 5   (offset: 0x132)
// cseg ...... 0x78 + 0xba (0x132)
// imports ... 7   (offset: 0x1fa)
// animtree1 . 0   (offset: 0x2f6)
// animtree2 . 0   (offset: 0x2f6)
#using scripts\common\callbacks;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\player;

#namespace specialty_gas_grenade_resist;

// Namespace specialty_gas_grenade_resist
// Params 0, eflags: 0x1
// Checksum 0xc18fe2e, Offset: 0x96
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_gas_grenade_resist
// Params 1
// Checksum 0x43626912, Offset: 0xb6
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_gas_grenade_resist", &function_7677e5d8f7c742ce, &function_4e32d86ebfb2dd4f, [] );
    }
}

// Namespace specialty_gas_grenade_resist
// Params 0
// Checksum 0xccd4f758, Offset: 0xf8
// Size: 0x1f
function function_7677e5d8f7c742ce()
{
    perks::function_70e4256c5fb41ada( "specialty_gas_grenade_resist" );
    
    if ( player::isreallyalive() )
    {
        return;
    }
    
    gas_grenade::gas_updateplayereffects();
}

// Namespace specialty_gas_grenade_resist
// Params 0
// Checksum 0x8a42c6a9, Offset: 0x11f
// Size: 0x13
function function_4e32d86ebfb2dd4f()
{
    if ( player::isreallyalive() )
    {
        return;
    }
    
    gas_grenade::gas_updateplayereffects();
}

