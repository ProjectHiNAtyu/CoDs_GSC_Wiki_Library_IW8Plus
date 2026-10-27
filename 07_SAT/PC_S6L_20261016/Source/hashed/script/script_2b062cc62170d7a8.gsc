// script_2b062cc62170d7a8  (hash_2b062cc62170d7a8.gscc) (size: 796 Bytes / 0x31c)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a6b4c2d (980110381)
// size ...... 796 (0x31c)
// includes .. 0   (offset: 0x31c)
// strings ... 0   (offset: 0x31c)
// dev strs .. 0   (offset: 0x31c)
// exports ... 5   (offset: 0x234)
// cseg ...... 0x58 + 0x1dc (0x234)
// imports ... 1   (offset: 0x2fc)
// animtree1 . 0   (offset: 0x31c)
// animtree2 . 0   (offset: 0x31c)
#namespace namespace_9fd3ecf626067599;

// Namespace namespace_9fd3ecf626067599
// Params 1
// Checksum 0x46e7af70, Offset: 0x76
// Size: 0x9a
function onplayerjoinsquad( player )
{
    if ( !isdefined( level.onjoinsquadcallbacks ) )
    {
        level.onjoinsquadcallbacks = [];
    }
    
    foreach ( callback in level.onjoinsquadcallbacks )
    {
        self [[ callback ]]( player );
    }
}

// Namespace namespace_9fd3ecf626067599
// Params 1
// Checksum 0x7384c3d, Offset: 0x118
// Size: 0x39
function registeronplayerjoinsquadcallback( callback )
{
    if ( !isdefined( level.onjoinsquadcallbacks ) )
    {
        level.onjoinsquadcallbacks = [];
    }
    
    level.onjoinsquadcallbacks[ level.onjoinsquadcallbacks.size ] = callback;
}

// Namespace namespace_9fd3ecf626067599
// Params 1
// Checksum 0x34410870, Offset: 0x159
// Size: 0x9a
function function_3efb30390246d5d1( player )
{
    if ( !isdefined( level.var_a0608b4c1593ab84 ) )
    {
        level.var_a0608b4c1593ab84 = [];
    }
    
    foreach ( callback in level.var_a0608b4c1593ab84 )
    {
        self [[ callback ]]( player );
    }
}

// Namespace namespace_9fd3ecf626067599
// Params 1
// Checksum 0xdb3112c4, Offset: 0x1fb
// Size: 0x39
function function_ced28cc2c2efdabf( callback )
{
    if ( !isdefined( level.var_a0608b4c1593ab84 ) )
    {
        level.var_a0608b4c1593ab84 = [];
    }
    
    level.var_a0608b4c1593ab84[ level.var_a0608b4c1593ab84.size ] = callback;
}

