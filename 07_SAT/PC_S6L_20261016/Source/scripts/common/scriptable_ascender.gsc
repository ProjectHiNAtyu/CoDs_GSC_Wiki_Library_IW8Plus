// scripts\common\scriptable_ascender.gsc  (hash_268072edcb8068d1.gscc) (size: 1325 Bytes / 0x52d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x36009808 (906008584)
// size ...... 1325 (0x52d)
// includes .. 1   (offset: 0x4ed)
// strings ... 4   (offset: 0x4f5)
// dev strs .. 0   (offset: 0x52d)
// exports ... 7   (offset: 0x345)
// cseg ...... 0x87 + 0x2be (0x345)
// imports ... 5   (offset: 0x45d)
// animtree1 . 0   (offset: 0x52d)
// animtree2 . 0   (offset: 0x52d)
#using scripts\common\values;

#namespace scriptable_ascender;

// Namespace scriptable_ascender
// Params 1
// Checksum 0x682b8290, Offset: 0xa5
// Size: 0x17
function function_959621fba91be23a( var_3ae5eb2fb5d3efbb )
{
    level.var_bb575808409344ee = var_3ae5eb2fb5d3efbb;
}

// Namespace scriptable_ascender
// Params 1
// Checksum 0xf2188888, Offset: 0xc4
// Size: 0x17
function function_432ef320b0c53fcd( canusecallback )
{
    level.ascender_can_use = canusecallback;
}

// Namespace scriptable_ascender
// Params 1
// Checksum 0x653864d5, Offset: 0xe3
// Size: 0x39
function function_784813a62abce5fe( usedcallback )
{
    if ( !isdefined( level.var_79d0243547ca5195 ) )
    {
        level.var_79d0243547ca5195 = [];
    }
    
    level.var_79d0243547ca5195[ level.var_79d0243547ca5195.size ] = usedcallback;
}

// Namespace scriptable_ascender
// Params 6
// Checksum 0x2cb62bd0, Offset: 0x124
// Size: 0xb3
function function_4b79d00966274afd( instance, player, edgeindex, isvertical, isinverted, isgoingup )
{
    if ( instance.forcedisabled || !player val::get( "ascender_use" ) )
    {
        s = spawnstruct();
        s.type = "HINT_NOBUTTON";
        s.string = &"";
        return s;
    }
    
    if ( isdefined( level.var_bb575808409344ee ) )
    {
        return [[ level.var_bb575808409344ee ]]( instance, player, edgeindex, isvertical, isinverted, isgoingup );
    }
}

// Namespace scriptable_ascender
// Params 5
// Checksum 0x8c590b12, Offset: 0x1e0
// Size: 0x99
function function_3964a642425ff608( instance, player, edgeindex, isinverted, isvertical )
{
    if ( instance.forcedisabled || !player val::get( "ascender_use" ) )
    {
        return 0;
    }
    
    if ( isdefined( level.ascender_can_use ) )
    {
        return [[ level.ascender_can_use ]]( instance, player, edgeindex, isinverted, isvertical );
    }
    
    if ( instance getscriptablehaspart( "top" ) && instance getscriptablepartstate( "top" ) != "use" )
    {
        return 0;
    }
    
    return 1;
}

// Namespace scriptable_ascender/event_89502489b930db54
// Params 6, eflags: 0x20
// Checksum 0x25b42a56, Offset: 0x282
// Size: 0xc3
function event_handler[event_89502489b930db54] function_89502489b930db54( instance, player, edgeindex, isinverted, isvertical, ascendervec )
{
    if ( isdefined( level.var_79d0243547ca5195 ) )
    {
        foreach ( used_func in level.var_79d0243547ca5195 )
        {
            [[ used_func ]]( instance, player, edgeindex, isinverted, isvertical, ascendervec );
        }
    }
}

