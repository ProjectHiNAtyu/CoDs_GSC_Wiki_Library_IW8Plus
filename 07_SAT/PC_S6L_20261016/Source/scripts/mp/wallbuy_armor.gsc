// scripts\mp\wallbuy_armor.gsc  (hash_2bebb4f5a2ed42a0.gscc) (size: 6144 Bytes / 0x1800 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8d61d9d5 (2372000213)
// size ...... 6144 (0x1800)
// includes .. 6   (offset: 0x1720)
// strings ... 12  (offset: 0x1750)
// dev strs .. 1   (offset: 0x17f4)
// exports ... 13  (offset: 0x1054)
// cseg ...... 0x173 + 0xee1 (0x1054)
// imports ... 41  (offset: 0x125c)
// animtree1 . 0   (offset: 0x1800)
// animtree2 . 0   (offset: 0x1800)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\currency;
#using scripts\mp\wallbuy;

#namespace wallbuy_armor;

// Namespace wallbuy_armor
// Params 0, eflags: 0x5
// Checksum 0x14550aee, Offset: 0x191
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"wallbuy_armor", undefined, &__init__, undefined );
}

// Namespace wallbuy_armor
// Params 0
// Checksum 0x1cbdf2af, Offset: 0x1b2
// Size: 0x21
function __init__()
{
    if ( level.gametypebundle.var_c1e5bbace58c9528 )
    {
        return;
    }
    
    level thread function_c3daf070dd67a8ad();
}

// Namespace wallbuy_armor
// Params 0
// Checksum 0xfd140b01, Offset: 0x1db
// Size: 0x82
function function_c3daf070dd67a8ad()
{
    if ( !isdefined( level.wallbuybundle ) )
    {
        var_1cd4c25867e233df = level.gametypebundle.wallbuybundle ?? level.gamemodebundle.wallbuybundle;
        level.wallbuybundle = getscriptbundle( "wallbuy:" + var_1cd4c25867e233df );
    }
    
    level thread wallbuy::function_2cf9e927b4199326( "armor", &function_d9ce172cabad49e5, &function_1438ad39ca2bfa4f );
    callback::add( "on_variant_wallbuy_spawn", &on_variant_wallbuy_spawn );
}

