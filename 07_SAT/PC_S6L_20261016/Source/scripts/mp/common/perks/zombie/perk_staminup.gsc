// scripts\mp\common\perks\zombie\perk_staminup.gsc  (hash_2d65125a9787d413.gscc) (size: 7378 Bytes / 0x1cd2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40c8541b (1086870555)
// size ...... 7378 (0x1cd2)
// includes .. 12  (offset: 0x1a3a)
// strings ... 29  (offset: 0x1a9a)
// dev strs .. 0   (offset: 0x1cd2)
// exports ... 18  (offset: 0x100a)
// cseg ...... 0x2d5 + 0xd35 (0x100a)
// imports ... 58  (offset: 0x12da)
// animtree1 . 0   (offset: 0x1cd2)
// animtree2 . 0   (offset: 0x1cd2)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace perk_staminup;

// Namespace perk_staminup
// Params 0, eflags: 0x5
// Checksum 0x9cd4e948, Offset: 0x2f3
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_staminup", undefined, &__init__, undefined );
}

// Namespace perk_staminup
// Params 0, eflags: 0x1
// Checksum 0xf18dc1b3, Offset: 0x310
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_706b5b7d9c0aa5e2 );
}

// Namespace perk_staminup
// Params 0
// Checksum 0xaddac897, Offset: 0x330
// Size: 0xa
function __init__()
{
    level thread perk_staminup_init();
}

