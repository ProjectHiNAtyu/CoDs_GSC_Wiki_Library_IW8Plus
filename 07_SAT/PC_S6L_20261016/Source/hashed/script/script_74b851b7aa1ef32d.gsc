// script_74b851b7aa1ef32d  (hash_74b851b7aa1ef32d.gscc) (size: 1468 Bytes / 0x5bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b6ece0f (460246543)
// size ...... 1468 (0x5bc)
// includes .. 3   (offset: 0x598)
// strings ... 1   (offset: 0x5b0)
// dev strs .. 0   (offset: 0x5bc)
// exports ... 7   (offset: 0x304)
// cseg ...... 0x78 + 0x28c (0x304)
// imports ... 13  (offset: 0x41c)
// animtree1 . 0   (offset: 0x5bc)
// animtree2 . 0   (offset: 0x5bc)
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\rank;

#namespace namespace_5f4bb62dbf67ff87;

// Namespace namespace_5f4bb62dbf67ff87
// Params 0, eflags: 0x4
// Checksum 0x45228ab5, Offset: 0x96
// Size: 0x5f
function private function_f482ff1e68806249()
{
    if ( !isdefined( level.killswitches ) )
    {
        level.killswitches = {};
    }
    
    level.killswitches.onactionscoreeventsdisabled = getdvarint( hashcat( @"scr_", game_utility::getgametype(), "_disable_onactionscoreevents" ), 0 ) == 1;
    return level.killswitches.onactionscoreeventsdisabled;
}

// Namespace namespace_5f4bb62dbf67ff87
// Params 4
// Checksum 0x67313ab7, Offset: 0xfe
// Size: 0x119
function doonactionscoreevent( eventtype, eventname, cooldown, eventinfo )
{
    if ( level.killswitches.onactionscoreeventsdisabled ?? function_f482ff1e68806249() )
    {
        return;
    }
    
    if ( isbrgamemode() && !isdefined( level.prematchendtime ) )
    {
        return;
    }
    
    var_38ab1a8ecfb1cfbd = gettime();
    
    if ( self.xpcooldowns[ eventname ] > var_38ab1a8ecfb1cfbd )
    {
        return;
    }
    
    if ( !isdefined( cooldown ) )
    {
        cooldown = 12;
    }
    
    self.xpcooldowns[ eventname ] = var_38ab1a8ecfb1cfbd + cooldown * 1000;
    
    switch ( eventtype )
    {
        case 0:
            function_9064e4425483d99( eventname, eventinfo.objweapon );
            break;
        case 1:
            function_ddf098056312770f( eventname, eventinfo.objweapon );
            break;
        case 2:
            function_7cce68765f609de9( eventname );
            break;
        default:
            break;
    }
}

// Namespace namespace_5f4bb62dbf67ff87
// Params 2, eflags: 0x4
// Checksum 0x745aa26e, Offset: 0x21f
// Size: 0x2d
function private function_9064e4425483d99( eventname, var_6ed5e82790ed3fb6 )
{
    function_e9fd42e08bf864c5( hashcat( #"hash_7b86296bccf8ad2e", eventname ), var_6ed5e82790ed3fb6 );
}

// Namespace namespace_5f4bb62dbf67ff87
// Params 2, eflags: 0x4
// Checksum 0x169939cc, Offset: 0x254
// Size: 0x2d
function private function_ddf098056312770f( eventname, var_14715dece1aceaa2 )
{
    function_e9fd42e08bf864c5( hashcat( #"hash_47311f9adb0427ed", eventname ), var_14715dece1aceaa2 );
}

// Namespace namespace_5f4bb62dbf67ff87
// Params 1, eflags: 0x4
// Checksum 0x8c623c19, Offset: 0x289
// Size: 0x23
function private function_7cce68765f609de9( eventname )
{
    function_e9fd42e08bf864c5( hashcat( #"hash_e0041cf80807afae", eventname ), undefined );
}

// Namespace namespace_5f4bb62dbf67ff87
// Params 2, eflags: 0x4
// Checksum 0x37c71414, Offset: 0x2b4
// Size: 0x50
function private function_e9fd42e08bf864c5( var_d92c81ab7ccc0a55, optionalweapon )
{
    points = rank::getscoreinfovalue( var_d92c81ab7ccc0a55 );
    
    if ( isdefined( points ) == 0 )
    {
        return;
    }
    
    thread points::doscoreevent( var_d92c81ab7ccc0a55, optionalweapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
}

