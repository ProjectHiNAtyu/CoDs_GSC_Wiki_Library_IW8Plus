// scripts\mp\common\weapons\weap_raygun.gsc  (hash_4707d25b1c80f2fa.gscc) (size: 2611 Bytes / 0xa33 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x203f94d7 (541037783)
// size ...... 2611 (0xa33)
// includes .. 3   (offset: 0x9cb)
// strings ... 4   (offset: 0x9e3)
// dev strs .. 2   (offset: 0xa1b)
// exports ... 5   (offset: 0x7db)
// cseg ...... 0x98 + 0x743 (0x7db)
// imports ... 10  (offset: 0x8a3)
// animtree1 . 0   (offset: 0xa33)
// animtree2 . 0   (offset: 0xa33)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;

#namespace weap_raygun;

// Namespace weap_raygun
// Params 0, eflags: 0x5
// Checksum 0x59af8f06, Offset: 0xb6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"weap_raygun", undefined, &init, undefined );
}

// Namespace weap_raygun
// Params 0, eflags: 0x4
// Checksum 0xbd7bafaf, Offset: 0xd7
// Size: 0x417
function private init()
{
    raygun_name = utility::get_scripted_weapon_name( #"raygun" );
    level.raygun_weapon_basename = raygun_name;
    assert( isdefined( raygun_name ) );
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = raygun_name;
    
    if ( !isdefined( level.var_35e19e0af705d62e ) )
    {
        level.var_35e19e0af705d62e = [];
    }
    
    level.var_35e19e0af705d62e[ level.var_35e19e0af705d62e.size ] = raygun_name;
    
    if ( !isdefined( level.var_ef6fc50ff40f47a8 ) )
    {
        level.var_ef6fc50ff40f47a8 = [];
    }
    
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = raygun_name;
    
    if ( !isdefined( level.var_20949167f659852f ) )
    {
        level.var_20949167f659852f = [];
    }
    
    level.var_20949167f659852f[ raygun_name ] = &function_95c07e7203ddaa26;
    
    if ( !isdefined( level.var_f7d8c385fccc43b4 ) )
    {
        level.var_f7d8c385fccc43b4 = [];
    }
    
    level.var_f7d8c385fccc43b4[ raygun_name ] = &function_23de2810dc858a9c;
    
    if ( !isdefined( level.var_86f911ce75014794 ) )
    {
        level.var_86f911ce75014794 = [];
    }
    
    level.var_86f911ce75014794[ level.raygun_weapon_basename ] = 1;
    level.var_666ec6850e612e3d = [];
    level.var_666ec6850e612e3d[ 0 ] = spawnstruct();
    level.var_666ec6850e612e3d[ 0 ].var_114709d5b68798 = 1000;
    level.var_666ec6850e612e3d[ 0 ].splash_damage_lower = 300;
    level.var_666ec6850e612e3d[ 0 ].splash_damage_upper = 1500;
    level.var_666ec6850e612e3d[ 0 ].splash_damage_range = 1200;
    level.var_666ec6850e612e3d[ 0 ].damage_scalar = 1;
    level.var_666ec6850e612e3d[ 1 ] = spawnstruct();
    level.var_666ec6850e612e3d[ 1 ].var_114709d5b68798 = 1500;
    level.var_666ec6850e612e3d[ 1 ].splash_damage_lower = 600;
    level.var_666ec6850e612e3d[ 1 ].splash_damage_upper = 2000;
    level.var_666ec6850e612e3d[ 1 ].splash_damage_range = 1400;
    level.var_666ec6850e612e3d[ 1 ].damage_scalar = 1.5;
    level.var_666ec6850e612e3d[ 2 ] = spawnstruct();
    level.var_666ec6850e612e3d[ 2 ].var_114709d5b68798 = 3000;
    level.var_666ec6850e612e3d[ 2 ].splash_damage_lower = 1200;
    level.var_666ec6850e612e3d[ 2 ].splash_damage_upper = 3000;
    level.var_666ec6850e612e3d[ 2 ].splash_damage_range = 1800;
    level.var_666ec6850e612e3d[ 2 ].damage_scalar = 3;
    level.var_666ec6850e612e3d[ 3 ] = spawnstruct();
    level.var_666ec6850e612e3d[ 3 ].var_114709d5b68798 = 5000;
    level.var_666ec6850e612e3d[ 3 ].splash_damage_lower = 2400;
    level.var_666ec6850e612e3d[ 3 ].splash_damage_upper = 5000;
    level.var_666ec6850e612e3d[ 3 ].splash_damage_range = 2600;
    level.var_666ec6850e612e3d[ 3 ].damage_scalar = 5;
    level.var_666ec6850e612e3d[ 4 ] = spawnstruct();
    level.var_666ec6850e612e3d[ 4 ].var_114709d5b68798 = 7000;
    level.var_666ec6850e612e3d[ 4 ].splash_damage_lower = 3200;
    level.var_666ec6850e612e3d[ 4 ].splash_damage_upper = 7000;
    level.var_666ec6850e612e3d[ 4 ].splash_damage_range = 3800;
    level.var_666ec6850e612e3d[ 4 ].damage_scalar = 7;
}

// Namespace weap_raygun
// Params 7
// Checksum 0x28a00335, Offset: 0x4f6
// Size: 0x6a
function function_95c07e7203ddaa26( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon )
{
    if ( ( smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" ) && victim == eattacker )
    {
        return 15;
    }
    
    return idamage;
}

// Namespace weap_raygun
// Params 1
// Checksum 0x3462baad, Offset: 0x568
// Size: 0x272
function function_23de2810dc858a9c( dmg_struct )
{
    if ( dmg_struct.smeansofdeath == "MOD_MELEE" )
    {
        return dmg_struct.idamage;
    }
    
    if ( self.aicategory == "boss" )
    {
        dmg_struct.idamage *= 0.1;
        return dmg_struct.idamage;
    }
    
    var_951c89546ec50477 = undefined;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
    {
        if ( isdefined( dmg_struct.eattacker ) )
        {
            var_951c89546ec50477 = dmg_struct.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( dmg_struct.objweapon );
        }
    }
    
    if ( !isdefined( var_951c89546ec50477 ) || var_951c89546ec50477 == 0 )
    {
        return dmg_struct.idamage;
    }
    
    assert( isdefined( level.var_666ec6850e612e3d[ var_951c89546ec50477 ] ), "<dev string:x24>" + var_951c89546ec50477 + "<dev string:x39>" );
    
    if ( dmg_struct.smeansofdeath == "MOD_PROJECTILE" )
    {
        var_2506b2baa00de6c3 = dmg_struct.idamage - level.var_666ec6850e612e3d[ var_951c89546ec50477 ].var_114709d5b68798;
        splash_damage_modified = ( var_2506b2baa00de6c3 / level.var_666ec6850e612e3d[ var_951c89546ec50477 ].damage_scalar - level.var_666ec6850e612e3d[ 0 ].splash_damage_lower ) / level.var_666ec6850e612e3d[ 0 ].splash_damage_range * level.var_666ec6850e612e3d[ var_951c89546ec50477 ].splash_damage_range + level.var_666ec6850e612e3d[ var_951c89546ec50477 ].splash_damage_lower;
        return ( splash_damage_modified + level.var_666ec6850e612e3d[ var_951c89546ec50477 ].var_114709d5b68798 );
    }
    else if ( dmg_struct.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        splash_damage_modified = ( dmg_struct.idamage / level.var_666ec6850e612e3d[ var_951c89546ec50477 ].damage_scalar - level.var_666ec6850e612e3d[ 0 ].splash_damage_lower ) / level.var_666ec6850e612e3d[ 0 ].splash_damage_range * level.var_666ec6850e612e3d[ var_951c89546ec50477 ].splash_damage_range + level.var_666ec6850e612e3d[ var_951c89546ec50477 ].splash_damage_lower;
        return splash_damage_modified;
    }
    
    return dmg_struct.idamage;
}

