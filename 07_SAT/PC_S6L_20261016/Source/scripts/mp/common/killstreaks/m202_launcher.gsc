// scripts\mp\common\killstreaks\m202_launcher.gsc  (hash_110ddfe4561da436.gscc) (size: 2082 Bytes / 0x822 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x238f79b2 (596605362)
// size ...... 2082 (0x822)
// includes .. 4   (offset: 0x7a2)
// strings ... 6   (offset: 0x7c2)
// dev strs .. 0   (offset: 0x822)
// exports ... 9   (offset: 0x47a)
// cseg ...... 0xd2 + 0x3a8 (0x47a)
// imports ... 16  (offset: 0x5e2)
// animtree1 . 0   (offset: 0x822)
// animtree2 . 0   (offset: 0x822)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace m202_launcher;

// Namespace m202_launcher
// Params 0, eflags: 0x1
// Checksum 0xff667f, Offset: 0xf0
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"m202_launcher", &init );
}

// Namespace m202_launcher
// Params 0
// Checksum 0xecf4bbd5, Offset: 0x10f
// Size: 0x78
function init()
{
    weaponname = utility::get_scripted_weapon_name( #"m202_launcher" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "m202_launcher", &function_3fb9857b6c31dd96, &onavailable, undefined, &onend );
    killstreaks::registerkillstreakstowableweapon( "m202_launcher", weaponname, undefined, "launcherWeapon" );
    killstreaks::registerkillstreakdamagedealingweapon( "m202_launcher", weaponname, #"low" );
    utility::flag_set( "m202_launcher_initialized" );
}

// Namespace m202_launcher
// Params 1
// Checksum 0xfb8c9374, Offset: 0x18f
// Size: 0x167
function function_3fb9857b6c31dd96( streakinfo )
{
    self.streakname = "m202_launcher";
    streakinfo.streakname = "m202_launcher";
    self.var_ec0bb630fbaa253a[ "t10_ks_m202" ] = streakinfo;
    var_f435d4269243516f = level.streakglobals.streakbundles[ "m202_launcher" ];
    streakinfo.var_b7f22211336c491a = var_f435d4269243516f.var_b7f22211336c491a ?? 0;
    childthread function_455674f5fa05a20c( streakinfo );
    childthread watchplayerdeath( streakinfo );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_411fe5165e030ede" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "used_m202_launcher", self );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname, "Killstreak_Ground", self );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname );
    }
}

// Namespace m202_launcher
// Params 1
// Checksum 0x63483de4, Offset: 0x2fe
// Size: 0xc
function onavailable( streakitem )
{
    
}

// Namespace m202_launcher
// Params 1
// Checksum 0x8080a48d, Offset: 0x312
// Size: 0x52
function watchplayerdeath( streakinfo )
{
    self notify( #"hash_f10756acd24447d8" );
    self endon( #"hash_f10756acd24447d8" );
    self endon( #"hash_2550b15457767b91" );
    self waittill( #"death", attacker );
    thread cleanup( streakinfo );
}

// Namespace m202_launcher
// Params 2
// Checksum 0x873bce58, Offset: 0x36c
// Size: 0x1e
function onend( streakitem, streakinfo )
{
    cleanup( streakinfo );
}

// Namespace m202_launcher
// Params 1
// Checksum 0xc76f2988, Offset: 0x392
// Size: 0x4d
function cleanup( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"hash_2550b15457767b91" );
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, "t10_ks_m202" ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

// Namespace m202_launcher
// Params 1, eflags: 0xc
// Checksum 0x2a2b4c47, Offset: 0x3e7
// Size: 0x93
function private function_455674f5fa05a20c( streakinfo )
{
    self notify( #"hash_9aa9595a5acd4b07" );
    self endon( #"hash_9aa9595a5acd4b07" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    
    while ( true )
    {
        self waittill( #"missile_fire", projectileentity, weaponobj );
        
        if ( streakinfo.weaponstruct == weaponobj )
        {
            projectileentity.streakinfo = streakinfo;
        }
    }
}

