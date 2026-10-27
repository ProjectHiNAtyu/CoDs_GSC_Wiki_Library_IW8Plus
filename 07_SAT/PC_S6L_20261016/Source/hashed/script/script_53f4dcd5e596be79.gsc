// script_53f4dcd5e596be79  (hash_53f4dcd5e596be79.gscc) (size: 1355 Bytes / 0x54b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e49b3c5 (1581888453)
// size ...... 1355 (0x54b)
// includes .. 3   (offset: 0x4ff)
// strings ... 3   (offset: 0x517)
// dev strs .. 0   (offset: 0x54b)
// exports ... 6   (offset: 0x2ab)
// cseg ...... 0xa7 + 0x204 (0x2ab)
// imports ... 12  (offset: 0x39b)
// animtree1 . 0   (offset: 0x54b)
// animtree2 . 0   (offset: 0x54b)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_8a47ca27ad231692;

// Namespace namespace_8a47ca27ad231692
// Params 0, eflags: 0x5
// Checksum 0x579749f4, Offset: 0xc5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_7f4696802cec0729", undefined, &__init__, undefined );
}

// Namespace namespace_8a47ca27ad231692
// Params 0
// Checksum 0xf29a0f18, Offset: 0xe6
// Size: 0xa
function __init__()
{
    level thread function_8acb89c56b24b1b1();
}

// Namespace namespace_8a47ca27ad231692
// Params 0
// Checksum 0x18872cd1, Offset: 0xf8
// Size: 0x48
function function_8acb89c56b24b1b1()
{
    utility::flag_wait( "m202_launcher_initialized" );
    weaponname = utility::get_scripted_weapon_name( #"m202_launcher" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "m202_launcher", weaponname, #"low" );
    level thread register_on_kill_medal();
}

// Namespace namespace_8a47ca27ad231692
// Params 0, eflags: 0x4
// Checksum 0x28dccfc5, Offset: 0x148
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"m202_launcher" );
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace namespace_8a47ca27ad231692
// Params 4, eflags: 0x4
// Checksum 0x655fbd83, Offset: 0x1bc
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "m202_launcher", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "m202_launcher" ] ) && self.rapidkill_data[ "m202_launcher" ].rapidkill_count === 15 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_soulharvest" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "m202_launcher", victim );
    }
}

