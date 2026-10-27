// scripts\mp\ftue\utility\ftue_progress.gsc  (hash_6981400abfcd765c.gscc) (size: 5830 Bytes / 0x16c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8633764 (3093509988)
// size ...... 5830 (0x16c6)
// includes .. 1   (offset: 0x15de)
// strings ... 15  (offset: 0x15e6)
// dev strs .. 0   (offset: 0x16c6)
// exports ... 31  (offset: 0xc6e)
// cseg ...... 0x175 + 0xaf9 (0xc6e)
// imports ... 30  (offset: 0x1146)
// animtree1 . 0   (offset: 0x16c6)
// animtree2 . 0   (offset: 0x16c6)
#using scripts\common\script;

#namespace ftue_progress;

// Namespace ftue_progress
// Params 0
// Checksum 0xede6f904, Offset: 0x193
// Size: 0x2f
function ftue_enabled()
{
    if ( !isdefined( level.var_3a126eaf02231f44 ) )
    {
        level.var_3a126eaf02231f44 = getdvarint( @"ftue_ingame_enabled", 1 );
    }
    
    return level.var_3a126eaf02231f44;
}

// Namespace ftue_progress
// Params 0
// Checksum 0xf3cb3433, Offset: 0x1cb
// Size: 0x43
function function_2f77d23c606e433f()
{
    if ( function_fc65c7b48a405593() )
    {
        level.var_9bff46a6d2a994e2 = spawnstruct();
        level.var_9bff46a6d2a994e2.var_2ea4065d22aea182 = [];
        level.var_9bff46a6d2a994e2.var_2e4865e272d1bae8 = 1;
    }
}

// Namespace ftue_progress
// Params 0, eflags: 0x4
// Checksum 0xc28c31f8, Offset: 0x216
// Size: 0x11, Type: bool
function private function_fc65c7b48a405593()
{
    return istrue( getdvarint( @"hash_9615d7fb7cf74e4c", 0 ) );
}

// Namespace ftue_progress
// Params 1
// Checksum 0xf7dbb31e, Offset: 0x230
// Size: 0x49, Type: bool
function function_53132d48c3fb23af( progressid )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    savedprogress = function_332b949abd855e74( "ftueProgress", progressid, "completed" );
    return savedprogress > 0;
}

// Namespace ftue_progress
// Params 1, eflags: 0x4
// Checksum 0x28f65abd, Offset: 0x282
// Size: 0x29, Type: bool
function private function_9c72a271810fa302( progressid )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    return true;
}

// Namespace ftue_progress
// Params 2
// Checksum 0xf79b9330, Offset: 0x2b4
// Size: 0x6e
function function_5dcbb86a0b038621( progressid, value )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    progressversion = function_9c72a271810fa302( progressid );
    function_c92672e8e91aa8a8( "ftueProgress", progressid, "completed", value );
    function_c92672e8e91aa8a8( "ftueProgress", progressid, "completedVersion", progressversion );
}

// Namespace ftue_progress
// Params 1
// Checksum 0x3ece297e, Offset: 0x32a
// Size: 0x47
function function_1fa95a7f0563fa00( progressid )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    version = function_332b949abd855e74( "ftueProgress", progressid, "completedVersion" );
    return version;
}

// Namespace ftue_progress
// Params 0
// Checksum 0xa4cf91be, Offset: 0x37a
// Size: 0x28
function function_dc0b953b3c5988a8()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    return function_ea650cfcd7a97beb( "brMatchPlayTime" );
}

// Namespace ftue_progress
// Params 1
// Checksum 0xa9d0ee2c, Offset: 0x3ab
// Size: 0x4a
function function_bff6c3b0092a56bb( playtime )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    savedtime = function_dc0b953b3c5988a8() + playtime;
    function_e1f1bc05c7500f27( "brMatchPlayTime", savedtime );
}

// Namespace ftue_progress
// Params 0
// Checksum 0xb8782211, Offset: 0x3fd
// Size: 0x28
function function_1b4dcded8ba60625()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    return function_ea650cfcd7a97beb( "matchesCompleted" );
}

// Namespace ftue_progress
// Params 0
// Checksum 0x866d22f1, Offset: 0x42e
// Size: 0x42
function function_1bd78cb3a25a72c8()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    savedmatches = function_1b4dcded8ba60625() + 1;
    function_e1f1bc05c7500f27( "matchesCompleted", savedmatches );
    return savedmatches;
}

