// scripts\mp\br\gametypes\br_gametypes.gsc  (hash_6e874715492d7515.gscc) (size: 1149 Bytes / 0x47d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfed34cf8 (4275260664)
// size ...... 1149 (0x47d)
// includes .. 1   (offset: 0x469)
// strings ... 1   (offset: 0x471)
// dev strs .. 0   (offset: 0x47d)
// exports ... 7   (offset: 0x275)
// cseg ...... 0x6a + 0x20b (0x275)
// imports ... 7   (offset: 0x38d)
// animtree1 . 0   (offset: 0x47d)
// animtree2 . 0   (offset: 0x47d)
#using scripts\common\callbacks;

#namespace br_gametypes;

// Namespace br_gametypes
// Params 0
// Checksum 0x9ac08a51, Offset: 0x88
// Size: 0x90
function init()
{
    level.brgametype = spawnstruct();
    level.brgametype.funcs = [];
    level.brgametype.disabledfeatures = [];
    level.brgametype.enabledfeatures = [];
    level.brgametype.data = [];
    function_13315e0ebd35a643();
    
    if ( isdefined( level.var_dd10333ade220938 ) )
    {
        [[ level.var_dd10333ade220938 ]]();
    }
    
    level callback::callback( "brGametypeInit" );
}

// Namespace br_gametypes
// Params 0
// Checksum 0x1ffabd67, Offset: 0x120
// Size: 0x59
function function_13315e0ebd35a643()
{
    level.br_circle_disabled = level.gametypebundle.disablecircles;
    
    if ( getdvarint( @"scr_br_circle_disable", 0 ) == 1 )
    {
        level.br_circle_disabled = 1;
    }
    
    if ( level.br_circle_disabled )
    {
        disablefeature( #"circle" );
    }
}

// Namespace br_gametypes
// Params 1
// Checksum 0x99f221f0, Offset: 0x181
// Size: 0x34
function disablefeature( featurename )
{
    assert( !isstring( featurename ) );
    level.brgametype.disabledfeatures[ featurename ] = 1;
}

// Namespace br_gametypes
// Params 1
// Checksum 0x314bb286, Offset: 0x1bd
// Size: 0x40, Type: bool
function isfeaturedisabled( featurename )
{
    assert( !isstring( featurename ) );
    return !isdefined( level.brgametype ) || level.brgametype.disabledfeatures[ featurename ];
}

// Namespace br_gametypes
// Params 1
// Checksum 0x98e4270f, Offset: 0x206
// Size: 0x34
function enablefeature( featurename )
{
    assert( !isstring( featurename ) );
    level.brgametype.enabledfeatures[ featurename ] = 1;
}

// Namespace br_gametypes
// Params 1
// Checksum 0x72209f0a, Offset: 0x242
// Size: 0x32, Type: bool
function isfeatureenabled( featurename )
{
    assert( !isstring( featurename ) );
    return istrue( level.brgametype.enabledfeatures[ featurename ] );
}

