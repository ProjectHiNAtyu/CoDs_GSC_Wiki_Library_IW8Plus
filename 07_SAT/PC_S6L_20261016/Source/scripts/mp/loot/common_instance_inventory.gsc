// scripts\mp\loot\common_instance_inventory.gsc  (hash_6899515ff500b795.gscc) (size: 48703 Bytes / 0xbe3f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x519c9196 (1369215382)
// size ...... 48703 (0xbe3f)
// includes .. 21  (offset: 0xb707)
// strings ... 38  (offset: 0xb7af)
// dev strs .. 79  (offset: 0xb9f3)
// exports ... 117 (offset: 0x802b)
// cseg ...... 0x2f4 + 0x7d37 (0x802b)
// imports ... 261 (offset: 0x9273)
// animtree1 . 0   (offset: 0xbe3f)
// animtree2 . 0   (offset: 0xbe3f)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\bounty_wanted;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\currency;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_resource;
#using scripts\mp\loot\common_item_upgrade;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\operator;

#namespace common_instance_inventory;

// Namespace common_instance_inventory
// Params 0
// Checksum 0xba52733a, Offset: 0x312
// Size: 0x1e6
function init()
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !level.var_8671749938fb45db && !getdvarint( @"ob_sm_reload", 0 ) )
    {
        function_5efeefe42cb80e59( 1 );
    }
    
    function_94ca2f60d212be9f();
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    utility::registersharedfunc( #"instanceInventory", #"isenabled", &isenabled );
    utility::registersharedfunc( #"instanceInventory", #"inventoryisvalid", &inventoryisvalid );
    utility::registersharedfunc( #"instanceInventory", #"hash_10edfd81317fb1b4", &function_f40306de6384b50 );
    utility::registersharedfunc( #"instanceInventory", #"hash_4cd131c09ba7529a", &function_834357b6721a42ff );
    utility::registersharedfunc( #"instanceInventory", #"hash_22f8ae7cbaae85d7", &function_f33e3fa40fc0faf2 );
    
    if ( operatorsenabled() )
    {
        utility::registersharedfunc( #"instanceInventory", #"getActiveOperatorLootID", &getactiveoperatorlootid );
        utility::registersharedfunc( #"instanceInventory", #"getActiveOperatorSkinLootID", &getactiveoperatorskinlootid );
        utility::registersharedfunc( #"instanceInventory", #"getActiveOperatorExecutionLootID", &getactiveoperatorexecutionlootid );
        utility::registersharedfunc( #"player", #"hash_c631568a218d88a6", &function_71d5424a56326d82 );
        utility::registersharedfunc( #"player", #"hash_3f6034cbc65791c3", &function_4cf88b6754916a38 );
        utility::registersharedfunc( #"rank", #"hash_6aead767a74875f5", &function_8d761e58e114e5c4 );
    }
    
    /#
        thread debugsetup();
    #/
    
    level.var_dd675d2bd46d6e5f = function_21b3e0d31a0e475e();
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x1f0b2b38, Offset: 0x500
// Size: 0x4c
function function_21b3e0d31a0e475e()
{
    var_dd675d2bd46d6e5f = [];
    var_dd675d2bd46d6e5f[ "Cash" ] = 0;
    var_dd675d2bd46d6e5f[ "Synthetics" ] = 2;
    var_dd675d2bd46d6e5f[ "Electronics" ] = 4;
    var_dd675d2bd46d6e5f[ "Chemicals" ] = 3;
    var_dd675d2bd46d6e5f[ "Metals" ] = 1;
    var_dd675d2bd46d6e5f[ "RareMetals" ] = 5;
    return var_dd675d2bd46d6e5f;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x926031c, Offset: 0x555
// Size: 0x41
function function_4e9663fa969f9a97( classindex )
{
    tablename = level.classtablename;
    operator = class::table_getitem( tablename, 1 ).operator;
    return operator;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xbc19d564, Offset: 0x59f
// Size: 0x53
function function_f3d18ca2f6800bfe( classindex )
{
    tablename = level.classtablename;
    operator = class::table_getitem( tablename, 1 ).operator;
    skin = operator::function_447fce2531e40d0e( operator );
    return skin;
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xdb6fa0e4, Offset: 0x5fb
// Size: 0x72
function isenabled()
{
    if ( !isdefined( level.instanceinventoryenabled ) )
    {
        if ( getdvarint( @"online_is_devmapping", 0 ) )
        {
            level.instanceinventoryenabled = 0;
            println( "<dev string:x24>" );
        }
        else
        {
            level.instanceinventoryenabled = isdefined( level.gamemodebundle ) ? istrue( level.gamemodebundle.var_b1e6ec706428fa46 ) : 0;
        }
    }
    
    return level.instanceinventoryenabled;
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x889191f5, Offset: 0x676
// Size: 0x15
function function_9003ead622d55c1c()
{
    return level.gamemodebundle.var_8ce969c710598bce;
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x9073dc1b, Offset: 0x694
// Size: 0x2f
function function_4e5bcac59dca0bd()
{
    if ( !isdefined( level.var_4e5bcac59dca0bd ) )
    {
        level.var_4e5bcac59dca0bd = getdvarint( @"hash_6da7630c95f567aa", 1 );
    }
    
    return level.var_4e5bcac59dca0bd;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x9f09b064, Offset: 0x6cc
// Size: 0x17
function function_b1b5b47fe399f1e7( keeploot )
{
    self.var_ccf86e5648a4b600 = keeploot;
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xc7354570, Offset: 0x6eb
// Size: 0xc, Type: bool
function function_e29d054f46b7548f()
{
    return istrue( self.var_ccf86e5648a4b600 );
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xea8ecb, Offset: 0x700
// Size: 0x203
function private function_94ca2f60d212be9f()
{
    if ( isdefined( level.gamemodebundle ) && level.gamemodebundle.var_ed590077848588c2 )
    {
        scriptbundle = getscriptbundle( level.gamemodebundle.var_ed590077848588c2 );
    }
    
    if ( isdefined( scriptbundle ) )
    {
        level.var_dbfa02b2281d0b30 = [];
        
        if ( scriptbundle.locationdata.size > 0 && scriptbundle.locationdata[ 0 ].instanceslots.size > 0 )
        {
            foreach ( locationdata in scriptbundle.locationdata )
            {
                foreach ( instanceslot in locationdata.instanceslots )
                {
                    level.var_dbfa02b2281d0b30[ instanceslot.ref ] = instanceslot;
                }
            }
            
            return;
        }
        
        foreach ( instanceslot in scriptbundle.instanceslots )
        {
            level.var_dbfa02b2281d0b30[ instanceslot.ref ] = instanceslot;
        }
    }
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x41a829f6, Offset: 0x90b
// Size: 0x2e, Type: bool
function function_28e60cf07393549d( slotref )
{
    if ( !isdefined( level.var_dbfa02b2281d0b30 ) )
    {
        function_94ca2f60d212be9f();
    }
    
    return isdefined( level.var_dbfa02b2281d0b30[ slotref ] );
}

// Namespace common_instance_inventory
// Params 3
// Checksum 0x9da6d4f4, Offset: 0x942
// Size: 0x60
function function_4c1e57c205fb4b91( player, slotref, var_16e703d46e75b118 = 0 )
{
    instanceslot = function_6e525a83b773221( slotref );
    
    if ( isdefined( instanceslot ) )
    {
        return player function_41f811caf4053d98( instanceslot.location, instanceslot.sublocation + var_16e703d46e75b118 );
    }
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x4ca86a8a, Offset: 0x9aa
// Size: 0x5f
function function_6e525a83b773221( slotref )
{
    if ( !isdefined( level.var_dbfa02b2281d0b30 ) )
    {
        function_94ca2f60d212be9f();
    }
    
    if ( isdefined( level.var_dbfa02b2281d0b30[ slotref ] ) )
    {
        return level.var_dbfa02b2281d0b30[ slotref ];
    }
    
    assert( 0, "<dev string:x77>" + getxhashsourcename( slotref ) + "<dev string:xb1>" );
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0xaae1916c, Offset: 0xa11
// Size: 0x12
function private inventoryisvalid( player )
{
    return player function_bcc29d70f0e86b37();
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0xb0ac5ba6, Offset: 0xa2c
// Size: 0x16
function private onplayerconnect( params )
{
    self.var_eddebed5872b3b52 = [];
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0x2cd5ba9f, Offset: 0xa4a
// Size: 0x216
function private onplayerspawned( params )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( self.var_c72cb0043263a756 )
    {
        return;
    }
    
    if ( isdefined( self.primaryweapons ) )
    {
        foreach ( weapon in self.primaryweapons )
        {
            if ( !isnullweapon( weapon ) && isdefined( weapon ) && isdefined( weapon.receiverblueprint ) && isdefined( weapon.receiverblueprint.attachmentdata ) && weapon.receiverblueprint.attachmentdata == "iw9_rec_mike4_v35" )
            {
                itembundle = getscriptbundle( "itemspawnentry:" + "ob_jup_item_ammomod_deadwire" );
                
                if ( isdefined( itembundle ) )
                {
                    item = spawnstruct();
                    item.type = itembundle.scriptable;
                    item.count = 1;
                    item_upgrade::function_951e0669fdee416a( weapon, itembundle, item );
                }
            }
        }
    }
    
    common_inventory::function_1202b827227d4ad2();
    common_inventory::function_4e7fa885e76e773e( common_inventory::function_538786216800afe9() );
    function_7784f775ef81d303();
    function_7db102f337c4fe73();
    
    if ( self.classstruct && self.classstruct.backpackitems )
    {
        common_inventory::function_23e6c4f7cc3350d3( self.classstruct );
    }
    
    callback::add( #"player_item_drop", &function_db5d35a47ac2e15c );
    callback::add( #"player_item_pickup", &function_b3b00a69365acc69 );
    
    if ( hasomnvar( "ui_wallet_amount" ) )
    {
        self setclientomnvar( "ui_wallet_amount", function_d9382cb4b4fd3cfe() );
    }
    
    self.var_c72cb0043263a756 = 1;
    callback::callback( #"instance_inventory_setup", {} );
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xd4aacbb, Offset: 0xc68
// Size: 0x761
function private function_7784f775ef81d303()
{
    if ( utility::issharedfuncdefined( #"instanceInventory", #"hash_b4203b4404eb0127" ) )
    {
        utility::callsharedfunc( #"instanceInventory", #"hash_b4203b4404eb0127", self );
        return;
    }
    
    if ( !function_9003ead622d55c1c() )
    {
        return;
    }
    
    if ( !isdefined( level.var_dcf14cc71588a322 ) )
    {
        level.var_dcf14cc71588a322 = 0;
    }
    
    if ( !isdefined( self.var_1fa81a0e31f08222 ) )
    {
        self.var_1fa81a0e31f08222 = level.var_dcf14cc71588a322;
        level.var_dcf14cc71588a322 += 1;
    }
    
    var_549d5d76fc055575 = [];
    instanceslot = function_6e525a83b773221( #"primaryweapon" );
    primaryweaponinstance = function_4c1e57c205fb4b91( self, #"primaryweapon" );
    
    if ( function_ae3907698ee6e6f1( primaryweaponinstance ) && primaryweaponinstance.kind != 11 )
    {
        var_549d5d76fc055575[ var_549d5d76fc055575.size ] = { #slotname:#"primary_0", #instance:primaryweaponinstance, #sublocation:instanceslot.sublocation, #location:instanceslot.location };
    }
    
    instanceslot = function_6e525a83b773221( #"secondaryweapon" );
    secondaryweaponinstance = function_4c1e57c205fb4b91( self, #"secondaryweapon" );
    
    if ( function_ae3907698ee6e6f1( secondaryweaponinstance ) && secondaryweaponinstance.kind != 11 )
    {
        var_549d5d76fc055575[ var_549d5d76fc055575.size ] = { #slotname:#"primary_1", #instance:secondaryweaponinstance, #sublocation:instanceslot.sublocation, #location:instanceslot.location };
    }
    
    instanceslot = function_6e525a83b773221( #"backpackweapon" );
    var_1827e45669a6c403 = function_4c1e57c205fb4b91( self, #"backpackweapon" );
    
    if ( function_ae3907698ee6e6f1( var_1827e45669a6c403 ) && var_1827e45669a6c403.kind != 11 )
    {
        var_549d5d76fc055575[ var_549d5d76fc055575.size ] = { #slotname:#"backpack_0", #instance:var_1827e45669a6c403, #sublocation:instanceslot.sublocation, #location:instanceslot.location };
    }
    
    if ( getdvarint( @"hash_1b1ec093041f3814", 1 ) != 0 )
    {
        var_3a5eefa6c4a5557c = [];
        ismaptomapinfil = istrue( utility::callsharedfunc( #"instanceInventory", #"ismaptomapinfil" ) );
        
        for ( backpackindex = 0; backpackindex < common_inventory::function_7d8024a0beed38ae() ; backpackindex++ )
        {
            iteminstance = function_4c1e57c205fb4b91( self, #"backpackcontents", backpackindex );
            
            if ( !function_ae3907698ee6e6f1( iteminstance ) || iteminstance.kind != 17 )
            {
                continue;
            }
            
            if ( ismaptomapinfil )
            {
                continue;
            }
            
            insuredslot = function_9513862f69ec0498( 15, iteminstance, 1 );
            
            if ( !isdefined( insuredslot ) )
            {
                self function_1fe0234f56138fe1( iteminstance.instanceid );
                assertmsg( "<dev string:xb3>" + self.name + "<dev string:xda>" + iteminstance.instanceid + "<dev string:x100>" + iteminstance.lootid + "<dev string:x110>" + "<dev string:x162>" );
                continue;
            }
            
            insuredinstance = function_bc8e9ab9a89df0bf( iteminstance );
            
            if ( insuredinstance.cooldownexpiration > getsystemtime() )
            {
                self function_1fe0234f56138fe1( iteminstance.instanceid );
                assertmsg( "<dev string:xb3>" + self.name + "<dev string:x1c1>" + iteminstance.instanceid + "<dev string:x200>" );
                continue;
            }
            
            if ( isdefined( var_3a5eefa6c4a5557c[ insuredslot ] ) )
            {
                self function_1fe0234f56138fe1( iteminstance.instanceid );
                assertmsg( "<dev string:xb3>" + self.name + "<dev string:xda>" + insuredinstance.instanceid + "<dev string:x241>" + var_3a5eefa6c4a5557c[ insuredslot ] + "<dev string:x283>" );
                continue;
            }
            
            itembundle = common_item::function_b202b16941992cca( iteminstance.lootid, [ #"schematiccooldown" ] );
            
            if ( !itembundle.schematiccooldown )
            {
                continue;
            }
            
            newcooldown = getsystemtime() + itembundle.schematiccooldown;
            self function_86c4417b398dd00( insuredinstance.instanceid, int( newcooldown ) );
            var_3a5eefa6c4a5557c[ insuredslot ] = insuredinstance.instanceid;
            
            /#
                function_661cb619c4f68d2( insuredinstance, self, "<dev string:x2a9>" );
            #/
        }
    }
    
    var_3a5eefa6c4a5557c = [];
    self.var_e6495f88793f9119 = [];
    
    foreach ( var_802ecd743c9856e0 in var_549d5d76fc055575 )
    {
        insuredslot = function_9513862f69ec0498( 15, var_802ecd743c9856e0.instance, 1 );
        
        if ( !isdefined( insuredslot ) )
        {
            continue;
        }
        
        insuredinstance = function_77826520a07b6812( var_802ecd743c9856e0.instance );
        
        if ( insuredinstance.cooldownexpiration > getsystemtime() )
        {
            self function_1fe0234f56138fe1( var_802ecd743c9856e0.instance.instanceid );
            assertmsg( "<dev string:xb3>" + self.name + "<dev string:x2cc>" + "<dev string:x31f>" + var_802ecd743c9856e0.instance.instanceid + "<dev string:x34e>" );
            continue;
        }
        
        if ( isdefined( var_3a5eefa6c4a5557c[ insuredslot ] ) )
        {
            self function_1fe0234f56138fe1( var_802ecd743c9856e0.instance.instanceid );
            assertmsg( "<dev string:xb3>" + self.name + "<dev string:x350>" + "<dev string:x3b5>" + var_3a5eefa6c4a5557c[ insuredslot ] + "<dev string:x3d6>" + var_802ecd743c9856e0.instance.instanceid + "<dev string:x34e>" );
            continue;
        }
        
        function_a568f4d2f7413a60( [ 1 ], [ self.var_1fa81a0e31f08222 ], var_802ecd743c9856e0.instance, 0 );
        var_802ecd743c9856e0.instance = self function_41f811caf4053d98( var_802ecd743c9856e0.location, var_802ecd743c9856e0.sublocation );
        self.var_e6495f88793f9119[ self.var_e6495f88793f9119.size ] = var_802ecd743c9856e0.instance;
        
        if ( isdefined( var_802ecd743c9856e0.slotname ) )
        {
            self.var_eddebed5872b3b52[ var_802ecd743c9856e0.slotname ] = { #insecure:function_dba82bdee30f1799( var_802ecd743c9856e0.instance.var_c11bbd62e8f23645 ), #secure:function_dba82bdee30f1799( var_802ecd743c9856e0.instance.metadata ) };
        }
        
        var_3a5eefa6c4a5557c[ insuredslot ] = var_802ecd743c9856e0.instance.instanceid;
        
        /#
            function_661cb619c4f68d2( var_802ecd743c9856e0.instance, self, "<dev string:x3fb>" );
        #/
    }
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x7d74a973, Offset: 0x13d1
// Size: 0x7f
function private function_7db102f337c4fe73()
{
    if ( utility::callsharedfunc( #"dmz", #"hash_8ba44ea29695fe01", self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"instanceInventory", #"grantitems" ) )
    {
        utility::callsharedfunc( #"instanceInventory", #"grantitems", self );
        return;
    }
    
    common_inventory::function_1202b827227d4ad2();
    function_3e0c3e937f1b144f();
    function_32dfd67f56a5499();
    function_e229a8e5e3673309();
    function_df41cac36eb507d1();
    function_15ddb9a423b85e92();
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xc4692cfe, Offset: 0x1458
// Size: 0x49
function function_79183cad3c7b34e5()
{
    iteminstance = function_4c1e57c205fb4b91( self, #"operator" );
    bountyScore = function_9513862f69ec0498( 7, iteminstance, 1 );
    
    if ( isdefined( bountyScore ) )
    {
        bounty_wanted::function_79183cad3c7b34e5( int( bountyScore ), 1 );
    }
}

// Namespace common_instance_inventory
// Params 2, eflags: 0x4
// Checksum 0x43ba3ac9, Offset: 0x14a9
// Size: 0x126
function private function_bdcb0463bd7f5e70( lootid, instanceid )
{
    var_eb17b44f95ecb1e7 = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( !isdefined( var_eb17b44f95ecb1e7 ) || function_99a3c189718cdd9e( var_eb17b44f95ecb1e7 ) )
    {
        return;
    }
    
    if ( !level.var_97db93a6b414090d )
    {
        var_6400ce73760d266a = function_b617404fdc090121( var_eb17b44f95ecb1e7 );
        
        if ( var_6400ce73760d266a.var_1d1583780b2c6606 )
        {
            if ( isdefined( var_6400ce73760d266a.var_1e3e1bca444e9636 ) )
            {
                var_eb17b44f95ecb1e7 = var_6400ce73760d266a.var_1e3e1bca444e9636;
            }
            else
            {
                return;
            }
        }
    }
    
    itembundle = getscriptbundle( var_eb17b44f95ecb1e7 );
    
    if ( !isdefined( itembundle ) )
    {
        return;
    }
    
    if ( !itembundle.var_74fdf8cd1e01b989 )
    {
        assertmsg( "<dev string:xb3>" + self.name + "<dev string:x42c>" + common_item::function_d43f27b1302f1c44( lootid ) + "<dev string:x44f>" + instanceid + "<dev string:x496>" );
        return;
    }
    
    count = common_item::function_598dd39282efb544( itembundle.spawncount ?? 1 );
    params = common_item::function_77600f92048df72d( itembundle, count );
    params.var_b63192f61121f97 = 1;
    return params;
}

// Namespace common_instance_inventory
// Params 5
// Checksum 0x1fae8635, Offset: 0x15d8
// Size: 0x8b
function grantinstance( player, lootid, instanceid = 0, quantity, autouse )
{
    params = function_bdcb0463bd7f5e70( lootid, instanceid );
    
    if ( !isdefined( params ) )
    {
        return;
    }
    
    params.count = quantity ?? params.count;
    common_item::function_2b5e2ff57d5f392( params, autouse, 1 );
    callback::callback( "instance_inventory_item_equipped", params );
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x6393368b, Offset: 0x166b
// Size: 0xb1
function function_b49be02162262bdf( player )
{
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "weapon", { #slotname:#"primary_0" } );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        if ( !class::ismeleeweapon( var_8fb8e1fb220cca48.weaponobj ) )
        {
            inventory_utility::_switchtoweaponimmediate( var_8fb8e1fb220cca48.weaponobj );
            return;
        }
    }
    
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "weapon", { #slotname:#"primary_1" } );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        if ( !class::ismeleeweapon( var_8fb8e1fb220cca48.weaponobj ) )
        {
            inventory_utility::_switchtoweaponimmediate( var_8fb8e1fb220cca48.weaponobj );
        }
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x2162ae49, Offset: 0x1724
// Size: 0x20d
function function_3e0c3e937f1b144f()
{
    if ( !isdefined( level.var_dbfa02b2281d0b30 ) )
    {
        function_94ca2f60d212be9f();
    }
    
    foreach ( slot in level.var_dbfa02b2281d0b30 )
    {
        if ( slot.location == 0 )
        {
            continue;
        }
        
        iteminstance = self function_41f811caf4053d98( slot.location, slot.sublocation );
        
        if ( !function_ae3907698ee6e6f1( iteminstance ) )
        {
            if ( slot.var_eeadcc32b1a82cbb && slot.var_74b30c282949fe5a )
            {
                grantinstance( self, common_item::items_getlootidfromref( slot.var_74b30c282949fe5a ), -1, 1, slot.commonitemautouse );
            }
            
            continue;
        }
        
        if ( slot.commonitemequip )
        {
            quantity = iteminstance.quantity;
            
            if ( isdefined( quantity ) )
            {
                quantity = int( quantity );
            }
            
            grantinstance( self, iteminstance.lootid, iteminstance.instanceid, quantity );
        }
        
        if ( slot.var_246041c61730fe9b )
        {
            if ( isdefined( iteminstance.var_a834790f492b07f8 ) )
            {
                foreach ( childid in iteminstance.var_a834790f492b07f8 )
                {
                    if ( childid <= 0 )
                    {
                        continue;
                    }
                    
                    grantinstance( self, childid );
                }
            }
        }
    }
    
    function_b49be02162262bdf( self );
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x6a5b888e, Offset: 0x1939
// Size: 0x16b
function private function_15ddb9a423b85e92()
{
    weaponinstance = function_4c1e57c205fb4b91( self, #"backpackweapon" );
    
    if ( !function_ae3907698ee6e6f1( weaponinstance ) )
    {
        return;
    }
    
    blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
    struct = function_4da778f38e8b3044( weaponinstance, blueprintindex );
    
    if ( !struct )
    {
        return;
    }
    
    backpackweapon = weapon::buildweapon( struct.weaponref, struct.attachmentrefs, struct.weaponcamo, struct.weaponreticle, struct.weaponvariant, struct.attachmentids, struct.weaponcosmetic, struct.weaponstickers, undefined, struct.var_b3ca7b468de89ea3, 1, struct.blueprintattachmentignorelist );
    
    if ( !backpackweapon )
    {
        return;
    }
    
    itembundle = common_item::function_b202b16941992cca( weaponinstance.lootid );
    validslots = common_inventory_groups::function_8b575930cbcb2457( 1, itembundle );
    
    if ( validslots.size == 1 )
    {
        slot = validslots[ 0 ];
        common_inventory::function_1923cd40e1b4efc8( backpackweapon );
        count = item_weapon::function_40acef7fe7fe290( backpackweapon );
        common_inventory::inventory_setbackpackitematindex( slot.index, weaponinstance.lootid, common_item::function_44eacd480abb5b94( count ) );
    }
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xed2206d0, Offset: 0x1aac
// Size: 0x116
function private function_df41cac36eb507d1()
{
    var_650893b22d069c38 = function_6e525a83b773221( #"hash_50f543d584b67a14" );
    var_a2cb6b9874562834 = function_6e525a83b773221( #"traitsend" );
    
    for ( i = var_650893b22d069c38.sublocation; i <= var_a2cb6b9874562834.sublocation ; i++ )
    {
        treeinstance = function_4c1e57c205fb4b91( self, #"hash_50f543d584b67a14", i - var_650893b22d069c38.sublocation );
        
        if ( !function_ae3907698ee6e6f1( treeinstance ) )
        {
            continue;
        }
        
        for ( traitindex = 0; traitindex < 22 ; traitindex++ )
        {
            if ( treeinstance.var_a834790f492b07f8[ traitindex ] && treeinstance.var_a834790f492b07f8[ traitindex ] != 0 )
            {
                traitselected = int( function_9513862f69ec0498( traitindex + 1, treeinstance, 1 ) ?? 0 );
                
                if ( !traitselected )
                {
                    continue;
                }
                
                grantinstance( self, treeinstance.var_a834790f492b07f8[ traitindex ] );
            }
        }
    }
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xbb1bf908, Offset: 0x1bca
// Size: 0x116
function private function_fe21365fc0794b1b()
{
    [ groupbundle, _ ] = common_inventory_groups::function_ecbef11f7cab32fa();
    
    if ( !groupbundle )
    {
        return;
    }
    
    ismaptomapexfil = istrue( utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) );
    var_3e8f826139ed4001 = common_inventory_groups::function_19a5a29f5cd0df45( groupbundle ) ?? 0;
    
    for ( i = 0; i < var_3e8f826139ed4001 ; i++ )
    {
        [ row, column ] = common_inventory_groups::function_12ee5af12df204b4( groupbundle, i );
        item = common_inventory_groups::function_26e8d89c0e534760( row, column );
        
        if ( !item )
        {
            continue;
        }
        
        lootid = common_item::function_6d301ac91c3cd13d( item );
        newinstance = function_52847cc4624e1a94( lootid, item.count ?? 1, #"hash_67e3368f14a3272e", 5, i, ismaptomapexfil );
    }
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xb8268eb, Offset: 0x1ce8
// Size: 0x128
function private function_e229a8e5e3673309()
{
    [ groupbundle, _ ] = common_inventory_groups::function_ecbef11f7cab32fa();
    
    if ( !isdefined( groupbundle ) )
    {
        return;
    }
    
    var_40544e729a946c9c = function_6e525a83b773221( #"hash_67e3368f14a3272e" );
    
    if ( !isdefined( var_40544e729a946c9c ) || var_40544e729a946c9c.location == 0 )
    {
        return;
    }
    
    var_3e8f826139ed4001 = common_inventory_groups::function_19a5a29f5cd0df45( groupbundle ) ?? 0;
    
    for ( i = 0; i < var_3e8f826139ed4001 ; i++ )
    {
        slotinstance = self function_41f811caf4053d98( var_40544e729a946c9c.location, var_40544e729a946c9c.sublocation + i );
        
        if ( function_ae3907698ee6e6f1( slotinstance ) )
        {
            itembundle = common_item::function_b202b16941992cca( slotinstance.lootid );
            quantity = slotinstance.quantity;
            
            if ( isdefined( quantity ) )
            {
                quantity = int( quantity );
            }
            
            item = common_item::function_77600f92048df72d( itembundle, quantity );
            common_inventory_groups::function_41fe07e971a7e566( item, 0, i );
        }
    }
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xe9f38479, Offset: 0x1e18
// Size: 0x3e6
function private function_32dfd67f56a5499()
{
    ismaptomapinfil = istrue( utility::callsharedfunc( #"instanceInventory", #"ismaptomapinfil" ) );
    var_4375d83555c8dd6f = undefined;
    offset = undefined;
    
    for ( backpackindex = 0; backpackindex < common_inventory::function_7d8024a0beed38ae() ; backpackindex++ )
    {
        lootinstance = function_4c1e57c205fb4b91( self, #"backpackcontents", backpackindex );
        
        if ( !function_ae3907698ee6e6f1( lootinstance ) )
        {
            continue;
        }
        
        var_eb17b44f95ecb1e7 = common_item_database::function_db2360bc1c33f6f9( lootinstance.lootid );
        
        if ( !isdefined( var_eb17b44f95ecb1e7 ) || function_99a3c189718cdd9e( var_eb17b44f95ecb1e7 ) )
        {
            continue;
        }
        
        itembundle = getscriptbundle( var_eb17b44f95ecb1e7 );
        
        if ( !isdefined( itembundle ) )
        {
            continue;
        }
        
        if ( !ismaptomapinfil && !itembundle.var_de7f3047419a5c39 )
        {
            assertmsg( "<dev string:xb3>" + self.name + "<dev string:x42c>" + common_item::function_d43f27b1302f1c44( lootinstance.lootid ) + "<dev string:x44f>" + lootinstance.instanceid + "<dev string:x496>" );
            continue;
        }
        
        if ( isdefined( itembundle ) && common_item::function_16e8c106491eeaca( itembundle ) == "schematic" && getdvarint( @"hash_1b1ec093041f3814", 1 ) != 0 )
        {
            if ( ismaptomapinfil )
            {
                common_inventory::inventory_setbackpackitematindex( backpackindex, lootinstance.lootid, 1 );
                continue;
            }
            
            var_b494e99d4c8a06b5 = itembundle.unlockedacquisition;
            
            if ( !isdefined( var_b494e99d4c8a06b5 ) )
            {
                assertmsg( "<dev string:x499>" + common_item::function_d43f27b1302f1c44( lootinstance.lootid ) + "<dev string:x4da>" );
                continue;
            }
            
            var_29ea0ab82b7f46ae = getscriptbundle( var_b494e99d4c8a06b5 );
            
            if ( !isdefined( var_29ea0ab82b7f46ae ) )
            {
                assertmsg( "<dev string:x50f>" + getxhashsourcename( var_b494e99d4c8a06b5 ) + "<dev string:x55a>" + "<dev string:x5a7>" );
                continue;
            }
            
            acquisitionlootid = common_item::function_779887309ec71dfe( var_29ea0ab82b7f46ae );
            
            if ( !isdefined( acquisitionlootid ) )
            {
                continue;
            }
            
            if ( lootinstance.kind != 17 )
            {
                assertmsg( "<dev string:x5e3>" + lootinstance.instanceid + "<dev string:x34e>" + "<dev string:x615>" + common_item::function_d43f27b1302f1c44( lootinstance.lootid ) + "<dev string:x34e>" + "<dev string:x626>" );
                continue;
            }
            
            common_inventory::inventory_setbackpackitematindex( backpackindex, acquisitionlootid, 1 );
            continue;
        }
        
        if ( !ismaptomapinfil && lootinstance.kind == 17 )
        {
            assertmsg( "<dev string:x5e3>" + lootinstance.instanceid + "<dev string:x34e>" + "<dev string:x679>" + lootinstance.lootid + "<dev string:x687>" + "<dev string:x6b9>" );
            continue;
        }
        
        quantity = 1;
        itemquantity = lootinstance.quantity;
        
        if ( isdefined( itemquantity ) )
        {
            itemquantity = int( itemquantity );
            
            if ( itemquantity > 1 )
            {
                quantity = itemquantity;
            }
        }
        
        if ( common_inventory_groups::inventorygroup_enabled() )
        {
            if ( !isdefined( var_4375d83555c8dd6f ) )
            {
                var_4375d83555c8dd6f = common_inventory_groups::function_c27ac785b5373b73()[ 0 ];
            }
            
            if ( !isdefined( offset ) )
            {
                for ( j = 0; j < common_inventory::function_7d8024a0beed38ae() ; j++ )
                {
                    if ( common_inventory_groups::function_d9dc48ec3cc713b4( itembundle, var_4375d83555c8dd6f, j, lootinstance.lootid ) )
                    {
                        offset = j;
                        break;
                    }
                }
            }
            
            startindex = backpackindex + offset;
            
            for ( j = startindex; j < common_inventory::function_7d8024a0beed38ae() ; j++ )
            {
                if ( common_inventory_groups::function_d9dc48ec3cc713b4( itembundle, var_4375d83555c8dd6f, j, lootinstance.lootid ) )
                {
                    common_inventory::inventory_setbackpackitematindex( j, lootinstance.lootid, quantity );
                    offset += j - startindex;
                    break;
                }
            }
            
            continue;
        }
        
        common_inventory::function_1a85f583119d9740( var_eb17b44f95ecb1e7, itembundle, common_item::function_77600f92048df72d( itembundle, quantity ), undefined, lootinstance.lootid );
    }
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0x147df315, Offset: 0x2206
// Size: 0x61
function private onplayerdisconnect( params )
{
    if ( !self hasplayerdata() )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"instanceInventory", #"onPlayerDisconnect" ) )
    {
        utility::callsharedfunc( #"instanceInventory", #"onPlayerDisconnect", params );
        return;
    }
    
    if ( !self.inventoryfinalized )
    {
        function_8fd84f733b81e456();
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xc6cb33b5, Offset: 0x226f
// Size: 0x1c7
function function_8fd84f733b81e456()
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( self.inventoryfinalized )
    {
        assertmsg( "<dev string:x70d>" + self.name + "<dev string:x752>" );
        return;
    }
    
    var_39b6fb8e4ff7b6ee = function_e29d054f46b7548f();
    callback::callback( #"hash_7e070a8c7f137ece", { #var_39b6fb8e4ff7b6ee:var_39b6fb8e4ff7b6ee } );
    
    if ( var_39b6fb8e4ff7b6ee )
    {
        if ( isdmzgamemode() )
        {
            operatorinstance = function_4c1e57c205fb4b91( self, #"operator" );
            
            if ( function_ae3907698ee6e6f1( operatorinstance ) )
            {
                function_a568f4d2f7413a60( [ 6 ], [ 0 ], operatorinstance, 0 );
            }
        }
        
        utility::callsharedfunc( #"instanceInventory", #"hash_1ea36aea7859a35d", self );
        extractitems();
        utility::callsharedfunc( #"instanceInventory", #"hash_5e6dae73583ffa98", self );
        unlockitems();
    }
    else
    {
        if ( isdmzgamemode() )
        {
            operatorinstance = function_4c1e57c205fb4b91( self, #"operator" );
            
            if ( function_ae3907698ee6e6f1( operatorinstance ) )
            {
                var_e5b900fc7bd1a2cc = 1;
                var_3b9fc30e30de93c2 = 0;
                
                if ( var_3b9fc30e30de93c2 )
                {
                    var_e5b900fc7bd1a2cc = 999;
                }
                else
                {
                    var_e5b900fc7bd1a2cc = ( function_8d64eb5ec00a1818( self ) ?? 0 ) + 1;
                }
                
                function_a568f4d2f7413a60( [ 6 ], [ var_e5b900fc7bd1a2cc ], operatorinstance, 0 );
            }
        }
        
        if ( function_4e5bcac59dca0bd() )
        {
            function_3170decee5857e88();
        }
    }
    
    function_b0ee9317bf6219();
    function_1b9949fdb11cd517();
    function_fe21365fc0794b1b();
    callback::callback( #"hash_24b3cb793ce0fba3", { #var_39b6fb8e4ff7b6ee:var_39b6fb8e4ff7b6ee } );
    self function_2b6ded790c955ccb();
    self.inventoryfinalized = 1;
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0x73b77c58, Offset: 0x243e
// Size: 0x2e
function function_ff7ae483d1728aae( player, featureindex )
{
    if ( player function_d2d396f77637ea86( featureindex ) == 0 )
    {
        player function_73c179b18f6c2ed8( featureindex, 1 );
        return 1;
    }
}

// Namespace common_instance_inventory
// Params 6, eflags: 0x4
// Checksum 0x1e2b5dd, Offset: 0x2474
// Size: 0x283
function private function_52847cc4624e1a94( lootid, quantity, slotref, inventorygroupid, index, ismaptomapexfil )
{
    function_295a263162af11ac( slotref, index );
    
    if ( !lootid )
    {
        return;
    }
    
    itembundle = common_item::function_b202b16941992cca( lootid );
    
    if ( !itembundle )
    {
        return;
    }
    
    if ( itembundle.var_976db38cf3a0b7b9 )
    {
        if ( function_ff7ae483d1728aae( self, itembundle.var_976db38cf3a0b7b9 ) )
        {
            if ( !isdefined( self.recipeunlocks ) )
            {
                self.recipeunlocks = 0;
            }
            
            self.recipeunlocks += 1;
            return;
        }
    }
    
    if ( !ismaptomapexfil && !itembundle.var_de7f3047419a5c39 )
    {
        return;
    }
    
    kind = 13;
    
    if ( itembundle.var_b22f7855894dc6a0 )
    {
        switch ( itembundle.var_b22f7855894dc6a0 )
        {
            case #"hash_78e8e9a60d7025a7":
                kind = 13;
                break;
            case #"hash_61d9379cb6db8320":
                kind = 12;
                break;
            case #"hash_5fe9df5902455824":
                kind = 18;
                break;
        }
    }
    
    if ( !ismaptomapexfil )
    {
        function_dfecd60c4938fd9( self, itembundle, quantity );
        typeref = common_item::function_16e8c106491eeaca( itembundle );
        
        if ( typeref == "dogtag" && common_inventory_groups::inventorygroup_enabled() )
        {
            additionaldata = common_inventory_groups::function_af51bdd9c1c5acd3( inventorygroupid, index );
            
            if ( additionaldata.bountyScore )
            {
                cashamount = bounty_wanted::function_90c77fff71f390d7( additionaldata.bountyScore );
                function_c74fbad95ae19935( self, cashamount );
                
                if ( !isdefined( self.var_95d6a65f7e13eb0 ) )
                {
                    self.var_95d6a65f7e13eb0 = 0;
                }
                
                self.var_95d6a65f7e13eb0 += 1;
                
                if ( !isdefined( self.bountypayout ) )
                {
                    self.bountypayout = 0;
                }
                
                self.bountypayout += cashamount;
            }
        }
    }
    
    if ( itembundle.var_5bfb1d2b2e3e656f )
    {
        function_295a263162af11ac( slotref, index );
        return;
    }
    
    function_faae73a378ff8c45( lootid, kind, slotref, [], [], [], index );
    newinstance = function_4c1e57c205fb4b91( self, slotref, index );
    bundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( bundlename )
    {
        function_b17acc4a951e49f5( bundlename, newinstance );
    }
    
    if ( function_ae3907698ee6e6f1( newinstance ) )
    {
        self function_c17a2151cfca6224( newinstance.instanceid, quantity );
    }
    
    return newinstance;
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xc5bc0538, Offset: 0x2700
// Size: 0x4b9
function private extractitems()
{
    if ( utility::issharedfuncdefined( #"instanceInventory", #"extractitems" ) )
    {
        utility::callsharedfunc( #"instanceInventory", #"extractitems", self );
        return;
    }
    
    function_1ce404f00d7b49f6( #"primary_0", #"primaryweapon" );
    function_1ce404f00d7b49f6( #"primary_1", #"secondaryweapon" );
    function_1ce404f00d7b49f6( #"backpack_0", #"backpackweapon" );
    function_1ce404f00d7b49f6( #"tertiary_0", #"tertiaryweapon" );
    function_c6b78d397d7be030( "lethal", 13, #"lethal" );
    function_c6b78d397d7be030( "tactical", 13, #"tactical" );
    function_c6b78d397d7be030( "super", 13, #"fieldupgrade" );
    
    if ( isdefined( level.gamemodebundle ) && level.gamemodebundle.var_11b58b36c8e3f5e5 )
    {
        function_a09ca489c9212e4c();
    }
    
    function_c6b78d397d7be030( "killstreak", 13, #"killstreak" );
    function_c6b78d397d7be030( "backpack", 13, #"backpack" );
    function_c6b78d397d7be030( "plate_carrier", 13, #"platecarrier" );
    function_c6b78d397d7be030( "revive", 13, #"selfrevive" );
    function_c6b78d397d7be030( "gasmask", 13, #"head" );
    function_c6b78d397d7be030( "armor", 13, #"armor" );
    function_c6b78d397d7be030( "parachute", 13, #"parachute" );
    operatorinstance = function_4c1e57c205fb4b91( self, #"operator" );
    
    if ( function_ae3907698ee6e6f1( operatorinstance ) )
    {
        function_a568f4d2f7413a60( [ 7 ], [ bounty_wanted::function_90db6f6e5ee89a2e( 1 ) ], operatorinstance, 0 );
        
        if ( self.kills && self.kills > 0 )
        {
            function_1f613da4ed6f2986( 2, self.kills, operatorinstance, 0 );
        }
        
        if ( !isdefined( self.var_aa57cbc2a1b17c3c ) )
        {
            self.var_aa57cbc2a1b17c3c = 0;
        }
        
        if ( !isdefined( self.opscompleted ) )
        {
            self.opscompleted = 0;
        }
        
        if ( self.var_aa57cbc2a1b17c3c + self.opscompleted > 0 )
        {
            function_1f613da4ed6f2986( 3, self.var_aa57cbc2a1b17c3c + self.opscompleted, operatorinstance, 0 );
        }
        
        function_1f613da4ed6f2986( 5, 1, operatorinstance, 0 );
    }
    
    progressioninstance = function_4c1e57c205fb4b91( self, #"operatorprogression" );
    currentprogression = "0";
    
    if ( function_ae3907698ee6e6f1( progressioninstance ) )
    {
        currentprogression = function_9513862f69ec0498( 1, progressioninstance, 0 ) ?? 0;
    }
    else
    {
        function_faae73a378ff8c45( function_28764917512a41cd( #"operatorprogression" ), 13, #"operatorprogression" );
        progressioninstance = function_4c1e57c205fb4b91( self, #"operatorprogression" );
    }
    
    progressionamount = 1;
    progressionoverride = getdvarint( @"hash_6e14d30b84c33938", 0 );
    
    if ( progressionoverride )
    {
        progressionamount = progressionoverride;
    }
    
    function_a568f4d2f7413a60( [ 1 ], [ int( currentprogression ) + progressionamount ], progressioninstance, 0 );
    ismaptomapexfil = istrue( utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) );
    itemsadded = 0;
    
    for ( backpackindex = 0; backpackindex < common_inventory::function_7d8024a0beed38ae() ; backpackindex++ )
    {
        lootid = common_inventory::inventory_getlootidatbackpackindex( backpackindex );
        quantity = common_inventory::inventory_getquantityatbackpackindex( backpackindex );
        itemtype = common_item::function_9deb822f286163b1( lootid );
        
        if ( !isdefined( lootid ) || lootid == 0 || itemtype == "weapon" )
        {
            function_295a263162af11ac( #"backpackcontents", backpackindex );
            continue;
        }
        
        newinstance = function_52847cc4624e1a94( lootid, quantity, #"backpackcontents", 1, itemsadded, ismaptomapexfil );
        itemsadded++;
    }
    
    function_33120d622c8fa763( self );
    var_cfa53eed63bbf088 = common_item::function_c6f3ef3dcb4c55c0( "currency", #"getcurrent" );
    
    if ( isdefined( var_cfa53eed63bbf088 ) )
    {
        var_7ae260b14d9bedcc = self [[ var_cfa53eed63bbf088 ]]();
        
        if ( isdefined( var_7ae260b14d9bedcc.count ) )
        {
            cash = modified_values::function_14d05d73e63e1f9e( 3, var_7ae260b14d9bedcc.count );
            
            if ( function_ae3907698ee6e6f1( operatorinstance ) )
            {
                function_1f613da4ed6f2986( 4, cash, operatorinstance, 0 );
            }
            
            function_c74fbad95ae19935( self, cash );
        }
    }
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0xc8518482, Offset: 0x2bc1
// Size: 0x3d2
function function_1ce404f00d7b49f6( weaponslot, slotref )
{
    instanceslot = function_6e525a83b773221( slotref );
    
    if ( !isdefined( instanceslot ) || instanceslot.location == 0 )
    {
        return;
    }
    
    location = instanceslot.location;
    sublocation = instanceslot.sublocation;
    function_b86acd5b5496f84d( location, sublocation );
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "weapon", { #slotname:weaponslot } );
    
    if ( !isdefined( var_8fb8e1fb220cca48 ) )
    {
        return;
    }
    
    lootid = getweaponobjlootid( var_8fb8e1fb220cca48.weaponobj, var_8fb8e1fb220cca48.name );
    
    if ( !lootid )
    {
        return;
    }
    
    itembundle = getscriptbundle( var_8fb8e1fb220cca48.name );
    
    if ( isdefined( itembundle ) && !utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) )
    {
        if ( weaponslot == #"backpack_0" && !itembundle.var_de7f3047419a5c39 || weaponslot != #"backpack_0" && !itembundle.var_74fdf8cd1e01b989 )
        {
            return;
        }
    }
    
    components = function_1e555380baacc77f( var_8fb8e1fb220cca48.weaponobj );
    function_faae73a378ff8c45( lootid, 11, slotref, components );
    instance = self function_41f811caf4053d98( location, sublocation );
    
    if ( isdefined( self.var_eddebed5872b3b52[ weaponslot ] ) )
    {
        self function_c0d5d134ef5e068( instance.instanceid, 0, self.var_eddebed5872b3b52[ weaponslot ].secure );
        self function_c0d5d134ef5e068( instance.instanceid, 1, self.var_eddebed5872b3b52[ weaponslot ].insecure );
    }
    
    index = common_inventory_groups::function_e7c426ab761c55e4( 2, itembundle, undefined, undefined, var_8fb8e1fb220cca48.weaponobj );
    data = common_inventory_groups::function_af51bdd9c1c5acd3( 2, index );
    
    if ( data.attachmentslots )
    {
        function_a568f4d2f7413a60( [ 9 ], [ data.attachmentslots ], instance, 0 );
    }
    
    var_ec96f3fca615049 = 0;
    
    if ( isdefined( var_8fb8e1fb220cca48.weaponobj.stickerslot0 ) && var_8fb8e1fb220cca48.weaponobj.stickerslot0 != "none" )
    {
        var_ec96f3fca615049 |= 1;
    }
    
    if ( isdefined( var_8fb8e1fb220cca48.weaponobj.stickerslot1 ) && var_8fb8e1fb220cca48.weaponobj.stickerslot1 != "none" )
    {
        var_ec96f3fca615049 |= 2;
    }
    
    if ( isdefined( var_8fb8e1fb220cca48.weaponobj.stickerslot2 ) && var_8fb8e1fb220cca48.weaponobj.stickerslot2 != "none" )
    {
        var_ec96f3fca615049 |= 4;
    }
    
    if ( isdefined( var_8fb8e1fb220cca48.weaponobj.stickerslot3 ) && var_8fb8e1fb220cca48.weaponobj.stickerslot3 != "none" )
    {
        var_ec96f3fca615049 |= 8;
    }
    
    if ( isdefined( var_8fb8e1fb220cca48.weaponobj.var_73762c7cb8b2063 ) && var_8fb8e1fb220cca48.weaponobj.var_73762c7cb8b2063 != "none" )
    {
        var_ec96f3fca615049 |= 16;
    }
    
    if ( var_ec96f3fca615049 > 0 )
    {
        function_a568f4d2f7413a60( [ 13 ], [ var_ec96f3fca615049 ], instance, 1 );
    }
    
    if ( isdefined( var_8fb8e1fb220cca48.name ) )
    {
        function_b17acc4a951e49f5( var_8fb8e1fb220cca48.name, instance );
    }
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xe40fdca2, Offset: 0x2f9b
// Size: 0x115
function private function_a09ca489c9212e4c()
{
    instanceslot = function_6e525a83b773221( #"perk" );
    
    if ( !isdefined( instanceslot ) || instanceslot.location == 0 )
    {
        return;
    }
    
    location = instanceslot.location;
    sublocation = instanceslot.sublocation;
    function_b86acd5b5496f84d( location, sublocation );
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "perk_rig" );
    
    if ( !isdefined( var_8fb8e1fb220cca48 ) )
    {
        return;
    }
    
    itembundle = getscriptbundlefieldvalues( var_8fb8e1fb220cca48.name, [ #"ref", #"hash_a3136e2196e1d61a" ] );
    
    if ( !itembundle.var_74fdf8cd1e01b989 )
    {
        return;
    }
    
    lootid = common_item::items_getlootidfromref( itembundle.ref );
    
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    components = function_d40581772670a3e( self );
    function_faae73a378ff8c45( lootid, 13, #"perk", components );
}

// Namespace common_instance_inventory
// Params 6
// Checksum 0xe78303de, Offset: 0x30b8
// Size: 0x223
function function_c6b78d397d7be030( itemtype, kind, slotref, ignorecount, optionalindex, setquantity = 1 )
{
    instanceslot = function_6e525a83b773221( slotref );
    
    if ( !isdefined( instanceslot ) || instanceslot.location == 0 )
    {
        return;
    }
    
    location = instanceslot.location;
    sublocation = instanceslot.sublocation;
    function_b86acd5b5496f84d( location, sublocation );
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( itemtype, { #index:optionalindex } );
    
    if ( !var_8fb8e1fb220cca48.name || !ignorecount && ( !isdefined( var_8fb8e1fb220cca48.count ) || var_8fb8e1fb220cca48.count <= 0 ) )
    {
        return;
    }
    
    itembundle = getscriptbundlefieldvalues( var_8fb8e1fb220cca48.name, [ #"ref", #"hash_a3136e2196e1d61a" ] );
    
    if ( !itembundle.var_74fdf8cd1e01b989 && !utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) )
    {
        return;
    }
    
    lootid = common_item::items_getlootidfromref( itembundle.ref );
    
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    if ( isdefined( self.var_8cf9648fae56099c[ itembundle.ref ] ) )
    {
        lootid = self.var_92c60993d80d57b5[ itembundle.ref ];
    }
    
    function_faae73a378ff8c45( lootid, kind, slotref, var_8fb8e1fb220cca48.components );
    newinstance = function_4c1e57c205fb4b91( self, slotref );
    
    if ( isdefined( var_8fb8e1fb220cca48.name ) )
    {
        function_b17acc4a951e49f5( var_8fb8e1fb220cca48.name, newinstance );
    }
    
    if ( setquantity && !ignorecount )
    {
        self function_c17a2151cfca6224( newinstance.instanceid, var_8fb8e1fb220cca48.count );
    }
}

// Namespace common_instance_inventory
// Params 4, eflags: 0x4
// Checksum 0x1e528267, Offset: 0x32e3
// Size: 0xb8
function private function_4e8215d304ae789a( instance, paramoffset, params, includecount )
{
    if ( function_ae3907698ee6e6f1( instance ) )
    {
        params[ params.size ] = paramoffset;
        params[ params.size ] = instance.lootid;
        
        if ( includecount && instance.count == 1 )
        {
            paramoffset += 2;
        }
        else if ( includecount && instance.count > 1 )
        {
            params[ params.size ] = paramoffset;
            params[ params.size ] = instance.count;
            paramoffset += 1;
        }
        else
        {
            paramoffset += 1;
        }
    }
    
    return [ params, paramoffset ];
}

// Namespace common_instance_inventory
// Params 7
// Checksum 0x82f99293, Offset: 0x33a4
// Size: 0x2c6
function function_f33e3fa40fc0faf2( player, params, var_29220e1d48b1eba, startid, includecount, includeattachments, includeblueprint )
{
    paramoffset = startid;
    primaryinstance = function_4c1e57c205fb4b91( player, #"primaryweapon" );
    [ params, paramoffset ] = player function_5ad28e9208ba97b7( primaryinstance, paramoffset, params, includecount, includeattachments, includeblueprint );
    secondaryinstance = function_4c1e57c205fb4b91( player, #"secondaryweapon" );
    [ params, paramoffset ] = player function_5ad28e9208ba97b7( secondaryinstance, paramoffset, params, includecount, includeattachments, includeblueprint );
    var_1827e45669a6c403 = function_4c1e57c205fb4b91( player, #"backpackweapon" );
    [ params, paramoffset ] = player function_5ad28e9208ba97b7( var_1827e45669a6c403, paramoffset, params, includecount, includeattachments, includeblueprint );
    var_624838825e6e6732 = [];
    lethalinstance = function_4c1e57c205fb4b91( player, #"lethal" );
    var_624838825e6e6732[ var_624838825e6e6732.size ] = lethalinstance;
    tacticalinstance = function_4c1e57c205fb4b91( player, #"tactical" );
    var_624838825e6e6732[ var_624838825e6e6732.size ] = tacticalinstance;
    fieldupgradeinstance = function_4c1e57c205fb4b91( player, #"fieldupgrade" );
    var_624838825e6e6732[ var_624838825e6e6732.size ] = fieldupgradeinstance;
    killstreakinstance = function_4c1e57c205fb4b91( player, #"killstreak" );
    var_624838825e6e6732[ var_624838825e6e6732.size ] = killstreakinstance;
    
    for ( backpackindex = 0; backpackindex < common_inventory::function_7d8024a0beed38ae() ; backpackindex++ )
    {
        backpackinstance = function_4c1e57c205fb4b91( player, #"backpackcontents", backpackindex );
        var_624838825e6e6732[ var_624838825e6e6732.size ] = backpackinstance;
    }
    
    numitems = paramoffset - startid;
    
    foreach ( instance in var_624838825e6e6732 )
    {
        if ( numitems == 40 )
        {
            paramoffset = startid;
        }
        
        if ( numitems >= 40 )
        {
            [ var_29220e1d48b1eba, paramoffset ] = player function_4e8215d304ae789a( instance, paramoffset, var_29220e1d48b1eba, includecount );
            continue;
        }
        
        [ params, paramoffset ] = player function_4e8215d304ae789a( instance, paramoffset, params, includecount );
    }
    
    return [ params, var_29220e1d48b1eba ];
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xf889a76e, Offset: 0x3673
// Size: 0x117
function private unlockitems()
{
    if ( !isdefined( level.gametypebundle.var_5dd5f3ca4d3a1ea4 ) )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"instanceInventory", #"ismaptomapexfil", self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"instanceInventory", #"hash_a66c90fafb6dab1f" ) )
    {
        utility::callsharedfunc( #"instanceInventory", #"hash_a66c90fafb6dab1f", self );
        return;
    }
    
    aeeventname = level.gametypebundle.var_5dd5f3ca4d3a1ea4;
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    unlockeventparams = [];
    unlockeventparams[ unlockeventparams.size ] = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" );
    unlockeventparams[ unlockeventparams.size ] = 1;
    var_b5e0bc8772b58b40 = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" );
    includeblueprint = getdvarint( @"hash_a79d3b965878a390", 0 );
    unlockeventparams = function_f33e3fa40fc0faf2( unlockeventparams, undefined, var_b5e0bc8772b58b40, 0, 1, includeblueprint );
    self function_4daae137c098c6b8( aeeventid, unlockeventparams );
}

// Namespace common_instance_inventory
// Params 6, eflags: 0x4
// Checksum 0xe3b44740, Offset: 0x3792
// Size: 0x208
function private function_5ad28e9208ba97b7( instance, paramoffset, params, includecount, includeattachments, includeblueprint )
{
    if ( !function_ae3907698ee6e6f1( instance ) )
    {
        return [ params, paramoffset ];
    }
    
    offset = 1;
    
    if ( includecount )
    {
        offset = 2;
    }
    
    weaponlootid = instance.lootid;
    baseweaponlootid = undefined;
    baseweapon = function_357526af7a89075f( instance.lootid );
    
    if ( isdefined( baseweapon ) )
    {
        baseweaponref = weapon::getweaponrootname( baseweapon );
        iteminfo = getLootItemInfoFromRef( baseweaponref );
        
        if ( isdefined( iteminfo ) )
        {
            baseweaponlootid = iteminfo.itemid;
        }
    }
    
    if ( includeblueprint )
    {
        params[ params.size ] = paramoffset;
        params[ params.size ] = weaponlootid;
        paramoffset += offset;
    }
    
    params[ params.size ] = paramoffset;
    params[ params.size ] = baseweaponlootid;
    paramoffset += offset;
    variantref = loot::function_f54ecb89dfab8e8c( baseweaponlootid ? baseweaponlootid : weaponlootid );
    rootname = weapon::getweaponrootname( variantref );
    assetname = weapon::getweaponassetname( rootname );
    attachmentsbundles = function_d71c82dac3ffb910( assetname );
    
    foreach ( bundle in attachmentsbundles )
    {
        if ( isdefined( bundle ) )
        {
            attachmentlootid = bundle.lootid;
        }
        
        if ( !isdefined( attachmentlootid ) )
        {
            continue;
        }
        
        params[ params.size ] = paramoffset;
        params[ params.size ] = attachmentlootid;
        paramoffset += offset;
    }
    
    return [ params, paramoffset ];
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xbe2612a1, Offset: 0x39a3
// Size: 0x6d
function function_9eb28fa08e379699( player )
{
    primaryweaponinstance = function_4c1e57c205fb4b91( self, #"primaryweapon" );
    
    if ( function_ae3907698ee6e6f1( primaryweaponinstance ) )
    {
        return 1;
    }
    
    if ( game_utility::getgametype() != "ob" )
    {
        secondaryweaponinstance = function_4c1e57c205fb4b91( self, #"secondaryweapon" );
        
        if ( function_ae3907698ee6e6f1( secondaryweaponinstance ) )
        {
            return 1;
        }
    }
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xcd8a5ae2, Offset: 0x3a18
// Size: 0x91, Type: bool
function function_e453c5c6c15c0374( player )
{
    if ( function_9eb28fa08e379699( player ) )
    {
        return true;
    }
    
    if ( function_28e60cf07393549d( #"tertiaryweapon" ) )
    {
        var_dd4830c9142c8e9f = function_4c1e57c205fb4b91( self, #"tertiaryweapon" );
        
        if ( function_ae3907698ee6e6f1( var_dd4830c9142c8e9f ) )
        {
            return true;
        }
    }
    
    if ( function_28e60cf07393549d( #"backpackweapon" ) )
    {
        var_1827e45669a6c403 = function_4c1e57c205fb4b91( self, #"backpackweapon" );
        
        if ( function_ae3907698ee6e6f1( var_1827e45669a6c403 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x2c1cdb7c, Offset: 0x3ab2
// Size: 0x1f7
function private function_1b9949fdb11cd517()
{
    if ( !isdefined( self.keyring ) )
    {
        return;
    }
    
    instanceslot = function_6e525a83b773221( #"hash_9c96d56491d2453c" );
    
    if ( !isdefined( instanceslot ) || instanceslot.location == 0 )
    {
        return;
    }
    
    [ groupbundle, _ ] = common_inventory_groups::function_db5a1ed29a9116b2();
    maxkeys = common_inventory_groups::function_19a5a29f5cd0df45( groupbundle ) ?? 8;
    location = instanceslot.location;
    
    for ( i = 0; i < maxkeys ; i++ )
    {
        function_b86acd5b5496f84d( location, i );
    }
    
    sublocation = 0;
    
    foreach ( keydata in self.keyring )
    {
        if ( !isdefined( keydata.lootid ) )
        {
            continue;
        }
        
        itembundle = common_item::function_b202b16941992cca( keydata.lootid );
        
        if ( !itembundle.var_74fdf8cd1e01b989 )
        {
            continue;
        }
        
        function_faae73a378ff8c45( keydata.lootid, 13, #"hash_9c96d56491d2453c", undefined, undefined, undefined, sublocation );
        newinstance = function_4c1e57c205fb4b91( self, #"hash_9c96d56491d2453c", sublocation );
        bundlename = common_item::function_e044c3e813daec3a( itembundle );
        
        if ( isdefined( bundlename ) )
        {
            function_b17acc4a951e49f5( bundlename, newinstance );
        }
        
        self function_c17a2151cfca6224( newinstance.instanceid, keydata.quantity );
        sublocation++;
    }
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x8a8e0ca9, Offset: 0x3cb1
// Size: 0x467
function private function_b0ee9317bf6219()
{
    if ( utility::issharedfuncdefined( #"instanceInventory", #"hash_edd08039698295a5" ) )
    {
        utility::callsharedfunc( #"instanceInventory", #"hash_edd08039698295a5", self );
        return;
    }
    
    if ( !function_9003ead622d55c1c() )
    {
        return;
    }
    
    if ( !isdefined( self.var_e6495f88793f9119 ) )
    {
        assertmsg( "<dev string:x785>" );
        return;
    }
    
    var_f0177fdb6fe5ce4f = [];
    primaryweaponinstance = function_4c1e57c205fb4b91( self, #"primaryweapon" );
    
    if ( function_ae3907698ee6e6f1( primaryweaponinstance ) )
    {
        var_f0177fdb6fe5ce4f[ var_f0177fdb6fe5ce4f.size ] = primaryweaponinstance;
    }
    
    secondaryweaponinstance = function_4c1e57c205fb4b91( self, #"secondaryweapon" );
    
    if ( function_ae3907698ee6e6f1( secondaryweaponinstance ) )
    {
        var_f0177fdb6fe5ce4f[ var_f0177fdb6fe5ce4f.size ] = secondaryweaponinstance;
    }
    
    var_1827e45669a6c403 = function_4c1e57c205fb4b91( self, #"backpackweapon" );
    
    if ( function_ae3907698ee6e6f1( var_1827e45669a6c403 ) )
    {
        var_f0177fdb6fe5ce4f[ var_f0177fdb6fe5ce4f.size ] = var_1827e45669a6c403;
    }
    
    foreach ( var_d39e76292a80cbf0 in self.var_e6495f88793f9119 )
    {
        var_5d6e192cde2e5074 = undefined;
        
        foreach ( var_6c9b13167b43769b in var_f0177fdb6fe5ce4f )
        {
            var_85b1ae31949abce8 = function_9513862f69ec0498( 1, var_d39e76292a80cbf0, 0 );
            var_11d1e2ccd1d0520e = function_9513862f69ec0498( 1, var_6c9b13167b43769b, 0 );
            var_415e93408c0a9ba = function_9513862f69ec0498( 15, var_d39e76292a80cbf0, 1 );
            var_da1bf7543df43f1c = function_9513862f69ec0498( 15, var_6c9b13167b43769b, 1 );
            
            if ( var_85b1ae31949abce8 == var_11d1e2ccd1d0520e && isdefined( var_415e93408c0a9ba ) && isdefined( var_da1bf7543df43f1c ) && var_415e93408c0a9ba == var_da1bf7543df43f1c )
            {
                var_5d6e192cde2e5074 = var_6c9b13167b43769b;
                break;
            }
        }
        
        if ( !isdefined( var_5d6e192cde2e5074 ) )
        {
            insuredinstance = function_77826520a07b6812( var_d39e76292a80cbf0 );
            
            if ( !isdefined( insuredinstance.cooldownexpiration ) || insuredinstance.cooldownexpiration <= getsystemtime() )
            {
                newcooldown = getdvarint( @"scr_default_weapon_cooldown", 14400 );
                
                if ( getdvarint( @"hash_6dc2f0452c76707d", 1 ) )
                {
                    insuredslot = function_9513862f69ec0498( 15, var_d39e76292a80cbf0, 1 );
                    
                    if ( isdefined( insuredslot ) )
                    {
                        switch ( insuredslot )
                        {
                            case #"hash_31100fbc01bd387c":
                                newcooldown = getdvarint( @"hash_618c3ca8c4897d2c", 7200 );
                                break;
                            case #"hash_311012bc01bd3d35":
                                newcooldown = getdvarint( @"hash_618c3fa8c48983c5", 14400 );
                                break;
                            case #"hash_311011bc01bd3ba2":
                                newcooldown = getdvarint( @"hash_618c3ea8c4898192", 21600 );
                                break;
                        }
                    }
                }
                
                newcooldown = getsystemtime() + newcooldown;
                self function_86c4417b398dd00( insuredinstance.instanceid, int( newcooldown ) );
            }
            
            continue;
        }
        
        if ( var_5d6e192cde2e5074.kind != 14 )
        {
            self function_1fe0234f56138fe1( var_5d6e192cde2e5074.instanceid );
            function_7467cfa870b97b5a( var_5d6e192cde2e5074.lootid, 14, var_5d6e192cde2e5074.location, var_5d6e192cde2e5074.sublocation, var_5d6e192cde2e5074.var_a834790f492b07f8 );
            var_39e25c243a9df71e = self function_41f811caf4053d98( var_5d6e192cde2e5074.location, var_5d6e192cde2e5074.sublocation );
            
            if ( isdefined( var_5d6e192cde2e5074.metadata ) && function_ae3907698ee6e6f1( var_39e25c243a9df71e ) )
            {
                metadatacopy = function_dba82bdee30f1799( var_5d6e192cde2e5074.metadata );
                self function_c0d5d134ef5e068( var_39e25c243a9df71e.instanceid, 0, metadatacopy );
            }
            
            if ( isdefined( var_5d6e192cde2e5074.var_c11bbd62e8f23645 ) && function_ae3907698ee6e6f1( var_39e25c243a9df71e ) )
            {
                metadatacopy = function_dba82bdee30f1799( var_5d6e192cde2e5074.var_c11bbd62e8f23645 );
                self function_c0d5d134ef5e068( var_39e25c243a9df71e.instanceid, 1, metadatacopy );
            }
        }
    }
}

// Namespace common_instance_inventory
// Params 3
// Checksum 0x978221f3, Offset: 0x4120
// Size: 0xf9
function function_dfecd60c4938fd9( player, itembundle, quantity = 1 )
{
    if ( !itembundle.resources )
    {
        return;
    }
    
    foreach ( resource in itembundle.resources )
    {
        if ( resource.printtype )
        {
            resourceamount = resource.value * quantity;
            resourcebundle = getscriptbundle( resource.printtype );
            
            if ( isdefined( resourcebundle ) )
            {
                function_9176bef1ef34015a( player, resourcebundle, resourceamount );
            }
        }
    }
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0xf0ea1872, Offset: 0x4221
// Size: 0x15b
function private function_33120d622c8fa763( player )
{
    if ( !isdefined( player.var_f9027633b61e4fb7 ) || player.var_f9027633b61e4fb7.size == 0 )
    {
        return;
    }
    
    foreach ( ref, count in player.var_f9027633b61e4fb7 )
    {
        itembundle = player item_resource::function_f117580b04feee18( ref );
        
        foreach ( resource in itembundle.resources )
        {
            if ( resource.printtype )
            {
                resourcebundle = getscriptbundle( resource.printtype );
                
                if ( resourcebundle )
                {
                    function_9176bef1ef34015a( player, resourcebundle, count );
                }
            }
        }
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xf2edfd2d, Offset: 0x4384
// Size: 0x7b
function function_189efb9dddbaac9c()
{
    instance = function_4c1e57c205fb4b91( self, #"bossboard" );
    
    if ( !function_ae3907698ee6e6f1( instance ) || !instance.var_c11bbd62e8f23645[ 1 ] || !instance.var_c11bbd62e8f23645[ 1 ].value )
    {
        return;
    }
    
    function_295a263162af11ac( #"bossboard" );
    return int( function_9513862f69ec0498( 1, instance, 1 ) );
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xfc11f351, Offset: 0x4408
// Size: 0x45
function function_5972859e700c5d59()
{
    instance = function_4c1e57c205fb4b91( self, #"infil" );
    
    if ( function_ae3907698ee6e6f1( instance ) )
    {
        function_295a263162af11ac( #"infil" );
        return instance.lootid;
    }
}

// Namespace common_instance_inventory
// Params 4, eflags: 0x4
// Checksum 0x678d7f2e, Offset: 0x4455
// Size: 0x6a4
function private function_f40306de6384b50( player, struct, class, var_4d5575c6f9ec8a5b )
{
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( isdefined( player.changedarchetypeinfo ) )
    {
        struct.loadoutarchetype = player.changedarchetypeinfo.archetype;
    }
    else
    {
        struct.loadoutarchetype = "archetype_assault";
    }
    
    if ( player.var_c72cb0043263a756 )
    {
        return;
    }
    
    wildcard = player class::function_facf39de1a82731a();
    weaponinstance = function_4c1e57c205fb4b91( player, #"primaryweapon" );
    
    if ( function_69b794916cb34595( player, weaponinstance ) )
    {
        blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
        weaponstruct = player function_4da778f38e8b3044( weaponinstance, blueprintindex );
        struct.loadoutprimary = weaponstruct.weaponref;
        maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
        
        for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
        {
            struct.loadoutprimaryattachments[ attachmentindex ] = weaponstruct.attachmentrefs[ attachmentindex ];
            struct.loadoutprimaryattachmentids[ attachmentindex ] = weaponstruct.attachmentids[ attachmentindex ];
            tuningvalues = weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ];
            
            if ( isdefined( tuningvalues ) )
            {
                struct.var_57a15af46a205668[ struct.loadoutprimaryattachments[ attachmentindex ] ] = tuningvalues;
            }
        }
        
        struct.loadoutprimarycamo = weaponstruct.weaponcamo;
        struct.loadoutprimaryreticle = weaponstruct.weaponreticle;
        struct.loadoutprimarylootitemid = weaponstruct.lootitemid;
        struct.loadoutprimaryvariantid = weaponstruct.weaponvariant;
        struct.loadoutprimarycosmeticattachment = weaponstruct.weaponcosmetic;
        
        for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
        {
            struct.loadoutprimarystickers[ stickerindex ] = weaponstruct.weaponstickers[ stickerindex ];
        }
        
        struct.loadoutPrimaryBlueprintAttachmentIgnoreList = weaponstruct.blueprintattachmentignorelist;
        player.var_eddebed5872b3b52[ #"primary_0" ] = { #insecure:function_dba82bdee30f1799( weaponinstance.var_c11bbd62e8f23645 ), #secure:function_dba82bdee30f1799( weaponinstance.metadata ) };
    }
    
    weaponinstance = function_4c1e57c205fb4b91( player, #"secondaryweapon" );
    
    if ( function_69b794916cb34595( player, weaponinstance ) )
    {
        blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
        weaponstruct = player function_4da778f38e8b3044( weaponinstance, blueprintindex );
        struct.loadoutsecondary = weaponstruct.weaponref;
        maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
        
        for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
        {
            struct.loadoutsecondaryattachments[ attachmentindex ] = weaponstruct.attachmentrefs[ attachmentindex ];
            struct.loadoutsecondaryattachmentids[ attachmentindex ] = weaponstruct.attachmentids[ attachmentindex ];
            tuningvalues = weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ];
            
            if ( isdefined( tuningvalues ) )
            {
                struct.var_57a15af46a205668[ struct.loadoutprimaryattachments[ attachmentindex ] ] = tuningvalues;
            }
        }
        
        struct.loadoutsecondarycamo = weaponstruct.weaponcamo;
        struct.loadoutsecondaryreticle = weaponstruct.weaponreticle;
        struct.loadoutsecondarylootitemid = weaponstruct.lootitemid;
        struct.loadoutsecondaryvariantid = weaponstruct.weaponvariant;
        struct.loadoutsecondarycosmeticattachment = weaponstruct.weaponcosmetic;
        
        for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
        {
            struct.loadoutsecondarystickers[ stickerindex ] = weaponstruct.weaponstickers[ stickerindex ];
        }
        
        struct.loadoutSecondaryBlueprintAttachmentIgnoreList = weaponstruct.blueprintattachmentignorelist;
        player.var_eddebed5872b3b52[ #"primary_1" ] = { #insecure:function_dba82bdee30f1799( weaponinstance.var_c11bbd62e8f23645 ), #secure:function_dba82bdee30f1799( weaponinstance.metadata ) };
    }
    
    weaponinstance = function_4c1e57c205fb4b91( player, #"tertiaryweapon" );
    tertiaryslot = function_6e525a83b773221( #"tertiaryweapon" );
    
    if ( function_69b794916cb34595( player, weaponinstance ) && !tertiaryslot.commonitemequip )
    {
        blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
        weaponstruct = player function_4da778f38e8b3044( weaponinstance, blueprintindex );
        struct.loadouttertiary = weaponstruct.weaponref;
        maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
        
        for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
        {
            struct.loadoutTertiaryAttachments[ attachmentindex ] = weaponstruct.attachmentrefs[ attachmentindex ];
            struct.loadoutTertiaryAttachmentIDs[ attachmentindex ] = weaponstruct.attachmentids[ attachmentindex ];
            tuningvalues = weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ];
            
            if ( isdefined( tuningvalues ) )
            {
                struct.var_57a15af46a205668[ struct.loadoutprimaryattachments[ attachmentindex ] ] = tuningvalues;
            }
        }
        
        struct.loadouttertiarycamo = weaponstruct.weaponcamo;
        struct.loadouttertiaryreticle = weaponstruct.weaponreticle;
        struct.loadoutTertiaryLootItemID = weaponstruct.lootitemid;
        struct.loadouttertiaryvariantid = weaponstruct.weaponvariant;
        struct.loadoutTertiaryCosmeticAttachment = weaponstruct.weaponcosmetic;
        
        for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
        {
            struct.loadoutTertiaryStickers[ stickerindex ] = weaponstruct.weaponstickers[ stickerindex ];
        }
        
        struct.loadoutTertiaryBlueprintAttachmentIgnoreList = weaponstruct.blueprintattachmentignorelist;
        player.var_eddebed5872b3b52[ #"tertiary_0" ] = { #insecure:function_dba82bdee30f1799( weaponinstance.var_c11bbd62e8f23645 ), #secure:function_dba82bdee30f1799( weaponinstance.metadata ) };
    }
    
    function_4f399bf42d809c64( player, struct, 1 );
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0x557d0709, Offset: 0x4b01
// Size: 0x110, Type: bool
function function_69b794916cb34595( player, weaponinstance )
{
    if ( !function_ae3907698ee6e6f1( weaponinstance ) )
    {
        return false;
    }
    
    blueprintindex = function_4d465a88a4c974d3( weaponinstance.lootid );
    ismaptomapinfil = istrue( utility::callsharedfunc( #"instanceInventory", #"ismaptomapinfil" ) );
    
    if ( blueprintindex == 0 )
    {
        var_eb17b44f95ecb1e7 = common_item_database::function_db2360bc1c33f6f9( weaponinstance.lootid );
        
        if ( isdefined( var_eb17b44f95ecb1e7 ) )
        {
            if ( function_99a3c189718cdd9e( var_eb17b44f95ecb1e7 ) )
            {
                return false;
            }
            else
            {
                itembundle = getscriptbundle( var_eb17b44f95ecb1e7 );
                
                if ( isdefined( itembundle ) )
                {
                    if ( !ismaptomapinfil && !itembundle.var_74fdf8cd1e01b989 )
                    {
                        assertmsg( "<dev string:xb3>" + player.name + "<dev string:x42c>" + common_item::function_d43f27b1302f1c44( weaponinstance.lootid ) + "<dev string:x44f>" + weaponinstance.instanceid + "<dev string:x496>" );
                        return false;
                    }
                }
            }
        }
    }
    
    return true;
}

// Namespace common_instance_inventory
// Params 4, eflags: 0x4
// Checksum 0x5d2599e5, Offset: 0x4c1a
// Size: 0x27
function private function_356b34bdd1523108( player, struct, prefix, weaponslot )
{
    
}

// Namespace common_instance_inventory
// Params 2, eflags: 0x4
// Checksum 0x31d2512, Offset: 0x4c49
// Size: 0x20
function private function_834357b6721a42ff( player, struct )
{
    function_4f399bf42d809c64( player, struct, 0 );
}

// Namespace common_instance_inventory
// Params 3, eflags: 0x4
// Checksum 0x6745f9a1, Offset: 0x4c71
// Size: 0x342
function private function_4f399bf42d809c64( player, struct, var_9bd8db90f8939b0c )
{
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( self.var_c72cb0043263a756 )
    {
        return;
    }
    
    instanceslot = function_6e525a83b773221( #"lethal" );
    iteminstance = function_4c1e57c205fb4b91( player, #"lethal" );
    
    if ( function_ae3907698ee6e6f1( iteminstance ) && ( !var_9bd8db90f8939b0c || instanceslot.commonitemequip ) )
    {
        lootinfo = getlootiteminfofromid( iteminstance.lootid );
        
        if ( isdefined( lootinfo ) && isdefined( lootinfo.itemref ) )
        {
            struct.loadoutequipmentprimary = lootinfo.itemref;
            struct.var_a1191d5606e653f0 = function_4d465a88a4c974d3( iteminstance.lootid );
            
            if ( !isdefined( struct.var_a1191d5606e653f0 ) )
            {
                struct.var_a1191d5606e653f0 = 0;
            }
            
            if ( struct.var_a1191d5606e653f0 > 0 )
            {
                if ( !isdefined( player.var_8cf9648fae56099c ) )
                {
                    player.var_8cf9648fae56099c = [];
                }
                
                if ( !isdefined( player.var_92c60993d80d57b5 ) )
                {
                    player.var_92c60993d80d57b5 = [];
                }
                
                player.var_8cf9648fae56099c[ lootinfo.itemref ] = struct.var_a1191d5606e653f0;
                player.var_92c60993d80d57b5[ lootinfo.itemref ] = iteminstance.lootid;
            }
        }
    }
    
    iteminstance = function_4c1e57c205fb4b91( player, #"tactical" );
    
    if ( function_ae3907698ee6e6f1( iteminstance ) && ( !var_9bd8db90f8939b0c || instanceslot.commonitemequip ) )
    {
        lootinfo = getlootiteminfofromid( iteminstance.lootid );
        
        if ( isdefined( lootinfo ) && isdefined( lootinfo.itemref ) )
        {
            struct.loadoutequipmentsecondary = lootinfo.itemref;
            struct.var_9481e959139fe88 = function_4d465a88a4c974d3( iteminstance.lootid );
            
            if ( !isdefined( struct.var_9481e959139fe88 ) )
            {
                struct.var_9481e959139fe88 = 0;
            }
            
            if ( struct.var_9481e959139fe88 > 0 )
            {
                if ( !isdefined( player.var_8cf9648fae56099c ) )
                {
                    player.var_8cf9648fae56099c = [];
                }
                
                if ( !isdefined( player.var_92c60993d80d57b5 ) )
                {
                    player.var_92c60993d80d57b5 = [];
                }
                
                player.var_8cf9648fae56099c[ lootinfo.itemref ] = struct.var_9481e959139fe88;
                player.var_92c60993d80d57b5[ lootinfo.itemref ] = iteminstance.lootid;
            }
        }
    }
    
    iteminstance = function_4c1e57c205fb4b91( player, #"fieldupgrade" );
    
    if ( function_ae3907698ee6e6f1( iteminstance ) && ( !var_9bd8db90f8939b0c || instanceslot.commonitemequip ) )
    {
        lootinfo = getlootiteminfofromid( iteminstance.lootid );
        
        if ( isdefined( lootinfo ) && isdefined( lootinfo.itemref ) )
        {
            struct.loadoutfieldupgrade1 = lootinfo.itemref;
        }
    }
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0x5dee37da, Offset: 0x4fbb
// Size: 0x938
function function_4da778f38e8b3044( instance, blueprintindex )
{
    struct = spawnstruct();
    struct.attachmentrefs = [];
    struct.attachmentids = [];
    struct.var_b3ca7b468de89ea3 = [];
    struct.weaponcamo = "camo_none";
    struct.weaponreticle = "none";
    struct.weaponcosmetic = "charm_none";
    struct.var_c325d12dda0a389b = int( function_9513862f69ec0498( 8, instance, 1 ) ?? 0 );
    struct.weaponstickers = [];
    struct.attachmentslots = function_9513862f69ec0498( 9, instance, 0 );
    lootinfo = getlootiteminfofromid( instance.lootid );
    weaponassetname = function_357526af7a89075f( instance.lootid );
    assert( weaponassetname, "<dev string:x7f8>" + instance.lootid );
    
    if ( isdefined( blueprintindex ) && isdefined( lootinfo.itemref ) )
    {
        struct.lootitemid = instance.lootid;
        struct.weaponref = weapon::getweaponrootname( weaponassetname );
        struct.weaponvariant = blueprintindex;
    }
    else
    {
        itembundle = common_item::function_b202b16941992cca( instance.lootid, [ #"lootitemtype", #"ref" ] );
        
        if ( isdefined( itembundle ) )
        {
            loottype = common_item::function_16e8c106491eeaca( itembundle );
            
            if ( loottype == "weapon" )
            {
                struct.lootitemid = instance.lootid;
                struct.weaponref = itembundle.ref;
                struct.weaponvariant = function_4d465a88a4c974d3( instance.lootid );
            }
            else
            {
                assertmsg( "<dev string:x81d>" + "<dev string:x892>" + instance.lootid + "<dev string:x8aa>" + loottype + "<dev string:x496>" );
            }
        }
    }
    
    if ( !isdefined( struct.lootitemid ) || struct.lootitemid == 0 )
    {
        struct.lootitemid = 0;
        struct.weaponref = level.defaultfist.basename;
        struct.weaponvariant = 0;
        return struct;
    }
    
    numattachments = 0;
    
    if ( isdefined( instance.var_a834790f492b07f8 ) )
    {
        var_ec96f3fca615049 = int( function_9513862f69ec0498( 13, instance, 1 ) ?? 0 );
        defaultattachments = getweapondefaultattachments( weaponassetname );
        var_ae71f5b7a842cc31 = 0;
        
        while ( var_ae71f5b7a842cc31 < 22 )
        {
            childlootid = instance.var_a834790f492b07f8[ var_ae71f5b7a842cc31 ];
            
            if ( childlootid == 0 )
            {
            }
            else
            {
                var_ed0e14e14d25ff36 = loot::function_52cf8374c44a4ff5( childlootid );
                
                if ( !isdefined( var_ed0e14e14d25ff36 ) )
                {
                }
                else
                {
                    var_f0c55b0f7e5ef927 = loot::function_f54ecb89dfab8e8c( childlootid );
                    
                    if ( !isdefined( var_f0c55b0f7e5ef927 ) )
                    {
                        assertmsg( "<dev string:x8b9>" + var_ed0e14e14d25ff36 + "<dev string:x8f1>" + childlootid + "<dev string:x8fb>" + instance.instanceid + "<dev string:x496>" );
                    }
                    else
                    {
                        switch ( var_ed0e14e14d25ff36 )
                        {
                            case #"hash_4a01666eb6c388c8":
                                attachmentref = loot::function_5fea6a6dee392b8( childlootid, weaponassetname );
                                
                                if ( !isdefined( attachmentref ) )
                                {
                                    assertmsg( "<dev string:x931>" + childlootid + "<dev string:x97c>" + weaponassetname + "<dev string:x8fb>" + instance.instanceid + "<dev string:x496>" );
                                    break;
                                }
                                
                                var_4ac84104531b60f7 = weapon::function_e0801e95ac4c4925( attachmentref, [ #"lootid" ] );
                                
                                if ( !isdefined( var_4ac84104531b60f7 ) )
                                {
                                    assertmsg( "<dev string:x98e>" + attachmentref + "<dev string:x8fb>" + instance.instanceid + "<dev string:x496>" );
                                    break;
                                }
                                
                                attachmentslot = getattachmentslot( weaponassetname, attachmentref );
                                
                                if ( attachmentslot == "" )
                                {
                                    assertmsg( "<dev string:x9df>" + attachmentref + "<dev string:x97c>" + weaponassetname + "<dev string:x8fb>" + instance.instanceid + "<dev string:x496>" );
                                    break;
                                }
                                
                                if ( arraycontains( defaultattachments, attachmentref ) )
                                {
                                    break;
                                }
                                
                                if ( attachmentslot != "conversionkit" && [[ utility::getsharedfunc( #"weapons", #"hash_35d31d8d23e44a0" ) ]]( struct.weaponref, attachmentref ) )
                                {
                                    numattachments++;
                                }
                                
                                if ( numattachments > weapon::getmaxprimaryattachments( class::function_facf39de1a82731a() ) )
                                {
                                    assertmsg( "<dev string:xa1d>" + instance.instanceid + "<dev string:xa5e>" + struct.attachmentrefs.size + "<dev string:xa6b>" );
                                    break;
                                }
                                
                                struct.attachmentrefs[ struct.attachmentrefs.size ] = attachmentref;
                                struct.attachmentids[ struct.attachmentids.size ] = function_5a8beea9d65ebe8f( weaponassetname, attachmentref, childlootid );
                                break;
                            case #"hash_a12afa2995fb2059":
                                if ( struct.weaponcamo != "camo_none" )
                                {
                                    assertmsg( "<dev string:xa1d>" + instance.instanceid + "<dev string:xaa8>" );
                                    break;
                                }
                                
                                bundledata = getscriptbundlefieldvalues( hashcat( %"hash_1345cc24140e89b8", var_f0c55b0f7e5ef927 ), [ #"ref", #"weaponref" ] );
                                
                                if ( !( isdefined( bundledata ) && isdefined( bundledata.ref ) ) )
                                {
                                    assertmsg( "<dev string:xac8>" + childlootid + "<dev string:x8fb>" + instance.instanceid + "<dev string:x496>" );
                                    break;
                                }
                                
                                struct.weaponcamo = bundledata.ref;
                                
                                if ( bundledata.weaponref )
                                {
                                    if ( !isdefined( level.var_d2196df9bcc1f0ce ) )
                                    {
                                        level.var_d2196df9bcc1f0ce = [];
                                    }
                                    
                                    if ( !isdefined( level.var_d2196df9bcc1f0ce[ bundledata.ref ] ) )
                                    {
                                        level.var_d2196df9bcc1f0ce[ bundledata.ref ] = [];
                                    }
                                    
                                    level.var_d2196df9bcc1f0ce[ bundledata.ref ][ bundledata.weaponref ] = childlootid;
                                }
                                
                                break;
                            case #"hash_3945637d52ccf689":
                            case #"hash_aca593b48f7018c2":
                                if ( struct.weaponcosmetic != "charm_none" && struct.weaponcosmetic != "gunscreen_none" )
                                {
                                    assertmsg( "<dev string:xa1d>" + instance.instanceid + "<dev string:xb0d>" );
                                    break;
                                }
                                
                                struct.weaponcosmetic = var_f0c55b0f7e5ef927;
                                break;
                            case #"hash_4b155f83e05788f7":
                                if ( struct.weaponreticle != "none" )
                                {
                                    assertmsg( "<dev string:xa1d>" + instance.instanceid + "<dev string:xb31>" );
                                }
                                
                                struct.weaponreticle = var_f0c55b0f7e5ef927;
                                break;
                            case #"hash_249ba0b9f7d065fc":
                                if ( struct.weaponstickers.size >= 5 )
                                {
                                    assertmsg( "<dev string:xa1d>" + instance.instanceid + "<dev string:xb54>" );
                                    break;
                                }
                                
                                while ( !( var_ec96f3fca615049 & 1 << struct.weaponstickers.size ) && struct.weaponstickers.size < 5 )
                                {
                                    struct.weaponstickers[ struct.weaponstickers.size ] = "none";
                                }
                                
                                struct.weaponstickers[ struct.weaponstickers.size ] = var_f0c55b0f7e5ef927;
                                break;
                            default:
                                assertmsg( "<dev string:xb81>" + var_ed0e14e14d25ff36 + "<dev string:xbbb>" + instance.instanceid + "<dev string:x496>" );
                                break;
                        }
                    }
                }
            }
            
            var_ae71f5b7a842cc31 += 1;
        }
    }
    
    if ( struct.weaponvariant > 0 )
    {
        struct.blueprintattachmentignorelist = weapon::function_2374da6f1b4fad4e( weaponassetname, struct.weaponvariant );
        struct.blueprintattachmentignorelist = arrayremove( struct.blueprintattachmentignorelist, struct.attachmentrefs );
    }
    
    if ( isdefined( instance.var_c11bbd62e8f23645 ) )
    {
        for ( i = 2; i <= 6 ; i++ )
        {
            value = function_9513862f69ec0498( i, instance, 1 );
            
            if ( isdefined( value ) && int( value ) != 0 )
            {
                value = int( value );
                valuex = value & 255;
                valuey = value >> 8;
                struct.var_b3ca7b468de89ea3[ i - 2 ] = [ function_4bd7309db3ebaf5c( valuex ), function_4bd7309db3ebaf5c( valuey ) ];
            }
        }
    }
    
    return struct;
}

// Namespace common_instance_inventory
// Params 3, eflags: 0x4
// Checksum 0x336568d6, Offset: 0x58fc
// Size: 0xb8
function private function_5a8beea9d65ebe8f( weaponassetname, attachment, variantlootid )
{
    blueprints = function_d3cb2c9aad7e9c4( weaponassetname, attachment );
    
    foreach ( variantindex, attachmentdata in blueprints )
    {
        attachmentlootid = attachmentdata.lootid;
        
        if ( variantlootid == attachmentlootid )
        {
            return variantindex;
        }
    }
    
    return 0;
}

// Namespace common_instance_inventory
// Params 3, eflags: 0x4
// Checksum 0x77ca9894, Offset: 0x59bd
// Size: 0xab
function private function_1136b3843dc9e18d( weaponassetname, attachment, variantid )
{
    blueprints = function_d3cb2c9aad7e9c4( weaponassetname, attachment );
    
    foreach ( variantindex, attachmentdata in blueprints )
    {
        if ( variantindex == variantid )
        {
            return attachmentdata.lootid;
        }
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x4e8aa8cf, Offset: 0x5a71
// Size: 0x42
function operatorsenabled()
{
    if ( !isdefined( level.var_c45078ea3ac015d5 ) )
    {
        gametypescriptbundle = getgametypescriptbundle();
        level.var_c45078ea3ac015d5 = gametypescriptbundle.var_43d9ad0c052515ea ?? 1;
    }
    
    return level.var_c45078ea3ac015d5;
}

// Namespace common_instance_inventory
// Params 2, eflags: 0x40 variadic
// Checksum 0xd1e682e, Offset: 0x5abc
// Size: 0x37
function function_71d5424a56326d82( ... )
{
    operatorlootid = getactiveoperatorlootid();
    
    if ( operatorlootid != 0 )
    {
        return loot::function_f54ecb89dfab8e8c( operatorlootid );
    }
}

// Namespace common_instance_inventory
// Params 2, eflags: 0x40 variadic
// Checksum 0xa677887e, Offset: 0x5afb
// Size: 0x37
function function_4cf88b6754916a38( ... )
{
    operatorskinlootid = getactiveoperatorskinlootid();
    
    if ( operatorskinlootid != 0 )
    {
        return loot::function_f54ecb89dfab8e8c( operatorskinlootid );
    }
}

// Namespace common_instance_inventory
// Params 2, eflags: 0x40 variadic
// Checksum 0x4a9167c5, Offset: 0x5b3a
// Size: 0x49
function getactiveoperatorlootid( ... )
{
    operatorinstance = function_4c1e57c205fb4b91( self, #"operator" );
    
    if ( function_ae3907698ee6e6f1( operatorinstance ) )
    {
        return operatorinstance.lootid;
    }
    
    return 0;
}

// Namespace common_instance_inventory
// Params 2, eflags: 0x40 variadic
// Checksum 0xf6dc5cca, Offset: 0x5b8c
// Size: 0x5c
function getactiveoperatorskinlootid( ... )
{
    operatorinstance = function_4c1e57c205fb4b91( self, #"operator" );
    
    if ( function_ae3907698ee6e6f1( operatorinstance ) )
    {
        if ( isdefined( operatorinstance.var_a834790f492b07f8[ 0 ] ) )
        {
            return operatorinstance.var_a834790f492b07f8[ 0 ];
        }
    }
    
    return 0;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xb7549948, Offset: 0x5bf1
// Size: 0x55
function getactiveoperatorexecutionlootid( player )
{
    operatorinstance = function_4c1e57c205fb4b91( self, #"operator" );
    
    if ( function_ae3907698ee6e6f1( operatorinstance ) )
    {
        if ( isdefined( operatorinstance.var_a834790f492b07f8[ 1 ] ) )
        {
            return operatorinstance.var_a834790f492b07f8[ 1 ];
        }
    }
    
    return 0;
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x4e0d61c5, Offset: 0x5c4f
// Size: 0x48
function function_8d761e58e114e5c4()
{
    operatorinstance = function_4c1e57c205fb4b91( self, #"operator" );
    
    if ( function_ae3907698ee6e6f1( operatorinstance ) )
    {
        xpbucket = function_9513862f69ec0498( 2, operatorinstance, 1 );
        
        if ( xpbucket )
        {
            return xpbucket;
        }
    }
    
    return 0;
}

// Namespace common_instance_inventory
// Params 4
// Checksum 0xfd900d00, Offset: 0x5ca0
// Size: 0x123
function function_9513862f69ec0498( key, instance, var_75ff6bcc38c69d41, var_fdb039ad3e8ca8ba )
{
    if ( !isdefined( key ) || !isdefined( instance ) )
    {
        return;
    }
    
    metadata = instance.metadata;
    
    if ( var_75ff6bcc38c69d41 )
    {
        metadata = instance.var_c11bbd62e8f23645;
    }
    
    if ( !isdefined( metadata ) )
    {
        return;
    }
    
    foreach ( data in metadata )
    {
        if ( key == data.key )
        {
            if ( var_fdb039ad3e8ca8ba )
            {
                return [ data.value, data.valuelow, data.valuehigh ];
            }
            
            return data.value;
        }
    }
}

// Namespace common_instance_inventory
// Params 4
// Checksum 0xcc49ae9a, Offset: 0x5dcc
// Size: 0x6d
function function_1f613da4ed6f2986( key, quantity, instance, var_75ff6bcc38c69d41 )
{
    oldvalue = function_9513862f69ec0498( key, instance, var_75ff6bcc38c69d41, 0 );
    
    if ( !isdefined( oldvalue ) )
    {
        oldvalue = 0;
    }
    else
    {
        oldvalue = int( oldvalue );
    }
    
    function_a568f4d2f7413a60( [ key ], [ oldvalue + quantity ], instance, var_75ff6bcc38c69d41 );
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0xe83a920b, Offset: 0x5e41
// Size: 0x4f
function function_b17acc4a951e49f5( itemspawnentry, instance )
{
    stringindex = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", itemspawnentry );
    
    if ( isdefined( stringindex ) )
    {
        function_a568f4d2f7413a60( [ 14 ], [ stringindex ], instance, 1 );
    }
}

// Namespace common_instance_inventory
// Params 4
// Checksum 0xd7f90f30, Offset: 0x5e98
// Size: 0x2e2
function function_a568f4d2f7413a60( keys, values, instance, var_75ff6bcc38c69d41 )
{
    if ( !( isdefined( keys ) && isdefined( values ) && isdefined( instance ) ) )
    {
        /#
            assert( isdefined( keys ), "<dev string:xbf3>" );
            assert( isdefined( values ), "<dev string:xc51>" );
            assert( isdefined( instance ), "<dev string:xcb1>" );
        #/
        
        return;
    }
    
    if ( !isarray( keys ) )
    {
        keys = [ keys ];
    }
    
    if ( !isarray( values ) )
    {
        values = [ values ];
    }
    
    assert( keys.size == values.size, "<dev string:xd0d>" );
    oldmetadata = instance.metadata;
    metadatatype = 0;
    var_6a8192f6dc846d84 = 0;
    
    if ( var_75ff6bcc38c69d41 )
    {
        oldmetadata = instance.var_c11bbd62e8f23645;
        metadatatype = 1;
        var_6a8192f6dc846d84 = 0;
    }
    
    newmetadata = [];
    
    foreach ( data in oldmetadata )
    {
        if ( data.key == var_6a8192f6dc846d84 )
        {
            continue;
        }
        
        var_ee2a8abe9f45ac18 = newmetadata.size;
        newmetadata[ var_ee2a8abe9f45ac18 ] = [];
        newmetadata[ var_ee2a8abe9f45ac18 ][ 0 ] = data.key;
        newmetadata[ var_ee2a8abe9f45ac18 ][ 1 ] = int( data.value );
    }
    
    foreach ( keyindex, key in keys )
    {
        overriden = 0;
        
        foreach ( index, kvp in newmetadata )
        {
            if ( key == kvp[ 0 ] )
            {
                newmetadata[ index ][ 1 ] = values[ keyindex ];
                overriden = 1;
                break;
            }
        }
        
        if ( !overriden )
        {
            var_ee2a8abe9f45ac18 = newmetadata.size;
            newmetadata[ var_ee2a8abe9f45ac18 ] = [];
            newmetadata[ var_ee2a8abe9f45ac18 ][ 0 ] = key;
            newmetadata[ var_ee2a8abe9f45ac18 ][ 1 ] = values[ keyindex ];
        }
    }
    
    self function_c0d5d134ef5e068( instance.instanceid, metadatatype, newmetadata );
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xc074a169, Offset: 0x6182
// Size: 0xbe
function function_dba82bdee30f1799( instancemetadata )
{
    var_92b09215dc7116db = [];
    
    foreach ( data in instancemetadata )
    {
        offset = var_92b09215dc7116db.size;
        var_92b09215dc7116db[ offset ] = [];
        var_92b09215dc7116db[ offset ][ 0 ] = data.key;
        var_92b09215dc7116db[ offset ][ 1 ] = int( data.value );
    }
    
    return var_92b09215dc7116db;
}

// Namespace common_instance_inventory
// Params 3
// Checksum 0xdbc6e4af, Offset: 0x6249
// Size: 0xa6
function function_5b445333c898cc36( kind, slotref, weaponobj )
{
    instanceslot = function_6e525a83b773221( slotref );
    
    if ( !isdefined( instanceslot ) || instanceslot.location == 0 )
    {
        return;
    }
    
    location = instanceslot.location;
    sublocation = instanceslot.sublocation;
    lootid = weapon::getweaponlootid( weaponobj );
    subcomponents = function_1e555380baacc77f( weaponobj );
    self function_c178641b0ba5bf6f( lootid, kind, location, sublocation, subcomponents );
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0xd374fd91, Offset: 0x62f7
// Size: 0x27a
function private function_db5d35a47ac2e15c( params )
{
    utility::ent_flag_set( "dropped_item" );
    
    if ( isdefined( params.item ) && isdefined( params.item.weaponobj ) )
    {
        weaponobj = item_weapon::function_e7484276ad85f220( #"primary_0" );
        
        if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
        {
            if ( isdefined( self.var_eddebed5872b3b52[ #"primary_0" ] ) )
            {
                params.item.var_eddebed5872b3b52 = self.var_eddebed5872b3b52[ #"primary_0" ];
                self.var_eddebed5872b3b52[ #"primary_0" ] = undefined;
            }
            
            return;
        }
        
        weaponobj = item_weapon::function_e7484276ad85f220( #"primary_1" );
        
        if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
        {
            if ( isdefined( self.var_eddebed5872b3b52[ #"primary_1" ] ) )
            {
                params.item.var_eddebed5872b3b52 = self.var_eddebed5872b3b52[ #"primary_1" ];
                self.var_eddebed5872b3b52[ #"primary_1" ] = undefined;
            }
            
            return;
        }
        
        weaponobj = item_weapon::function_e7484276ad85f220( #"tertiary_0" );
        
        if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
        {
            if ( isdefined( self.var_eddebed5872b3b52[ #"tertiary_0" ] ) )
            {
                params.item.var_eddebed5872b3b52 = self.var_eddebed5872b3b52[ #"tertiary_0" ];
                self.var_eddebed5872b3b52[ #"tertiary_0" ] = undefined;
            }
            
            return;
        }
        
        weaponobj = item_weapon::function_e7484276ad85f220( #"backpack_0" );
        
        if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
        {
            if ( isdefined( self.var_eddebed5872b3b52[ #"backpack_0" ] ) )
            {
                params.item.var_eddebed5872b3b52 = self.var_eddebed5872b3b52[ #"backpack_0" ];
                self.var_eddebed5872b3b52[ #"backpack_0" ] = undefined;
            }
            
            return;
        }
    }
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0xe8cd8e0b, Offset: 0x6579
// Size: 0x1d7
function private function_b3b00a69365acc69( params )
{
    if ( isdefined( params.item ) && isdefined( params.item.var_eddebed5872b3b52 ) )
    {
        if ( params.tobackpack )
        {
            weaponobj = item_weapon::function_e7484276ad85f220( #"backpack_0" );
            
            if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
            {
                self.var_eddebed5872b3b52[ #"backpack_0" ] = params.item.var_eddebed5872b3b52;
                return;
            }
            
            return;
        }
        
        weaponobj = item_weapon::function_e7484276ad85f220( #"primary_0" );
        
        if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
        {
            self.var_eddebed5872b3b52[ #"primary_0" ] = params.item.var_eddebed5872b3b52;
            return;
        }
        
        weaponobj = item_weapon::function_e7484276ad85f220( #"primary_1" );
        
        if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
        {
            self.var_eddebed5872b3b52[ #"primary_1" ] = params.item.var_eddebed5872b3b52;
            return;
        }
        
        weaponobj = item_weapon::function_e7484276ad85f220( #"tertiary_0" );
        
        if ( isdefined( weaponobj ) && issameweapon( weaponobj, params.item.weaponobj, 1 ) )
        {
            self.var_eddebed5872b3b52[ #"tertiary_0" ] = params.item.var_eddebed5872b3b52;
            return;
        }
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x6041792b, Offset: 0x6758
// Size: 0x88
function function_3170decee5857e88()
{
    if ( utility::issharedfuncdefined( #"instanceInventory", #"wipeitems" ) )
    {
        utility::callsharedfunc( #"instanceInventory", #"wipeitems", self );
        return;
    }
    
    var_ada4fa53db68ba89 = getdvarint( @"hash_5c869b8df5b17357", 0 );
    
    if ( var_ada4fa53db68ba89 > 0 && !utility::ent_flag( "dropped_item" ) )
    {
        if ( gettime() <= utility::function_4b74c15943231980( var_ada4fa53db68ba89 ) )
        {
            return;
        }
    }
    
    function_c6d8b10d084c2004();
    function_9e6c1e3a398e502d();
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xbd92b3b2, Offset: 0x67e8
// Size: 0xf7
function function_c6d8b10d084c2004( wipeeverything )
{
    foreach ( slot in level.var_dbfa02b2281d0b30 )
    {
        if ( slot.location == 0 || !wipeeverything && !slot.wipeondeath )
        {
            continue;
        }
        
        iteminstance = self function_41f811caf4053d98( slot.location, slot.sublocation );
        
        if ( !function_ae3907698ee6e6f1( iteminstance ) )
        {
            continue;
        }
        
        function_b86acd5b5496f84d( slot.location, slot.sublocation );
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x697199f9, Offset: 0x68e7
// Size: 0x33
function function_9e6c1e3a398e502d()
{
    for ( backpackindex = 0; backpackindex < common_inventory::function_7d8024a0beed38ae() ; backpackindex++ )
    {
        function_295a263162af11ac( #"backpackcontents", backpackindex );
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xeda985e2, Offset: 0x6922
// Size: 0x22
function function_37fdf19667fcb5f6()
{
    function_295a263162af11ac( #"scratchprimary" );
    function_295a263162af11ac( #"scratchsecondary" );
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0xf2e5374f, Offset: 0x694c
// Size: 0x8e
function function_295a263162af11ac( slotref, var_16e703d46e75b118 = 0 )
{
    instanceslot = function_6e525a83b773221( slotref );
    
    if ( !isdefined( instanceslot ) || instanceslot.location == 0 )
    {
        return;
    }
    
    instance = self function_41f811caf4053d98( instanceslot.location, instanceslot.sublocation + var_16e703d46e75b118 );
    
    if ( function_ae3907698ee6e6f1( instance ) )
    {
        self function_1fe0234f56138fe1( instance.instanceid );
    }
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0xf4e9bfee, Offset: 0x69e2
// Size: 0x45
function function_b86acd5b5496f84d( location, sublocation )
{
    instance = self function_41f811caf4053d98( location, sublocation );
    
    if ( function_ae3907698ee6e6f1( instance ) )
    {
        self function_1fe0234f56138fe1( instance.instanceid );
    }
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x590ea3ea, Offset: 0x6a2f
// Size: 0x7a
function function_daebd5f98ef84efd( weaponslot )
{
    switch ( weaponslot )
    {
        case 1:
            return #"secondaryweapon";
        case 2:
            return #"tertiaryweapon";
        case 3:
            return #"backpackweapon";
        case 0:
        default:
            return #"primaryweapon";
    }
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xdd30d731, Offset: 0x6ab1
// Size: 0x34
function function_1e5fd659146e4d80( weaponslot )
{
    if ( !isenabled() )
    {
        return;
    }
    
    instanceslot = function_daebd5f98ef84efd( weaponslot );
    function_295a263162af11ac( instanceslot );
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xa41e67bb, Offset: 0x6aed
// Size: 0x34
function function_843e185e3cd37eb1( weaponslot )
{
    if ( !isenabled() )
    {
        return;
    }
    
    instanceslot = function_daebd5f98ef84efd( weaponslot );
    return function_4c1e57c205fb4b91( self, instanceslot );
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xda1c8b62, Offset: 0x6b2a
// Size: 0x2e
function private function_e19d6e094a0f9a89()
{
    if ( !isdefined( level.var_10aa664933a3ead0 ) )
    {
        level.var_10aa664933a3ead0 = getdvarint( @"hash_3a0b46b826670c2b", 0 );
    }
    
    return level.var_10aa664933a3ead0;
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0x239ebf00, Offset: 0x6b61
// Size: 0x27
function private getupgradecount( sublocation )
{
    if ( function_e19d6e094a0f9a89() )
    {
        return 1;
    }
    
    return self function_d2d396f77637ea86( sublocation ) ?? 0;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x2b60d806, Offset: 0x6b90
// Size: 0x16, Type: bool
function function_902ad22eabe0eeeb( sublocation )
{
    return getupgradecount( sublocation ) > 0;
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0x142dc17e, Offset: 0x6baf
// Size: 0x3c, Type: bool
function function_9605bf8a150ed652( player, slotref )
{
    instanceslot = function_6e525a83b773221( slotref );
    return player function_902ad22eabe0eeeb( instanceslot.sublocation );
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x3f79b7eb, Offset: 0x6bf4
// Size: 0x32
function private function_558bd431b283bbab()
{
    if ( !isdefined( level.var_4398e1e72f9e4002 ) )
    {
        level.var_4398e1e72f9e4002 = getdvarfloat( @"hash_4d31327236448d75", 0.05 );
    }
    
    return level.var_4398e1e72f9e4002;
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x500ad103, Offset: 0x6c2f
// Size: 0x2b
function function_e8c80d2fa9b2512e()
{
    if ( !isenabled() )
    {
        return 0;
    }
    
    upgradecount = getupgradecount( 14 );
    return upgradecount * function_558bd431b283bbab();
}

// Namespace common_instance_inventory
// Params 7
// Checksum 0x1064b6bc, Offset: 0x6c63
// Size: 0x9e
function function_faae73a378ff8c45( lootid, kind, slotref, components, metadata, var_c11bbd62e8f23645, var_16e703d46e75b118 = 0 )
{
    instanceslot = function_6e525a83b773221( slotref );
    
    if ( !isdefined( instanceslot ) || instanceslot.location == 0 )
    {
        return;
    }
    
    function_7467cfa870b97b5a( lootid, kind, instanceslot.location, instanceslot.sublocation + var_16e703d46e75b118, components, metadata, var_c11bbd62e8f23645 );
}

// Namespace common_instance_inventory
// Params 7
// Checksum 0xc1ad19a0, Offset: 0x6d09
// Size: 0x6a
function function_7467cfa870b97b5a( lootid, kind, location, sublocation, components = [], metadata = [], var_c11bbd62e8f23645 = [] )
{
    self function_c178641b0ba5bf6f( lootid, kind, location, sublocation, components, metadata, var_c11bbd62e8f23645 );
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0x99f1db77, Offset: 0x6d7b
// Size: 0x1b
function function_7529ec37c096b680()
{
    return { #lootid:0, #instanceid:"0" };
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x31db801c, Offset: 0x6d9f
// Size: 0x35, Type: bool
function function_ae3907698ee6e6f1( instance )
{
    return isdefined( instance ) && instance.instanceid != "0" && instance.lootid != 0;
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0x5d6e2811, Offset: 0x6ddd
// Size: 0xec
function private function_77826520a07b6812( iteminstance )
{
    if ( isdefined( iteminstance ) && isdefined( iteminstance.var_c11bbd62e8f23645 ) )
    {
        if ( iteminstance.kind == 17 )
        {
            assertmsg( "<dev string:xd8b>" );
            return function_7529ec37c096b680();
        }
        
        foreach ( metadata in iteminstance.var_c11bbd62e8f23645 )
        {
            if ( metadata.key == 15 )
            {
                return self function_41f811caf4053d98( 5, int( metadata.value ) - 1 );
            }
        }
    }
    
    return function_7529ec37c096b680();
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0x34ff1727, Offset: 0x6ed2
// Size: 0xe9
function private function_bc8e9ab9a89df0bf( iteminstance )
{
    if ( isdefined( iteminstance ) && isdefined( iteminstance.var_c11bbd62e8f23645 ) )
    {
        if ( iteminstance.kind != 17 )
        {
            assertmsg( "<dev string:xe09>" );
            return function_7529ec37c096b680();
        }
        
        foreach ( metadata in iteminstance.var_c11bbd62e8f23645 )
        {
            if ( metadata.key == 15 )
            {
                return self function_41f811caf4053d98( 6, int( metadata.value ) - 1 );
            }
        }
    }
    
    return function_7529ec37c096b680();
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xcea3a230, Offset: 0x6fc4
// Size: 0x2a
function function_2874be8df9b65535( iteminstance )
{
    if ( !function_ae3907698ee6e6f1( iteminstance ) )
    {
        return;
    }
    
    return common_item::function_b202b16941992cca( iteminstance.lootid );
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x5054202, Offset: 0x6ff7
// Size: 0x157
function function_b258e1b57fbb92f3( slotname )
{
    if ( !isdefined( self.var_eddebed5872b3b52 ) )
    {
        self.var_eddebed5872b3b52 = [];
    }
    
    weaponmetadata = self.var_eddebed5872b3b52[ slotname ];
    
    if ( isdefined( weaponmetadata ) )
    {
        var_f4c73fbd6866b07 = 0;
        
        foreach ( data in weaponmetadata.secure )
        {
            if ( data[ 0 ] == 1 )
            {
                if ( data[ 1 ] == self.var_1fa81a0e31f08222 )
                {
                    var_f4c73fbd6866b07 = 1;
                }
                
                break;
            }
        }
        
        if ( var_f4c73fbd6866b07 )
        {
            foreach ( data in weaponmetadata.insecure )
            {
                if ( data[ 0 ] == 15 )
                {
                    return data[ 1 ];
                }
            }
        }
    }
}

// Namespace common_instance_inventory
// Params 3
// Checksum 0xd6f349e6, Offset: 0x7157
// Size: 0x81
function function_414fe7abd6cb9cdc( location, sublocation, reductionseconds )
{
    instance = self function_41f811caf4053d98( location, sublocation );
    
    if ( !function_ae3907698ee6e6f1( instance ) )
    {
        return;
    }
    
    currentcooldown = instance.cooldownexpiration ?? 0;
    
    if ( currentcooldown <= getsystemtime() )
    {
        return;
    }
    
    self function_86c4417b398dd00( instance.instanceid, int( max( currentcooldown - reductionseconds, 0 ) ) );
}

// Namespace common_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x1ed06f74, Offset: 0x71e0
// Size: 0x2f, Type: bool
function private function_b476039704194ec4()
{
    if ( !isdefined( level.var_75f5a342c888c093 ) )
    {
        level.var_75f5a342c888c093 = getdvarint( @"hash_9f2df0e295940dc4", 0 );
    }
    
    return istrue( level.var_75f5a342c888c093 );
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x743d24ca, Offset: 0x7218
// Size: 0x46, Type: bool
function function_a9c1208833ddfc8e( var_d1e58031a710f96a )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:xe9a>" );
        return false;
    }
    
    if ( function_b476039704194ec4() )
    {
        return true;
    }
    
    if ( !isenabled() )
    {
        return false;
    }
    
    return function_40ebf70d26a3b7eb( var_d1e58031a710f96a ) > 0;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xc092a288, Offset: 0x7267
// Size: 0x2b
function function_40ebf70d26a3b7eb( var_d1e58031a710f96a )
{
    if ( function_b476039704194ec4() )
    {
        return 1;
    }
    
    if ( !isenabled() )
    {
        return 0;
    }
    
    return self function_3bf6be64d239b853( var_d1e58031a710f96a );
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0x80261000, Offset: 0x729b
// Size: 0x43
function getweaponobjlootid( weaponobj, bundlename )
{
    lootid = weapon::getweaponlootid( weaponobj );
    
    if ( lootid == 0 && isdefined( bundlename ) )
    {
        lootid = common_item::function_b01955b20c77371d( bundlename );
    }
    
    return lootid;
}

// Namespace common_instance_inventory
// Params 3
// Checksum 0xe5dde911, Offset: 0x72e7
// Size: 0xbd
function function_34f09daaeaad639e( weaponobj, bundlename, instanceid = -1 )
{
    lootid = getweaponobjlootid( weaponobj, bundlename );
    var_a834790f492b07f8 = function_1e555380baacc77f( weaponobj );
    rarity = undefined;
    
    if ( isdefined( weaponobj.basename ) && weaponobj.basename != "none" && isplayer( self ) )
    {
        rarity = item_weapon::function_fb81bd2fe070faa6( weaponobj );
    }
    
    return { #rarity:rarity, #instanceid:instanceid, #var_a834790f492b07f8:var_a834790f492b07f8, #lootid:lootid };
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xcb1d76bc, Offset: 0x73ad
// Size: 0x4e
function function_ba123c1855fc926( instance )
{
    blueprintindex = function_4d465a88a4c974d3( instance.lootid );
    weaponinfo = function_4da778f38e8b3044( instance, blueprintindex );
    weapon = weapon::function_a972ae5c8fb5933( weaponinfo );
    return weapon;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x7fa0744d, Offset: 0x7404
// Size: 0x3ab
function function_1e555380baacc77f( weaponobj )
{
    weaponrootname = weapon::getweaponrootname( weaponobj );
    subcomponents = [];
    
    if ( isdefined( weaponobj.attachments ) )
    {
        defaultattachments = getweapondefaultattachments( weaponobj );
        
        foreach ( attachment in weaponobj.attachments )
        {
            isdefault = arraycontains( defaultattachments, attachment );
            isselectable = utility::callsharedfunc( #"weapons", #"hash_35d31d8d23e44a0", weaponobj, attachment );
            
            if ( weaponobj.attachmentvarindices[ attachment ] > 0 )
            {
                attachmentlootid = function_1136b3843dc9e18d( weaponobj.basename, attachment, weaponobj.attachmentvarindices[ attachment ] );
                
                if ( !isdefined( attachmentlootid ) )
                {
                    attachmentlootid = weapon::getattachmentlootid( weaponrootname, attachment );
                }
                
                subcomponents[ subcomponents.size ] = attachmentlootid;
                continue;
            }
            
            if ( !isdefault && isselectable )
            {
                subcomponents[ subcomponents.size ] = weapon::getattachmentlootid( weaponrootname, attachment );
            }
        }
    }
    
    if ( isdefined( weaponobj.camo ) )
    {
        var_d2196df9bcc1f0ce = level.var_d2196df9bcc1f0ce[ weaponobj.camo ][ weaponrootname ];
        
        if ( var_d2196df9bcc1f0ce )
        {
            subcomponents[ subcomponents.size ] = var_d2196df9bcc1f0ce;
        }
        else
        {
            subcomponents[ subcomponents.size ] = loot::getlootidfromref( weaponobj.camo );
        }
    }
    
    if ( isdefined( weaponobj.reticle ) )
    {
        reticlebundle = function_64144d3177c6bcce( weaponobj );
        
        if ( reticlebundle )
        {
            reticleLootID = getscriptbundlefieldvalue( reticlebundle, #"lootid" ) ?? 0;
            
            if ( reticleLootID != 0 )
            {
                subcomponents[ subcomponents.size ] = reticleLootID;
            }
        }
    }
    
    if ( isdefined( weaponobj.charmscriptbundle ) )
    {
        subcomponents[ subcomponents.size ] = loot::getlootidfromref( weaponobj.charmscriptbundle.charmref );
    }
    
    if ( isdefined( weaponobj.stickerslot0 ) && weaponobj.stickerslot0 != "sticker_none" )
    {
        subcomponents[ subcomponents.size ] = loot::getlootidfromref( function_41bec0232e24ee41( weaponobj.stickerslot0, "i/" ) );
    }
    
    if ( isdefined( weaponobj.stickerslot1 ) && weaponobj.stickerslot1 != "sticker_none" )
    {
        subcomponents[ subcomponents.size ] = loot::getlootidfromref( function_41bec0232e24ee41( weaponobj.stickerslot1, "i/" ) );
    }
    
    if ( isdefined( weaponobj.stickerslot2 ) && weaponobj.stickerslot2 != "sticker_none" )
    {
        subcomponents[ subcomponents.size ] = loot::getlootidfromref( function_41bec0232e24ee41( weaponobj.stickerslot2, "i/" ) );
    }
    
    if ( isdefined( weaponobj.stickerslot3 ) && weaponobj.stickerslot3 != "sticker_none" )
    {
        subcomponents[ subcomponents.size ] = loot::getlootidfromref( function_41bec0232e24ee41( weaponobj.stickerslot3, "i/" ) );
    }
    
    if ( isdefined( weaponobj.var_73762c7cb8b2063 ) && weaponobj.var_73762c7cb8b2063 != "sticker_none" )
    {
        subcomponents[ subcomponents.size ] = loot::getlootidfromref( function_41bec0232e24ee41( weaponobj.var_73762c7cb8b2063, "i/" ) );
    }
    
    utility::callsharedfunc( #"instanceInventory", #"hash_33b349611dba5601", weaponobj, subcomponents );
    return subcomponents;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xe39f9257, Offset: 0x77b8
// Size: 0x11b
function function_d40581772670a3e( player )
{
    subcomponents = [];
    allmodules = player.rigslots;
    
    foreach ( module in allmodules )
    {
        name = common_item_database::function_a4f0a21951180013( module );
        
        if ( !name )
        {
            continue;
        }
        
        itembundle = getscriptbundlefieldvalues( name, [ #"ref", #"hash_a3136e2196e1d61a" ] );
        
        if ( !itembundle.var_74fdf8cd1e01b989 )
        {
            continue;
        }
        
        lootid = common_item::items_getlootidfromref( itembundle.ref );
        
        if ( !isdefined( lootid ) )
        {
            continue;
        }
        
        subcomponents[ subcomponents.size ] = lootid;
    }
    
    return subcomponents;
}

// Namespace common_instance_inventory
// Params 3, eflags: 0x4
// Checksum 0x8839fcd1, Offset: 0x78dc
// Size: 0xd6
function private function_9176bef1ef34015a( player, resourcebundle, quantity )
{
    resourceid = level.var_dd675d2bd46d6e5f[ resourcebundle.var_898b66f2326be513 ];
    
    if ( isdefined( resourceid ) )
    {
        before = player function_b68ced2de078c8cc( resourceid );
        player function_7de0e979b2a80889( resourceid, quantity );
        after = player function_b68ced2de078c8cc( resourceid );
        added = after - before;
        
        if ( added < quantity )
        {
            if ( !isdefined( self.var_f98e688273793859 ) )
            {
                self.var_f98e688273793859 = 0;
            }
            
            self.var_f98e688273793859 += quantity - added;
        }
    }
    
    if ( isdefined( resourcebundle.challengebit ) )
    {
        challenges::function_f28537541380c90a( player, quantity, resourcebundle.challengebit );
    }
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xf3c4dd20, Offset: 0x79ba
// Size: 0x4a
function function_d9382cb4b4fd3cfe()
{
    /#
        if ( !isenabled() )
        {
            return currency::get_currency_amount( "<dev string:xed5>" );
        }
    #/
    
    cashid = level.var_dd675d2bd46d6e5f[ "Cash" ];
    
    if ( isdefined( cashid ) )
    {
        return max( self function_b68ced2de078c8cc( cashid ), 0 );
    }
    
    return 0;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xaa40418f, Offset: 0x7a0d
// Size: 0x5b
function function_8d64eb5ec00a1818( player )
{
    iteminstance = function_4c1e57c205fb4b91( player, #"operator" );
    operatorlevel = function_9513862f69ec0498( 3, iteminstance, 1 );
    
    if ( !isdefined( operatorlevel ) || operatorlevel == "" )
    {
        operatorlevel = 0;
    }
    
    return int( operatorlevel );
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0x2bef1fb8, Offset: 0x7a71
// Size: 0x4f
function function_dfc147e06c587c4b( player )
{
    operatorlevel = function_8d64eb5ec00a1818( player );
    scriptbundle = getscriptbundle( %"hash_20b5e550f589c11" );
    return scriptbundle.ranklist[ operatorlevel ].rank;
}

// Namespace common_instance_inventory
// Params 1
// Checksum 0xb2c1c607, Offset: 0x7ac9
// Size: 0x49
function function_e2bf67c04711b64f( player )
{
    rankentry = function_dfc147e06c587c4b( player );
    values = getscriptbundlefieldvalues( rankentry, [ #"relatedlootid" ] );
    return values.relatedlootid;
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0xd23c5c77, Offset: 0x7b1b
// Size: 0xe2
function function_c74fbad95ae19935( player, quantity )
{
    if ( !isenabled() )
    {
        return;
    }
    
    cashid = level.var_dd675d2bd46d6e5f[ "Cash" ];
    quantity = int( quantity );
    
    if ( quantity < 0 && player function_d9382cb4b4fd3cfe() < quantity )
    {
        assertmsg( "<dev string:xeda>" );
        player function_49a1dccd48042b08( cashid, 0 );
    }
    else
    {
        player function_7de0e979b2a80889( cashid, quantity );
    }
    
    if ( quantity > 0 )
    {
        if ( !isdefined( player.extractedcash ) )
        {
            player.extractedcash = 0;
        }
        
        player.extractedcash += quantity;
        challenges::function_f28537541380c90a( player, quantity, cashid );
    }
    
    if ( hasomnvar( "ui_wallet_amount" ) )
    {
        player setclientomnvar( "ui_wallet_amount", player function_d9382cb4b4fd3cfe() );
    }
}

// Namespace common_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0xb6a01e5, Offset: 0x7c05
// Size: 0x35, Type: bool
function private function_28764917512a41cd( slotref )
{
    instance = function_6e525a83b773221( slotref );
    return common_item::items_getlootidfromref( instance.var_74b30c282949fe5a ) ?? 0;
}

// Namespace common_instance_inventory
// Params 0
// Checksum 0xd67b94db, Offset: 0x7c43
// Size: 0x4a, Type: bool
function function_dbacd0955ecf31c9()
{
    instanceslot = function_6e525a83b773221( #"hash_50f543d584b67a14" );
    instance = self function_41f811caf4053d98( instanceslot.location, instanceslot.sublocation );
    return function_ae3907698ee6e6f1( instance );
}

// Namespace common_instance_inventory
// Params 2
// Checksum 0x78842b76, Offset: 0x7c96
// Size: 0x87
function function_caff1c402df5dae8( traitchildren, index )
{
    instanceslot = function_6e525a83b773221( #"hash_50f543d584b67a14" );
    var_67b5c2a186b5eab5 = instanceslot.sublocation + index;
    function_b86acd5b5496f84d( instanceslot.location, var_67b5c2a186b5eab5 );
    function_7467cfa870b97b5a( 93581, 1800 + int( function_8d761e58e114e5c4() ) - 1, instanceslot.location, var_67b5c2a186b5eab5, traitchildren );
}

/#

    // Namespace common_instance_inventory
    // Params 0, eflags: 0x4
    // Checksum 0xe4b3a5a9, Offset: 0x7d25
    // Size: 0x2e, Type: dev
    function private debugsetup()
    {
        devgui::function_9082edeb5db93280( "<dev string:xf09>" );
        devgui::add_devgui_func( "<dev string:xf29>", "<dev string:xf43>", &debugfinalize );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace common_instance_inventory
    // Params 0, eflags: 0x4
    // Checksum 0xa77ffbd0, Offset: 0x7d5b
    // Size: 0x9d, Type: dev
    function private debugfinalize()
    {
        foreach ( player in level.players )
        {
            player.inventoryfinalized = 0;
            player function_b1b5b47fe399f1e7( 1 );
            player function_8fd84f733b81e456();
            player function_2b6ded790c955ccb();
        }
    }

    // Namespace common_instance_inventory
    // Params 3, eflags: 0x4
    // Checksum 0x80396c3f, Offset: 0x7e00
    // Size: 0x1f8, Type: dev
    function private function_661cb619c4f68d2( instance, player, context )
    {
        if ( getdvarint( @"hash_613933303e1174d5", 0 ) == 0 )
        {
            return;
        }
        
        println( "<dev string:xf6b>" + instance.instanceid + "<dev string:xf8a>" );
        
        if ( isdefined( player ) )
        {
            println( "<dev string:xf91>" + player.name );
        }
        
        if ( isdefined( context ) )
        {
            println( "<dev string:xf9a>" + context );
        }
        
        if ( isdefined( instance.metadata ) )
        {
            println( "<dev string:xfa4>" );
            
            foreach ( data in instance.metadata )
            {
                println( "<dev string:xfb5>" + data.key + "<dev string:xfbb>" + data.value );
            }
        }
        
        if ( isdefined( instance.var_c11bbd62e8f23645 ) )
        {
            println( "<dev string:xfc5>" );
            
            foreach ( data in instance.var_c11bbd62e8f23645 )
            {
                println( "<dev string:xfb5>" + data.key + "<dev string:xfbb>" + data.value );
            }
        }
        
        println( "<dev string:xfd8>" + instance.instanceid + "<dev string:xf8a>" );
    }

    // Namespace common_instance_inventory
    // Params 0
    // Checksum 0xd7b5b703, Offset: 0x8000
    // Size: 0x2b, Type: dev
    function devenabled()
    {
        return isdefined( level.gamemodebundle ) ? istrue( level.gamemodebundle.var_b1e6ec706428fa46 ) : 0;
    }

#/
