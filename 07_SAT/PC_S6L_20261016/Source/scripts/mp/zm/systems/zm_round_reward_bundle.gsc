// scripts\mp\zm\systems\zm_round_reward_bundle.gsc  (hash_657b2a82bbbae3f0.gscc) (size: 2201 Bytes / 0x899 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95dc081b (2514225179)
// size ...... 2201 (0x899)
// includes .. 4   (offset: 0x851)
// strings ... 2   (offset: 0x871)
// dev strs .. 1   (offset: 0x88d)
// exports ... 8   (offset: 0x515)
// cseg ...... 0x91 + 0x484 (0x515)
// imports ... 17  (offset: 0x655)
// animtree1 . 0   (offset: 0x899)
// animtree2 . 0   (offset: 0x899)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace zm_round_reward_bundle;

// Namespace zm_round_reward_bundle
// Params 0, eflags: 0x5
// Checksum 0x2e5ddc8e, Offset: 0xaf
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"round_reward_bundle", undefined, undefined, &function_f75faca5a021ce14 );
}

// Namespace zm_round_reward_bundle
// Params 0, eflags: 0x4
// Checksum 0x13442119, Offset: 0xd0
// Size: 0x33
function private function_f75faca5a021ce14()
{
    if ( isdefined( level.var_a5aa4c06a8ae1426 ) )
    {
        return;
    }
    
    level.var_a5aa4c06a8ae1426 = spawnstruct();
    utility::flag_set( "round_reward_bundle_initialized" );
    
    /#
        function_ad56df72cd156833();
    #/
}

// Namespace zm_round_reward_bundle
// Params 3
// Checksum 0x4d524fb2, Offset: 0x10b
// Size: 0xc6
function function_fbc9326d735aa670( var_2effb277747ddf1d = %"zm_round_reward_bundle_default", rewardreference, reward_loc )
{
    if ( isxhashasset( var_2effb277747ddf1d ) )
    {
        var_2effb277747ddf1d = var_2effb277747ddf1d;
    }
    else if ( isstring( var_2effb277747ddf1d ) )
    {
        var_2effb277747ddf1d = "roundrewardbundle:" + var_2effb277747ddf1d;
    }
    
    round_reward_bundle = getscriptbundle( var_2effb277747ddf1d );
    var_453d1489f7ab3219 = isxhash( rewardreference ) ? rewardreference : getxhash( rewardreference );
    var_44561fffd408386a = function_35089264bf4f094b( round_reward_bundle, var_453d1489f7ab3219 );
    
    if ( !isdefined( reward_loc ) )
    {
        reward_loc = ( 0, 0, 0 );
    }
    
    var_a6bdff5762913810 = function_56691545fbd494f7( var_44561fffd408386a, reward_loc );
    return var_a6bdff5762913810.itemspawnlist;
}

// Namespace zm_round_reward_bundle
// Params 3
// Checksum 0xbd97c53b, Offset: 0x1da
// Size: 0x191
function function_8cbad2bff5b7cc1( var_2effb277747ddf1d = %"zm_round_reward_bundle_default", rewardreference, reward_loc )
{
    if ( isxhashasset( var_2effb277747ddf1d ) )
    {
        var_2effb277747ddf1d = var_2effb277747ddf1d;
    }
    else if ( isstring( var_2effb277747ddf1d ) )
    {
        var_2effb277747ddf1d = "roundrewardbundle:" + var_2effb277747ddf1d;
    }
    
    round_reward_bundle = getscriptbundle( var_2effb277747ddf1d );
    var_453d1489f7ab3219 = isxhash( rewardreference ) ? rewardreference : getxhash( rewardreference );
    var_44561fffd408386a = function_35089264bf4f094b( round_reward_bundle, var_453d1489f7ab3219 );
    
    if ( !isdefined( reward_loc ) )
    {
        reward_loc = ( 0, 0, 0 );
    }
    
    var_a6bdff5762913810 = function_56691545fbd494f7( var_44561fffd408386a, reward_loc );
    
    if ( isdefined( var_a6bdff5762913810.var_aa76c22fdd12654 ) && isdefined( var_a6bdff5762913810.var_aca5a22fdf74676 ) )
    {
        if ( var_a6bdff5762913810.var_aa76c22fdd12654 == var_a6bdff5762913810.var_aca5a22fdf74676 || var_a6bdff5762913810.var_aa76c22fdd12654 > var_a6bdff5762913810.var_aca5a22fdf74676 )
        {
            assert( var_a6bdff5762913810.var_aa76c22fdd12654 <= var_a6bdff5762913810.var_aca5a22fdf74676, "<dev string:x24>" );
            item_count = var_a6bdff5762913810.var_aa76c22fdd12654;
        }
        else
        {
            item_count = randomintrange( var_a6bdff5762913810.var_aa76c22fdd12654, var_a6bdff5762913810.var_aca5a22fdf74676 + 1 );
        }
    }
    
    if ( !isdefined( item_count ) )
    {
        item_count = 1;
    }
    
    var_aaf013937e69a716 = common_item::items_selectfromlist( var_a6bdff5762913810.itemspawnlist, item_count );
    return var_aaf013937e69a716;
}

// Namespace zm_round_reward_bundle
// Params 2
// Checksum 0x52df7f9b, Offset: 0x374
// Size: 0xa8
function function_35089264bf4f094b( round_reward_bundle, var_453d1489f7ab3219 )
{
    foreach ( reward_bundle in round_reward_bundle.reward_bundles )
    {
        if ( var_453d1489f7ab3219 == reward_bundle.rewardreference )
        {
            return reward_bundle;
        }
    }
    
    return round_reward_bundle.reward_bundles[ 0 ];
}

// Namespace zm_round_reward_bundle
// Params 2
// Checksum 0x61c519f6, Offset: 0x425
// Size: 0xe2
function function_56691545fbd494f7( var_44561fffd408386a, reward_loc )
{
    foreach ( var_a6bdff5762913810 in var_44561fffd408386a.var_4510f02dc55f01b9 )
    {
        n_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( reward_loc );
        
        if ( n_round < var_a6bdff5762913810.minround )
        {
            continue;
        }
        
        if ( var_a6bdff5762913810.maxround != 0 && n_round > var_a6bdff5762913810.maxround )
        {
            continue;
        }
        
        return var_a6bdff5762913810;
    }
    
    return var_44561fffd408386a.var_4510f02dc55f01b9[ 0 ];
}

/#

    // Namespace zm_round_reward_bundle
    // Params 0, eflags: 0x4
    // Checksum 0x57e28c64, Offset: 0x510
    // Size: 0x5, Type: dev
    function private function_ad56df72cd156833()
    {
        
    }

#/
