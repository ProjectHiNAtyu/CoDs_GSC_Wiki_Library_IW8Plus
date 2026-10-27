// scripts\mp\loot\common_item_lootkey.gsc  (hash_480ac8eb154c8bac.gscc) (size: 3605 Bytes / 0xe15 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x260a3ce6 (638205158)
// size ...... 3605 (0xe15)
// includes .. 6   (offset: 0xcdd)
// strings ... 13  (offset: 0xd0d)
// dev strs .. 6   (offset: 0xdc9)
// exports ... 9   (offset: 0x875)
// cseg ...... 0x15e + 0x717 (0x875)
// imports ... 27  (offset: 0x9dd)
// animtree1 . 0   (offset: 0xe15)
// animtree2 . 0   (offset: 0xe15)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace item_lootkey;

// Namespace item_lootkey
// Params 0, eflags: 0x5
// Checksum 0x2b50a9f1, Offset: 0x17c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_lootkey", #"common_item", &init_item_lootkey, undefined );
}

// Namespace item_lootkey
// Params 0
// Checksum 0x349114de, Offset: 0x1a5
// Size: 0x131
function init_item_lootkey()
{
    if ( !isdefined( level.lootkey_info ) )
    {
        level.lootkey_info = spawnstruct();
    }
    
    if ( !isdefined( level.gamemodebundle.lootkeybundle ) )
    {
        return;
    }
    
    var_c6d327b881d9b04b = getscriptbundle( level.gamemodebundle.lootkeybundle );
    
    if ( !isdefined( var_c6d327b881d9b04b ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    var_89006a1c264456aa = getscriptbundle( hashcat( %"hash_2ecd0e6a15cf428b", level.mapname, "_lootkey_bundle" ) );
    level.lootkey_info.lootkeybundle = var_89006a1c264456aa ?? var_c6d327b881d9b04b;
    
    if ( !isdefined( level.lootkey_info.lootkeybundle ) )
    {
        return;
    }
    
    if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "lootkey" );
    common_item::function_84174b793b5fe9a7( "lootkey", #"use", &function_553a21b99a568a87 );
    common_item::function_84174b793b5fe9a7( "lootkey", #"canautouse", &utility::always_true );
    
    /#
        level thread function_ad090627e3ca61b4();
    #/
}

// Namespace item_lootkey
// Params 4
// Checksum 0x743a4527, Offset: 0x2de
// Size: 0x1d9, Type: bool
function function_553a21b99a568a87( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( item.var_4631081df2c3fb6a )
    {
        if ( isdefined( item.owner ) && item.owner != self )
        {
            return true;
        }
        
        if ( isdefined( item ) && isdefined( item.root ) )
        {
            item.root delete();
        }
    }
    
    if ( isdefined( self.n_loot_key_level ) && self.n_loot_key_level != 0 )
    {
        var_fcaa4d3a5ca6121d = [ "", "zmloot_lootkey_small", "zmloot_lootkey_medium", "zmloot_lootkey_large", "zmloot_lootkey_legendary" ][ self.n_loot_key_level ];
        common_item::items_spawnnewitemfromscriptable( var_fcaa4d3a5ca6121d, self.origin );
    }
    
    for ( i = 1; i < [ "", "t10_zm_lootkey_small", "t10_zm_lootkey_medium", "t10_zm_lootkey_large", "t10_zm_lootkey_legendary" ].size ; i++ )
    {
        if ( itembundle.ref == [ "", "t10_zm_lootkey_small", "t10_zm_lootkey_medium", "t10_zm_lootkey_large", "t10_zm_lootkey_legendary" ][ i ] )
        {
            self.n_loot_key_level = i;
            break;
        }
    }
    
    sparams = { #owner:self };
    
    if ( isdefined( self.n_loot_key_level ) && self.n_loot_key_level != 0 )
    {
        sparams.var_41f8529e24f6fb4b = self.n_loot_key_level;
    }
    
    callback::callback( "lootkey_used", sparams );
    return false;
}

// Namespace item_lootkey
// Params 1
// Checksum 0xf25abdbc, Offset: 0x4c0
// Size: 0x17f
function on_ai_killed( params )
{
    if ( self.var_48960fedb514aedd || self.var_a13bed1ac47e1b2c || self.var_f7fb30c6fe83c8e3 )
    {
        return;
    }
    
    n_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    
    if ( n_round > 0 && n_round < 15 )
    {
        var_48e5ffcba8be38a6 = level.lootkey_info.lootkeybundle.var_43bfb2f05feb9a16;
    }
    else if ( n_round >= 15 && n_round < 25 )
    {
        var_48e5ffcba8be38a6 = level.lootkey_info.lootkeybundle.var_43bfb1f05feb97e3;
    }
    else if ( n_round >= 25 && n_round < 35 )
    {
        var_48e5ffcba8be38a6 = level.lootkey_info.lootkeybundle.var_43bfb0f05feb95b0;
    }
    else if ( n_round >= 35 )
    {
        var_48e5ffcba8be38a6 = level.lootkey_info.lootkeybundle.var_43bfb7f05feba515;
    }
    
    if ( !isdefined( var_48e5ffcba8be38a6 ) )
    {
        var_48e5ffcba8be38a6 = level.lootkey_info.lootkeybundle.var_43bfb2f05feb9a16;
    }
    
    if ( isdefined( self.aicategory ) && self.aicategory != "normal" )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin );
        common_item::function_38cde6a6acb68ea6( var_48e5ffcba8be38a6, 1, spawnoptions );
    }
}

// Namespace item_lootkey
// Params 1
// Checksum 0xae9dd694, Offset: 0x647
// Size: 0xc1
function get_lootkey_reward_list( reward_level )
{
    assert( isint( reward_level ), "<dev string:x4d>" );
    str_reward_list = [ undefined, level.lootkey_info.lootkeybundle.var_feb6862a1ab64082, level.lootkey_info.lootkeybundle.var_8fcb8c7b05279bd0, level.lootkey_info.lootkeybundle.var_5905e18773b9aefe, level.lootkey_info.lootkeybundle.var_73d2627deb8eef2c ][ reward_level ];
    
    if ( isdefined( str_reward_list ) )
    {
        return str_reward_list;
    }
}

// Namespace item_lootkey
// Params 1
// Checksum 0x4a6e788f, Offset: 0x711
// Size: 0xe9
function get_lootkey_reward_level( var_d9906d678f78a3fa )
{
    assert( isxhashasset( var_d9906d678f78a3fa ), "<dev string:x87>" );
    var_571861311f1508e0 = [ undefined, level.lootkey_info.lootkeybundle.var_feb6862a1ab64082, level.lootkey_info.lootkeybundle.var_8fcb8c7b05279bd0, level.lootkey_info.lootkeybundle.var_5905e18773b9aefe, level.lootkey_info.lootkeybundle.var_73d2627deb8eef2c ];
    
    for ( i = 0; i < var_571861311f1508e0.size + 1 ; i++ )
    {
        lootkeybundle = var_571861311f1508e0[ i ];
        
        if ( lootkeybundle == var_d9906d678f78a3fa )
        {
            return i;
        }
    }
}

/#

    // Namespace item_lootkey
    // Params 0, eflags: 0x4
    // Checksum 0x2ab27c27, Offset: 0x803
    // Size: 0x2e, Type: dev
    function private function_ad090627e3ca61b4()
    {
        devgui::function_9082edeb5db93280( "<dev string:xc9>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdb>", "<dev string:xdb>", &function_432dce99190e4555 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace item_lootkey
    // Params 1
    // Checksum 0x1437da85, Offset: 0x839
    // Size: 0x3c, Type: dev
    function function_432dce99190e4555( a_params )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( level.players[ 0 ] );
        common_item::function_38cde6a6acb68ea6( "<dev string:xf1>", 9, spawnoptions );
    }

#/
