// scripts\mp\zm\systems\killstreaks\zm_mega_death_machine_gun.gsc  (hash_5e8688a56b0c5837.gscc) (size: 2359 Bytes / 0x937 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13ed33e0 (334312416)
// size ...... 2359 (0x937)
// includes .. 5   (offset: 0x8af)
// strings ... 5   (offset: 0x8d7)
// dev strs .. 0   (offset: 0x937)
// exports ... 10  (offset: 0x4b7)
// cseg ...... 0xd3 + 0x3e4 (0x4b7)
// imports ... 21  (offset: 0x647)
// animtree1 . 0   (offset: 0x937)
// animtree2 . 0   (offset: 0x937)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace zm_mega_death_machine_gun;

// Namespace zm_mega_death_machine_gun
// Params 0, eflags: 0x1
// Checksum 0x77fea34c, Offset: 0xf1
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"mega_death_machine_gun", &init );
}

// Namespace zm_mega_death_machine_gun
// Params 0
// Checksum 0x6a6966c1, Offset: 0x110
// Size: 0x99
function init()
{
    bundle = killstreak::function_85b2d8e857ab4898( "mega_death_machine_gun" );
    weaponname = utility::get_scripted_weapon_name( #"mega_death_machine_gun" );
    
    if ( !isdefined( weaponname ) || !isdefined( bundle ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "mega_death_machine_gun", &function_94babf25f62b1eaa, &onavailable, undefined, &onend );
    killstreaks::registerkillstreakstowableweapon( "mega_death_machine_gun", weaponname, undefined, "bulletWeapon", undefined, "used_mega_death_machine_gun", 1 );
    killstreaks::registerkillstreakdamagedealingweapon( "mega_death_machine_gun", weaponname, #"low" );
    level thread register_on_kill_medal();
}

// Namespace zm_mega_death_machine_gun
// Params 1
// Checksum 0xf604b357, Offset: 0x1b1
// Size: 0x9b
function function_94babf25f62b1eaa( streakinfo )
{
    self.streakname = "mega_death_machine_gun";
    streakinfo.streakname = "mega_death_machine_gun";
    weaponname = utility::get_scripted_weapon_name( #"mega_death_machine_gun" );
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    var_b8f7799197bd32cb = level.streakglobals.streakbundles[ "mega_death_machine_gun" ];
    streakinfo.var_b7f22211336c491a = var_b8f7799197bd32cb.var_b7f22211336c491a ?? 0;
    childthread watchplayerdeath( streakinfo );
}

// Namespace zm_mega_death_machine_gun
// Params 1
// Checksum 0x72f681f0, Offset: 0x254
// Size: 0xc
function onavailable( streakitem )
{
    
}

// Namespace zm_mega_death_machine_gun
// Params 1
// Checksum 0xcb2c559e, Offset: 0x268
// Size: 0x52
function watchplayerdeath( streakinfo )
{
    self notify( #"hash_c0d9d6474f31ef41" );
    self endon( #"hash_c0d9d6474f31ef41" );
    self endon( #"mega_death_machine_gun_complete" );
    self waittill( #"death", attacker );
    thread cleanup( streakinfo );
}

// Namespace zm_mega_death_machine_gun
// Params 2
// Checksum 0xce9ebe9f, Offset: 0x2c2
// Size: 0x1e
function onend( streakitem, streakinfo )
{
    cleanup( streakinfo );
}

// Namespace zm_mega_death_machine_gun
// Params 1
// Checksum 0xfd770252, Offset: 0x2e8
// Size: 0x64
function cleanup( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"mega_death_machine_gun_complete" );
    weaponname = utility::get_scripted_weapon_name( #"mega_death_machine_gun" );
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, weaponname ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

// Namespace zm_mega_death_machine_gun
// Params 0, eflags: 0x4
// Checksum 0xe79646c2, Offset: 0x354
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"mega_death_machine_gun" );
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_mega_death_machine_gun
// Params 4, eflags: 0x4
// Checksum 0xf6aa3ce8, Offset: 0x3c8
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

