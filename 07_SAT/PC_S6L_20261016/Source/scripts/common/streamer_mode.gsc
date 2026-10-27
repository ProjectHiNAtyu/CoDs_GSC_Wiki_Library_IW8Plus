// scripts\common\streamer_mode.gsc  (hash_065303c30fbbbbe3.gscc) (size: 2466 Bytes / 0x9a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11e71387 (300356487)
// size ...... 2466 (0x9a2)
// includes .. 3   (offset: 0x912)
// strings ... 10  (offset: 0x92a)
// dev strs .. 0   (offset: 0x9a2)
// exports ... 10  (offset: 0x4ea)
// cseg ...... 0x1a5 + 0x345 (0x4ea)
// imports ... 23  (offset: 0x67a)
// animtree1 . 0   (offset: 0x9a2)
// animtree2 . 0   (offset: 0x9a2)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\common\utility\game;

#namespace streamer_mode;

// Namespace streamer_mode
// Params 0, eflags: 0x5
// Checksum 0xe6e7b805, Offset: 0x1c3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"streamer_mode", undefined, &function_7d730f4c289e66fd, undefined );
}

// Namespace streamer_mode
// Params 0, eflags: 0x4
// Checksum 0x84b7675d, Offset: 0x1e4
// Size: 0xad
function private function_7d730f4c289e66fd()
{
    if ( !getdvarint( @"online_enable_streamer_mode_dlog" ) )
    {
        logstring( "[Streamer Mode] Disable to send streamer mode dlog, as dvar online_enable_streamer_mode_dlog is off." );
        return;
    }
    
    flagsraw = getdvar( @"hash_ad7966fcf5edf249", "25+12014+12015" );
    flags = [];
    
    if ( isdefined( flagsraw ) && flagsraw.size )
    {
        logstring( "[Streamer Mode] Parsing streamer mode flags: " + flagsraw );
        flags = strtok( flagsraw, "+" );
    }
    
    level.flags = flags;
    level callback::add( #"player_connect", &_onplayerconnect );
    level callback::add( #"player_disconnect", &_onplayerdisconnect );
    level thread _watchgameend();
}

// Namespace streamer_mode
// Params 1, eflags: 0x4
// Checksum 0x58598779, Offset: 0x299
// Size: 0xa2
function private _onplayerconnect( sparams )
{
    foreach ( f in level.flags )
    {
        if ( self function_c61e257d2f3c6251( int( f ) ) )
        {
            logstring( "[Streamer Mode] Seeing a streamer, uno id: " + self getplayerunoid() );
            function_62aded1cf7945a3();
            return;
        }
    }
}

// Namespace streamer_mode
// Params 1, eflags: 0x4
// Checksum 0xa1dc51fa, Offset: 0x343
// Size: 0x13
function private _onplayerdisconnect( sparams )
{
    function_396ee648c3497110();
}

// Namespace streamer_mode
// Params 0, eflags: 0x4
// Checksum 0xe19f49df, Offset: 0x35e
// Size: 0x91
function private _watchgameend()
{
    level waittill( #"game_ended" );
    
    if ( game_utility_mp::waslastround() )
    {
        foreach ( player in level.players )
        {
            player function_396ee648c3497110();
        }
    }
}

// Namespace streamer_mode
// Params 0, eflags: 0x4
// Checksum 0xd2afd9a0, Offset: 0x3f7
// Size: 0x12
function private function_396ee648c3497110()
{
    if ( function_d61f3e0a13ae2096() )
    {
        function_8ff7c24cb5b3dd41();
    }
}

// Namespace streamer_mode
// Params 0, eflags: 0x4
// Checksum 0xd78f38b0, Offset: 0x411
// Size: 0xa4
function private function_8ff7c24cb5b3dd41()
{
    if ( self.var_370def36ffbff11e )
    {
        return;
    }
    
    playerunoid = self getplayerunoid();
    var_13ecdf45e7da76b5 = self function_26bd4e370f05f4a4();
    var_fa3a779f2c94348 = isbot( self );
    var_f60e0357d6c4a260 = istrue( self.is_streamer );
    dlog_recordevent( "dlog_event_streamer_mode_anonymous_tracking", [ "anonymous_uno_id", playerunoid, "anonymous_name", var_13ecdf45e7da76b5, "is_streamer", var_f60e0357d6c4a260, "is_bot", var_fa3a779f2c94348 ] );
    self.var_370def36ffbff11e = 1;
}

// Namespace streamer_mode
// Params 0, eflags: 0x4
// Checksum 0x6c113972, Offset: 0x4bd
// Size: 0x18
function private function_62aded1cf7945a3()
{
    self.is_streamer = 1;
    level.var_1b8e5057ebff9ea9 = 1;
}

// Namespace streamer_mode
// Params 0, eflags: 0x4
// Checksum 0xcf4d3c3b, Offset: 0x4dd
// Size: 0xc, Type: bool
function private function_d61f3e0a13ae2096()
{
    return istrue( level.var_1b8e5057ebff9ea9 );
}

