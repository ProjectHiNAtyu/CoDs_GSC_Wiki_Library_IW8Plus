// scripts\mp\quick_use.gsc  (hash_0fce6a4f48ce9847.gscc) (size: 22922 Bytes / 0x598a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6d18d8 (225253592)
// size ...... 22922 (0x598a)
// includes .. 15  (offset: 0x56e2)
// strings ... 31  (offset: 0x575a)
// dev strs .. 2   (offset: 0x5972)
// exports ... 72  (offset: 0x39c2)
// cseg ...... 0x280 + 0x3742 (0x39c2)
// imports ... 144 (offset: 0x4502)
// animtree1 . 0   (offset: 0x598a)
// animtree2 . 0   (offset: 0x598a)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;
#using scripts\mp\health_chunks;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerhealth;
#using scripts\mp\quickprompt;

#namespace quick_use;

// Namespace quick_use
// Params 0, eflags: 0x5
// Checksum 0x3e6ec58, Offset: 0x29e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8367e525f77f66b0", #"item_backpack_consumable", &init, undefined );
}

// Namespace quick_use
// Params 0, eflags: 0x4
// Checksum 0xf746b5b5, Offset: 0x2c7
// Size: 0x1ae
function private init()
{
    if ( !isenabled() || !common_item::items_isenabled() )
    {
        return;
    }
    
    function_bd7c8a2556eaef1b();
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_damaged", &onplayerdamaged );
    callback::add( #"inventory_update", &function_c14cbd2b301dcaf1 );
    callback::add( #"player_spawned", &OnSpawned );
    callback::add( #"player_laststand_revived", &function_feb3b1429e105dec );
    callback::add( #"no_stamina", &function_d5654e1a4c6202c7 );
    callback::add( #"inventory_item_used", &function_5ee702f5eb5d65e8 );
    callback::add( #"hash_9741c7ee14b21924", &function_964e631da185fc64 );
    callback::add( #"hash_aa7c0dbef3e86ee4", &function_be5aa2b016d17cbd );
    callback::add( #"hash_42a07c459e05796d", &function_88beb0b0354f83e );
    callback::add( #"hash_5447fe6feab51288", &function_67ea77a1c360b27 );
    callback::add( #"used_plate_carrier", &function_88beb0b0354f83e );
    callback::add( #"plate_carrier_removed", &function_88beb0b0354f83e );
    callback::add( #"hash_91012fd98c668c5f", &function_25dfeb2a608a9131 );
    
    if ( health_chunks::isenabled() )
    {
        callback::add( #"hash_564154fd82037502", &function_ab3de13d2a78dd8c );
        callback::add( #"hash_9f85dd470a0b7a0c", &function_ab3de13d2a78dd8c );
    }
    
    utility::registersharedfunc( #"hash_8367e525f77f66b0", #"hash_ccaff0c8d05d796", &function_3e75b34009daf933 );
    
    /#
        thread dev::devcommandwatcher( @"hash_a51f3c7825138039", &function_d6720a92e1898efb );
    #/
}

// Namespace quick_use
// Params 0
// Checksum 0xb0b07903, Offset: 0x47d
// Size: 0x23
function isenabled()
{
    return getdvarint( @"quick_use_enabled", istrue( level.gametypebundle.var_346b669e78a5157d ) );
}

// Namespace quick_use
// Params 0, eflags: 0x4
// Checksum 0x38665f16, Offset: 0x4a9
// Size: 0x1a9
function private function_bd7c8a2556eaef1b()
{
    if ( !isdefined( level.var_aa5d856ff74f6b34 ) )
    {
        level.var_aa5d856ff74f6b34 = [];
    }
    
    var_ddfbc7691b51df3d = [ #"hash_564154fd82037502" ];
    var_13950fa389818dfd = [ #"player_damaged" ];
    var_13950fa389818dfd = arraycombine( var_13950fa389818dfd, var_ddfbc7691b51df3d );
    var_25441fcd3a5efe3f = [ #"no_stamina" ];
    var_2148deef9d98bddf = [ #"sedative_inhaler_event" ];
    armorplateevents = [ #"hash_aa7c0dbef3e86ee4", #"hash_5447fe6feab51288", #"used_plate_carrier" ];
    var_da5a803d2e34a22c = [ #"rad_blockers_event" ];
    nvgevents = [ #"nvg_event", #"toggle_off_nvg" ];
    function_91d951100a9cd2ed( "NONE", &function_5f17b1802122dfb1, [ #"none_event" ] );
    function_91d951100a9cd2ed( "BANDAGE", &function_aaa19462edbc8628, var_ddfbc7691b51df3d );
    function_91d951100a9cd2ed( "MEDKIT", &function_dfbedfe2535b1c18, var_ddfbc7691b51df3d );
    function_91d951100a9cd2ed( "PAIN_KILLERS", &function_aebf36cfa34093c4, var_13950fa389818dfd );
    function_91d951100a9cd2ed( "NOREPINEPHRINE", &function_5f17b1802122dfb1, var_25441fcd3a5efe3f );
    function_91d951100a9cd2ed( "SEDATIVE_INHALER", &function_5f17b1802122dfb1, var_2148deef9d98bddf );
    function_91d951100a9cd2ed( "ARMOR", &function_f265964fc950467b, armorplateevents );
    function_91d951100a9cd2ed( "RAD_BLOCKERS", &function_5f17b1802122dfb1, var_da5a803d2e34a22c );
    function_91d951100a9cd2ed( "NVG", &function_70abb62c015faa43, nvgevents );
}

// Namespace quick_use
// Params 5, eflags: 0x4
// Checksum 0xe0ff91cf, Offset: 0x65a
// Size: 0x19e
function private function_91d951100a9cd2ed( var_9a868ae1400e3424, usablecallback, var_f955eb87595f422e, comparefunc, var_ed87842e2b91e859 )
{
    if ( !isdefined( level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ] ) )
    {
        level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ] = {};
    }
    
    if ( !isdefined( level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items ) )
    {
        level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items = [];
    }
    
    level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].usablecallback = usablecallback;
    level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].comparefunc = comparefunc;
    level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].var_f955eb87595f422e = var_f955eb87595f422e;
    level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].var_ed87842e2b91e859 = var_ed87842e2b91e859;
    
    if ( !isdefined( level.var_b9879b8ca3f4afac ) )
    {
        level.var_b9879b8ca3f4afac = [];
    }
    
    foreach ( event in var_f955eb87595f422e )
    {
        if ( !isdefined( level.var_b9879b8ca3f4afac[ event ] ) )
        {
            level.var_b9879b8ca3f4afac[ event ] = [];
        }
        
        level.var_b9879b8ca3f4afac[ event ] = arraycombineunique( level.var_b9879b8ca3f4afac[ event ], [ var_9a868ae1400e3424 ] );
    }
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xa19e9a61, Offset: 0x800
// Size: 0x125
function private function_c03321eb45610b7b( callbackevent )
{
    if ( !level.var_b9879b8ca3f4afac )
    {
        return [];
    }
    
    if ( !callbackevent )
    {
        allevents = [];
        
        foreach ( eventtypes in level.var_b9879b8ca3f4afac )
        {
            foreach ( eventtype in eventtypes )
            {
                allevents = arraycombineunique( allevents, [ eventtype ] );
            }
        }
        
        return allevents;
    }
    
    return level.var_b9879b8ca3f4afac[ callbackevent ] ?? [];
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xa9146a4e, Offset: 0x92e
// Size: 0x63
function private function_116a11bd01778bec( itembundle )
{
    if ( !itembundle || !level.var_4901567bf5b2a56c )
    {
        return;
    }
    
    bundlename = common_item::function_e044c3e813daec3a( itembundle );
    
    if ( !bundlename || !level.var_4901567bf5b2a56c[ bundlename ] )
    {
        return;
    }
    
    return level.var_4901567bf5b2a56c[ bundlename ].var_9a868ae1400e3424;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x2120a8ef, Offset: 0x99a
// Size: 0x37
function private function_fd455cee9746325( var_9a868ae1400e3424 )
{
    if ( !level.var_4901567bf5b2a56c || !var_9a868ae1400e3424 )
    {
        return;
    }
    
    return level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].usableomnvar;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xc8f94275, Offset: 0x9da
// Size: 0xa4
function private function_6b1a30e162172513( itembundlename )
{
    itembundle = getscriptbundlefieldvalues( itembundlename, [ #"ref", #"scriptable", #"lootitemtype", #"quickusable", #"hash_e70f2bf9f78cdae9", #"hash_6a874022cbaa963f", #"hash_be973748e231069a", #"hash_55d961ad8c478bcb", #"hash_5a7a3a821da1e057" ] );
    itembundle.itembundlename = itembundlename;
    return itembundle;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xbe2b2e20, Offset: 0xa87
// Size: 0x48d
function private function_25dfeb2a608a9131( params )
{
    itembundlename = params.itembundlename;
    itembundle = function_6b1a30e162172513( itembundlename );
    
    if ( !itembundle.quickusable )
    {
        return;
    }
    
    var_9a868ae1400e3424 = "NONE";
    usableomnvar = undefined;
    
    if ( itembundle.var_6b2f3ddaab966fec )
    {
        typedata = getscriptbundlefieldvalues( itembundle.var_6b2f3ddaab966fec, [ #"hash_9bb775a76bbdd82f", #"usableomnvar" ] );
        var_9a868ae1400e3424 = typedata.var_9a868ae1400e3424;
        usableomnvar = typedata.usableomnvar;
        
        if ( !isdefined( level.var_4901567bf5b2a56c ) )
        {
            level.var_4901567bf5b2a56c = [];
        }
        
        level.var_4901567bf5b2a56c[ itembundlename ] = typedata;
    }
    
    if ( !isdefined( level.var_aa5d856ff74f6b34 ) )
    {
        level.var_aa5d856ff74f6b34 = [];
    }
    
    if ( !isdefined( level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ] ) )
    {
        level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ] = {};
    }
    
    if ( !isdefined( level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items ) )
    {
        level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items = [];
    }
    
    level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].usableomnvar = usableomnvar;
    level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items[ level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items.size ] = itembundle;
    level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items = arraysort( level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items, undefined, &function_ac7e1c2c9bb76c0a );
    
    if ( !isdefined( level.var_d0e159df5d64faa6 ) )
    {
        level.var_d0e159df5d64faa6 = [];
    }
    
    indexes = [];
    
    foreach ( promptstruct in itembundle.var_4740e7bf22614c6b )
    {
        if ( promptstruct.quickuseprompt )
        {
            index = quickprompt::function_34974cec7d4d14eb( promptstruct.quickuseprompt );
            
            if ( isdefined( index ) )
            {
                level.var_d0e159df5d64faa6[ index ] = 1;
                indexes[ indexes.size ] = index;
            }
        }
    }
    
    if ( !isdefined( level.var_7c2e2e929eb2ea59 ) )
    {
        level.var_7c2e2e929eb2ea59 = [];
    }
    
    if ( !isdefined( level.var_7c2e2e929eb2ea59[ itembundle.var_dccdc786c72b8620 ?? "DEFAULT" ] ) )
    {
        level.var_7c2e2e929eb2ea59[ itembundle.var_dccdc786c72b8620 ?? "DEFAULT" ] = {};
    }
    
    if ( !isdefined( level.var_7c2e2e929eb2ea59[ itembundle.var_dccdc786c72b8620 ?? "DEFAULT" ].var_d0e159df5d64faa6 ) )
    {
        level.var_7c2e2e929eb2ea59[ itembundle.var_dccdc786c72b8620 ?? "DEFAULT" ].var_d0e159df5d64faa6 = [];
    }
    
    level.var_7c2e2e929eb2ea59[ itembundle.var_dccdc786c72b8620 ?? "DEFAULT" ].var_d0e159df5d64faa6 = arraycombine( level.var_7c2e2e929eb2ea59[ itembundle.var_dccdc786c72b8620 ?? "DEFAULT" ].var_d0e159df5d64faa6, indexes );
    
    if ( itembundle.var_5e666a1cea606c50 )
    {
        if ( !level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].startedmonitor && var_9a868ae1400e3424 == "NVG" )
        {
            level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].startedmonitor = 1;
            darkzones = getnoentvolumearray( "prompt_volume_toggle_nvg", #script_noteworthy );
            
            if ( darkzones && darkzones.size > 0 )
            {
                foreach ( darkzone in darkzones )
                {
                    trigger::makeenterexittrigger( darkzone, &function_d5cf11fa80a00b39, &function_ddb2018fced67a6d, undefined, undefined, &triggerfilter );
                }
            }
        }
    }
}

// Namespace quick_use
// Params 3, eflags: 0x4
// Checksum 0x5e142992, Offset: 0xf1c
// Size: 0x16e
function private function_4aae569737c390b1( a, b, player )
{
    if ( !isdefined( player ) || !player.maxhealth )
    {
        return function_2387a9046f5e7d75( a, b );
    }
    
    missinghealth = int( player.maxhealth - player.maxhealth * player playerhealth::function_b2900ab8be3b86ba( 1 ) );
    
    if ( a.consumablehealth == b.consumablehealth )
    {
        return function_2387a9046f5e7d75( a, b );
    }
    
    var_2364df11b1e35fc9 = a.consumablehealth >= missinghealth;
    var_d48571f8caa5f89e = b.consumablehealth >= missinghealth;
    
    if ( var_2364df11b1e35fc9 && var_d48571f8caa5f89e )
    {
        return ( a.consumablehealth <= b.consumablehealth );
    }
    else if ( var_2364df11b1e35fc9 )
    {
        return 1;
    }
    else if ( var_d48571f8caa5f89e )
    {
        return 0;
    }
    
    var_bceaf25544f59a33 = a.var_ad6f440daf82c2d9 >= missinghealth;
    var_ef5b455f9d93859c = b.var_ad6f440daf82c2d9 >= missinghealth;
    
    if ( var_bceaf25544f59a33 && var_ef5b455f9d93859c )
    {
        return ( a.var_ad6f440daf82c2d9 <= b.var_ad6f440daf82c2d9 );
    }
    else if ( var_bceaf25544f59a33 )
    {
        return 1;
    }
    else if ( var_ef5b455f9d93859c )
    {
        return 0;
    }
    
    return function_2387a9046f5e7d75( a, b );
}

// Namespace quick_use
// Params 3, eflags: 0x4
// Checksum 0x4804b88, Offset: 0x1093
// Size: 0x8c
function private function_ac7e1c2c9bb76c0a( a, b, player )
{
    atype = function_116a11bd01778bec( a );
    btype = function_116a11bd01778bec( b );
    
    if ( atype == btype && level.var_aa5d856ff74f6b34[ atype ].comparefunc )
    {
        return self [[ level.var_aa5d856ff74f6b34[ atype ].comparefunc ]]( a, b, player );
    }
    
    return function_2387a9046f5e7d75( a, b );
}

// Namespace quick_use
// Params 2, eflags: 0x4
// Checksum 0x8ee14da1, Offset: 0x1128
// Size: 0x50, Type: bool
function private function_2387a9046f5e7d75( a, b )
{
    return ( a.var_60d0fa0219644fa3 ?? a.var_59e18820492963f4 ?? 0 ) > ( b.var_60d0fa0219644fa3 ?? b.var_59e18820492963f4 ?? 0 );
}

// Namespace quick_use
// Params 2, eflags: 0x4
// Checksum 0xc1524f4c, Offset: 0x1181
// Size: 0x53, Type: bool
function private function_7d2f37727ac73b1c( var_9a868ae1400e3424, params )
{
    if ( !level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].usablecallback || !self [[ level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].usablecallback ]]( params ) )
    {
        return false;
    }
    
    return true;
}

// Namespace quick_use
// Params 4, eflags: 0x4
// Checksum 0xf2b41c6a, Offset: 0x11dd
// Size: 0xd5, Type: bool
function private function_e9afe2df9621fb54( item, var_9a868ae1400e3424, var_4eec328dbc49d2c1, params )
{
    if ( !item.itembundlename )
    {
        return false;
    }
    
    if ( !self.var_2b02866e9cb008f0 || !self.var_2b02866e9cb008f0[ item.itembundlename ] || !self.var_2b02866e9cb008f0[ item.itembundlename ].itembundle )
    {
        return false;
    }
    
    if ( var_4eec328dbc49d2c1 && var_4eec328dbc49d2c1 != ( self.var_2b02866e9cb008f0[ item.itembundlename ].itembundle.var_dccdc786c72b8620 ?? "DEFAULT" ) )
    {
        return false;
    }
    
    if ( !function_7d2f37727ac73b1c( var_9a868ae1400e3424, params ) )
    {
        return false;
    }
    
    return true;
}

// Namespace quick_use
// Params 2, eflags: 0x4
// Checksum 0x4c18affc, Offset: 0x12bb
// Size: 0x40
function private function_e03def80dff4f041( var_9a868ae1400e3424, params )
{
    omnvar = function_fd455cee9746325( var_9a868ae1400e3424 );
    
    if ( !omnvar )
    {
        return;
    }
    
    self setclientomnvar( omnvar, function_7d2f37727ac73b1c( var_9a868ae1400e3424 ) );
}

// Namespace quick_use
// Params 5, eflags: 0x4
// Checksum 0xc9961340, Offset: 0x1303
// Size: 0x5e9
function private function_3e75b34009daf933( var_4bffb08fbb61e10e, itembundle, inflatepriority, var_4eec328dbc49d2c1, params )
{
    if ( !level.var_aa5d856ff74f6b34 )
    {
        return 0;
    }
    
    var_f2993d10ed5965b8 = [];
    var_e417c45fdf3d1b55 = undefined;
    
    if ( !itembundle )
    {
        var_e417c45fdf3d1b55 = function_c03321eb45610b7b( var_4bffb08fbb61e10e );
        
        foreach ( var_9a868ae1400e3424 in var_e417c45fdf3d1b55 )
        {
            if ( !level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ] )
            {
                continue;
            }
            
            foreach ( item in level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items )
            {
                if ( var_f2993d10ed5965b8[ item.itembundlename ] )
                {
                    continue;
                }
                
                if ( function_e9afe2df9621fb54( item, var_9a868ae1400e3424, var_4eec328dbc49d2c1, params ) )
                {
                    bundle = self.var_2b02866e9cb008f0[ item.itembundlename ].itembundle;
                    
                    if ( inflatepriority || function_eb8f6983c4b12b27( bundle ) )
                    {
                        bundle = structcopy( self.var_2b02866e9cb008f0[ item.itembundlename ].itembundle );
                        bundle.var_60d0fa0219644fa3 = ( bundle.var_59e18820492963f4 ?? 0 ) + ( bundle.var_dbb73e7b96937aaa ?? 1000 );
                    }
                    
                    var_f2993d10ed5965b8[ item.itembundlename ] = bundle;
                }
            }
        }
    }
    else
    {
        itembundlename = common_item::function_e044c3e813daec3a( itembundle );
        item = { #itembundlename:itembundlename };
        var_9a868ae1400e3424 = function_116a11bd01778bec( itembundle ) ?? "NONE";
        var_e417c45fdf3d1b55 = [ var_9a868ae1400e3424 ];
        
        if ( function_e9afe2df9621fb54( item, var_9a868ae1400e3424, var_4eec328dbc49d2c1, params ) )
        {
            bundle = itembundle;
            
            if ( inflatepriority || function_eb8f6983c4b12b27( bundle ) )
            {
                bundle = structcopy( self.var_2b02866e9cb008f0[ item.itembundlename ].itembundle );
                bundle.var_60d0fa0219644fa3 = ( bundle.var_59e18820492963f4 ?? 0 ) + ( bundle.var_dbb73e7b96937aaa ?? 1000 );
            }
            
            var_f2993d10ed5965b8[ item.itembundlename ] = bundle;
        }
    }
    
    foreach ( type in var_e417c45fdf3d1b55 )
    {
        function_e03def80dff4f041( type, params );
    }
    
    if ( !isdefined( self.var_c414206804b86889 ) )
    {
        self.var_c414206804b86889 = [];
    }
    
    foreach ( slot in self.var_c414206804b86889 )
    {
        if ( !slot.itembundle )
        {
            continue;
        }
        
        itembundlename = common_item::function_e044c3e813daec3a( slot.itembundle );
        
        if ( !itembundlename || var_f2993d10ed5965b8[ itembundlename ] )
        {
            continue;
        }
        
        item = { #itembundlename:itembundlename };
        var_9a868ae1400e3424 = function_116a11bd01778bec( slot.itembundle ) ?? "NONE";
        
        if ( function_e9afe2df9621fb54( item, var_9a868ae1400e3424, var_4eec328dbc49d2c1, params ) )
        {
            var_f2993d10ed5965b8[ itembundlename ] = slot.itembundle;
        }
    }
    
    if ( var_f2993d10ed5965b8.size > 1 )
    {
        var_f2993d10ed5965b8 = arraysort( var_f2993d10ed5965b8, self, &function_ac7e1c2c9bb76c0a );
    }
    
    takenslots = [];
    
    foreach ( itembundle in var_f2993d10ed5965b8 )
    {
        slot = itembundle.var_dccdc786c72b8620 ?? "DEFAULT";
        
        if ( takenslots[ slot ] )
        {
            continue;
        }
        
        result = function_2fb4714a901b0985( itembundle, inflatepriority, var_4bffb08fbb61e10e, slot, var_4eec328dbc49d2c1 );
        
        if ( result )
        {
            takenslots[ slot ] = 1;
        }
    }
    
    var_604e9e33787cd756 = level.var_7c2e2e929eb2ea59;
    
    if ( var_4eec328dbc49d2c1 )
    {
        var_604e9e33787cd756 = [];
        var_604e9e33787cd756[ var_4eec328dbc49d2c1 ] = 1;
    }
    
    foreach ( slot, _ in var_604e9e33787cd756 )
    {
        if ( !takenslots[ slot ] )
        {
            self.var_c414206804b86889[ slot ] = undefined;
            self notify( "quick_use_slot_cleared_" + slot );
            function_6f7d6a4d5c193e0( slot );
        }
    }
    
    if ( !self.var_c414206804b86889[ "DEFAULT" ] && hasomnvar( "ui_quick_use_item_id" ) )
    {
        self setclientomnvar( "ui_quick_use_item_id", 0 );
    }
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x18c71f, Offset: 0x18f4
// Size: 0x11f
function private function_6f7d6a4d5c193e0( cancelslot )
{
    if ( quickprompt::function_106bde9d618791e9() && arraycontains( level.var_7c2e2e929eb2ea59[ cancelslot ].var_d0e159df5d64faa6, self.quickprompt.type ) )
    {
        quickprompt::quickpromptcancel();
        
        foreach ( slot, _ in level.var_7c2e2e929eb2ea59 )
        {
            if ( slot != cancelslot && self.var_c414206804b86889 && self.var_c414206804b86889[ slot ] )
            {
                function_8378b842790a37d5( self.var_c414206804b86889[ slot ].itembundle, undefined, slot );
                break;
            }
        }
    }
    
    if ( self.var_c1e5365cb212a166 == cancelslot )
    {
        self notify( #"quick_use_prompt_cleared" );
    }
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x4a7a3a07, Offset: 0x1a1b
// Size: 0x4f
function private function_dbffb269cf7b6dfe( itembundle )
{
    typeref = common_item::function_16e8c106491eeaca( itembundle );
    
    if ( !isdefined( typeref ) )
    {
        return;
    }
    
    callbacks = common_item::function_9f00d6361edd38ce( typeref );
    return callbacks.funcs[ #"hash_2d3b76ff260f2d68" ];
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x28952eb8, Offset: 0x1a73
// Size: 0x10e
function private function_b1bdbe633a5c6807( slot )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( !self.var_c414206804b86889 || !slot || !self.var_c414206804b86889[ slot ] )
    {
        return;
    }
    
    itembundle = self.var_c414206804b86889[ slot ].itembundle;
    usecallback = function_dbffb269cf7b6dfe( itembundle );
    
    if ( !isdefined( usecallback ) )
    {
        return;
    }
    
    groupindex = 1;
    index = common_inventory_groups::function_e7c426ab761c55e4( groupindex, itembundle );
    
    if ( !isdefined( index ) )
    {
        groupindex = 2;
        index = common_inventory_groups::function_e7c426ab761c55e4( groupindex, itembundle );
    }
    
    funcs = common_inventory_groups::function_987405ff5ee23e99( groupindex );
    
    if ( !( isdefined( funcs.fromfunc ) && isdefined( funcs.var_65a6f7922d118cdd ) ) )
    {
        return;
    }
    
    lootid = common_item::function_779887309ec71dfe( itembundle );
    self [[ usecallback ]]( index, itembundle, lootid, 1, groupindex );
    function_6f7d6a4d5c193e0( slot );
}

// Namespace quick_use
// Params 0, eflags: 0x4
// Checksum 0x205bc640, Offset: 0x1b89
// Size: 0xa7
function private getmaxpriority()
{
    if ( !self.var_c414206804b86889 )
    {
        return -1;
    }
    
    maxval = -1;
    
    foreach ( slot in self.var_c414206804b86889 )
    {
        maxval = int( max( maxval, slot.priority ) );
    }
    
    return maxval;
}

// Namespace quick_use
// Params 5, eflags: 0x4
// Checksum 0x98da04ae, Offset: 0x1c39
// Size: 0x267, Type: bool
function private function_2fb4714a901b0985( itembundle, inflatepriority, var_4bffb08fbb61e10e, slot, var_4eec328dbc49d2c1 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !player::isaliveandnotinlaststand( self ) )
    {
        return false;
    }
    
    if ( killstreak::function_2512509a946854ce() )
    {
        return false;
    }
    
    if ( !itembundle.quickusable )
    {
        return false;
    }
    
    lootid = common_item::function_779887309ec71dfe( itembundle );
    
    if ( !isdefined( lootid ) )
    {
        return false;
    }
    
    if ( !isdefined( var_4eec328dbc49d2c1 ) )
    {
        var_4eec328dbc49d2c1 = "DEFAULT";
    }
    
    if ( !isdefined( self.var_c414206804b86889 ) )
    {
        self.var_c414206804b86889 = [];
    }
    
    if ( !isdefined( slot ) )
    {
        slot = itembundle.var_dccdc786c72b8620 ?? "DEFAULT";
    }
    
    var_c076442497fb50b5 = self.var_c414206804b86889[ slot ] && common_item::function_779887309ec71dfe( self.var_c414206804b86889[ slot ].itembundle ) == lootid;
    newpriority = itembundle.var_60d0fa0219644fa3 ?? itembundle.var_59e18820492963f4 ?? 0;
    
    if ( var_c076442497fb50b5 && ( !inflatepriority || inflatepriority && self.var_c414206804b86889[ slot ].priority == newpriority ) && ( !self.var_8d4c73ff2c42ed85 || slot == self.var_8d4c73ff2c42ed85 ) )
    {
        return true;
    }
    
    if ( inflatepriority && slot == var_4eec328dbc49d2c1 )
    {
        thread function_e8f5e20e1c4287d2( slot, lootid );
    }
    
    if ( !var_c076442497fb50b5 && self.var_c414206804b86889[ slot ] && isdefined( self.var_c414206804b86889[ slot ].priority ) && newpriority < self.var_c414206804b86889[ slot ].priority )
    {
        return false;
    }
    
    self.var_c414206804b86889[ slot ] = { #priority:newpriority, #itembundle:itembundle };
    itembundle.var_60d0fa0219644fa3 = undefined;
    function_cd2e8c7a76f77ed5( itembundle );
    
    if ( hasomnvar( "ui_quick_use_item_id" ) && slot == "DEFAULT" )
    {
        self setclientomnvar( "ui_quick_use_item_id", lootid );
    }
    
    maxpriority = getmaxpriority();
    
    if ( newpriority < maxpriority )
    {
        return true;
    }
    
    function_8378b842790a37d5( itembundle, var_4bffb08fbb61e10e, slot, istrue( inflatepriority ) );
    return true;
}

// Namespace quick_use
// Params 4, eflags: 0x4
// Checksum 0x80b2c209, Offset: 0x1ea9
// Size: 0x31a
function private function_8378b842790a37d5( itembundle, var_4bffb08fbb61e10e, slot, skipdelay )
{
    quickuseprompt = undefined;
    var_a2bc1af3e9e12b85 = undefined;
    var_15fef5b568b8c972 = undefined;
    var_c77491c358487f7f = undefined;
    callbackevent = #"general";
    
    if ( itembundle.var_4740e7bf22614c6b )
    {
        foreach ( promptstruct in itembundle.var_4740e7bf22614c6b )
        {
            if ( promptstruct.callbackevent == var_4bffb08fbb61e10e || !promptstruct.callbackevent || promptstruct.callbackevent == #"general" )
            {
                quickuseprompt = promptstruct.quickuseprompt;
                var_a2bc1af3e9e12b85 = promptstruct.var_a2bc1af3e9e12b85;
                var_15fef5b568b8c972 = promptstruct.var_15fef5b568b8c972;
                var_c77491c358487f7f = promptstruct.var_c77491c358487f7f;
                callbackevent = promptstruct.callbackevent ?? #"general";
                
                if ( promptstruct.callbackevent == var_4bffb08fbb61e10e || !var_4bffb08fbb61e10e )
                {
                    break;
                }
            }
        }
    }
    
    bundlename = common_item::function_e044c3e813daec3a( itembundle );
    
    if ( !isdefined( self.var_2b02866e9cb008f0[ bundlename ].cooldowns ) )
    {
        self.var_2b02866e9cb008f0[ bundlename ].cooldowns = [];
    }
    
    if ( self.var_2b02866e9cb008f0[ bundlename ].cooldowns[ callbackevent ] && self.var_2b02866e9cb008f0[ bundlename ].cooldowns[ callbackevent ] > gettime() )
    {
        return;
    }
    
    timeout = var_15fef5b568b8c972 ? 429497 : undefined;
    lootid = common_item::function_779887309ec71dfe( itembundle );
    thread quickprompt::function_661f2ac4b89488a1( quickuseprompt, timeout, undefined, undefined, lootid, skipdelay );
    cooldowntime = getcooldowntime( itembundle, var_a2bc1af3e9e12b85 );
    
    if ( cooldowntime )
    {
        self.var_2b02866e9cb008f0[ bundlename ].cooldowns[ callbackevent ] = gettime() + cooldowntime;
    }
    
    self.var_8d4c73ff2c42ed85 = slot;
    settings = quickprompt::function_cf3f7f2b697e78fe( quickuseprompt );
    
    if ( settings.var_edf094f6f941163a && level.var_3ba1cb65c3aa671b && level.var_3ba1cb65c3aa671b[ settings.var_edf094f6f941163a ] )
    {
        event = level.var_3ba1cb65c3aa671b[ settings.var_edf094f6f941163a ];
        thread function_59f96c8fac0e9893( event.duration ?? 5 );
        thread function_2e9c243839c72144();
    }
    
    if ( !var_15fef5b568b8c972 )
    {
        thread function_f6871bbb52f8935a( quickuseprompt, var_c77491c358487f7f, lootid, slot );
    }
}

// Namespace quick_use
// Params 1, eflags: 0xc
// Checksum 0x91a41433, Offset: 0x21cb
// Size: 0x60
function private function_59f96c8fac0e9893( duration )
{
    self notify( #"hash_9ca24ad76eed2db" );
    self endon( #"hash_9ca24ad76eed2db" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_db8a72d90f1b67cf" );
    self.var_65f1ce7a007e6103 = 1;
    wait duration;
    self.var_65f1ce7a007e6103 = undefined;
}

// Namespace quick_use
// Params 0, eflags: 0xc
// Checksum 0x84170805, Offset: 0x2233
// Size: 0x6c
function private function_2e9c243839c72144()
{
    self notify( #"hash_3d82f4af1f4f0b63" );
    self endon( #"hash_3d82f4af1f4f0b63" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any( "death", "last_stand_enter" );
    
    if ( !self.var_65f1ce7a007e6103 )
    {
        return;
    }
    
    self function_971e406eb1e08f74();
    self stopsoundchannel( "voice_radio_2d" );
    self.var_65f1ce7a007e6103 = undefined;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x8861bb88, Offset: 0x22a7
// Size: 0x41, Type: bool
function private function_eb8f6983c4b12b27( itembundle )
{
    lootid = common_item::function_779887309ec71dfe( itembundle );
    
    if ( !lootid )
    {
        return false;
    }
    
    return self.var_3c3205fac834620b && self.var_3c3205fac834620b[ lootid ];
}

// Namespace quick_use
// Params 2, eflags: 0x4
// Checksum 0x9abbd4c2, Offset: 0x22f1
// Size: 0x86
function private function_e8f5e20e1c4287d2( slot, lootid )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    endonstring = "watch_inflate_priority_" + lootid;
    self notify( endonstring );
    self endon( endonstring );
    
    if ( !isdefined( self.var_3c3205fac834620b ) )
    {
        self.var_3c3205fac834620b = [];
    }
    
    self.var_3c3205fac834620b[ lootid ] = 1;
    function_26abf1e3ed6f3a63( slot, lootid );
    self.var_3c3205fac834620b[ lootid ] = undefined;
}

// Namespace quick_use
// Params 2, eflags: 0xc
// Checksum 0xa3c5bbd7, Offset: 0x237f
// Size: 0x76
function private function_26abf1e3ed6f3a63( slot, lootid )
{
    self notify( #"hash_f881e9f370cf430a" );
    self endon( #"hash_f881e9f370cf430a" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "quick_use_slot_cleared_" + slot );
    wait function_d097af86e065fb0e();
    self.var_c414206804b86889[ slot ] = undefined;
    self.var_3c3205fac834620b[ lootid ] = undefined;
    thread function_3e75b34009daf933();
}

// Namespace quick_use
// Params 4, eflags: 0xc
// Checksum 0xf0b806ea, Offset: 0x23fd
// Size: 0xa8
function private function_f6871bbb52f8935a( quickuseprompt, var_c77491c358487f7f, lootid, slot )
{
    self notify( #"hash_e794fef0e0807276" );
    self endon( #"hash_e794fef0e0807276" );
    
    if ( !quickuseprompt || !var_c77491c358487f7f || !lootid )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"quick_use_prompt_cleared" );
    thread function_fd82d4b199f07792( slot );
    
    while ( true )
    {
        wait var_c77491c358487f7f;
        thread quickprompt::function_661f2ac4b89488a1( quickuseprompt, undefined, undefined, undefined, lootid, 1 );
    }
}

// Namespace quick_use
// Params 1, eflags: 0xc
// Checksum 0x15e1fb8f, Offset: 0x24ad
// Size: 0x4f
function private function_fd82d4b199f07792( slot )
{
    self notify( #"hash_92a9f48e51bdd660" );
    self endon( #"hash_92a9f48e51bdd660" );
    self.var_c1e5365cb212a166 = slot;
    utility::waittill_any( "quick_use_prompt_cleared", "last_stand_enter", "death_or_disconnect" );
    self.var_c1e5365cb212a166 = undefined;
}

// Namespace quick_use
// Params 1
// Checksum 0x2d4166b7, Offset: 0x2504
// Size: 0xb2
function function_33ce1272468894c7( var_9a868ae1400e3424 )
{
    if ( !self.var_2b02866e9cb008f0 )
    {
        return 0;
    }
    
    foreach ( bundlename in getarraykeys( self.var_2b02866e9cb008f0 ) )
    {
        usetype = getscriptbundlefieldvalue( bundlename, #"hash_9bb775a76bbdd82f" );
        
        if ( usetype == var_9a868ae1400e3424 )
        {
            return 1;
        }
    }
}

// Namespace quick_use
// Params 1
// Checksum 0x9a63462c, Offset: 0x25be
// Size: 0x48
function function_f4cd8a1ae549f98c( slot )
{
    if ( !slot || !self.var_c414206804b86889 || !self.var_c414206804b86889[ slot ] )
    {
        return;
    }
    
    return self.var_c414206804b86889[ slot ].itembundle;
}

// Namespace quick_use
// Params 1
// Checksum 0xdbd2b1fa, Offset: 0x260f
// Size: 0x56, Type: bool
function function_28b589a4d7479415( itembundle )
{
    var_9a868ae1400e3424 = function_116a11bd01778bec( itembundle );
    
    if ( var_9a868ae1400e3424 == "MEDKIT" )
    {
        return true;
    }
    
    if ( self.var_144ad4a5bcb22c3 && ( var_9a868ae1400e3424 == "BANDAGE" || var_9a868ae1400e3424 == "PAIN_KILLERS" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace quick_use
// Params 2, eflags: 0x4
// Checksum 0xaeb12c11, Offset: 0x266e
// Size: 0x87
function private getcooldowntime( itembundle, cooldowntime )
{
    /#
        if ( isdefined( level.var_d6720a92e1898efb.cooldown ) )
        {
            return ( level.var_d6720a92e1898efb.cooldown * 1000 );
        }
    #/
    
    if ( isdefined( cooldowntime ) )
    {
        return cooldowntime;
    }
    
    if ( isdefined( itembundle.var_a2bc1af3e9e12b85 ) )
    {
        return itembundle.var_a2bc1af3e9e12b85;
    }
    
    return ( level.gametypebundle.var_a2bc1af3e9e12b85 ?? 60 ) * 1000;
}

// Namespace quick_use
// Params 0, eflags: 0x4
// Checksum 0xc4ddcd19, Offset: 0x26fe
// Size: 0x41
function private function_d097af86e065fb0e()
{
    /#
        if ( isdefined( level.var_d6720a92e1898efb.var_60d0fa0219644fa3 ) )
        {
            return ( level.var_d6720a92e1898efb.var_60d0fa0219644fa3 * 1000 );
        }
    #/
    
    return quickprompt::function_811c31b8825a9d2b() / 1000 + 5;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xc837ba94, Offset: 0x2748
// Size: 0x32, Type: bool
function private function_f265964fc950467b( params )
{
    if ( !level.allowarmor )
    {
        return false;
    }
    
    if ( !self.maxarmorhealth )
    {
        return false;
    }
    
    return armor::function_33fbba4f082f4aec() > 0;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x6dbb69d8, Offset: 0x2783
// Size: 0xe, Type: bool
function private function_5f17b1802122dfb1( params )
{
    return true;
}

// Namespace quick_use
// Params 0, eflags: 0x4
// Checksum 0x5e42a22c, Offset: 0x279a
// Size: 0x1b, Type: bool
function private function_c61f910ae90f7bc()
{
    sprintfrac = self getsprintmeterfraction();
    return sprintfrac <= 0.1;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xc18a6896, Offset: 0x27be
// Size: 0x14, Type: bool
function private function_aaa19462edbc8628( params )
{
    return health_chunks::function_57d7450ef7a9c202( 1 );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x76526004, Offset: 0x27db
// Size: 0x12, Type: bool
function private function_dfbedfe2535b1c18( params )
{
    return health_chunks::function_57d7450ef7a9c202();
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x870840bf, Offset: 0x27f6
// Size: 0xe, Type: bool
function private function_aebf36cfa34093c4( params )
{
    return true;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x5e2fe923, Offset: 0x280d
// Size: 0x70
function private function_8b109303109c6fe6( pressed )
{
    if ( !pressed )
    {
        self notify( #"button_released" );
        
        if ( self usinggamepad() && player::isaliveandnotinlaststand( self ) && self.var_f8a9874de10eadb8 > gettime() )
        {
            killstreaks::listenkillstreakaction( "streak_select", 1 );
        }
        
        return;
    }
    
    if ( player::isaliveandnotinlaststand( self ) )
    {
        thread function_4dd3613a68836528( gettime() );
        thread function_31f3241936901525();
    }
}

// Namespace quick_use
// Params 0, eflags: 0xc
// Checksum 0xe50c0813, Offset: 0x2885
// Size: 0x58
function private function_31f3241936901525()
{
    self notify( #"hash_a954f18996022eb9" );
    self endon( #"hash_a954f18996022eb9" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any( "death", "last_stand_enter", "button_released" );
    self setclientomnvar( "ui_quick_use_progress", 0 );
}

// Namespace quick_use
// Params 0, eflags: 0x4
// Checksum 0x67fdf54a, Offset: 0x28e5
// Size: 0x15, Type: bool
function private getholdtime()
{
    return getdvarint( @"hash_923b34c4661bf18d" ) ?? 500;
}

// Namespace quick_use
// Params 1, eflags: 0xc
// Checksum 0x1b2b3e0, Offset: 0x2903
// Size: 0xc6
function private function_4dd3613a68836528( starttime )
{
    self notify( #"hash_19502d9e796d4cce" );
    self endon( #"hash_19502d9e796d4cce" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"button_released" );
    endtime = starttime + getholdtime();
    self.var_f8a9874de10eadb8 = endtime;
    currenttime = starttime;
    
    while ( endtime >= currenttime )
    {
        currenttime = gettime();
        self setclientomnvar( "ui_quick_use_progress", min( ( currenttime - starttime ) / ( endtime - starttime ), 1 ) );
        waitframe();
    }
    
    function_b1bdbe633a5c6807( "DEFAULT" );
    self notify( #"button_released" );
}

// Namespace quick_use
// Params 0, eflags: 0xc
// Checksum 0x5576b3ae, Offset: 0x29d1
// Size: 0x51
function private function_b6ddadb0fa18e508()
{
    self notify( #"hash_6f11fb416f9d7064" );
    self endon( #"hash_6f11fb416f9d7064" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"quick_use_pressed_kbm" );
        
        if ( player::isaliveandnotinlaststand( self ) )
        {
            function_b1bdbe633a5c6807( "DEFAULT" );
        }
    }
}

// Namespace quick_use
// Params 0, eflags: 0xc
// Checksum 0xb837ea4e, Offset: 0x2a2a
// Size: 0x44
function private function_82d2b26c2e211dfc()
{
    self notify( #"hash_b1151d72d7dbecda" );
    self endon( #"hash_b1151d72d7dbecda" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"quick_use_pressed" );
        function_8b109303109c6fe6( 1 );
    }
}

// Namespace quick_use
// Params 0, eflags: 0xc
// Checksum 0x6c0db2ed, Offset: 0x2a76
// Size: 0x43
function private function_65467fe2f141d1e1()
{
    self notify( #"hash_c9c929b27e61c88b" );
    self endon( #"hash_c9c929b27e61c88b" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"quick_use_release" );
        function_8b109303109c6fe6( 0 );
    }
}

// Namespace quick_use
// Params 0, eflags: 0xc
// Checksum 0x8a6f040b, Offset: 0x2ac1
// Size: 0xb8
function private function_3e810d87c5c085b8()
{
    self notify( #"hash_f5e2ce32b6f31397" );
    self endon( #"hash_f5e2ce32b6f31397" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( utility::issharedfuncdefined( #"player", #"isaliveandnotinlaststand" ) )
    {
        while ( !self [[ utility::getsharedfunc( #"player", #"isaliveandnotinlaststand" ) ]]( self ) )
        {
            waitframe();
        }
    }
    
    function_3e75b34009daf933();
    
    if ( function_33ce1272468894c7( "BANDAGE" ) || function_33ce1272468894c7( "PAIN_KILLERS" ) || function_33ce1272468894c7( "MEDKIT" ) )
    {
        function_3e75b34009daf933( #"hash_564154fd82037502", undefined, 1 );
    }
}

// Namespace quick_use
// Params 0, eflags: 0xc
// Checksum 0x78267c3b, Offset: 0x2b81
// Size: 0xa2
function private function_4161a5998db5cfe()
{
    self notify( #"hash_217c9479975fd44f" );
    self endon( #"hash_217c9479975fd44f" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"sedative_inhaler_cleared" );
    
    while ( true )
    {
        self waittill( #"hash_c93b150749601d3e" );
        
        if ( utility::issharedfuncdefined( #"player", #"isaliveandnotinlaststand" ) && self [[ utility::getsharedfunc( #"player", #"isaliveandnotinlaststand" ) ]]( self ) )
        {
            function_3e75b34009daf933( #"sedative_inhaler_event", undefined, 1 );
        }
        
        waitframe();
    }
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x19081f37, Offset: 0x2c2b
// Size: 0x39, Type: bool
function private function_70abb62c015faa43( params )
{
    if ( params.var_6e707b07634b5bf4 && self isnightvisionon() )
    {
        return true;
    }
    
    return !self isnightvisionon() && self.var_70abb62c015faa43;
}

// Namespace quick_use
// Params 3, eflags: 0x4
// Checksum 0x806276d5, Offset: 0x2c6d
// Size: 0x25, Type: bool
function private triggerfilter( var_11bf9622e9646279, trigger, payload )
{
    return !isplayer( var_11bf9622e9646279 );
}

// Namespace quick_use
// Params 3, eflags: 0x4
// Checksum 0xd3e749cb, Offset: 0x2c9b
// Size: 0xf9
function private function_d5cf11fa80a00b39( player, trigger, params )
{
    if ( player.var_70abb62c015faa43 )
    {
        return;
    }
    
    if ( player isnightvisionon() )
    {
        var_df7262d31af3644a = common_item::function_c6f3ef3dcb4c55c0( "nvg", #"getcurrent" );
        
        if ( !var_df7262d31af3644a )
        {
            return;
        }
        
        currentnvg = player [[ var_df7262d31af3644a ]]();
        
        if ( !currentnvg.name )
        {
            return;
        }
        
        itembundle = function_6b1a30e162172513( currentnvg.name );
        function_e4e5ec01e5ea6aff( itembundle, undefined, 1 );
        return;
    }
    
    player.var_70abb62c015faa43 = 1;
    
    if ( !level.var_aa5d856ff74f6b34[ "NVG" ] || !level.var_aa5d856ff74f6b34[ "NVG" ].items )
    {
        return;
    }
    
    player function_3e75b34009daf933( #"nvg_event", undefined, 1 );
}

// Namespace quick_use
// Params 3, eflags: 0x4
// Checksum 0x18e20823, Offset: 0x2d9c
// Size: 0xd4
function private function_ddb2018fced67a6d( player, trigger, params )
{
    player.var_70abb62c015faa43 = undefined;
    var_df7262d31af3644a = common_item::function_c6f3ef3dcb4c55c0( "nvg", #"getcurrent" );
    
    if ( !var_df7262d31af3644a )
    {
        return;
    }
    
    currentnvg = player [[ var_df7262d31af3644a ]]();
    
    if ( !currentnvg.name )
    {
        return;
    }
    
    itembundle = function_6b1a30e162172513( currentnvg.name );
    
    if ( !player isnightvisionon() )
    {
        function_e4e5ec01e5ea6aff( itembundle, undefined, 1, undefined, undefined, { #var_6e707b07634b5bf4:1 } );
        return;
    }
    
    function_e4e5ec01e5ea6aff( itembundle, undefined, 1, #"toggle_off_nvg", 1, { #var_6e707b07634b5bf4:1 } );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x3ee60a93, Offset: 0x2e78
// Size: 0x20
function private function_6c482d9a4e881569( slot )
{
    return self.var_c414206804b86889[ slot ?? "DEFAULT" ];
}

// Namespace quick_use
// Params 6, eflags: 0x4
// Checksum 0x803ae538, Offset: 0x2ea1
// Size: 0x208
function private function_e4e5ec01e5ea6aff( itembundle, isvaliditem, var_3c32e1b7f7b47822, updateevent, inflatepriority, params )
{
    if ( !self.var_2b02866e9cb008f0 || !itembundle )
    {
        return;
    }
    
    bundlename = itembundle.itembundlename ?? common_item::function_e044c3e813daec3a( itembundle );
    
    if ( !bundlename || !self.var_2b02866e9cb008f0[ bundlename ] )
    {
        return;
    }
    
    lootid = common_item::function_779887309ec71dfe( itembundle );
    slot = itembundle.var_dccdc786c72b8620 ?? "DEFAULT";
    
    if ( self.var_c414206804b86889[ slot ] && common_item::function_779887309ec71dfe( self.var_c414206804b86889[ slot ].itembundle ) == lootid && ( !isvaliditem || !var_3c32e1b7f7b47822 ) )
    {
        self.var_c414206804b86889[ slot ] = undefined;
    }
    
    if ( !var_3c32e1b7f7b47822 )
    {
        self.var_2b02866e9cb008f0[ bundlename ].itembundle = undefined;
        
        if ( self.var_2b02866e9cb008f0[ bundlename ].cooldowns )
        {
            currenttime = gettime();
            clearcooldowns = 1;
            
            foreach ( cooldown in self.var_2b02866e9cb008f0[ bundlename ].cooldowns ?? [] )
            {
                if ( cooldown > currenttime )
                {
                    clearcooldowns = 0;
                    break;
                }
            }
            
            if ( clearcooldowns )
            {
                self.var_2b02866e9cb008f0[ bundlename ].cooldowns = undefined;
            }
        }
    }
    
    function_3e75b34009daf933( updateevent, undefined, inflatepriority, undefined, params );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xa42f57dd, Offset: 0x30b1
// Size: 0x6b
function private function_cd2e8c7a76f77ed5( itembundle )
{
    if ( !isdefined( self.var_2b02866e9cb008f0 ) )
    {
        self.var_2b02866e9cb008f0 = [];
    }
    
    bundlename = common_item::function_e044c3e813daec3a( itembundle );
    
    if ( !isdefined( self.var_2b02866e9cb008f0[ bundlename ] ) )
    {
        self.var_2b02866e9cb008f0[ bundlename ] = {};
    }
    
    self.var_2b02866e9cb008f0[ bundlename ].itembundle = itembundle;
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x4722e0bf, Offset: 0x3124
// Size: 0x70
function private function_c14cbd2b301dcaf1( params )
{
    if ( params.empty )
    {
        clearinventoryitem( params );
        return;
    }
    
    if ( params.item )
    {
        itembundle = common_item::function_6b8ff3d5f2688336( params.item );
        
        if ( itembundle.quickusable )
        {
            function_cd2e8c7a76f77ed5( itembundle );
            function_3e75b34009daf933( undefined, itembundle );
        }
    }
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x99c19b23, Offset: 0x319c
// Size: 0x344
function private clearinventoryitem( params )
{
    if ( !params.additionaldata.scriptable || params.additionaldata.var_ec66b34329c3a64e )
    {
        return;
    }
    
    itembundle = common_item::function_80af1e9daffacc7d( params.additionaldata.scriptable );
    
    if ( !itembundle.quickusable )
    {
        return;
    }
    
    bundlename = common_item::function_e044c3e813daec3a( itembundle );
    isvaliditem = 1;
    var_e417c45fdf3d1b55 = function_c03321eb45610b7b();
    
    foreach ( var_9a868ae1400e3424 in var_e417c45fdf3d1b55 )
    {
        if ( !level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ] )
        {
            continue;
        }
        
        foreach ( item in level.var_aa5d856ff74f6b34[ var_9a868ae1400e3424 ].items )
        {
            if ( item.itembundlename == bundlename && !function_e9afe2df9621fb54( item, var_9a868ae1400e3424 ) )
            {
                isvaliditem = 0;
                break;
            }
        }
        
        if ( !isvaliditem )
        {
            break;
        }
    }
    
    var_3c32e1b7f7b47822 = 0;
    scriptablename = isxhashasset( params.additionaldata.scriptable ) ? params.additionaldata.scriptable : getxhashasset( params.additionaldata.scriptable );
    
    if ( self.inventory.size > 0 )
    {
        foreach ( inventorygroup in self.inventory )
        {
            foreach ( additionaldata in inventorygroup )
            {
                if ( scriptablename === additionaldata.scriptable )
                {
                    var_3c32e1b7f7b47822 = 1;
                    break;
                }
            }
            
            if ( var_3c32e1b7f7b47822 )
            {
                break;
            }
        }
    }
    
    if ( isvaliditem && var_3c32e1b7f7b47822 )
    {
        return;
    }
    
    function_e4e5ec01e5ea6aff( itembundle, isvaliditem, var_3c32e1b7f7b47822 );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x895fbab4, Offset: 0x34e8
// Size: 0x61
function private onplayerconnect( params )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    thread function_4161a5998db5cfe();
    self notifyonplayercommand( "quick_use_release", "-actionslot 4" );
    self notifyonplayercommand( "quick_use_pressed", "+actionslot 4" );
    self notifyonplayercommand( "quick_use_pressed_kbm", "killstreak2" );
    thread function_82d2b26c2e211dfc();
    thread function_65467fe2f141d1e1();
    thread function_b6ddadb0fa18e508();
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x4674a0a3, Offset: 0x3551
// Size: 0x7a
function private onplayerdamaged( params )
{
    if ( !isplayer( params.victim ) || isbot( params.victim ) )
    {
        return;
    }
    
    if ( params.objweapon.basename == "rex_radiation_dmz" )
    {
        function_3e75b34009daf933( #"rad_blockers_event", undefined, 1 );
        return;
    }
    
    function_3e75b34009daf933( #"player_damaged", undefined, 1 );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x4ac82b18, Offset: 0x35d3
// Size: 0x64
function private function_5ee702f5eb5d65e8( params )
{
    if ( !params.itembundle )
    {
        return;
    }
    
    newparams = { #player:self, #additionaldata:{ #scriptable:params.itembundle.scriptable } };
    clearinventoryitem( newparams );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xe985f0f4, Offset: 0x363f
// Size: 0x23
function private OnSpawned( params )
{
    if ( !params.revivespawn )
    {
        return;
    }
    
    function_3e75b34009daf933();
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0xb148ac10, Offset: 0x366a
// Size: 0x13
function private function_feb3b1429e105dec( params )
{
    thread function_3e810d87c5c085b8();
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x485b5cca, Offset: 0x3685
// Size: 0x1f
function private function_d5654e1a4c6202c7( params )
{
    function_3e75b34009daf933( #"no_stamina", undefined, 1 );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x76498a64, Offset: 0x36ac
// Size: 0x1d
function private function_88beb0b0354f83e( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_3e75b34009daf933();
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x310bc692, Offset: 0x36d1
// Size: 0x2e
function private function_be5aa2b016d17cbd( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_3e75b34009daf933( #"hash_aa7c0dbef3e86ee4", undefined, 1, "ARMOR" );
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x17a8a14b, Offset: 0x3707
// Size: 0x48
function private function_67ea77a1c360b27( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.armorhealth > 0 && function_f265964fc950467b( params ) )
    {
        function_3e75b34009daf933( #"hash_5447fe6feab51288", undefined, 1, "ARMOR" );
    }
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x89bcde5c, Offset: 0x3757
// Size: 0x9e
function private function_ab3de13d2a78dd8c( params )
{
    if ( !isent( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( params.isdisabling )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"player", #"isaliveandnotinlaststand" ) && self [[ utility::getsharedfunc( #"player", #"isaliveandnotinlaststand" ) ]]( self ) )
    {
        var_4bffb08fbb61e10e = params.removing ? #"hash_564154fd82037502" : undefined;
        function_3e75b34009daf933( var_4bffb08fbb61e10e, undefined, isdefined( var_4bffb08fbb61e10e ) );
    }
}

// Namespace quick_use
// Params 1, eflags: 0x4
// Checksum 0x775fb68c, Offset: 0x37fd
// Size: 0xe8
function private function_964e631da185fc64( params )
{
    if ( hasomnvar( "ui_quick_use_item_id" ) )
    {
        self setclientomnvar( "ui_quick_use_item_id", 0 );
    }
    
    if ( quickprompt::function_106bde9d618791e9() && level.var_d0e159df5d64faa6[ self.quickprompt.type ] )
    {
        quickprompt::quickpromptcancel();
    }
    
    self notify( #"quick_use_prompt_cleared" );
    
    foreach ( slot, _ in level.var_7c2e2e929eb2ea59 )
    {
        self.var_c414206804b86889[ slot ] = undefined;
        self notify( "quick_use_slot_cleared_" + slot );
    }
}

/#

    // Namespace quick_use
    // Params 2, eflags: 0x4
    // Checksum 0x239bb80c, Offset: 0x38ed
    // Size: 0xd5, Type: dev
    function private function_d6720a92e1898efb( command, args )
    {
        if ( !isdefined( level.var_d6720a92e1898efb ) )
        {
            level.var_d6720a92e1898efb = {};
        }
        
        switch ( command )
        {
            case #"hash_7b6614415d1b2e48":
                if ( !isdefined( args[ 0 ] ) )
                {
                    break;
                }
                
                iprintln( "<dev string:x2d>" + int( args[ 0 ] ) );
                level.var_d6720a92e1898efb.cooldown = int( args[ 0 ] );
                break;
            case #"hash_d4dde12b38318c68":
                if ( !isdefined( args[ 0 ] ) )
                {
                    break;
                }
                
                iprintln( "<dev string:x43>" + int( args[ 0 ] ) );
                level.var_d6720a92e1898efb.timeout = int( args[ 0 ] );
                break;
            default:
                break;
        }
    }

#/
