// scripts\mp\common\utility\dvars.gsc  (hash_26f5997b01261edd.gscc) (size: 4973 Bytes / 0x136d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2deaa2f6 (770351862)
// size ...... 4973 (0x136d)
// includes .. 1   (offset: 0x1299)
// strings ... 10  (offset: 0x12a1)
// dev strs .. 1   (offset: 0x1361)
// exports ... 24  (offset: 0xb21)
// cseg ...... 0xa8 + 0xa79 (0xb21)
// imports ... 26  (offset: 0xee1)
// animtree1 . 0   (offset: 0x136d)
// animtree2 . 0   (offset: 0x136d)
#using scripts\mp\common\utility\game_utility;

#namespace dvars;

// Namespace dvars
// Params 0
// Checksum 0xb9945348, Offset: 0xc6
// Size: 0x4f
function function_b73670613c3c0546()
{
    if ( !isdefined( level.var_c29605e227613218 ) )
    {
        level.var_c29605e227613218 = game_utility::getgametype();
        
        if ( isbrgamemode() )
        {
            level.var_c29605e227613218 = "br";
        }
        else
        {
            level.var_c29605e227613218 = game_utility::getgametype();
        }
    }
    
    return level.var_c29605e227613218;
}

// Namespace dvars
// Params 4
// Checksum 0x40e51c6c, Offset: 0x11e
// Size: 0x93
function dvarintvalue( dvar, defval, minval, maxval )
{
    dvar = hashcat( @"scr_", function_b73670613c3c0546(), "_", dvar );
    
    if ( !isdvardefined( dvar ) )
    {
        setdvar( dvar, defval );
        return defval;
    }
    
    value = getdvarint( dvar );
    
    if ( value > maxval )
    {
        value = maxval;
    }
    else if ( value < minval )
    {
        value = minval;
    }
    else
    {
        return value;
    }
    
    setdvar( dvar, value );
    return value;
}

// Namespace dvars
// Params 4
// Checksum 0x79c8570e, Offset: 0x1ba
// Size: 0x93
function dvarfloatvalue( dvar, defval, minval, maxval )
{
    dvar = hashcat( @"scr_", function_b73670613c3c0546(), "_", dvar );
    
    if ( !isdvardefined( dvar ) )
    {
        setdvar( dvar, defval );
        return defval;
    }
    
    value = getdvarfloat( dvar );
    
    if ( value > maxval )
    {
        value = maxval;
    }
    else if ( value < minval )
    {
        value = minval;
    }
    else
    {
        return value;
    }
    
    setdvar( dvar, value );
    return value;
}

// Namespace dvars
// Params 2
// Checksum 0x5820a753, Offset: 0x256
// Size: 0xbb
function registerwatchdvarint( namestring, defaultvalue )
{
    dvarstring = hashcat( @"scr_", function_b73670613c3c0546(), "_", namestring );
    
    if ( getdvarint( dvarstring, -1 ) == -1 )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    level.watchdvars[ dvarstring ] = spawnstruct();
    level.watchdvars[ dvarstring ].value = getdvarint( dvarstring, defaultvalue );
    level.watchdvars[ dvarstring ].type = "int";
    level.watchdvars[ dvarstring ].notifystring = "update_" + namestring;
}

// Namespace dvars
// Params 2
// Checksum 0x2d977bae, Offset: 0x319
// Size: 0xbb
function registerwatchdvarfloat( namestring, defaultvalue )
{
    dvarstring = hashcat( @"scr_", function_b73670613c3c0546(), "_", namestring );
    
    if ( getdvarfloat( dvarstring, -1 ) == -1 )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    level.watchdvars[ dvarstring ] = spawnstruct();
    level.watchdvars[ dvarstring ].value = getdvarfloat( dvarstring, defaultvalue );
    level.watchdvars[ dvarstring ].type = "float";
    level.watchdvars[ dvarstring ].notifystring = "update_" + namestring;
}

