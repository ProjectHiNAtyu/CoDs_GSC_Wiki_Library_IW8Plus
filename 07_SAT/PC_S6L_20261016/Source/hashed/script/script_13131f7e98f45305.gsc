// script_13131f7e98f45305  (hash_13131f7e98f45305.gscc) (size: 1123 Bytes / 0x463 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf3684f9a (4083699610)
// size ...... 1123 (0x463)
// includes .. 1   (offset: 0x45b)
// strings ... 0   (offset: 0x463)
// dev strs .. 0   (offset: 0x463)
// exports ... 7   (offset: 0x2af)
// cseg ...... 0x58 + 0x257 (0x2af)
// imports ... 5   (offset: 0x3c7)
// animtree1 . 0   (offset: 0x463)
// animtree2 . 0   (offset: 0x463)
#using scripts\common\callbacks;

#namespace namespace_6107ae6ec81b3c5c;

// Namespace namespace_6107ae6ec81b3c5c
// Params 0
// Checksum 0xd877766, Offset: 0x76
// Size: 0x20
function init()
{
    if ( !isdefined( level.var_b46020f508530c15 ) )
    {
        level.var_b46020f508530c15 = [];
    }
    
    level thread function_c55f66d48e128bb4();
}

// Namespace namespace_6107ae6ec81b3c5c
// Params 0
// Checksum 0x3c619c97, Offset: 0x9e
// Size: 0x30
function function_c55f66d48e128bb4()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player thread function_282245e2743f09e6();
        player thread function_7e73ef4f5b87017f();
    }
}

// Namespace namespace_6107ae6ec81b3c5c
// Params 1
// Checksum 0xdb9057b9, Offset: 0xd6
// Size: 0x39
function function_f13d6a76e92aeee1( callback )
{
    if ( !isdefined( level.var_b46020f508530c15 ) )
    {
        level.var_b46020f508530c15 = [];
    }
    
    level.var_b46020f508530c15[ level.var_b46020f508530c15.size ] = callback;
}

// Namespace namespace_6107ae6ec81b3c5c
// Params 1
// Checksum 0x887542c7, Offset: 0x117
// Size: 0xa0
function function_9dd73e8bda2a8f56( removecallback )
{
    temparray = [];
    
    foreach ( callback in level.var_b46020f508530c15 )
    {
        if ( removecallback != callback )
        {
            temparray[ temparray.size ] = callback;
        }
    }
    
    level.var_b46020f508530c15 = temparray;
}

// Namespace namespace_6107ae6ec81b3c5c
// Params 0
// Checksum 0x3fc79be7, Offset: 0x1bf
// Size: 0xaf
function function_282245e2743f09e6()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( #"reload_start" );
        callback::callback( #"reload_start", { #player:self } );
        
        foreach ( callback in level.var_b46020f508530c15 )
        {
            self [[ callback ]]();
        }
    }
}

// Namespace namespace_6107ae6ec81b3c5c
// Params 0
// Checksum 0xb4890dc8, Offset: 0x276
// Size: 0x39
function function_7e73ef4f5b87017f()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( #"reload_ammo_added" );
        callback::callback( #"reload", { #player:self } );
    }
}

