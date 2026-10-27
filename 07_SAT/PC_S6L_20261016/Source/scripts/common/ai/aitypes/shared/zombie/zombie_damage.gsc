// scripts\common\ai\aitypes\shared\zombie\zombie_damage.gsc  (hash_6ed201c5af7d130e.gscc) (size: 28466 Bytes / 0x6f32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e3b7fe0 (2386264032)
// size ...... 28466 (0x6f32)
// includes .. 16  (offset: 0x69ee)
// strings ... 76  (offset: 0x6a6e)
// dev strs .. 6   (offset: 0x6eea)
// exports ... 60  (offset: 0x4f7a)
// cseg ...... 0x5b7 + 0x49c3 (0x4f7a)
// imports ... 137 (offset: 0x58da)
// animtree1 . 0   (offset: 0x6f32)
// animtree2 . 0   (offset: 0x6f32)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\status_effects\effect_charm;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;

#namespace zombie_damage;

// Namespace zombie_damage
// Params 0, eflags: 0x1
// Checksum 0x2ebbb84a, Offset: 0x5d5
// Size: 0x278
function autoexec function_654dc558755fa60f()
{
    utility::registersharedfunc( #"zombie_damage", #"builddamagestruct", &function_a3c35706f9e298e );
    utility::registersharedfunc( #"zombie_damage", #"shouldskipdamage", &should_skip_damage );
    utility::registersharedfunc( #"zombie_damage", #"checkdamagedarmor", &check_damaged_armor );
    utility::registersharedfunc( #"zombie_damage", #"checkarmorhitmarker", &check_armor_hitmarker );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamageexposedhead", &function_960f65c8626d199b );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamagearmor", &function_1f965cbbc7f5d5e7 );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamageunderbarrel", &function_b9821f08dcbdc9d0 );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamagerarity", &function_881dfa87252ee0ea );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamagespecific", &function_e06f2d26a28d8093 );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamagemercs", &function_2bf9dd60a4f921ca );
    utility::registersharedfunc( #"zombie_damage", #"hash_db261451b4d687b", &function_87aebf397086e82f );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamagekillcallbacks", &function_23f0f83c55de1ad );
    utility::registersharedfunc( #"zombie_damage", #"hash_5e54d804a8307343", &function_579261f41dfd0572 );
    utility::registersharedfunc( #"zombie_damage", #"hash_77e033ee0b438081", &function_e20f670a9518dbc0 );
    utility::registersharedfunc( #"zombie_damage", #"hash_ae192973716b5437", &function_10e5fc0c6d63f99c );
    utility::registersharedfunc( #"zombie_damage", #"hash_fd3334fda5a6750e", &function_eb7d5e5b35444c8b );
    utility::registersharedfunc( #"zombie_damage", #"damagemetabone", &try_damage_metabone );
    utility::registersharedfunc( #"zombie_damage", #"adjustdamageshield", &function_bccc7eb65bfbb479 );
    utility::registersharedfunc( #"zombie_damage", #"hash_3a2f9b37a2a2d1e2", &function_9238df0f5f57170a );
    utility::registersharedfunc( #"zombie_damage", #"hash_854b475a5070719a", &function_2a4a7ff773fb9d07 );
    utility::registersharedfunc( #"zombie_damage", #"hash_5c15fd29ca6d7906", &function_85e93f8d55a27ac4 );
}

// Namespace zombie_damage
// Params 1
// Checksum 0xf87f5a7a, Offset: 0x855
// Size: 0xa1
function function_a3c35706f9e298e( params )
{
    return build_damage_struct( params.einflictor, params.eattacker, params.idamage, params.idflags, params.smeansofdeath, params.sweapon, params.vpoint, params.vdir, params.shitloc, params.timeoffset, params.modelindex, params.partname, params.objweapon );
}

// Namespace zombie_damage
// Params 13
// Checksum 0x40e5cf51, Offset: 0x8ff
// Size: 0x21e
function build_damage_struct( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.eattacker = eattacker;
    dmg_struct.idamage = idamage;
    dmg_struct.idflags = idflags;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.sweapon = sweapon;
    dmg_struct.vpoint = vpoint;
    dmg_struct.vdir = vdir;
    dmg_struct.shitloc = shitloc;
    dmg_struct.timeoffset = timeoffset;
    dmg_struct.modelindex = modelindex;
    dmg_struct.partname = partname;
    dmg_struct.objweapon = objweapon;
    dmg_struct.biscritical = 0;
    dmg_struct.var_4f9d5587bf9a2b1e = 0;
    dmg_struct.var_ff33243f5be1fe3b = function_802d419e92379eb3();
    dmg_struct.timehit = gettime();
    
    if ( metabone::function_83525a0b05843168() )
    {
        dmg_struct.metabonename = metabone::function_b7f4a00525689bee( dmg_struct );
    }
    else
    {
        dmg_struct.metabonename = metabone::get_metabone_name( shitloc, partname, vpoint, vdir );
        
        if ( is_explosive_damage( smeansofdeath ) && !isdefined( dmg_struct.metabonename ) )
        {
            var_d906f3558dfa031f = metabone::function_30d906ccb9fe2142( "Types_Armor" );
            
            if ( var_d906f3558dfa031f.size > 0 )
            {
                dmg_struct.metabonename = utility::array_random( var_d906f3558dfa031f );
            }
        }
    }
    
    if ( metabone::function_3866ce438fcee825() )
    {
        dmg_struct.forcecrit = metabone::function_d985a5fbf5939161( dmg_struct );
    }
    
    return dmg_struct;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xb4e46e5f, Offset: 0xb26
// Size: 0x35, Type: bool
function is_explosive_damage( smeansofdeath )
{
    if ( !isdefined( smeansofdeath ) )
    {
        return false;
    }
    
    return smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH";
}

// Namespace zombie_damage
// Params 3
// Checksum 0x5480bfe2, Offset: 0xb64
// Size: 0xc1, Type: bool
function should_skip_damage( eattacker, objweapon, smeansofdeath )
{
    attacker_team = eattacker.owner.team ?? eattacker.team;
    
    if ( !eattacker.allowfriendlyfire && self.team == attacker_team )
    {
        return true;
    }
    
    if ( eattacker == self && status_effects::has_status_effect_type( "charm" ) )
    {
        return true;
    }
    
    if ( self.b_skip_trigger_hurt_damage && smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        return true;
    }
    
    if ( self.var_a9e9679c0535fe1b )
    {
        eattacker namespace_9d8e359c3b1041e5::updateDamageFeedback_SharedFunc( "hitimmune" );
        return true;
    }
    
    return false;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xaef498d6, Offset: 0xc2e
// Size: 0x5a3
function handle_status_effects( dmg_struct )
{
    var_5e5a2456deacd236 = get_element( dmg_struct.objweapon, dmg_struct.eattacker, dmg_struct.smeansofdeath, dmg_struct.einflictor );
    statuseffecttype = get_status_effect( dmg_struct );
    statuseffectonimpact = function_e1bf6f05865e63f8( dmg_struct.objweapon );
    meansofdeath = dmg_struct.smeansofdeath;
    var_a7141b4927be63bf = 0;
    
    if ( zombie_utils::function_bf1464d09f4e4b40() && isplayer( dmg_struct.eattacker ) )
    {
        var_a7141b4927be63bf = 1;
    }
    
    if ( meansofdeath == "MOD_IMPACT" && !statuseffectonimpact )
    {
        return var_5e5a2456deacd236;
    }
    
    if ( !var_a7141b4927be63bf && isdefined( statuseffecttype ) && statuseffecttype != "none" )
    {
        duration = get_status_duration( dmg_struct.objweapon );
        var_8d2325a3c1b80415 = get_status_damage_percent( dmg_struct.objweapon );
        tick = get_status_tick( dmg_struct.objweapon );
        var_af36bda453df2d8e = function_3f46ef04c082496b( dmg_struct.objweapon );
        
        switch ( statuseffecttype )
        {
            case #"hash_23f2c68a2fc41281":
                effect_stun::stun( dmg_struct.objweapon.basename, duration, dmg_struct.eattacker, "stunned_on", undefined, var_5e5a2456deacd236 );
                self.var_1c715bf5ac0aa638 = dmg_struct.vpoint;
                break;
            case #"hash_e8f0758a10ec7618":
                effect_slow::slow( dmg_struct.objweapon.basename, tick, duration, dmg_struct.eattacker, undefined, 0, var_5e5a2456deacd236 );
                break;
            case #"hash_185c93a22da79530":
                effect_charm::charm( duration, dmg_struct.eattacker, undefined, var_5e5a2456deacd236 );
                break;
            case #"hash_ab2e692ee80521f8":
                isdragonsbreath = function_7616e0b62f4d6337( dmg_struct );
                uniqueid = dmg_struct.objweapon.basename ?? "weapon_burn";
                var_544477e253154482 = 0;
                
                if ( isdragonsbreath && !self.var_183f4d5d5cc70f29 )
                {
                    uniqueid = "dragonsbreath";
                    
                    if ( getdvarint( @"hash_666ee7d4e70b4c1c", 0 ) && meansofdeath != "MOD_UNKNOWN" )
                    {
                        duration = level.weaponmetadata[ "dragonbreath_settings" ].dragonbreathduration;
                        tick = level.weaponmetadata[ "dragonbreath_settings" ].var_777d257be1a4bbc8;
                        var_951c89546ec50477 = 0;
                        
                        if ( dmg_struct.eattacker )
                        {
                            var_951c89546ec50477 = dmg_struct.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( dmg_struct.objweapon );
                        }
                        
                        if ( var_951c89546ec50477 > 0 )
                        {
                            switch ( var_951c89546ec50477 )
                            {
                                case 1:
                                    pap_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_731ad3a238456f7a;
                                    break;
                                case 2:
                                    pap_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_731ad2a238456d47;
                                    break;
                                case 3:
                                    pap_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_731ad1a238456b14;
                                    break;
                                case 4:
                                    pap_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_731ad0a2384568e1;
                                    break;
                            }
                        }
                        else
                        {
                            pap_damage = level.weaponmetadata[ "dragonbreath_settings" ].dragonbreathdamage;
                        }
                        
                        rarity_damage = 1;
                        
                        if ( isplayer( dmg_struct.eattacker ) )
                        {
                            rarity = dmg_struct.eattacker function_af20e81da38c49bc( dmg_struct.objweapon );
                            
                            switch ( rarity )
                            {
                                case #"hash_1393412d7401c646":
                                    rarity_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_1a184b016fc08792;
                                    break;
                                case #"hash_883ff07272b4f9c":
                                    rarity_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_794b911765c9a6db;
                                    break;
                                case #"hash_778bb52ecd08072d":
                                    rarity_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_3d9a237b6a338282;
                                    break;
                                case #"hash_598a30e44f53045f":
                                    rarity_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_dbea0094be1481d3;
                                    break;
                                case #"hash_35bb3bd014c77f4b":
                                    rarity_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_fd572e316130fca1;
                                    break;
                                case #"hash_2ac407c1cd5943a9":
                                    rarity_damage = level.weaponmetadata[ "dragonbreath_settings" ].var_e87ad34435a5d344;
                                    break;
                            }
                        }
                        
                        damage = rarity_damage * pap_damage;
                    }
                }
                else
                {
                    var_544477e253154482 = 1;
                    damage = var_8d2325a3c1b80415;
                }
                
                if ( isalive( self ) && dmg_struct.smeansofdeath != "MOD_UNKNOWN" )
                {
                    effect_burn::burn( duration, damage, tick, dmg_struct.eattacker, uniqueid, var_af36bda453df2d8e, dmg_struct.einflictor, var_5e5a2456deacd236, 1, dmg_struct.objweapon, var_544477e253154482, 1, 1 );
                }
                
                break;
        }
    }
    
    return var_5e5a2456deacd236;
}

// Namespace zombie_damage
// Params 4
// Checksum 0xfe60b9d2, Offset: 0x11da
// Size: 0x1f1
function get_element( objweapon, eattacker, smeansofdeath, einflictor = undefined )
{
    element = "none";
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    blueprint_element = objweapon.weaponblueprint.var_9a7975cd0d0f0d6;
    
    if ( isplayer( eattacker ) && level.ammo_mods_in_use && eattacker namespace_9d8e359c3b1041e5::function_f3b72bf1c0b8c737( objweapon, einflictor ) )
    {
        ammomod_name = eattacker namespace_9d8e359c3b1041e5::function_30cd19b8533d27d2( objweapon, einflictor );
        
        if ( isdefined( level.ammo_mods[ ammomod_name ].element ) )
        {
            element = level.ammo_mods[ ammomod_name ].element;
        }
        
        if ( isdefined( blueprint_element ) )
        {
            if ( element == "none" || isdefined( self.elementalweakness ) && self.elementalweakness[ blueprint_element ] && !self.elementalweakness[ element ] )
            {
                element = blueprint_element;
            }
        }
    }
    else
    {
        weaponbundle = undefined;
        
        if ( isdefined( level.weaponmetadata ) )
        {
            weaponbundle = level.weaponmetadata[ root_weapon_string ];
        }
        
        if ( isdefined( weaponbundle.elementdamagetype ) )
        {
            element = weaponbundle.elementdamagetype;
        }
        
        if ( isdefined( blueprint_element ) )
        {
            element = blueprint_element;
        }
    }
    
    if ( isdefined( smeansofdeath ) )
    {
        if ( smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_ELEMENTAL_FIRE" )
        {
            element = "fire";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_ELEC" )
        {
            element = "electrical";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_COLD" )
        {
            element = "cold";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_TOXIC" )
        {
            element = "toxic";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_DARK" )
        {
            element = "dark";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_LIGHT" )
        {
            element = "light";
        }
    }
    
    return element;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x1375b655, Offset: 0x13d4
// Size: 0x62, Type: bool
function function_e1bf6f05865e63f8( objweapon )
{
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    weaponbundle = undefined;
    
    if ( isdefined( level.weaponmetadata ) )
    {
        weaponbundle = level.weaponmetadata[ root_weapon_string ];
    }
    
    if ( isdefined( weaponbundle ) && weaponbundle.statuseffectonimpact )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xd2c935ba, Offset: 0x143f
// Size: 0xea, Type: bool
function function_7616e0b62f4d6337( dmg_struct )
{
    objweapon = dmg_struct.objweapon;
    smeansofdeath = dmg_struct.smeansofdeath;
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        return false;
    }
    
    if ( smeansofdeath == "MOD_ELEMENTAL_FIRE" )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_666ee7d4e70b4c1c", 0 ) )
    {
        if ( utility::issharedfuncdefined( #"dragonsbreath", #"hash_b3b9e769b19108fd" ) )
        {
            if ( utility::callsharedfunc( #"dragonsbreath", #"hash_b3b9e769b19108fd", objweapon ) )
            {
                return true;
            }
        }
        else if ( isdefined( objweapon.modifier ) && issubstr( objweapon.modifier, "_db_" ) || getweaponhasperk( objweapon, "specialty_ub_flamethrower" ) && objweapon.isalternate )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x50339550, Offset: 0x1532
// Size: 0x9d
function get_status_effect( dmg_struct )
{
    objweapon = dmg_struct.objweapon;
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    weaponbundle = undefined;
    
    if ( isdefined( level.weaponmetadata ) )
    {
        weaponbundle = level.weaponmetadata[ root_weapon_string ];
    }
    
    effect = "none";
    
    if ( isdefined( weaponbundle.statuseffecttype ) )
    {
        effect = weaponbundle.statuseffecttype;
    }
    
    if ( function_7616e0b62f4d6337( dmg_struct ) )
    {
        effect = "burn";
    }
    
    return effect;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xa2190c82, Offset: 0x15d8
// Size: 0x62
function get_status_duration( objweapon )
{
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    weaponbundle = level.weaponmetadata[ root_weapon_string ];
    duration = 0;
    
    if ( isdefined( weaponbundle.statuseffectduration ) )
    {
        duration = weaponbundle.statuseffectduration;
    }
    
    return duration;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x67876ecf, Offset: 0x1643
// Size: 0x68
function get_status_damage_percent( objweapon )
{
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    weaponbundle = level.weaponmetadata[ root_weapon_string ];
    var_8d2325a3c1b80415 = 0;
    
    if ( isdefined( weaponbundle.statuseffectdamage ) )
    {
        var_8d2325a3c1b80415 = weaponbundle.statuseffectdamage / 100;
    }
    
    return var_8d2325a3c1b80415;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x2025f8bd, Offset: 0x16b4
// Size: 0x62
function get_status_tick( objweapon )
{
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    weaponbundle = level.weaponmetadata[ root_weapon_string ];
    tick = 0;
    
    if ( isdefined( weaponbundle.statuseffecttick ) )
    {
        tick = weaponbundle.statuseffecttick;
    }
    
    return tick;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x39dbd01f, Offset: 0x171f
// Size: 0x44
function function_3f46ef04c082496b( objweapon )
{
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    weaponbundle = level.weaponmetadata[ root_weapon_string ];
    return weaponbundle.var_484d08002b62439;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xeeedd480, Offset: 0x176c
// Size: 0x12b
function function_40c3998760e0b954( dmg_struct )
{
    damage = dmg_struct.idamage;
    var_13518fb33ec73cc = self.var_13518fb33ec73cc;
    
    if ( ( dmg_struct.idflags & 2147483648 ) > 0 )
    {
        round_difficulty = var_13518fb33ec73cc ?? namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        damage *= base_zombie_maxhealth;
        dmg_struct.idflags &= ~2147483648;
    }
    else if ( ( dmg_struct.idflags & 1073741824 ) > 0 )
    {
        if ( isdefined( var_13518fb33ec73cc ) )
        {
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            var_d7bb797536e48a72 = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            var_25150c622a55e40 = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", var_13518fb33ec73cc );
            damage *= var_25150c622a55e40 / var_d7bb797536e48a72;
        }
        
        dmg_struct.idflags &= ~1073741824;
    }
    
    return damage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xceecd187, Offset: 0x18a0
// Size: 0x63
function function_cef159ba09a96f98( dmg_struct )
{
    if ( ( dmg_struct.idflags & 1073741824 ) <= 0 )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_8a860cb98efd603a" ) )
        {
            return utility::callsharedfunc( #"zombie", #"hash_8a860cb98efd603a", dmg_struct );
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x837bff19, Offset: 0x190c
// Size: 0xd5
function function_e01c2c6191f04821( dmg_struct )
{
    if ( ( dmg_struct.idflags & 137438953472 ) <= 0 )
    {
        owner = dmg_struct.eattacker.var_bd22ba6c600a23a3;
        
        if ( isplayer( owner ) && owner.brainrot_damage_multiplier )
        {
            dealt_damage = dmg_struct.eattacker.var_cab75db7e9e5b64c ?? dmg_struct.idamage;
            return ( dealt_damage * owner.brainrot_damage_multiplier );
        }
        
        if ( isdefined( dmg_struct.eattacker.var_cab75db7e9e5b64c ) )
        {
            return dmg_struct.eattacker.var_cab75db7e9e5b64c;
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x7aa66d88, Offset: 0x19ea
// Size: 0x288
function function_5fc0f527cde63905( dmg_struct )
{
    gunbutt = !dmg_struct.sweapon.ismelee && dmg_struct.smeansofdeath === "MOD_MELEE";
    elementtype = dmg_struct.var_5e5a2456deacd236;
    eattacker = dmg_struct.eattacker;
    is_bgb_override = isplayer( eattacker ) && eattacker utility::callsharedfunc( #"bgb", #"is_enabled", "elementary" );
    
    if ( isplayer( eattacker ) && ( eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_rainbow_pop" ) || is_bgb_override ) )
    {
        w_current = eattacker getcurrentweapon();
        
        if ( eattacker namespace_9d8e359c3b1041e5::function_f3b72bf1c0b8c737( w_current ) && w_current == dmg_struct.sweapon || is_bgb_override )
        {
            chance = level.zombie_augments[ #"elemental_pop_rainbow_pop" ].var_5c7cbab055e56fa3 ?? 0.5;
            chance *= 100;
            
            if ( is_bgb_override )
            {
                chance = 100;
            }
            
            if ( utility::percent_chance( chance ) )
            {
                foreach ( var_811808a0b6413d21, elemental_weakness in self.elementalweakness )
                {
                    elementtype = var_811808a0b6413d21;
                    break;
                }
                
                eattacker.var_525de68277d988e5 = elementtype;
            }
        }
    }
    
    if ( !gunbutt && isarray( self.elementalweakness ) && self.elementalweakness[ elementtype ] && elementtype != "none" )
    {
        var_46876de127afad77 = 1.5;
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_c79aa134f08a6b6a" ) )
        {
            if ( isdefined( eattacker ) )
            {
                var_19d30c60c2997876 = eattacker utility::callsharedfunc( #"zombie", #"hash_c79aa134f08a6b6a" );
                
                if ( var_19d30c60c2997876 > 0 )
                {
                    var_46876de127afad77 = var_19d30c60c2997876;
                }
            }
        }
        
        return ( dmg_struct.idamage * var_46876de127afad77 );
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xbeb3b67, Offset: 0x1c7b
// Size: 0x19c
function function_2bf9dd60a4f921ca( dmg_struct )
{
    agent = dmg_struct.eattacker;
    isheadshot = dmg_struct.smeansofdeath == "MOD_HEAD_SHOT";
    
    if ( isagent( agent ) && agent.type == "human" )
    {
        if ( isheadshot && isdefined( agent.var_9e3471b72f72f196 ) )
        {
            dmg_struct.idamage *= agent.var_9e3471b72f72f196;
        }
        else if ( !isheadshot && isdefined( agent.var_3761ee502c4a6baa ) )
        {
            dmg_struct.idamage *= agent.var_3761ee502c4a6baa;
        }
        
        if ( isdefined( agent.var_1cabc40f1f97e378 ) && dmg_struct.smeansofdeath == "MOD_MELEE" && issubstr( agent.agent_type, "shielded" ) )
        {
            dmg_struct.idamage *= agent.var_1cabc40f1f97e378;
        }
        else if ( isdefined( agent.var_c87430f3a1036549 ) && dmg_struct.smeansofdeath == "MOD_MELEE" && issubstr( agent.agent_type, "schematic_soldier_buddy" ) )
        {
            dmg_struct.idamage *= agent.var_c87430f3a1036549;
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x29b73023, Offset: 0x1e20
// Size: 0x299
function function_23f0f83c55de1ad( dmg_struct )
{
    adjusteddamage = dmg_struct.idamage;
    assert( isdefined( adjusteddamage ) );
    
    if ( isarray( level.var_f3f3b4d926db02c7 ) )
    {
        for ( var_1cc7f3cdaac35cf7 = 0; var_1cc7f3cdaac35cf7 < level.var_f3f3b4d926db02c7.size ; var_1cc7f3cdaac35cf7++ )
        {
            func = level.var_f3f3b4d926db02c7[ var_1cc7f3cdaac35cf7 ];
            new_damage = self [[ func ]]( dmg_struct );
            function_f7dee2255370a93e( func, new_damage );
            
            if ( isdefined( new_damage ) && new_damage >= 0 )
            {
                dmg_struct.idamage = new_damage;
                adjusteddamage = new_damage;
            }
        }
    }
    
    if ( isarray( self.var_f3f3b4d926db02c7 ) )
    {
        for ( var_1cc7f3cdaac35cf7 = 0; var_1cc7f3cdaac35cf7 < self.var_f3f3b4d926db02c7.size ; var_1cc7f3cdaac35cf7++ )
        {
            func = self.var_f3f3b4d926db02c7[ var_1cc7f3cdaac35cf7 ];
            new_damage = self [[ func ]]( dmg_struct );
            function_f7dee2255370a93e( func, new_damage );
            
            if ( isdefined( new_damage ) && new_damage >= 0 )
            {
                dmg_struct.idamage = new_damage;
                adjusteddamage = new_damage;
            }
        }
    }
    
    if ( isplayer( dmg_struct.eattacker ) && isarray( dmg_struct.eattacker.var_f3f3b4d926db02c7 ) )
    {
        for ( var_1cc7f3cdaac35cf7 = 0; var_1cc7f3cdaac35cf7 < dmg_struct.eattacker.var_f3f3b4d926db02c7.size ; var_1cc7f3cdaac35cf7++ )
        {
            func = dmg_struct.eattacker.var_f3f3b4d926db02c7[ var_1cc7f3cdaac35cf7 ];
            new_damage = self [[ func ]]( dmg_struct );
            function_f7dee2255370a93e( func, new_damage );
            
            if ( isdefined( new_damage ) && new_damage >= 0 )
            {
                dmg_struct.idamage = new_damage;
                adjusteddamage = new_damage;
            }
        }
    }
    
    if ( isdefined( dmg_struct.sweapon ) )
    {
        weapon_basename = dmg_struct.sweapon.basename;
        
        if ( isarray( level.var_ad4a0c0e90a75e96 ) )
        {
            func = level.var_ad4a0c0e90a75e96[ weapon_basename ];
            
            if ( isdefined( func ) )
            {
                new_damage = self [[ func ]]( dmg_struct );
                function_f7dee2255370a93e( func, new_damage );
                
                if ( isdefined( new_damage ) && new_damage >= 0 )
                {
                    dmg_struct.idamage = new_damage;
                    adjusteddamage = new_damage;
                }
            }
        }
        
        if ( isarray( self.var_ad4a0c0e90a75e96 ) )
        {
            func = self.var_ad4a0c0e90a75e96[ weapon_basename ];
            
            if ( isdefined( func ) )
            {
                new_damage = self [[ func ]]( dmg_struct );
                function_f7dee2255370a93e( func, new_damage );
                
                if ( isdefined( new_damage ) && new_damage >= 0 )
                {
                    dmg_struct.idamage = new_damage;
                    adjusteddamage = new_damage;
                }
            }
        }
    }
    
    return adjusteddamage;
}

// Namespace zombie_damage
// Params 2, eflags: 0x4
// Checksum 0xb878bc0d, Offset: 0x20c2
// Size: 0x5b
function private function_f7dee2255370a93e( func, damage )
{
    if ( !isdefined( damage ) || damage < 0 && damage != -1 )
    {
        msg = "[Zombie Damage] Invalid damage: " + damage + " from function: " + func;
        logstring( msg );
        assertmsg( msg );
    }
}

// Namespace zombie_damage
// Params 1
// Checksum 0x7f551215, Offset: 0x2125
// Size: 0x156
function try_damage_metabone( dmg_struct )
{
    if ( self.damageshield )
    {
        return;
    }
    
    if ( isdefined( dmg_struct.metabonename ) )
    {
        var_20049f434bd68701 = dmg_struct.idamage;
        
        if ( dmg_struct.var_4f9d5587bf9a2b1e && isplayer( dmg_struct.eattacker ) && utility::issharedfuncdefined( #"zombie", #"hash_dcff2d0c4d9b34ce" ) )
        {
            var_20049f434bd68701 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"hash_dcff2d0c4d9b34ce", var_20049f434bd68701 );
        }
        
        b_destroyed = metabone::damage_metabone( dmg_struct.metabonename, var_20049f434bd68701, dmg_struct.eattacker, dmg_struct.einflictor, dmg_struct.vdir );
        
        if ( dmg_struct.var_4f9d5587bf9a2b1e && isdefined( self.modifiedidflags ) )
        {
            self.modifiedidflags |= 512;
            
            if ( b_destroyed )
            {
                self.modifiedidflags |= 1024;
                thread trigger_armorbreak_hitmarker( dmg_struct.eattacker, dmg_struct.var_4f9d5587bf9a2b1e, dmg_struct.metabonename );
            }
        }
    }
}

// Namespace zombie_damage
// Params 1
// Checksum 0xf2a8fe24, Offset: 0x2283
// Size: 0x22a
function function_881dfa87252ee0ea( dmg_struct )
{
    if ( !isdefined( dmg_struct.idflags ) || !( dmg_struct.idflags & 65536 ) )
    {
        eattacker = dmg_struct.eattacker;
        objweapon = dmg_struct.objweapon;
        
        if ( isplayer( eattacker ) && objweapon )
        {
            objweapon = function_2a4a7ff773fb9d07( objweapon, eattacker );
        }
        
        if ( utility::issharedfuncdefined( #"bunkerbuster", #"isbunkerbustergl" ) )
        {
            if ( utility::callsharedfunc( #"bunkerbuster", #"isbunkerbustergl", objweapon ) )
            {
                if ( isdefined( eattacker.var_41d1470f095bbfc8 ) )
                {
                    objweapon = eattacker.var_41d1470f095bbfc8 getnoaltweapon();
                }
            }
        }
        
        if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_d276db87d69299de" ) )
        {
            var_b92817d29e3cb812 = utility::callsharedfunc( #"zombie_damage", #"hash_d276db87d69299de", objweapon, eattacker );
            dmg_struct.idamage *= var_b92817d29e3cb812;
        }
        
        if ( isplayer( eattacker ) )
        {
            rarity = eattacker function_af20e81da38c49bc( objweapon );
            var_b92817d29e3cb812 = function_6786d0923b8261db( objweapon, dmg_struct.smeansofdeath, rarity );
            dmg_struct.idamage *= var_b92817d29e3cb812;
        }
        
        if ( function_b8d8d8bfe4fa2158( objweapon, dmg_struct ) )
        {
            new_damage = utility::callsharedfunc( #"zombie_damage", #"hash_8a5422fcea1951e4", dmg_struct.idamage, objweapon, eattacker );
            
            if ( new_damage && new_damage != -1 )
            {
                dmg_struct.idamage = new_damage;
            }
        }
        else
        {
            var_27e0ee95c282b66c = function_968dcf03f8aacaae( objweapon, dmg_struct.smeansofdeath, eattacker );
            dmg_struct.idamage *= var_27e0ee95c282b66c;
        }
        
        dmg_struct.idamage = function_f618f57aa5bae72a( dmg_struct );
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 2
// Checksum 0xf41736a8, Offset: 0x24b6
// Size: 0xf2
function function_2a4a7ff773fb9d07( objweapon, eattacker )
{
    if ( objweapon.isalternate )
    {
        objweapon = objweapon getnoaltweapon();
    }
    
    weaponrootname = getweaponrootstring( objweapon );
    
    if ( level.var_e1b9ad5126850403[ weaponrootname ] )
    {
        var_a89f9ad30d96ad41 = level.var_e1b9ad5126850403[ weaponrootname ];
        
        foreach ( weapon in eattacker.weaponlist )
        {
            rootname = getweaponrootstring( weapon );
            
            if ( rootname == var_a89f9ad30d96ad41 )
            {
                objweapon = weapon;
                break;
            }
        }
    }
    
    return objweapon;
}

// Namespace zombie_damage
// Params 2, eflags: 0x4
// Checksum 0xcb023647, Offset: 0x25b1
// Size: 0x10a
function private function_b8d8d8bfe4fa2158( objweapon, dmg_struct )
{
    existsfunction = utility::issharedfuncdefined( #"zombie_damage", #"hash_8a5422fcea1951e4" );
    
    if ( !existsfunction )
    {
        return 0;
    }
    
    iskillstreak = weapon::iskillstreakweapon( objweapon );
    
    if ( iskillstreak )
    {
        return 0;
    }
    
    var_d1c259205d70761f = dmg_struct.eattacker.isequipment;
    
    if ( var_d1c259205d70761f )
    {
        return 0;
    }
    
    isweaponequipment = weapon::isweaponequipment( objweapon );
    
    if ( !isweaponequipment )
    {
        return 1;
    }
    else
    {
        var_897afd39d0a1399c = dmg_struct.eattacker.super.weaponobj;
        var_28ad4d962dc90b43 = dmg_struct.eattacker.tacticalsuper.weaponobj;
        issuperweapon = var_897afd39d0a1399c == objweapon || var_28ad4d962dc90b43 == objweapon;
        return issuperweapon;
    }
    
    return 0;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x15c74935, Offset: 0x26c4
// Size: 0xe0
function function_af20e81da38c49bc( objweapon )
{
    var_343a39a8a26818a7 = "white";
    
    if ( objweapon )
    {
        var_d1ad847a3b590336 = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( objweapon );
        
        if ( isdefined( var_d1ad847a3b590336 ) )
        {
            switch ( var_d1ad847a3b590336 )
            {
                case 0:
                    var_343a39a8a26818a7 = "white";
                    break;
                case 1:
                    var_343a39a8a26818a7 = "green";
                    break;
                case 2:
                    var_343a39a8a26818a7 = "blue";
                    break;
                case 3:
                    var_343a39a8a26818a7 = "purple";
                    break;
                case 4:
                    var_343a39a8a26818a7 = "orange";
                    break;
                case 5:
                    var_343a39a8a26818a7 = "yellow";
                    break;
                case 6:
                    var_343a39a8a26818a7 = "red";
                    break;
            }
        }
    }
    
    return var_343a39a8a26818a7;
}

// Namespace zombie_damage
// Params 3
// Checksum 0x2eff9cea, Offset: 0x27ad
// Size: 0x9e
function function_6786d0923b8261db( objweapon, smeansofdeath, rarity )
{
    var_8b2d7f75c0e810a9 = utility::callsharedfunc( #"weapon", #"is_tertiary_weapon_override", objweapon );
    
    if ( smeansofdeath == "MOD_MELEE" && !objweapon.ismelee && !var_8b2d7f75c0e810a9 )
    {
        return 1;
    }
    
    var_b7cbf0415150b077 = function_3be09bd80aadd132( objweapon, rarity );
    var_da5d00e3a8a522c4 = function_64636dac18fcb593( rarity );
    return isnumber( var_b7cbf0415150b077 ) ? var_b7cbf0415150b077 : var_da5d00e3a8a522c4;
}

// Namespace zombie_damage
// Params 2
// Checksum 0x75d8d399, Offset: 0x2854
// Size: 0x1de
function function_3be09bd80aadd132( objweapon, rarity )
{
    switch ( rarity )
    {
        case #"hash_1393412d7401c646":
            if ( isdefined( objweapon.var_192285613ae5c1d3.var_2c3223c008ec28d5 ) )
            {
                return objweapon.var_192285613ae5c1d3.var_2c3223c008ec28d5;
            }
            
            break;
        case #"hash_883ff07272b4f9c":
            if ( isdefined( objweapon.var_192285613ae5c1d3.var_31993b0404457e7b ) )
            {
                return objweapon.var_192285613ae5c1d3.var_31993b0404457e7b;
            }
            
            break;
        case #"hash_778bb52ecd08072d":
            if ( isdefined( objweapon.var_192285613ae5c1d3.var_32a06fdbe7dd754a ) )
            {
                return objweapon.var_192285613ae5c1d3.var_32a06fdbe7dd754a;
            }
            
            break;
        case #"hash_598a30e44f53045f":
            if ( isdefined( objweapon.var_192285613ae5c1d3.var_65467efeff657bac ) )
            {
                return objweapon.var_192285613ae5c1d3.var_65467efeff657bac;
            }
            
            break;
        case #"hash_35bb3bd014c77f4b":
            if ( isdefined( objweapon.var_192285613ae5c1d3.var_624115c7e1aa4478 ) )
            {
                return objweapon.var_192285613ae5c1d3.var_624115c7e1aa4478;
            }
            
            break;
        case #"hash_97430f6c58e61cbc":
            if ( isdefined( objweapon.var_192285613ae5c1d3.var_7d9779d9e7b4db6b ) )
            {
                return objweapon.var_192285613ae5c1d3.var_7d9779d9e7b4db6b;
            }
            
            break;
        case #"hash_2ac407c1cd5943a9":
            if ( isdefined( objweapon.var_192285613ae5c1d3.var_973a085c08a1d4ea ) )
            {
                return objweapon.var_192285613ae5c1d3.var_973a085c08a1d4ea;
            }
            
            break;
        default:
            return;
    }
}

// Namespace zombie_damage
// Params 1
// Checksum 0x2116ba3, Offset: 0x2a3a
// Size: 0x17d
function function_64636dac18fcb593( rarity )
{
    var_9eeac31b76fd859d = 1;
    
    if ( isdefined( level.weaponmetadata ) )
    {
        switch ( rarity )
        {
            case #"hash_1393412d7401c646":
            default:
                var_9eeac31b76fd859d = level.weaponmetadata[ "rarity_settings" ].var_92f45d84303abef2 ?? 1;
                break;
            case #"hash_883ff07272b4f9c":
                var_9eeac31b76fd859d = level.weaponmetadata[ "rarity_settings" ].var_2550ce6fe8f5f078 ?? 1.25;
                break;
            case #"hash_778bb52ecd08072d":
                var_9eeac31b76fd859d = level.weaponmetadata[ "rarity_settings" ].var_5a183b53e6638a8f ?? 1.5;
                break;
            case #"hash_598a30e44f53045f":
                var_9eeac31b76fd859d = level.weaponmetadata[ "rarity_settings" ].var_479d2715b4197011 ?? 1.75;
                break;
            case #"hash_35bb3bd014c77f4b":
                var_9eeac31b76fd859d = level.weaponmetadata[ "rarity_settings" ].var_39165759050c65f5 ?? 2;
                break;
            case #"hash_97430f6c58e61cbc":
                var_9eeac31b76fd859d = level.weaponmetadata[ "rarity_settings" ].var_1cee31acf45cd3e8 ?? 2.25;
                break;
            case #"hash_2ac407c1cd5943a9":
                break;
        }
    }
    
    return var_9eeac31b76fd859d;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x597610d2, Offset: 0x2bc0
// Size: 0xf4
function function_b61c9fb801149e7c( var_951c89546ec50477 )
{
    var_6fab33bbf1ca1428 = 1;
    
    if ( isdefined( var_951c89546ec50477 ) )
    {
        switch ( var_951c89546ec50477 )
        {
            case 1:
                var_6fab33bbf1ca1428 = level.weaponmetadata[ "pap_settings" ].var_7d839c8d6b962468 ?? 2;
                break;
            case 2:
                var_6fab33bbf1ca1428 = level.weaponmetadata[ "pap_settings" ].var_77a38153acdfba05 ?? 2.5;
                break;
            case 3:
                var_6fab33bbf1ca1428 = level.weaponmetadata[ "pap_settings" ].var_23ec616b8fded652 ?? 3;
                break;
            case 4:
                var_6fab33bbf1ca1428 = level.weaponmetadata[ "pap_settings" ].var_ec149227ba79bc67 ?? 4;
                break;
        }
    }
    
    return var_6fab33bbf1ca1428;
}

// Namespace zombie_damage
// Params 2
// Checksum 0x4c8b461b, Offset: 0x2cbd
// Size: 0x1f1
function function_dcee44724d9edddd( objweapon, var_951c89546ec50477 )
{
    var_2e08e94c9cb1747c = objweapon.var_1616e6fbba9a722d;
    var_5b3d437e33a1c935 = undefined;
    
    switch ( var_951c89546ec50477 )
    {
        case 1:
            if ( isdefined( objweapon.var_9bcd339f8886ba09.var_4a86dfc10defb0eb ) )
            {
                return objweapon.var_9bcd339f8886ba09.var_4a86dfc10defb0eb;
            }
            
            break;
        case 2:
            if ( isdefined( objweapon.var_9bcd339f8886ba09.var_7de2bfbb7e8a0508 ) )
            {
                return objweapon.var_9bcd339f8886ba09.var_7de2bfbb7e8a0508;
            }
            
            break;
        case 3:
            if ( isdefined( objweapon.var_9bcd339f8886ba09.var_89325e970f236b5 ) )
            {
                return objweapon.var_9bcd339f8886ba09.var_89325e970f236b5;
            }
            
            break;
        case 4:
            if ( isdefined( objweapon.var_9bcd339f8886ba09.var_9d7832eac1af3ed2 ) )
            {
                return objweapon.var_9bcd339f8886ba09.var_9d7832eac1af3ed2;
            }
            
            break;
    }
    
    if ( isdefined( level.weaponmetadata[ var_2e08e94c9cb1747c ] ) )
    {
        switch ( var_951c89546ec50477 )
        {
            case 1:
                var_5b3d437e33a1c935 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_ac146f11cae40f98;
                break;
            case 2:
                var_5b3d437e33a1c935 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_c4c8f234a781c67d;
                break;
            case 3:
                var_5b3d437e33a1c935 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_ce0f5d5d8aa3ad5e;
                break;
            case 4:
                var_5b3d437e33a1c935 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_8d5c35acf7442453;
                break;
        }
    }
    
    return var_5b3d437e33a1c935;
}

// Namespace zombie_damage
// Params 3
// Checksum 0xc89c86a2, Offset: 0x2eb7
// Size: 0xf3
function function_968dcf03f8aacaae( objweapon, smeansofdeath, player )
{
    if ( !isplayer( player ) )
    {
        return 1;
    }
    
    var_8b2d7f75c0e810a9 = player utility::callsharedfunc( #"weapon", #"is_tertiary_weapon_override", objweapon );
    
    if ( smeansofdeath == "MOD_MELEE" && !objweapon.ismelee && !var_8b2d7f75c0e810a9 )
    {
        return 1;
    }
    
    var_eb93c8b47f055f23 = 1;
    var_951c89546ec50477 = undefined;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
    {
        var_951c89546ec50477 = player namespace_9d8e359c3b1041e5::function_1d4087075103b248( objweapon );
    }
    
    if ( isdefined( var_951c89546ec50477 ) )
    {
        var_43ed2f0ac3ccd3e8 = function_dcee44724d9edddd( objweapon, var_951c89546ec50477 );
        var_9a2aa3c33ee4bd25 = function_b61c9fb801149e7c( var_951c89546ec50477 );
        
        if ( isdefined( var_43ed2f0ac3ccd3e8 ) )
        {
            var_eb93c8b47f055f23 = var_43ed2f0ac3ccd3e8;
        }
        else
        {
            var_eb93c8b47f055f23 = var_9a2aa3c33ee4bd25;
        }
    }
    
    return var_eb93c8b47f055f23;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x46f4092e, Offset: 0x2fb3
// Size: 0x86
function check_critical_kill( dmg_struct )
{
    if ( dmg_struct.idamage >= self.health && !dmg_struct.biscritical && isdefined( dmg_struct.metabonename ) && is_critical_allowed( dmg_struct ) )
    {
        var_acce083aee0fa46b = metabone::get_metabone_metadata( dmg_struct.metabonename, "Types_Weakspot" );
        
        if ( isdefined( var_acce083aee0fa46b ) )
        {
            dmg_struct.biscritical = 1;
        }
    }
}

// Namespace zombie_damage
// Params 1, eflags: 0x4
// Checksum 0x457da1b9, Offset: 0x3041
// Size: 0x6d
function private is_critical_allowed( dmg_struct )
{
    if ( dmg_struct.smeansofdeath == "MOD_MELEE" && !level.gamemodebundle.var_a6ddfde4d8752843 )
    {
        return;
    }
    
    return dmg_struct.forcecrit || isplayer( dmg_struct.eattacker ) && !dmg_struct.objweapon weapon::function_ebf195b764552e41();
}

// Namespace zombie_damage
// Params 1
// Checksum 0xe1145f3f, Offset: 0x30b7
// Size: 0x35c
function function_f618f57aa5bae72a( dmg_struct )
{
    if ( !is_critical_allowed( dmg_struct ) )
    {
        return dmg_struct.idamage;
    }
    
    if ( isdefined( dmg_struct.metabonename ) )
    {
        var_acce083aee0fa46b = metabone::get_metabone_metadata( dmg_struct.metabonename, "Types_Weakspot" );
        
        if ( isdefined( var_acce083aee0fa46b ) )
        {
            /#
                if ( !getdvarint( @"hash_2cbf00f3fb539237", 1 ) )
                {
                    iprintln( "<dev string:x24>" + dmg_struct.metabonename );
                }
            #/
            
            dmg_struct.biscritical = 1;
        }
    }
    
    if ( dmg_struct.eattacker.var_81dcc244c7c4591e )
    {
        dmg_struct.eattacker.var_81dcc244c7c4591e = undefined;
        
        if ( self.aicategory != "boss" )
        {
            dmg_struct.biscritical = 1;
        }
    }
    
    if ( dmg_struct.biscritical )
    {
        if ( isdefined( self._blackboard ) )
        {
            self._blackboard.var_d922503bad49d017 = gettime();
        }
        
        var_25ebc911e358603c = 0;
        
        if ( isdefined( dmg_struct.idflags ) && dmg_struct.idflags & 262144 )
        {
            weapondamagetype = 2;
        }
        else
        {
            weapondamagetype = 0;
        }
        
        var_ea007afa6a78065 = 1;
        
        if ( !self.var_bfa7ca2a8740bf7b )
        {
            gunbutt = !( isweapon( dmg_struct.objweapon ) && dmg_struct.objweapon.ismelee ) && dmg_struct.smeansofdeath === "MOD_MELEE";
            
            if ( gunbutt )
            {
                var_ea007afa6a78065 = 1.5;
            }
            else
            {
                var_ea007afa6a78065 = weapongetdamagelocationmodifier( dmg_struct.objweapon, "head", weapondamagetype );
            }
        }
        
        if ( isdefined( var_acce083aee0fa46b ) )
        {
            if ( ( var_acce083aee0fa46b.additionaldamagemod ?? 0 ) > 0 )
            {
                var_25ebc911e358603c += dmg_struct.idamage * var_acce083aee0fa46b.additionaldamagemod;
            }
            else
            {
                var_ea007afa6a78065 = ( ( var_acce083aee0fa46b.additionaldamagemod ?? 0 ) + 1 ) * ( ( var_ea007afa6a78065 ?? 1 ) - 1 ) + 1;
            }
        }
        
        if ( isdefined( var_ea007afa6a78065 ) )
        {
            var_25ebc911e358603c += dmg_struct.idamage * ( var_ea007afa6a78065 - 1 );
        }
        
        var_ba621935918835d = dmg_struct.idamage + var_25ebc911e358603c;
        var_bbd59a8545b993c7 = self.health == self.maxhealth;
        var_fb1b5d1499df98c4 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_deadshot", #"deadshot_first_strike" );
        var_c55ff9156bc43d7a = var_fb1b5d1499df98c4 && var_bbd59a8545b993c7;
        
        if ( !dmg_struct.sweapon.ismelee && dmg_struct.smeansofdeath != "MOD_MELEE" && isdefined( dmg_struct.eattacker.var_92a742437d824533 ) && !var_c55ff9156bc43d7a )
        {
            var_ba621935918835d *= dmg_struct.eattacker.var_92a742437d824533;
            dmg_struct.var_ac6da6d4896af068 = 1;
        }
        
        return var_ba621935918835d;
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x916ce382, Offset: 0x341c
// Size: 0x12f
function check_damaged_armor( dmg_struct )
{
    if ( self.damageshield )
    {
        return 0;
    }
    
    if ( isplayer( dmg_struct.eattacker ) && isdefined( dmg_struct.metabonename ) )
    {
        armor_data = metabone::get_metabone_metadata( dmg_struct.metabonename, "Types_Armor" );
        
        if ( isdefined( armor_data ) )
        {
            dmg_struct.var_d5020ae6ddd07b6e = is_explosive_damage( dmg_struct.smeansofdeath ) ? armor_data.explosivedamagemod : armor_data.damagemod;
            dmg_struct.var_4f9d5587bf9a2b1e = isdefined( dmg_struct.var_d5020ae6ddd07b6e );
            assert( isdefined( dmg_struct.var_d5020ae6ddd07b6e ), self.subclass + "<dev string:x3d>" + dmg_struct.metabonename + "<dev string:x64>" + metabone::get_metabone_state_name( dmg_struct.metabonename ) + "<dev string:x70>" + ( metabone::is_metabone_destroyed( dmg_struct.metabonename ) ? "<dev string:x81>" : "<dev string:x86>" ) );
        }
    }
    
    return dmg_struct.var_4f9d5587bf9a2b1e;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x907833bc, Offset: 0x3554
// Size: 0x18f
function function_1f965cbbc7f5d5e7( dmg_struct )
{
    if ( dmg_struct.var_4f9d5587bf9a2b1e && dmg_struct.metabonename && isdefined( dmg_struct.var_d5020ae6ddd07b6e ) )
    {
        assert( dmg_struct.var_d5020ae6ddd07b6e <= 1 );
        attacker = dmg_struct.eattacker;
        mitigation_mod = dmg_struct.var_d5020ae6ddd07b6e;
        
        if ( attacker.var_a48163c16d11e1b1 )
        {
            dmg_struct.idamage = attacker [[ attacker.var_a48163c16d11e1b1 ]]( dmg_struct.idamage, attacker, undefined );
        }
        
        if ( isplayer( dmg_struct.eattacker ) && dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_blast_off" ) && dmg_struct.eattacker utility::callsharedfunc( #"ammo_mod", #"hash_dd0e24457cb788c3", dmg_struct.sweapon, "shatterblast" ) )
        {
            var_a6bc16811db725c2 = level.zombie_augments[ #"shatterblast_blast_off" ].var_7f355000760f6f1f ?? 0.1;
            mitigation_mod = dmg_struct.var_d5020ae6ddd07b6e + var_a6bc16811db725c2;
        }
        
        dmg_struct.idamage *= mitigation_mod;
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xb8963b82, Offset: 0x36ec
// Size: 0xe1
function function_10e5fc0c6d63f99c( dmg_struct )
{
    if ( dmg_struct.var_4f9d5587bf9a2b1e && dmg_struct.var_d5020ae6ddd07b6e > 0 )
    {
        assert( dmg_struct.var_d5020ae6ddd07b6e <= 1 );
        var_30235f9622a692ae = 1;
        
        if ( dmg_struct.shitloc != "armor" )
        {
            if ( dmg_struct.idflags & 262144 )
            {
                weapondamagetype = 2;
            }
            else
            {
                weapondamagetype = 0;
            }
            
            var_30235f9622a692ae = weapongetdamagelocationmodifier( dmg_struct.objweapon, "armor", weapondamagetype );
        }
        
        var_30235f9622a692ae = min( 1 / dmg_struct.var_d5020ae6ddd07b6e, var_30235f9622a692ae ?? 1 );
        dmg_struct.idamage *= var_30235f9622a692ae;
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xbd4b5689, Offset: 0x37d6
// Size: 0x10a
function function_960f65c8626d199b( dmg_struct )
{
    if ( ( dmg_struct.shitloc == "head" || dmg_struct.shitloc == "neck" || dmg_struct.shitloc == "helmet" ) && dmg_struct.smeansofdeath != "MOD_MELEE" && !dmg_struct.sweapon.ismelee && !dmg_struct.var_d3006097a8584457 )
    {
        if ( dmg_struct.idflags & 262144 )
        {
            weapondamagetype = 2;
        }
        else
        {
            weapondamagetype = 0;
        }
        
        var_e2a1baffd8978f47 = weapongetdamagelocationmodifier( dmg_struct.objweapon, dmg_struct.shitloc, weapondamagetype );
        
        if ( isdefined( var_e2a1baffd8978f47 ) && var_e2a1baffd8978f47 != 0 )
        {
            dmg_struct.idamage /= var_e2a1baffd8978f47;
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 3
// Checksum 0xf91b33f, Offset: 0x38e9
// Size: 0x91
function check_armor_hitmarker( eattacker, var_4f9d5587bf9a2b1e, var_c3d8bfb2fb7c1749 = "hitarmor" )
{
    self endon( #"death" );
    self endon( #"metabone_destroyed" );
    msg = utility::waittill_any_timeout( 0.5, "metabone_damaged_not_destroyed" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    if ( isplayer( eattacker ) && var_4f9d5587bf9a2b1e && !self.var_698cf8d8d4a8cbb9 )
    {
        eattacker namespace_9d8e359c3b1041e5::updateDamageFeedback_SharedFunc( var_c3d8bfb2fb7c1749 );
    }
}

// Namespace zombie_damage
// Params 4
// Checksum 0xd5ff7596, Offset: 0x3982
// Size: 0x6d
function trigger_armorbreak_hitmarker( eattacker, var_4f9d5587bf9a2b1e, metabonename, var_47d50d6126bd4f8c = "hitarmorbreak" )
{
    self endon( #"death" );
    
    if ( isplayer( eattacker ) && var_4f9d5587bf9a2b1e && isdefined( metabonename ) && !self.var_698cf8d8d4a8cbb9 )
    {
        eattacker namespace_9d8e359c3b1041e5::updateDamageFeedback_SharedFunc( var_47d50d6126bd4f8c );
    }
}

// Namespace zombie_damage
// Params 1
// Checksum 0xe1561a70, Offset: 0x39f7
// Size: 0x91
function function_e06f2d26a28d8093( dmg_struct )
{
    if ( isdefined( dmg_struct.objweapon ) && isdefined( dmg_struct.objweapon.basename ) && isdefined( level.var_f7d8c385fccc43b4[ dmg_struct.objweapon.basename ] ) )
    {
        dmg_struct.idamage = [[ level.var_f7d8c385fccc43b4[ dmg_struct.objweapon.basename ] ]]( dmg_struct );
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x5ac8ac43, Offset: 0x3a91
// Size: 0x3dc
function function_87aebf397086e82f( dmg_struct )
{
    attackent = undefined;
    var_de1f53206b410ff1 = dmg_struct.idamage;
    
    if ( isdefined( dmg_struct.eattacker ) )
    {
        attackent = dmg_struct.eattacker;
    }
    else
    {
        attackent = dmg_struct.einflictor;
    }
    
    if ( isdefined( dmg_struct.smeansofdeath ) )
    {
        if ( dmg_struct.smeansofdeath == "MOD_CRUSH" )
        {
            if ( isdefined( attackent.vehicletype ) )
            {
                if ( isdefined( level.var_104ab5d510e3e884[ attackent.vehicletype ] ) )
                {
                    var_de1f53206b410ff1 = [[ level.var_104ab5d510e3e884[ attackent.vehicletype ] ]]( dmg_struct );
                }
                else if ( getdvarint( @"hash_52daf1fb76b3dd86", 0 ) != 1 )
                {
                    regiondifficulty = "difficulty_easy";
                    
                    if ( isfunction( level.var_bb131187d6741752 ) )
                    {
                        regiondifficulty = [[ level.var_bb131187d6741752 ]]( attackent.origin );
                    }
                    
                    switch ( regiondifficulty )
                    {
                        case #"hash_af83e47edfa8900a":
                            var_de1f53206b410ff1 *= getdvarfloat( @"hash_c07028410287f458", 2 );
                            break;
                        case #"hash_5343b465e56ec9a4":
                            var_de1f53206b410ff1 *= getdvarfloat( @"hash_c07029410287f68b", 5 );
                            break;
                        case #"hash_651f76c0ad6741ec":
                            var_de1f53206b410ff1 *= getdvarfloat( @"hash_c0702e410288018a", 10 );
                            break;
                        case #"hash_c0250ffc2e87f2ff":
                        case #"hash_c02510fc2e87f492":
                            var_de1f53206b410ff1 *= getdvarfloat( @"hash_c0702f41028803bd", 20 );
                            break;
                    }
                }
                
                var_e2135a579d15e713 = attackent.var_429d5e520209434f;
                ref = attackent vehicle::get_ref();
                bundledata = vehicle::get_data( ref );
                
                if ( var_e2135a579d15e713 || bundledata )
                {
                    var_4a476503463c1c7b = 100;
                    
                    if ( self.aicategory == "hvt" )
                    {
                        var_4a476503463c1c7b = var_e2135a579d15e713.var_fb358cd27991fb1b ?? bundledata.damage.var_fb358cd27991fb1b;
                    }
                    else if ( self.aicategory == "special" )
                    {
                        var_4a476503463c1c7b = var_e2135a579d15e713.var_fa778571b5999562 ?? bundledata.damage.var_fa778571b5999562;
                    }
                    else if ( self.aicategory == "elite" )
                    {
                        var_4a476503463c1c7b = var_e2135a579d15e713.var_38e56640caa6c9ee ?? bundledata.damage.var_38e56640caa6c9ee;
                    }
                    
                    var_de1f53206b410ff1 = min( self.maxhealth * var_4a476503463c1c7b / 100, var_de1f53206b410ff1 );
                }
                
                driver = vehicle_occupancy::get_driver( attackent );
                
                if ( isdefined( driver ) )
                {
                    if ( self.var_698cf8d8d4a8cbb9 )
                    {
                        driver damagefeedback::updatedamagefeedback( "none" );
                    }
                    else
                    {
                        driver damagefeedback::updatehitmarker( "standard", self.health - var_de1f53206b410ff1 <= 0, 0, 0, undefined );
                    }
                }
                
                if ( self.aicategory == "normal" )
                {
                    if ( var_e2135a579d15e713.var_8f17a0069f3a1e6c )
                    {
                        if ( randomintrange( 1, 100 ) <= var_e2135a579d15e713.var_c8b4ff1e9f8a9df1 )
                        {
                            veh_fwd = anglestoforward( attackent.angles );
                            veh_to_zombie = vectornormalize( self.origin - attackent.origin );
                            dot_product = vectordot( veh_fwd, veh_to_zombie );
                            
                            if ( dot_product > cos( var_e2135a579d15e713.var_521f07901f126b2b ) )
                            {
                                self.forceannihilate = 1;
                                attackent callback::callback( "gib_frontal_zombie" );
                            }
                        }
                    }
                }
            }
        }
    }
    
    return var_de1f53206b410ff1;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x161f3567, Offset: 0x3e76
// Size: 0xe1
function function_920710da910e04e8( dmg_struct )
{
    if ( !isdefined( dmg_struct.einflictor ) || !isdefined( level.rockablecars.cars ) )
    {
        return dmg_struct.idamage;
    }
    
    if ( self.aicategory != "normal" || !dmg_struct.einflictor.var_680baa076be6d8b )
    {
        return dmg_struct.idamage;
    }
    
    exploded_veh = dmg_struct.einflictor;
    
    if ( isdefined( exploded_veh.origin ) && isdefined( self.origin ) && distance( exploded_veh.origin, self.origin ) < 300 )
    {
        return self.health;
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xc9acb3e, Offset: 0x3f60
// Size: 0x7c
function function_b9821f08dcbdc9d0( dmg_struct )
{
    if ( !isdefined( dmg_struct.objweapon ) || !dmg_struct.objweapon.isalternate )
    {
        return dmg_struct.idamage;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"scaleUnderbarrelDamageByRound" ) )
    {
        dmg_struct.idamage = namespace_9d8e359c3b1041e5::function_d14f9550ec3c9c39( dmg_struct );
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xac4f496f, Offset: 0x3fe5
// Size: 0x35d
function function_fe961b174c288da0( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_f5dd6051946ae612" ) )
        {
            dmg_struct.idamage = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"hash_f5dd6051946ae612", dmg_struct.idamage );
        }
        
        if ( dmg_struct.eattacker utility::ent_flag( "frenzied_guard_active" ) && dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_fists_of_frenzy" ) && dmg_struct.smeansofdeath == "MOD_MELEE" )
        {
            var_13518fb33ec73cc = self.var_13518fb33ec73cc;
            percent_mod = level.zombie_augments[ #"frenzied_guard_fists_of_frenzy" ].var_2067d3ca905b9ebb ?? 2;
            round_difficulty = var_13518fb33ec73cc ?? namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            dmg_struct.idamage = percent_mod * zombie_base_health;
        }
        
        if ( dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_deadshot", #"deadshot_dead_to_rights" ) )
        {
            if ( weapon::isprimaryweapon( dmg_struct.sweapon ) && dmg_struct.smeansofdeath != "MOD_MELEE" )
            {
                distance = distance2dsquared( dmg_struct.eattacker.origin, self.origin );
                range_activation = level.zombie_augments[ #"deadshot_dead_to_rights" ].var_ab8056560075a76d ?? 45;
                range_activation *= range_activation;
                bonus_damage_percent = level.zombie_augments[ #"deadshot_dead_to_rights" ].var_ef04ebdf63c8ebe1 ?? 0.25;
                var_f7950ba72dbf2c53 = dmg_struct.idamage * bonus_damage_percent;
                
                if ( distance <= range_activation )
                {
                    dmg_struct.idamage += var_f7950ba72dbf2c53;
                }
            }
        }
        
        if ( dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_d_mod", #"d_mod_double_dealer" ) && ( dmg_struct.smeansofdeath == "MOD_RIFLE_BULLET" || dmg_struct.smeansofdeath == "MOD_PISTOL_BULLET" ) && !weapon::iskillstreakweapon( dmg_struct.sweapon ) )
        {
            if ( dmg_struct.eattacker.var_abcd1ec7d2a92572 >= 3 )
            {
                dmg_struct.idamage += dmg_struct.idamage * ( level.zombie_augments[ #"d_mod_double_dealer" ].var_b3b79783144e82b9 ?? 1 );
            }
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x17a2018d, Offset: 0x434b
// Size: 0xc9
function function_6da586fdebc81509( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) || isplayer( dmg_struct.eattacker.activator ) || dmg_struct.eattacker && dmg_struct.eattacker status_effects::has_status_effect_type( "charm" ) || dmg_struct.eattacker.var_fb2e0070ae6f04e4 )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_9390d4bfb2b44ab2" ) )
        {
            dmg_struct.idamage = utility::callsharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", dmg_struct );
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x71bb4d4f, Offset: 0x441d
// Size: 0xcd
function function_e031bc5b6d914320( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) || isplayer( dmg_struct.eattacker.activator ) || isplayer( dmg_struct.eattacker.owner ) || dmg_struct.eattacker && dmg_struct.eattacker status_effects::has_status_effect_type( "charm" ) )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_890056d50c508463" ) )
        {
            dmg_struct.idamage = utility::callsharedfunc( #"zombie", #"hash_890056d50c508463", dmg_struct );
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x5a4a99a7, Offset: 0x44f3
// Size: 0x6a
function function_a5d75273b1b77ffb( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_d71c2ec0ff424be4" ) )
        {
            dmg_struct.idamage = utility::callsharedfunc( #"zombie", #"hash_d71c2ec0ff424be4", dmg_struct );
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1, eflags: 0x4
// Checksum 0x641bc45b, Offset: 0x4566
// Size: 0x85, Type: bool
function private function_b58e2d156f9236cf( dmg_struct )
{
    if ( !self.var_d6894f01a36b4ff3.var_62e9f54bccaa0009 )
    {
        return false;
    }
    
    if ( ( dmg_struct.idflags & 536870912 ) > 0 )
    {
        return false;
    }
    
    if ( dmg_struct.biscritical )
    {
        return false;
    }
    
    if ( dmg_struct.smeansofdeath == "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( isdefined( self.var_81239cbfa6fb7d8b ) )
    {
        if ( ![[ self.var_81239cbfa6fb7d8b ]]( dmg_struct ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x55a171d5, Offset: 0x45f4
// Size: 0xbb
function function_579261f41dfd0572( dmg_struct )
{
    if ( function_b58e2d156f9236cf( dmg_struct ) )
    {
        if ( isexplosivedamagemod( dmg_struct.smeansofdeath ) )
        {
            dmg_struct.idamage *= self.var_d6894f01a36b4ff3.var_746a8e537e09f7bb;
        }
        else
        {
            dmg_struct.idamage *= self.var_d6894f01a36b4ff3.var_507832c5bdc559e0;
        }
        
        dmg_struct.var_ff33243f5be1fe3b = min( self.var_d6894f01a36b4ff3.var_3def56580ba5fc3, dmg_struct.var_ff33243f5be1fe3b );
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0xa491b8f1, Offset: 0x46b8
// Size: 0x15d
function function_e20f670a9518dbc0( dmg_struct )
{
    if ( self.var_d6894f01a36b4ff3.var_825cbb9c164f0fe9 )
    {
        current_health_percent = ( self.health - dmg_struct.idamage ) / self.maxhealth;
        
        if ( current_health_percent <= self.var_d6894f01a36b4ff3.var_e82334da5c9d18be )
        {
            var_772a15ececa4778d = gettime() - self.birthtime;
            var_bd9622e4f3893443 = self.var_9dd11279d5e371c7 ?? self.var_d6894f01a36b4ff3.var_ee14f8e645a86f09;
            var_e9e82b3d01691bba = utility::function_4b74c15943231980( var_bd9622e4f3893443 * 60 );
            min_health_percent = 1 - min( var_772a15ececa4778d / var_e9e82b3d01691bba, 1 );
            
            if ( current_health_percent <= min_health_percent )
            {
                buffer_percent = self.var_d6894f01a36b4ff3.var_c707a1d525396e78;
                damage_reduction_max = self.var_d6894f01a36b4ff3.var_e13a895e0ec9a588;
                damage_reduction = max( math::remap( current_health_percent, min_health_percent, min_health_percent - buffer_percent, 1, damage_reduction_max ), damage_reduction_max );
                dmg_struct.idamage *= damage_reduction;
            }
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x64ca0192, Offset: 0x481e
// Size: 0x39
function function_802d419e92379eb3( dmg_struct )
{
    if ( isdefined( self.var_d6894f01a36b4ff3.var_630a75d0d7b8e87d ) )
    {
        return self.var_d6894f01a36b4ff3.var_630a75d0d7b8e87d;
    }
    
    return 1;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x4c516064, Offset: 0x4860
// Size: 0xc3
function function_f02b21908b7bd90d( dmg_struct )
{
    if ( !dmg_struct.var_d33b5d20cf3b0e9b )
    {
        if ( dmg_struct.var_ff33243f5be1fe3b >= 0 && dmg_struct.var_ff33243f5be1fe3b < 1 && isdefined( self.maxhealth ) )
        {
            dmg_struct.idamage = min( dmg_struct.idamage, dmg_struct.var_ff33243f5be1fe3b * self.maxhealth );
        }
        
        return;
    }
    
    logstring( "Damage being pushed through without damage max health cap applied: " + dmg_struct.idamage );
    logstring( "Damage if damage max health cap was applied: " + min( dmg_struct.idamage, dmg_struct.var_ff33243f5be1fe3b * self.maxhealth ) );
}

// Namespace zombie_damage
// Params 1, eflags: 0x4
// Checksum 0xc339586b, Offset: 0x492b
// Size: 0x1be
function private function_b1972eb8e4bd7e8f( dmg_struct )
{
    n_damage = dmg_struct.idamage;
    
    if ( dmg_struct.smeansofdeath == "MOD_MELEE" && isplayer( dmg_struct.eattacker ) && dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
    {
        max_damage_round = level.perkbundles[ "specialty_m_mod" ].maxdamageround ?? 20;
        current_round = undefined;
        current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round );
        
        if ( dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_pressure_points" ) && isdefined( level.zombie_augments[ #"m_mod_pressure_points" ].var_214cc1d3e160728c ) && isplayer( dmg_struct.eattacker ) )
        {
            var_3f03aa5d85b59f0b = level.zombie_augments[ #"m_mod_pressure_points" ].var_214cc1d3e160728c ?? 5;
            max_damage_round += var_3f03aa5d85b59f0b;
        }
        
        var_6a02108301e17dc = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", int( max_damage_round ) ) ?? 1635;
        n_damage = current_round <= max_damage_round ? int( base_zombie_max_health ) : int( var_6a02108301e17dc );
        
        if ( n_damage < 525 )
        {
            n_damage = 525;
        }
    }
    
    return n_damage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x66aee6cd, Offset: 0x4af2
// Size: 0x223
function function_eb7d5e5b35444c8b( dmg_struct )
{
    attacker = dmg_struct.eattacker;
    
    if ( isdefined( attacker ) && attacker utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_m_mod" ) && !( dmg_struct.idflags & 65536 ) )
    {
        weaponrootname = getweaponrootstring( dmg_struct.objweapon );
        
        if ( isdefined( weaponrootname ) )
        {
            weaponrootname = getxhash( weaponrootname );
        }
        
        if ( dmg_struct.objweapon === attacker.var_cc1262e66dbb1c79 && ( dmg_struct.objweapon.ismelee || weaponrootname === #"sat_me_ballisticknife" ) || utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_9cc974404dd11cf3", dmg_struct.objweapon ) )
        {
            if ( isdefined( attacker.var_fbbb1259b16d80fc ) && weapon::iswonderweapon( dmg_struct.objweapon ) )
            {
                scaled_damage = dmg_struct.idamage * attacker.var_fbbb1259b16d80fc;
                var_1ac82a16cb548691 = function_b1972eb8e4bd7e8f( dmg_struct );
                
                if ( scaled_damage < var_1ac82a16cb548691 )
                {
                    scaled_damage = var_1ac82a16cb548691;
                }
                
                return scaled_damage;
            }
            else if ( isdefined( attacker.var_913e73538232df23 ) && weaponrootname === #"sat_me_ballisticknife" && dmg_struct.smeansofdeath == "MOD_MELEE" )
            {
                scaled_damage = dmg_struct.idamage * attacker.var_913e73538232df23;
                var_1ac82a16cb548691 = function_b1972eb8e4bd7e8f( dmg_struct );
                
                if ( scaled_damage < var_1ac82a16cb548691 )
                {
                    scaled_damage = var_1ac82a16cb548691;
                }
                
                return scaled_damage;
            }
            else if ( isdefined( attacker.var_614432bb9af09520 ) && dmg_struct.smeansofdeath == "MOD_MELEE" )
            {
                scaled_damage = dmg_struct.idamage * attacker.var_614432bb9af09520;
                var_1ac82a16cb548691 = function_b1972eb8e4bd7e8f( dmg_struct );
                
                if ( scaled_damage < var_1ac82a16cb548691 )
                {
                    scaled_damage = var_1ac82a16cb548691;
                }
                
                return scaled_damage;
            }
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 1
// Checksum 0x9ee5e6a2, Offset: 0x4d1e
// Size: 0x117
function function_9238df0f5f57170a( params )
{
    if ( !isdefined( self.health_state_callbacks ) || !self.health_state_callbacks.size )
    {
        return;
    }
    
    if ( params.idamage == 0 )
    {
        return;
    }
    
    var_3773b5f3cf1455d2 = 0;
    health_state_callbacks = self.health_state_callbacks;
    newhealth = self.health - int( params.idamage );
    
    for ( i = health_state_callbacks.size - 1; i >= 0 ; i-- )
    {
        var_6fcb51fd383c5fa = health_state_callbacks[ i ];
        var_35069c22d08b1f24 = int( var_6fcb51fd383c5fa.var_35069c22d08b1f24 * self.maxhealth );
        
        if ( newhealth <= var_35069c22d08b1f24 )
        {
            if ( !var_3773b5f3cf1455d2 )
            {
                var_3773b5f3cf1455d2 = 1;
                self [[ var_6fcb51fd383c5fa.callback ]]( var_6fcb51fd383c5fa.var_35069c22d08b1f24, params );
            }
            
            self.health_state_callbacks = arrayremove( self.health_state_callbacks, var_6fcb51fd383c5fa );
            continue;
        }
        
        break;
    }
}

// Namespace zombie_damage
// Params 1
// Checksum 0xa564ff9d, Offset: 0x4e3d
// Size: 0xfb
function function_bccc7eb65bfbb479( dmg_struct )
{
    if ( self.var_2127b832226be646 > 0 )
    {
        b_shielded = 1;
        
        if ( isdefined( self.var_45f2beaaf602ef55 ) && ( isdefined( dmg_struct.shitloc ) && arraycontains( self.var_45f2beaaf602ef55, dmg_struct.shitloc ) || isdefined( dmg_struct.partname ) && arraycontains( self.var_45f2beaaf602ef55, dmg_struct.partname ) || isdefined( dmg_struct.metabonename ) && arraycontains( self.var_45f2beaaf602ef55, dmg_struct.metabonename ) ) )
        {
            b_shielded = 0;
        }
        
        if ( b_shielded )
        {
            dmg_struct.idamage *= self.var_2127b832226be646;
            dmg_struct.bshielded = 1;
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_damage
// Params 2
// Checksum 0x4b4eb024, Offset: 0x4f41
// Size: 0x39
function function_85e93f8d55a27ac4( weaponrootname, var_a89f9ad30d96ad41 )
{
    if ( !isdefined( level.var_e1b9ad5126850403 ) )
    {
        level.var_e1b9ad5126850403 = [];
    }
    
    level.var_e1b9ad5126850403[ weaponrootname ] = var_a89f9ad30d96ad41;
}