// Namespace dvars
// Params 2
// Checksum 0x2b1552e7, Offset: 0x3dc
// Size: 0xc1
function registerwatchdvar( namestring, defaultvalue )
{
    dvarstring = hashcat( @"scr_", function_b73670613c3c0546(), "_", namestring );
    
    if ( getdvar( dvarstring, "" ) == "" )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    level.watchdvars[ dvarstring ] = spawnstruct();
    level.watchdvars[ dvarstring ].value = getdvar( dvarstring, defaultvalue );
    level.watchdvars[ dvarstring ].type = "string";
    level.watchdvars[ dvarstring ].notifystring = "update_" + namestring;
}

// Namespace dvars
// Params 2
// Checksum 0xd02480ea, Offset: 0x4a5
// Size: 0x49
function setoverridewatchdvar( dvarstring, value )
{
    dvarhash = hashcat( @"scr_", function_b73670613c3c0546(), "_", dvarstring );
    level.overridewatchdvars[ dvarhash ] = value;
}

// Namespace dvars
// Params 1
// Checksum 0x9b2c96b0, Offset: 0x4f6
// Size: 0x85
function getwatcheddvar( dvarstring )
{
    dvarhash = function_1165fde71640a2d1( dvarstring );
    
    if ( isdefined( level.overridewatchdvars[ dvarhash ] ) )
    {
        return level.overridewatchdvars[ dvarhash ];
    }
    
    if ( isdefined( level.watchdvars[ dvarhash ] ) && isdefined( level.watchdvars[ dvarhash ].value ) )
    {
        return level.watchdvars[ dvarhash ].value;
    }
    
    return;
}

// Namespace dvars
// Params 1
// Checksum 0x2a76cc32, Offset: 0x583
// Size: 0x26
function function_1165fde71640a2d1( dvarstring )
{
    return hashcat( @"scr_", function_b73670613c3c0546(), "_", dvarstring );
}

// Namespace dvars
// Params 0
// Checksum 0x5aa750eb, Offset: 0x5b2
// Size: 0x18a
function updatewatcheddvarsexecute()
{
    if ( !isdefined( level.watchdvars ) )
    {
        return;
    }
    
    watchdvars = getarraykeys( level.watchdvars );
    
    foreach ( dvarstring in watchdvars )
    {
        if ( level.watchdvars[ dvarstring ].type == "string" )
        {
            dvarvalue = getproperty( dvarstring, level.watchdvars[ dvarstring ].value );
        }
        else if ( level.watchdvars[ dvarstring ].type == "float" )
        {
            dvarvalue = getfloatproperty( dvarstring, level.watchdvars[ dvarstring ].value );
        }
        else
        {
            dvarvalue = getintproperty( dvarstring, level.watchdvars[ dvarstring ].value );
        }
        
        if ( dvarvalue != level.watchdvars[ dvarstring ].value )
        {
            level.watchdvars[ dvarstring ].value = dvarvalue;
            level notify( level.watchdvars[ dvarstring ].notifystring, dvarvalue );
        }
    }
}

// Namespace dvars
// Params 0
// Checksum 0xa00430b7, Offset: 0x744
// Size: 0x22
function updatewatcheddvars()
{
    while ( game[ "state" ] == "playing" )
    {
        updatewatcheddvarsexecute();
        wait 1;
    }
}

// Namespace dvars
// Params 2
// Checksum 0xe7cfdbe6, Offset: 0x76e
// Size: 0x39
function getproperty( dvar, defvalue )
{
    value = defvalue;
    
    /#
        setdevdvarifuninitialized( dvar, defvalue );
    #/
    
    value = getdvar( dvar, defvalue );
    return value;
}

// Namespace dvars
// Params 2
// Checksum 0xcf136eea, Offset: 0x7b0
// Size: 0x39
function getintproperty( dvar, defvalue )
{
    value = defvalue;
    
    /#
        setdevdvarifuninitialized( dvar, defvalue );
    #/
    
    value = getdvarint( dvar, defvalue );
    return value;
}