// Namespace wallbuy_armor
// Params 1
// Checksum 0x631b7dd9, Offset: 0x265
// Size: 0x3a7
function function_d9ce172cabad49e5( player )
{
    if ( !isplayer( player ) || !( isdefined( self.cost ) && isdefined( self.var_8a968ea891a86d04 ) ) )
    {
        assert( "<dev string:x24>" );
        return;
    }
    
    if ( player.var_e830497a1d286f74 )
    {
        return;
    }
    
    if ( player.var_cdbf0145adf184dc )
    {
        return;
    }
    
    if ( player.interactions_disabled )
    {
        return;
    }
    
    if ( !isdefined( player.platecarrierlevel ) )
    {
        return;
    }
    
    if ( wallbuy::function_3401a0a7b55ffbdb() )
    {
        if ( level.zm_relic_tier >= 1 )
        {
            armor_level = minint( 4, player.platecarrierlevel + 1 );
        }
        else
        {
            armor_level = minint( 3, player.platecarrierlevel + 1 );
        }
        
        cost = function_1120cf142efa395d( player.platecarrierlevel );
    }
    else
    {
        cost = self.cost;
        cost = function_58457386981c809b( player, cost );
        cost = function_5582d066c46c93be( player, cost );
        armor_level = self.armorlevel ?? 2;
    }
    
    if ( player.platecarrierlevel > armor_level )
    {
        armor_level = player.platecarrierlevel;
    }
    
    if ( isdefined( player.armorhealth ) && isdefined( armor_level ) && !player function_ca7c032b14c70c53( armor_level ) && !player.var_a1faa64d8c07872e )
    {
        if ( player currency::attempt_purchase( level.wallbuy_currency_type, cost, 1, undefined, #"wallbuy" ) )
        {
            if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
            {
                armor_level = 3;
                params = spawnstruct();
                params.player = player;
                params.activate = 1;
                player callback::callback( "toggle_squad_armor", params );
            }
            
            if ( !isdefined( self.var_d83402b3befb78d6 ) )
            {
                target_angle = self.angles + ( 0, 0, 90 );
                var_d83402b3befb78d6 = utility::spawn_model( self.wallbuy_spawn_model, self.origin, target_angle );
                var_d83402b3befb78d6.angles = var_d83402b3befb78d6.angles;
                self.var_d83402b3befb78d6 = var_d83402b3befb78d6;
                var_5534ee0990246282 = ( 0, 0, -5 );
                var_cd42b2a7832a77a8 = var_d83402b3befb78d6 localtoworldcoords( var_5534ee0990246282 );
                var_d83402b3befb78d6 notsolid();
                var_177018b3984d2e6a = ( 0, 0, 0.5 );
                var_c6ec37af26231409 = 0.75;
                targetposworld = var_d83402b3befb78d6 localtoworldcoords( var_177018b3984d2e6a );
                var_d83402b3befb78d6.origin = var_cd42b2a7832a77a8;
                var_d83402b3befb78d6 moveto( targetposworld, var_c6ec37af26231409 );
            }
            
            player playsoundtoplayer( #"hash_6cd86061dc419bd0", player );
            player function_fdbe2cad6d8bb7e7( armor_level );
            
            if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
            {
                armor_level = 4;
            }
            
            if ( armor_level == 4 )
            {
                if ( utility::issharedfuncdefined( #"zombie", #"set_golden_armor" ) )
                {
                    player utility::callsharedfunc( #"zombie", #"set_golden_armor" );
                }
            }
            
            params = spawnstruct();
            params.cost = cost;
            params.armor_level = armor_level;
            params.currency = level.wallbuy_currency_type;
            player callback::callback( "wallbuy_armor_purchased", params );
        }
        
        return;
    }
    
    player playsoundtoplayer( #"ui_zm_core_purchase_deny", player );
}

// Namespace wallbuy_armor
// Params 1, eflags: 0x4
// Checksum 0x16aeef70, Offset: 0x614
// Size: 0xc8
function private function_1120cf142efa395d( var_e3e674f76a2d3c7 )
{
    cost = 0;
    
    if ( var_e3e674f76a2d3c7 == 3 || level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        if ( level.zm_relic_tier >= 1 || level.zm_mode_modifiers.var_2dc492758425fa76 )
        {
            var_4937b99bf84f9a8c = get_golden_armor_bundle();
            cost = var_4937b99bf84f9a8c.costbase;
        }
        else
        {
            var_4937b99bf84f9a8c = wallbuy::function_7cd289ee83ffd8d2( var_e3e674f76a2d3c7 );
            cost = var_4937b99bf84f9a8c.costrefill;
        }
        
        return cost;
    }
    
    var_92f04b3737b46357 = var_e3e674f76a2d3c7 + 1;
    bundleinfo = wallbuy::function_7cd289ee83ffd8d2( var_92f04b3737b46357 );
    cost = bundleinfo.costbase;
    return cost;
}

// Namespace wallbuy_armor
// Params 2
// Checksum 0x65ecb66c, Offset: 0x6e5
// Size: 0x5c1
function function_1438ad39ca2bfa4f( usable, player )
{
    var_78a9bbaea0e11692 = abs( usable.origin[ 2 ] - 80 - player.origin[ 2 ] );
    
    if ( var_78a9bbaea0e11692 > 80 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.var_e830497a1d286f74 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.var_cdbf0145adf184dc )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( !isdefined( player.platecarrierlevel ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( wallbuy::function_3401a0a7b55ffbdb() )
    {
        if ( level.zm_relic_tier >= 1 && hasomnvar( "ui_zm_relic_tier" ) )
        {
            var_90269f24164ee19a = minint( 4, player.platecarrierlevel + 1 );
        }
        else
        {
            var_90269f24164ee19a = minint( 3, player.platecarrierlevel + 1 );
        }
        
        var_f212cad60adb9d48 = usable function_1120cf142efa395d( player.platecarrierlevel );
    }
    else
    {
        if ( !isdefined( usable.armorlevel ) )
        {
            usable.armorlevel = 1;
        }
        
        switch ( usable.scriptablename )
        {
            case #"hash_2e1a3e386a30e918":
                usable.armorlevel = 2;
                break;
            case #"hash_185a9dad52084255":
                usable.armorlevel = 3;
                break;
            default:
                usable.armorlevel = 1;
                break;
        }
        
        if ( usable.var_7ffbc1821f2b0602 == #"wallbuy_zm_t10_armor_legendary" )
        {
            usable.armorlevel = 4;
        }
        
        var_f212cad60adb9d48 = usable.cost;
        bundleinfo = wallbuy::function_b1ac1ed5869786d9( usable.scriptablename );
        var_90269f24164ee19a = usable.armorlevel;
        
        if ( !isdefined( bundleinfo ) )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        var_f212cad60adb9d48 = usable function_58457386981c809b( player, var_f212cad60adb9d48 );
        var_f212cad60adb9d48 = usable function_5582d066c46c93be( player, var_f212cad60adb9d48 );
    }
    
    if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        var_90269f24164ee19a = 4;
    }
    
    var_bacc0c211bfcfcac = player currency::get_currency_amount( #"essence" );
    description = &"CP_ZMB/ARMOR1_DESC";
    hint_title = &"";
    
    switch ( var_90269f24164ee19a )
    {
        case 1:
            description = &"CP_ZMB/ARMOR1_DESC";
            hint_title = &"SHARED_HINTSTRINGS/WALLBUY_ARMOR_HINT_LEVEL_II";
            break;
        case 2:
            description = &"CP_ZMB/ARMOR2_DESC";
            hint_title = &"SHARED_HINTSTRINGS/WALLBUY_ARMOR_HINT_LEVEL_II";
            break;
        case 3:
            description = &"CP_ZMB/ARMOR3_DESC";
            hint_title = &"SHARED_HINTSTRINGS/WALLBUY_ARMOR_HINT_LEVEL_III";
            break;
        case 4:
            if ( isdefined( level.var_c3cbabc25cac9c8e ) )
            {
                description = level.var_c3cbabc25cac9c8e.var_ecaed48dad41d0ff;
                hint_title = level.var_c3cbabc25cac9c8e.var_b08116dcb1125b8;
            }
            
            break;
    }
    
    hint_data = { #icon:"ui_icon_zm_ping_armor", #icon_text_value:var_f212cad60adb9d48, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #description:description, #title:hint_title, #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #params:[ var_f212cad60adb9d48, &"" ], #type:"HINT_BUTTON" };
    
    if ( player.var_a1faa64d8c07872e && isdefined( level.var_c3cbabc25cac9c8e ) )
    {
        hint_data.title = &"CP_ZMB/ARMOR_REPAIR";
        hint_data.description = &"CP_ZMB/ARMOR_REPAIR_DESC";
        hint_data.aux_text = level.var_c3cbabc25cac9c8e.var_6e3d7e8c2200dae7;
        hint_data.icon_text_value = &"";
        hint_data.interactable = 0;
        return hint_data;
    }
    
    if ( var_bacc0c211bfcfcac < var_f212cad60adb9d48 )
    {
        hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hint_data.interactable = 0;
    }
    else if ( player.platecarrierlevel < var_90269f24164ee19a )
    {
    }
    else
    {
        if ( player.platecarrierlevel == 3 )
        {
            bundleinfo = wallbuy::function_7cd289ee83ffd8d2( player.platecarrierlevel );
        }
        
        hint_data.title = &"CP_ZMB/ARMOR_REPAIR";
        hint_data.description = &"CP_ZMB/ARMOR_REPAIR_DESC";
        
        if ( player function_ca7c032b14c70c53( player.platecarrierlevel ) )
        {
            hint_data.aux_text = &"CP_ZMB/ARMOR_FULL";
            hint_data.interactable = 0;
        }
    }
    
    return hint_data;
}

// Namespace wallbuy_armor
// Params 1
// Checksum 0x427a8be5, Offset: 0xcaf
// Size: 0xf0
function function_fdbe2cad6d8bb7e7( platecarrierlevel )
{
    var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 50;
    var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 100;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 150;
    platecarrierlevel = minint( 3, platecarrierlevel );
    self.platecarrierlevel = platecarrierlevel;
    
    if ( platecarrierlevel == 1 )
    {
        self.maxarmorhealth = var_219886ad4a381968;
        armor::setarmorhealth( var_219886ad4a381968 );
    }
    else if ( platecarrierlevel == 2 )
    {
        self.maxarmorhealth = var_554023bac16105cf;
        armor::setarmorhealth( var_554023bac16105cf );
    }
    else if ( platecarrierlevel == 3 )
    {
        self.maxarmorhealth = var_3dc0c4e27d22d986;
        armor::setarmorhealth( var_3dc0c4e27d22d986 );
    }
    
    self setclientomnvar( "ui_armor_current_level", platecarrierlevel );
}

// Namespace wallbuy_armor
// Params 2
// Checksum 0xa6acdfa9, Offset: 0xda7
// Size: 0x6b
function function_58457386981c809b( player, cost )
{
    newcost = cost;
    armorlvl = self.armorlevel ?? 1;
    
    if ( armorlvl >= 3 && player.platecarrierlevel > 1 && armorlvl != 4 )
    {
        newcost = self.costalternate;
    }
    
    return newcost;
}

// Namespace wallbuy_armor
// Params 2
// Checksum 0x38857ad5, Offset: 0xe1b
// Size: 0xa0
function function_5582d066c46c93be( player, cost )
{
    newcost = cost;
    refilllvl = self.armorlevel ?? 1;
    
    if ( refilllvl == 4 )
    {
        return newcost;
    }
    
    if ( player.platecarrierlevel == refilllvl )
    {
        newcost = self.costrefill;
    }
    else if ( player.platecarrierlevel == 3 )
    {
        var_4937b99bf84f9a8c = wallbuy::function_7cd289ee83ffd8d2( player.platecarrierlevel );
        newcost = var_4937b99bf84f9a8c.costrefill;
    }
    
    return newcost;
}

// Namespace wallbuy_armor
// Params 1
// Checksum 0xb9064213, Offset: 0xec4
// Size: 0xc9, Type: bool
function function_ca7c032b14c70c53( armorlvl )
{
    var_219886ad4a381968 = level.var_1e9e024bcfca2274.var_3839236eb9dabdc4 ?? 50;
    var_554023bac16105cf = level.var_1e9e024bcfca2274.var_ba2fc513d06dd9d5 ?? 100;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 150;
    
    if ( armorlvl == 1 )
    {
        if ( self.armorhealth >= var_219886ad4a381968 )
        {
            return true;
        }
    }
    else if ( armorlvl == 2 )
    {
        if ( self.armorhealth >= var_554023bac16105cf )
        {
            return true;
        }
    }
    else if ( armorlvl == 3 )
    {
        if ( self.armorhealth >= var_3dc0c4e27d22d986 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace wallbuy_armor
// Params 1, eflags: 0x4
// Checksum 0xcde23bd7, Offset: 0xf96
// Size: 0x7e
function private on_variant_wallbuy_spawn( params )
{
    if ( !isdefined( self.scriptablename ) )
    {
        return;
    }
    
    if ( getxhash( self.scriptablename ) == #"wallbuy_zm_t10_armor_legendary" && !isdefined( level.var_c3cbabc25cac9c8e ) )
    {
        level.var_c3cbabc25cac9c8e = getscriptbundle( level.wallbuybundle.var_b4e9f711cc353b61 );
    }
    
    if ( wallbuy::function_3401a0a7b55ffbdb() )
    {
        utility::function_7c10ea82c1e305b8( "wallbuy", "universal" );
    }
}

// Namespace wallbuy_armor
// Params 0
// Checksum 0x400c0c1b, Offset: 0x101c
// Size: 0x37
function get_golden_armor_bundle()
{
    if ( !isdefined( level.var_c3cbabc25cac9c8e ) )
    {
        level.var_c3cbabc25cac9c8e = getscriptbundle( level.wallbuybundle.var_b4e9f711cc353b61 );
    }
    
    return level.var_c3cbabc25cac9c8e;
}

