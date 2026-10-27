// scripts\mp\common\equipment\scuba_gasmask.gsc  (hash_55f74959b17f5e8d.gscc) (size: 1767 Bytes / 0x6e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd3d39ef4 (3553861364)
// size ...... 1767 (0x6e7)
// includes .. 4   (offset: 0x6b7)
// strings ... 1   (offset: 0x6d7)
// dev strs .. 0   (offset: 0x6e7)
// exports ... 9   (offset: 0x353)
// cseg ...... 0x66 + 0x2ed (0x353)
// imports ... 17  (offset: 0x4bb)
// animtree1 . 0   (offset: 0x6e7)
// animtree2 . 0   (offset: 0x6e7)
#using scripts\common\gasmask;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_pickups;

#namespace scuba_gasmask;

// Namespace scuba_gasmask
// Params 0
// Checksum 0xee1e5031, Offset: 0x84
// Size: 0xb6
function init()
{
    utility::registersharedfunc( #"scubagasmask", #"hasscubagasmask", &hasscubagasmask );
    utility::registersharedfunc( #"scubagasmask", #"isscubagasmaskequipped", &isscubagasmaskequipped );
    utility::registersharedfunc( #"scubagasmask", #"removescubagasmaskfromplayer", &removescubagasmaskfromplayer );
    utility::registersharedfunc( #"scubagasmask", #"updatescubagasmask", &updatescubagasmask );
    utility::registersharedfunc( #"scubagasmask", #"monitorscubagasmaskdamage", &function_7f005ffe7b976cb4 );
    utility::registersharedfunc( #"scubagasmask", #"isusingscubagasmask", &isusingscubagasmask );
}

// Namespace scuba_gasmask
// Params 1, eflags: 0x4
// Checksum 0xec0bc800, Offset: 0x142
// Size: 0x16, Type: bool
function private isusingscubagasmask( player )
{
    return istrue( self.usingscubagasmask );
}

// Namespace scuba_gasmask
// Params 1
// Checksum 0x53ffe018, Offset: 0x161
// Size: 0x20, Type: bool
function hasscubagasmask( player )
{
    return isusingscubagasmask( player ) && gasmask::hasgasmask( player );
}

// Namespace scuba_gasmask
// Params 1
// Checksum 0x5e82fcfa, Offset: 0x18a
// Size: 0x20, Type: bool
function isscubagasmaskequipped( player )
{
    return hasscubagasmask( player ) && gasmask::function_799e5d7cad9440ce( player );
}

// Namespace scuba_gasmask
// Params 1
// Checksum 0xded6f057, Offset: 0x1b3
// Size: 0x22
function removescubagasmaskfromplayer( player )
{
    if ( hasscubagasmask( player ) )
    {
        player.usingscubagasmask = undefined;
    }
}

// Namespace scuba_gasmask
// Params 2
// Checksum 0x61f43fd1, Offset: 0x1dd
// Size: 0x35
function updatescubagasmask( player, isunderwater )
{
    if ( isdefined( player ) && isdefined( player.origin ) )
    {
        level thread function_c78ef04c701bb8d3( player, isunderwater );
    }
}

// Namespace scuba_gasmask
// Params 2
// Checksum 0xde8d09d5, Offset: 0x21a
// Size: 0x87
function function_c78ef04c701bb8d3( player, isunderwater )
{
    player endon( #"death_or_disconnect" );
    player notify( #"queue_scuba" );
    player endon( #"queue_scuba" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !player.gasmaskswapinprogress )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isunderwater )
    {
        player br_pickups::gasmaskon( "underwater" );
        return;
    }
    
    player br_pickups::gasmaskoff( "underwater" );
}

// Namespace scuba_gasmask
// Params 0
// Checksum 0xe7f29363, Offset: 0x2a9
// Size: 0xaa
function function_7f005ffe7b976cb4()
{
    self endon( #"death_or_disconnect" );
    self endon( #"swim_breathing_disabled_end" );
    level endon( #"game_ended" );
    var_47ec9e26280ec273 = getdvarfloat( @"hash_4a852245a5077873", 1 );
    damagepertick = getdvarfloat( @"hash_8d16d3f760df5419", 0.857 );
    
    while ( true )
    {
        if ( !swim_common::isplayerunderwater() )
        {
            break;
        }
        
        if ( !hasscubagasmask( self ) )
        {
            break;
        }
        
        if ( isdefined( self.origin ) && !self.plotarmor )
        {
            gasmask::processdamage( damagepertick );
        }
        
        wait var_47ec9e26280ec273;
    }
}

