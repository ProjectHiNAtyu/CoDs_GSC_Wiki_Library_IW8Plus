// scripts\mp\br_heat.gsc  (hash_225cacf3e2335943.gscc) (size: 4877 Bytes / 0x130d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6207b7e0 (1644672992)
// size ...... 4877 (0x130d)
// includes .. 5   (offset: 0x1231)
// strings ... 12  (offset: 0x1259)
// dev strs .. 0   (offset: 0x130d)
// exports ... 14  (offset: 0xc79)
// cseg ...... 0x147 + 0xb32 (0xc79)
// imports ... 30  (offset: 0xea9)
// animtree1 . 0   (offset: 0x130d)
// animtree2 . 0   (offset: 0x130d)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\flags;

#namespace br_heat;

// Namespace br_heat
// Params 0, eflags: 0x5
// Checksum 0xcf29c54f, Offset: 0x165
// Size: 0x9
function private autoexec main()
{
    init();
}

// Namespace br_heat
// Params 0
// Checksum 0xdf98e3e6, Offset: 0x176
// Size: 0x186
function init()
{
    if ( !heat_isenabled() )
    {
        return;
    }
    
    heatdata = function_bb7f50f767f6113c();
    
    if ( !isdefined( heatdata ) )
    {
        return;
    }
    
    level.heat = spawnstruct();
    level.heat.data = heatdata;
    level.heat.dvars = { #var_a1a372a462140951:getdvarint( @"hash_836dd1a8d9050d9f", -1 ), #var_62aaaabbc2402850:getdvarint( @"hash_c09480010cfe71c", -1 ), #var_b8a4281d93157917:getdvarint( @"hash_235c5c709fdfe5cb", -1 ), #var_b1f9fa406b84d1be:getdvarint( @"scr_br_heat_radius_override", 0 ), #var_80fdb5f559240bd4:getdvarfloat( @"hash_805f2e1bd6e0c7bc", 0 ), #var_ff87ddf70acf8d49:getdvarfloat( @"hash_52a0ef1130c0821a", 0 ) };
    function_e50ddabd8b4f6cf5();
    utility::registersharedfunc( #"br_heat", #"hash_79c56a813a08dec7", &function_b4b366b58c9a2240 );
    utility::registersharedfunc( #"br_heat", #"hash_fd88e9bcd7d31ca9", &function_2b4c8c5fa29258f1 );
    utility::registersharedfunc( #"br_heat", #"hash_9f22480705367c86", &function_e7382b377308182f );
    game[ "dialog" ][ "br_heat_high_activity" ] = "srry_wzan_alhi";
    game[ "dialog" ][ "br_heat_medium_activity" ] = "srry_wzan_almd";
    game[ "dialog" ][ "br_heat_low_activity" ] = "srry_wzan_allw";
}

// Namespace br_heat
// Params 0
// Checksum 0x8a23463a, Offset: 0x304
// Size: 0x322
function function_e50ddabd8b4f6cf5()
{
    if ( !isdefined( level.heat.data ) || !isdefined( level.heat.dvars ) )
    {
        return;
    }
    
    level.heat.data.refreshrate = level.heat.dvars.var_ff87ddf70acf8d49 > 0 ? level.heat.dvars.var_ff87ddf70acf8d49 : level.heat.data.refreshrate;
    level.heat.data.compassrefreshrate = level.heat.dvars.var_80fdb5f559240bd4 > 0 ? level.heat.dvars.var_80fdb5f559240bd4 : level.heat.data.compassrefreshrate;
    level.heat.data.var_9b946689b6d2ede3 = level.heat.dvars.var_b1f9fa406b84d1be > 0 ? level.heat.dvars.var_b1f9fa406b84d1be : level.heat.data.var_9b946689b6d2ede3;
    level.heat.data.var_eb996a00a73411a5 = level.heat.dvars.var_b8a4281d93157917 >= 0 ? level.heat.dvars.var_b8a4281d93157917 : level.heat.data.var_eb996a00a73411a5;
    level.heat.data.var_c2942a31bdcc7f84 = level.heat.dvars.var_62aaaabbc2402850 >= 0 ? level.heat.dvars.var_62aaaabbc2402850 : level.heat.data.var_c2942a31bdcc7f84;
    level.heat.data.var_8d76498e733e2983 = level.heat.dvars.var_a1a372a462140951 >= 0 ? level.heat.dvars.var_a1a372a462140951 : level.heat.data.var_8d76498e733e2983;
}

// Namespace br_heat
// Params 0
// Checksum 0x776d9655, Offset: 0x62e
// Size: 0xd3
function function_b4b366b58c9a2240()
{
    flags::function_2f3408423ccc9b2e( "br_ready_to_jump" );
    
    if ( !isdefined( level.heat.throttle ) )
    {
        level.heat.throttle = throttle::throttle_initialize( "br_heat_update", 10 );
    }
    
    foreach ( player in level.players )
    {
        function_5ba96c1541197c0e( player );
    }
    
    callback::add( #"player_connect", &updateplayerheat );
}

// Namespace br_heat
// Params 1, eflags: 0x4
// Checksum 0x2f0a7b40, Offset: 0x709
// Size: 0x67
function private function_2b4c8c5fa29258f1( player )
{
    if ( !player.var_b39de3205bdae490 )
    {
        flags::function_2f3408423ccc9b2e( "br_ready_to_jump" );
        
        if ( !isdefined( level.heat.throttle ) )
        {
            level.heat.throttle = throttle::throttle_initialize( "br_heat_update", 10 );
        }
        
        function_5ba96c1541197c0e( player );
    }
}

// Namespace br_heat
// Params 1, eflags: 0x4
// Checksum 0x28876bef, Offset: 0x778
// Size: 0x3b
function private function_5ba96c1541197c0e( player )
{
    if ( player.var_b39de3205bdae490 )
    {
        return;
    }
    
    player.var_b39de3205bdae490 = 1;
    player thread updateplayerheat();
    player thread function_4694301109efeeb4();
}

// Namespace br_heat
// Params 2, eflags: 0x4
// Checksum 0x83a3f863, Offset: 0x7bb
// Size: 0x1f
function private function_e7382b377308182f( players, duration )
{
    thread function_b90d555bfbcfba98( players, duration );
}

// Namespace br_heat
// Params 2, eflags: 0x4
// Checksum 0x8b569f30, Offset: 0x7e2
// Size: 0x10e
function private function_b90d555bfbcfba98( players, duration )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    foreach ( player in players )
    {
        function_2b4c8c5fa29258f1( player );
    }
    
    wait duration;
    
    foreach ( player in players )
    {
        player.var_b39de3205bdae490 = 0;
    }
}

// Namespace br_heat
// Params 1, eflags: 0xc
// Checksum 0xe359a5c5, Offset: 0x8f8
// Size: 0xad
function private updateplayerheat( params )
{
    self notify( #"hash_959c190253606b9d" );
    self endon( #"hash_959c190253606b9d" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( self.brneverlanded )
    {
        waitframe();
    }
    
    self.playerheat = 0;
    
    while ( self.var_b39de3205bdae490 )
    {
        throttle::throttle_wait_in_queue( level.heat.throttle, self );
        
        if ( isalive( self ) )
        {
            function_7e0ad5094604de4c();
            wait level.heat.data.refreshrate;
        }
    }
}

// Namespace br_heat
// Params 0, eflags: 0xc
// Checksum 0x3f11d4c1, Offset: 0x9ad
// Size: 0x9c
function private function_4694301109efeeb4()
{
    self notify( #"hash_ffa310e6269782d5" );
    self endon( #"hash_ffa310e6269782d5" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_757b4d9f445ce2bb" );
    
    while ( self.brneverlanded )
    {
        waitframe();
    }
    
    while ( self.var_b39de3205bdae490 )
    {
        wait level.heat.data.compassrefreshrate;
        self setclientomnvar( "ui_br_heat_player_level", 0 );
        waitframe();
        self setclientomnvar( "ui_br_heat_player_level", self.playerheat );
    }
}

// Namespace br_heat
// Params 0, eflags: 0x4
// Checksum 0xb1a4dc5b, Offset: 0xa51
// Size: 0x1dc
function private function_7e0ad5094604de4c()
{
    playersnearby = utility::playersnear( self.origin, level.heat.data.var_9b946689b6d2ede3 );
    enemiesnear = [];
    
    foreach ( player in playersnearby )
    {
        if ( player.team != self.team && isalive( player ) )
        {
            enemiesnear[ enemiesnear.size ] = player;
        }
    }
    
    var_82404bc072693aaf = enemiesnear.size;
    playerheat = 0;
    var_29d1433430b317fa = undefined;
    
    if ( var_82404bc072693aaf >= level.heat.data.var_8d76498e733e2983 )
    {
        playerheat = 3;
        var_29d1433430b317fa = "br_heat_high_activity";
    }
    else if ( var_82404bc072693aaf >= level.heat.data.var_c2942a31bdcc7f84 )
    {
        playerheat = 2;
        var_29d1433430b317fa = "br_heat_medium_activity";
    }
    else if ( var_82404bc072693aaf >= level.heat.data.var_eb996a00a73411a5 )
    {
        playerheat = 1;
        var_29d1433430b317fa = "br_heat_low_activity";
    }
    
    if ( playerheat != self.playerheat )
    {
        self notify( #"hash_757b4d9f445ce2bb" );
        self setclientomnvar( "ui_br_heat_player_level", playerheat );
        
        if ( isdefined( var_29d1433430b317fa ) )
        {
            br_public::brleaderdialogplayer( var_29d1433430b317fa, self, 1, 0, undefined, undefined, "dx_br_srgr_" );
        }
        
        self.playerheat = playerheat;
        thread function_4694301109efeeb4();
    }
}

// Namespace br_heat
// Params 0, eflags: 0x4
// Checksum 0xa978a722, Offset: 0xc35
// Size: 0x14, Type: bool
function private heat_isenabled()
{
    return getdvarint( @"hash_350f916ac56375bc", 1 ) == 1;
}

// Namespace br_heat
// Params 0, eflags: 0x4
// Checksum 0x2656c5c3, Offset: 0xc52
// Size: 0x26
function private function_bb7f50f767f6113c()
{
    heatdata = getscriptbundle( hashcat( %"hash_610091ddcb517c86", "br_heat_default" ) );
    return heatdata;
}

