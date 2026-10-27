// scripts\mp\purchasemenu.gsc  (hash_4269c5cb8b71e86e.gscc) (size: 4892 Bytes / 0x131c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2196cbe1 (563530721)
// size ...... 4892 (0x131c)
// includes .. 1   (offset: 0x12fc)
// strings ... 2   (offset: 0x1304)
// dev strs .. 0   (offset: 0x131c)
// exports ... 13  (offset: 0xf2c)
// cseg ...... 0xa9 + 0xe83 (0xf2c)
// imports ... 13  (offset: 0x1134)
// animtree1 . 0   (offset: 0x131c)
// animtree2 . 0   (offset: 0x131c)
#using scripts\mp\common\utility\game_utility;

#namespace purchasemenu;

// Namespace purchasemenu
// Params 0
// Checksum 0x4ca87ae1, Offset: 0xc7
// Size: 0x214
function init()
{
    level.purchasemenu = [];
    purchasemenulist = level.gametypebundle.purchasemenulist ?? level.gamemodebundle.purchasemenulist;
    mapinfo = getactivemapinfobundle();
    
    if ( mapinfo.var_d2bd519e7bd218b6 && game_utility::function_21211f3255f8ea58() )
    {
        ignoreditems = mapinfo.var_d2bd519e7bd218b6;
    }
    else if ( mapinfo.var_58e3fe167604f088 )
    {
        ignoreditems = mapinfo.var_58e3fe167604f088;
    }
    
    var_683bce87d658b588 = undefined;
    
    if ( ignoreditems && isxhashasset( ignoreditems ) )
    {
        var_683bce87d658b588 = getscriptbundle( ignoreditems );
    }
    
    if ( isdefined( purchasemenulist ) )
    {
        var_7670200ae2711ca9 = getscriptbundle( purchasemenulist );
        
        if ( isdefined( level.var_73019dea778c47e6 ) )
        {
            var_7670200ae2711ca9 = getscriptbundle( level.var_73019dea778c47e6 );
        }
        
        if ( isdefined( var_7670200ae2711ca9 ) && isdefined( var_7670200ae2711ca9.purchasemenus ) )
        {
            foreach ( i, menu in var_7670200ae2711ca9.purchasemenus )
            {
                if ( isdefined( menu.menuref ) )
                {
                    level.purchasemenu[ menu.menuref ] = function_7b1d4491df5154b1( menu.purchasemenu, var_683bce87d658b588 );
                    
                    if ( isdefined( level.purchasemenu[ menu.menuref ] ) )
                    {
                        level.purchasemenu[ menu.menuref ].id = i + 1;
                        level.purchasemenu[ menu.menuref ].ref = menu.menuref;
                    }
                }
            }
        }
    }
}