// Namespace ftue_progress
// Params 1
// Checksum 0xee99f8dd, Offset: 0x479
// Size: 0x52, Type: bool
function function_e86e99a754ea1de2( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_7b3f9ee7404bfa64 ) );
    currentmatches = function_1b4dcded8ba60625();
    
    if ( currentmatches >= params.var_7b3f9ee7404bfa64 )
    {
        return true;
    }
    
    return false;
}

// Namespace ftue_progress
// Params 1
// Checksum 0x1be16481, Offset: 0x4d4
// Size: 0x74
function function_d00c0941d634466b( index )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    var_132205f3eff3f399 = floor( index / 32 );
    index %= 32;
    tooltipscompleted = function_1e3f556a985cf18c( var_132205f3eff3f399 );
    mask = 1 << index;
    tooltipscompleted |= mask;
    function_bc3e8217e2c0feb8( tooltipscompleted, var_132205f3eff3f399 );
}

// Namespace ftue_progress
// Params 1
// Checksum 0xe8abc68b, Offset: 0x550
// Size: 0x69, Type: bool
function function_23632e49519e1ef7( index )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    var_132205f3eff3f399 = floor( index / 32 );
    index %= 32;
    tooltipscompleted = function_1e3f556a985cf18c( var_132205f3eff3f399 );
    mask = 1 << index;
    return istrue( tooltipscompleted & mask );
}

// Namespace ftue_progress
// Params 0
// Checksum 0x5bacfa3, Offset: 0x5c2
// Size: 0x49
function function_1a1277c0b2dc47a6()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    
    if ( function_fc65c7b48a405593() )
    {
        return level.var_9bff46a6d2a994e2.var_2e4865e272d1bae8;
    }
    
    return function_ea650cfcd7a97beb( "playerExpertiseOption" );
}

// Namespace ftue_progress
// Params 0
// Checksum 0x33433580, Offset: 0x613
// Size: 0x37, Type: bool
function function_ee2163604314c218()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    disabled = function_ea650cfcd7a97beb( "tooltipsDisabled" );
    return !disabled;
}

// Namespace ftue_progress
// Params 1, eflags: 0x4
// Checksum 0x59b416, Offset: 0x653
// Size: 0x1d
function private function_ea650cfcd7a97beb( data )
{
    return function_5b9dff536d1f1552( level.var_eacaa7f6211fe730, data );
}

// Namespace ftue_progress
// Params 2, eflags: 0x4
// Checksum 0x75c95f8f, Offset: 0x679
// Size: 0x28
function private function_e1f1bc05c7500f27( data, value )
{
    function_b1a77b2cc21f35e6( level.var_eacaa7f6211fe730, data, value );
}

// Namespace ftue_progress
// Params 3, eflags: 0x4
// Checksum 0x9048907c, Offset: 0x6a9
// Size: 0x31
function private function_332b949abd855e74( arrayname, index, data )
{
    return function_fb1d4d542fcb8d6d( level.var_eacaa7f6211fe730, arrayname, index, data );
}

// Namespace ftue_progress
// Params 4, eflags: 0x4
// Checksum 0x9367f7d7, Offset: 0x6e3
// Size: 0x3d
function private function_c92672e8e91aa8a8( arrayname, index, data, value )
{
    function_e0ae228df667d479( level.var_eacaa7f6211fe730, arrayname, index, data, value );
}

// Namespace ftue_progress
// Params 2, eflags: 0x4
// Checksum 0x58d90625, Offset: 0x728
// Size: 0x4b
function private function_5b9dff536d1f1552( key, data )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    playerdata = self getplayerdata( "mp", key, data );
    return playerdata;
}

// Namespace ftue_progress
// Params 4, eflags: 0x4
// Checksum 0x41b80278, Offset: 0x77c
// Size: 0x60
function private function_fb1d4d542fcb8d6d( key, arrayname, index, data )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    playerdata = self getplayerdata( "mp", key, arrayname, index, data );
    return playerdata;
}

// Namespace ftue_progress
// Params 3, eflags: 0x4
// Checksum 0x58d9066f, Offset: 0x7e5
// Size: 0x48
function private function_b1a77b2cc21f35e6( key, data, value )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    self setplayerdata( "mp", key, data, value );
}

