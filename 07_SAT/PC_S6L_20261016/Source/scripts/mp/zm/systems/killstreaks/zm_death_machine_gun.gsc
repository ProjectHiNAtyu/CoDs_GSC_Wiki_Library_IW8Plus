// scripts\mp\zm\systems\killstreaks\zm_death_machine_gun.gsc  (hash_679a3086e0de1436.gscc) (size: 1396 Bytes / 0x574 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49399887 (1228511367)
// size ...... 1396 (0x574)
// includes .. 3   (offset: 0x520)
// strings ... 4   (offset: 0x538)
// dev strs .. 0   (offset: 0x574)
// exports ... 6   (offset: 0x2cc)
// cseg ...... 0xc0 + 0x20c (0x2cc)
// imports ... 12  (offset: 0x3bc)
// animtree1 . 0   (offset: 0x574)
// animtree2 . 0   (offset: 0x574)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_death_machine_gun;

// Namespace zm_death_machine_gun
// Params 0, eflags: 0x5
// Checksum 0xbd050d0d, Offset: 0xde
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_death_machine", undefined, &__init__, undefined );
}

// Namespace zm_death_machine_gun
// Params 0
// Checksum 0x36cd1dd0, Offset: 0xff
// Size: 0xa
function __init__()
{
    level thread init_zm_death_machine();
}

// Namespace zm_death_machine_gun
// Params 0
// Checksum 0x2a7d64f8, Offset: 0x111
// Size: 0x50
function init_zm_death_machine()
{
    utility::flag_wait( "death_machine_gun_initialized" );
    weaponname = utility::get_scripted_weapon_name( #"death_machine_gun" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "death_machine_gun", weaponname, #"low" );
    level thread register_on_kill_medal();
}

// Namespace zm_death_machine_gun
// Params 0, eflags: 0x4
// Checksum 0xfc1e3c39, Offset: 0x169
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"death_machine_gun" );
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_death_machine_gun
// Params 4, eflags: 0x4
// Checksum 0x7c01f35, Offset: 0x1dd
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "death_machine", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "death_machine" ] ) && self.rapidkill_data[ "death_machine" ].rapidkill_count === 15 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_shredded" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "death_machine", victim );
    }
}

