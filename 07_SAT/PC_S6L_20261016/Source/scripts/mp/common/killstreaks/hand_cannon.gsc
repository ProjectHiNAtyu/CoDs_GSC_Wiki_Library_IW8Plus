// scripts\mp\common\killstreaks\hand_cannon.gsc  (hash_1c881541de2684c7.gscc) (size: 2067 Bytes / 0x813 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1575072a (359991082)
// size ...... 2067 (0x813)
// includes .. 5   (offset: 0x78b)
// strings ... 6   (offset: 0x7b3)
// dev strs .. 0   (offset: 0x813)
// exports ... 8   (offset: 0x44f)
// cseg ...... 0xd0 + 0x37f (0x44f)
// imports ... 18  (offset: 0x58f)
// animtree1 . 0   (offset: 0x813)
// animtree2 . 0   (offset: 0x813)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\points;

#namespace hand_cannon;

// Namespace hand_cannon
// Params 0, eflags: 0x1
// Checksum 0x8a5f4102, Offset: 0xee
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"hand_cannon", &init );
}

// Namespace hand_cannon
// Params 0
// Checksum 0xdbc33c, Offset: 0x10d
// Size: 0x80
function init()
{
    weaponname = utility::get_scripted_weapon_name( #"hand_cannon" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "hand_cannon", &function_d4a26e5e7325c827, &function_96f70995f8b50a0d, undefined, &function_44d968a6ecde2793 );
    killstreaks::registerkillstreakstowableweapon( "hand_cannon", weaponname, undefined, "bulletWeapon", undefined, "used_hand_cannon", 1 );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "hand_cannon", weaponname, #"low" );
    utility::flag_set( "hand_cannon_initialized" );
}

// Namespace hand_cannon
// Params 1
// Checksum 0x6fa47c4c, Offset: 0x195
// Size: 0x164
function function_d4a26e5e7325c827( streakinfo )
{
    weaponname = utility::get_scripted_weapon_name( #"hand_cannon" );
    self.streakname = "hand_cannon";
    streakinfo.streakname = "hand_cannon";
    
    if ( !isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a = [];
    }
    
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    handcannonbundle = level.streakglobals.streakbundles[ "hand_cannon" ];
    streakinfo.var_b7f22211336c491a = handcannonbundle.var_b7f22211336c491a ?? 0;
    childthread handcannon_watchplayerdeath( streakinfo );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_79d777018c6dba8b" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_79d777018c6dba8b" ) ]]( streakinfo );
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

// Namespace hand_cannon
// Params 1
// Checksum 0xea8716d7, Offset: 0x301
// Size: 0xc
function function_96f70995f8b50a0d( streakitem )
{
    
}

// Namespace hand_cannon
// Params 1
// Checksum 0x539982f8, Offset: 0x315
// Size: 0x81
function handcannon_watchplayerdeath( streakinfo )
{
    self notify( #"hash_20b28d0a3b943799" );
    self endon( #"hash_20b28d0a3b943799" );
    level endon( #"game_ended" );
    self endon( #"hand_cannon_complete" );
    self waittill( #"death", attacker );
    
    if ( attacker && attacker != self )
    {
        attacker thread points::doscoreevent( #"hash_dd99fb2b5b2ea3c7" );
    }
    
    if ( self )
    {
        thread handcannon_cleanup( streakinfo );
    }
}

// Namespace hand_cannon
// Params 2
// Checksum 0x53dfc0a4, Offset: 0x39e
// Size: 0x1e
function function_44d968a6ecde2793( streakitem, streakinfo )
{
    handcannon_cleanup( streakinfo );
}

// Namespace hand_cannon
// Params 1
// Checksum 0xb6e0b036, Offset: 0x3c4
// Size: 0x8b
function handcannon_cleanup( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"hand_cannon_complete" );
    handcannonbundle = level.streakglobals.streakbundles[ "hand_cannon" ];
    weaponname = handcannonbundle.deployweaponname ?? "t10_ks_handcannon";
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, weaponname ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

