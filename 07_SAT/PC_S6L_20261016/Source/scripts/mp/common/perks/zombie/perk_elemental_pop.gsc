// scripts\mp\common\perks\zombie\perk_elemental_pop.gsc  (hash_3340139e531ebcff.gscc) (size: 5854 Bytes / 0x16de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28899079 (680104057)
// size ...... 5854 (0x16de)
// includes .. 9   (offset: 0x1566)
// strings ... 16  (offset: 0x15ae)
// dev strs .. 1   (offset: 0x16d2)
// exports ... 13  (offset: 0xcce)
// cseg ...... 0x242 + 0xa8c (0xcce)
// imports ... 58  (offset: 0xed6)
// animtree1 . 0   (offset: 0x16de)
// animtree2 . 0   (offset: 0x16de)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\equipment;

#namespace perk_elemental_pop;

// Namespace perk_elemental_pop
// Params 0, eflags: 0x5
// Checksum 0x2719d829, Offset: 0x260
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_elemental_pop", undefined, &__init__, undefined );
}

// Namespace perk_elemental_pop
// Params 0
// Checksum 0x97a1f838, Offset: 0x27d
// Size: 0xa
function __init__()
{
    level thread perk_elemental_pop_init();
}

// Namespace perk_elemental_pop
// Params 0
// Checksum 0x16ed8d93, Offset: 0x28f
// Size: 0xba
function perk_elemental_pop_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_elemental_pop" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_elemental_pop" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_elemental_pop" );
    level thread zombie_perks::enable_perk_for_level( "specialty_elemental_pop", str_currency, var_fcb7626c79b3c98f, &function_98f303258874552a, &function_ec09e52c93b9efc0, 1 );
    level utility::flag_set( "specialty_elemental_pop" + "init_complete" );
    utility::registersharedfunc( #"zombie", #"hash_a2a2812a52ad2527", &function_ab6f45bf3b6d4b3e );
}

// Namespace perk_elemental_pop
// Params 0
// Checksum 0x3f58d8c2, Offset: 0x351
// Size: 0x9
function function_98f303258874552a()
{
    function_a5e3728dff5e3e33();
}

// Namespace perk_elemental_pop
// Params 4
// Checksum 0x6d8a057c, Offset: 0x362
// Size: 0x2e
function function_ec09e52c93b9efc0( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    function_2df5702cbc28f7e9();
}

// Namespace perk_elemental_pop
// Params 0
// Checksum 0x9b92f33c, Offset: 0x398
// Size: 0x1a
function function_a5e3728dff5e3e33()
{
    zombie_perks::function_5d65c3d58cc084ec( "specialty_elemental_pop" );
    zombie_utils::function_dfae6a5bd222c586( &elemental_pop_actor_damage_override );
}

// Namespace perk_elemental_pop
// Params 0
// Checksum 0x6b2f697b, Offset: 0x3ba
// Size: 0x1a
function function_2df5702cbc28f7e9()
{
    zombie_perks::function_25539251d02082( "specialty_elemental_pop" );
    zombie_utils::function_10c0c35c21e3ed9d( &elemental_pop_actor_damage_override );
}

