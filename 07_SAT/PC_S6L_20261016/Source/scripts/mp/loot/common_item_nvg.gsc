// scripts\mp\loot\common_item_nvg.gsc  (hash_6003ca7a94b38d64.gscc) (size: 4924 Bytes / 0x133c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63c701ee (1673986542)
// size ...... 4924 (0x133c)
// includes .. 7   (offset: 0x1280)
// strings ... 6   (offset: 0x12b8)
// dev strs .. 1   (offset: 0x1330)
// exports ... 16  (offset: 0xa20)
// cseg ...... 0xbc + 0x964 (0xa20)
// imports ... 50  (offset: 0xca0)
// animtree1 . 0   (offset: 0x133c)
// animtree2 . 0   (offset: 0x133c)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_nvg;

// Namespace item_nvg
// Params 0, eflags: 0x5
// Checksum 0x5ca4836f, Offset: 0xda
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_nvg", #"common_item", &init, undefined );
}

// Namespace item_nvg
// Params 0
// Checksum 0xb6516467, Offset: 0x103
// Size: 0xd4
function init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    level.nvgtypes = [];
    common_item::function_4b30c091d3b04a25( "nvg" );
    common_item::function_84174b793b5fe9a7( "nvg", #"use", &function_9c16d4cc3937168 );
    common_item::function_84174b793b5fe9a7( "nvg", #"hash_9e49dfaa7c147654", &function_cf3350f913b08398 );
    common_item::function_84174b793b5fe9a7( "nvg", #"getcurrent", &function_ae3cbdd48d98d97c );
    common_item::function_84174b793b5fe9a7( "nvg", #"removecurrent", &function_d179e965a8c649ee );
    common_item::function_84174b793b5fe9a7( "nvg", #"hash_2d3b76ff260f2d68", &function_ea85f950fdcb9d61 );
    common_item::function_84174b793b5fe9a7( "nvg", #"database_additem", &function_31d6d99317bd8b80 );
    callback::add( #"player_item_drop", &function_50f1976c13a20949 );
}

// Namespace item_nvg
// Params 1
// Checksum 0x480be452, Offset: 0x1df
// Size: 0xd0
function function_31d6d99317bd8b80( itembundlename )
{
    pbgvalue = getscriptbundlefieldvalue( itembundlename, #"hash_879d1abc3d186cfa" );
    
    if ( pbgvalue )
    {
        itembundle = getscriptbundlefieldvalues( itembundlename, [ #"ref", #"scriptable" ] );
        data = { #itembundle:itembundle, #itembundlename:itembundlename, #pbgvalue:pbgvalue };
        level.nvgtypes[ level.nvgtypes.size ] = data;
    }
    
    if ( utility::issharedfuncdefined( #"hash_8367e525f77f66b0", #"hash_e0da15da6bb956cd" ) )
    {
        utility::callsharedfunc( #"hash_8367e525f77f66b0", #"hash_e0da15da6bb956cd", itembundlename );
    }
}

// Namespace item_nvg
// Params 4
// Checksum 0x2315e845, Offset: 0x2b7
// Size: 0x1b5
function function_9c16d4cc3937168( itembundle, item, autouse, var_981c264073bf1154 )
{
    self.nvgtype = itembundle.ref;
    self notify( #"pickedupnvgs" );
    thread function_cee1d9564bb323da();
    
    foreach ( data in level.nvgtypes )
    {
        if ( data.itembundle.ref == itembundle.ref )
        {
            pbgvalue = data.pbgvalue;
            
            if ( pbgvalue )
            {
                function_3113d4503f5e9341( pbgvalue, self );
            }
        }
    }
    
    if ( hasomnvar( "ui_loadout_gear_index" ) && common_inventory_groups::inventorygroup_enabled() )
    {
        index = common_item::function_4af7d245e50939e7( "LOADOUT_GEAR", itembundle );
        
        if ( isdefined( index ) )
        {
            self setclientomnvar( "ui_loadout_gear_index", index + 1 );
        }
    }
    
    if ( function_2dea7cc4a3c56d1d() || isdefined( self.var_a7a18d0e9d96f58a ) && self.var_a7a18d0e9d96f58a + 1000 > gettime() )
    {
        return ( item.count - 1 );
    }
    
    if ( itembundle.var_836b828a56b23751 )
    {
        self.var_a7a18d0e9d96f58a = gettime();
        function_cd0a74c0fa209426( itembundle );
    }
    
    return item.count - 1;
}

// Namespace item_nvg
// Params 0, eflags: 0xc
// Checksum 0x44704982, Offset: 0x475
// Size: 0x10c
function private function_cee1d9564bb323da()
{
    self notify( #"hash_a4618f6db6e25ee7" );
    self endon( #"hash_a4618f6db6e25ee7" );
    self endon( #"disconnect" );
    dvar = getdvarint( @"hash_6966aadc0ddbfb98", 0 );
    
    if ( !dvar )
    {
        return;
    }
    
    self notifyonplayercommand( "equip_nvgs_dvar", "+actionslot 4" );
    
    while ( true )
    {
        self waittill( #"equip_nvgs_dvar" );
        
        /#
            self iprintlnbold( "<dev string:x24>" );
        #/
        
        item = { #additionaldata:{ #slotindex:3, #scriptable:"rex_loot_nvg", #originalowner:level.players[ 0 ], #groupindex:2, #count:1 }, #type:%"rex_loot_nvg", #count:1 };
        bundle = common_item::function_6b8ff3d5f2688336( item );
        function_ea85f950fdcb9d61( 3, bundle );
    }
}

// Namespace item_nvg
// Params 4
// Checksum 0xa8bf46d3, Offset: 0x589
// Size: 0x52, Type: bool
function function_cf3350f913b08398( itembundle, item, autouse, allowswap )
{
    typeref = common_item::function_16e8c106491eeaca( itembundle );
    return typeref != "nvg" || !isdefined( self.nvgtype );
}

// Namespace item_nvg
// Params 1
// Checksum 0x1970d8fc, Offset: 0x5e4
// Size: 0x52
function function_ae3cbdd48d98d97c( params )
{
    if ( isdefined( self.nvgtype ) )
    {
        name = common_item_database::function_a4f0a21951180013( self.nvgtype );
        
        if ( isdefined( name ) )
        {
            return { #count:1, #name:name };
        }
    }
}

// Namespace item_nvg
// Params 1
// Checksum 0x5cdaea76, Offset: 0x63f
// Size: 0x5a
function function_d179e965a8c649ee( params )
{
    var_8fb8e1fb220cca48 = function_ae3cbdd48d98d97c( params );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        if ( hasomnvar( "ui_loadout_gear_index" ) )
        {
            self setclientomnvar( "ui_loadout_gear_index", 0 );
        }
        
        if ( function_2dea7cc4a3c56d1d() )
        {
            function_2d134361bab43d4b();
        }
        
        self.nvgtype = undefined;
    }
    
    return var_8fb8e1fb220cca48;
}

// Namespace item_nvg
// Params 5
// Checksum 0xeea51d7f, Offset: 0x6a2
// Size: 0xf6
function function_ea85f950fdcb9d61( index, bundle, lootid, quantity, groupid )
{
    if ( isdefined( self.var_a7a18d0e9d96f58a ) && self.var_a7a18d0e9d96f58a + 1000 > gettime() )
    {
        return;
    }
    
    typeref = common_item::function_16e8c106491eeaca( bundle );
    
    if ( typeref != "nvg" )
    {
        return;
    }
    
    self.var_a7a18d0e9d96f58a = gettime();
    
    if ( function_2dea7cc4a3c56d1d() )
    {
        function_2d134361bab43d4b();
        thread function_3326301201862bf9( 0 );
    }
    else
    {
        function_cd0a74c0fa209426( bundle );
        thread function_3326301201862bf9( 1 );
    }
    
    if ( groupid == 1 )
    {
        item = common_item::function_77600f92048df72d( bundle, 1, undefined, groupid, index );
        result = common_item::function_2b5e2ff57d5f392( item, undefined, 1 );
        
        if ( result )
        {
            common_inventory::inventory_setbackpackitematindex( index, 0, 0, undefined, item );
        }
    }
}

// Namespace item_nvg
// Params 0, eflags: 0x4
// Checksum 0x91459543, Offset: 0x7a0
// Size: 0x30
function private function_2dea7cc4a3c56d1d()
{
    dvar = getdvarint( @"hash_75e625b71e37cfb1", 0 );
    
    if ( dvar )
    {
        return self.var_93714c13c193a745;
    }
    
    return self isnightvisionon();
}

// Namespace item_nvg
// Params 1, eflags: 0x4
// Checksum 0xfc6b2905, Offset: 0x7d9
// Size: 0x61
function private function_cd0a74c0fa209426( itembundlename )
{
    self.var_93714c13c193a745 = 1;
    dvar = getdvarint( @"hash_75e625b71e37cfb1", 0 );
    
    if ( dvar )
    {
        pbgvalue = itembundlename.var_e16068e0bffa69cd;
        
        if ( pbgvalue )
        {
            function_55af6d015c4cb895( self, pbgvalue );
        }
        
        return;
    }
    
    self nightvisionviewon();
}

// Namespace item_nvg
// Params 0, eflags: 0x4
// Checksum 0x99b5a79c, Offset: 0x842
// Size: 0x3a
function private function_2d134361bab43d4b()
{
    self.var_93714c13c193a745 = undefined;
    dvar = getdvarint( @"hash_75e625b71e37cfb1", 0 );
    
    if ( dvar )
    {
        function_fe2123dba85371ec( self );
        return;
    }
    
    self nightvisionviewoff();
}

// Namespace item_nvg
// Params 1, eflags: 0xc
// Checksum 0xf752431f, Offset: 0x884
// Size: 0x8c
function private function_3326301201862bf9( toggledon )
{
    self notify( #"hash_8a8b54f92a5a7828" );
    self endon( #"hash_8a8b54f92a5a7828" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    
    while ( function_2dea7cc4a3c56d1d() != toggledon )
    {
        waitframe();
    }
    
    if ( utility::issharedfuncdefined( #"hash_8367e525f77f66b0", #"hash_ccaff0c8d05d796" ) )
    {
        utility::callsharedfunc( #"hash_8367e525f77f66b0", #"hash_ccaff0c8d05d796" );
    }
}

// Namespace item_nvg
// Params 1
// Checksum 0x6ccba30e, Offset: 0x918
// Size: 0xc6
function function_50f1976c13a20949( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    typeref = common_item::function_3cba34a99d02cd9( params.itembundlename );
    
    if ( typeref != "nvg" )
    {
        return;
    }
    
    childthread function_583b9394d6463b7c();
    
    if ( common_inventory_groups::inventorygroup_enabled() && !params.item.additionaldata.currentnvg )
    {
        return;
    }
    
    if ( function_2dea7cc4a3c56d1d() )
    {
        if ( isdefined( params.item.additionaldata.currentnvg ) )
        {
            params.item.additionaldata.currentnvg = undefined;
        }
        
        function_2d134361bab43d4b();
    }
}

// Namespace item_nvg
// Params 0
// Checksum 0xdbf3491f, Offset: 0x9e6
// Size: 0x3a
function function_583b9394d6463b7c()
{
    waitframe();
    
    if ( self.var_a7a18d0e9d96f58a && self.var_a7a18d0e9d96f58a + 1000 > gettime() )
    {
        while ( !self isnightvisionon() )
        {
            waitframe();
        }
        
        self nightvisionviewoff( 1 );
    }
}

