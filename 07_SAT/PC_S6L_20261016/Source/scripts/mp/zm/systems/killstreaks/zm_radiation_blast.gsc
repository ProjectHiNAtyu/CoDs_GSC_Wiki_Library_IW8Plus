// scripts\mp\zm\systems\killstreaks\zm_radiation_blast.gsc  (hash_249fe7008537ba59.gscc) (size: 1326 Bytes / 0x52e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x648d4f3f (1686982463)
// size ...... 1326 (0x52e)
// includes .. 3   (offset: 0x4de)
// strings ... 3   (offset: 0x4f6)
// dev strs .. 0   (offset: 0x52e)
// exports ... 6   (offset: 0x2aa)
// cseg ...... 0xab + 0x1ff (0x2aa)
// imports ... 11  (offset: 0x39a)
// animtree1 . 0   (offset: 0x52e)
// animtree2 . 0   (offset: 0x52e)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_radiation_blast;

// Namespace zm_radiation_blast
// Params 0, eflags: 0x5
// Checksum 0x4f1cf423, Offset: 0xc9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_radiation_blast", undefined, &__init__, undefined );
}

// Namespace zm_radiation_blast
// Params 0
// Checksum 0x6536a875, Offset: 0xea
// Size: 0xa
function __init__()
{
    level thread init_zm_radiation_blast();
}

// Namespace zm_radiation_blast
// Params 0
// Checksum 0x333ece25, Offset: 0xfc
// Size: 0x5a
function init_zm_radiation_blast()
{
    utility::flag_wait( "radiation_blast_initialized" );
    weaponname = level.sentrysettings[ "radiation_blast" ].weaponinfo;
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "radiation_blast", weaponname, #"low" );
    level thread register_on_kill_medal();
}

// Namespace zm_radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xc0143cd1, Offset: 0x15e
// Size: 0x76
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = level.sentrysettings[ "radiation_blast" ].weaponinfo;
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_radiation_blast
// Params 4, eflags: 0x4
// Checksum 0x6a09b5a5, Offset: 0x1dc
// Size: 0xce
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "radiation_blast", sweapon );
    }
    
    if ( self.rapidkill_data[ "radiation_blast" ].rapidkill_count === 5 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_irradiated" );
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "radiation_blast", victim );
    }
}

