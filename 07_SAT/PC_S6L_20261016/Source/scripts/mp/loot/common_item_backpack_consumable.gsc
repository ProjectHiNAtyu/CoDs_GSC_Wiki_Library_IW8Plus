// scripts\mp\loot\common_item_backpack_consumable.gsc  (hash_05181bc20b17bf91.gscc) (size: 6981 Bytes / 0x1b45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7554c60 (123030624)
// size ...... 6981 (0x1b45)
// includes .. 13  (offset: 0x1a71)
// strings ... 7   (offset: 0x1ad9)
// dev strs .. 0   (offset: 0x1b45)
// exports ... 15  (offset: 0x1059)
// cseg ...... 0xd1 + 0xf88 (0x1059)
// imports ... 68  (offset: 0x12b1)
// animtree1 . 0   (offset: 0x1b45)
// animtree2 . 0   (offset: 0x1b45)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\iodine_pills;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\health_chunks;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerhealth;

#namespace item_backpack_consumable;

// Namespace item_backpack_consumable
// Params 0, eflags: 0x5
// Checksum 0x34a28cc7, Offset: 0xef
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_backpack_consumable", #"common_item", &init, undefined );
}

// Namespace item_backpack_consumable
// Params 0, eflags: 0x4
// Checksum 0x980f11e0, Offset: 0x118
// Size: 0x9a
function private init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "backpack_consumable" );
    common_item::function_84174b793b5fe9a7( "backpack_consumable", #"use", &use_backpack_consumable );
    common_item::function_84174b793b5fe9a7( "backpack_consumable", #"canautouse", &utility::always_false );
    common_item::function_84174b793b5fe9a7( "backpack_consumable", #"hash_9e49dfaa7c147654", &utility::always_false );
    common_item::function_84174b793b5fe9a7( "backpack_consumable", #"hash_2d3b76ff260f2d68", &function_60de033329bbd305 );
    
    /#
        level thread dev::devcommandwatcher( @"backpack_consumable", &function_68a70c688341c838 );
    #/
}

// Namespace item_backpack_consumable
// Params 4, eflags: 0x4
// Checksum 0xc27204c7, Offset: 0x1ba
// Size: 0x32
function private use_backpack_consumable( itembundle, item, autouse, var_981c264073bf1154 )
{
    return item.count;
}

// Namespace item_backpack_consumable
// Params 5, eflags: 0x4
// Checksum 0x67a5888, Offset: 0x1f5
// Size: 0x3e
function private function_60de033329bbd305( index, itembundle, lootid, quantity, fromgroup )
{
    thread function_eddb0aeb3f2d9019( index, itembundle, lootid, quantity, fromgroup );
}

// Namespace item_backpack_consumable
// Params 3, eflags: 0x4
// Checksum 0xc2a4ab0a, Offset: 0x23b
// Size: 0xdb
function private function_6e5a2a2216eb55ee( weapon, itembundle, resultstruct )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"hash_6c025249317f7ca8" );
    starttime = gettime();
    thread function_ab9aa34b980f0e99( weapon, resultstruct );
    result = weapon_utility::giveandfireoffhandreliable( weapon );
    elapsedtime = gettime() - starttime;
    usetime = max( 0, ( itembundle.var_b3adca5c638d83ed ?? 0 ) - elapsedtime / 1000 );
    wait usetime;
    resultstruct.result = result;
    resultstruct.usetime = usetime;
    self notify( #"hash_6c025249317f7ca8" );
}

// Namespace item_backpack_consumable
// Params 2, eflags: 0xc
// Checksum 0xadab4644, Offset: 0x31e
// Size: 0x93
function private function_ab9aa34b980f0e99( weapon, resultstruct )
{
    self notify( #"hash_fb12451e3f3b0881" );
    self endon( #"hash_fb12451e3f3b0881" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"hash_6c025249317f7ca8" );
    
    while ( !self hasweapon( weapon ) )
    {
        waitframe();
    }
    
    while ( self hasweapon( weapon ) )
    {
        waitframe();
    }
    
    resultstruct.result = 0;
    self notify( #"hash_6c025249317f7ca8" );
}

// Namespace item_backpack_consumable
// Params 0, eflags: 0x4
// Checksum 0xf4c0e381, Offset: 0x3b9
// Size: 0x5f, Type: bool
function private function_7241bf302cb1a9da()
{
    return self isparachuting() || self ismantling() || self ishanging() || self isonladder() || self isonascender() || self isdiving() || self issprintsliding() || self isinexecutionattack() || self isinexecutionvictim() || !val::get( "allow_consumables" );
}

// Namespace item_backpack_consumable
// Params 5
// Checksum 0x972d9981, Offset: 0x421
// Size: 0x32b
function function_eddb0aeb3f2d9019( index, itembundle, lootid, quantity, fromgroup )
{
    if ( !common_inventory_groups::inventorygroup_enabled() || function_7241bf302cb1a9da() )
    {
        return;
    }
    
    if ( itembundle.consumablehealth && health_chunks::isenabled() && !health_chunks::function_57d7450ef7a9c202() )
    {
        if ( isdefined( itembundle.var_b044baa89081d029 ) && utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( itembundle.var_b044baa89081d029 );
        }
        
        return;
    }
    
    itemtaken = 0;
    row = undefined;
    column = undefined;
    item = undefined;
    funcs = common_inventory_groups::function_987405ff5ee23e99( fromgroup );
    
    if ( isdefined( funcs.fromfunc ) && isdefined( funcs.var_65a6f7922d118cdd ) )
    {
        [ groupbundle, _ ] = self [[ funcs.var_65a6f7922d118cdd ]]();
        [ row, column ] = common_inventory_groups::function_12ee5af12df204b4( groupbundle, index );
        item = self [[ funcs.getfunc ]]( row, column );
        
        if ( !( isdefined( item ) && isdefined( item.type ) ) )
        {
            return;
        }
        
        currentlootid = common_item::function_6d301ac91c3cd13d( item );
        
        if ( currentlootid != lootid )
        {
            return;
        }
        
        if ( item.additionaldata )
        {
            item.additionaldata.var_ec66b34329c3a64e = 1;
        }
        
        self [[ funcs.fromfunc ]]( 1, 0, row, column );
        itemtaken = 1;
        
        if ( item.additionaldata.var_ec66b34329c3a64e )
        {
            item.additionaldata.var_ec66b34329c3a64e = undefined;
        }
    }
    
    usetime = 0;
    
    if ( isdefined( itembundle.consumableweapon ) )
    {
        common_item::function_ca1fd5f697b3b46( self, level.gametypebundle.pickupgestureweapon, level.gametypebundle.var_10688c489d4665d8 );
        gestureweapon = makeweapon( itembundle.consumableweapon );
        resultstruct = {};
        function_6e5a2a2216eb55ee( gestureweapon, itembundle, resultstruct );
        result = resultstruct.result;
        usetime = resultstruct.usetime ?? 0;
        
        if ( !result && itemtaken && isdefined( row ) && isdefined( column ) && isdefined( item ) )
        {
            self [[ funcs.tofunc ]]( item, row, column );
            return;
        }
    }
    
    if ( hasomnvar( "ui_using_consumable" ) )
    {
        self setclientomnvar( "ui_using_consumable", lootid );
    }
    
    function_6705303a9ca0a189( itembundle, usetime );
    callback::callback( #"inventory_item_used", { #itembundle:itembundle } );
}

// Namespace item_backpack_consumable
// Params 2
// Checksum 0xcbdd23a9, Offset: 0x754
// Size: 0x40e
function function_6705303a9ca0a189( itembundle, usetime )
{
    var_5b1545fe21d30a25 = itembundle.var_5b1545fe21d30a25;
    
    if ( var_5b1545fe21d30a25 )
    {
        var_5b1545fe21d30a25 = modified_values::function_14d05d73e63e1f9e( 12, var_5b1545fe21d30a25 );
    }
    
    if ( itembundle.consumableinfinitetacsprint )
    {
        thread function_921a8cd334c93b13( itembundle );
    }
    
    if ( var_5b1545fe21d30a25 )
    {
        activeconsumable = function_7d1458b1b4f68367( itembundle, var_5b1545fe21d30a25 );
        
        if ( !isdefined( self.var_29f2ab97549acbef ) )
        {
            self.var_29f2ab97549acbef = [];
        }
        
        self.var_29f2ab97549acbef[ self.var_29f2ab97549acbef.size ] = activeconsumable;
        thread function_f249af5453b94df5( activeconsumable );
    }
    
    if ( itembundle.var_ad6f440daf82c2d9 && health_chunks::isenabled() )
    {
        health_chunks::function_137ee85a17945df0( self );
    }
    
    var_ee906a110c9ed4f6 = 0;
    
    if ( itembundle.consumablehealth && health_chunks::isenabled() )
    {
        health_chunks::incrementchunks( self, itembundle.consumablehealth, undefined, istrue( itembundle.var_c85f59aafda159b1 ), itembundle.var_de5b9d9cd4b15f57, itembundle.var_a8f51c439b70f42c );
        var_ee906a110c9ed4f6 = 1;
    }
    
    if ( itembundle.var_ac2cd3fffbccdcd6 )
    {
        playerhealth::function_fd91e6d94cab77e7( itembundle.ref, itembundle.var_ac2cd3fffbccdcd6 );
    }
    
    if ( itembundle.var_519b44128484c91a )
    {
        iodine_pills::function_a880610ef6c2556d( var_5b1545fe21d30a25, itembundle.var_d34414bd08c7fedc );
    }
    
    if ( !var_ee906a110c9ed4f6 && itembundle.var_c85f59aafda159b1 )
    {
        if ( usetime > 0 )
        {
            thread playerhealth::forcehealthregendelay( self, 1, usetime, itembundle.var_a8f51c439b70f42c );
        }
        else
        {
            playerhealth::forcehealthregen( self, 1, itembundle.var_a8f51c439b70f42c );
        }
    }
    
    perklist = [];
    
    if ( isdefined( itembundle.consumableperks ) && !isdefined( self.perks[ itembundle.ref ] ) )
    {
        foreach ( perkentry in itembundle.consumableperks )
        {
            if ( perkentry.perk )
            {
                perklist[ perklist.size ] = perkentry.perk;
            }
        }
        
        if ( perklist.size > 0 )
        {
            if ( !perks::function_ae69f867e887ac4a( itembundle.ref ) )
            {
                perks::registerscriptperk( itembundle.ref, undefined, undefined, perklist );
            }
            
            self [[ utility::getsharedfunc( #"perk", #"giveperk" ) ]]( itembundle.ref );
        }
    }
    
    if ( itembundle.consumablevalues.size > 0 )
    {
        foreach ( valueentry in itembundle.consumablevalues )
        {
            if ( !valueentry.var_9dc3e06e7b1817a3 )
            {
                val::set( itembundle.ref, valueentry.valuestring, valueentry.valuebool );
                continue;
            }
            
            val::set( itembundle.ref, valueentry.valuestring, valueentry.valuenum );
        }
    }
    
    if ( isdefined( itembundle.consumablevisionset ) )
    {
        self visionsetnakedforplayer( itembundle.consumablevisionset, itembundle.var_1a15aa5bea6103b0 ?? 0.5 );
        return;
    }
    
    if ( isdefined( itembundle.var_9ae0351158245ac0 ) )
    {
        pbgpostfxbundlestart( self, itembundle.var_9ae0351158245ac0 );
    }
}

// Namespace item_backpack_consumable
// Params 2, eflags: 0x4
// Checksum 0x18b3b4ff, Offset: 0xb6a
// Size: 0x4d
function private function_7d1458b1b4f68367( itembundle, duration )
{
    return { #endtime:gettime() + duration * 1000, #starttime:gettime(), #initialduration:duration, #bundle:itembundle };
}

// Namespace item_backpack_consumable
// Params 1, eflags: 0x4
// Checksum 0x279761d8, Offset: 0xbc0
// Size: 0x280
function private function_f249af5453b94df5( activeconsumable )
{
    itembundle = activeconsumable.bundle;
    self notify( itembundle.ref );
    self endon( itembundle.ref );
    self endon( #"disconnect" );
    
    /#
        if ( isdefined( level.var_68a70c688341c838.timeout ) )
        {
            activeconsumable.endtime = gettime() + level.var_68a70c688341c838.timeout * 1000;
        }
    #/
    
    var_68d5c64e3eb8bc82 = activeconsumable.endtime - gettime();
    utility::waittill_any_timeout( var_68d5c64e3eb8bc82 / 1000, "death", "last_stand_enter" );
    
    if ( itembundle.consumableperks.size > 0 )
    {
        self [[ utility::getsharedfunc( #"perk", #"removeperk" ) ]]( itembundle.ref );
    }
    
    if ( itembundle.consumablevalues.size > 0 )
    {
        val::reset_all( itembundle.ref );
    }
    
    self.var_29f2ab97549acbef = arrayremove( self.var_29f2ab97549acbef, activeconsumable );
    
    if ( isdefined( itembundle.consumablevisionset ) )
    {
        self visionsetnakedforplayer( "", itembundle.var_1a15aa5bea6103b0 ?? 0.5 );
    }
    else if ( isdefined( itembundle.var_9ae0351158245ac0 ) )
    {
        var_6066c454b24a081f = 1;
        
        foreach ( consumable in self.var_29f2ab97549acbef )
        {
            if ( consumable.bundle.var_9ae0351158245ac0 == itembundle.var_9ae0351158245ac0 )
            {
                var_6066c454b24a081f = 0;
                break;
            }
        }
        
        if ( var_6066c454b24a081f )
        {
            pbgpostfxbundleend( self, itembundle.var_9ae0351158245ac0 );
        }
    }
    
    if ( itembundle.var_ad6f440daf82c2d9 && health_chunks::isenabled() )
    {
        health_chunks::function_9834bbf38e7cf81( self );
    }
    
    if ( itembundle.var_ac2cd3fffbccdcd6 )
    {
        playerhealth::function_b1fb4d148779580e( itembundle.ref );
    }
    
    self notify( itembundle.ref + "_ended" );
}

// Namespace item_backpack_consumable
// Params 1
// Checksum 0x46797b8d, Offset: 0xe48
// Size: 0x141
function function_ea2aa0911809c7f1( extensionscalar )
{
    if ( !isdefined( self.var_29f2ab97549acbef ) || !self.var_29f2ab97549acbef.size )
    {
        return;
    }
    
    foreach ( activeconsumable in self.var_29f2ab97549acbef )
    {
        if ( !( isdefined( activeconsumable ) && isdefined( activeconsumable.bundle ) && isdefined( activeconsumable.initialduration ) && isdefined( activeconsumable.endtime ) ) )
        {
            continue;
        }
        
        maxendtime = activeconsumable.starttime + activeconsumable.initialduration * 2 * 1000;
        extensionms = activeconsumable.initialduration * ( extensionscalar - 1 ) * 1000;
        activeconsumable.endtime = min( activeconsumable.endtime + extensionms, maxendtime );
        thread function_f249af5453b94df5( activeconsumable );
    }
}

// Namespace item_backpack_consumable
// Params 1, eflags: 0x4
// Checksum 0x75d4b479, Offset: 0xf91
// Size: 0x47
function private function_921a8cd334c93b13( itembundle )
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( itembundle.ref + "_ended" );
    
    while ( true )
    {
        self refreshsprinttime();
        waitframe();
    }
}

// Namespace item_backpack_consumable
// Params 2, eflags: 0x4
// Checksum 0xe6b9f111, Offset: 0xfe0
// Size: 0x79
function private function_68a70c688341c838( command, args )
{
    if ( !isdefined( level.var_68a70c688341c838 ) )
    {
        level.var_68a70c688341c838 = {};
    }
    
    switch ( command )
    {
        case #"hash_d4dde12b38318c68":
            if ( !isdefined( args[ 0 ] ) )
            {
                break;
            }
            
            level.var_68a70c688341c838.timeout = int( args[ 0 ] );
            break;
        default:
            break;
    }
}

