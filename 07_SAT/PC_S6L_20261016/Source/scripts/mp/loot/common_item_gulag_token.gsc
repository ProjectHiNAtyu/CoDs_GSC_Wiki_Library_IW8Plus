// scripts\mp\loot\common_item_gulag_token.gsc  (hash_29b32ebeb4c0edb7.gscc) (size: 2285 Bytes / 0x8ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5f0cd2 (224333010)
// size ...... 2285 (0x8ed)
// includes .. 7   (offset: 0x87d)
// strings ... 3   (offset: 0x8b5)
// dev strs .. 0   (offset: 0x8ed)
// exports ... 12  (offset: 0x3fd)
// cseg ...... 0x96 + 0x367 (0x3fd)
// imports ... 23  (offset: 0x5dd)
// animtree1 . 0   (offset: 0x8ed)
// animtree2 . 0   (offset: 0x8ed)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_gulag_token;

// Namespace item_gulag_token
// Params 0, eflags: 0x5
// Checksum 0xa0285ac1, Offset: 0xb4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_gulag_token", #"common_item", &init, undefined );
}

// Namespace item_gulag_token
// Params 0
// Checksum 0x444949f6, Offset: 0xdd
// Size: 0xfb
function init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "gulag_token" );
    common_item::function_84174b793b5fe9a7( "gulag_token", #"use", &function_4386b0fbc37c44c2 );
    common_item::function_84174b793b5fe9a7( "gulag_token", #"hash_9e49dfaa7c147654", &function_4e88e10e7a03e87e );
    common_item::function_84174b793b5fe9a7( "gulag_token", #"getcurrent", &function_40888a5fae129832 );
    common_item::function_84174b793b5fe9a7( "gulag_token", #"removecurrent", &function_38cabd015a870970 );
    utility::registersharedfunc( #"game", #"hash_6b72f04a5e268f64", &function_930089fa4b1ddf76 );
    level.commonitem.var_1a2dcc64a08f0324 = getdvarint( @"scr_br_gulag_token", 1 );
    level.commonitem.var_7dc8a97db7af6e3 = getdvarint( @"scr_br_gulag_token_gulag", 1 );
    level callback::add( #"hash_a20e721cf931b9d0", &function_533c1312826918cc );
}

// Namespace item_gulag_token
// Params 4
// Checksum 0x19417dd9, Offset: 0x1e0
// Size: 0x3d
function function_4386b0fbc37c44c2( itembundle, item, autouse, var_981c264073bf1154 )
{
    function_f6d2dff183e0c81a( 0 );
    return item.count - 1;
}

// Namespace item_gulag_token
// Params 4
// Checksum 0x8d2cc86, Offset: 0x226
// Size: 0x2e, Type: bool
function function_4e88e10e7a03e87e( itembundle, item, autouse, allowswap )
{
    return !function_322bfd131afa413e();
}

// Namespace item_gulag_token
// Params 1
// Checksum 0x284eb95d, Offset: 0x25d
// Size: 0x44
function function_40888a5fae129832( params )
{
    if ( function_322bfd131afa413e() )
    {
        name = common_item_database::function_ca9ca606e66b5911( "brloot_gulag_token" );
        return { #count:1, #name:name };
    }
}

// Namespace item_gulag_token
// Params 1
// Checksum 0x5264a2b1, Offset: 0x2aa
// Size: 0x2f
function function_38cabd015a870970( params )
{
    var_8fb8e1fb220cca48 = function_40888a5fae129832( params );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        function_10b12e3b4eaa98df();
    }
    
    return var_8fb8e1fb220cca48;
}

// Namespace item_gulag_token
// Params 0
// Checksum 0xc1d600db, Offset: 0x2e2
// Size: 0xc, Type: bool
function function_322bfd131afa413e()
{
    return istrue( self.var_70c1f4b75530023f );
}

// Namespace item_gulag_token
// Params 1
// Checksum 0x5482608c, Offset: 0x2f7
// Size: 0x3c
function function_f6d2dff183e0c81a( skipsplash )
{
    if ( !function_322bfd131afa413e() )
    {
        self.var_70c1f4b75530023f = 1;
        br_public::function_99e432af35c80c99( 1 );
        
        if ( !skipsplash )
        {
            thread hud_message::showsplash( "br_gulag_token_pickup" );
        }
    }
}

// Namespace item_gulag_token
// Params 0
// Checksum 0xf85647bc, Offset: 0x33b
// Size: 0x1d
function function_10b12e3b4eaa98df()
{
    if ( function_322bfd131afa413e() )
    {
        self.var_70c1f4b75530023f = 0;
        br_public::sethasrespawntokenextrainfo( 0 );
    }
}

// Namespace item_gulag_token
// Params 0
// Checksum 0x7896c24b, Offset: 0x360
// Size: 0x6c, Type: bool
function function_930089fa4b1ddf76()
{
    tokendisabled = !level.commonitem.var_1a2dcc64a08f0324;
    gulagdisabled = level.commonitem.var_7dc8a97db7af6e3 && isdefined( level.gulag ) && level.gulag.shutdown;
    return tokendisabled || gulagdisabled;
}

// Namespace item_gulag_token
// Params 1
// Checksum 0xee14df07, Offset: 0x3d5
// Size: 0x27, Type: bool
function function_533c1312826918cc( params )
{
    return function_930089fa4b1ddf76() && params.itemkey == "brloot_gulag_token";
}

