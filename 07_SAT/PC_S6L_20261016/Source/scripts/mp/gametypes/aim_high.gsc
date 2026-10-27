// scripts\mp\gametypes\aim_high.gsc  (hash_643fcf5927413f68.gscc) (size: 1285 Bytes / 0x505 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c8cf05e (478998622)
// size ...... 1285 (0x505)
// includes .. 3   (offset: 0x4b9)
// strings ... 4   (offset: 0x4d1)
// dev strs .. 0   (offset: 0x505)
// exports ... 5   (offset: 0x2d1)
// cseg ...... 0xb4 + 0x21d (0x2d1)
// imports ... 10  (offset: 0x399)
// animtree1 . 0   (offset: 0x505)
// animtree2 . 0   (offset: 0x505)
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\damage;

#namespace aim_high;

// Namespace aim_high
// Params 0, eflags: 0x1
// Checksum 0xf94c8df8, Offset: 0xd2
// Size: 0x1b
function autoexec main()
{
    if ( !getdvarint( @"hash_9e466fa03585c99e", 0 ) )
    {
        init();
    }
}

// Namespace aim_high
// Params 0, eflags: 0x4
// Checksum 0x2b390ddf, Offset: 0xf5
// Size: 0x9b
function private init()
{
    level.headshotDamageMultiplier = getmatchrulesdata( "commonOption", "headshotDamageMultiplier" );
    level.bodydamagemultiplier = getmatchrulesdata( "commonOption", "nonHeadshotDamageMultiplier" );
    
    if ( !( level.headshotDamageMultiplier || !level.nonHeadshotDamageMultiplier ) )
    {
        return;
    }
    
    if ( level.headshotDamageMultiplier != 1 || level.bodydamagemultiplier != 1 )
    {
        damage::register_scripted_damage_override_func( &function_ce357f8f084a634a );
    }
    
    if ( level.bodydamagemultiplier < 1 )
    {
        damage::function_231589aee53ae064( &function_4aae200be06f56ae );
    }
}

// Namespace aim_high
// Params 1, eflags: 0x4
// Checksum 0xb1ea85b4, Offset: 0x198
// Size: 0x5b
function private function_4aae200be06f56ae( hitparams )
{
    str_means_of_death = hitparams.meansofdeath;
    var_a531c067af82927a = hitparams.hitlocation;
    
    if ( !utility::isbulletdamage( str_means_of_death ) )
    {
        return;
    }
    
    if ( damage_utility::isheadshot( var_a531c067af82927a, str_means_of_death ) )
    {
        return;
    }
    
    return "hitarmorlight";
}

// Namespace aim_high
// Params 10, eflags: 0x4
// Checksum 0x30f70b13, Offset: 0x1fb
// Size: 0xd5
function private function_ce357f8f084a634a( e_inflictor, e_attacker, n_damage, id_flags, str_means_of_death, var_f02dcbbb028482e0, var_5fb4fe43f49ba675, v_dir, var_a531c067af82927a, var_10a6b9eadfe28ee1 )
{
    if ( !isdefined( level.headshotDamageMultiplier ) )
    {
        level.headshotDamageMultiplier = 1;
    }
    
    if ( !isdefined( level.bodydamagemultiplier ) )
    {
        level.bodydamagemultiplier = 1;
    }
    
    if ( utility::isbulletdamage( str_means_of_death ) )
    {
        var_dda424c349037c52 = damage_utility::isheadshot( var_a531c067af82927a, str_means_of_death, e_attacker ) ? level.headshotDamageMultiplier : level.bodydamagemultiplier;
    }
    else
    {
        var_dda424c349037c52 = 1;
    }
    
    return var_dda424c349037c52 * n_damage;
}

