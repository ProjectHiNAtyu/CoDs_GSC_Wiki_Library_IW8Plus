// scripts\mp\common\killstreaks\war_machine_launcher.gsc  (hash_1ad40e150c96e457.gscc) (size: 2152 Bytes / 0x868 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1c4b9bc (4056201660)
// size ...... 2152 (0x868)
// includes .. 5   (offset: 0x7ec)
// strings ... 5   (offset: 0x814)
// dev strs .. 0   (offset: 0x868)
// exports ... 9   (offset: 0x4a0)
// cseg ...... 0xd8 + 0x3c8 (0x4a0)
// imports ... 17  (offset: 0x608)
// animtree1 . 0   (offset: 0x868)
// animtree2 . 0   (offset: 0x868)
#using script_16ea1b94f0f381b3;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace war_machine_launcher;

// Namespace war_machine_launcher
// Params 0, eflags: 0x1
// Checksum 0xe4161393, Offset: 0xf6
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"war_machine_launcher", &init );
}

// Namespace war_machine_launcher
// Params 0
// Checksum 0x2d3e0aa2, Offset: 0x115
// Size: 0x9d
function init()
{
    bundle = killstreak::function_85b2d8e857ab4898( "war_machine_launcher" );
    weaponname = utility::get_scripted_weapon_name( #"war_machine_launcher" );
    
    if ( !isdefined( weaponname ) || !isdefined( bundle ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "war_machine_launcher", &function_2624d24b23333ae0, &function_6aa04a7a744a5786, undefined, &function_96a44ea729b8a384 );
    killstreaks::registerkillstreakstowableweapon( "war_machine_launcher", weaponname, undefined, "launcherWeapon", undefined, "used_war_machine_launcher", 1 );
    killstreaks::registerkillstreakdamagedealingweapon( "war_machine_launcher", weaponname, #"large" );
    utility::flag_set( "war_machine_launcher_initialized" );
}

// Namespace war_machine_launcher
// Params 1
// Checksum 0x7c764d75, Offset: 0x1ba
// Size: 0x14b
function function_2624d24b23333ae0( streakinfo )
{
    self.streakname = "war_machine_launcher";
    streakinfo.streakname = "war_machine_launcher";
    weaponname = utility::get_scripted_weapon_name( #"war_machine_launcher" );
    self.var_ec0bb630fbaa253a[ weaponname ] = streakinfo;
    var_2cf0a2f9ee3030b5 = level.streakglobals.streakbundles[ "war_machine_launcher" ];
    streakinfo.var_b7f22211336c491a = var_2cf0a2f9ee3030b5.var_b7f22211336c491a ?? 0;
    childthread function_455674f5fa05a20c( streakinfo );
    childthread function_2ec06ca2c9c99b5a( streakinfo );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_e344347324fb895c" ];
    
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

// Namespace war_machine_launcher
// Params 1
// Checksum 0xa552d61d, Offset: 0x30d
// Size: 0xc
function function_6aa04a7a744a5786( streakitem )
{
    
}

// Namespace war_machine_launcher
// Params 1
// Checksum 0x4ac07d0, Offset: 0x321
// Size: 0x52
function function_2ec06ca2c9c99b5a( streakinfo )
{
    self notify( #"hash_f7f742150e90583d" );
    self endon( #"hash_f7f742150e90583d" );
    self endon( #"war_machine_launcher_complete" );
    self waittill( #"death", attacker );
    thread function_43cec08586ecdde( streakinfo );
}

// Namespace war_machine_launcher
// Params 2
// Checksum 0x76f45088, Offset: 0x37b
// Size: 0x1e
function function_96a44ea729b8a384( streakitem, streakinfo )
{
    function_43cec08586ecdde( streakinfo );
}

// Namespace war_machine_launcher
// Params 1
// Checksum 0x569d7ba0, Offset: 0x3a1
// Size: 0x64
function function_43cec08586ecdde( streakinfo )
{
    self notify( #"streak_end" );
    self notify( #"war_machine_launcher_complete" );
    weaponname = utility::get_scripted_weapon_name( #"war_machine_launcher" );
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, weaponname ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    self.streakname = undefined;
}

// Namespace war_machine_launcher
// Params 1, eflags: 0xc
// Checksum 0x493c1c22, Offset: 0x40d
// Size: 0x93
function private function_455674f5fa05a20c( streakinfo )
{
    self notify( #"hash_2245059caba43f75" );
    self endon( #"hash_2245059caba43f75" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", projectileentity, weaponobj );
        
        if ( streakinfo.weaponstruct == weaponobj )
        {
            projectileentity.streakinfo = streakinfo;
        }
    }
}