// Namespace dvars
// Params 2
// Checksum 0xf2c8a034, Offset: 0x7f2
// Size: 0x39
function getfloatproperty( dvar, defvalue )
{
    value = defvalue;
    
    /#
        setdevdvarifuninitialized( dvar, defvalue );
    #/
    
    value = getdvarfloat( dvar, defvalue );
    return value;
}

// Namespace dvars
// Params 2
// Checksum 0x2271d702, Offset: 0x834
// Size: 0x21
function getoverridedvarintexceptmatchrulesvalues( override, fallback )
{
    return getdvarint( override, getdvarint( fallback ) );
}

// Namespace dvars
// Params 2
// Checksum 0x2f099c3d, Offset: 0x85e
// Size: 0x21
function getoverridedvarfloatexceptmatchrulesvalues( override, fallback )
{
    return getdvarfloat( override, getdvarfloat( fallback ) );
}

// Namespace dvars
// Params 2
// Checksum 0xf4cc0ec1, Offset: 0x888
// Size: 0x21
function getoverridedvarexceptmatchrulesvalues( override, fallback )
{
    return getdvar( override, getdvar( fallback ) );
}

// Namespace dvars
// Params 2
// Checksum 0xf3a4b5bc, Offset: 0x8b2
// Size: 0x82
function function_60bcfae5d310eb1f( class, member )
{
    assert( isusingmatchrulesdata() );
    dvar = hashcat( @"scr_", function_b73670613c3c0546(), "_", member );
    data = getmatchrulesdata( class, member );
    
    if ( getbuildversion() == "SHIP" || getdvar( dvar, "" ) == "" )
    {
        setdynamicdvar( dvar, data );
    }
}

// Namespace dvars
// Params 2
// Checksum 0xfa52edf8, Offset: 0x93c
// Size: 0x39
function function_99012ab10f8154de( class, member )
{
    rulevalue = getmatchrulesdata( class, member );
    setdynamicdvar( function_1165fde71640a2d1( member ), rulevalue );
    return rulevalue;
}

// Namespace dvars
// Params 2
// Checksum 0x27e550c3, Offset: 0x97e
// Size: 0x4a
function function_13909a5327c395b9( member, defvalue = 0 )
{
    dvar = hashcat( @"scr_", function_b73670613c3c0546(), "_", member );
    return getdvarint( dvar, defvalue );
}

// Namespace dvars
// Params 2
// Checksum 0xf7e05ca7, Offset: 0x9d1
// Size: 0x4e
function function_80a5871795f1cd82( member, defvalue = 0 )
{
    dvar = hashcat( @"scr_", function_b73670613c3c0546(), "_", member );
    return getdvarfloat( dvar, defvalue );
}

// Namespace dvars
// Params 2
// Checksum 0xa1eaa4ef, Offset: 0xa28
// Size: 0x4e
function function_a0cb357a2cd424f8( member, defvalue = "" )
{
    dvar = hashcat( @"scr_", function_b73670613c3c0546(), "_", member );
    return getdvar( dvar, defvalue );
}

/#

    // Namespace dvars
    // Params 0
    // Checksum 0xab510649, Offset: 0xa7f
    // Size: 0xa2, Type: dev
    function function_f0fc15052d9d9921()
    {
        level notify( #"hash_9c6f3299b011d718" );
        level endon( #"hash_9c6f3299b011d718" );
        
        while ( true )
        {
            level waittill( #"host_migration_begin" );
            setdevdvarifuninitialized( @"scr_emp_timeout", 15 );
            setdevdvarifuninitialized( @"scr_uav_timeout", level.radarviewtime );
            setdevdvarifuninitialized( @"hash_5bded6d7c75e5248", "<dev string:x24>" );
            setdevdvarifuninitialized( @"scr_devchangetimelimit", -1 );
            setdevdvarifuninitialized( @"scr_cranked_bomb_timer", 30 );
            setdevdvarifuninitialized( @"scr_helipilot_timeout", 60 );
        }
    }

#/
