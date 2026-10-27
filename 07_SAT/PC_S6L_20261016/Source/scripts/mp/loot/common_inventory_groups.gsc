// scripts\mp\loot\common_inventory_groups.gsc  (hash_52f6e21d675cefec.gscc) (size: 57356 Bytes / 0xe00c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9ff4980 (4194257280)
// size ...... 57356 (0xe00c)
// includes .. 16  (offset: 0xdb2c)
// strings ... 47  (offset: 0xdbac)
// dev strs .. 14  (offset: 0xdf5c)
// exports ... 130 (offset: 0x9ec0)
// cseg ...... 0x372 + 0x9b4e (0x9ec0)
// imports ... 300 (offset: 0xb310)
// animtree1 . 0   (offset: 0xe00c)
// animtree2 . 0   (offset: 0xe00c)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\bounty_wanted;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;

#namespace common_inventory_groups;

// Namespace common_inventory_groups
// Params 0, eflags: 0x5
// Checksum 0xdff92273, Offset: 0x390
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"common_inventory_groups", #"common_inventory", &init, undefined );
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x62b6a65b, Offset: 0x3b9
// Size: 0x27a
function init()
{
    if ( !common_inventory::inventory_isenabled() || !inventorygroup_enabled() || level.inventorygroups )
    {
        return;
    }
    
    if ( !level.commonitem )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.inventorygroups = [];
    inventorygroup_register( 0, &function_63677b108a0ff271 );
    inventorygroup_register( 1, &function_6a8341777ee0c509, &function_7bc00939437e31d8, &function_a46efa1f9cc44ebb, &function_c27ac785b5373b73 );
    inventorygroup_register( 2, &function_f998388e358cf199, &function_3e6bbea9196b5392, &function_a1c96095f2d9e7b3, &function_896ed3217a875f7d );
    inventorygroup_register( 3, &function_d6c4d76ff6ccb354, &function_d34b33fe6910c2b3, &function_9ce95cacb0bdd6fa, &function_f21361209233afa );
    inventorygroup_register( 131, &function_d24bdce79b4983ac, &function_97033a5afde2ac9b, &function_7e9d1f88ae6255d6, &function_db5a1ed29a9116b2 );
    inventorygroup_register( 20, &function_9c8691b495da38ea, &function_9181f6aad93f999d, &function_98cc7d797d834288, &function_935aeab40494aefc );
    inventorygroup_register( 5, &function_41fe07e971a7e566, &function_75c026e08d6e49d3, &function_26e8d89c0e534760, &function_ecbef11f7cab32fa );
    inventorygroup_register( 4, &function_b5139dcd34f5e71d, &function_86624a4bfa9b4bfa, &function_b484c980606c1d2f, &function_f8c75ac0ed477595 );
    inventorygroup_register( 21, &function_9c8691b495da38ea, &function_9181f6aad93f999d, &function_98cc7d797d834288, &function_935aeab40494aefc );
    inventorygroup_register( 130, &function_1bdc8fc964c99a08, &function_7bcd40e0b22a963f, &function_48e2b44da86b9022, &function_5383a295f9e4ae09 );
    inventorygroup_register( 7, &function_b987142c4b5e97af, &function_370d4f4c8ad12928, &function_fc6f05b5daf4d44d, &function_f5e1c6cea41a1a13 );
    thread function_92aa347a4ef1517d();
    thread function_71044e7f34def746();
    callback::add( #"hash_89555462d4b2ee9f", &function_4b107113143c697e );
    callback::add( #"player_item_pickup", &function_32d5a80bd7babf56 );
    callback::add( #"prematch_done", &function_3664ce722fc287e7 );
    callback::add( #"equipment_use", &function_47af79123f074b9b );
    callback::add( #"player_laststand_exit", &function_d7ebdc81e04bb928 );
    callback::add( #"killstreak_activated", &function_8e1612374088f6f1 );
    callback::add( #"on_super_use_finished", &function_aa6a079a30666967 );
    callback::add( #"gasmask_broken", &function_6571b54d60ca361e );
    callback::add( #"hash_42a07c459e05796d", &function_124ab74e96b061e4 );
    
    if ( common_instance_inventory::isenabled() )
    {
        callback::add( #"instance_inventory_setup", &function_158ae7ede45ead16 );
        return;
    }
    
    callback::add( #"player_spawned", &function_158ae7ede45ead16 );
}

// Namespace common_inventory_groups
// Params 5
// Checksum 0xf1468041, Offset: 0x63b
// Size: 0xa1
function inventorygroup_register( groupindex, tofunc, fromfunc, getfunc, var_65a6f7922d118cdd )
{
    level.inventorygroups[ groupindex ] = spawnstruct();
    level.inventorygroups[ groupindex ].tofunc = tofunc;
    level.inventorygroups[ groupindex ].fromfunc = fromfunc;
    level.inventorygroups[ groupindex ].getfunc = getfunc;
    level.inventorygroups[ groupindex ].var_65a6f7922d118cdd = var_65a6f7922d118cdd;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x3b0d8d43, Offset: 0x6e4
// Size: 0x20
function function_987405ff5ee23e99( groupindex )
{
    if ( !isdefined( groupindex ) )
    {
        return;
    }
    
    return level.inventorygroups[ groupindex ];
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x61e4eb39, Offset: 0x70d
// Size: 0x15
function inventorygroup_enabled()
{
    return level.gametypebundle.var_a391eddd059957ef;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xe21e6086, Offset: 0x72b
// Size: 0x55
function function_158ae7ede45ead16( params )
{
    function_6c235adfbbfc52ca( params );
    function_e7147271c6109155( params );
    [ loadoutgroup, _ ] = function_896ed3217a875f7d();
    function_6ba35ad635331220( loadoutgroup );
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0xfe48e95f, Offset: 0x788
// Size: 0x106
function private function_6c235adfbbfc52ca( params )
{
    loadoutindex = getdvarint( @"scr_loadout_group_index", 0 );
    
    if ( loadoutindex > 0 && level.inventorygroupings && level.inventorygroupings[ "LOADOUT" ] )
    {
        foreach ( loadoutbundlename, loadoutdata in level.inventorygroupings[ "LOADOUT" ] )
        {
            if ( loadoutdata.index === loadoutindex - 1 )
            {
                self.loadoutgroup = loadoutbundlename;
            }
        }
        
        if ( self.loadoutgroup && hasomnvar( "ui_loadout_index" ) )
        {
            self setclientomnvar( "ui_loadout_index", loadoutindex );
        }
    }
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xea14d3da, Offset: 0x896
// Size: 0x1c4
function function_e7147271c6109155( params )
{
    if ( !level.inventorygroups )
    {
        return;
    }
    
    foreach ( groupid, funcs in level.inventorygroups )
    {
        if ( !function_bdd40ff62071d8a0( groupid ) || !funcs.getfunc || !funcs.var_65a6f7922d118cdd )
        {
            continue;
        }
        
        [ groupbundle, _ ] = self [[ funcs.var_65a6f7922d118cdd ]]();
        
        if ( !groupbundle.buttonrows )
        {
            continue;
        }
        
        index = 0;
        
        for ( i = groupbundle.buttonrows.size - 1; i >= 0 ; i-- )
        {
            row = groupbundle.buttonrows[ i ];
            
            for ( j = 0; j < row.buttoncolumns.size ; j++ )
            {
                item = self [[ funcs.getfunc ]]( i, j, 0, 0 );
                
                if ( isdefined( item.count ) )
                {
                    function_172046f8819425a6( groupid, index, item );
                }
                
                index += 1;
            }
        }
    }
    
    callback::callback( #"hash_79fff19f74169f8e", { #player:self } );
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0xe7ff54bc, Offset: 0xa62
// Size: 0x57
function function_228fbf34ff2066d7( groupindex, slotindex, additionaldata )
{
    if ( !inventorygroup_enabled() )
    {
        return;
    }
    
    if ( !self.inventory || !isdefined( groupindex ) || !isdefined( slotindex ) )
    {
        return;
    }
    
    self.inventory[ groupindex ][ slotindex ] = additionaldata;
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x9ad25ab, Offset: 0xac1
// Size: 0x52
function function_af51bdd9c1c5acd3( groupindex, slotindex )
{
    if ( !isdefined( groupindex ) || !isdefined( slotindex ) || !self.inventory || !self.inventory[ groupindex ] )
    {
        return;
    }
    
    return self.inventory[ groupindex ][ slotindex ];
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x353d6e24, Offset: 0xb1c
// Size: 0xb
function function_4e8ec7c4c3d604e4()
{
    return self.inventory;
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0x2b976960, Offset: 0xb30
// Size: 0x12d
function function_2dc92498eae53857( groupindex, slotindex, item )
{
    additionaldata = item.additionaldata ?? {};
    additionaldata.groupindex = groupindex;
    additionaldata.slotindex = slotindex;
    additionaldata.originalowner = item.additionaldata.originalowner ?? self;
    additionaldata.critical = item.critical || item.additionaldata.critical ? 1 : undefined;
    additionaldata.activity = item.additionaldata.activity;
    additionaldata.scriptable = item.type;
    additionaldata.weaponobj = item.weaponobj;
    additionaldata.count = item.count ?? 0;
    item.additionaldata = additionaldata;
    return additionaldata;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x8d817b15, Offset: 0xc66
// Size: 0x9a
function function_32d5a80bd7babf56( params )
{
    if ( params.tobackpack )
    {
        return;
    }
    
    groupid = function_a6cff1b67a8fcc11( params.item );
    lootid = common_item::function_6d301ac91c3cd13d( params.item );
    index = function_e7c426ab761c55e4( groupid, params.itembundle, lootid );
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    params.player function_172046f8819425a6( groupid, index, params.item );
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x9e8434c7, Offset: 0xd08
// Size: 0xdc
function function_4b107113143c697e( params )
{
    item = params.item;
    callbacks = undefined;
    
    if ( item )
    {
        itembundle = common_item::function_6b8ff3d5f2688336( item );
        callbacks = common_item::function_9f00d6361edd38ce( params.typeref );
        
        if ( itembundle.critical )
        {
            item.critical = 1;
        }
    }
    
    params.player function_172046f8819425a6( 1, params.index, params.item );
    
    if ( callbacks && callbacks.funcs[ #"hash_e2da6c78fc49f200" ] )
    {
        [[ callbacks.funcs[ #"hash_e2da6c78fc49f200" ] ]]( self, itembundle, item, 1, params );
    }
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0x621f870c, Offset: 0xdec
// Size: 0x198
function function_172046f8819425a6( groupindex, slotindex, item )
{
    if ( !isdefined( self.inventory ) )
    {
        self.inventory = [];
    }
    
    if ( !isdefined( self.inventory[ groupindex ] ) )
    {
        self.inventory[ groupindex ] = [];
    }
    
    additionaldata = undefined;
    var_f346f8c72c6eef8a = function_af51bdd9c1c5acd3( groupindex, slotindex );
    
    if ( !isdefined( item ) )
    {
        item = function_b340fb55e3a33389( groupindex, slotindex );
    }
    
    deltacount = 0;
    
    if ( item )
    {
        if ( var_f346f8c72c6eef8a )
        {
            if ( var_f346f8c72c6eef8a.scriptable != item.type )
            {
                self.inventory[ groupindex ][ slotindex ] = undefined;
                deltacount = item.count ?? 0;
            }
            else
            {
                deltacount = ( item.count ?? 0 ) - var_f346f8c72c6eef8a.count;
            }
        }
        
        additionaldata = function_2dc92498eae53857( groupindex, slotindex, item );
        self.inventory[ groupindex ][ slotindex ] = additionaldata;
    }
    else if ( var_f346f8c72c6eef8a )
    {
        additionaldata = self.inventory[ groupindex ][ slotindex ];
        deltacount = -1 * additionaldata.count;
        self.inventory[ groupindex ][ slotindex ] = undefined;
    }
    
    callback::callback( #"inventory_update", { #slotindex:slotindex, #groupindex:groupindex, #deltacount:deltacount, #item:item, #empty:!isdefined( item ), #additionaldata:additionaldata } );
    return additionaldata;
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0x46798c4c, Offset: 0xf8d
// Size: 0x84
function private function_47af79123f074b9b( params )
{
    if ( !params.ref || !isplayer( self ) )
    {
        return;
    }
    
    lootid = common_item::items_getlootidfromref( params.ref );
    
    if ( !lootid )
    {
        return;
    }
    
    itembundle = common_item::function_b202b16941992cca( lootid );
    
    if ( !itembundle )
    {
        return;
    }
    
    slotindex = function_76928b4f093ca1ad( 2, itembundle, 1 );
    function_172046f8819425a6( 2, slotindex );
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0xc141e44b, Offset: 0x1019
// Size: 0x40
function private function_124ab74e96b061e4( params )
{
    foundslot = function_62b90f3423d5f896( 2, "armor" );
    
    if ( !foundslot )
    {
        return;
    }
    
    function_172046f8819425a6( 2, foundslot.index );
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0x9df5942f, Offset: 0x1061
// Size: 0x40
function private function_8e1612374088f6f1( params )
{
    foundslot = function_62b90f3423d5f896( 2, "killstreak" );
    
    if ( !foundslot )
    {
        return;
    }
    
    function_172046f8819425a6( 2, foundslot.index );
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0x3f2750ff, Offset: 0x10a9
// Size: 0x40
function private function_aa6a079a30666967( params )
{
    foundslot = function_62b90f3423d5f896( 2, "super" );
    
    if ( !foundslot )
    {
        return;
    }
    
    function_172046f8819425a6( 2, foundslot.index );
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0x25f97368, Offset: 0x10f1
// Size: 0x40
function private function_6571b54d60ca361e( params )
{
    foundslot = function_62b90f3423d5f896( 2, "gasmask" );
    
    if ( !foundslot )
    {
        return;
    }
    
    function_172046f8819425a6( 2, foundslot.index );
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0x9ae57554, Offset: 0x1139
// Size: 0x5a
function private function_d7ebdc81e04bb928( params )
{
    if ( !self || !isplayer( self ) )
    {
        return;
    }
    
    if ( namespace_9d8e359c3b1041e5::hasselfrevivetokensharedfunc() )
    {
        return;
    }
    
    foundslot = function_62b90f3423d5f896( 2, "revive" );
    
    if ( !foundslot )
    {
        return;
    }
    
    function_172046f8819425a6( 2, foundslot.index );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0xe331a540, Offset: 0x119b
// Size: 0xae
function function_63677b108a0ff271( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    typeref = undefined;
    
    if ( item.type )
    {
        typeref = common_item::function_9621774ab5ce6f82( item.type );
    }
    
    return function_e3a3a47f88474ba4( item.count, !item.dontdrop, item, undefined, undefined, typeref == "weapon" || typeref == "gasmask" );
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xa85425ea, Offset: 0x1252
// Size: 0x94
function function_69f17db49d1fd00( itembundle )
{
    if ( !inventorygroup_enabled() )
    {
        return;
    }
    
    if ( isdefined( self.perks[ "specialty_trait_backpack_extra_slots" ] ) )
    {
        if ( isdefined( itembundle.var_8e68df9684111673 ) )
        {
            return itembundle.var_8e68df9684111673;
        }
        else if ( isdefined( level.gametypebundle.var_8e68df9684111673 ) )
        {
            return level.gametypebundle.var_8e68df9684111673;
        }
    }
    
    return itembundle.backpackgroup ?? level.gametypebundle.var_d64fe236fbddfa34;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xc6d8d155, Offset: 0x12ef
// Size: 0x32
function function_bb4396f7ff09e93f( bundlename )
{
    if ( !bundlename )
    {
        bundlename = level.gametypebundle.var_d64fe236fbddfa34;
    }
    
    self.backpackgroup = bundlename;
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0xfdeb04b3, Offset: 0x1329
// Size: 0x40
function function_c27ac785b5373b73()
{
    bundlename = self.backpackgroup ?? level.gametypebundle.var_d64fe236fbddfa34;
    return [ function_dffd0ba870098fc5( bundlename ), bundlename ];
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0x5cc753d8, Offset: 0x1372
// Size: 0xdc
function function_a46efa1f9cc44ebb( fromrow, fromcolumn, affectall, extradata )
{
    index = function_b3ca90137cf3cd0( self, fromrow, fromcolumn );
    lootid = common_inventory::inventory_getlootidatbackpackindex( index );
    itembundle = common_item::function_b202b16941992cca( lootid );
    typeref = common_item::function_16e8c106491eeaca( itembundle );
    quantity = common_inventory::inventory_getquantityatbackpackindex( index );
    
    if ( quantity == 0 && typeref != "weapon" )
    {
        return;
    }
    
    var_d602659d21376d75 = function_17c174dc1ef34e6b( affectall, itembundle, quantity, undefined, typeref );
    weaponobj = undefined;
    
    if ( typeref == "weapon" )
    {
        weaponobj = common_inventory::function_7bf60ff8870e96b4();
    }
    
    return common_item::function_77600f92048df72d( itembundle, var_d602659d21376d75, weaponobj, 1, index );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0xf852608d, Offset: 0x1457
// Size: 0x157
function function_3ede3be25ae9b1f7( groupa, rowa, columna, itema, groupb, rowb, columnb, itemb )
{
    funcsa = function_987405ff5ee23e99( groupa );
    itema = itema ?? [[ funcsa.getfunc ]]( rowa, columna, 1 );
    
    if ( isarray( itema ) )
    {
        itema = itema[ 0 ];
    }
    
    if ( itema )
    {
        self [[ funcsa.fromfunc ]]( itema.count, 0, rowa, columna );
    }
    
    funcsb = function_987405ff5ee23e99( groupb );
    itemb = itemb ?? [[ funcsb.getfunc ]]( rowb, columnb, 1 );
    
    if ( itemb && isarray( itemb ) )
    {
        itemb = itemb[ 0 ];
    }
    
    if ( itemb )
    {
        extradata = { #var_8e2a9de76678811f:1 };
        self [[ funcsb.fromfunc ]]( itemb.count, 0, rowb, columnb );
        self [[ funcsa.tofunc ]]( itemb, rowa, columna, undefined, extradata, 999 );
    }
    
    if ( itema )
    {
        self [[ funcsb.tofunc ]]( itema, rowb, columnb, undefined, undefined, 999 );
    }
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0xe58de8d0, Offset: 0x15b6
// Size: 0x376
function function_6a8341777ee0c509( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    newlootid = common_item::function_779887309ec71dfe( itembundle );
    itemtype = common_item::function_9deb822f286163b1( newlootid );
    callbacks = common_item::function_9f00d6361edd38ce( itemtype );
    
    if ( callbacks.funcs[ #"hash_549c36915774594e" ] )
    {
        var_efdf2e7094e10b13 = self [[ callbacks.funcs[ #"hash_549c36915774594e" ] ]]( itembundle );
        
        if ( var_efdf2e7094e10b13 )
        {
            quantityused = common_item::function_2b5e2ff57d5f392( item );
            return function_e3a3a47f88474ba4( quantityused, 0 );
        }
    }
    
    if ( !function_b4a381d24198d6cd( torow, tocolumn ) && itemtype != "weapon" )
    {
        index = function_b3ca90137cf3cd0( self, torow, tocolumn );
        quantityused = 0;
        
        if ( function_bdd40ff62071d8a0( fromgroup ) )
        {
            function_3ede3be25ae9b1f7( fromgroup, fromrow, fromcolumn, item, 1, torow, tocolumn );
        }
        else
        {
            quantityused = common_inventory::function_22c912d7a228afd8( index, newlootid, item.count, undefined, item, function_175892577412c612( fromgroup ) );
        }
        
        common_item::function_e70f64f8d4664b9e( self, item, item.count, 1 );
        return function_e3a3a47f88474ba4( quantityused, 0, undefined, undefined, undefined, itemtype == "weapon" );
    }
    
    if ( fromgroup == 2 )
    {
        item.var_bfb964dc17a2982c = 2;
    }
    
    if ( itemtype == "weapon" )
    {
        validslots = function_8b575930cbcb2457( 1, itembundle );
        
        if ( validslots.size == 1 )
        {
            slot = validslots[ 0 ];
            var_d793611aa27f052f = item_weapon::function_2acdc118d951356c( { #slotname:#"backpack_0" } );
            currentquantity = common_inventory::inventory_getquantityatbackpackindex( slot.index );
            common_inventory::function_56f7e890f83685bd();
            var_6993bc4ae891d692 = item_weapon::function_31562a2fb3df68d5( itembundle, item );
            common_inventory::function_1923cd40e1b4efc8( var_6993bc4ae891d692 );
            lootid = common_item::function_779887309ec71dfe( itembundle );
            common_inventory::inventory_setbackpackitematindex( slot.index, lootid, common_item::function_44eacd480abb5b94( item.count ), item );
            backpackitem = undefined;
            
            if ( var_d793611aa27f052f )
            {
                currentbundle = common_item::function_90c3e0c1fd55d6b6( var_d793611aa27f052f.name );
                backpackitem = common_item::function_77600f92048df72d( currentbundle, var_d793611aa27f052f.count, var_d793611aa27f052f.weaponobj, 1, slot.index );
                backpackitem.count = currentquantity;
            }
            
            common_item::function_e70f64f8d4664b9e( self, item, item.count, 1 );
            
            if ( fromgroup == 2 )
            {
                function_3e6bbea9196b5392( item.count, 0, fromrow, fromcolumn, undefined, 0, 0, 1 );
                
                if ( backpackitem )
                {
                    common_item::function_2b5e2ff57d5f392( backpackitem, undefined, 1, undefined, undefined, undefined, 1 );
                }
                
                return function_e3a3a47f88474ba4( 0, 0 );
            }
            
            return function_e3a3a47f88474ba4( item.count, isdefined( backpackitem ), backpackitem, undefined, undefined, 1 );
        }
    }
    
    quantityused = common_inventory::function_b374bcc6d7c43b31( item, newlootid, undefined, undefined, function_175892577412c612( fromgroup ) );
    return function_e3a3a47f88474ba4( quantityused, 0, undefined, undefined, undefined, itemtype == "weapon" );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0xe51f9279, Offset: 0x1935
// Size: 0x25d
function function_7bc00939437e31d8( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    index = function_b3ca90137cf3cd0( self, fromrow, fromcolumn );
    lootid = common_inventory::inventory_getlootidatbackpackindex( index );
    quantity = common_inventory::inventory_getquantityatbackpackindex( index );
    newquantity = quantity - quantityused;
    newitem = undefined;
    itembundle = undefined;
    typeref = common_item::function_9deb822f286163b1( lootid );
    
    if ( newquantity < 0 )
    {
        assertmsg( "<dev string:x85>" );
        return;
    }
    
    if ( shoulddrop )
    {
        itembundlename = undefined;
        
        if ( toitem )
        {
            itembundlename = common_item::function_33a2c00e46263d99( toitem );
        }
        else
        {
            itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
        }
        
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        
        if ( typeref == "weapon" )
        {
            spawnoptions.weapon = common_inventory::function_7bf60ff8870e96b4();
            common_inventory::function_56f7e890f83685bd();
        }
        
        additionaldata = function_af51bdd9c1c5acd3( 1, index );
        spawnoptions.additionaldata = additionaldata;
        spawnoptions.var_fc803688fa7c976c = 21;
        common_item::function_61c2c0251e742ffd( itembundlename, quantityused, spawnoptions );
    }
    else if ( common_inventory::function_5a70e09721a21568() && toitem && newquantity <= 0 )
    {
        itembundle = common_item::function_6b8ff3d5f2688336( toitem );
        tolootid = common_item::function_779887309ec71dfe( itembundle );
        
        if ( tolootid != lootid || !common_item::function_bfd517bdc8850ea6( typeref, itembundle ) )
        {
            lootid = tolootid;
            newquantity = toitem.count;
            newitem = toitem;
        }
    }
    
    if ( newquantity == 0 || lootid == 0 )
    {
        if ( typeref == "weapon" )
        {
            common_inventory::function_56f7e890f83685bd();
        }
        
        lootid = 0;
        newquantity = 0;
    }
    else if ( typeref == "weapon" && newitem && itembundle )
    {
        common_inventory::function_56f7e890f83685bd();
        var_6993bc4ae891d692 = item_weapon::function_31562a2fb3df68d5( itembundle, newitem );
        common_inventory::function_1923cd40e1b4efc8( var_6993bc4ae891d692 );
    }
    
    common_inventory::inventory_setbackpackitematindex( index, lootid, common_item::function_44eacd480abb5b94( newquantity ), newitem, toitem );
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x34499f0a, Offset: 0x1b9a
// Size: 0x21, Type: bool
function function_70646e83e5497be()
{
    return self.loadoutgroup ?? level.gametypebundle.var_300127ed993202cc;
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x6b4a5d26, Offset: 0x1bc4
// Size: 0x27
function function_896ed3217a875f7d()
{
    bundlename = function_70646e83e5497be();
    return [ function_dffd0ba870098fc5( bundlename ), bundlename ];
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x58ec78df, Offset: 0x1bf4
// Size: 0x8a
function function_acd97ba889776567( index, loadoutgroup )
{
    if ( !loadoutgroup )
    {
        [ loadoutgroup, _ ] = function_896ed3217a875f7d();
    }
    
    [ row, column ] = function_12ee5af12df204b4( loadoutgroup, index );
    
    if ( !isdefined( row ) || !isdefined( column ) )
    {
        return;
    }
    
    return inventorygroup_getweaponslotname( loadoutgroup, row, column );
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0xa0949fd9, Offset: 0x1c87
// Size: 0x263
function inventorygroup_getweaponslotname( loadoutgroup, var_6106a7b59449c058, var_cab2e959c5b1a482 )
{
    var_ca341850f0652061 = 0;
    var_a35b3057ec8730b1 = 0;
    subtype = "";
    var_1d1b23c9d34b4255 = undefined;
    
    foreach ( row, columns in loadoutgroup.buttonrows )
    {
        foreach ( column, _ in columns.buttoncolumns )
        {
            buttondefinition = function_62e8f7d021e6a61e( loadoutgroup, row, column );
            typedata = function_ec48255a23c8526f( buttondefinition );
            
            if ( typedata.alloweditemtypes.size == 0 )
            {
                continue;
            }
            
            slottype = typedata.alloweditemtypes[ 0 ].itemtype;
            subtype = typedata.alloweditemtypes[ 0 ].subtype;
            
            if ( row == var_6106a7b59449c058 && column == var_cab2e959c5b1a482 )
            {
                if ( subtype == #"tertiary" )
                {
                    var_1d1b23c9d34b4255 = var_a35b3057ec8730b1;
                    findtertiary = 1;
                }
                else
                {
                    var_1d1b23c9d34b4255 = var_ca341850f0652061;
                    findtertiary = 0;
                }
                
                break;
            }
            
            if ( slottype )
            {
                typeref = getscriptbundlefieldvalue( slottype, "typeRef" ) ?? "generic";
                
                if ( typeref == "weapon" )
                {
                    if ( subtype == #"tertiary" )
                    {
                        var_a35b3057ec8730b1++;
                        continue;
                    }
                    
                    var_ca341850f0652061++;
                }
            }
        }
        
        if ( isdefined( var_1d1b23c9d34b4255 ) )
        {
            break;
        }
    }
    
    if ( !isdefined( var_1d1b23c9d34b4255 ) )
    {
        throw( "InventoryGroup_GetWeaponSlotName - No slot found for row " + var_6106a7b59449c058 + " and column " + var_cab2e959c5b1a482 );
        return;
    }
    
    return findtertiary ? item_weapon::function_ecbb37fb8ca2b8cd( var_1d1b23c9d34b4255 ) : item_weapon::function_72e6bdd2cc8a6199( var_1d1b23c9d34b4255 );
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0x7ae298f2, Offset: 0x1ef3
// Size: 0x13f
function function_a1c96095f2d9e7b3( fromrow, fromcolumn, affectall, extradata )
{
    [ loadoutgroup, _ ] = function_896ed3217a875f7d();
    [ callbacks, typeref, var_8fb8e1fb220cca48 ] = function_98333f94074fd38e( loadoutgroup, fromrow, fromcolumn );
    
    if ( !var_8fb8e1fb220cca48 || var_8fb8e1fb220cca48.count <= 0 && typeref != "weapon" && typeref != "gasmask" )
    {
        return;
    }
    
    bundle = getscriptbundle( var_8fb8e1fb220cca48.name );
    quantity = function_17c174dc1ef34e6b( affectall, bundle, var_8fb8e1fb220cca48.durability ?? var_8fb8e1fb220cca48.count, var_8fb8e1fb220cca48.weaponobj );
    slotindex = function_7539b7a73a2ba0b2( loadoutgroup, fromrow, fromcolumn );
    return common_item::function_77600f92048df72d( bundle, quantity, var_8fb8e1fb220cca48.weaponobj, 2, slotindex );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0x729b8561, Offset: 0x203b
// Size: 0x518
function function_f998388e358cf199( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    if ( utility::issharedfuncdefined( item.type, #"hash_de84461e6d41a1c9" ) )
    {
        return utility::callsharedfunc( item.type, #"hash_de84461e6d41a1c9", item );
    }
    
    [ loadoutgroup, _ ] = function_896ed3217a875f7d();
    originalrow = torow;
    originalcolumn = tocolumn;
    
    if ( function_b4a381d24198d6cd( torow, tocolumn ) )
    {
        itembundle = common_item::function_6b8ff3d5f2688336( item );
        slotindex = function_76928b4f093ca1ad( 2, itembundle, 1, item );
        [ torow, tocolumn ] = function_12ee5af12df204b4( loadoutgroup, slotindex );
    }
    else if ( function_bdd40ff62071d8a0( fromgroup ) && fromgroup != 2 )
    {
        itembundle = common_item::function_6b8ff3d5f2688336( item );
        newlootid = common_item::function_779887309ec71dfe( itembundle );
        itemtype = common_item::function_9deb822f286163b1( newlootid );
        function_3ede3be25ae9b1f7( fromgroup, fromrow, fromcolumn, item, 2, torow, tocolumn );
        common_item::function_e70f64f8d4664b9e( self, item, item.count, 1 );
        return function_e3a3a47f88474ba4( 0, 0, undefined, undefined, undefined, itemtype == "weapon" );
    }
    
    if ( !isdefined( torow ) || !isdefined( tocolumn ) )
    {
        return {};
    }
    
    shoulddrop = fromgroup == 0;
    [ callbacks, typeref, var_8fb8e1fb220cca48 ] = function_98333f94074fd38e( loadoutgroup, torow, tocolumn );
    
    if ( !callbacks )
    {
        return {};
    }
    
    currentitem = undefined;
    returnempty = 0;
    
    if ( typeref == "weapon" )
    {
        if ( !level.gamemodebundle.var_76bb6a5731029fb8 )
        {
            slotname = undefined;
            
            if ( function_b4a381d24198d6cd( originalrow, originalcolumn ) )
            {
                var_a5cb646476a709ad = undefined;
                var_aca0dc81ff6e890f = 0;
                
                if ( extradata.var_62f650984f3ada2a )
                {
                    [ _, var_a5cb646476a709ad ] = item_weapon::function_5057d6afdfd6c768();
                    item.var_64a5633315d24c40 = 1;
                }
                else
                {
                    numprimaries = item_weapon::function_db94c1441f6cd802( 1 );
                    
                    if ( numprimaries <= 1 )
                    {
                        var_aca0dc81ff6e890f = 1;
                    }
                    else
                    {
                        var_a5cb646476a709ad = self function_ca1904a5dd87fd53() ?? self getcurrentweapon();
                    }
                }
                
                if ( !var_aca0dc81ff6e890f )
                {
                    if ( var_a5cb646476a709ad )
                    {
                        if ( var_a5cb646476a709ad == item_weapon::function_e7484276ad85f220( #"primary_0" ) )
                        {
                            slotname = #"primary_0";
                        }
                        else if ( var_a5cb646476a709ad == item_weapon::function_e7484276ad85f220( #"primary_1" ) )
                        {
                            slotname = #"primary_1";
                        }
                    }
                    
                    if ( !slotname )
                    {
                        slotname = extradata.var_62f650984f3ada2a ? #"primary_1" : #"primary_0";
                    }
                }
            }
            else
            {
                slotname = inventorygroup_getweaponslotname( loadoutgroup, torow, tocolumn );
            }
            
            if ( !var_aca0dc81ff6e890f )
            {
                var_db759b470a61dedf = fromgroup === 1 && common_inventory::function_5a70e09721a21568();
                
                if ( var_db759b470a61dedf )
                {
                    weapondata = self [[ callbacks.funcs[ #"getcurrent" ] ]]( { #slotname:slotname } );
                    
                    if ( weapondata.weaponobj )
                    {
                        slotindex = function_7539b7a73a2ba0b2( loadoutgroup, torow, tocolumn );
                        currentitem = common_item::function_77600f92048df72d( weapondata.name, weapondata.count, weapondata.weaponobj, 2, slotindex );
                    }
                }
                
                if ( fromgroup == 2 )
                {
                    var_e7284b31073910c0 = inventorygroup_getweaponslotname( loadoutgroup, fromrow, fromcolumn );
                    self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #dontdrop:1, #slotname:var_e7284b31073910c0 } );
                    returnempty = 1;
                }
                
                self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #dontdrop:var_db759b470a61dedf, #slotname:slotname } );
            }
        }
    }
    else if ( var_8fb8e1fb220cca48.count > 0 )
    {
        slotindex = function_7539b7a73a2ba0b2( loadoutgroup, torow, tocolumn );
        currentitem = common_item::function_77600f92048df72d( var_8fb8e1fb220cca48.name, var_8fb8e1fb220cca48.count, undefined, 2, slotindex );
    }
    
    quantityused = common_item::function_96119bed8ab4c5d9( item, undefined, undefined, function_175892577412c612( fromgroup ), extradata.var_8e2a9de76678811f );
    
    if ( quantityused )
    {
        slotindex = function_7539b7a73a2ba0b2( loadoutgroup, torow, tocolumn );
        function_172046f8819425a6( 2, slotindex );
    }
    
    if ( returnempty )
    {
        return {};
    }
    
    return function_e3a3a47f88474ba4( quantityused, shoulddrop, currentitem, undefined, undefined, typeref == "weapon" );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0x9cc22bf7, Offset: 0x255c
// Size: 0x2c1
function function_3e6bbea9196b5392( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    [ loadoutgroup, _ ] = function_896ed3217a875f7d();
    [ callbacks, typeref, var_8fb8e1fb220cca48 ] = function_98333f94074fd38e( loadoutgroup, fromrow, fromcolumn );
    
    if ( !callbacks.funcs[ #"removecurrent" ] || !callbacks.funcs[ #"getcurrent" ] )
    {
        return;
    }
    
    slotname = undefined;
    
    if ( typeref == "weapon" )
    {
        slotname = inventorygroup_getweaponslotname( loadoutgroup, fromrow, fromcolumn );
    }
    
    var_f3049d9662760faa = typeref == "weapon" && togroup == 0;
    var_34a7a3f23ff246cd = self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #dontdrop:!var_f3049d9662760faa, #slotname:slotname, #count:quantityused } );
    bundlename = var_34a7a3f23ff246cd.name ?? var_8fb8e1fb220cca48.name;
    quantityused = var_34a7a3f23ff246cd.count ?? quantityused;
    inventoryindex = function_7539b7a73a2ba0b2( loadoutgroup, fromrow, fromcolumn );
    
    if ( shoulddrop && !var_34a7a3f23ff246cd.dontdrop && !var_f3049d9662760faa && var_8fb8e1fb220cca48 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        additionaldata = function_af51bdd9c1c5acd3( 2, inventoryindex );
        spawnoptions.additionaldata = additionaldata;
        spawnoptions.spawningteam = self.team;
        spawnoptions.originalowner = self;
        spawnoptions.analyticssource = "dropped";
        item = common_item::function_61c2c0251e742ffd( bundlename, quantityused, spawnoptions );
        itemtype = common_item::function_3cba34a99d02cd9( bundlename );
        
        if ( isdefined( itemtype ) )
        {
            var_d8a830f7f5381c6e = common_item::function_c6f3ef3dcb4c55c0( itemtype, #"hash_de6911904edf96d3" );
            
            if ( isdefined( var_d8a830f7f5381c6e ) )
            {
                itembundle = getscriptbundle( bundlename );
                self [[ var_d8a830f7f5381c6e ]]( item, spawnoptions, itembundle );
            }
        }
    }
    
    function_172046f8819425a6( 2, inventoryindex );
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x36aa5474, Offset: 0x2825
// Size: 0xf0
function function_f21361209233afa()
{
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "perk_rig" );
    
    if ( !var_8fb8e1fb220cca48.name )
    {
        return [ function_dffd0ba870098fc5( level.gametypebundle.var_2670c23bbf76e59b ), level.gametypebundle.var_2670c23bbf76e59b ];
    }
    
    riggroup = getscriptbundlefieldvalue( var_8fb8e1fb220cca48.name, #"riggroup" );
    
    if ( !riggroup )
    {
        if ( !level.gametypebundle.var_2670c23bbf76e59b )
        {
            return [ undefined, undefined ];
        }
        
        return [ function_dffd0ba870098fc5( level.gametypebundle.var_2670c23bbf76e59b ), level.gametypebundle.var_2670c23bbf76e59b ];
    }
    
    return [ getscriptbundle( riggroup ), riggroup ];
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0xe3132d2e, Offset: 0x291e
// Size: 0xd6
function function_9ce95cacb0bdd6fa( fromrow, fromcolumn, affectall, extradata )
{
    [ perkgroup, _ ] = function_f21361209233afa();
    [ callbacks, typeref, var_8fb8e1fb220cca48 ] = function_98333f94074fd38e( perkgroup, fromrow, fromcolumn );
    
    if ( !callbacks || !var_8fb8e1fb220cca48 )
    {
        return;
    }
    
    index = function_7539b7a73a2ba0b2( perkgroup, fromrow, fromcolumn );
    return common_item::function_77600f92048df72d( var_8fb8e1fb220cca48.name, var_8fb8e1fb220cca48.count, undefined, 3, index );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0xe6868fde, Offset: 0x29fd
// Size: 0x68
function function_d6c4d76ff6ccb354( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    quantityused = common_item::function_2b5e2ff57d5f392( item );
    return function_e3a3a47f88474ba4( quantityused, 0 );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0x283e1d25, Offset: 0x2a6e
// Size: 0x5d
function function_d34b33fe6910c2b3( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x8f976656, Offset: 0x2ad3
// Size: 0x107
function function_193ff4daea75bb55( var_748bf771657d3e8a )
{
    if ( !var_748bf771657d3e8a )
    {
        self setclientomnvar( "ui_utility_group_index", 0 );
        self.resourcegroup = undefined;
        return;
    }
    
    if ( hasomnvar( "ui_utility_group_index" ) )
    {
        index = function_93b951c93e339754( "UTILITY", var_748bf771657d3e8a );
        
        if ( isdefined( index ) )
        {
            self setclientomnvar( "ui_utility_group_index", index + 1 );
        }
    }
    
    slots = function_6e8756548142d338( "UTILITY", var_748bf771657d3e8a );
    
    foreach ( slot in slots )
    {
        if ( slot.enablegroupasset )
        {
            self.resourcegroup = slot.enablegroupasset;
            break;
        }
    }
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0xee99fb5f, Offset: 0x2be2
// Size: 0x2e
function function_5383a295f9e4ae09()
{
    if ( self.resourcegroup )
    {
        return function_27fe7c6ba0ffc55c( "RESOURCES", self.resourcegroup );
    }
    
    return function_27fe7c6ba0ffc55c( "RESOURCES" );
}

// Namespace common_inventory_groups
// Params 5
// Checksum 0x1ce960f4, Offset: 0x2c19
// Size: 0x116
function function_48e2b44da86b9022( fromrow, fromcolumn, affectall, extradata, var_41d1e94effd14745 )
{
    var_26573cdd669441c1 = common_item::function_c6f3ef3dcb4c55c0( "resource", #"getcurrent" );
    
    if ( !var_26573cdd669441c1 )
    {
        return;
    }
    
    index = 0;
    
    if ( !function_b4a381d24198d6cd( fromrow, fromcolumn ) )
    {
        if ( !var_41d1e94effd14745 )
        {
            [ var_41d1e94effd14745, _ ] = function_5383a295f9e4ae09();
        }
        
        index = function_7539b7a73a2ba0b2( var_41d1e94effd14745, fromrow, fromcolumn );
    }
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    currentdata = self [[ var_26573cdd669441c1 ]]( { #bundlename:var_41d1e94effd14745.inventorygroupname, #index:index } );
    
    if ( !currentdata )
    {
        return;
    }
    
    itembundle = common_item::function_90c3e0c1fd55d6b6( currentdata.name );
    return common_item::function_77600f92048df72d( itembundle, currentdata.count, undefined, 130, index );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0xc337a62, Offset: 0x2d38
// Size: 0xc2
function function_1bdc8fc964c99a08( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    
    if ( !itembundle )
    {
        return function_e3a3a47f88474ba4( 0, 0 );
    }
    
    usefunc = common_item::function_c6f3ef3dcb4c55c0( "resource", #"use" );
    
    if ( !usefunc )
    {
        return function_e3a3a47f88474ba4( 0, 0 );
    }
    
    leftoveramount = self [[ usefunc ]]( itembundle, item );
    return function_e3a3a47f88474ba4( item.count - leftoveramount, 0 );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0x2a0ef201, Offset: 0x2e03
// Size: 0x19e
function function_7bcd40e0b22a963f( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    currentitem = function_48e2b44da86b9022( fromrow, fromcolumn );
    var_eab43258fe292345 = common_item::function_c6f3ef3dcb4c55c0( "resource", #"removecurrent" );
    
    if ( !var_eab43258fe292345 )
    {
        return;
    }
    
    removecount = currentitem.count;
    itembundle = common_item::function_6b8ff3d5f2688336( currentitem );
    
    if ( !affectall )
    {
        resourcebundle = common_item::function_6b8ff3d5f2688336( itembundle );
        removecount = common_item::function_ea3b3088d82fd357( resourcebundle );
    }
    
    index = 0;
    [ var_41d1e94effd14745, _ ] = function_5383a295f9e4ae09();
    
    if ( !function_b4a381d24198d6cd( fromrow, fromcolumn ) )
    {
        index = function_7539b7a73a2ba0b2( var_41d1e94effd14745, fromrow, fromcolumn );
    }
    
    self [[ var_eab43258fe292345 ]]( { #bundlename:var_41d1e94effd14745.inventorygroupname, #count:removecount, #index:index } );
    
    if ( shoulddrop )
    {
        lootid = common_item::function_6d301ac91c3cd13d( currentitem );
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        itembundle = common_item::function_b202b16941992cca( lootid );
        common_item::function_61c2c0251e742ffd( itembundle, removecount, spawnoptions );
    }
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x59c0157c, Offset: 0x2fa9
// Size: 0xd6
function function_db5a1ed29a9116b2()
{
    if ( !level.inventorygroupings || !level.inventorygroupings[ "KEYRING" ] )
    {
        return [];
    }
    
    keybundlename = self.keygroup;
    
    if ( !keybundlename )
    {
        foreach ( bundlename, entry in level.inventorygroupings[ "KEYRING" ] )
        {
            keybundlename = bundlename;
            break;
        }
    }
    
    if ( !keybundlename )
    {
        return [];
    }
    
    return [ function_dffd0ba870098fc5( keybundlename ), keybundlename ];
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0x872f04aa, Offset: 0x3088
// Size: 0x1b2
function function_7e9d1f88ae6255d6( fromrow, fromcolumn, affectall, extradata )
{
    if ( !self.keyring )
    {
        return;
    }
    
    keylootid = undefined;
    keyquantity = undefined;
    keyindex = undefined;
    
    if ( function_b4a381d24198d6cd( fromrow, fromcolumn ) )
    {
        foreach ( index, datastruct in self.keyring )
        {
            keyindex = index;
            keylootid = datastruct.lootid;
            keyquantity = datastruct.quantity;
        }
    }
    else
    {
        [ groupbundle, _ ] = function_db5a1ed29a9116b2();
        keyindex = function_7539b7a73a2ba0b2( groupbundle, fromrow, fromcolumn );
        keylootid = isdefined( self.keyring[ keyindex ] ) ? self.keyring[ keyindex ].lootid : undefined;
        keyquantity = isdefined( self.keyring[ keyindex ] ) ? self.keyring[ keyindex ].quantity : undefined;
    }
    
    if ( !keylootid || !isdefined( keyindex ) )
    {
        return;
    }
    
    itembundle = common_item::function_b202b16941992cca( keylootid );
    return common_item::function_77600f92048df72d( itembundle, keyquantity, undefined, 131, keyindex );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0xac4e3e98, Offset: 0x3243
// Size: 0x18f
function function_d24bdce79b4983ac( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    if ( !isdefined( self.keyring ) )
    {
        self.keyring = [];
    }
    
    index = function_7539b7a73a2ba0b2( torow, tocolumn );
    
    if ( function_b4a381d24198d6cd( torow, tocolumn ) )
    {
        [ keygroup, _ ] = function_db5a1ed29a9116b2();
        maxkeys = function_19a5a29f5cd0df45( keygroup );
        
        if ( isdefined( keygroup ) && self.keyring.size < maxkeys )
        {
            for ( i = 0; i < maxkeys ; i++ )
            {
                if ( !self.keyring[ i ] )
                {
                    index = i;
                    break;
                }
            }
        }
    }
    
    if ( !hasomnvar( "ui_key_slot_" + index ) )
    {
        return function_e3a3a47f88474ba4( 0, 0 );
    }
    
    lootid = common_item::function_6d301ac91c3cd13d( item );
    
    if ( !lootid )
    {
        return function_e3a3a47f88474ba4( 0, 0 );
    }
    
    self.keyring[ index ] = { #quantity:item.count, #lootid:lootid };
    self setclientomnvar( "ui_key_slot_" + index, lootid );
    return function_e3a3a47f88474ba4( item.count, 0 );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0x6952e583, Offset: 0x33db
// Size: 0x207
function function_97033a5afde2ac9b( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    if ( !self.keyring )
    {
        return;
    }
    
    [ keygroup, _ ] = function_db5a1ed29a9116b2();
    index = undefined;
    maxkeys = function_19a5a29f5cd0df45( keygroup );
    
    if ( function_b4a381d24198d6cd( fromrow, fromcolumn ) )
    {
        for ( i = 0; i < maxkeys ; i++ )
        {
            if ( !self.keyring[ i ] )
            {
                index = i;
                break;
            }
        }
    }
    else
    {
        index = function_7539b7a73a2ba0b2( keygroup, fromrow, fromcolumn );
    }
    
    if ( !isdefined( index ) || !self.keyring[ index ] || !self.keyring[ index ].lootid )
    {
        return;
    }
    
    if ( shoulddrop )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        itembundle = common_item::function_b202b16941992cca( self.keyring[ index ].lootid );
        common_item::function_61c2c0251e742ffd( itembundle, self.keyring[ index ].quantity, spawnoptions );
    }
    
    self.keyring[ index ] = undefined;
    
    if ( isint( index ) )
    {
        function_cdc669dbc8ea2101( self.keyring );
    }
    
    for ( i = 0; i < maxkeys ; i++ )
    {
        lootid = isdefined( self.keyring[ i ] ) ? self.keyring[ i ].lootid : 0;
        self setclientomnvar( "ui_key_slot_" + i, lootid );
    }
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0xe06638df, Offset: 0x35ea
// Size: 0x8f
function function_935aeab40494aefc()
{
    cache = self;
    
    if ( isent( self ) && isplayer( self ) )
    {
        cache = self.var_50f741a14f09a6;
    }
    
    if ( !cache.inventorygroup )
    {
        return [ function_dffd0ba870098fc5( level.gametypebundle.var_4a2c11daec7f271 ), level.gametypebundle.var_4a2c11daec7f271 ];
    }
    
    return [ cache.inventorygroup, cache.inventorygroupname ];
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0xf5b86c31, Offset: 0x3682
// Size: 0x20e
function function_98cc7d797d834288( fromrow, fromcolumn, affectall, extradata )
{
    cache = self;
    player = undefined;
    
    if ( isent( self ) && isplayer( self ) )
    {
        cache = self.var_50f741a14f09a6;
        player = self;
    }
    
    if ( !cache )
    {
        return;
    }
    
    [ containerbundle, _ ] = function_935aeab40494aefc();
    index = function_7539b7a73a2ba0b2( containerbundle, fromrow, fromcolumn );
    lootid = 0;
    quantity = 0;
    containeritem = undefined;
    weapondata = undefined;
    
    if ( cache.playercontents )
    {
        lootid = common_cache::function_ba4d200a60da538( cache, player, index );
        quantity = common_cache::function_e401c34a0cb32886( cache, player, index );
        containeritem = common_cache::function_d02799be7103ba5c( cache, player, index );
        weapondata = common_cache::function_8cdc917b25e97bed( cache, player, index );
    }
    else
    {
        lootid = common_cache::function_8a794a103f67b684( cache, index );
        quantity = common_cache::function_8fcbeea1c8dee7fe( cache, index );
        containeritem = common_cache::function_e3c66d2777a7f9e8( cache, index );
        weapondata = common_cache::function_79205ff2572aa19b( cache, index );
    }
    
    if ( lootid == 0 || quantity == 0 )
    {
        return;
    }
    
    itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( !itembundlename )
    {
        assertmsg( "<dev string:xbb>" + lootid + "<dev string:xee>" );
        return;
    }
    
    itembundle = getscriptbundle( itembundlename );
    var_d602659d21376d75 = function_17c174dc1ef34e6b( affectall, itembundle, quantity );
    item = undefined;
    
    if ( cache.var_bfb964dc17a2982c )
    {
        item = common_item::function_a48ae6cbf7e8c2d5( cache );
        item.var_bfb964dc17a2982c = cache.var_bfb964dc17a2982c;
    }
    else
    {
        item = common_item::function_77600f92048df72d( itembundle, var_d602659d21376d75, undefined, 20, index, containeritem, weapondata );
    }
    
    item.fromcache = 1;
    item.cache = cache;
    return item;
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0x851505d1, Offset: 0x3899
// Size: 0x237
function function_9c8691b495da38ea( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    cache = self;
    player = undefined;
    
    if ( isent( self ) && isplayer( self ) )
    {
        cache = self.var_50f741a14f09a6;
        player = self;
    }
    
    if ( !cache )
    {
        return {};
    }
    
    itemname = common_item::function_33a2c00e46263d99( item );
    lootid = common_item::function_b01955b20c77371d( itemname );
    typeref = common_item::function_9deb822f286163b1( lootid );
    quantity = item.count;
    
    if ( quantity == 0 || lootid == 0 )
    {
        itemname = undefined;
        lootid = 0;
        quantity = 0;
    }
    
    if ( function_b4a381d24198d6cd( torow, tocolumn ) )
    {
        quantityused = common_cache::cache_additem( cache, itemname, quantity, !isent( self ) || !isplayer( self ), player, item, undefined, 1 );
        
        if ( quantityused > 0 )
        {
            level callback::callback( #"hash_47d8289e20141bc6", { #container:cache, #quantity:quantity, #itemlootid:lootid, #player:player } );
        }
        
        return function_e3a3a47f88474ba4( quantityused, 0, undefined, undefined, undefined, typeref == "weapon" );
    }
    
    [ containerbundle, _ ] = function_935aeab40494aefc();
    index = function_7539b7a73a2ba0b2( containerbundle, torow, tocolumn );
    
    if ( player && player::isreallyalive( player ) )
    {
        common_cache::function_25bee1f5701a0786( player, index, lootid, quantity, undefined, item );
    }
    
    if ( quantity > 0 )
    {
        level callback::callback( #"hash_47d8289e20141bc6", { #container:cache, #quantity:quantity, #itemlootid:lootid, #player:player } );
    }
    
    return function_e3a3a47f88474ba4( quantity, 0, undefined, undefined, undefined, typeref == "weapon" );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0xe2e7969d, Offset: 0x3ad9
// Size: 0x5bb
function function_9181f6aad93f999d( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    cache = self;
    player = undefined;
    
    if ( isent( self ) && isplayer( self ) )
    {
        cache = self.var_50f741a14f09a6;
        player = self;
    }
    
    if ( !cache )
    {
        return;
    }
    
    [ containerbundle, _ ] = function_935aeab40494aefc();
    index = function_7539b7a73a2ba0b2( containerbundle, fromrow, fromcolumn );
    lootid = 0;
    quantity = 0;
    containeritem = undefined;
    weapondata = undefined;
    
    if ( cache.playercontents )
    {
        lootid = common_cache::function_ba4d200a60da538( cache, player, index );
        quantity = common_cache::function_e401c34a0cb32886( cache, player, index );
        containeritem = common_cache::function_d02799be7103ba5c( cache, player, index );
        weapondata = common_cache::function_8cdc917b25e97bed( cache, index );
    }
    else
    {
        lootid = common_cache::function_8a794a103f67b684( cache, index );
        quantity = common_cache::function_8fcbeea1c8dee7fe( cache, index );
        containeritem = common_cache::function_e3c66d2777a7f9e8( cache, index );
        weapondata = common_cache::function_79205ff2572aa19b( cache, index );
    }
    
    lootidtaken = lootid;
    newquantity = quantity - quantityused;
    
    if ( ( togroup == 2 || togroup == 4 ) && common_inventory::function_5a70e09721a21568() && toitem && newquantity <= 0 )
    {
        toitembundle = common_item::function_6b8ff3d5f2688336( toitem );
        tolootid = common_item::function_779887309ec71dfe( toitembundle );
        typeref = common_item::function_9deb822f286163b1( lootid );
        toitemtype = common_item::function_16e8c106491eeaca( toitembundle );
        
        if ( ( tolootid != lootid || !common_item::function_bfd517bdc8850ea6( typeref, toitembundle ) ) && toitemtype != "currency" )
        {
            remainder = common_inventory::inventory_additemtobackpack( toitembundle, toitem.count, toitem );
            
            if ( remainder > 0 )
            {
                toitem.count = remainder;
                shoulddrop = 1;
            }
        }
    }
    
    if ( shoulddrop )
    {
        var_920f451943144b23 = quantityused;
        itembundlename = undefined;
        additionaldata = undefined;
        weaponobj = undefined;
        
        if ( toitem )
        {
            itembundlename = common_item::function_33a2c00e46263d99( toitem );
            var_920f451943144b23 = toitem.count;
            additionaldata = toitem.additionaldata;
            weaponobj = toitem.weaponobj;
            
            if ( !weaponobj && toitem.var_6828becb300b1c44 )
            {
                weaponobj = item_weapon::function_849a34281f9996f1( toitem.var_6828becb300b1c44 );
            }
        }
        else
        {
            itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
            additionaldata = function_172046f8819425a6( 1, index );
            
            if ( weapondata )
            {
                weaponobj = item_weapon::function_31562a2fb3df68d5( weapondata );
            }
        }
        
        if ( !isvector( cache.angles ) )
        {
            var_8d07dcbf9dd1782d = vectornormalize2( self.origin - cache.origin );
            anglestoplayer = vectortoangles( var_8d07dcbf9dd1782d );
            cache.angles = anglestoplayer;
        }
        
        [ baseorigin, _ ] = common_cache::function_9d11bc7908a66f11( cache );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( baseorigin, cache.angles );
        spawnoptions.weapon = weaponobj;
        spawnoptions.additionaldata = additionaldata;
        spawnoptions.ignoreents = [ cache ];
        
        if ( level.var_14030c25357c4890[ itembundlename ] )
        {
            spawnoptions = self [[ level.var_14030c25357c4890[ itembundlename ] ]]( spawnoptions );
        }
        
        common_item::function_61c2c0251e742ffd( itembundlename, var_920f451943144b23, spawnoptions );
    }
    
    if ( newquantity == 0 && lootid != 0 )
    {
        var_70107ba24ea06c27 = undefined;
        var_1ad5f8b793f2a815 = 0;
        
        foreach ( pingdata in cache.var_488526e1eed488ac )
        {
            if ( pingdata.lootid == lootid )
            {
                var_1ad5f8b793f2a815++;
                
                if ( var_1ad5f8b793f2a815 > 1 )
                {
                    break;
                }
                
                var_70107ba24ea06c27 = pingdata;
            }
        }
        
        if ( var_1ad5f8b793f2a815 == 1 )
        {
            var_70107ba24ea06c27.pingowner calloutmarkerping::function_7c0ee9d4b604e6d6( var_70107ba24ea06c27.pingindex );
        }
    }
    
    if ( newquantity == 0 || lootid == 0 )
    {
        lootid = 0;
        newquantity = 0;
        containeritem = undefined;
    }
    
    if ( player )
    {
        if ( !isstruct( cache ) && cache getscriptableisloot() && newquantity != cache.count )
        {
            var_56c576ebd3fe3c3 = common_item::function_6b8ff3d5f2688336( cache );
            cacheitemtype = common_item::function_16e8c106491eeaca( var_56c576ebd3fe3c3 );
            
            if ( cacheitemtype != "cache" )
            {
                if ( newquantity == 0 )
                {
                    common_cache::function_25bee1f5701a0786( player, index, lootid, newquantity, undefined, containeritem );
                    player common_cache::function_df8b3ab8ce2209e7( 1 );
                    return;
                }
                
                cache.count = newquantity;
                common_item::function_9d4ae27b4634d928( cache, var_56c576ebd3fe3c3, 1 );
                return;
            }
        }
        
        if ( player::isreallyalive( player ) )
        {
            common_cache::function_25bee1f5701a0786( player, index, lootid, newquantity, undefined, containeritem );
        }
    }
    
    common_cache::function_df8b3ab8ce2209e7( 1, undefined, lootidtaken );
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x273ada8, Offset: 0x409c
// Size: 0x9c
function function_e704cb5db69835c4( backpackbundle )
{
    securegroup = backpackbundle.var_95e3f807f83ea1b6 ?? level.gametypebundle.var_bf7ad50d738c49d5;
    
    if ( isdefined( self.perks[ "specialty_trait_backpack_extra_secure" ] ) )
    {
        securegroup = backpackbundle.var_e45590dce701e056 ?? securegroup;
    }
    
    if ( hasomnvar( "ui_secure_group" ) )
    {
        groupindex = function_93b951c93e339754( "SECURE", securegroup ) + 1;
        self setclientomnvar( "ui_secure_group", groupindex );
    }
    
    self.securegroup = securegroup;
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0xd75b06e8, Offset: 0x4140
// Size: 0x4f
function function_ecbef11f7cab32fa()
{
    if ( !self.securegroup )
    {
        return [];
    }
    
    var_f5a8e77f6726a2a9 = self.securegroup ?? level.gametypebundle.var_bf7ad50d738c49d5;
    return [ function_dffd0ba870098fc5( var_f5a8e77f6726a2a9 ), var_f5a8e77f6726a2a9 ];
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0xad6f2d65, Offset: 0x4198
// Size: 0x1b2
function function_26e8d89c0e534760( fromrow, fromcolumn, affectall, extradata )
{
    if ( !self.securecase )
    {
        return;
    }
    
    securelootid = undefined;
    securequantity = undefined;
    secureindex = undefined;
    
    if ( function_b4a381d24198d6cd( fromrow, fromcolumn ) )
    {
        foreach ( index, datastruct in self.securecase )
        {
            secureindex = index;
            securelootid = datastruct.lootid;
            securequantity = datastruct.quantity;
        }
    }
    else
    {
        [ groupbundle, _ ] = function_ecbef11f7cab32fa();
        secureindex = function_7539b7a73a2ba0b2( groupbundle, fromrow, fromcolumn );
        securelootid = isdefined( self.securecase[ secureindex ] ) ? self.securecase[ secureindex ].lootid : undefined;
        securequantity = isdefined( self.securecase[ secureindex ] ) ? self.securecase[ secureindex ].quantity : undefined;
    }
    
    if ( !securelootid || !isdefined( secureindex ) )
    {
        return;
    }
    
    itembundle = common_item::function_b202b16941992cca( securelootid );
    return common_item::function_77600f92048df72d( itembundle, securequantity, undefined, 5, secureindex );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0x21b31add, Offset: 0x4353
// Size: 0x189
function function_41fe07e971a7e566( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    if ( !isdefined( self.securecase ) )
    {
        self.securecase = [];
    }
    
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    [ securegroup, _ ] = function_ecbef11f7cab32fa();
    index = undefined;
    
    if ( function_b4a381d24198d6cd( torow, tocolumn ) )
    {
        index = function_76928b4f093ca1ad( 5, itembundle, 1, item );
    }
    else
    {
        index = function_7539b7a73a2ba0b2( securegroup, torow, tocolumn );
    }
    
    if ( !isdefined( index ) )
    {
        return function_e3a3a47f88474ba4( 0, 0 );
    }
    
    if ( !hasomnvar( "ui_secure_slot_" + index ) )
    {
        return function_e3a3a47f88474ba4( 0, 0 );
    }
    
    lootid = common_item::function_6d301ac91c3cd13d( item );
    
    if ( !lootid )
    {
        return function_e3a3a47f88474ba4( 0, 0 );
    }
    
    self.securecase[ index ] = { #quantity:item.count, #lootid:lootid };
    self setclientomnvar( "ui_secure_slot_" + index, lootid );
    self setclientomnvar( "ui_secure_slot_count_" + index, item.count );
    return function_e3a3a47f88474ba4( item.count, 0 );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0xbc7ddd98, Offset: 0x44e5
// Size: 0x1ba
function function_75c026e08d6e49d3( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    if ( !self.securecase )
    {
        return;
    }
    
    [ securegroup, _ ] = function_ecbef11f7cab32fa();
    index = undefined;
    var_3e8f826139ed4001 = function_19a5a29f5cd0df45( securegroup );
    
    if ( function_b4a381d24198d6cd( fromrow, fromcolumn ) )
    {
        for ( i = 0; i < var_3e8f826139ed4001 ; i++ )
        {
            if ( !self.securecase[ i ] )
            {
                index = i;
                break;
            }
        }
    }
    else
    {
        index = function_7539b7a73a2ba0b2( securegroup, fromrow, fromcolumn );
    }
    
    if ( !isdefined( index ) || !self.securecase[ index ] || !self.securecase[ index ].lootid )
    {
        return;
    }
    
    if ( shoulddrop )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        itembundle = common_item::function_b202b16941992cca( self.securecase[ index ].lootid );
        common_item::function_61c2c0251e742ffd( itembundle, self.securecase[ index ].quantity, spawnoptions );
    }
    
    self.securecase[ index ] = undefined;
    self setclientomnvar( "ui_secure_slot_" + index, 0 );
    self setclientomnvar( "ui_secure_slot_count_" + index, 0 );
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x438fe187, Offset: 0x46a7
// Size: 0x40
function function_32dd7330c1c8b764( team )
{
    if ( !teams::function_b00ab7e503f33379( self.team, "questItems" ) )
    {
        teams::setteamdata( team, "questItems", [] );
    }
    
    return teams::getteamdata( team, "questItems" );
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0xb9bfec91, Offset: 0x46f0
// Size: 0xad
function function_c81b3c1810b022de( team, item )
{
    questitemdata = function_32dd7330c1c8b764( team );
    
    foreach ( questitem in questitemdata )
    {
        if ( questitem.type == item.type )
        {
            return 1;
        }
    }
}

// Namespace common_inventory_groups
// Params 3, eflags: 0x4
// Checksum 0xc28ea79, Offset: 0x47a5
// Size: 0x96
function private function_c1e2ea8f7fb8b4b0( team, item, index )
{
    questitemdata = function_32dd7330c1c8b764( self.team ) ?? [];
    
    if ( !isdefined( index ) )
    {
        questitemdata[ questitemdata.size ] = item;
    }
    else
    {
        questitemdata[ index ] = item;
    }
    
    teams::setteamdata( team, "questItems", questitemdata );
    lootid = common_item::function_6d301ac91c3cd13d( item );
    
    if ( isdefined( lootid ) && hasomnvar( "ui_quest_item_lootid" ) )
    {
        self setclientomnvar( "ui_quest_item_lootid", lootid );
    }
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x9f1fc4c5, Offset: 0x4843
// Size: 0xd
function function_f5e1c6cea41a1a13()
{
    return function_27fe7c6ba0ffc55c( "QUEST" );
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0x4a04b6b, Offset: 0x4859
// Size: 0xd6
function function_fc6f05b5daf4d44d( fromrow, fromcolumn, affectall, extradata )
{
    [ questgroup, _ ] = function_f5e1c6cea41a1a13();
    
    if ( !questgroup )
    {
        return;
    }
    
    questitemdata = function_32dd7330c1c8b764( self.team ) ?? [];
    
    if ( !questitemdata )
    {
        return;
    }
    
    index = function_7539b7a73a2ba0b2( questgroup, fromrow, fromcolumn );
    
    if ( !questitemdata[ index ] )
    {
        return;
    }
    
    item = questitemdata[ index ];
    itemname = common_item::function_33a2c00e46263d99( item );
    return common_item::function_77600f92048df72d( itemname, item.count, undefined, 7, index, item );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0xe56c514f, Offset: 0x4938
// Size: 0x120
function function_b987142c4b5e97af( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    [ questgroup, _ ] = function_f5e1c6cea41a1a13();
    
    if ( !questgroup )
    {
        return;
    }
    
    index = undefined;
    
    if ( !function_b4a381d24198d6cd( torow, tocolumn ) )
    {
        index = function_7539b7a73a2ba0b2( questgroup, torow, tocolumn );
    }
    
    itemname = common_item::function_33a2c00e46263d99( item );
    var_abc379aa0df5f77d = common_item::function_77600f92048df72d( itemname, item.count, undefined, 7, index, item );
    level notify( "quest_item_pickup_" + self.team, itemname );
    function_c1e2ea8f7fb8b4b0( self.team, var_abc379aa0df5f77d, index );
    common_item::function_e70f64f8d4664b9e( self, item, item.count, 1 );
    return function_e3a3a47f88474ba4( 1, 0 );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0xc7c3ec7f, Offset: 0x4a61
// Size: 0xfb
function function_370d4f4c8ad12928( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    [ questgroup, _ ] = function_f5e1c6cea41a1a13();
    
    if ( !questgroup )
    {
        return;
    }
    
    questitemdata = function_32dd7330c1c8b764( self.team );
    
    if ( !questitemdata )
    {
        return;
    }
    
    index = function_7539b7a73a2ba0b2( questgroup, fromrow, fromcolumn );
    
    if ( !questitemdata[ index ] )
    {
        return;
    }
    
    questitemdata[ index ] = undefined;
    
    if ( isint( index ) )
    {
        function_cdc669dbc8ea2101( questitemdata );
    }
    
    teams::setteamdata( self.team, "questItems", questitemdata );
}

// Namespace common_inventory_groups
// Params 0
// Checksum 0x98c2b6f8, Offset: 0x4b64
// Size: 0x65
function function_f8c75ac0ed477595()
{
    if ( self.utilitygroup )
    {
        return [ function_dffd0ba870098fc5( self.utilitygroup ), self.utilitygroup ];
    }
    
    return [ function_dffd0ba870098fc5( level.gametypebundle.var_c21048bab8b27f00 ), level.gametypebundle.var_c21048bab8b27f00 ];
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0xedcdf4f4, Offset: 0x4bd2
// Size: 0xe7
function function_b484c980606c1d2f( fromrow, fromcolumn, affectall, extradata )
{
    [ utilitygroup, _ ] = function_f8c75ac0ed477595();
    [ callbacks, typeref, var_8fb8e1fb220cca48 ] = function_98333f94074fd38e( utilitygroup, fromrow, fromcolumn );
    
    if ( !callbacks || !var_8fb8e1fb220cca48 )
    {
        return;
    }
    
    index = function_7539b7a73a2ba0b2( utilitygroup, fromrow, fromcolumn );
    count = var_8fb8e1fb220cca48.count ?? 1;
    return common_item::function_77600f92048df72d( var_8fb8e1fb220cca48.name, count, undefined, 4, index );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0x613e67c, Offset: 0x4cc2
// Size: 0x1bf
function function_b5139dcd34f5e71d( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn )
{
    row = torow;
    column = tocolumn;
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    [ utilitygroup, _ ] = function_f8c75ac0ed477595();
    
    if ( !utilitygroup )
    {
        return {};
    }
    
    if ( function_b4a381d24198d6cd( torow, tocolumn ) )
    {
        index = function_76928b4f093ca1ad( 4, itembundle, 1, item );
        [ row, column ] = function_12ee5af12df204b4( utilitygroup, index );
        
        if ( !isdefined( row ) || !isdefined( column ) )
        {
            return {};
        }
    }
    
    currentitem = function_b484c980606c1d2f( row, column, 1 );
    quantityused = common_item::function_2b5e2ff57d5f392( item );
    newindex = function_e7c426ab761c55e4( fromgroup, itembundle );
    newrow = undefined;
    newcolumn = undefined;
    
    if ( isdefined( newindex ) )
    {
        fromfuncs = function_987405ff5ee23e99( fromgroup );
        [ var_7998ff0179c853b1, _ ] = self [[ fromfuncs.var_65a6f7922d118cdd ]]();
        [ newrow, newcolumn ] = function_12ee5af12df204b4( var_7998ff0179c853b1, newindex );
    }
    
    return function_e3a3a47f88474ba4( quantityused, 0, currentitem, newrow, newcolumn );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0xf940deff, Offset: 0x4e8a
// Size: 0x197
function function_86624a4bfa9b4bfa( quantityused, shoulddrop, fromrow, fromcolumn, toitem, torow, tocolumn, togroup, affectall, extradata )
{
    [ utilitygroup, _ ] = function_f8c75ac0ed477595();
    [ callbacks, typeref, var_8fb8e1fb220cca48 ] = function_98333f94074fd38e( utilitygroup, fromrow, fromcolumn );
    
    if ( !callbacks.funcs[ #"removecurrent" ] || !callbacks.funcs[ #"getcurrent" ] )
    {
        return;
    }
    
    self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #count:quantityused } );
    index = function_7539b7a73a2ba0b2( utilitygroup, fromrow, fromcolumn );
    
    if ( shoulddrop && var_8fb8e1fb220cca48 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        additionaldata = function_172046f8819425a6( 4, index );
        spawnoptions.additionaldata = additionaldata;
        common_item::function_61c2c0251e742ffd( var_8fb8e1fb220cca48.name, quantityused, spawnoptions );
        return;
    }
    
    function_172046f8819425a6( 4, index );
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0xcefdd7f5, Offset: 0x5029
// Size: 0x150
function function_12ee5af12df204b4( inventorygroup, index )
{
    if ( !isdefined( index ) )
    {
        assert( "<dev string:x14a>" );
        return;
    }
    
    if ( inventorygroup && inventorygroup.inventorygroupname && level.var_d21f4ee5c0bf65b && level.var_d21f4ee5c0bf65b[ inventorygroup.inventorygroupname ] )
    {
        cache = level.var_d21f4ee5c0bf65b[ inventorygroup.inventorygroupname ];
        
        if ( index >= 0 && index < cache.totalslots )
        {
            return [ cache.var_fa5d5f5b62e33b29[ index ], cache.var_5ed9c2bbb4ba22c9[ index ] ];
        }
    }
    
    column = index;
    row = 0;
    
    for ( i = inventorygroup.buttonrows.size - 1; i >= 0 ; i-- )
    {
        grouprow = inventorygroup.buttonrows[ i ];
        
        if ( column < grouprow.buttoncolumns.size )
        {
            row = i;
            break;
        }
        
        column -= grouprow.buttoncolumns.size;
    }
    
    return [ row, column ];
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0xba15276, Offset: 0x5182
// Size: 0x169
function function_7539b7a73a2ba0b2( inventorygroup, row, column )
{
    if ( !inventorygroup || !isdefined( row ) || !isdefined( column ) )
    {
        return;
    }
    
    if ( inventorygroup.inventorygroupname && level.var_d21f4ee5c0bf65b && level.var_d21f4ee5c0bf65b[ inventorygroup.inventorygroupname ] )
    {
        cache = level.var_d21f4ee5c0bf65b[ inventorygroup.inventorygroupname ];
        
        if ( row >= 0 && row < cache.numrows )
        {
            return ( cache.var_b4a83925861e3298[ row ] + column );
        }
    }
    
    index = 0;
    maxrows = ( function_167305faa8e9aa3( inventorygroup ) ?? 2 ) - 1;
    
    foreach ( i, grouprow in inventorygroup.buttonrows )
    {
        if ( i == maxrows - row )
        {
            return ( index + column );
        }
        
        index += grouprow.buttoncolumns.size;
    }
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x7b9f76ad, Offset: 0x52f3
// Size: 0xc5
function function_a8f87e5f5f340e9f( inventorygroup )
{
    ans = [];
    
    if ( !inventorygroup.buttonrows )
    {
        return ans;
    }
    
    index = 0;
    
    for ( i = inventorygroup.buttonrows.size - 1; i >= 0 ; i-- )
    {
        row = inventorygroup.buttonrows[ i ];
        
        for ( j = 0; j < row.buttoncolumns.size ; j++ )
        {
            ans[ index ] = function_ec48255a23c8526f( function_62e8f7d021e6a61e( inventorygroup, i, j ) );
            ans[ index ].index = index;
            index += 1;
        }
    }
    
    return ans;
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0x95c6087f, Offset: 0x53c1
// Size: 0x58
function function_b3ca90137cf3cd0( player, row, column )
{
    [ backpackgroup, _ ] = player function_c27ac785b5373b73();
    return function_7539b7a73a2ba0b2( backpackgroup, row, column );
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x141556d7, Offset: 0x5422
// Size: 0x7d
function function_313be7104bf0b01e( packedval )
{
    assert( isdefined( packedval ), "<dev string:x1f6>" );
    var_c726c50d3c76b3de = [];
    var_c726c50d3c76b3de[ 0 ] = packedval & 1;
    var_c726c50d3c76b3de[ 1 ] = packedval >> 1 & 1;
    mask = 31;
    packedval >>= 2;
    
    for ( i = 0; i < 6 ; i++ )
    {
        var_c726c50d3c76b3de[ var_c726c50d3c76b3de.size ] = packedval >> i * 5 & mask;
    }
    
    return var_c726c50d3c76b3de;
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0xdbe73be6, Offset: 0x54a8
// Size: 0xeb
function function_27fe7c6ba0ffc55c( grouptype, var_82adb5d59536cf0e )
{
    if ( !level.inventorygroupings || !level.inventorygroupings[ grouptype ] )
    {
        return [];
    }
    
    var_4e5913e9d4dfcb31 = undefined;
    
    foreach ( bundlename, entry in level.inventorygroupings[ grouptype ] )
    {
        if ( var_82adb5d59536cf0e )
        {
            if ( var_82adb5d59536cf0e == bundlename )
            {
                var_4e5913e9d4dfcb31 = bundlename;
                break;
            }
            
            continue;
        }
        
        var_4e5913e9d4dfcb31 = bundlename;
        break;
    }
    
    if ( !var_4e5913e9d4dfcb31 )
    {
        return [];
    }
    
    return [ function_dffd0ba870098fc5( var_4e5913e9d4dfcb31 ), var_4e5913e9d4dfcb31 ];
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xd093649c, Offset: 0x559c
// Size: 0xd4
function function_dffd0ba870098fc5( inventorygroupname )
{
    if ( !inventorygroupname )
    {
        return;
    }
    
    if ( !isdefined( level.var_f228d668d98a50d9 ) )
    {
        level.var_f228d668d98a50d9 = [];
    }
    
    var_7237854e3be197ca = level.var_f228d668d98a50d9[ inventorygroupname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    group = getscriptbundlefieldvalues( inventorygroupname, [ #"buttonrows", #"groupid", #"hash_149871376ad9c1", #"vehicleref", #"hash_9897c6ff2eccb24c", #"variants", #"hash_6aefd7cce71a2c40" ] );
    group.inventorygroupname = inventorygroupname;
    level.var_f228d668d98a50d9[ inventorygroupname ] = group;
    return group;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x46a327aa, Offset: 0x5679
// Size: 0x28
function function_167305faa8e9aa3( inventorygroupbundle )
{
    if ( !inventorygroupbundle.buttonrows )
    {
        return;
    }
    
    return inventorygroupbundle.buttonrows.size;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xf32cb924, Offset: 0x56aa
// Size: 0x107
function function_19a5a29f5cd0df45( inventorygroupbundle )
{
    if ( !inventorygroupbundle )
    {
        return;
    }
    
    if ( inventorygroupbundle.inventorygroupname && level.var_d21f4ee5c0bf65b && level.var_d21f4ee5c0bf65b[ inventorygroupbundle.inventorygroupname ] )
    {
        return level.var_d21f4ee5c0bf65b[ inventorygroupbundle.inventorygroupname ].totalslots;
    }
    
    if ( !inventorygroupbundle.buttonrows )
    {
        return;
    }
    
    total = 0;
    
    foreach ( row in inventorygroupbundle.buttonrows )
    {
        total += row.buttoncolumns.size;
    }
    
    return total;
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0xf15a5db6, Offset: 0x57ba
// Size: 0x14a
function function_62e8f7d021e6a61e( inventorygroup, row, column )
{
    buttondefinition = inventorygroup.buttonrows[ row ].buttoncolumns[ column ].buttondef;
    
    if ( !isdefined( buttondefinition ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_7bea5e48d4bd4ecc ) )
    {
        level.var_7bea5e48d4bd4ecc = [];
    }
    
    var_fa3144b8c2e26739 = level.var_7bea5e48d4bd4ecc[ inventorygroup.groupid ][ buttondefinition ];
    var_7237854e3be197ca = var_fa3144b8c2e26739;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_fa3144b8c2e26739 = getscriptbundlefieldvalues( buttondefinition, [ #"alloweditemtypes", #"blockeditemtypes", #"alloweditems", #"maxquantity", #"hash_d37e6e58dd146484", #"craftcost", #"hash_4132cc9bbda9dded", #"hash_46cc99785759e437", #"hash_f375ebc6f410969f", #"enablegroupasset" ] );
    level.var_7bea5e48d4bd4ecc[ inventorygroup.groupid ][ buttondefinition ] = var_fa3144b8c2e26739;
    return var_fa3144b8c2e26739;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x9a8bce7, Offset: 0x590d
// Size: 0xf3
function function_ec48255a23c8526f( buttondefinition )
{
    alloweditemtypes = buttondefinition.alloweditemtypes ?? [];
    blockeditemtypes = buttondefinition.blockeditemtypes ?? [];
    alloweditems = buttondefinition.alloweditems ?? [];
    return { #enablegroupasset:buttondefinition.enablegroupasset, #var_c6448e733a67923e:buttondefinition.var_c6448e733a67923e, #var_12d4ede7ad63e670:buttondefinition.var_12d4ede7ad63e670, #var_209a9ddd0970710e:buttondefinition.var_209a9ddd0970710e, #craftcost:buttondefinition.craftcost, #maxquantity:buttondefinition.maxquantity, #alloweditems:alloweditems, #blockeditemtypes:blockeditemtypes, #alloweditemtypes:alloweditemtypes };
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0x8cca79ed, Offset: 0x5a09
// Size: 0x8b, Type: bool
function function_1cc3abea66bf8801( inventorygroup, row, column )
{
    buttondefinition = function_62e8f7d021e6a61e( inventorygroup, row, column );
    
    if ( !buttondefinition )
    {
        return false;
    }
    
    typedata = function_ec48255a23c8526f( buttondefinition );
    
    if ( typedata.alloweditemtypes.size > 0 )
    {
        return ( getscriptbundlefieldvalue( typedata.alloweditemtypes[ 0 ].itemtype, #"typeref" ) == "currency" );
    }
    
    return false;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xbebbe9f, Offset: 0x5a9d
// Size: 0xad
function function_d6c9fa5cafe81453( groupid )
{
    if ( !isdefined( groupid ) )
    {
        return;
    }
    
    if ( !level.inventorygroupings || !level.inventorygroupings[ groupid ] )
    {
        return;
    }
    
    foreach ( bundlename, index in level.inventorygroupings[ groupid ] )
    {
        return getscriptbundle( bundlename );
    }
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x62729b37, Offset: 0x5b52
// Size: 0x70
function function_93b951c93e339754( groupid, bundlename )
{
    if ( !isdefined( groupid ) || !bundlename )
    {
        return 0;
    }
    
    if ( !level.inventorygroupings || !level.inventorygroupings[ groupid ] || !level.inventorygroupings[ groupid ][ bundlename ] )
    {
        return 0;
    }
    
    return level.inventorygroupings[ groupid ][ bundlename ].index;
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x68af96fa, Offset: 0x5bcb
// Size: 0x6e
function function_6e8756548142d338( groupid, bundlename )
{
    if ( !isdefined( groupid ) || !bundlename )
    {
        return;
    }
    
    if ( !level.inventorygroupings || !level.inventorygroupings[ groupid ] || !level.inventorygroupings[ groupid ][ bundlename ] )
    {
        return;
    }
    
    return level.inventorygroupings[ groupid ][ bundlename ].sortedslots;
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0xeb3b1fd1, Offset: 0x5c42
// Size: 0x357, Type: bool
function function_79e2c2087aa7de1e( itembundle, typedata, bundlelootid = common_item::function_779887309ec71dfe( itembundle ), itemtype )
{
    foreach ( alloweditem in typedata.alloweditems )
    {
        if ( !isdefined( alloweditem.lootid ) )
        {
            alloweditem.lootid = common_item::function_b01955b20c77371d( alloweditem.itemspawnentry );
        }
        
        if ( bundlelootid === alloweditem.lootid )
        {
            return true;
        }
    }
    
    if ( !isdefined( itemtype ) )
    {
        itemtype = common_item::function_16e8c106491eeaca( itembundle );
    }
    
    assert( itemtype == common_item::function_16e8c106491eeaca( itembundle ), "<dev string:x224>" );
    var_216bd00d4dbf4e02 = itembundle.subtype != "";
    
    foreach ( blockedtype in typedata.blockeditemtypes )
    {
        if ( blockedtype.itemtype )
        {
            if ( !isdefined( blockedtype.typeref ) )
            {
                blockedtype.typeref = getscriptbundlefieldvalue( blockedtype.itemtype, "typeRef" );
            }
            
            if ( blockedtype.typeref != "" && itemtype == blockedtype.typeref )
            {
                return false;
            }
        }
        
        if ( var_216bd00d4dbf4e02 && blockedtype.subtype != "" && itembundle.subtype == blockedtype.subtype )
        {
            return false;
        }
    }
    
    foreach ( allowedtype in typedata.alloweditemtypes )
    {
        if ( allowedtype.itemtype )
        {
            if ( !isdefined( allowedtype.typeref ) )
            {
                allowedtype.typeref = getscriptbundlefieldvalue( allowedtype.itemtype, "typeRef" );
            }
            
            if ( allowedtype.typeref != "" && ( allowedtype.typeref == "generic" || allowedtype.typeref == itemtype ) )
            {
                return true;
            }
        }
        
        if ( var_216bd00d4dbf4e02 && allowedtype.subtype != "" && allowedtype.subtype == itembundle.subtype )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace common_inventory_groups
// Params 5
// Checksum 0x1956da4, Offset: 0x5fa2
// Size: 0x6f, Type: bool
function function_f25fea162932fee( itembundle, inventorygroup, row, column, bundlelootid )
{
    if ( !inventorygroup_enabled() )
    {
        return true;
    }
    
    buttondefinition = function_62e8f7d021e6a61e( inventorygroup, row, column );
    typedata = function_ec48255a23c8526f( buttondefinition );
    return function_79e2c2087aa7de1e( itembundle, typedata, bundlelootid );
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0x2a85c2f9, Offset: 0x601a
// Size: 0x83, Type: bool
function function_d9dc48ec3cc713b4( itembundle, inventorygroup, index, bundlelootid )
{
    if ( !inventorygroup_enabled() )
    {
        return true;
    }
    
    [ row, column ] = function_12ee5af12df204b4( inventorygroup, index );
    
    if ( !isdefined( row ) || !isdefined( column ) )
    {
        return false;
    }
    
    return function_f25fea162932fee( itembundle, inventorygroup, row, column, bundlelootid );
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0xb2233f73, Offset: 0x60a6
// Size: 0x13a
function function_9cfb83fd532b7894( itembundle, inventorygroup, backpacksize, bundlelootid )
{
    result = [];
    validationcache = [];
    
    if ( !isdefined( bundlelootid ) )
    {
        bundlelootid = common_item::function_779887309ec71dfe( itembundle );
    }
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        [ row, column ] = function_12ee5af12df204b4( inventorygroup, i );
        
        if ( !isdefined( row ) || !isdefined( column ) )
        {
            continue;
        }
        
        buttondefinition = function_62e8f7d021e6a61e( inventorygroup, row, column );
        var_9453cac265cb1d4c = inventorygroup.buttonrows[ row ].buttoncolumns[ column ].buttondef;
        
        if ( isdefined( validationcache[ var_9453cac265cb1d4c ] ) )
        {
            if ( validationcache[ var_9453cac265cb1d4c ] )
            {
                result[ i ] = buttondefinition;
            }
            
            continue;
        }
        
        typedata = function_ec48255a23c8526f( buttondefinition );
        isvalid = function_79e2c2087aa7de1e( itembundle, typedata, bundlelootid );
        validationcache[ var_9453cac265cb1d4c ] = isvalid;
        
        if ( isvalid )
        {
            result[ i ] = buttondefinition;
        }
    }
    
    return result;
}

// Namespace common_inventory_groups
// Params 6
// Checksum 0x5426c04e, Offset: 0x61e9
// Size: 0x366
function function_76928b4f093ca1ad( groupindex, itembundle, var_c6cbb69e3515edb2 = 0, item, inventorygroup, inventorygroupname )
{
    funcs = function_987405ff5ee23e99( groupindex );
    
    if ( !( isdefined( inventorygroup ) && isdefined( inventorygroupname ) ) )
    {
        [ inventorygroup, inventorygroupname ] = self [[ funcs.var_65a6f7922d118cdd ]]();
    }
    
    if ( !inventorygroup )
    {
        return;
    }
    
    slots = function_6e8756548142d338( function_b353a43484c9827f( groupindex ), inventorygroupname );
    
    if ( !slots )
    {
        return;
    }
    
    bundlelootid = common_item::function_779887309ec71dfe( itembundle );
    bundletype = common_item::function_16e8c106491eeaca( itembundle );
    
    if ( bundletype == "weapon" && ( groupindex === 2 || groupindex === 1 ) )
    {
        weaponobj = isdefined( item ) ? item_weapon::function_31562a2fb3df68d5( itembundle, item ) : item_weapon::function_477bf1207c6672a5( itembundle );
        
        if ( !weaponobj )
        {
            return;
        }
        
        index = undefined;
        
        if ( groupindex === 2 )
        {
            [ index, _ ] = item_weapon::function_6e9acdbb392dabc5( weaponobj, !var_c6cbb69e3515edb2 );
            index = item_weapon::function_ab5ff5980e9d9950( index ) ?? 0;
        }
        else if ( groupindex === 1 )
        {
            [ index, _ ] = item_weapon::function_6a2e65a74360c22d( weaponobj, !var_c6cbb69e3515edb2 );
        }
        
        return function_fe1314155ed7bd19( index );
    }
    
    index = undefined;
    
    foreach ( typedata in slots )
    {
        result = function_79e2c2087aa7de1e( itembundle, typedata, bundlelootid, bundletype );
        
        if ( !result )
        {
            continue;
        }
        
        if ( var_c6cbb69e3515edb2 && !isdefined( index ) )
        {
            index = typedata.index;
        }
        
        if ( funcs.getfunc )
        {
            [ row, column ] = function_12ee5af12df204b4( inventorygroup, typedata.index );
            
            if ( !isdefined( row ) || !isdefined( column ) )
            {
                continue;
            }
            
            currentitem = self [[ funcs.getfunc ]]( row, column, 1, 0 );
            
            if ( currentitem && bundlelootid )
            {
                slotbundle = common_item::function_6b8ff3d5f2688336( currentitem );
                slotlootid = common_item::function_779887309ec71dfe( slotbundle );
                var_9183e13907927f04 = groupindex == 2 ? common_item::function_5f3f8e423378acd6( slotbundle ) : common_item::function_38334193bd9b5956( slotbundle );
                maxcount = int( min( var_9183e13907927f04, typedata.maxquantity ?? 999999 ) );
                
                if ( slotlootid != bundlelootid || currentitem.count >= maxcount || !common_item::function_bfd517bdc8850ea6( bundletype, slotbundle ) )
                {
                    continue;
                }
            }
        }
        
        return typedata.index;
    }
    
    return index;
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x26d2e9ca, Offset: 0x6558
// Size: 0xa5
function function_3687d548a906da96( groupindex, slotindex )
{
    funcs = function_987405ff5ee23e99( groupindex );
    [ inventorygroup, inventorygroupname ] = self [[ funcs.var_65a6f7922d118cdd ]]();
    
    if ( !inventorygroup )
    {
        return 999999;
    }
    
    slots = function_6e8756548142d338( function_b353a43484c9827f( groupindex ), inventorygroupname );
    
    if ( !slots )
    {
        return 999999;
    }
    
    return slots[ slotindex ].maxquantity ?? 999999;
}

// Namespace common_inventory_groups
// Params 3, eflags: 0x4
// Checksum 0x55270dcf, Offset: 0x6606
// Size: 0x1bd
function private function_62b90f3423d5f896( groupindex, typeref, subtype )
{
    if ( !groupindex )
    {
        return;
    }
    
    slots = function_29bde483bdcd02b( groupindex );
    
    if ( !slots )
    {
        return;
    }
    
    foreach ( typedata in slots )
    {
        if ( !typedata.alloweditemtypes || !typedata.alloweditemtypes.size )
        {
            continue;
        }
        
        foreach ( alloweditem in typedata.alloweditemtypes )
        {
            if ( !alloweditem.itemtype && !alloweditem.subtype )
            {
                continue;
            }
            
            if ( typeref && alloweditem.itemtype )
            {
                var_3dce9812bba97463 = getscriptbundlefieldvalue( alloweditem.itemtype, "typeRef" ) ?? "generic";
                
                if ( var_3dce9812bba97463 != typeref )
                {
                    continue;
                }
            }
            
            if ( subtype && alloweditem.subtype != subtype )
            {
                continue;
            }
            
            return typedata;
        }
    }
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x90036a54, Offset: 0x67cc
// Size: 0x70
function function_29bde483bdcd02b( groupindex )
{
    funcs = function_987405ff5ee23e99( groupindex );
    [ _, inventorygroupname ] = self [[ funcs.var_65a6f7922d118cdd ]]();
    
    if ( !inventorygroupname )
    {
        return [];
    }
    
    return function_6e8756548142d338( function_b353a43484c9827f( groupindex ), inventorygroupname ) ?? [];
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x6b687b48, Offset: 0x6845
// Size: 0xc7
function function_b340fb55e3a33389( groupindex, slotindex )
{
    funcs = function_987405ff5ee23e99( groupindex );
    
    if ( !funcs.getfunc || !funcs.var_65a6f7922d118cdd )
    {
        return;
    }
    
    [ inventorygroup, _ ] = self [[ funcs.var_65a6f7922d118cdd ]]();
    
    if ( !inventorygroup )
    {
        return;
    }
    
    [ row, column ] = function_12ee5af12df204b4( inventorygroup, slotindex );
    return self [[ funcs.getfunc ]]( row, column, 1, 0 );
}

// Namespace common_inventory_groups
// Params 7, eflags: 0x4
// Checksum 0x997633b0, Offset: 0x6915
// Size: 0x2cc
function private function_cd10bbb422bb33de( groupindex, itembundle, bundlelootid, returnitem, returnindex, returnall, weaponobj )
{
    funcs = function_987405ff5ee23e99( groupindex );
    
    if ( !funcs.getfunc || !funcs.var_65a6f7922d118cdd )
    {
        return;
    }
    
    [ inventorygroup, inventorygroupname ] = self [[ funcs.var_65a6f7922d118cdd ]]();
    
    if ( !inventorygroup || !inventorygroupname )
    {
        return;
    }
    
    slots = function_6e8756548142d338( function_b353a43484c9827f( groupindex ), inventorygroupname );
    
    if ( !slots )
    {
        return;
    }
    
    if ( !weaponobj )
    {
        if ( bundlelootid && !itembundle )
        {
            itembundle = common_item::function_b202b16941992cca( bundlelootid );
        }
        
        if ( itembundle && !bundlelootid )
        {
            bundlelootid = common_item::function_779887309ec71dfe( itembundle );
        }
        
        if ( !bundlelootid || !itembundle )
        {
            return;
        }
    }
    
    returnarray = [];
    
    foreach ( typedata in slots )
    {
        result = function_79e2c2087aa7de1e( itembundle, typedata, bundlelootid );
        
        if ( !result )
        {
            continue;
        }
        
        [ row, column ] = function_12ee5af12df204b4( inventorygroup, typedata.index );
        
        if ( !isdefined( row ) || !isdefined( column ) )
        {
            continue;
        }
        
        item = self [[ funcs.getfunc ]]( row, column, 0, 0 );
        
        if ( item )
        {
            slotlootid = common_item::function_6d301ac91c3cd13d( item );
            
            if ( slotlootid == bundlelootid || weaponobj == item.weaponobj )
            {
                if ( returnitem && returnindex )
                {
                    val = [ item, typedata.index ];
                    
                    if ( returnall )
                    {
                        returnarray[ returnarray.size ] = val;
                    }
                    else
                    {
                        return val;
                    }
                    
                    continue;
                }
                
                if ( returnitem )
                {
                    val = item;
                    
                    if ( returnall )
                    {
                        returnarray[ returnarray.size ] = val;
                    }
                    else
                    {
                        return val;
                    }
                    
                    continue;
                }
                
                val = typedata.index;
                
                if ( returnall )
                {
                    returnarray[ returnarray.size ] = val;
                    continue;
                }
                
                return val;
            }
        }
    }
    
    if ( returnarray.size && returnall )
    {
        return returnarray;
    }
}

// Namespace common_inventory_groups
// Params 4
// Checksum 0xc8baf8e3, Offset: 0x6bea
// Size: 0x233
function function_d493153270fca171( groupindex, slotindex, itembundle, var_d602659d21376d75 )
{
    groupfuncs = function_987405ff5ee23e99( groupindex );
    
    if ( !groupfuncs.fromfunc || !groupfuncs.getfunc || !groupfuncs.var_65a6f7922d118cdd )
    {
        return 0;
    }
    
    [ inventorygroup, _ ] = self [[ groupfuncs.var_65a6f7922d118cdd ]]();
    
    if ( !inventorygroup )
    {
        return 0;
    }
    
    remainingquantity = var_d602659d21376d75;
    
    if ( isdefined( slotindex ) )
    {
        [ row, column ] = function_12ee5af12df204b4( inventorygroup, slotindex );
        item = [[ groupfuncs.getfunc ]]( row, column, 1 );
        var_d395b032111261c8 = int( min( item.count, remainingquantity ) );
        self [[ groupfuncs.fromfunc ]]( var_d395b032111261c8, 0, row, column );
        remainingquantity -= var_d395b032111261c8;
        return ( var_d602659d21376d75 - remainingquantity );
    }
    
    allinstances = function_ea3edc0e8fc6ffc9( groupindex, itembundle, undefined, 1 );
    
    foreach ( entry in allinstances )
    {
        item = entry[ 0 ];
        index = entry[ 1 ];
        var_d395b032111261c8 = int( min( item.count, remainingquantity ) );
        [ row, column ] = function_12ee5af12df204b4( inventorygroup, index );
        self [[ groupfuncs.fromfunc ]]( var_d395b032111261c8, 0, row, column );
        remainingquantity -= var_d395b032111261c8;
        
        if ( remainingquantity <= 0 )
        {
            return var_d602659d21376d75;
        }
    }
    
    return var_d602659d21376d75 - remainingquantity;
}

// Namespace common_inventory_groups
// Params 5
// Checksum 0x4b34cdf1, Offset: 0x6e26
// Size: 0x41
function function_ea3edc0e8fc6ffc9( groupindex, itembundle, bundlelootid, returnall, weaponobj )
{
    return function_cd10bbb422bb33de( groupindex, itembundle, bundlelootid, 1, 1, returnall, weaponobj );
}

// Namespace common_inventory_groups
// Params 5
// Checksum 0x6dde3c2, Offset: 0x6e70
// Size: 0x40
function function_bab25ef1337d21c8( groupindex, itembundle, bundlelootid, returnall, weaponobj )
{
    return function_cd10bbb422bb33de( groupindex, itembundle, bundlelootid, 1, undefined, returnall, weaponobj );
}

// Namespace common_inventory_groups
// Params 5
// Checksum 0xa9734a12, Offset: 0x6eb9
// Size: 0x40
function function_e7c426ab761c55e4( groupindex, itembundle, bundlelootid, returnall, weaponobj )
{
    return function_cd10bbb422bb33de( groupindex, itembundle, bundlelootid, undefined, 1, returnall, weaponobj );
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0xa4b93293, Offset: 0x6f02
// Size: 0x17b
function function_cbcd1dafab5f95e7( itembundle, bundlelootid, filtergroups )
{
    resultarray = [];
    
    if ( !isdefined( filtergroups ) )
    {
        filtergroups = [];
    }
    
    foreach ( groupindex in [ 1, 2, 3, 4, 5, 131, 130, 7 ] )
    {
        if ( arraycontains( filtergroups, groupindex ) )
        {
            continue;
        }
        
        foundinstances = function_ea3edc0e8fc6ffc9( groupindex, itembundle, bundlelootid, 1 );
        
        if ( foundinstances && foundinstances.size )
        {
            foreach ( entry in foundinstances )
            {
                if ( !isdefined( resultarray[ groupindex ] ) )
                {
                    resultarray[ groupindex ] = [];
                }
                
                resultarray[ groupindex ][ entry[ 1 ] ] = entry[ 0 ];
            }
        }
    }
    
    return resultarray;
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0xc0a9fe8d, Offset: 0x7086
// Size: 0x6f
function function_8b575930cbcb2457( groupindex, itembundle )
{
    funcs = function_987405ff5ee23e99( groupindex );
    
    if ( !funcs )
    {
        return [];
    }
    
    [ inventorygroup, inventorygroupname ] = self [[ funcs.var_65a6f7922d118cdd ]]();
    return function_c8b5512ec6e3fe49( groupindex, itembundle, inventorygroupname );
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0xc651e7f4, Offset: 0x70fe
// Size: 0xe8
function function_c8b5512ec6e3fe49( groupindex, itembundle, inventorygroupname )
{
    slots = function_6e8756548142d338( function_b353a43484c9827f( groupindex ), inventorygroupname );
    
    if ( !slots )
    {
        return [];
    }
    
    bundlelootid = common_item::function_779887309ec71dfe( itembundle );
    resultslots = [];
    
    foreach ( typedata in slots )
    {
        result = function_79e2c2087aa7de1e( itembundle, typedata, bundlelootid );
        
        if ( result )
        {
            resultslots[ resultslots.size ] = typedata;
        }
    }
    
    return resultslots;
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0xdfbce1f3, Offset: 0x71ef
// Size: 0x245, Type: bool
function function_3b0e4fccbf0778d4( left, right )
{
    if ( left.alloweditems.size > 0 || right.alloweditems.size > 0 )
    {
        if ( left.alloweditems.size == right.alloweditems.size )
        {
            return ( left.index < right.index );
        }
        
        return ( left.alloweditems.size > right.alloweditems.size );
    }
    
    var_a2fefd2913bb29ec = left.alloweditemtypes.size;
    
    foreach ( allowedtype in left.alloweditemtypes )
    {
        if ( allowedtype.itemtype )
        {
            typeref = getscriptbundlefieldvalue( allowedtype.itemtype, "typeRef" ) ?? "generic";
            
            if ( typeref == "generic" )
            {
                var_a2fefd2913bb29ec--;
                break;
            }
        }
    }
    
    var_1f2a5d4cc482a521 = right.alloweditemtypes.size;
    
    foreach ( allowedtype in right.alloweditemtypes )
    {
        if ( allowedtype.itemtype )
        {
            typeref = getscriptbundlefieldvalue( allowedtype.itemtype, "typeRef" ) ?? "generic";
            
            if ( typeref == "generic" )
            {
                var_1f2a5d4cc482a521--;
                break;
            }
        }
    }
    
    if ( var_a2fefd2913bb29ec == var_1f2a5d4cc482a521 )
    {
        return ( left.index < right.index );
    }
    
    if ( var_a2fefd2913bb29ec == 0 || var_1f2a5d4cc482a521 == 0 )
    {
        return ( var_1f2a5d4cc482a521 == 0 );
    }
    
    return var_a2fefd2913bb29ec > var_1f2a5d4cc482a521;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x80a6d4b8, Offset: 0x743d
// Size: 0x25, Type: bool
function function_6552ebad288148db( item )
{
    return item.additionaldata.groupindex ?? 0;
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0x6ae7a224, Offset: 0x746b
// Size: 0x331
function private function_ebe56d81601bfa82( inventorygroup )
{
    var_63d0a4c615134f6d = [];
    slots = function_a8f87e5f5f340e9f( inventorygroup );
    
    if ( !slots )
    {
        return var_63d0a4c615134f6d;
    }
    
    foreach ( slot in slots )
    {
        allowedtypes = [];
        
        foreach ( allowedtype in slot.alloweditemtypes )
        {
            if ( !allowedtype.itemtype )
            {
                continue;
            }
            
            typeref = getscriptbundlefieldvalue( allowedtype.itemtype, "typeRef" ) ?? "generic";
            allowedtypes[ allowedtypes.size ] = allowedtype;
        }
        
        foreach ( alloweditem in slot.alloweditems )
        {
            if ( !alloweditem.itemspawnentry )
            {
                continue;
            }
            
            if ( !isdefined( alloweditem.typeref ) )
            {
                alloweditem.typeref = common_item::function_3cba34a99d02cd9( alloweditem.itemspawnentry );
            }
            
            if ( !isdefined( alloweditem.subtype ) )
            {
                alloweditem.subtype = common_item::function_8fb8bfe0d9780c2e( alloweditem.itemspawnentry );
            }
            
            allowedtype = { #subtype:alloweditem.subtype, #itemtype:alloweditem.typeref };
            allowedtypes[ allowedtypes.size ] = allowedtype;
        }
        
        resultstruct = { #index:slot.index, #alloweditemtypes:allowedtypes };
        
        foreach ( allowedtype in allowedtypes )
        {
            if ( !allowedtype.itemtype || var_63d0a4c615134f6d[ allowedtype.itemtype ] )
            {
                continue;
            }
            
            typeref = getscriptbundlefieldvalue( allowedtype.itemtype, "typeRef" ) ?? "generic";
            var_63d0a4c615134f6d[ typeref ] = resultstruct;
        }
    }
    
    return var_63d0a4c615134f6d;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x8d4071fa, Offset: 0x77a5
// Size: 0x1f5
function function_5adc07cba5c77aba( itemtype )
{
    if ( !inventorygroup_enabled() || itemtype == "generic" )
    {
        return level.commonitem.itemcallbacks[ itemtype ];
    }
    
    loadoutgroupname = function_70646e83e5497be();
    slotdata = level.var_fc79a1290e796489[ loadoutgroupname ][ itemtype ];
    
    if ( !slotdata.alloweditemtypes || slotdata.alloweditemtypes.size == 0 )
    {
        return level.commonitem.itemcallbacks[ itemtype ];
    }
    
    foreach ( allowedtype in slotdata.alloweditemtypes )
    {
        if ( !allowedtype.itemtype )
        {
            continue;
        }
        
        typeref = getscriptbundlefieldvalue( allowedtype.itemtype, #"typeref" ) ?? "generic";
        callbacks = level.commonitem.itemcallbacks[ typeref ];
        
        if ( !callbacks.funcs[ #"getcurrent" ] )
        {
            continue;
        }
        
        if ( typeref == "weapon" )
        {
            slotname = function_acd97ba889776567( slotdata.index );
        }
        
        var_8fb8e1fb220cca48 = self [[ callbacks.funcs[ #"getcurrent" ] ]]( { #slotname:slotname } );
        
        if ( var_8fb8e1fb220cca48 )
        {
            return callbacks;
        }
    }
    
    return level.commonitem.itemcallbacks[ itemtype ];
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x8a5a0ed3, Offset: 0x79a3
// Size: 0x6a
function function_a6cff1b67a8fcc11( item )
{
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    grouptype = !isdefined( itembundle.inventorygrouplocation ) || itembundle.inventorygrouplocation == "NONE" ? "BACKPACK" : itembundle.inventorygrouplocation;
    return function_803ea5387e90fa5b( grouptype );
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x600a1, Offset: 0x7a16
// Size: 0xc1
function function_803ea5387e90fa5b( grouptype )
{
    if ( !grouptype )
    {
        return 0;
    }
    
    switch ( grouptype )
    {
        case #"hash_90b47b0b88fa12fb":
            return 0;
        case #"hash_e63c9f4f7f7d38eb":
            return 1;
        case #"hash_2c4c34ed69312923":
            return 2;
        case #"hash_dc6fcc7779f2bbea":
            return 3;
        case #"hash_c144e5f655210d5f":
            return 4;
        case #"hash_e2f447ec64d5b8b0":
            return 5;
        case #"hash_5fa239efd466a5c6":
            return 131;
        case #"hash_1daad998e6098a72":
            return 130;
        case #"hash_ea60885a039c37f8":
            return 20;
        case #"hash_2428f776dfd76e3d":
            return 7;
        default:
            return 0;
    }
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x5a4a6e2, Offset: 0x7adf
// Size: 0xfb
function function_b353a43484c9827f( groupindex )
{
    if ( !isdefined( groupindex ) )
    {
        return "NONE";
    }
    
    switch ( groupindex )
    {
        case 0:
            return "NONE";
        case 1:
            return "BACKPACK";
        case 2:
            return "LOADOUT";
        case 3:
            return "PERKS";
        case 4:
            return "UTILITY";
        case 5:
            return "SECURE";
        case 131:
            return "KEYRING";
        case 130:
            return "RESOURCES";
        case 20:
            return "CONTAINER";
        case 7:
            return "QUEST";
        case 21:
            return "MANAGEMENT";
        default:
            return "NONE";
    }
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x75a911a4, Offset: 0x7be2
// Size: 0x27, Type: bool
function function_175892577412c612( groupid )
{
    if ( !isdefined( groupid ) )
    {
        return false;
    }
    
    return function_bdd40ff62071d8a0( groupid ) || groupid == 999;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x65f8fca3, Offset: 0x7c12
// Size: 0x4c
function function_bdd40ff62071d8a0( groupid )
{
    if ( !isdefined( groupid ) )
    {
        return 0;
    }
    
    return arraycontains( [ 1, 2, 3, 4, 5, 131, 130, 7 ], groupid );
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x642b8ccf, Offset: 0x7c67
// Size: 0x8f
function function_6dfdd28826ee7354( inventorygroup, index )
{
    if ( !inventorygroup || !isdefined( index ) )
    {
        return [ undefined, undefined, undefined ];
    }
    
    [ row, column ] = function_12ee5af12df204b4( inventorygroup, index );
    
    if ( !isdefined( row ) || !isdefined( column ) )
    {
        return [ undefined, undefined, undefined ];
    }
    
    return function_98333f94074fd38e( inventorygroup, row, column );
}

// Namespace common_inventory_groups
// Params 3
// Checksum 0xe74c859, Offset: 0x7cff
// Size: 0x211
function function_98333f94074fd38e( inventorygroup, row, column )
{
    if ( !inventorygroup || !isdefined( row ) || !isdefined( column ) )
    {
        return [ undefined, undefined, undefined ];
    }
    
    buttondefinition = function_62e8f7d021e6a61e( inventorygroup, row, column );
    typedata = function_ec48255a23c8526f( buttondefinition );
    
    if ( typedata.alloweditemtypes.size == 0 )
    {
        return [ undefined, undefined, undefined ];
    }
    
    typeref = undefined;
    callbacks = undefined;
    var_8fb8e1fb220cca48 = undefined;
    
    foreach ( slottype in typedata.alloweditemtypes )
    {
        if ( !slottype.itemtype )
        {
            continue;
        }
        
        typeref = getscriptbundlefieldvalue( slottype.itemtype, #"typeref" ) ?? "generic";
        callbacks = common_item::function_9f00d6361edd38ce( typeref, 0 );
        
        if ( !callbacks.funcs[ #"getcurrent" ] )
        {
            continue;
        }
        
        if ( typeref == "weapon" )
        {
            slotname = inventorygroup_getweaponslotname( inventorygroup, row, column );
        }
        
        index = function_7539b7a73a2ba0b2( inventorygroup, row, column );
        var_8fb8e1fb220cca48 = self [[ callbacks.funcs[ #"getcurrent" ] ]]( { #index:index, #slotname:slotname } );
        
        if ( var_8fb8e1fb220cca48 )
        {
            break;
        }
    }
    
    if ( !callbacks )
    {
        return [ undefined, undefined, undefined ];
    }
    
    return [ callbacks, typeref, var_8fb8e1fb220cca48 ];
}

// Namespace common_inventory_groups
// Params 2, eflags: 0x4
// Checksum 0xd53961d, Offset: 0x7f19
// Size: 0x23, Type: bool
function private function_b4a381d24198d6cd( row, column )
{
    return row == 31 || column == 31;
}

// Namespace common_inventory_groups
// Params 5, eflags: 0x4
// Checksum 0x4887cf64, Offset: 0x7f45
// Size: 0xcc
function private function_17c174dc1ef34e6b( affectall, itembundle, quantity, weaponobj, typeref = common_item::function_16e8c106491eeaca( itembundle ) )
{
    defaultquantity = itembundle.dropcount ?? common_item::function_ea3b3088d82fd357( itembundle, { #weapon:weaponobj } );
    
    if ( typeref == "currency" )
    {
        defaultquantity = getdvarint( @"hash_b272936aad99a46f", 50 );
    }
    else if ( typeref == "weapon" )
    {
        affectall = 1;
    }
    
    if ( !isdefined( quantity ) )
    {
        quantity = 1;
    }
    
    defaultquantity = int( min( defaultquantity, quantity ) );
    return affectall || itembundle.var_2b0a27d4be7d298b ? quantity : defaultquantity;
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xe66433b6, Offset: 0x801a
// Size: 0x1ed
function function_fe1314155ed7bd19( index )
{
    if ( !isdefined( index ) )
    {
        return;
    }
    
    slots = undefined;
    
    if ( common_inventory::function_933894456e289760() && index >= 2 )
    {
        index -= 2;
        [ backpackgroup, var_ac9ac87f293120e4 ] = function_c27ac785b5373b73();
        slots = function_6e8756548142d338( "BACKPACK", var_ac9ac87f293120e4 );
    }
    else
    {
        [ loadoutgroup, loadoutgroupname ] = function_896ed3217a875f7d();
        slots = function_6e8756548142d338( "LOADOUT", loadoutgroupname );
    }
    
    if ( !slots )
    {
        return;
    }
    
    foundweapons = 0;
    
    foreach ( typedata in slots )
    {
        foreach ( allowedtype in typedata.alloweditemtypes )
        {
            if ( !allowedtype.itemtype )
            {
                continue;
            }
            
            typeref = getscriptbundlefieldvalue( allowedtype.itemtype, "typeRef" );
            
            if ( typeref == "weapon" )
            {
                if ( foundweapons == index )
                {
                    return typedata.index;
                }
                
                foundweapons++;
            }
        }
    }
}

// Namespace common_inventory_groups
// Params 6
// Checksum 0x791ade8c, Offset: 0x8210
// Size: 0x7c
function function_e3a3a47f88474ba4( quantityused, shoulddrop, toitem, var_55dd87f7b35e8c90, var_694baa06fdec00c6, var_ee8e73d99cebd505 )
{
    return { #var_ee8e73d99cebd505:var_ee8e73d99cebd505, #var_694baa06fdec00c6:var_694baa06fdec00c6, #var_55dd87f7b35e8c90:var_55dd87f7b35e8c90, #toitem:toitem, #shoulddrop:shoulddrop, #quantityused:quantityused };
}

// Namespace common_inventory_groups
// Params 2, eflags: 0x4
// Checksum 0xf39df6c5, Offset: 0x8295
// Size: 0x1a7
function private function_6e857d468e441a24( inventorygroupname, inventorygroupbundle )
{
    if ( !isdefined( level.var_d21f4ee5c0bf65b ) )
    {
        level.var_d21f4ee5c0bf65b = [];
    }
    
    if ( !isdefined( level.var_d21f4ee5c0bf65b[ inventorygroupname ] ) )
    {
        level.var_d21f4ee5c0bf65b[ inventorygroupname ] = [];
    }
    
    numrows = inventorygroupbundle.buttonrows ? inventorygroupbundle.buttonrows.size : 0;
    total = 0;
    var_b0ad7e406d456efc = [];
    
    for ( i = 0; i < numrows ; i++ )
    {
        size = inventorygroupbundle.buttonrows[ i ].buttoncolumns.size;
        var_b0ad7e406d456efc[ i ] = size;
        total += size;
    }
    
    var_b4a83925861e3298 = [];
    running = 0;
    
    for ( i = numrows - 1; i >= 0 ; i-- )
    {
        var_b4a83925861e3298[ i ] = running;
        running += var_b0ad7e406d456efc[ i ];
    }
    
    var_fa5d5f5b62e33b29 = [];
    var_5ed9c2bbb4ba22c9 = [];
    idx = 0;
    
    for ( i = numrows - 1; i >= 0 ; i-- )
    {
        size = var_b0ad7e406d456efc[ i ];
        
        for ( j = 0; j < size ; j++ )
        {
            var_fa5d5f5b62e33b29[ idx ] = i;
            var_5ed9c2bbb4ba22c9[ idx ] = j;
            idx += 1;
        }
    }
    
    level.var_d21f4ee5c0bf65b[ inventorygroupname ] = { #var_5ed9c2bbb4ba22c9:var_5ed9c2bbb4ba22c9, #var_fa5d5f5b62e33b29:var_fa5d5f5b62e33b29, #var_b4a83925861e3298:var_b4a83925861e3298, #totalslots:total };
}

// Namespace common_inventory_groups
// Params 0, eflags: 0x4
// Checksum 0x418ee0a, Offset: 0x8444
// Size: 0x361
function private function_92aa347a4ef1517d()
{
    level endon( #"game_ended" );
    
    while ( !level.gametypebundle )
    {
        waitframe();
    }
    
    if ( !level.gametypebundle.inventorygroupings || level.gametypebundle.inventorygroupings.size <= 0 )
    {
        return;
    }
    
    level.inventorygroupings = [];
    level.var_fc79a1290e796489 = [];
    
    foreach ( inventorygroupbundle in level.gametypebundle.inventorygroupings )
    {
        groupbundle = getscriptbundlefieldvalues( inventorygroupbundle.inventorygroup, [ #"groupid", #"inventorygroupings" ] );
        
        if ( !isdefined( level.inventorygroupings[ groupbundle.groupid ] ) )
        {
            level.inventorygroupings[ groupbundle.groupid ] = [];
        }
        
        var_4269020ba5d22e87 = [];
        
        foreach ( index, grouping in groupbundle.inventorygroupings )
        {
            inventorygroupbundle = getscriptbundlefieldvalues( grouping.inventorygroup, [ #"buttonrows", #"groupid", #"temporarygroupid" ] );
            function_6e857d468e441a24( grouping.inventorygroup, inventorygroupbundle );
            slots = function_a8f87e5f5f340e9f( inventorygroupbundle );
            slots = arraysort( slots, undefined, &function_3b0e4fccbf0778d4 );
            var_4269020ba5d22e87[ grouping.inventorygroup ] = { #sortedslots:slots, #index:index };
            
            if ( inventorygroupbundle.groupid === "TEMPORARY" )
            {
                if ( !isdefined( level.inventorygroupings[ inventorygroupbundle.temporarygroupid ] ) )
                {
                    level.inventorygroupings[ inventorygroupbundle.temporarygroupid ] = [];
                }
                
                if ( !isdefined( level.inventorygroupings[ inventorygroupbundle.temporarygroupid ][ grouping.inventorygroup ] ) )
                {
                    level.inventorygroupings[ inventorygroupbundle.temporarygroupid ][ grouping.inventorygroup ] = [];
                }
                
                level.inventorygroupings[ inventorygroupbundle.temporarygroupid ][ grouping.inventorygroup ] = { #sortedslots:slots, #index:index };
            }
            
            level.var_fc79a1290e796489[ grouping.inventorygroup ] = function_ebe56d81601bfa82( inventorygroupbundle );
        }
        
        level.inventorygroupings[ groupbundle.groupid ] = function_c6c06162c8e6ae75( var_4269020ba5d22e87, level.inventorygroupings[ groupbundle.groupid ] );
    }
}

// Namespace common_inventory_groups
// Params 0, eflags: 0x4
// Checksum 0xd4a69cf0, Offset: 0x87ad
// Size: 0x3f
function private function_71044e7f34def746()
{
    level endon( #"game_ended" );
    
    while ( !utility::issharedfuncdefined( #"game", #"registeronluieventcallback" ) )
    {
        wait 1;
    }
    
    namespace_9d8e359c3b1041e5::registeronluieventcallbacksharedfunc( &movecallback );
}

// Namespace common_inventory_groups
// Params 8
// Checksum 0x6fcf7c45, Offset: 0x87f4
// Size: 0x154
function function_71e4fb4e9d5af271( fromrow, fromcolumn, fromgroup, togroup, var_af93d6ea3ba7d9a4, currentitem, affectall, extradata )
{
    if ( !inventorygroup_enabled() )
    {
        return;
    }
    
    if ( !currentitem )
    {
        fromfuncs = function_987405ff5ee23e99( fromgroup );
        currentitem = [[ fromfuncs.getfunc ]]( fromrow, fromcolumn, affectall, extradata );
        
        if ( !currentitem )
        {
            return;
        }
    }
    
    itembundle = common_item::function_6b8ff3d5f2688336( currentitem );
    index = function_76928b4f093ca1ad( togroup, itembundle, var_af93d6ea3ba7d9a4, currentitem );
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    tofuncs = function_987405ff5ee23e99( togroup );
    [ inventorygroup, _ ] = self [[ tofuncs.var_65a6f7922d118cdd ]]();
    [ torow, tocolumn ] = function_12ee5af12df204b4( inventorygroup, index );
    
    if ( !isdefined( torow ) || !isdefined( tocolumn ) )
    {
        return;
    }
    
    function_d1ad55b9507ab500( fromrow, fromcolumn, fromgroup, torow, tocolumn, togroup, affectall, extradata, currentitem );
}

// Namespace common_inventory_groups
// Params 10
// Checksum 0xb98e18d7, Offset: 0x8950
// Size: 0x555
function function_d1ad55b9507ab500( fromrow, fromcolumn, fromgroup, torow, tocolumn, togroup, affectall, extradata, baseitems, ignorefrom )
{
    if ( !inventorygroup_enabled() )
    {
        return;
    }
    
    fromfuncs = function_987405ff5ee23e99( fromgroup );
    
    if ( fromfuncs.getfunc )
    {
        if ( !isdefined( baseitems ) )
        {
            baseitems = [[ fromfuncs.getfunc ]]( fromrow, fromcolumn, affectall, extradata );
        }
        
        if ( baseitems )
        {
            itembundlename = common_item::function_33a2c00e46263d99( baseitems );
            itembundle = common_item::function_6b8ff3d5f2688336( baseitems );
            typeref = common_item::function_16e8c106491eeaca( itembundle );
            var_b0992630fc1bfccf = typeref == "weapon" && fromgroup == 20 && ( togroup == 2 || togroup == 4 );
            
            if ( var_b0992630fc1bfccf )
            {
                var_ae016c4294ead9b7 = val::get( "weapon_pickup" );
                allowweaponswitch = val::get( "weapon_switch" );
                var_9b9151333dd98e72 = !var_ae016c4294ead9b7 || !allowweaponswitch;
                
                if ( var_9b9151333dd98e72 )
                {
                    common_item::function_eddf962212836a3e( itembundle, 0 );
                    return;
                }
            }
            
            if ( itembundle.var_b4b09e700a96b722 && fromgroup == 20 && togroup == 0 )
            {
                return;
            }
            
            if ( togroup == 0 && !level callback::response( 2, #"item_can_drop", { #itemtype:typeref, #itembundle:itembundle, #player:self } ) )
            {
                return;
            }
            
            if ( typeref )
            {
                typecallbacks = common_item::function_9f00d6361edd38ce( typeref );
                
                if ( typecallbacks.funcs[ #"caninteract" ] )
                {
                    caninteract = self [[ typecallbacks.funcs[ #"caninteract" ] ]]( { #itembundlename:itembundlename, #item:baseitems, #fromgroup:fromgroup, #togroup:togroup, #itembundle:itembundle } );
                }
                else if ( utility::callsharedfunc( #"killstreak", #"iskillstreakweapon", self getcurrentweapon() ) )
                {
                    caninteract = 1;
                }
                else
                {
                    weaponobj = baseitems.weaponobj;
                    
                    if ( typeref == "weapon" && !weaponobj )
                    {
                        weaponobj = item_weapon::function_477bf1207c6672a5( itembundle );
                    }
                    
                    caninteract = self function_a35b39392c23339f( { #weaponobj:weaponobj, #fromgroup:fromgroup, #togroup:togroup, #itembundlename:itembundlename } );
                }
                
                if ( !caninteract )
                {
                    if ( togroup != 0 )
                    {
                        common_item::function_eddf962212836a3e( itembundle, 0 );
                    }
                    
                    return;
                }
                
                if ( typecallbacks.funcs[ #"hash_9886eb1395647ce1" ] )
                {
                    [ baseitems, togroup ] = self [[ typecallbacks.funcs[ #"hash_9886eb1395647ce1" ] ]]( baseitems, togroup );
                }
            }
        }
    }
    
    if ( !isdefined( baseitems ) )
    {
        baseitems = [];
    }
    
    if ( !isarray( baseitems ) )
    {
        baseitems = [ baseitems ];
    }
    else
    {
        torow = 31;
        tocolumn = 31;
    }
    
    [ tocontainer, togroup ] = function_d9ae127eba52c1a( togroup );
    result = undefined;
    
    foreach ( item in baseitems )
    {
        tofuncs = function_987405ff5ee23e99( togroup );
        
        if ( !item || !tofuncs.tofunc )
        {
            continue;
        }
        
        itembundle = common_item::function_6b8ff3d5f2688336( item );
        
        if ( !function_b4a381d24198d6cd( torow, tocolumn ) )
        {
            var_74b28098a7da9142 = isdefined( tofuncs.var_65a6f7922d118cdd ) ? self [[ tofuncs.var_65a6f7922d118cdd ]]()[ 0 ] : undefined;
            
            if ( var_74b28098a7da9142 && !function_f25fea162932fee( itembundle, var_74b28098a7da9142, torow, tocolumn ) )
            {
                break;
            }
        }
        
        item.fromgroup = fromgroup;
        result = tocontainer [[ tofuncs.tofunc ]]( item, torow, tocolumn, affectall, extradata, fromgroup, fromrow, fromcolumn );
        
        if ( isdefined( result.var_55dd87f7b35e8c90 ) && isdefined( result.var_694baa06fdec00c6 ) )
        {
            fromrow = result.var_55dd87f7b35e8c90;
            fromcolumn = result.var_694baa06fdec00c6;
        }
    }
    
    if ( !ignorefrom && ( result.quantityused || result.var_ee8e73d99cebd505 ) && fromfuncs.fromfunc )
    {
        newitem = self [[ fromfuncs.fromfunc ]]( result.quantityused, result.shoulddrop, fromrow, fromcolumn, result.toitem, torow, tocolumn, togroup, affectall, extradata );
    }
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0x6128f0e9, Offset: 0x8ead
// Size: 0x78
function function_d9ae127eba52c1a( togroup )
{
    if ( isdefined( self.vehicle ) && self.vehicle.ispiloted && self.vehicle.targetname == "radar_drone_recon" )
    {
        return [ self.vehicle.container, 20 ];
    }
    
    return [ self, togroup ];
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0xa6fa951a, Offset: 0x8f2e
// Size: 0x5c
function private function_fc6960bf6e17db25( typedata )
{
    var_23571593164e759e = typedata.var_c6448e733a67923e;
    
    if ( var_23571593164e759e )
    {
        return common_item::function_90c3e0c1fd55d6b6( common_item::items_selectfromlist( var_23571593164e759e, 1 )[ 0 ] );
    }
    
    if ( !typedata.var_209a9ddd0970710e )
    {
        return;
    }
    
    return common_item::function_90c3e0c1fd55d6b6( typedata.var_209a9ddd0970710e );
}

// Namespace common_inventory_groups
// Params 2, eflags: 0x4
// Checksum 0x1f765243, Offset: 0x8f93
// Size: 0x1b9
function private function_bb1ae691e92d0233( fromrow, fromcolumn )
{
    if ( !isdefined( self.perks[ "specialty_trait_workbenches" ] ) )
    {
        return;
    }
    
    [ var_41d1e94effd14745, _ ] = function_5383a295f9e4ae09();
    
    if ( !var_41d1e94effd14745 )
    {
        return;
    }
    
    buttondefinition = function_62e8f7d021e6a61e( var_41d1e94effd14745, fromrow, fromcolumn );
    
    if ( !buttondefinition )
    {
        return;
    }
    
    typedata = function_ec48255a23c8526f( buttondefinition );
    craftcost = int( typedata.craftcost ?? 0 );
    
    if ( craftcost <= 0 )
    {
        return;
    }
    
    currentitem = function_48e2b44da86b9022( fromrow, fromcolumn, 0, undefined, var_41d1e94effd14745 );
    
    if ( !currentitem || currentitem.count < craftcost )
    {
        return;
    }
    
    outputbundle = function_fc6960bf6e17db25( typedata );
    
    if ( !outputbundle )
    {
        return;
    }
    
    outputitem = common_item::function_77600f92048df72d( outputbundle, typedata.var_12d4ede7ad63e670 ?? 1 );
    outputitem.fromground = 1;
    quantitycrafted = common_item::function_41751a7f86839f01( outputitem, undefined, 1 );
    
    if ( quantitycrafted <= 0 )
    {
        return;
    }
    
    var_eab43258fe292345 = common_item::function_c6f3ef3dcb4c55c0( "resource", #"removecurrent" );
    
    if ( !var_eab43258fe292345 )
    {
        return;
    }
    
    index = function_7539b7a73a2ba0b2( var_41d1e94effd14745, fromrow, fromcolumn );
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    self [[ var_eab43258fe292345 ]]( { #bundlename:var_41d1e94effd14745.inventorygroupname, #count:craftcost, #index:index } );
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0x6aef609d, Offset: 0x9154
// Size: 0x20e
function movecallback( notification, slotindex )
{
    if ( !notification )
    {
        return;
    }
    
    switch ( notification )
    {
        case #"hash_2160b51cb4b160aa":
        case #"hash_ecc65cb861cf47c6":
            movedata = function_313be7104bf0b01e( slotindex );
            contextual = movedata[ 0 ];
            affectall = movedata[ 1 ];
            torow = movedata[ 2 ];
            tocolumn = movedata[ 3 ];
            togroup = movedata[ 4 ];
            fromrow = movedata[ 5 ];
            fromcolumn = movedata[ 6 ];
            fromgroup = movedata[ 7 ];
            
            if ( notification == "temporary_move_item" )
            {
                fromgroup += 100;
            }
            
            var_62f650984f3ada2a = undefined;
            
            if ( contextual )
            {
                if ( fromgroup == 20 && function_bdd40ff62071d8a0( togroup ) )
                {
                    var_62f650984f3ada2a = 1;
                }
                else
                {
                    togroup += 100;
                }
            }
            
            extradata = { #var_62f650984f3ada2a:var_62f650984f3ada2a };
            
            if ( togroup == 0 )
            {
                fromfuncs = function_987405ff5ee23e99( fromgroup );
                
                if ( fromfuncs.getfunc )
                {
                    baseitem = self [[ fromfuncs.getfunc ]]( fromrow, fromcolumn, 0, undefined );
                    itembundle = common_item::function_6b8ff3d5f2688336( baseitem );
                    typeref = common_item::function_16e8c106491eeaca( itembundle );
                    
                    if ( !( utility::callsharedfunc( #"gametype", #"hash_6ad813eac6007239", typeref ) ?? 1 ) )
                    {
                        break;
                    }
                }
            }
            
            function_d1ad55b9507ab500( fromrow, fromcolumn, fromgroup, torow, tocolumn, togroup, affectall, extradata );
            break;
        case #"hash_96e9c9a96f91bd31":
            movedata = function_313be7104bf0b01e( slotindex );
            fromgroup = movedata[ 7 ] + 100;
            
            if ( fromgroup != 130 )
            {
                break;
            }
            
            fromrow = movedata[ 5 ];
            fromcolumn = movedata[ 6 ];
            function_bb1ae691e92d0233( fromrow, fromcolumn );
            break;
        default:
            return;
    }
}

// Namespace common_inventory_groups
// Params 1, eflags: 0x4
// Checksum 0xaec87121, Offset: 0x936a
// Size: 0x1c5
function private function_3664ce722fc287e7( params )
{
    itemsstring = getdvar( @"hash_e7b3d6760fce9351", "" );
    
    if ( !itemsstring || itemsstring == "" )
    {
        return;
    }
    
    items = strtok( itemsstring, "," );
    
    foreach ( player in level.players )
    {
        [ var_7d9ba0c7b083b3a2, _ ] = player function_db5a1ed29a9116b2();
        totalkeys = function_19a5a29f5cd0df45( var_7d9ba0c7b083b3a2 );
        count = 0;
        
        foreach ( itembundlename in items )
        {
            if ( count == totalkeys )
            {
                break;
            }
            
            itembundle = getscriptbundle( "itemspawnentry:" + itembundlename );
            
            if ( !itembundle )
            {
                continue;
            }
            
            item = common_item::function_77600f92048df72d( itembundle, 1, undefined, 131, count );
            player function_d24bdce79b4983ac( item, 31, 31 );
            count++;
        }
    }
}

// Namespace common_inventory_groups
// Params 1
// Checksum 0xdce215b9, Offset: 0x9537
// Size: 0x1b7
function function_6ba35ad635331220( loadoutgroup )
{
    self.var_ea52c11dcd2aecad = 0;
    
    foreach ( row, columns in loadoutgroup.buttonrows )
    {
        foreach ( column, _ in columns.buttoncolumns )
        {
            buttondefinition = function_62e8f7d021e6a61e( loadoutgroup, row, column );
            typedata = function_ec48255a23c8526f( buttondefinition );
            
            if ( typedata.alloweditemtypes.size == 0 )
            {
                continue;
            }
            
            subtype = typedata.alloweditemtypes[ 0 ].subtype;
            slottype = typedata.alloweditemtypes[ 0 ].itemtype;
            
            if ( slottype )
            {
                typeref = getscriptbundlefieldvalue( slottype, "typeRef" ) ?? "generic";
                
                if ( typeref == "weapon" && subtype != "tertiary" )
                {
                    self.var_ea52c11dcd2aecad++;
                }
            }
        }
    }
}

// Namespace common_inventory_groups
// Params 2
// Checksum 0xb1df422, Offset: 0x96f6
// Size: 0x545
function function_8ac7b21bacb56918( corpse, var_280f4c5a9aad6612 )
{
    droppeditems = [];
    droppedweapon = undefined;
    
    if ( common_inventory::function_d33e11a8dda3cb20() )
    {
        var_d793611aa27f052f = item_weapon::function_2acdc118d951356c( { #slotname:#"backpack_0" } );
        
        if ( isdefined( var_d793611aa27f052f ) )
        {
            weaponbundle = common_item::function_90c3e0c1fd55d6b6( var_d793611aa27f052f.name );
            weaponlootid = common_item::function_779887309ec71dfe( weaponbundle );
            index = function_e7c426ab761c55e4( 1, weaponbundle, weaponlootid );
            item = common_item::function_77600f92048df72d( var_d793611aa27f052f.name, undefined, var_d793611aa27f052f.weaponobj, 1, index, undefined, var_d793611aa27f052f );
            item.count = var_d793611aa27f052f.count;
            common_cache::cache_additem( corpse, var_d793611aa27f052f.name, var_d793611aa27f052f.count, 1, undefined, item );
            common_inventory::function_56f7e890f83685bd();
        }
    }
    
    foreach ( groupindex in [ 1, 2 ] )
    {
        funcs = function_987405ff5ee23e99( groupindex );
        
        if ( !funcs.getfunc || !funcs.fromfunc )
        {
            continue;
        }
        
        [ inventorygroup, _ ] = self [[ funcs.var_65a6f7922d118cdd ]]();
        
        if ( !inventorygroup )
        {
            continue;
        }
        
        totalslots = function_19a5a29f5cd0df45( inventorygroup );
        
        for ( i = 0; i < totalslots ; i++ )
        {
            item = function_b340fb55e3a33389( groupindex, i );
            
            if ( !item )
            {
                continue;
            }
            
            bundlename = common_item::function_33a2c00e46263d99( item ) ?? "";
            bundle = common_item::function_90c3e0c1fd55d6b6( bundlename );
            lootid = common_item::function_6d301ac91c3cd13d( item );
            
            if ( !bundle || !isdefined( lootid ) || dmz_dog_tag::function_7b2fcbd8d8d2e2a3( lootid ) )
            {
                continue;
            }
            
            count = item.count ?? item.quantity;
            typeref = common_item::function_16e8c106491eeaca( bundle );
            
            if ( count <= 0 && typeref != "weapon" )
            {
                continue;
            }
            
            [ fromrow, fromcolumn ] = function_12ee5af12df204b4( inventorygroup, i );
            
            if ( bundle.droponground || groupindex == 2 && !droppedweapon && typeref == "weapon" )
            {
                if ( typeref == "weapon" && !droppedweapon )
                {
                    slotname = function_acd97ba889776567( i );
                    [ callbacks, _, _ ] = function_6dfdd28826ee7354( inventorygroup, i );
                    droppedweapon = self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #dontdrop:0, #slotname:slotname, #count:count } );
                }
                else
                {
                    function_d1ad55b9507ab500( fromrow, fromcolumn, groupindex, 31, 31, 0, 1, undefined, item );
                }
            }
            else
            {
                function_d1ad55b9507ab500( fromrow, fromcolumn, groupindex, 31, 31, 20, 1, undefined, item );
            }
            
            if ( !isdefined( droppeditems[ lootid ] ) )
            {
                droppeditems[ lootid ] = 0;
            }
            
            droppeditems[ lootid ] += count;
        }
    }
    
    if ( dmz_dog_tag::hasdogtag( self ) )
    {
        itembundlename = common_item_database::function_ca9ca606e66b5911( dmz_dog_tag::function_a084b2fcf3307a37( self ) );
        dogtagbundle = common_item::function_90c3e0c1fd55d6b6( itembundlename );
        dogtagitem = common_item::function_77600f92048df72d( dogtagbundle, 1 );
        
        if ( !isdefined( dogtagitem.additionaldata ) )
        {
            dogtagitem.additionaldata = {};
        }
        
        dogtagitem.additionaldata.originalowner = self;
        dogtagitem.additionaldata.var_80a55ae41f929b49 = self.guid;
        dogtagitem.additionaldata.bountyScore = bounty_wanted::function_fc000e7d3c544a81();
        
        if ( !isdefined( var_280f4c5a9aad6612 ) )
        {
            var_280f4c5a9aad6612 = common_item::items_initspawnoptions_spawnfromentity( self );
        }
        
        var_280f4c5a9aad6612.additionaldata = dogtagitem.additionaldata;
        self.dogtag = common_item::function_61c2c0251e742ffd( dogtagbundle, 1, var_280f4c5a9aad6612 );
        dmz_dog_tag::function_ff4a0e3c9d3674dc( self, 0 );
        lootid = common_item::function_779887309ec71dfe( dogtagbundle );
        
        if ( !isdefined( droppeditems[ lootid ] ) )
        {
            droppeditems[ lootid ] = 0;
        }
        
        droppeditems[ lootid ] += dogtagitem.count ?? dogtagitem.quantity;
    }
    
    return [ droppeditems, droppedweapon ];
}

/#

    // Namespace common_inventory_groups
    // Params 1
    // Checksum 0x18109f66, Offset: 0x9c44
    // Size: 0x27c, Type: dev
    function printinventorygroup( groupindex )
    {
        funcs = function_987405ff5ee23e99( groupindex );
        
        if ( !funcs.getfunc )
        {
            return;
        }
        
        [ inventorygroup, inventorygroupname ] = self [[ funcs.var_65a6f7922d118cdd ]]();
        
        if ( !inventorygroup )
        {
            return;
        }
        
        slots = function_6e8756548142d338( function_b353a43484c9827f( groupindex ), inventorygroupname );
        
        if ( !slots )
        {
            return;
        }
        
        println( "<dev string:x288>" + getxhashsourcename( inventorygroupname ) + "<dev string:x2bf>" );
        outputarray = [];
        maxrow = 0;
        maxcolumn = 0;
        
        foreach ( typedata in slots )
        {
            [ row, column ] = function_12ee5af12df204b4( inventorygroup, typedata.index );
            
            if ( !isdefined( row ) || !isdefined( column ) )
            {
                continue;
            }
            
            currentitem = self [[ funcs.getfunc ]]( row, column, 1, 0 );
            
            if ( row > maxrow )
            {
                maxrow = row;
            }
            
            if ( column > maxcolumn )
            {
                maxcolumn = column;
            }
            
            if ( currentitem )
            {
                bundlename = common_item::function_33a2c00e46263d99( currentitem ) ?? "<dev string:x2d8>";
                
                if ( !isdefined( outputarray[ row ] ) )
                {
                    outputarray[ row ] = [];
                }
                
                outputarray[ row ][ column ] = "<dev string:x2d9>" + getxhashsourcename( bundlename ) + "<dev string:x2dc>";
                continue;
            }
            
            if ( !isdefined( outputarray[ row ] ) )
            {
                outputarray[ row ] = [];
            }
            
            outputarray[ row ][ column ] = "<dev string:x2df>";
        }
        
        for ( i = 0; i <= maxrow ; i++ )
        {
            row = outputarray[ i ];
            
            if ( row )
            {
                for ( j = 0; j <= maxcolumn ; j++ )
                {
                    column = row[ j ];
                    
                    if ( column )
                    {
                        print( column );
                    }
                }
            }
            
            println( "<dev string:x2d8>" );
        }
        
        println( "<dev string:x2e5>" + getxhashsourcename( inventorygroupname ) + "<dev string:x2bf>" );
    }

#/
