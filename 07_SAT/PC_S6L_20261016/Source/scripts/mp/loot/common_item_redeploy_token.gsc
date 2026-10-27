// scripts\mp\loot\common_item_redeploy_token.gsc  (hash_3db62fe8fa12f469.gscc) (size: 3230 Bytes / 0xc9e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe47006a9 (3832546985)
// size ...... 3230 (0xc9e)
// includes .. 5   (offset: 0xc0e)
// strings ... 3   (offset: 0xc36)
// dev strs .. 3   (offset: 0xc7a)
// exports ... 13  (offset: 0x6ce)
// cseg ...... 0x96 + 0x638 (0x6ce)
// imports ... 26  (offset: 0x8d6)
// animtree1 . 0   (offset: 0xc9e)
// animtree2 . 0   (offset: 0xc9e)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_redeploy_token;

// Namespace item_redeploy_token
// Params 0, eflags: 0x5
// Checksum 0x90edc610, Offset: 0xb4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_redeploy_token", #"common_item", &init, undefined );
}

// Namespace item_redeploy_token
// Params 0
// Checksum 0x807ea2db, Offset: 0xdd
// Size: 0x16b
function init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "redeploy_token" );
    common_item::function_84174b793b5fe9a7( "redeploy_token", #"use", &function_4ce0d918567b67b2 );
    common_item::function_84174b793b5fe9a7( "redeploy_token", #"hash_9e49dfaa7c147654", &function_627afdc6e4ed4c0e );
    common_item::function_84174b793b5fe9a7( "redeploy_token", #"getcurrent", &function_c21e6cd7dad2d0a2 );
    common_item::function_84174b793b5fe9a7( "redeploy_token", #"removecurrent", &function_3b6714661ceb18e0 );
    utility::registersharedfunc( #"game", #"respawntokendisabled", &items_respawntokendisabled );
    utility::registersharedfunc( #"game", #"hash_b4cec77d706797e", &function_627afdc6e4ed4c0e );
    level.commonitem.respawntokenenabled = level.gametypebundle.respawntokenenabled && getdvarint( @"scr_br_respawn_token", 1 );
    level.commonitem.respawntokenclosewithgulag = level.gametypebundle.respawntokenclosewithgulag && getdvarint( @"scr_br_respawn_token_gulag", 1 );
    level.commonitem.var_96c6db3968fdcac0 = level.gametypebundle.var_96c6db3968fdcac0 && getdvarint( @"hash_fbd4a4c8aa273539", 1 );
}

// Namespace item_redeploy_token
// Params 0
// Checksum 0xe738f737, Offset: 0x250
// Size: 0xc, Type: bool
function function_6932ae7663f88c8e()
{
    return istrue( self.hasrespawntoken );
}

// Namespace item_redeploy_token
// Params 4
// Checksum 0x138cf395, Offset: 0x265
// Size: 0x47
function function_4ce0d918567b67b2( itembundle, item, autouse, var_981c264073bf1154 )
{
    function_190ce3e2e0f50a8a( itembundle.scriptable );
    return item.count - 1;
}

// Namespace item_redeploy_token
// Params 4
// Checksum 0x78190e7f, Offset: 0x2b5
// Size: 0x40, Type: bool
function function_627afdc6e4ed4c0e( itembundle, item, autouse, allowswap )
{
    if ( !br_public::function_2d9074b461a9f5cb() )
    {
        return !function_6932ae7663f88c8e();
    }
    
    return !br_public::function_f8e966575e96628e();
}

// Namespace item_redeploy_token
// Params 1
// Checksum 0x7e1fa33a, Offset: 0x2fe
// Size: 0x65
function function_c21e6cd7dad2d0a2( params )
{
    if ( function_6932ae7663f88c8e() )
    {
        if ( br_public::function_2d9074b461a9f5cb() && !br_public::function_f8e966575e96628e() )
        {
            return;
        }
        
        name = common_item_database::function_ca9ca606e66b5911( self.var_619e717b9a2fcdaa ?? "brloot_redeploy_token" );
        return { #count:1, #name:name };
    }
}

// Namespace item_redeploy_token
// Params 0
// Checksum 0xa945b313, Offset: 0x36c
// Size: 0x3c
function function_e63583d1a42b616c()
{
    if ( br_public::function_2d9074b461a9f5cb() )
    {
        var_7237854e3be197ca = self.var_ccf5a598b0d5582e;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    else if ( self.hasrespawntoken )
    {
        return 1;
    }
    
    return 0;
}

// Namespace item_redeploy_token
// Params 1
// Checksum 0x25b6f1bf, Offset: 0x3b1
// Size: 0x2f
function function_3b6714661ceb18e0( params )
{
    var_8fb8e1fb220cca48 = function_c21e6cd7dad2d0a2( params );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        function_16ab0a48337237ef();
    }
    
    return var_8fb8e1fb220cca48;
}

// Namespace item_redeploy_token
// Params 1
// Checksum 0x6ef75d72, Offset: 0x3e9
// Size: 0xba
function function_190ce3e2e0f50a8a( scriptablename )
{
    if ( br_public::function_2d9074b461a9f5cb() )
    {
        if ( br_public::function_f8e966575e96628e() )
        {
            return;
        }
        
        if ( !isdefined( self.var_ccf5a598b0d5582e ) || self.var_ccf5a598b0d5582e < 0 )
        {
            self.var_ccf5a598b0d5582e = 0;
        }
        
        self.var_ccf5a598b0d5582e += 1;
        br_public::updatebrscoreboardstat( "numRespawnToken", self.var_ccf5a598b0d5582e );
    }
    else
    {
        assert( !function_6932ae7663f88c8e(), "<dev string:x24>" );
    }
    
    self.var_619e717b9a2fcdaa = scriptablename ?? self.var_619e717b9a2fcdaa ?? "brloot_redeploy_token";
    self.hasrespawntoken = 1;
    br_public::sethasrespawntokenextrainfo( 1 );
}

// Namespace item_redeploy_token
// Params 1
// Checksum 0x610ac005, Offset: 0x4ab
// Size: 0xc5
function function_16ab0a48337237ef( var_3bb4bc8fc499e96b )
{
    if ( br_public::function_2d9074b461a9f5cb() )
    {
        if ( var_3bb4bc8fc499e96b )
        {
            self.var_ccf5a598b0d5582e = 0;
        }
        else
        {
            assert( isdefined( self.var_ccf5a598b0d5582e ), "<dev string:x48>" );
            assert( br_public::function_ec4d7cb61b4d915e() > 0, "<dev string:x7e>" );
            
            if ( br_public::function_ec4d7cb61b4d915e() <= 0 )
            {
                return;
            }
            
            self.var_ccf5a598b0d5582e -= 1;
        }
        
        br_public::updatebrscoreboardstat( "numRespawnToken", self.var_ccf5a598b0d5582e );
        
        if ( self.var_ccf5a598b0d5582e > 0 )
        {
            return;
        }
    }
    else
    {
        assert( function_6932ae7663f88c8e() );
    }
    
    self.hasrespawntoken = 0;
    self.var_619e717b9a2fcdaa = undefined;
    br_public::sethasrespawntokenextrainfo( 0 );
}

// Namespace item_redeploy_token
// Params 0
// Checksum 0xc6acf357, Offset: 0x578
// Size: 0xb1
function items_respawntokendisabled()
{
    if ( !level.commonitem.respawntokenenabled )
    {
        return 1;
    }
    
    if ( isdefined( level.gulag ) && level.gulag.shutdown && level.commonitem.respawntokenclosewithgulag )
    {
        return 1;
    }
    
    if ( isdefined( level.brgametype.respawnenable ) && !level.brgametype.respawnenable && level.commonitem.var_96c6db3968fdcac0 )
    {
        return 1;
    }
    
    return getdvarint( @"hash_4d250e4873e1753e", 0 );
}

// Namespace item_redeploy_token
// Params 0
// Checksum 0x6228cc3a, Offset: 0x632
// Size: 0x9c
function function_a8dbeb883ac6e5d4()
{
    if ( !br_public::function_2d9074b461a9f5cb() )
    {
        return;
    }
    
    if ( isdefined( self.var_ccf5a598b0d5582e ) )
    {
        return;
    }
    
    self.var_ccf5a598b0d5582e = getdvarint( @"hash_986abd5a9e818046", 0 );
    self.hasrespawntoken = self.var_ccf5a598b0d5582e > 0 ? 1 : 0;
    
    if ( self.var_ccf5a598b0d5582e > 0 )
    {
        if ( !isdefined( self.var_619e717b9a2fcdaa ) )
        {
            self.var_619e717b9a2fcdaa = "brloot_redeploy_token";
        }
    }
    
    br_public::updatebrscoreboardstat( "numRespawnToken", self.var_ccf5a598b0d5582e );
    br_public::sethasrespawntokenextrainfo( self.hasrespawntoken );
}

