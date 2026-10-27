// scripts\mp\zm\systems\zm_armor.gsc  (hash_315d0ecfeb067b1c.gscc) (size: 13823 Bytes / 0x35ff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52899a8e (1384749710)
// size ...... 13823 (0x35ff)
// includes .. 11  (offset: 0x330f)
// strings ... 26  (offset: 0x3367)
// dev strs .. 23  (offset: 0x34e3)
// exports ... 38  (offset: 0x2123)
// cseg ...... 0x265 + 0x1ebe (0x2123)
// imports ... 98  (offset: 0x2713)
// animtree1 . 0   (offset: 0x35ff)
// animtree2 . 0   (offset: 0x35ff)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\health_overcharge;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_armor;

// Namespace zm_armor
// Params 0, eflags: 0x5
// Checksum 0x5f37e6de, Offset: 0x283
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"zm_armor", #"armor", &function_2d66dd9e5865a2ac, undefined );
}

// Namespace zm_armor
// Params 0
// Checksum 0x3ba84ced, Offset: 0x2ac
// Size: 0x1f2
function function_2d66dd9e5865a2ac()
{
    if ( !level.allowarmor )
    {
        return;
    }
    
    /#
        level thread setup_armor_devgui();
    #/
    
    if ( isdefined( level.gamemodebundle.armormetadata ) )
    {
        level.var_1e9e024bcfca2274 = getscriptbundle( level.gamemodebundle.armormetadata );
    }
    
    level.var_6f8b7a2e996178a8 = &armor_damage_absorbed;
    level.var_40d8cae54a6dee6a = &function_65e672b76edb7eff;
    level.var_6b5a5711823ede8c = &repair_from_plate;
    level.var_deed8ad09d3bee37 = &get_max_armor_health;
    level.var_89173a04bb110bf3 = &function_4449f43557aeb992;
    level.var_21038aca0aba3c4a = &armor_damage_post;
    level.armoronweaponswitchlongpress = 1;
    callback::add( #"player_connect", &function_1c077eb1ecd1777e );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"player_damaged", &on_player_damaged );
    callback::add( #"hash_5447fe6feab51288", &on_armor_damage );
    callback::add( #"hash_42a07c459e05796d", &function_5bd3b4eeec2f3204 );
    callback::add( #"hash_aa7c0dbef3e86ee4", &function_8eade457e6fa438b );
    callback::add( "on_armor_health_changed", &function_23bbbc9801af4c73 );
    callback::add( "wallbuy_armor_purchased", &function_5bd3b4eeec2f3204 );
    callback::add( "zm_perk_obtained", &function_7d8b4c0e9ba89d3d );
    callback::add( "zm_perk_lost", &function_e3f7c1bfc2a0521 );
    callback::add( "toggle_squad_armor", &function_e13e43d539369157 );
    utility::registersharedfunc( #"zombie", #"set_golden_armor", &set_golden_armor );
    utility::registersharedfunc( #"zombie", #"take_golden_armor", &take_golden_armor );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_97433ea32554977f", &function_a0013c4398cc7a8e );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_645c05fba73f3a59", &function_a4a3accaf4842d2c );
    level thread init_armor_post_main();
}

// Namespace zm_armor
// Params 0
// Checksum 0x2b8e9c3f, Offset: 0x4a6
// Size: 0x3
function init_armor_post_main()
{
    waitframe();
}

// Namespace zm_armor
// Params 1
// Checksum 0xea1ac35b, Offset: 0x4b1
// Size: 0x25
function function_1c077eb1ecd1777e( params )
{
    waitframe();
    
    if ( isplayer( self ) )
    {
        armor::initarmor();
        armor::givestartingarmor( 0, 0 );
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0x8e24e13, Offset: 0x4de
// Size: 0x16c
function function_4449f43557aeb992( player )
{
    var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 375;
    var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 450;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 501;
    startingplates = level.var_1e9e024bcfca2274.var_794dfc5af7dde3a0 ?? 3;
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        [ armor_plates, armor_level ] = player zm_save::function_c3331894f472199b();
        
        if ( armor_level == 1 )
        {
            return [ var_219886ad4a381968, armor_plates ];
        }
        else if ( armor_level == 2 )
        {
            return [ var_554023bac16105cf, armor_plates ];
        }
        else if ( armor_level == 3 )
        {
            return [ var_3dc0c4e27d22d986, armor_plates ];
        }
    }
    
    var_b11333017419250c = self.platecarrierlevel ?? 1;
    
    if ( var_b11333017419250c == 2 )
    {
        return [ var_554023bac16105cf, startingplates ];
    }
    else if ( var_b11333017419250c == 3 )
    {
        return [ var_3dc0c4e27d22d986, startingplates ];
    }
    
    return [ var_219886ad4a381968, startingplates ];
}

// Namespace zm_armor
// Params 1
// Checksum 0xe4486050, Offset: 0x653
// Size: 0xd6
function on_player_spawned( params )
{
    if ( isfunction( level.var_6b28f0a43ed09cc ) )
    {
        self [[ level.var_6b28f0a43ed09cc ]]( params );
        return;
    }
    
    waitframe();
    
    if ( isplayer( self ) )
    {
        if ( zm_save::function_fcccc3d2a616b1c7() )
        {
            [ armor_plates, armor_level ] = zm_save::function_c3331894f472199b();
            function_fdbe2cad6d8bb7e7( armor_level );
        }
        else
        {
            function_fdbe2cad6d8bb7e7( self.platecarrierlevel ?? 1 );
        }
        
        if ( self.var_a1faa64d8c07872e )
        {
            if ( isdefined( level.zm_mode_modifiers ) && level.zm_mode_modifiers.var_2dc492758425fa76 )
            {
            }
            
            utility::callsharedfunc( #"zombie", #"set_golden_armor" );
        }
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0x70b9f0aa, Offset: 0x731
// Size: 0x10e
function function_fdbe2cad6d8bb7e7( platecarrierlevel )
{
    if ( isdefined( level.zm_mode_modifiers ) && level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        return;
    }
    
    var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 375;
    var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 450;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 501;
    self.platecarrierlevel = platecarrierlevel;
    self setclientomnvar( "ui_armor_current_level", platecarrierlevel );
    
    if ( platecarrierlevel == 1 )
    {
        self.maxarmorhealth = var_219886ad4a381968;
        armor::setarmorhealth( var_219886ad4a381968 );
        return;
    }
    
    if ( platecarrierlevel == 2 )
    {
        self.maxarmorhealth = var_554023bac16105cf;
        armor::setarmorhealth( var_554023bac16105cf );
        return;
    }
    
    if ( platecarrierlevel == 3 )
    {
        self.maxarmorhealth = var_3dc0c4e27d22d986;
        armor::setarmorhealth( var_3dc0c4e27d22d986 );
    }
}

// Namespace zm_armor
// Params 0
// Checksum 0x5d2245e9, Offset: 0x847
// Size: 0xce
function get_max_armor_health()
{
    var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 375;
    var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 450;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 501;
    
    switch ( self.platecarrierlevel )
    {
        case 1:
            maxarmorhealth = var_219886ad4a381968;
        case 2:
            maxarmorhealth = var_554023bac16105cf;
            break;
        case 3:
            maxarmorhealth = var_3dc0c4e27d22d986;
        default:
            maxarmorhealth = maxarmorhealth;
            break;
    }
    
    return maxarmorhealth;
}

// Namespace zm_armor
// Params 1
// Checksum 0x9a05e973, Offset: 0x91e
// Size: 0x136
function on_armor_damage( params )
{
    if ( int( params.damageabsorbed ) == 0 )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 450;
        var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 501;
        platelevel = self.platecarrierlevel ?? 1;
        var_fdb95557f8e4600c = var_3dc0c4e27d22d986 - var_3dc0c4e27d22d986 / 3;
        var_ba1b2fdf9f694c91 = 0;
        
        if ( platelevel >= 3 )
        {
            var_ba1b2fdf9f694c91 = var_3dc0c4e27d22d986 - 2 * var_3dc0c4e27d22d986 / 3;
        }
        else
        {
            var_ba1b2fdf9f694c91 = var_554023bac16105cf - var_554023bac16105cf / 2;
        }
        
        currentarmorhealth = self.armorhealth ?? 0;
        var_76f428285796319b = 0;
        
        if ( currentarmorhealth <= var_fdb95557f8e4600c && self.lastarmorhealth >= var_fdb95557f8e4600c )
        {
            var_76f428285796319b = 1;
        }
        
        if ( currentarmorhealth <= var_ba1b2fdf9f694c91 && self.lastarmorhealth >= var_ba1b2fdf9f694c91 )
        {
            var_76f428285796319b = 1;
        }
        
        if ( var_76f428285796319b )
        {
            callback::callback( "armor_pip_broken" );
            zm_armor_broken_stun();
        }
    }
}

// Namespace zm_armor
// Params 0
// Checksum 0x5a033047, Offset: 0xa5c
// Size: 0x31
function function_395a8aebf2c4d078()
{
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( self getscriptableparthasstate( "juggernog_reactive_armor_fx", "juggernog_reactive_armor_off" ) )
    {
        self setscriptablepartstate( "juggernog_reactive_armor_fx", "juggernog_reactive_armor_off" );
    }
}

// Namespace zm_armor
// Params 0
// Checksum 0xd37949aa, Offset: 0xa95
// Size: 0x26a
function function_70b827d3d121dbe0()
{
    if ( !health_overcharge::function_8747738d3cfe9a6a() && !self.var_9ef5dcd22c39f926 && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_juggernog", #"juggernog_iron_core" ) )
    {
        self.var_9ef5dcd22c39f926 = 1;
        var_7c82299625e1ce3 = level.zombie_augments[ #"juggernog_iron_core" ].var_f903e697469224a4 ?? 100;
        n_max_total_health = self.maxhealth + var_7c82299625e1ce3;
        
        if ( health_overcharge::function_1c546d630583f860() && self.var_68e0e97561171104.base_max_health )
        {
            self.var_df536b1df86d4230 = self.var_68e0e97561171104.base_max_health;
            n_max_total_health = self.var_68e0e97561171104.base_max_health + var_7c82299625e1ce3;
        }
        else
        {
            self.var_df536b1df86d4230 = self.maxhealth;
        }
        
        if ( isarray( self.var_68e0e97561171104.overcharge_sources ) && self.var_68e0e97561171104.overcharge_sources.size > 0 )
        {
            self.maxhealth = n_max_total_health;
            self.health = self.maxhealth;
            var_8550a26f601bb3cf = self.var_68e0e97561171104.overcharge_sources;
            callback::callback( "on_player_max_health_change", { #new_max_health:n_max_total_health } );
            waitframe();
            waitframe();
            
            if ( isplayer( self ) && isalive( self ) )
            {
                foreach ( index, overheal_value in var_8550a26f601bb3cf )
                {
                    health_overcharge::function_f6da758a8ee4c988( self, index, overheal_value );
                }
            }
            
            return;
        }
        
        self.maxhealth = n_max_total_health;
        self.health += var_7c82299625e1ce3;
        
        if ( self.health > self.maxhealth )
        {
            self.health = self.maxhealth;
        }
        
        callback::callback( "on_player_max_health_change", { #new_max_health:n_max_total_health } );
    }
}

// Namespace zm_armor
// Params 0
// Checksum 0x39229d11, Offset: 0xd07
// Size: 0x1bc
function zm_armor_broken_stun()
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_juggernog", #"juggernog_reactive_armor" ) )
    {
        if ( self getscriptableparthasstate( "juggernog_reactive_armor_fx", "juggernog_reactive_armor_on" ) )
        {
            self setscriptablepartstate( "juggernog_reactive_armor_fx", "juggernog_reactive_armor_on" );
        }
        
        thread function_395a8aebf2c4d078();
        self playrumbleonentity( "damage_light" );
        self earthquakeforplayer( 0.2, 1, self.origin, 100 );
        range = level.zombie_augments[ #"juggernog_reactive_armor" ].var_6b758a388f5e7961 ?? 0;
        duration = level.zombie_augments[ #"juggernog_reactive_armor" ].var_4962fba8ce2cc094 ?? 0;
        var_3e5df7c437647749 = getaiarrayinradius( self.origin, range );
        var_a7b32f2b5269c6de = 0;
        
        foreach ( zombie in var_3e5df7c437647749 )
        {
            if ( zombie.aicategory == "normal" && !zombie zombie_utils::function_bf1464d09f4e4b40() && zombie.team != self.team )
            {
                zombie zombie_stun::stun_ai( duration, "stunned_on" );
                var_a7b32f2b5269c6de++;
            }
        }
        
        if ( var_a7b32f2b5269c6de > 0 )
        {
            self playsoundonmovingent( #"hash_340604cc905bf3b4" );
        }
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0x9be26ea9, Offset: 0xecb
// Size: 0x13
function function_5bd3b4eeec2f3204( params )
{
    thread function_ea0fcb86e1a69395();
}

// Namespace zm_armor
// Params 1
// Checksum 0x47ae6fc3, Offset: 0xee6
// Size: 0x1fa
function function_ea0fcb86e1a69395( var_8b639da25a9ccec2 = 0 )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"juggernog_iron_core" ) )
    {
        if ( self.var_9ef5dcd22c39f926 )
        {
            self.var_9ef5dcd22c39f926 = undefined;
            n_max_total_health = 150;
            
            if ( var_8b639da25a9ccec2 )
            {
                n_max_total_health = int( getmatchrulesdata( "commonOption", "maxHealth" ) );
            }
            else if ( isdefined( self.var_df536b1df86d4230 ) )
            {
                n_max_total_health = self.var_df536b1df86d4230;
            }
            
            if ( self.health > n_max_total_health )
            {
                if ( isarray( self.var_68e0e97561171104.overcharge_sources ) && self.var_68e0e97561171104.overcharge_sources.size > 0 )
                {
                    overcharge_sources = self.var_68e0e97561171104.overcharge_sources;
                    self.health = n_max_total_health;
                    self.maxhealth = n_max_total_health;
                    callback::callback( "on_player_max_health_change", { #new_max_health:n_max_total_health } );
                    waitframe();
                    waitframe();
                    
                    if ( isplayer( self ) && isalive( self ) )
                    {
                        foreach ( index, overheal_value in overcharge_sources )
                        {
                            health_overcharge::function_f6da758a8ee4c988( self, index, overheal_value );
                        }
                    }
                }
                else
                {
                    self.health = n_max_total_health;
                    self.maxhealth = n_max_total_health;
                    callback::callback( "on_player_max_health_change", { #new_max_health:n_max_total_health } );
                }
                
                return;
            }
            
            self.maxhealth = n_max_total_health;
            callback::callback( "on_player_max_health_change", { #new_max_health:n_max_total_health } );
        }
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0xd0e5e622, Offset: 0x10e8
// Size: 0x1a
function function_8eade457e6fa438b( params )
{
    thread zm_armor_broken_stun();
    thread function_70b827d3d121dbe0();
}

// Namespace zm_armor
// Params 1
// Checksum 0xf18e211f, Offset: 0x110a
// Size: 0x48
function function_7d8b4c0e9ba89d3d( params )
{
    if ( isplayer( self ) && isalive( self ) && self.armorhealth <= 0 && params.var_ffc1674def575bfa == "specialty_juggernog" )
    {
        thread function_70b827d3d121dbe0();
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0x157cde6b, Offset: 0x115a
// Size: 0x3b
function function_e3f7c1bfc2a0521( params )
{
    if ( isplayer( self ) && isalive( self ) && params.var_ffc1674def575bfa == "specialty_juggernog" )
    {
        thread function_ea0fcb86e1a69395( 1 );
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0x5b200431, Offset: 0x119d
// Size: 0x33
function function_23bbbc9801af4c73( params )
{
    if ( isplayer( self ) && isalive( self ) && self.armorhealth <= 0 )
    {
        thread function_70b827d3d121dbe0();
    }
}

// Namespace zm_armor
// Params 0
// Checksum 0xe01cc016, Offset: 0x11d8
// Size: 0xa7
function function_65e672b76edb7eff()
{
    maxplates = 5;
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_2f741b96164e5e2c > 0 )
    {
        maxplates = level.gametypebundle.var_2f741b96164e5e2c;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_plate_hunter" ) )
    {
        additionalplates = level.zombie_augments[ #"z_mod_plate_hunter" ].var_89ebc168e9215b9 ?? 0;
        maxplates += additionalplates;
    }
    
    return maxplates;
}

// Namespace zm_armor
// Params 1
// Checksum 0x6750618c, Offset: 0x1288
// Size: 0x2d
function repair_armor( amountrepair )
{
    newarmorhealth = self.armorhealth + amountrepair;
    armor::setarmorhealth( newarmorhealth );
}

// Namespace zm_armor
// Params 0
// Checksum 0x8f91e4f6, Offset: 0x12bd
// Size: 0x5b
function repair_from_plate()
{
    newarmorhealth = 0;
    
    if ( isdefined( self.platecarrierlevel ) )
    {
        newarmorhealth = self.armorhealth + self.maxarmorhealth / self.platecarrierlevel;
    }
    
    newarmorhealth = clamp( newarmorhealth, 0, self.maxarmorhealth );
    callback::callback( "on_armor_repair_from_plate" );
    return newarmorhealth;
}

// Namespace zm_armor
// Params 4
// Checksum 0xacdbf63f, Offset: 0x1321
// Size: 0x361
function armor_damage_absorbed( damage, eattacker, einflictor, smeansofdeath )
{
    var_82f5b1dc13332499 = level.var_1e9e024bcfca2274.var_6e36edafe33fcbbd ?? 0.45;
    var_a0da6a5a151cf2d2 = level.var_1e9e024bcfca2274.var_e1ccf0a99db550c ?? 0.58;
    var_52bab125271b87cb = level.var_1e9e024bcfca2274.var_28630d21f2687b7b ?? 0.65;
    
    if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_juggernog" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"juggernog_thicker_plates" ) )
    {
        var_28f3ffdd7296051a = level.zombie_augments[ #"juggernog_thicker_plates" ].var_fcd4c396ce615ccc ?? 0;
        var_82f5b1dc13332499 += var_28f3ffdd7296051a;
        var_a0da6a5a151cf2d2 += var_28f3ffdd7296051a;
        var_52bab125271b87cb += var_28f3ffdd7296051a;
    }
    
    if ( isdefined( eattacker.var_bd1805e45701eeb1 ) )
    {
        var_82f5b1dc13332499 *= eattacker.var_bd1805e45701eeb1;
        var_a0da6a5a151cf2d2 *= eattacker.var_bd1805e45701eeb1;
        var_52bab125271b87cb *= eattacker.var_bd1805e45701eeb1;
    }
    
    switch ( self.platecarrierlevel )
    {
        case 1:
            absorbed_damage = damage * var_82f5b1dc13332499;
            break;
        case 2:
            absorbed_damage = damage * var_a0da6a5a151cf2d2;
            break;
        case 3:
            absorbed_damage = damage * var_52bab125271b87cb;
            break;
    }
    
    if ( isdefined( self.var_bba1e16138d312c8 ) )
    {
        absorbed_damage = self [[ self.var_bba1e16138d312c8 ]]( damage, eattacker, einflictor, smeansofdeath );
    }
    
    ignore_turtle_shell = smeansofdeath == "MOD_BLEEDOUT" && eattacker.var_f968344e6801d0c1;
    
    if ( eattacker.ignore_turtle_shell || einflictor.ignore_turtle_shell )
    {
        if ( eattacker.ignore_turtle_shell )
        {
            eattacker.ignore_turtle_shell = undefined;
        }
        
        if ( einflictor.ignore_turtle_shell )
        {
            einflictor.ignore_turtle_shell = undefined;
        }
        
        ignore_turtle_shell = 1;
    }
    
    if ( !ignore_turtle_shell && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_juggernog" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"juggernog_turtle_shell" ) )
    {
        var_65164c668c7d876c = eattacker.turtle_shell_attack_origin ?? eattacker.origin;
        
        if ( !isdefined( var_65164c668c7d876c ) )
        {
            return absorbed_damage;
        }
        
        var_ea2af167de05f800 = vectornormalize( var_65164c668c7d876c - self.origin );
        playerforward = vectornormalize( anglestoforward( self.angles ) );
        dot = vectordot( playerforward, var_ea2af167de05f800 );
        
        if ( dot <= 0 && eattacker != self && var_65164c668c7d876c != self.origin )
        {
            eattacker.var_84f354484bf84831 = 1;
            absorbed_damage = damage;
            self setentitysoundcontext( "zm_plr_impact_armored", "on" );
            utility::delaycall( 0.1, &setentitysoundcontext, "zm_plr_impact_armored", "" );
        }
    }
    
    return absorbed_damage;
}

// Namespace zm_armor
// Params 3
// Checksum 0xaff113b5, Offset: 0x168b
// Size: 0x1c3
function armor_damage_post( damageabsorbed, attacker, smeansofdeath )
{
    aitype = "none";
    
    if ( isdefined( attacker ) && isdefined( attacker.type ) )
    {
        aitype = attacker.type;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_8df0babcf2adf617" ) )
    {
        var_bccb7ae9baf9bfd6 = utility::callsharedfunc( #"zombie", #"hash_8df0babcf2adf617" );
        damageabsorbed -= damageabsorbed * var_bccb7ae9baf9bfd6;
    }
    
    if ( aitype == "zombie" && attacker.var_84f354484bf84831 && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_juggernog", #"juggernog_turtle_shell" ) )
    {
        attacker.var_84f354484bf84831 = undefined;
        damageabsorbed *= 0.5;
    }
    
    var_a91b46d687624c63 = getdvarfloat( @"armor_health_damage_multiplier", -1 );
    
    if ( var_a91b46d687624c63 >= 0 )
    {
        attacker.armor_health_damage_multiplier = var_a91b46d687624c63;
    }
    
    if ( attacker.armor_health_damage_multiplier )
    {
        damageabsorbed *= attacker.armor_health_damage_multiplier;
    }
    
    if ( self.var_a1faa64d8c07872e && isdefined( attacker.var_317816f65dd8fd6c ) )
    {
        damageabsorbed *= attacker.var_317816f65dd8fd6c;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.var_a48163c16d11e1b1 ) )
    {
        damageabsorbed = self [[ attacker.var_a48163c16d11e1b1 ]]( damageabsorbed, attacker, smeansofdeath );
    }
    
    if ( isdefined( self.var_a48163c16d11e1b1 ) )
    {
        damageabsorbed = self [[ self.var_a48163c16d11e1b1 ]]( damageabsorbed, attacker, smeansofdeath );
    }
    
    self.lastarmorhealth = self.armorhealth;
    return damageabsorbed;
}

// Namespace zm_armor
// Params 0
// Checksum 0x839fa83e, Offset: 0x1857
// Size: 0x1c, Type: bool
function has_full_armor()
{
    if ( self.armorhealth == self.maxarmorhealth )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_armor
// Params 1
// Checksum 0xf84ee1af, Offset: 0x187c
// Size: 0x28, Type: bool
function function_426ebbae6d35dba6( armorlv )
{
    if ( !isdefined( armorlv ) )
    {
        return false;
    }
    
    if ( self.platecarrierlevel >= armorlv )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_armor
// Params 0
// Checksum 0x24952d9c, Offset: 0x18ad
// Size: 0x1b
function set_golden_armor()
{
    self.var_a1faa64d8c07872e = 1;
    thread function_f43fdb9de37faade();
    armor::setarmoromnvars();
}

// Namespace zm_armor
// Params 0
// Checksum 0x7b54400f, Offset: 0x18d0
// Size: 0x13
function take_golden_armor()
{
    self.var_a1faa64d8c07872e = undefined;
    armor::setarmoromnvars();
}

// Namespace zm_armor
// Params 1
// Checksum 0x87d27f19, Offset: 0x18eb
// Size: 0x2f
function on_player_damaged( sparams )
{
    if ( self.var_a1faa64d8c07872e )
    {
        self.var_eb543ab8371fc802 = gettime();
        self.var_661269b3ac878e4c = 0;
    }
}

// Namespace zm_armor
// Params 0
// Checksum 0x6d19742b, Offset: 0x1922
// Size: 0x1be
function function_f43fdb9de37faade()
{
    self notify( #"hash_d1bfd9bef184d4db" );
    self endon( #"hash_d1bfd9bef184d4db" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_661269b3ac878e4c = 0;
    self.var_9450940fefbe79c8 = level.zombie_augments[ #"juggernog_shielded" ].var_195cd02958ed876 ?? 4;
    self.var_9450940fefbe79c8 *= 1000;
    self.var_eb543ab8371fc802 = gettime();
    self.var_ac875e0060d0ce38 = 0;
    
    while ( self.var_a1faa64d8c07872e )
    {
        time = gettime();
        
        if ( self.var_661269b3ac878e4c )
        {
            if ( self.armorhealth < self.maxarmorhealth )
            {
                var_12454f0b928bc1d6 = armor::getarmorhealth();
                var_575fa5fcfb8b6b1c = level.zombie_augments[ #"juggernog_shielded" ].var_840d64e41ac5801a ?? 3;
                var_12454f0b928bc1d6 += var_575fa5fcfb8b6b1c;
                self.var_ac875e0060d0ce38 += var_575fa5fcfb8b6b1c;
                armor::setarmorhealth( var_12454f0b928bc1d6 );
                
                if ( self.var_9ef5dcd22c39f926 )
                {
                    thread function_ea0fcb86e1a69395();
                }
                
                plate_health = self.maxarmorhealth / self.platecarrierlevel;
                
                if ( self.var_ac875e0060d0ce38 >= plate_health - 1 )
                {
                    callback::callback( #"hash_42a07c459e05796d" );
                    self.var_ac875e0060d0ce38 = 0;
                }
            }
        }
        else if ( time - self.var_eb543ab8371fc802 >= self.var_9450940fefbe79c8 )
        {
            self.var_661269b3ac878e4c = 1;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace zm_armor
    // Params 0
    // Checksum 0xf18d5548, Offset: 0x1ae8
    // Size: 0xe7, Type: dev
    function setup_armor_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e>", "<dev string:x3d>", &debug_give_armor, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a>", "<dev string:x59>", &debug_give_armor, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x66>", "<dev string:x75>", &debug_give_armor, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x66>", "<dev string:x82>", &function_a0013c4398cc7a8e, 0 );
        devgui::add_devgui_func( "<dev string:x92>", "<dev string:xb1>", &debug_spawn_armor_plates, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc4>", "<dev string:xe6>", &debug_spawn_armor_vest, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfa>", "<dev string:x11c>", &debug_spawn_armor_vest, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x130>", "<dev string:x152>", &debug_spawn_armor_vest, 0 );
        devgui::add_devgui_func( "<dev string:x166>", "<dev string:x171>", &function_6364b6725730302c, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_armor
    // Params 0
    // Checksum 0x18546779, Offset: 0x1bd7
    // Size: 0x7f, Type: dev
    function function_6364b6725730302c()
    {
        foreach ( player in level.players )
        {
            player armor::setarmorhealth( 0 );
        }
    }

    // Namespace zm_armor
    // Params 1
    // Checksum 0xaa541f, Offset: 0x1c5e
    // Size: 0x9a, Type: dev
    function debug_give_armor( params )
    {
        armor_level = int( params[ 0 ] );
        
        foreach ( player in level.players )
        {
            player function_fdbe2cad6d8bb7e7( armor_level );
        }
    }

    // Namespace zm_armor
    // Params 1
    // Checksum 0xf5a7b4d, Offset: 0x1d00
    // Size: 0xc8, Type: dev
    function debug_spawn_armor_vest( params )
    {
        armor_level = int( params[ 0 ] );
        armorvestspawnpoints = utility::getstructarray( "<dev string:x17c>", "<dev string:x18d>" );
        
        foreach ( spawnpoint in armorvestspawnpoints )
        {
            namespace_9d8e359c3b1041e5::spawnnewitemfromscriptablesharedfunc( "<dev string:x198>" + armor_level, spawnpoint.origin, spawnpoint.angles );
        }
    }

    // Namespace zm_armor
    // Params 0
    // Checksum 0x46e2ee82, Offset: 0x1dd0
    // Size: 0xaa, Type: dev
    function debug_spawn_armor_plates()
    {
        armorplatespawnpoints = utility::getstructarray( "<dev string:x1ab>", "<dev string:x18d>" );
        
        foreach ( spawnpoint in armorplatespawnpoints )
        {
            namespace_9d8e359c3b1041e5::spawnnewitemfromscriptablesharedfunc( "<dev string:x1bd>", spawnpoint.origin, spawnpoint.angles );
        }
    }

#/

// Namespace zm_armor
// Params 1
// Checksum 0x1a676549, Offset: 0x1e82
// Size: 0xbd
function function_a0013c4398cc7a8e( params )
{
    foreach ( player in level.players )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"set_golden_armor" ) )
        {
            player utility::callsharedfunc( #"zombie", #"set_golden_armor" );
        }
        
        player function_fdbe2cad6d8bb7e7( 3 );
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0x3600f642, Offset: 0x1f47
// Size: 0xb2
function function_a4a3accaf4842d2c( params )
{
    foreach ( player in level.players )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"take_golden_armor" ) )
        {
            player utility::callsharedfunc( #"zombie", #"take_golden_armor" );
        }
    }
}

// Namespace zm_armor
// Params 1
// Checksum 0x3a13fa29, Offset: 0x2001
// Size: 0x122
function function_e13e43d539369157( params )
{
    playersquadindex = params.player.sessionsquadid;
    var_25f925f48ee1e217 = params.player.sessionuimemberindex;
    
    if ( !squad_utility::issquadmode() )
    {
        var_25f925f48ee1e217 = 0;
        params.player function_47457b9ec007482e( "ui_show_armor_at_squad_index", var_25f925f48ee1e217, 1, params.activate );
        return;
    }
    
    if ( var_25f925f48ee1e217 != -1 )
    {
        foreach ( squadplayer in level.players )
        {
            if ( squadplayer.sessionsquadid == playersquadindex )
            {
                squadplayer function_47457b9ec007482e( "ui_show_armor_at_squad_index", var_25f925f48ee1e217, 1, params.activate );
            }
        }
    }
}

