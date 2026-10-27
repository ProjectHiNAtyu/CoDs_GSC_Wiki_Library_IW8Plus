// scripts\mp\zm\systems\killstreaks\zm_war_machine.gsc  (hash_759613ac79fdd727.gscc) (size: 1405 Bytes / 0x57d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa729c8f4 (2804533492)
// size ...... 1405 (0x57d)
// includes .. 3   (offset: 0x525)
// strings ... 4   (offset: 0x53d)
// dev strs .. 0   (offset: 0x57d)
// exports ... 6   (offset: 0x2d1)
// cseg ...... 0xca + 0x207 (0x2d1)
// imports ... 12  (offset: 0x3c1)
// animtree1 . 0   (offset: 0x57d)
// animtree2 . 0   (offset: 0x57d)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_war_machine;

// Namespace zm_war_machine
// Params 0, eflags: 0x5
// Checksum 0xa74b7970, Offset: 0xe8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_war_machine", undefined, &__init__, undefined );
}

// Namespace zm_war_machine
// Params 0
// Checksum 0xbe35cc6a, Offset: 0x109
// Size: 0xa
function __init__()
{
    level thread init_zm_war_machine();
}

// Namespace zm_war_machine
// Params 0
// Checksum 0x17a72c38, Offset: 0x11b
// Size: 0x4b
function init_zm_war_machine()
{
    utility::flag_wait( "war_machine_launcher_initialized" );
    weaponname = utility::get_scripted_weapon_name( #"war_machine_launcher" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "war_machine_launcher", "t10_ks_warmachine", #"low" );
    level thread register_on_kill_medal();
}

// Namespace zm_war_machine
// Params 0, eflags: 0x4
// Checksum 0xb87ace8e, Offset: 0x16e
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"war_machine_launcher" );
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_war_machine
// Params 4, eflags: 0x4
// Checksum 0x8e2d02a1, Offset: 0x1e2
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "war_machine_launcher", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "war_machine_launcher" ] ) && self.rapidkill_data[ "war_machine_launcher" ].rapidkill_count === 15 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_bouncehouse" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "war_machine_launcher", victim );
    }
}

