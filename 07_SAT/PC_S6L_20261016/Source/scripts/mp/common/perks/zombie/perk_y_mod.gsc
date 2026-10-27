// scripts\mp\common\perks\zombie\perk_y_mod.gsc  (hash_3229728ce5c15282.gscc) (size: 7947 Bytes / 0x1f0b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3dfa658a (1039820170)
// size ...... 7947 (0x1f0b)
// includes .. 13  (offset: 0x1c7f)
// strings ... 33  (offset: 0x1ce7)
// dev strs .. 0   (offset: 0x1f0b)
// exports ... 19  (offset: 0x11cf)
// cseg ...... 0x24b + 0xf84 (0x11cf)
// imports ... 66  (offset: 0x14c7)
// animtree1 . 0   (offset: 0x1f0b)
// animtree2 . 0   (offset: 0x1f0b)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\currency;
#using scripts\mp\equipment;

#namespace perk_y_mod;

// Namespace perk_y_mod
// Params 0, eflags: 0x5
// Checksum 0x67bad285, Offset: 0x269
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_y_mod", undefined, &__init__, undefined );
}

// Namespace perk_y_mod
// Params 0
// Checksum 0x1d95f80d, Offset: 0x286
// Size: 0xa
function __init__()
{
    level thread function_f5d6427ae533dcfc();
}