// Namespace perk_staminup
// Params 1
// Checksum 0xc187e1da, Offset: 0x342
// Size: 0x5e
function function_706b5b7d9c0aa5e2( params )
{
    bundle = level.perkbundles[ "specialty_staminup" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( isfunction( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_staminup", &function_b9e3302f8827c198, &function_d2df0872161d97ce );
    }
}

// Namespace perk_staminup
// Params 0
// Checksum 0x63d3d1bc, Offset: 0x3a8
// Size: 0xbf
function perk_staminup_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_staminup" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_staminup" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_staminup" );
    level thread zombie_perks::enable_perk_for_level( "specialty_staminup", str_currency, var_fcb7626c79b3c98f, &function_b9e3302f8827c198, &function_d2df0872161d97ce );
    level thread function_9d29784005227bc0();
    damage::register_scripted_damage_override_func( &staminup_damage_override_func );
    level utility::flag_set( "specialty_staminup" + "init_complete" );
    callback::add( "on_zombie_ai_killed", &on_zombie_killed );
}

// Namespace perk_staminup
// Params 0
// Checksum 0xacfca3bb, Offset: 0x46f
// Size: 0x19
function function_9d29784005227bc0()
{
    waitframe();
    perks::registerscriptperk( "specialty_zombies_lightweight", &function_ff794780938ce863, &function_a683e2e000a4d376 );
}

// Namespace perk_staminup
// Params 10
// Checksum 0x27c2c38a, Offset: 0x490
// Size: 0x2cc
function staminup_damage_override_func( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( zombie_perks::has_perk( "specialty_staminup" ) )
    {
        if ( self issprinting() )
        {
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_fire_walker" ) )
            {
                weaponelement = "none";
                
                if ( utility::issharedfuncdefined( #"zombie", #"get_weapon_element" ) )
                {
                    weaponelement = utility::callsharedfunc( #"zombie", #"get_weapon_element", objweapon, eattacker, smeansofdeath );
                }
                
                if ( weaponelement == "fire" || smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_RADIATION" || eattacker === self && smeansofdeath == "MOD_UNKNOWN" )
                {
                    return 0;
                }
            }
        }
        
        if ( level.gamemodebundle.var_2d09ffdf1e6a201b )
        {
            if ( self issupersprinting() || self issprinting() )
            {
                if ( isdefined( eattacker ) && eattacker != self && utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_slippery_target" ) && ( smeansofdeath === "MOD_PROJECTILE" || smeansofdeath === "MOD_PROJECTILE_SPLASH" || smeansofdeath === "MOD_GRENADE" || smeansofdeath === "MOD_RIFLE_BULLET" || smeansofdeath === "MOD_PISTOL_BULLET" || smeansofdeath === "MOD_GRENADE_SPLASH" ) )
                {
                    percentscale = level.zombie_augments[ #"staminup_slippery_target" ].var_74c1fa0fe24c4fd4 ?? 1;
                    damagereduced = int( idamage * percentscale );
                    idamage -= damagereduced;
                    
                    if ( idamage <= 0 )
                    {
                        idamage = 1;
                    }
                    
                    return idamage;
                }
            }
        }
        else if ( self issupersprinting() )
        {
            if ( isdefined( eattacker ) && eattacker != self && utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_slippery_target" ) && ( smeansofdeath === "MOD_PROJECTILE" || smeansofdeath === "MOD_PROJECTILE_SPLASH" || smeansofdeath === "MOD_GRENADE" || smeansofdeath === "MOD_RIFLE_BULLET" || smeansofdeath === "MOD_PISTOL_BULLET" ) )
            {
                percentscale = level.zombie_augments[ #"staminup_slippery_target" ].var_74c1fa0fe24c4fd4 ?? 1;
                damagereduced = int( idamage * percentscale );
                idamage -= damagereduced;
                
                if ( idamage <= 0 )
                {
                    idamage = 1;
                }
                
                return idamage;
            }
        }
    }
    
    return idamage;
}

// Namespace perk_staminup
// Params 0
// Checksum 0x6c0fc3d5, Offset: 0x765
// Size: 0x9
function function_b9e3302f8827c198()
{
    function_7069badc2a588f99();
}

// Namespace perk_staminup
// Params 4
// Checksum 0x3edd1e6b, Offset: 0x776
// Size: 0x2e
function function_d2df0872161d97ce( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    function_db3680e01aa62c5f();
}

// Namespace perk_staminup
// Params 0
// Checksum 0x53c10312, Offset: 0x7ac
// Size: 0x186
function function_7069badc2a588f99()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_guns_up" ) )
    {
        perk::giveperk( "specialty_fastsprintrecovery" );
        perk::giveperk( "specialty_sprintfire" );
        perk::giveperk( "specialty_sprintmelee" );
        perk::giveperk( "specialty_sprintads" );
        perk::giveperk( "specialty_sliding_ads" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_footwork" ) )
    {
        thread strafe_watcher();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_light_footed" ) )
    {
        self function_70576dbab4f88e19( "sndlightfooted", 1 );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_endurance" ) )
    {
        if ( level.gamemodebundle.var_2d09ffdf1e6a201b )
        {
            perk::giveperk( "specialty_supersprint" );
            perk::giveperk( "specialty_longersprint" );
        }
        else
        {
            perk::giveperk( "specialty_longersprint" );
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_multitask" ) )
    {
        perk::giveperk( "specialty_sprintoffhand" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_stalker" ) )
    {
        thread function_e21837c98e512fb9();
    }
    
    zombie_perks::function_5d65c3d58cc084ec( "specialty_staminup" );
}

// Namespace perk_staminup
// Params 0
// Checksum 0x2ae205f3, Offset: 0x93a
// Size: 0x214
function function_db3680e01aa62c5f()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_guns_up" ) )
    {
        perk::removeperk( "specialty_fastsprintrecovery" );
        perk::removeperk( "specialty_sprintfire" );
        perk::removeperk( "specialty_sprintmelee" );
        perk::removeperk( "specialty_sprintads" );
        perk::removeperk( "specialty_sliding_ads" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_light_footed" ) )
    {
        self function_70576dbab4f88e19( "sndlightfooted", 0 );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_endurance" ) )
    {
        if ( level.gamemodebundle.var_2d09ffdf1e6a201b )
        {
            perk::removeperk( "specialty_supersprint" );
            perk::removeperk( "specialty_longersprint" );
        }
        else
        {
            perk::removeperk( "specialty_longersprint" );
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_multitask" ) )
    {
        perk::removeperk( "specialty_sprintoffhand" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_stalker" ) )
    {
        if ( isdefined( self.var_2d0e74f429afe5a0[ "staminup_ads_speedup" ] ) )
        {
            weapons::removeextramovespeed( "staminup_ads_speedup" );
            weapons::updatemovespeedscale();
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"staminup_speed_boost" ) )
    {
        if ( isdefined( self.var_2d0e74f429afe5a0[ "staminup_speed_boost" ] ) )
        {
            weapons::removeextramovespeed( "staminup_speed_boost" );
            weapons::updatemovespeedscale();
        }
    }
    
    if ( self.var_9084c9dafed9e838 )
    {
        weapons::function_986fc44dada307f4( "staminup_strafe_boost" );
        weapons::updatemovespeedscale();
    }
    
    self.var_9084c9dafed9e838 = undefined;
    self notify( #"staminup_taken" );
    zombie_perks::function_25539251d02082( "specialty_staminup" );
}

// Namespace perk_staminup
// Params 0
// Checksum 0x5b6aebdf, Offset: 0xb56
// Size: 0x6c
function function_ff794780938ce863()
{
    perkbundle = level.perkbundles[ "specialty_staminup" ];
    var_8422f131d046ac11 = perkbundle.var_15bf096011c5614f ?? 0.05;
    weapons::addextramovespeed( "specialty_staminup", var_8422f131d046ac11 );
    
    if ( !common::function_8ff835bf23198a0( "specialty_staminup" ) )
    {
        common::function_ac4bf3256b2545e3( "specialty_staminup", var_8422f131d046ac11 );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace perk_staminup
// Params 0
// Checksum 0x194d2caf, Offset: 0xbca
// Size: 0x2f
function function_a683e2e000a4d376()
{
    weapons::removeextramovespeed( "specialty_staminup" );
    
    if ( common::function_8ff835bf23198a0( "specialty_staminup" ) )
    {
        common::function_d85a92c557ea5a52( "specialty_staminup" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace perk_staminup
// Params 0
// Checksum 0xe32c7cd0, Offset: 0xc01
// Size: 0xfd
function function_e21837c98e512fb9()
{
    self endon( #"death_or_disconnect" );
    self endon( #"staminup_taken" );
    speedupamount = level.zombie_augments[ #"staminup_stalker" ].var_823172a4c4a4b56b ?? 0;
    
    if ( speedupamount > 0 )
    {
        while ( isalive( self ) )
        {
            if ( self playerads() == 1 && !isdefined( self.var_2d0e74f429afe5a0[ "staminup_ads_speedup" ] ) )
            {
                weapons::addextramovespeed( "staminup_ads_speedup", speedupamount );
                
                if ( !common::function_8ff835bf23198a0( "staminup_ads_speedup" ) )
                {
                    common::function_ac4bf3256b2545e3( "staminup_ads_speedup", speedupamount );
                }
                
                weapons::updatemovespeedscale();
            }
            else if ( self playerads() < 0.95 )
            {
                if ( isdefined( self.var_2d0e74f429afe5a0[ "staminup_ads_speedup" ] ) )
                {
                    weapons::removeextramovespeed( "staminup_ads_speedup" );
                    
                    if ( common::function_8ff835bf23198a0( "staminup_ads_speedup" ) )
                    {
                        common::function_d85a92c557ea5a52( "staminup_ads_speedup" );
                    }
                    
                    weapons::updatemovespeedscale();
                }
            }
            
            waitframe();
        }
    }
}

// Namespace perk_staminup
// Params 0
// Checksum 0xda96b441, Offset: 0xd06
// Size: 0x131
function function_e68ae1adb512cc86()
{
    self notify( #"hash_1dae422c67252a63" );
    self endon( #"hash_1dae422c67252a63" );
    self endon( #"death_or_disconnect" );
    self endon( #"staminup_taken" );
    speedupamount = level.zombie_augments[ #"staminup_speed_boost" ].var_ec54c47718d2b814 ?? 0;
    duration = level.zombie_augments[ #"staminup_speed_boost" ].var_78bab22b492826fb ?? 0;
    
    if ( !isdefined( self.var_2d0e74f429afe5a0[ "staminup_speed_boost" ] ) )
    {
        weapons::addextramovespeed( "staminup_speed_boost", speedupamount );
        
        if ( !common::function_8ff835bf23198a0( "staminup_speed_boost" ) )
        {
            common::function_ac4bf3256b2545e3( "staminup_speed_boost", speedupamount );
        }
        
        weapons::updatemovespeedscale();
        self playlocalsound( #"hash_aecc80fd10ef0070" );
    }
    
    wait duration;
    
    if ( isdefined( self.var_2d0e74f429afe5a0[ "staminup_speed_boost" ] ) )
    {
        weapons::removeextramovespeed( "staminup_speed_boost" );
        
        if ( common::function_8ff835bf23198a0( "staminup_speed_boost" ) )
        {
            common::function_d85a92c557ea5a52( "staminup_speed_boost" );
        }
        
        weapons::updatemovespeedscale();
        self playlocalsound( #"hash_217277f8770373e5" );
    }
}

// Namespace perk_staminup
// Params 1
// Checksum 0x648d71ce, Offset: 0xe3f
// Size: 0xbf
function on_zombie_killed( sparams )
{
    if ( isplayer( sparams.eattacker ) && isdefined( sparams.objweapon ) && sparams.objweapon != level.weaponnone )
    {
        player = sparams.eattacker;
        weapon = sparams.objweapon;
        
        if ( equipment_mp::function_65ff545a795c7f55( weapon ) && !weapon::issuperweapon( weapon ) )
        {
            if ( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_staminup", #"staminup_speed_boost" ) )
            {
                player thread function_e68ae1adb512cc86();
            }
        }
    }
}

// Namespace perk_staminup
// Params 0, eflags: 0x4
// Checksum 0x30cf20ad, Offset: 0xf06
// Size: 0x104
function private strafe_watcher()
{
    self endon( #"death_or_disconnect" );
    self endon( #"staminup_taken" );
    self.var_9084c9dafed9e838 = 0;
    speed_boost_amount = 1 + ( level.zombie_augments[ #"staminup_footwork" ].var_ec54c47718d2b814 ?? 0.05 );
    
    while ( true )
    {
        var_754b2498ad7d4231 = vectornormalize( self getvelocity() );
        playerforward = vectornormalize( anglestoforward( self.angles ) );
        var_685dcddaa76d6f32 = vectordot( var_754b2498ad7d4231, playerforward );
        
        if ( var_685dcddaa76d6f32 > 0.5 )
        {
            if ( self.var_9084c9dafed9e838 )
            {
                weapons::function_986fc44dada307f4( "staminup_strafe_boost" );
                weapons::updatemovespeedscale();
                self.var_9084c9dafed9e838 = 0;
            }
        }
        else if ( !self.var_9084c9dafed9e838 )
        {
            weapons::function_4512b7715789e4cf( "staminup_strafe_boost", speed_boost_amount );
            weapons::updatemovespeedscale();
            self.var_9084c9dafed9e838 = 1;
        }
        
        waitframe();
    }
}

