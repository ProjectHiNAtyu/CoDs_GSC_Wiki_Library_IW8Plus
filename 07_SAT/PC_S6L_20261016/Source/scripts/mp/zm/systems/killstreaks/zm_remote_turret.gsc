// scripts\mp\zm\systems\killstreaks\zm_remote_turret.gsc  (hash_64a9de370adcb0fe.gscc) (size: 1472 Bytes / 0x5c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39faeb89 (972745609)
// size ...... 1472 (0x5c0)
// includes .. 4   (offset: 0x54c)
// strings ... 4   (offset: 0x56c)
// dev strs .. 0   (offset: 0x5c0)
// exports ... 6   (offset: 0x2dc)
// cseg ...... 0xbf + 0x21d (0x2dc)
// imports ... 13  (offset: 0x3cc)
// animtree1 . 0   (offset: 0x5c0)
// animtree2 . 0   (offset: 0x5c0)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace zm_remote_turret;

// Namespace zm_remote_turret
// Params 0, eflags: 0x5
// Checksum 0x10bbb96, Offset: 0xdd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_remote_turret", undefined, &__init__, undefined );
}

// Namespace zm_remote_turret
// Params 0
// Checksum 0x90552a17, Offset: 0xfe
// Size: 0xa
function __init__()
{
    level thread init_zm_remote_turret();
}

// Namespace zm_remote_turret
// Params 0
// Checksum 0x32bea4ed, Offset: 0x110
// Size: 0x5d
function init_zm_remote_turret()
{
    utility::flag_wait( "remote_turret_initialized" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "remote_turret", "sat_remote_turret_zm", #"low" );
    weaponname = utility::get_scripted_weapon_name( "remote_turret" ) ?? "sat_remote_turret_zm";
    weapon::registerkillstreakweaponmap( "remote_turret", weaponname );
    level thread register_on_kill_medal();
}

// Namespace zm_remote_turret
// Params 0, eflags: 0x4
// Checksum 0x3aa9deba, Offset: 0x175
// Size: 0x70
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( "remote_turret" ) ?? "sat_remote_turret_zm";
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_remote_turret
// Params 4, eflags: 0x4
// Checksum 0xb5a1587b, Offset: 0x1ed
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "remote_turret", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "remote_turret" ] ) && self.rapidkill_data[ "remote_turret" ].rapidkill_count === 5 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_remote_crackdown" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "remote_turret", victim );
    }
}