// Namespace ftue_progress
// Params 5, eflags: 0x4
// Checksum 0x3428e9a1, Offset: 0x835
// Size: 0x5d
function private function_e0ae228df667d479( key, arrayname, index, data, value )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    self setplayerdata( "mp", key, arrayname, index, data, value );
}

// Namespace ftue_progress
// Params 1
// Checksum 0xd892fa20, Offset: 0x89a
// Size: 0x84
function function_1e3f556a985cf18c( var_132205f3eff3f399 )
{
    var_83352d154d65ef38 = function_3805a70bd8376753( var_132205f3eff3f399 );
    tooltipscompleted = 0;
    
    if ( function_fc65c7b48a405593() )
    {
        tooltipscompleted = function_c04c9fa7a806e72e( self );
    }
    else
    {
        tooltipscompleted = function_ea650cfcd7a97beb( var_83352d154d65ef38 );
    }
    
    if ( !isdefined( tooltipscompleted ) )
    {
        script::demoforcesre( "[ftue getTooltipsCompleted] keySetIndex : " + ( var_132205f3eff3f399 ?? "[n/a]" ) + " | " + ( self.name ?? "[n/a]" ) );
        return 0;
    }
    
    return tooltipscompleted;
}

// Namespace ftue_progress
// Params 2, eflags: 0x4
// Checksum 0x36a9c621, Offset: 0x927
// Size: 0x49
function private function_bc3e8217e2c0feb8( tooltipscompleted, var_132205f3eff3f399 )
{
    var_83352d154d65ef38 = function_3805a70bd8376753( var_132205f3eff3f399 );
    
    if ( function_fc65c7b48a405593() )
    {
        function_75c82e8bad695baa( self, tooltipscompleted );
        return;
    }
    
    function_e1f1bc05c7500f27( var_83352d154d65ef38, tooltipscompleted );
}

// Namespace ftue_progress
// Params 1, eflags: 0x4
// Checksum 0xf4b535d, Offset: 0x978
// Size: 0xb3
function private function_c04c9fa7a806e72e( player )
{
    function_9f9f10b5b33a71c6( player );
    
    foreach ( entry in level.var_9bff46a6d2a994e2.var_2ea4065d22aea182 )
    {
        if ( isdefined( entry ) && entry.player == player )
        {
            return entry.var_16938ea6b6ed7773;
        }
    }
}

// Namespace ftue_progress
// Params 2, eflags: 0x4
// Checksum 0x8e24e379, Offset: 0xa33
// Size: 0xc1
function private function_75c82e8bad695baa( player, value )
{
    function_9f9f10b5b33a71c6( player );
    
    foreach ( entry in level.var_9bff46a6d2a994e2.var_2ea4065d22aea182 )
    {
        if ( isdefined( entry ) && entry.player == player )
        {
            entry.var_16938ea6b6ed7773 = value;
            break;
        }
    }
}

// Namespace ftue_progress
// Params 1, eflags: 0x4
// Checksum 0xb37e43ff, Offset: 0xafc
// Size: 0x123
function private function_9f9f10b5b33a71c6( player )
{
    foreach ( entry in level.var_9bff46a6d2a994e2.var_2ea4065d22aea182 )
    {
        if ( isdefined( entry ) && entry.player == player )
        {
            return;
        }
    }
    
    entry = spawnstruct();
    entry.player = player;
    entry.var_16938ea6b6ed7773 = getdvarint( @"hash_92e4360591ae4baf", 0 );
    
    if ( !isdefined( level.var_9bff46a6d2a994e2.var_2ea4065d22aea182 ) )
    {
        level.var_9bff46a6d2a994e2.var_2ea4065d22aea182 = [];
    }
    
    level.var_9bff46a6d2a994e2.var_2ea4065d22aea182[ level.var_9bff46a6d2a994e2.var_2ea4065d22aea182.size ] = entry;
}

// Namespace ftue_progress
// Params 1, eflags: 0x4
// Checksum 0x66ac47e3, Offset: 0xc27
// Size: 0x46
function private function_3805a70bd8376753( var_132205f3eff3f399 )
{
    if ( level.gametype == "bongo" )
    {
        return "tooltipsCompleted_bongo";
    }
    
    var_83352d154d65ef38 = "tooltipsCompleted_01";
    
    if ( var_132205f3eff3f399 == 1 )
    {
        var_83352d154d65ef38 = "tooltipsCompleted_02";
    }
    
    return var_83352d154d65ef38;
}

