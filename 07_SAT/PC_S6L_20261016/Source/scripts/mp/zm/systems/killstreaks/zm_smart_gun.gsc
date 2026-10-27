// scripts\mp\zm\systems\killstreaks\zm_smart_gun.gsc  (hash_0ece80be73ed1593.gscc) (size: 1355 Bytes / 0x54b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ba538e8 (1805990120)
// size ...... 1355 (0x54b)
// includes .. 3   (offset: 0x4ff)
// strings ... 3   (offset: 0x517)
// dev strs .. 0   (offset: 0x54b)
// exports ... 6   (offset: 0x2ab)
// cseg ...... 0x9f + 0x20c (0x2ab)
// imports ... 12  (offset: 0x39b)
// animtree1 . 0   (offset: 0x54b)
// animtree2 . 0   (offset: 0x54b)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_smart_gun;

// Namespace zm_smart_gun
// Params 0, eflags: 0x5
// Checksum 0x71e2916a, Offset: 0xbd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_smart_gun", undefined, &__init__, undefined );
}

// Namespace zm_smart_gun
// Params 0
// Checksum 0xc2c41d27, Offset: 0xde
// Size: 0xa
function __init__()
{
    level thread init_zm_smart_gun();
}

// Namespace zm_smart_gun
// Params 0
// Checksum 0x352aa508, Offset: 0xf0
// Size: 0x50
function init_zm_smart_gun()
{
    utility::flag_wait( "smart_gun_initialized" );
    weaponname = utility::get_scripted_weapon_name( #"smart_gun" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "smart_gun", weaponname, #"low" );
    level thread register_on_kill_medal();
}

// Namespace zm_smart_gun
// Params 0, eflags: 0x4
// Checksum 0xb49c681b, Offset: 0x148
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"smart_gun" );
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_smart_gun
// Params 4, eflags: 0x4
// Checksum 0x88641b7b, Offset: 0x1bc
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "smart_gun", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "smart_gun" ] ) && self.rapidkill_data[ "smart_gun" ].rapidkill_count === 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_smartgun" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "smart_gun", victim );
    }
}

