// script_63258e3c8c400b7a  (hash_63258e3c8c400b7a.gscc) (size: 1461 Bytes / 0x5b5)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd944c0d2 (3645161682)
// size ...... 1461 (0x5b5)
// includes .. 0   (offset: 0x5b5)
// strings ... 0   (offset: 0x5b5)
// dev strs .. 0   (offset: 0x5b5)
// exports ... 7   (offset: 0x3d9)
// cseg ...... 0x58 + 0x381 (0x3d9)
// imports ... 7   (offset: 0x4f1)
// animtree1 . 0   (offset: 0x5b5)
// animtree2 . 0   (offset: 0x5b5)
#namespace lui_elems;

// Namespace lui_elems
// Params 2
// Checksum 0x2c46a15a, Offset: 0x76
// Size: 0x11a
function register_lui_elem( luielemname, assethash )
{
    if ( !isdefined( level.luielemregistrations ) )
    {
        level.luielemregistrations = [];
    }
    
    if ( !isdefined( level.var_9eb7757d37cec205 ) )
    {
        level.var_9eb7757d37cec205 = [];
    }
    
    regid = 0;
    
    if ( level.var_9eb7757d37cec205[ assethash ] && level.var_9eb7757d37cec205[ assethash ].size > 0 )
    {
        regid = level.var_9eb7757d37cec205[ assethash ][ 0 ];
        level.var_9eb7757d37cec205[ assethash ][ 0 ] = undefined;
        
        if ( isint( 0 ) )
        {
            function_cdc669dbc8ea2101( level.var_9eb7757d37cec205[ assethash ] );
        }
    }
    else
    {
        if ( !isdefined( level.luielemregistrations[ assethash ] ) )
        {
            level.luielemregistrations[ assethash ] = 0;
        }
        
        regid = level.luielemregistrations[ assethash ];
        level.luielemregistrations[ assethash ]++;
    }
    
    luielem = { #var_1e3e00c2e1be874d:0, #regid:regid, #assethash:assethash, #menuname:luielemname };
    return luielem;
}

// Namespace lui_elems
// Params 2
// Checksum 0x75c392ee, Offset: 0x199
// Size: 0x57
function open_lui_elem( player, flags = 0 )
{
    luielem = self;
    luielem.var_1e3e00c2e1be874d = 1;
    player openluielem( luielem.menuname, luielem.regid, flags );
}

// Namespace lui_elems
// Params 1
// Checksum 0xaf39ff0b, Offset: 0x1f8
// Size: 0x43
function close_lui_elem( player )
{
    luielem = self;
    luielem.var_1e3e00c2e1be874d = 0;
    player closeluielem( luielem.menuname, luielem.regid );
}

// Namespace lui_elems
// Params 1
// Checksum 0xb6f23954, Offset: 0x243
// Size: 0x35
function is_open_lui_elem( player )
{
    luielem = self;
    return player isluielemopenforplayer( luielem.menuname, luielem.regid );
}

// Namespace lui_elems
// Params 3
// Checksum 0x437ad78a, Offset: 0x281
// Size: 0x4b
function function_dccebe4829a93560( player, data, value )
{
    luielem = self;
    player setluielemdata( luielem.menuname, luielem.regid, data, value );
}

// Namespace lui_elems
// Params 2
// Checksum 0x719516cc, Offset: 0x2d4
// Size: 0x105
function unregister_lui_elem( player, forceclose = 0 )
{
    luielem = self;
    
    if ( luielem.var_1e3e00c2e1be874d || forceclose )
    {
        close_lui_elem( player );
    }
    
    if ( isdefined( luielem.assethash ) && isdefined( luielem.regid ) )
    {
        if ( !isdefined( level.var_9eb7757d37cec205 ) )
        {
            level.var_9eb7757d37cec205 = [];
        }
        
        if ( !isdefined( level.var_9eb7757d37cec205[ luielem.assethash ] ) )
        {
            level.var_9eb7757d37cec205[ luielem.assethash ] = [];
        }
        
        level.var_9eb7757d37cec205[ luielem.assethash ][ level.var_9eb7757d37cec205[ luielem.assethash ].size ] = luielem.regid;
    }
    
    luielem.var_1e3e00c2e1be874d = 0;
    luielem.regid = undefined;
    luielem.assethash = undefined;
}

