// script_59596b076f9a2e5e  (hash_59596b076f9a2e5e.gscc) (size: 807 Bytes / 0x327 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1fcb8759 (533432153)
// size ...... 807 (0x327)
// includes .. 2   (offset: 0x303)
// strings ... 1   (offset: 0x313)
// dev strs .. 0   (offset: 0x327)
// exports ... 6   (offset: 0x167)
// cseg ...... 0x75 + 0xf2 (0x167)
// imports ... 6   (offset: 0x257)
// animtree1 . 0   (offset: 0x327)
// animtree2 . 0   (offset: 0x327)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;

#namespace specialty_armor_salvaging;

// Namespace specialty_armor_salvaging
// Params 0, eflags: 0x1
// Checksum 0xb352617d, Offset: 0x93
// Size: 0x2e
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    level callback::add( #"player_death", &onplayerdeath );
}

// Namespace specialty_armor_salvaging
// Params 1
// Checksum 0xec5a7830, Offset: 0xc9
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_armor_salvaging", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_armor_salvaging
// Params 0
// Checksum 0xe5aeece5, Offset: 0x10b
// Size: 0x2
function setspecialty()
{
    
}

// Namespace specialty_armor_salvaging
// Params 0
// Checksum 0xd519588b, Offset: 0x115
// Size: 0x2
function unsetspecialty()
{
    
}

// Namespace specialty_armor_salvaging
// Params 1
// Checksum 0x6e6ddf14, Offset: 0x11f
// Size: 0x48
function onplayerdeath( params )
{
    player = params.attacker;
    
    if ( !isdefined( player.perks[ "specialty_armor_salvaging" ] ) )
    {
        return;
    }
    
    player namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_armor_salvaging" );
}

