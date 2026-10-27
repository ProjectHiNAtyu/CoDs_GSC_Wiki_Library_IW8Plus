// script_68bc09e23284a3db  (hash_68bc09e23284a3db.gscc) (size: 1764 Bytes / 0x6e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x938a2edc (2475306716)
// size ...... 1764 (0x6e4)
// includes .. 4   (offset: 0x6b8)
// strings ... 1   (offset: 0x6d8)
// dev strs .. 0   (offset: 0x6e4)
// exports ... 6   (offset: 0x414)
// cseg ...... 0x6b + 0x3a9 (0x414)
// imports ... 15  (offset: 0x504)
// animtree1 . 0   (offset: 0x6e4)
// animtree2 . 0   (offset: 0x6e4)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\loot\common_item;

#namespace namespace_8bccee4a1ef68229;

// Namespace namespace_8bccee4a1ef68229
// Params 0, eflags: 0x5
// Checksum 0xb116aee8, Offset: 0x89
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ccfb9db009a6c2d4", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_8bccee4a1ef68229
// Params 0, eflags: 0x4
// Checksum 0xfb719d9d, Offset: 0xb2
// Size: 0xcb
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    /#
        level.package_airdrop.droppeditems = [];
    #/
    
    utility::registersharedfunc( #"can_airdrop_package", #"loot", &utility::always_true );
    utility::registersharedfunc( #"hash_c0543f4480543c68", #"loot", &function_a1b78d399321671b );
    utility::registersharedfunc( #"hash_270838ed4fd5716e", #"loot", &utility::empty_init_func );
    
    /#
        utility::registersharedfunc( #"hash_957e5882bc1fa7c5", #"loot", &debug_deleteall );
        utility::registersharedfunc( #"hash_da0b3038771ec485", #"loot", &debug_drawlocations );
    #/
}

// Namespace namespace_8bccee4a1ef68229
// Params 5, eflags: 0x4
// Checksum 0x1c794b42, Offset: 0x185
// Size: 0x125
function private function_a1b78d399321671b( airdropsettings, dropposition, dropdestination, dropangles, initialvelocity )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    itemspawnentry = packagesettings.itemspawnentry;
    
    if ( !isdefined( itemspawnentry ) )
    {
        return;
    }
    
    groundlocation = airdrop_scriptbundle::function_15ad4ce1fcf6748f( dropdestination, 1 );
    itembundle = getscriptbundle( "itemspawnentry:" + itemspawnentry );
    item = common_item::function_47324f290423b2d1( itembundle, dropdestination, groundlocation + ( 0, 0, 20 ), undefined, 1 );
    
    /#
        level.package_airdrop.droppeditems[ level.package_airdrop.droppeditems.size ] = item;
        item.var_45394fecf9989389 = airdropsettings.airdropidentifier;
    #/
    
    return item;
}

/#

    // Namespace namespace_8bccee4a1ef68229
    // Params 0
    // Checksum 0xca93c775, Offset: 0x2b3
    // Size: 0xa7, Type: dev
    function debug_deleteall()
    {
        foreach ( item in level.package_airdrop.droppeditems )
        {
            if ( !item )
            {
                continue;
            }
            
            level thread common_item::function_869d7676e359a627( item );
        }
        
        level.package_airdrop.droppeditems = [];
    }

    // Namespace namespace_8bccee4a1ef68229
    // Params 0
    // Checksum 0x593c66f2, Offset: 0x362
    // Size: 0xb2, Type: dev
    function debug_drawlocations()
    {
        foreach ( item in level.package_airdrop.droppeditems )
        {
            if ( !item )
            {
                continue;
            }
            
            airdrop_scriptbundle::function_cbfae468752db826( item.origin, item.var_45394fecf9989389, ( 1, 1, 0 ) );
        }
    }

#/
