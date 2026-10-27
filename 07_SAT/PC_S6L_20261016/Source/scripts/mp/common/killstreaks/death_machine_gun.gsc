// scripts\mp\common\killstreaks\death_machine_gun.gsc  (hash_6c4ae6261d3ec681.gscc) (size: 1909 Bytes / 0x775 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5881279 (92803705)
// size ...... 1909 (0x775)
// includes .. 5   (offset: 0x6f9)
// strings ... 5   (offset: 0x721)
// dev strs .. 0   (offset: 0x775)
// exports ... 8   (offset: 0x3f1)
// cseg ...... 0xcd + 0x324 (0x3f1)
// imports ... 16  (offset: 0x531)
// animtree1 . 0   (offset: 0x775)
// animtree2 . 0   (offset: 0x775)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace death_machine_gun;

// Namespace death_machine_gun
// Params 0, eflags: 0x1
// Checksum 0x6bda04d8, Offset: 0xeb
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"death_machine_gun", &init );
}

// Namespace death_machine_gun
// Params 0
// Checksum 0xebb55e6e, Offset: 0x10a
// Size: 0x9d
function init()
{
    bundle = killstreak::function_85b2d8e857ab4898( "death_machine_gun" );
    weaponname = utility::get_scripted_weapon_name( #"death_machine_gun" );
    
    if ( !isdefined( weaponname ) || !isdefined( bundle ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "death_machine_gun", &function_f46826571d0976ac, &onavailable, undefined, &onend );
    killstreaks::registerkillstreakstowableweapon( "death_machine_gun", weaponname, undefined, "bulletWeapon", undefined, "used_death_machine_gun", 1 );
    killstreaks::registerkillstreakdamagedealingweapon( "death_machine_gun", weaponname, #"low" );
    utility::flag_set( "death_machine_gun_initialized" );
}

// Namespace death_machine_gun
// Params 1
// Checksum 0x2817a78a, Offset: 0x1af
// Size: 0x142
function function_f46826571d0976ac( streakinfo )
{
    self.streakname = "death_machine_gun";
    streakinfo.streakname = "death_machine_gun";
    weaponname = utility::get_scripted_weapon_name( #"death_machine_gun" );
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    var_278357a23cbfcd59 = level.streakglobals.streakbundles[ "death_machine_gun" ];
    streakinfo.var_b7f22211336c491a = var_278357a23cbfcd59.var_b7f22211336c491a ?? 0;
    childthread watchplayerdeath( streakinfo );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_3f214449424db11a" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname, "Killstreak_Ground", self );
    }
}

// Namespace death_machine_gun
// Params 1
// Checksum 0xe42b6c67, Offset: 0x2f9
// Size: 0xc
function onavailable( streakitem )
{
    
}

// Namespace death_machine_gun
// Params 1
// Checksum 0x9cae5ac, Offset: 0x30d
// Size: 0x52
function watchplayerdeath( streakinfo )
{
    self notify( #"hash_caf74b3fd0367c2f" );
    self endon( #"hash_caf74b3fd0367c2f" );
    self endon( #"death_machine_gun_complete" );
    self waittill( #"death", attacker );
    thread cleanup( streakinfo );
}

// Namespace death_machine_gun
// Params 2
// Checksum 0x49e82754, Offset: 0x367
// Size: 0x1e
function onend( streakitem, streakinfo )
{
    cleanup( streakinfo );
}

// Namespace death_machine_gun
// Params 1
// Checksum 0xb568f863, Offset: 0x38d
// Size: 0x64
function cleanup( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"death_machine_gun_complete" );
    weaponname = utility::get_scripted_weapon_name( #"death_machine_gun" );
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, weaponname ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