// Namespace purchasemenu
// Params 2
// Checksum 0x23c7c915, Offset: 0x2e3
// Size: 0x2b9
function create_item_struct( menuref, itemindex )
{
    if ( !( isdefined( menuref ) && isdefined( itemindex ) && isdefined( level.purchasemenu[ menuref ] ) ) )
    {
        return;
    }
    
    item = level.purchasemenu[ menuref ].items[ itemindex ];
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    item_bundle = getscriptbundle( item.asset );
    
    if ( isdefined( item_bundle ) )
    {
        var_30f37d57a23dc69f = spawnstruct();
        var_30f37d57a23dc69f.cost = item_bundle.cost;
        var_30f37d57a23dc69f.scriptable_name = item_bundle.scriptablename;
        var_30f37d57a23dc69f.tier = item_bundle.tier;
        var_30f37d57a23dc69f.itemref = item_bundle.itemref;
        var_30f37d57a23dc69f.itemid = item_bundle.itemid;
        var_30f37d57a23dc69f.itemamount = item_bundle.itemamount;
        var_30f37d57a23dc69f.var_87bb7cc888933731 = item_bundle.var_87bb7cc888933731;
        var_30f37d57a23dc69f.maxstack = item_bundle.maxstack;
        var_30f37d57a23dc69f.category = item.category;
        var_30f37d57a23dc69f.var_b487b5b7ae379493 = item.var_b487b5b7ae379493;
        var_30f37d57a23dc69f.var_f5fec69ffd2456b2 = item.var_f5fec69ffd2456b2;
        var_30f37d57a23dc69f.globalindex = item.globalindex;
        var_30f37d57a23dc69f.var_7e02ec01953711b4 = item_bundle.var_7e02ec01953711b4;
        var_30f37d57a23dc69f.purchaselimit = item_bundle.purchaselimit;
        var_30f37d57a23dc69f.var_fd31b7199454f3b6 = item_bundle.var_fd31b7199454f3b6;
        tab_struct = level.purchasemenu[ menuref ].var_256445803195385a[ item_bundle.var_f5fec69ffd2456b2 ];
        var_30f37d57a23dc69f.var_9281c8f5b1f3b37a = tab_struct.var_9084bbdf86f67435 ?? level.purchasemenu[ menuref ].var_9084bbdf86f67435;
        var_30f37d57a23dc69f.var_ac7c10eb14c9d6e0 = tab_struct.var_c86efb1efa075fb7 ?? level.purchasemenu[ menuref ].var_c86efb1efa075fb7;
        
        if ( isdefined( item_bundle.currency ) )
        {
            var_cfadee1896fda9ba = getscriptbundle( item_bundle.currency );
            
            if ( isdefined( var_cfadee1896fda9ba ) )
            {
                var_30f37d57a23dc69f.currency = var_cfadee1896fda9ba.currencyname;
            }
        }
        
        return var_30f37d57a23dc69f;
    }
}