// Namespace perk_y_mod
// Params 0
// Checksum 0xec040a09, Offset: 0x298
// Size: 0x120
function function_f5d6427ae533dcfc()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_y_mod" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_y_mod" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_y_mod" );
    var_7c0c0569bf2695fb = var_fcb7626c79b3c98f ?? 2000;
    level thread zombie_perks::enable_perk_for_level( "specialty_y_mod", str_currency, var_7c0c0569bf2695fb, &function_e23a7b88ddfddfe5, &function_8ab469d19ea882d7, 1 );
    callback::add( #"player_damaged", &function_8cf9dfbde1074c55 );
    callback::add( #"grenade_fire", &y_mod_on_grenade_fired );
    utility::registersharedfunc( #"zombie", #"hash_c9b2cf177257916b", &function_ead7ea558e43455e );
    scriptable::scriptable_addnotifycallback( "y_mod_shot", &function_dcbcf17b7d587b30 );
    level utility::flag_set( "specialty_y_mod" + "init_complete" );
    level._effect[ "y_mod_proc" ] = loadfxasset( "vfx_sat_gameplay_zm_y_mod_explo" );
}

// Namespace perk_y_mod
// Params 0
// Checksum 0x104a6942, Offset: 0x3c0
// Size: 0xb5
function function_e23a7b88ddfddfe5()
{
    zombie_perks::function_5d65c3d58cc084ec( "specialty_y_mod" );
    bundle = level.perkbundles[ "specialty_y_mod" ];
    self.var_2c3dba6bb298556 = bundle.var_2c3dba6bb298556;
    self.var_8704cc35a218223e = bundle.var_8704cc35a218223e;
    self.var_b81774ac446ce81c = bundle.var_b81774ac446ce81c;
    self.var_a95ef1bcd0dee7c7 = bundle.var_a95ef1bcd0dee7c7;
    self.var_8970e031954e80db = bundle.var_8970e031954e80db;
    self.var_3082ee7c33419e7 = bundle.var_3082ee7c33419e7;
    self.var_af2b43ed0e80e403 = bundle.var_af2b43ed0e80e403;
}

// Namespace perk_y_mod
// Params 4
// Checksum 0x70bdc38b, Offset: 0x47d
// Size: 0x83
function function_8ab469d19ea882d7( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    zombie_perks::function_25539251d02082( "specialty_y_mod" );
    self.var_2c3dba6bb298556 = undefined;
    self.var_8704cc35a218223e = undefined;
    self.var_b81774ac446ce81c = undefined;
    self.var_a95ef1bcd0dee7c7 = undefined;
    self.var_8970e031954e80db = undefined;
    self.var_3082ee7c33419e7 = undefined;
    self.var_af2b43ed0e80e403 = undefined;
    self.var_aac6a355ba29b499 = undefined;
}

// Namespace perk_y_mod
// Params 2
// Checksum 0xdb976470, Offset: 0x508
// Size: 0xbe
function function_2a57219bf798191f( lethal_equip_ref, lethal_ammo_count )
{
    if ( self.ismutantinjection )
    {
        return;
    }
    
    if ( isdefined( lethal_equip_ref ) && isdefined( lethal_ammo_count ) )
    {
        lethal_ammo_count -= 1;
        
        if ( lethal_ammo_count < 0 )
        {
            lethal_ammo_count = 0;
        }
        
        equipment_mp::setequipmentammo( lethal_equip_ref, lethal_ammo_count );
        
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_free_throw" ) )
        {
            percentchance = level.zombie_augments[ #"z_mod_free_throw" ].var_bdac387423954252 ?? 0.25;
            percentchance *= 100;
            
            if ( utility::percent_chance( percentchance ) )
            {
                equipment_mp::incrementequipmentammo( lethal_equip_ref );
            }
        }
    }
}

// Namespace perk_y_mod
// Params 1
// Checksum 0xe69216b4, Offset: 0x5ce
// Size: 0x3e
function y_mod_on_grenade_fired( sparams )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_lethal_equipment" ) )
    {
        thread function_d8955a322addaa20( sparams );
    }
}

// Namespace perk_y_mod
// Params 1
// Checksum 0xf2ff14a0, Offset: 0x614
// Size: 0x83, Type: bool
function function_bfc1a39aaa968e04( equipment_ref )
{
    if ( !isdefined( equipment_ref ) || equipment_ref == "" || equipment_ref == "none" )
    {
        return false;
    }
    
    var_6d535f67aee41549 = equipment_mp::isequipmentlethal( equipment_ref );
    
    if ( var_6d535f67aee41549 )
    {
        if ( equipment_ref == "equip_combataxe" || equipment_ref == "equip_mini_sentry" || equipment_ref == "equip_molotov" )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    else if ( equipment_ref == "equip_monkey_bomb" )
    {
        return true;
    }
    
    return false;
}

// Namespace perk_y_mod
// Params 1
// Checksum 0xd9b690f9, Offset: 0x6a0
// Size: 0x123
function function_d8955a322addaa20( sparams )
{
    self endon( #"death_or_disconnect" );
    should_web = function_bfc1a39aaa968e04( sparams.grenade.equipmentref );
    
    if ( should_web )
    {
        last_grenade_origin = sparams.grenade.origin;
        
        if ( sparams.grenade.equipmentref == "equip_c4" )
        {
            sparams.grenade waittill( #"pre_detonate" );
            last_grenade_origin = sparams.grenade.origin;
        }
        else
        {
            sparams.grenade waittill( #"explode", origin );
            last_grenade_origin = origin;
        }
        
        wait 0.25;
        
        if ( isplayer( self ) && isalive( self ) && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_lethal_equipment" ) )
        {
            thread function_bc2f9e6df47d0692( 1, last_grenade_origin );
        }
    }
}

// Namespace perk_y_mod
// Params 1
// Checksum 0x847234e4, Offset: 0x7cb
// Size: 0x226
function function_8cf9dfbde1074c55( sparams )
{
    var_888364eb6510ab1b = isdefined( sparams.eattacker ) && sparams.eattacker != self && ( issentient( sparams.eattacker ) || isagent( sparams.eattacker ) || isplayer( sparams.eattacker ) );
    var_1fbd78cb601edd0f = sparams.smeansofdeath == "MOD_MELEE";
    
    if ( isplayer( self ) && isalive( self ) && var_888364eb6510ab1b && zombie_perks::has_perk( "specialty_y_mod" ) && var_1fbd78cb601edd0f )
    {
        health_percent_activation = self.var_2c3dba6bb298556 ?? 0.5;
        health_threshold = self.maxhealth * health_percent_activation;
        
        if ( self.health <= health_threshold )
        {
            lethal_equip_ref = equipment_mp::getcurrentequipment( "primary" );
            lethal_ammo_count = equipment_mp::getequipmentammo( lethal_equip_ref ) ?? 0;
            
            if ( !isdefined( self.var_aac6a355ba29b499 ) && lethal_ammo_count >= 1 )
            {
                self canceloffhands();
                function_2a57219bf798191f( lethal_equip_ref, lethal_ammo_count );
                thread function_bc2f9e6df47d0692();
                return;
            }
            
            last_cooldown_time = self.var_aac6a355ba29b499 ?? gettime();
            cooldown_time = self.var_af2b43ed0e80e403 * 1000;
            var_470d2c54a3a13111 = 0;
            
            if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_haste" ) )
            {
                var_470d2c54a3a13111 = level.zombie_augments[ #"y_mod_haste" ].var_fbc7d2a7afe49740 ?? 5;
                var_470d2c54a3a13111 *= 1000;
                cooldown_time -= var_470d2c54a3a13111;
                cooldown_time = clamp( cooldown_time, 1, self.var_af2b43ed0e80e403 * 1000 );
            }
            
            if ( gettime() - last_cooldown_time >= cooldown_time && lethal_ammo_count >= 1 )
            {
                function_2a57219bf798191f( lethal_equip_ref, lethal_ammo_count );
                thread function_bc2f9e6df47d0692();
            }
        }
    }
}

// Namespace perk_y_mod
// Params 0
// Checksum 0x5d128bdc, Offset: 0x9f9
// Size: 0x1f, Type: bool
function function_ead7ea558e43455e()
{
    if ( self.var_b564eceeb50012af || self.var_7653110396b4298f )
    {
        return true;
    }
    
    return false;
}

// Namespace perk_y_mod
// Params 2
// Checksum 0x175d6002, Offset: 0xa21
// Size: 0xed
function y_mod_cocoon_zombie( player, cocoon_time )
{
    if ( self.type == "zombie" && self.team != player.team && !zombie_utils::function_bf1464d09f4e4b40() && !status_effects::function_fa35fc2723e956eb( "slow", "y_mod_cocoon" ) )
    {
        effect_slow::slow( "y_mod_cocoon", 0.0001, cocoon_time, player, &y_mod_cocoon_ended );
        
        if ( namespace_b76ff2659823e89d::is_crawling() )
        {
            utility::function_32b24db3127bff40( "y_mod", "cocoon_on_crawler" );
        }
        else
        {
            utility::function_32b24db3127bff40( "y_mod", "cocoon_on" );
        }
        
        if ( zombie_vehicle_attack::is_in_vehicle_attack() )
        {
            zombie_vehicle_attack::function_b6b04d95c27e889b( 0 );
            zombie_vehicle_attack::function_22391ae9d7a28a94( 1 );
        }
        else
        {
            val::set( "y_mod_cocoon", "ignoreall", 1 );
        }
        
        self.var_b564eceeb50012af = 1;
        self.var_99ae508ac039ff18 = 1;
    }
}

// Namespace perk_y_mod
// Params 3
// Checksum 0x8b74958b, Offset: 0xb16
// Size: 0x9a
function y_mod_web_zombie( player, web_time, var_13552415056c9dda )
{
    if ( self.type == "zombie" && self.team != player.team && !zombie_utils::function_bf1464d09f4e4b40() && !status_effects::function_fa35fc2723e956eb( "slow", "y_mod_cocoon" ) )
    {
        effect_slow::slow( "y_mod_web", var_13552415056c9dda, web_time, player, &y_mod_web_ended );
        utility::function_32b24db3127bff40( "y_mod", "web_on" );
        self.var_7653110396b4298f = 1;
    }
}

// Namespace perk_y_mod
// Params 3
// Checksum 0x2f823f45, Offset: 0xbb8
// Size: 0x4b2
function function_bc2f9e6df47d0692( var_f20bc8da9ed5d6a7 = 0, override_origin, var_69fd3f047db51992 = 0 )
{
    callback::callback( "y_mod_proc" );
    y_mod_origin = self.origin;
    fx_origin = self gettagorigin( "j_spine4" );
    
    if ( override_origin )
    {
        fx_origin = override_origin;
        y_mod_origin = override_origin;
    }
    
    if ( !var_69fd3f047db51992 )
    {
        playfx( utility::getfx( "y_mod_proc" ), fx_origin );
        self playsoundonmovingent( #"hash_55f674931a380207" );
    }
    
    if ( !var_f20bc8da9ed5d6a7 )
    {
        self.var_aac6a355ba29b499 = gettime();
    }
    
    var_b29294b28c9ce489 = 0;
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_wide_web" ) )
    {
        var_b29294b28c9ce489 = level.zombie_augments[ #"y_mod_wide_web" ].var_98f09be19178dd0f ?? 0.75;
    }
    
    var_2e947f91a2401d7 = 0;
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_extension" ) )
    {
        var_2e947f91a2401d7 = level.zombie_augments[ #"y_mod_extension" ].var_3ed0fcaca236592e ?? 0.5;
    }
    
    cocoon_range = self.var_8970e031954e80db ?? 50;
    bonus_range = cocoon_range * var_b29294b28c9ce489;
    cocoon_range += bonus_range;
    cocoon_time = self.var_3082ee7c33419e7 ?? 10;
    cocoon_time += cocoon_time * var_2e947f91a2401d7;
    cocoon_zombies = getaiarrayinradius( y_mod_origin, cocoon_range );
    
    foreach ( zombie in cocoon_zombies )
    {
        if ( !isalive( zombie ) || zombie.health <= 0 )
        {
            continue;
        }
        
        if ( zombie getaiblackboarddynamic( "in_grab_attack" ) )
        {
            continue;
        }
        
        var_92132e0dfea650e3 = zombie.aicategory == "normal";
        
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_tangled_web" ) )
        {
            var_92132e0dfea650e3 = zombie.aicategory == "normal" || zombie.aicategory == "special";
        }
        
        if ( var_92132e0dfea650e3 )
        {
            zombie y_mod_cocoon_zombie( self, cocoon_time );
        }
    }
    
    web_range = self.var_b81774ac446ce81c ?? 164;
    bonus_range = web_range * var_b29294b28c9ce489;
    web_range += bonus_range;
    web_time = self.var_a95ef1bcd0dee7c7 ?? 1;
    web_time += web_time * var_2e947f91a2401d7;
    var_13552415056c9dda = self.var_8704cc35a218223e ?? 0.5;
    web_zombies = getaiarrayinradius( y_mod_origin, web_range );
    
    foreach ( zombie in web_zombies )
    {
        if ( !isalive( zombie ) || zombie.health <= 0 )
        {
            continue;
        }
        
        if ( zombie getaiblackboarddynamic( "in_grab_attack" ) )
        {
            continue;
        }
        
        var_d1cd12466649b5e7 = zombie.aicategory == "normal" || zombie.aicategory == "special";
        var_92132e0dfea650e3 = 0;
        
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_tangled_web" ) )
        {
            var_92132e0dfea650e3 = zombie.aicategory == "normal" || zombie.aicategory == "special";
            var_d1cd12466649b5e7 = zombie.aicategory == "normal" || zombie.aicategory == "special" || zombie.aicategory == "elite";
        }
        
        if ( var_92132e0dfea650e3 )
        {
            zombie y_mod_cocoon_zombie( self, cocoon_time );
        }
        
        if ( var_d1cd12466649b5e7 )
        {
            zombie y_mod_web_zombie( self, web_time, var_13552415056c9dda );
        }
    }
}

// Namespace perk_y_mod
// Params 2, eflags: 0x40 variadic
// Checksum 0x585eebed, Offset: 0x1072
// Size: 0x68
function y_mod_cocoon_ended( ... )
{
    utility::function_32b24db3127bff40( "y_mod", "breakout" );
    self.var_99ae508ac039ff18 = 0;
    self.var_b564eceeb50012af = undefined;
    
    if ( zombie_vehicle_attack::is_in_vehicle_attack() )
    {
        zombie_vehicle_attack::function_b6b04d95c27e889b( 1 );
        zombie_vehicle_attack::function_22391ae9d7a28a94( 0 );
        return;
    }
    
    val::reset( "y_mod_cocoon", "ignoreall" );
}

// Namespace perk_y_mod
// Params 2, eflags: 0x40 variadic
// Checksum 0x1924fe55, Offset: 0x10e2
// Size: 0x30
function y_mod_web_ended( ... )
{
    utility::function_32b24db3127bff40( "y_mod", "off" );
    self.var_7653110396b4298f = undefined;
}

// Namespace perk_y_mod
// Params 4
// Checksum 0xa149ff2c, Offset: 0x111a
// Size: 0x64
function function_dcbcf17b7d587b30( eattacker, note, param, var_64ffacba090c91be )
{
    closest_player = getclosestplayer( eattacker.origin );
    
    if ( isplayer( closest_player ) )
    {
        closest_player function_bc2f9e6df47d0692( 0, closest_player.origin, 1 );
    }
}

// Namespace perk_y_mod
// Params 1
// Checksum 0xe89c2819, Offset: 0x1186
// Size: 0x48
function getclosestplayer( origin )
{
    if ( !isdefined( level.players ) )
    {
        return level.player;
    }
    else if ( level.players.size == 0 )
    {
        return;
    }
    
    return sortbydistance( level.players, origin )[ 0 ];
}

