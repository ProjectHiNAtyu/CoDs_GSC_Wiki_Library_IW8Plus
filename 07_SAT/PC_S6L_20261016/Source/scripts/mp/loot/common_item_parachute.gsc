// scripts\mp\loot\common_item_parachute.gsc  (hash_5508e68d26cfa616.gscc) (size: 3284 Bytes / 0xcd4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2b31d4 (237711828)
// size ...... 3284 (0xcd4)
// includes .. 7   (offset: 0xc1c)
// strings ... 6   (offset: 0xc54)
// dev strs .. 0   (offset: 0xcd4)
// exports ... 13  (offset: 0x68c)
// cseg ...... 0xb4 + 0x5d8 (0x68c)
// imports ... 30  (offset: 0x894)
// animtree1 . 0   (offset: 0xcd4)
// animtree2 . 0   (offset: 0xcd4)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\quickprompt;

#namespace common_item_parachute;

// Namespace common_item_parachute
// Params 0, eflags: 0x5
// Checksum 0x96c5c1b8, Offset: 0xd2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_parachute", #"common_item", &init_item_parachute, undefined );
}

// Namespace common_item_parachute
// Params 0
// Checksum 0x4ea332c, Offset: 0xfb
// Size: 0xe4
function init_item_parachute()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "parachute" );
    common_item::function_84174b793b5fe9a7( "parachute", #"use", &use_parachute );
    common_item::function_84174b793b5fe9a7( "parachute", #"canautouse", &function_5822363eefc0c325 );
    common_item::function_84174b793b5fe9a7( "parachute", #"hash_9e49dfaa7c147654", &function_5822363eefc0c325 );
    common_item::function_84174b793b5fe9a7( "parachute", #"caninteract", &can_interact );
    common_item::function_84174b793b5fe9a7( "parachute", #"removecurrent", &remove_current_parachute );
    common_item::function_84174b793b5fe9a7( "parachute", #"getcurrent", &get_current_item_parachute );
    common_item::function_84174b793b5fe9a7( "parachute", #"database_additem", &function_e0c2c29a7bd50d36 );
    callback::add( #"parachute_opened", &function_ae1ffeb4ec440a25 );
}

// Namespace common_item_parachute
// Params 4
// Checksum 0x386adc96, Offset: 0x1e7
// Size: 0x88
function function_5822363eefc0c325( itembundle, item, auto_use, var_51e0c31d31f04b31 )
{
    if ( isdefined( item.type ) && utility::issharedfuncdefined( item.type, #"hash_2e22b6be73e28e05" ) )
    {
        var_93ca4f09d0d5e3f8 = self [[ utility::getsharedfunc( item.type, #"hash_2e22b6be73e28e05" ) ]]( itembundle, item, auto_use, var_51e0c31d31f04b31 );
        return var_93ca4f09d0d5e3f8;
    }
    
    return 1;
}

// Namespace common_item_parachute
// Params 4
// Checksum 0x4c6704ff, Offset: 0x278
// Size: 0x4c
function use_parachute( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( self.parachuteid )
    {
        return item.count;
    }
    
    set_has_parachute( 1, itembundle, item );
    return 0;
}

// Namespace common_item_parachute
// Params 2, eflags: 0x40 variadic
// Checksum 0xca71e49c, Offset: 0x2cd
// Size: 0x65
function get_current_item_parachute( ... )
{
    if ( self.parachuteid )
    {
        name = common_item_database::function_db2360bc1c33f6f9( self.parachuteid );
        
        if ( name )
        {
            return { #count:self.var_95c08e89b1ad4839 ?? 1, #name:name };
        }
    }
}

// Namespace common_item_parachute
// Params 1
// Checksum 0xf2e0cf2e, Offset: 0x33b
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

// Namespace common_item_parachute
// Params 2, eflags: 0x40 variadic
// Checksum 0x7c542c9a, Offset: 0x3c2
// Size: 0x3f
function remove_current_parachute( ... )
{
    if ( !self.parachuteid )
    {
        return;
    }
    
    currentparachute = get_current_item_parachute();
    set_has_parachute( 0 );
    return currentparachute;
}

// Namespace common_item_parachute
// Params 3, eflags: 0x4
// Checksum 0xd99c992f, Offset: 0x40a
// Size: 0x101
function private set_has_parachute( var_bf98b84ed85e62cd, itembundle, item )
{
    if ( itembundle )
    {
        self.parachuteid = common_item::function_779887309ec71dfe( itembundle );
    }
    else
    {
        self.parachuteid = undefined;
    }
    
    self.var_95c08e89b1ad4839 = itembundle.var_ce8c6e2548d43c80 ? item.count : undefined;
    val::set( "parachute", "base_jumping", var_bf98b84ed85e62cd );
    
    if ( hasomnvar( "ui_parachute_id" ) )
    {
        if ( self.parachuteid )
        {
            self setclientomnvar( "ui_parachute_id", self.parachuteid );
            self setclientomnvar( "ui_parachute_quantity", item.count );
        }
        else
        {
            self setclientomnvar( "ui_parachute_id", 0 );
            self setclientomnvar( "ui_parachute_quantity", 0 );
        }
    }
    
    if ( var_bf98b84ed85e62cd && itembundle.var_ce8c6e2548d43c80 )
    {
        thread function_4b738f5059cfefc4();
        return;
    }
    
    self notify( #"removed_parachute" );
}

// Namespace common_item_parachute
// Params 0, eflags: 0xc
// Checksum 0x834d34ae, Offset: 0x513
// Size: 0x5a
function private function_4b738f5059cfefc4()
{
    self notify( #"hash_7e4953fcb5ce49d3" );
    self endon( #"hash_7e4953fcb5ce49d3" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"removed_parachute" );
    
    while ( true )
    {
        self waittill( #"skydive_deployparachute" );
        function_ae1ffeb4ec440a25();
    }
}

// Namespace common_item_parachute
// Params 1, eflags: 0x4
// Checksum 0x3ac53475, Offset: 0x575
// Size: 0xa4
function private function_ae1ffeb4ec440a25( params )
{
    if ( !self.parachuteid || !self.var_95c08e89b1ad4839 )
    {
        return;
    }
    
    self.var_95c08e89b1ad4839--;
    self setclientomnvar( "ui_parachute_quantity", self.var_95c08e89b1ad4839 );
    
    if ( self.var_95c08e89b1ad4839 > 0 )
    {
        return;
    }
    
    if ( level.gamemodebundle.var_9e7d5810e8c3bfcc )
    {
        thread quickprompt::function_661f2ac4b89488a1( level.gamemodebundle.var_9e7d5810e8c3bfcc );
    }
    
    self setentitysoundcontext( "parachute", "last" );
    thread function_1c02e05a47d29a35();
    thread remove_current_parachute( self );
}

// Namespace common_item_parachute
// Params 0, eflags: 0x4
// Checksum 0x30a81559, Offset: 0x621
// Size: 0x4c
function private function_1c02e05a47d29a35()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !self isparachutedeployed() )
    {
        while ( !self isparachutedeployed() )
        {
            waitframe();
        }
    }
    
    while ( self isparachutedeployed() )
    {
        waitframe();
    }
    
    self setentitysoundcontext( "parachute", "default" );
}

// Namespace common_item_parachute
// Params 1, eflags: 0x4
// Checksum 0xd83d15fc, Offset: 0x675
// Size: 0x17
function private function_e0c2c29a7bd50d36( itembundlename )
{
    level.var_60df68ace0baea06 = 1;
}