// Namespace purchasemenu
// Params 1
// Checksum 0x1ecd0f0c, Offset: 0x5a4
// Size: 0xa0, Type: bool
function is_item_valid( itemstruct )
{
    if ( isdefined( itemstruct ) && isdefined( itemstruct.purchaseitem ) )
    {
        itembundle = getscriptbundlefieldvalues( itemstruct.purchaseitem, [ #"hash_933481706d639bc7", #"hash_b32a46624ffc3379" ] );
        
        if ( isdefined( itembundle ) )
        {
            hidefromdvar = isdefined( itembundle.dvaritem ) && ( !getdvarint( itembundle.dvaritem, 0 ) ?? 0 );
            return !( itembundle.hideinmenu || hidefromdvar );
        }
    }
    
    return false;
}

// Namespace purchasemenu
// Params 2
// Checksum 0x324e523c, Offset: 0x64d
// Size: 0x5da
function function_7b1d4491df5154b1( var_3758daba4278fb56, var_683bce87d658b588 )
{
    if ( !isdefined( var_3758daba4278fb56 ) )
    {
        return;
    }
    
    var_24729d845f9dc3fb = spawnstruct();
    var_24729d845f9dc3fb.var_256445803195385a = [];
    var_24729d845f9dc3fb.items = [];
    var_97b3e9cf58ddeff5 = getscriptbundle( var_3758daba4278fb56 );
    var_24729d845f9dc3fb.var_912dc9ccec6a110c = var_97b3e9cf58ddeff5.var_47f08be5559f4c77;
    var_24729d845f9dc3fb.var_8a64e37068076a47 = var_97b3e9cf58ddeff5.var_77c74a9d8054eb0e;
    var_24729d845f9dc3fb.var_518864f924edcfb6 = var_97b3e9cf58ddeff5.var_518864f924edcfb6;
    var_24729d845f9dc3fb.soundopenmenu = var_97b3e9cf58ddeff5.soundopenmenu;
    var_24729d845f9dc3fb.soundclosemenu = var_97b3e9cf58ddeff5.soundclosemenu;
    var_24729d845f9dc3fb.var_9084bbdf86f67435 = var_97b3e9cf58ddeff5.var_9084bbdf86f67435;
    var_24729d845f9dc3fb.var_c86efb1efa075fb7 = var_97b3e9cf58ddeff5.var_c86efb1efa075fb7;
    var_b487b5b7ae379493 = 1;
    
    if ( isdefined( var_97b3e9cf58ddeff5.var_6a003cae79cda7a6 ) )
    {
        tablist_bundle = getscriptbundle( var_97b3e9cf58ddeff5.var_6a003cae79cda7a6 );
        globalindex = 1;
        
        if ( isdefined( tablist_bundle ) && isdefined( tablist_bundle.var_8d6107fd79dbbce0 ) )
        {
            foreach ( tab in tablist_bundle.var_8d6107fd79dbbce0 )
            {
                var_246a3da0cced05b6 = getscriptbundle( tab.var_6465f12debc12fd3 );
                
                if ( isdefined( var_246a3da0cced05b6 ) )
                {
                    tab_struct = spawnstruct();
                    tab_struct.asset = tab.var_6465f12debc12fd3;
                    tab_struct.index = var_b487b5b7ae379493;
                    tab_struct.ref = var_246a3da0cced05b6.ref;
                    tab_struct.items = [];
                    
                    if ( isdefined( var_246a3da0cced05b6.var_45d4e63a65fca9f9 ) )
                    {
                        var_c03c92022f916c5f = getscriptbundle( var_246a3da0cced05b6.var_45d4e63a65fca9f9 );
                        var_f5fec69ffd2456b2 = 1;
                        
                        foreach ( index, item in var_c03c92022f916c5f.purchaseitems )
                        {
                            if ( is_item_valid( item ) && !function_84e37b7a39ef6268( item, var_683bce87d658b588 ) )
                            {
                                var_30f37d57a23dc69f = spawnstruct();
                                var_30f37d57a23dc69f.asset = item.purchaseitem;
                                var_30f37d57a23dc69f.var_b487b5b7ae379493 = var_b487b5b7ae379493;
                                var_30f37d57a23dc69f.var_f5fec69ffd2456b2 = var_f5fec69ffd2456b2;
                                var_30f37d57a23dc69f.globalindex = globalindex;
                                var_30f37d57a23dc69f.category = var_246a3da0cced05b6.tabcategory;
                                var_24729d845f9dc3fb.items[ globalindex ] = var_30f37d57a23dc69f;
                                tab_struct.items[ var_f5fec69ffd2456b2 ] = var_30f37d57a23dc69f;
                                var_f5fec69ffd2456b2++;
                                globalindex++;
                            }
                        }
                    }
                    
                    var_24729d845f9dc3fb.var_256445803195385a[ var_b487b5b7ae379493 ] = tab_struct;
                }
                
                var_b487b5b7ae379493 += 1;
            }
        }
    }
    else if ( isdefined( var_97b3e9cf58ddeff5.var_ed999f84dad64edb ) )
    {
        var_246a3da0cced05b6 = getscriptbundle( var_97b3e9cf58ddeff5.var_ed999f84dad64edb );
        
        if ( isdefined( var_246a3da0cced05b6 ) )
        {
            tab_struct = spawnstruct();
            tab_struct.asset = tab.var_6465f12debc12fd3;
            tab_struct.index = var_b487b5b7ae379493;
            tab_struct.items = [];
            tab_struct.var_a041636c049c4d29 = var_246a3da0cced05b6.var_f3131a694e17bdc6;
            tab_struct.packedomnvars = [];
            
            foreach ( index, item in var_246a3da0cced05b6.var_b01239e8bca7a4f5 )
            {
                if ( item.omnvar )
                {
                    tab_struct.packedomnvars[ tab_struct.packedomnvars.size ] = item.omnvar;
                }
            }
            
            if ( isdefined( var_246a3da0cced05b6.var_45d4e63a65fca9f9 ) )
            {
                var_c03c92022f916c5f = getscriptbundle( var_246a3da0cced05b6.var_45d4e63a65fca9f9 );
                globalindex = 1;
                
                foreach ( index, item in var_c03c92022f916c5f.purchaseitems )
                {
                    if ( is_item_valid( item ) && !function_84e37b7a39ef6268( item, var_683bce87d658b588 ) )
                    {
                        var_30f37d57a23dc69f = spawnstruct();
                        var_30f37d57a23dc69f.asset = item.purchaseitem;
                        var_30f37d57a23dc69f.var_b487b5b7ae379493 = var_b487b5b7ae379493;
                        var_30f37d57a23dc69f.var_f5fec69ffd2456b2 = globalindex;
                        var_30f37d57a23dc69f.globalindex = globalindex;
                        var_30f37d57a23dc69f.category = var_246a3da0cced05b6.tabcategory;
                        var_24729d845f9dc3fb.items[ globalindex ] = var_30f37d57a23dc69f;
                        tab_struct.items[ globalindex ] = var_30f37d57a23dc69f;
                        globalindex++;
                    }
                }
            }
            
            var_24729d845f9dc3fb.var_256445803195385a[ var_b487b5b7ae379493 ] = tab_struct;
        }
    }
    
    return var_24729d845f9dc3fb;
}

// Namespace purchasemenu
// Params 2
// Checksum 0x6f08e0c4, Offset: 0xc30
// Size: 0xae, Type: bool
function function_84e37b7a39ef6268( item, var_683bce87d658b588 )
{
    if ( !isdefined( var_683bce87d658b588 ) )
    {
        return false;
    }
    
    foreach ( ignored_item in var_683bce87d658b588.purchaseitems )
    {
        if ( ignored_item.purchaseitem == item.purchaseitem )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace purchasemenu
// Params 1
// Checksum 0x84ccd4a5, Offset: 0xce7
// Size: 0x1f
function get_purchasemenu( ref )
{
    if ( isdefined( ref ) )
    {
        return level.purchasemenu[ ref ];
    }
}

// Namespace purchasemenu
// Params 2
// Checksum 0x20657dd6, Offset: 0xd0e
// Size: 0x66
function get_purchasemenu_tab( ref, index )
{
    if ( isdefined( ref ) && isdefined( index ) && isdefined( level.purchasemenu[ ref ] ) && isdefined( level.purchasemenu[ ref ].var_256445803195385a[ index ] ) )
    {
        return level.purchasemenu[ ref ].var_256445803195385a[ index ];
    }
}

// Namespace purchasemenu
// Params 2
// Checksum 0x37c29bcd, Offset: 0xd7c
// Size: 0x66
function get_purchasemenu_item( ref, index )
{
    if ( isdefined( ref ) && isdefined( index ) && isdefined( level.purchasemenu[ ref ] ) && isdefined( level.purchasemenu[ ref ].items[ index ] ) )
    {
        return level.purchasemenu[ ref ].items[ index ];
    }
}

// Namespace purchasemenu
// Params 1
// Checksum 0xa7b7c4eb, Offset: 0xdea
// Size: 0x39
function function_cc7a4eca046e03ee( ref )
{
    if ( isdefined( ref ) && isdefined( level.purchasemenu[ ref ] ) )
    {
        return level.purchasemenu[ ref ].var_518864f924edcfb6;
    }
}

// Namespace purchasemenu
// Params 2
// Checksum 0x24e33d58, Offset: 0xe2b
// Size: 0x46, Type: bool
function function_bc886ba2b8da88c( menuref, channel )
{
    if ( isdefined( channel ) && isdefined( level.purchasemenu[ menuref ] ) )
    {
        return ( level.purchasemenu[ menuref ].var_8a64e37068076a47 == channel );
    }
    
    return false;
}

// Namespace purchasemenu
// Params 2
// Checksum 0x9cccafb5, Offset: 0xe7a
// Size: 0x7c
function menu_close_notify( var_9c657aff3a2d52cf, onclose )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( var_9c657aff3a2d52cf.var_8a64e37068076a47 );
    self waittill( #"luinotifyserver", channel, value );
    
    if ( channel == var_9c657aff3a2d52cf.var_8a64e37068076a47 )
    {
        if ( isdefined( onclose ) )
        {
            waitframe();
            [[ onclose ]]( self );
        }
    }
}

// Namespace purchasemenu
// Params 1
// Checksum 0x4850403e, Offset: 0xefe
// Size: 0x2e
function function_93f934ea2f1c06f8( response )
{
    waitframe();
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_purchasemenu_purchase_response", response );
        self setclientomnvar( "ui_purchasemenu_purchase_response_notify", gettime() );
    }
}

