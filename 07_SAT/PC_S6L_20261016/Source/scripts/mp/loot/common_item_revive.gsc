// scripts\mp\loot\common_item_revive.gsc  (hash_2791e8a2b366065c.gscc) (size: 3022 Bytes / 0xbce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x890a3cb0 (2299149488)
// size ...... 3022 (0xbce)
// includes .. 8   (offset: 0xb22)
// strings ... 6   (offset: 0xb62)
// dev strs .. 0   (offset: 0xbce)
// exports ... 9   (offset: 0x5b2)
// cseg ...... 0xdd + 0x4d5 (0x5b2)
// imports ... 35  (offset: 0x71a)
// animtree1 . 0   (offset: 0xbce)
// animtree2 . 0   (offset: 0xbce)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_revive;

// Namespace item_revive
// Params 0, eflags: 0x5
// Checksum 0x6e01e610, Offset: 0xfb
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_revive", #"common_item", &init_item_revive, undefined );
}

// Namespace item_revive
// Params 0
// Checksum 0xfc7ca73a, Offset: 0x124
// Size: 0xb1
function init_item_revive()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "revive" );
    common_item::function_84174b793b5fe9a7( "revive", #"use", &use_revive );
    common_item::function_84174b793b5fe9a7( "revive", #"canautouse", &function_f184dea31c227de3 );
    common_item::function_84174b793b5fe9a7( "revive", #"hash_9e49dfaa7c147654", &can_use_revive );
    common_item::function_84174b793b5fe9a7( "revive", #"getcurrent", &get_current_revive );
    common_item::function_84174b793b5fe9a7( "revive", #"removecurrent", &remove_current_revive );
    level callback::add( #"player_laststand_revived", &on_revived );
}

// Namespace item_revive
// Params 1
// Checksum 0x67818bde, Offset: 0x1dd
// Size: 0xe7
function on_revived( params )
{
    if ( self == params.reviver && common_inventory::inventory_isenabled() )
    {
        self setclientomnvar( "ui_self_revive_advanced_acquired", 0 );
        
        for ( backpackindex = 0; backpackindex < common_inventory::function_9cd65c8312048802() ; backpackindex++ )
        {
            lootid = common_inventory::inventory_getlootidatbackpackindex( backpackindex );
            quantity = common_inventory::inventory_getquantityatbackpackindex( backpackindex );
            
            if ( lootid > 0 )
            {
                itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
                itembundle = getscriptbundlefieldvalues( itembundlename, [ #"lootitemtype" ] );
                
                if ( common_item::function_16e8c106491eeaca( itembundle ) == "revive" )
                {
                    for ( i = 0; i < quantity ; i++ )
                    {
                        if ( laststand::function_ed4da7e5751eed47() )
                        {
                            common_inventory::inventory_equipbackpackitem( backpackindex );
                        }
                    }
                }
            }
        }
    }
}

// Namespace item_revive
// Params 4
// Checksum 0x348438ae, Offset: 0x2cc
// Size: 0x50, Type: bool
function can_use_revive( itembundle, item, autouse, allowswap )
{
    return laststand::function_ed4da7e5751eed47() || itembundle.ref != self.self_revive_item.ref;
}

// Namespace item_revive
// Params 4
// Checksum 0xa28ed358, Offset: 0x325
// Size: 0x38, Type: bool
function function_f184dea31c227de3( itembundle, item, autouse, allowswap )
{
    return player::isinlaststand( self ) && laststand::function_ed4da7e5751eed47();
}

// Namespace item_revive
// Params 4
// Checksum 0xba12b77a, Offset: 0x366
// Size: 0x181
function use_revive( itembundle, item, autouse, var_981c264073bf1154 )
{
    var_e63e4b7d091190dc = item.count;
    
    for ( i = 0; i < item.count ; i++ )
    {
        n_max_self_revive = laststand::function_a40d280a3420d81();
        
        if ( laststand::function_7072b516e6cffb7c() < n_max_self_revive )
        {
            laststand::function_a2e03a85015b1897();
            var_e63e4b7d091190dc--;
            
            if ( issubstr( itembundle.ref, "_consumable_self_revive_advanced" ) )
            {
                self setclientomnvar( "ui_self_revive_advanced_acquired", 1 );
                continue;
            }
            
            self setclientomnvar( "ui_self_revive_advanced_acquired", 0 );
        }
    }
    
    if ( item.count > 0 )
    {
        self.self_revive_item = { #name:common_item_database::function_a4f0a21951180013( itembundle.ref ), #ref:itembundle.ref };
    }
    
    if ( isbrgamemode() )
    {
        if ( itembundle.var_4391c2a234042527 )
        {
            thread hud_message::showsplash( itembundle.var_4391c2a234042527 );
        }
        
        if ( player::isinlaststand( self ) )
        {
            if ( self.var_8bec82459b31fc31.owner )
            {
                self.var_8bec82459b31fc31 thread laststand::selfrevivethink();
                
                if ( !player::getbeingrevivedinternal() )
                {
                    self setclientomnvar( "ui_securing_progress", 0.01 );
                    self setclientomnvar( "ui_securing", 16 );
                }
            }
        }
    }
    
    return var_e63e4b7d091190dc;
}

// Namespace item_revive
// Params 1
// Checksum 0x4ee7c673, Offset: 0x4f0
// Size: 0x61
function get_current_revive( params )
{
    if ( self.self_revive_item )
    {
        return { #count:laststand::function_7072b516e6cffb7c(), #ref:self.self_revive_item.ref, #name:self.self_revive_item.name };
    }
}

// Namespace item_revive
// Params 1
// Checksum 0xd0b52a14, Offset: 0x55a
// Size: 0x57
function remove_current_revive( params )
{
    var_8fb8e1fb220cca48 = get_current_revive( params );
    
    if ( var_8fb8e1fb220cca48 && isdefined( self ) )
    {
        if ( issubstr( var_8fb8e1fb220cca48.ref, "advanced" ) )
        {
            self setclientomnvar( "ui_self_revive_advanced_acquired", 0 );
        }
        
        laststand::function_7a1a4fa42d3ac8e3();
    }
    
    return var_8fb8e1fb220cca48;
}