// Namespace perk_elemental_pop
// Params 1
// Checksum 0xc8b7237f, Offset: 0x3dc
// Size: 0x344
function elemental_pop_actor_damage_override( params )
{
    assert( isplayer( params.eattacker ) );
    assert( params.eattacker zombie_perks::has_perk( "<dev string:x24>" ) );
    damage = params.idamage;
    attacker = params.eattacker;
    
    if ( !is_valid_mod( params.smeansofdeath, attacker, params.objweapon ) )
    {
        return damage;
    }
    
    if ( !level.ammo_mods_in_use )
    {
        return damage;
    }
    
    if ( !isdefined( attacker.var_436d1d31c48df750 ) )
    {
        attacker.var_436d1d31c48df750 = 0;
    }
    
    chance = level.perkbundles[ "specialty_elemental_pop" ].var_a4acfe2b6b1945a0 ?? 5;
    cooldownmult = level.perkbundles[ "specialty_elemental_pop" ].var_54d8132e73b1be17 ?? 2;
    currentcooldown = 0;
    var_3f3f99a2cc32a958 = 2;
    
    if ( isdefined( attacker.var_9db3c6b649ecf485 ) )
    {
        currentcooldown = level.ammo_mods[ attacker.var_9db3c6b649ecf485 ].var_d8565ba5d24b8a01;
    }
    
    cooldown = cooldownmult * currentcooldown;
    
    if ( cooldown < level.perkbundles[ "specialty_elemental_pop" ].var_8b4c0ca328de0b6d )
    {
        cooldown = level.perkbundles[ "specialty_elemental_pop" ].var_8b4c0ca328de0b6d;
    }
    
    if ( attacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_more_pop" ) )
    {
        cooldown -= cooldown * level.zombie_augments[ #"elemental_pop_more_pop" ].var_10fca521ede5ea4e;
    }
    
    if ( attacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_elemental_equipment" ) )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_844ec3842490d875", params.sweapon ) )
        {
            chance = level.zombie_augments[ #"elemental_pop_elemental_equipment" ].var_bed21b6f8f805e59;
            var_3f3f99a2cc32a958 = 1;
            var_c9dc02ec85fee73d = 1;
        }
    }
    
    if ( attacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_tuned_frequency" ) )
    {
        currentweapon = attacker getcurrentweapon();
        
        if ( isweapon( currentweapon ) )
        {
            ammomod = attacker ammo_mod::get_ammo_mod_name( currentweapon );
            
            if ( ammomod != "" )
            {
                chance = level.zombie_augments[ #"elemental_pop_tuned_frequency" ].var_92d6a1b4f732457a;
            }
        }
    }
    
    if ( utility::percent_chance( chance ) && damage >= var_3f3f99a2cc32a958 && attacker function_30fffcd4b846cbe4( params.sweapon ) && attacker.var_436d1d31c48df750 + utility::function_4b74c15943231980( cooldown ) < gettime() )
    {
        damage = function_ab6f45bf3b6d4b3e( params, damage, attacker, undefined, var_c9dc02ec85fee73d );
    }
    
    return damage;
}

// Namespace perk_elemental_pop
// Params 5
// Checksum 0x59be1ca8, Offset: 0x729
// Size: 0x321
function function_ab6f45bf3b6d4b3e( params, damage, attacker, meansofdeathoverride, var_c9dc02ec85fee73d )
{
    var_5e94b7b011663cfd = damage > self.health;
    weapon = params.sweapon;
    
    if ( !isdefined( weapon ) )
    {
        weapon = attacker getcurrentweapon();
    }
    
    var_41c8d742f46ed3fb = attacker ammo_mod::get_ammo_mod_name( weapon );
    var_58e7e0121c794d5c = getarraykeys( level.ammo_mods );
    var_58e7e0121c794d5c = arrayremove( var_58e7e0121c794d5c, "none" );
    
    if ( isdefined( var_41c8d742f46ed3fb ) && var_58e7e0121c794d5c.size > 1 )
    {
        var_58e7e0121c794d5c = arrayremove( var_58e7e0121c794d5c, var_41c8d742f46ed3fb );
    }
    
    var_35a7e90f80366839 = utility::array_random( var_58e7e0121c794d5c );
    
    if ( attacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_tuned_frequency" ) )
    {
        currentweapon = attacker getcurrentweapon();
        
        if ( isweapon( currentweapon ) )
        {
            ammomod = attacker ammo_mod::get_ammo_mod_name( currentweapon );
            
            if ( ammomod != "" )
            {
                var_35a7e90f80366839 = ammomod;
            }
        }
    }
    
    attacker.var_88cc283ee5d29498 = 1;
    var_b1ece7ee0e8bf412 = level.weaponnone;
    attacker ammo_mod::add_ammo_mod_to_weapon( var_b1ece7ee0e8bf412, var_35a7e90f80366839, 0 );
    meansofdeath = "MOD_PISTOL_BULLET";
    attacker callback::callback( "zm_perk_elemental_pop_proc" );
    
    if ( self.aicategory == "normal" || self.aicategory == "special" )
    {
        var_ad5d0f2a4afb15ff = level.perkbundles[ "specialty_elemental_pop" ].var_9de0bd5324529537;
        meansofdeath = meansofdeathoverride ?? meansofdeath;
        
        if ( ammo_mod::ammo_mod_response( var_5e94b7b011663cfd, params.inflictor, attacker, damage, params.idflags, meansofdeath, var_b1ece7ee0e8bf412, params.vpoint, params.vdir, params.shitloc, params.timeoffset, params.modelindex, params.partname, params.objweapon, var_ad5d0f2a4afb15ff, weapon ) )
        {
            if ( isalive( self ) )
            {
                attacker setscriptablepartstate( "elemental_pop_fx", "perk_fx_on", 0 );
                attacker.var_436d1d31c48df750 = gettime();
                attacker.var_9db3c6b649ecf485 = var_35a7e90f80366839;
                
                if ( var_c9dc02ec85fee73d )
                {
                    if ( isdefined( level._effect[ "elemental_equipment_proc" ] ) )
                    {
                        var_c5fa72c12e1b5aef = ( 0, 0, 0 );
                        
                        if ( self tagexists( "j_spine4" ) )
                        {
                            var_c5fa72c12e1b5aef = self gettagorigin( "j_spine4" );
                        }
                        else
                        {
                            var_c5fa72c12e1b5aef = self getcentroid();
                        }
                        
                        playfx( utility::getfx( "elemental_equipment_proc" ), var_c5fa72c12e1b5aef );
                    }
                }
            }
        }
    }
    
    attacker ammo_mod::function_e6267ae500506234( var_b1ece7ee0e8bf412, 0 );
    attacker thread function_52e35b8d483ce48b( var_b1ece7ee0e8bf412 );
    
    if ( var_41c8d742f46ed3fb && var_41c8d742f46ed3fb != "none" )
    {
        if ( !attacker ammo_mod::function_ba9b2ecd18bdbdd8( weapon, var_41c8d742f46ed3fb ) )
        {
            attacker ammo_mod::add_ammo_mod_to_weapon( weapon, var_41c8d742f46ed3fb );
        }
    }
    
    return damage;
}

// Namespace perk_elemental_pop
// Params 1
// Checksum 0x8dbe52f0, Offset: 0xa53
// Size: 0x4d
function function_52e35b8d483ce48b( var_b1ece7ee0e8bf412 )
{
    self endon( #"death" );
    self notify( #"hash_334170f6b3503d00" );
    self endon( #"hash_334170f6b3503d00" );
    waitframe();
    self setscriptablepartstate( "elemental_pop_fx", "perk_fx_off", 0 );
    waitframe();
    self.var_88cc283ee5d29498 = undefined;
}

// Namespace perk_elemental_pop
// Params 1
// Checksum 0x290084e3, Offset: 0xaa8
// Size: 0x106, Type: bool
function function_30fffcd4b846cbe4( weapon )
{
    if ( !weapon )
    {
        return false;
    }
    
    if ( weapon == level.weaponnone )
    {
        return false;
    }
    
    if ( isdefined( weapon.var_e74daecbaa319747 ) && weapon.var_a5321ea94d6fa202 )
    {
        weapon = weapon.var_e74daecbaa319747;
    }
    
    if ( weapon::isprimaryweapon( weapon ) || weapon.inventorytype == "primary" )
    {
        return true;
    }
    else if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_elemental_equipment" ) )
    {
        weaponref = undefined;
        
        if ( utility::issharedfuncdefined( #"equipment", #"getequipmentreffromweapon" ) )
        {
            weaponref = [[ utility::getsharedfunc( #"equipment", #"getequipmentreffromweapon" ) ]]( weapon );
        }
        
        if ( isdefined( weaponref ) )
        {
            if ( equipment_mp::isequipmentlethal( weaponref ) || equipment_mp::isequipmenttactical( weaponref ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace perk_elemental_pop
// Params 3
// Checksum 0xd31efc95, Offset: 0xbb7
// Size: 0x117
function is_valid_mod( var_5a74003d195f2cde, attacker, weapon )
{
    switch ( var_5a74003d195f2cde )
    {
        case #"hash_571e46e17a3cf2e3":
        case #"hash_5f1054c48d66fd1c":
        case #"hash_966768b3f0c94767":
        case #"hash_a5123f4d02745600":
        case #"hash_a86d8c43482948a4":
            return 1;
        case #"hash_2da6932bf991d10e":
        case #"hash_63c3623e159b1e83":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a911a1880d996edb":
        case #"hash_b1078ff213fddba6":
        case #"hash_c22b13f81bed11f0":
        case #"hash_d8646db4e6ee3658":
            if ( isplayer( attacker ) )
            {
                if ( weapon.inventorytype == "primary" )
                {
                    return 1;
                }
                
                if ( attacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_elemental_equipment" ) )
                {
                    return 1;
                }
            }
        default:
            return 0;
    }
}

