// scripts\mp\loot\common_item_quest.gsc  (hash_4df88f92d46bd747.gscc) (size: 2432 Bytes / 0x980 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ea13246 (1050751558)
// size ...... 2432 (0x980)
// includes .. 6   (offset: 0x908)
// strings ... 4   (offset: 0x938)
// dev strs .. 0   (offset: 0x980)
// exports ... 7   (offset: 0x57c)
// cseg ...... 0xa1 + 0x4db (0x57c)
// imports ... 21  (offset: 0x694)
// animtree1 . 0   (offset: 0x980)
// animtree2 . 0   (offset: 0x980)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\loot\common_collectible;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\squads;

#namespace common_item_quest;

// Namespace common_item_quest
// Params 0
// Checksum 0xb9c5898, Offset: 0xbf
// Size: 0xaa
function init_item_quest()
{
    common_item::function_4b30c091d3b04a25( "quest" );
    common_item::function_84174b793b5fe9a7( "quest", #"use", &use_quest );
    common_item::function_84174b793b5fe9a7( "quest", #"canautouse", &function_36d32235ef960500 );
    common_item::function_84174b793b5fe9a7( "quest", #"hash_9e49dfaa7c147654", &function_36d32235ef960500 );
    common_item::function_84174b793b5fe9a7( "quest", #"caninteract", &can_interact );
    common_item::function_84174b793b5fe9a7( "quest", #"hash_f2486ea3c2669567", &on_pickup_success );
    common_item::function_84174b793b5fe9a7( "quest", #"hash_549c36915774594e", &utility::always_true );
}

// Namespace common_item_quest
// Params 4
// Checksum 0xfe7ad4df, Offset: 0x171
// Size: 0x88
function function_36d32235ef960500( itembundle, item, auto_use, var_51e0c31d31f04b31 )
{
    if ( isdefined( item.type ) && utility::issharedfuncdefined( item.type, #"hash_2e22b6be73e28e05" ) )
    {
        var_93ca4f09d0d5e3f8 = self [[ utility::getsharedfunc( item.type, #"hash_2e22b6be73e28e05" ) ]]( itembundle, item, auto_use, var_51e0c31d31f04b31 );
        return var_93ca4f09d0d5e3f8;
    }
    
    return 1;
}

// Namespace common_item_quest
// Params 4
// Checksum 0xbe279498, Offset: 0x202
// Size: 0x1ea, Type: bool
function use_quest( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( itembundle.subtype == "collectible" )
    {
        result = common_collectible::obtaincollectible( itembundle, item );
        
        if ( result )
        {
            common_item::function_2e0436a8625e3515( itembundle, 1 );
            common_item::function_e70f64f8d4664b9e( self, item, 1, undefined, undefined, undefined, autouse );
            self notify( #"self_pickedupitem", getxhashasset( item.type ) );
        }
        
        return true;
    }
    
    if ( level.gamemodebundle.var_f3f1bc07a5a9a294 )
    {
        funcs = common_inventory_groups::function_987405ff5ee23e99( 7 );
        
        if ( isdefined( funcs.tofunc ) && isdefined( funcs.var_65a6f7922d118cdd ) )
        {
            index = common_inventory_groups::function_76928b4f093ca1ad( 7, itembundle, undefined, item );
            
            if ( index )
            {
                [ groupbundle, _ ] = self [[ funcs.var_65a6f7922d118cdd ]]();
                [ row, column ] = common_inventory_groups::function_12ee5af12df204b4( groupbundle, index );
            }
            
            [[ funcs.tofunc ]]( item, row, column );
        }
    }
    
    if ( autouse )
    {
        callback::callback( "quest_item_used", { #player:self, #scriptable:item, #bundle:itembundle } );
    }
    
    if ( isdefined( item.type ) && utility::issharedfuncdefined( item.type, #"onuse" ) )
    {
        self [[ utility::getsharedfunc( item.type, #"onuse" ) ]]( itembundle, item, autouse, var_981c264073bf1154 );
    }
    
    return false;
}

// Namespace common_item_quest
// Params 1
// Checksum 0xe8f28bb7, Offset: 0x3f5
// Size: 0x7e
function can_interact( itemstruct )
{
    item = itemstruct.item;
    
    if ( isdefined( item.type ) && utility::issharedfuncdefined( item.type, #"caninteract" ) )
    {
        caninteract = self [[ utility::getsharedfunc( item.type, #"caninteract" ) ]]( itemstruct );
        return caninteract;
    }
    
    return 1;
}

// Namespace common_item_quest
// Params 2
// Checksum 0x132b56b4, Offset: 0x47c
// Size: 0x1e
function on_pickup_success( itembundle, lootid )
{
    function_19b7bcd568b698f3( lootid );
}

// Namespace common_item_quest
// Params 1
// Checksum 0xc55f6fa1, Offset: 0x4a2
// Size: 0xda
function function_19b7bcd568b698f3( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    [ squadmemberindex, squadmates ] = squads::function_53d0f06555f0036b();
    
    if ( !isdefined( squadmemberindex ) || !isdefined( squadmates ) || squadmates.size == 1 )
    {
        return;
    }
    
    foreach ( player in squadmates )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( "ui_quest_item_squad_index_" + squadmemberindex, lootid );
        }
    }
}

