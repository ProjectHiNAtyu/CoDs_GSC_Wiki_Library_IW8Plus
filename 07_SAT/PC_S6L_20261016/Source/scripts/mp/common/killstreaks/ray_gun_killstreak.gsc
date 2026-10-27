// scripts\mp\common\killstreaks\ray_gun_killstreak.gsc  (hash_4aa78276955ed6ce.gscc) (size: 2183 Bytes / 0x887 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0bd516d (2965197165)
// size ...... 2183 (0x887)
// includes .. 5   (offset: 0x7e3)
// strings ... 7   (offset: 0x80b)
// dev strs .. 0   (offset: 0x887)
// exports ... 9   (offset: 0x47b)
// cseg ...... 0xdd + 0x39e (0x47b)
// imports ... 18  (offset: 0x5e3)
// animtree1 . 0   (offset: 0x887)
// animtree2 . 0   (offset: 0x887)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace ray_gun_killstreak;

// Namespace ray_gun_killstreak
// Params 0, eflags: 0x1
// Checksum 0x8aecce2b, Offset: 0xfb
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"ray_gun", &init );
}

// Namespace ray_gun_killstreak
// Params 0
// Checksum 0x6b69cc21, Offset: 0x11a
// Size: 0x7c
function init()
{
    weaponname = utility::get_scripted_weapon_name( #"raygun" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "ray_gun", &function_206a9486e227868f, &onavailable, undefined, &onend );
    killstreaks::registerkillstreakstowableweapon( "ray_gun", weaponname, undefined, "bulletWeapon", undefined, undefined, 1 );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ray_gun", weaponname, #"low" );
    utility::flag_set( "ray_gun_initialized" );
}

// Namespace ray_gun_killstreak
// Params 1
// Checksum 0xec27f5ea, Offset: 0x19e
// Size: 0x146
function function_206a9486e227868f( streakinfo )
{
    val::set( "ray_gun_weapon_pickup", "weapon_pickup", 0 );
    thread function_a9e8e45f85e015bc( streakinfo );
    weaponname = utility::get_scripted_weapon_name( #"raygun" );
    self.streakname = "ray_gun";
    streakinfo.streakname = "ray_gun";
    
    if ( !isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a = [];
    }
    
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    bundle = level.streakglobals.streakbundles[ "ray_gun" ];
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

// Namespace ray_gun_killstreak
// Params 1, eflags: 0x4
// Checksum 0x1433b96b, Offset: 0x2ec
// Size: 0x47
function private function_a9e8e45f85e015bc( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"ray_gun_complete" );
    streakinfo waittill( #"killstreak_stowable_weapon_switched" );
    
    if ( self )
    {
        val::reset( "ray_gun_weapon_pickup", "weapon_pickup" );
    }
}

// Namespace ray_gun_killstreak
// Params 1
// Checksum 0x7ead1aee, Offset: 0x33b
// Size: 0xc
function onavailable( streakitem )
{
    
}

// Namespace ray_gun_killstreak
// Params 1
// Checksum 0xe80d8781, Offset: 0x34f
// Size: 0x62
function watchplayerdeath( streakinfo )
{
    self notify( #"hash_2fad5390192e4130" );
    self endon( #"hash_2fad5390192e4130" );
    level endon( #"game_ended" );
    self endon( #"ray_gun_complete" );
    self waittill( #"death", attacker );
    
    if ( self )
    {
        thread cleanup( streakinfo );
    }
}

// Namespace ray_gun_killstreak
// Params 2
// Checksum 0x8a856b17, Offset: 0x3b9
// Size: 0x1e
function onend( streakitem, streakinfo )
{
    cleanup( streakinfo );
}

// Namespace ray_gun_killstreak
// Params 1
// Checksum 0x2756a1a9, Offset: 0x3df
// Size: 0x9c
function cleanup( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"ray_gun_complete" );
    val::reset( "ray_gun_weapon_pickup", "weapon_pickup" );
    bundle = level.streakglobals.streakbundles[ "ray_gun" ];
    weaponname = bundle.deployweaponname ?? "sat_ww_raygun_mp";
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, weaponname ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

