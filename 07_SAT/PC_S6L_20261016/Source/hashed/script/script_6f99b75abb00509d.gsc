// script_6f99b75abb00509d  (hash_6f99b75abb00509d.gscc) (size: 2192 Bytes / 0x890 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7b3145c (3350402140)
// size ...... 2192 (0x890)
// includes .. 5   (offset: 0x7ec)
// strings ... 7   (offset: 0x814)
// dev strs .. 0   (offset: 0x890)
// exports ... 9   (offset: 0x484)
// cseg ...... 0xe6 + 0x39e (0x484)
// imports ... 18  (offset: 0x5ec)
// animtree1 . 0   (offset: 0x890)
// animtree2 . 0   (offset: 0x890)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace namespace_f77a3ddd0c31ab19;

// Namespace namespace_f77a3ddd0c31ab19
// Params 0, eflags: 0x1
// Checksum 0x3c6d3068, Offset: 0x104
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"ray_gun_mk2", &init );
}

// Namespace namespace_f77a3ddd0c31ab19
// Params 0
// Checksum 0x1a4ba912, Offset: 0x123
// Size: 0x7c
function init()
{
    weaponname = utility::get_scripted_weapon_name( #"raygun_mark_2" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "ray_gun_mk2", &function_206a9486e227868f, &onavailable, undefined, &onend );
    killstreaks::registerkillstreakstowableweapon( "ray_gun_mk2", weaponname, undefined, "bulletWeapon", undefined, undefined, 1 );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ray_gun_mk2", weaponname, #"low" );
    utility::flag_set( "ray_gun_initialized" );
}

// Namespace namespace_f77a3ddd0c31ab19
// Params 1
// Checksum 0x4f37e898, Offset: 0x1a7
// Size: 0x146
function function_206a9486e227868f( streakinfo )
{
    val::set( "ray_gun_mk2_weapon_pickup", "weapon_pickup", 0 );
    thread function_a9e8e45f85e015bc( streakinfo );
    weaponname = utility::get_scripted_weapon_name( #"raygun_mark_2" );
    self.streakname = "ray_gun_mk2";
    streakinfo.streakname = "ray_gun_mk2";
    
    if ( !isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a = [];
    }
    
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    bundle = level.streakglobals.streakbundles[ "ray_gun_mk2" ];
    streakinfo.var_b7f22211336c491a = bundle.var_b7f22211336c491a ?? 0;
    childthread watchplayerdeath( streakinfo );
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

// Namespace namespace_f77a3ddd0c31ab19
// Params 1, eflags: 0x4
// Checksum 0x640bfdb7, Offset: 0x2f5
// Size: 0x47
function private function_a9e8e45f85e015bc( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_8e80bd6cf04ca687" );
    streakinfo waittill( #"killstreak_stowable_weapon_switched" );
    
    if ( self )
    {
        val::reset( "ray_gun_mk2_weapon_pickup", "weapon_pickup" );
    }
}

// Namespace namespace_f77a3ddd0c31ab19
// Params 1
// Checksum 0x7da4803d, Offset: 0x344
// Size: 0xc
function onavailable( streakitem )
{
    
}

// Namespace namespace_f77a3ddd0c31ab19
// Params 1
// Checksum 0x4a07bb1c, Offset: 0x358
// Size: 0x62
function watchplayerdeath( streakinfo )
{
    self notify( #"hash_d145653dec691d93" );
    self endon( #"hash_d145653dec691d93" );
    level endon( #"game_ended" );
    self endon( #"hash_8e80bd6cf04ca687" );
    self waittill( #"death", attacker );
    
    if ( self )
    {
        thread cleanup( streakinfo );
    }
}

// Namespace namespace_f77a3ddd0c31ab19
// Params 2
// Checksum 0x45e983e1, Offset: 0x3c2
// Size: 0x1e
function onend( streakitem, streakinfo )
{
    cleanup( streakinfo );
}

// Namespace namespace_f77a3ddd0c31ab19
// Params 1
// Checksum 0x7075abdd, Offset: 0x3e8
// Size: 0x9c
function cleanup( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"hash_8e80bd6cf04ca687" );
    val::reset( "ray_gun_mk2_weapon_pickup", "weapon_pickup" );
    bundle = level.streakglobals.streakbundles[ "ray_gun_mk2" ];
    weaponname = bundle.deployweaponname ?? "sat_ks_handcannon";
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, weaponname ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

