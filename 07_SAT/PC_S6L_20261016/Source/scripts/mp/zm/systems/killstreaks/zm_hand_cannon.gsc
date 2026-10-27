// scripts\mp\zm\systems\killstreaks\zm_hand_cannon.gsc  (hash_215e40591e1f8e04.gscc) (size: 1472 Bytes / 0x5c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e041858 (2651068504)
// size ...... 1472 (0x5c0)
// includes .. 3   (offset: 0x574)
// strings ... 3   (offset: 0x58c)
// dev strs .. 0   (offset: 0x5c0)
// exports ... 7   (offset: 0x2f8)
// cseg ...... 0xa3 + 0x255 (0x2f8)
// imports ... 12  (offset: 0x410)
// animtree1 . 0   (offset: 0x5c0)
// animtree2 . 0   (offset: 0x5c0)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_hand_cannon;

// Namespace zm_hand_cannon
// Params 0, eflags: 0x5
// Checksum 0x3a93333f, Offset: 0xc1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_hand_cannon", undefined, &__init__, undefined );
}

// Namespace zm_hand_cannon
// Params 0
// Checksum 0xa16e9f5, Offset: 0xe2
// Size: 0xa
function __init__()
{
    level thread init_zm_hand_cannon();
}

// Namespace zm_hand_cannon
// Params 0
// Checksum 0xd275b7e8, Offset: 0xf4
// Size: 0x4f
function init_zm_hand_cannon()
{
    utility::flag_wait( "hand_cannon_initialized" );
    weaponname = utility::get_scripted_weapon_name( #"hand_cannon" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "hand_cannon", #"hand_cannon", #"low" );
    level thread register_on_kill_medal();
}

// Namespace zm_hand_cannon
// Params 0, eflags: 0x4
// Checksum 0x692be2ee, Offset: 0x14b
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"hand_cannon" );
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_hand_cannon
// Params 7
// Checksum 0x9c0f3d22, Offset: 0x1bf
// Size: 0x42
function zm_hand_cannon_damage( origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon )
{
    
}

// Namespace zm_hand_cannon
// Params 4, eflags: 0x4
// Checksum 0x6f87c810, Offset: 0x209
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "hand_cannon", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "hand_cannon" ] ) && self.rapidkill_data[ "hand_cannon" ].rapidkill_count === 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_annihilated" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "hand_cannon", victim );
    }
}

