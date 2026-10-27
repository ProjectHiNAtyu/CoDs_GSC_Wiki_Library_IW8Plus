// scripts\mp\codcaster_utils.gsc  (hash_548072087c9fd504.gscc) (size: 5580 Bytes / 0x15cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde32c48b (3727869067)
// size ...... 5580 (0x15cc)
// includes .. 3   (offset: 0x14d0)
// strings ... 13  (offset: 0x14e8)
// dev strs .. 3   (offset: 0x15a8)
// exports ... 19  (offset: 0xd94)
// cseg ...... 0x1c2 + 0xbd2 (0xd94)
// imports ... 33  (offset: 0x108c)
// animtree1 . 0   (offset: 0x15cc)
// animtree2 . 0   (offset: 0x15cc)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\gamelogic;

#namespace codcaster_utils;

// Namespace codcaster_utils
// Params 3
// Checksum 0xcc357a68, Offset: 0x1e0
// Size: 0x60
function function_daf7fb7edb6acdbd( notificationid, clientnum, extradata )
{
    if ( !isdefined( level.var_913cd16747e527e5 ) || level.var_913cd16747e527e5 == 0 )
    {
        level thread function_8713b8656ececdd7();
    }
    
    enqueuenotification( function_10020e8422e7f5f7( notificationid, clientnum, extradata ) );
    level notify( #"hash_f73e440e863b042c" );
}

// Namespace codcaster_utils
// Params 0
// Checksum 0xc162a27, Offset: 0x248
// Size: 0xf4
function function_8713b8656ececdd7()
{
    level endon( #"game_ended" );
    level.var_913cd16747e527e5 = 1;
    var_436a89503965bf10 = getdvarint( @"hash_f56b9053764e5971", 3 );
    
    while ( true )
    {
        if ( !isstruct( game[ #"hash_1cf29b7666d960ed" ] ) )
        {
            game[ #"hash_1cf29b7666d960ed" ] = function_548d4c3e78f9703d();
        }
        
        queue = game[ #"hash_1cf29b7666d960ed" ];
        
        while ( queue.head < queue.tail )
        {
            function_40854157004ff280( queue.queue[ queue.head ] );
            queue.queue[ queue.head ] = undefined;
            queue.head++;
            waitframes( var_436a89503965bf10 );
        }
        
        function_40854157004ff280( 999 );
        level waittill( #"hash_f73e440e863b042c" );
    }
}

// Namespace codcaster_utils
// Params 1, eflags: 0x4
// Checksum 0x7d93864e, Offset: 0x344
// Size: 0x7b
function private enqueuenotification( var_6eafd5b000f8a5db )
{
    if ( !isdefined( game[ #"hash_1cf29b7666d960ed" ] ) )
    {
        game[ #"hash_1cf29b7666d960ed" ] = function_548d4c3e78f9703d();
    }
    
    queue = game[ #"hash_1cf29b7666d960ed" ];
    
    if ( isint( queue.tail ) )
    {
        queue.queue[ queue.tail ] = var_6eafd5b000f8a5db;
        queue.tail++;
    }
}

// Namespace codcaster_utils
// Params 0, eflags: 0x4
// Checksum 0xa0f278fe, Offset: 0x3c7
// Size: 0x21
function private function_548d4c3e78f9703d()
{
    return { #tail:0, #head:0, #queue:[] };
}

// Namespace codcaster_utils
// Params 1
// Checksum 0x64ccd810, Offset: 0x3f1
// Size: 0x22
function function_40854157004ff280( var_6eafd5b000f8a5db )
{
    if ( isdefined( var_6eafd5b000f8a5db ) )
    {
        setomnvar( o"ui_codcaster_notification", var_6eafd5b000f8a5db );
    }
}

// Namespace codcaster_utils
// Params 1
// Checksum 0xb0f845a9, Offset: 0x41b
// Size: 0x70
function function_ba4d0515f8c36de2( codcaster )
{
    oobtype = 0;
    oobtime = 0;
    
    if ( isdefined( self.oobtype ) )
    {
        oobtype = self.oobtype;
    }
    
    if ( isdefined( self.oobendtime ) )
    {
        oobtime = self.oobendtime;
    }
    
    codcaster setclientomnvar( "ui_out_of_bounds_type", oobtype );
    codcaster setclientomnvar( "ui_out_of_bounds_countdown", oobtime );
}

// Namespace codcaster_utils
// Params 3
// Checksum 0x5ae84e82, Offset: 0x493
// Size: 0xb0
function function_10020e8422e7f5f7( notificationid, clientnum, extradata )
{
    assert( notificationid < 999, "<dev string:x24>" );
    var_6eafd5b000f8a5db = notificationid;
    
    if ( isdefined( clientnum ) )
    {
        assert( clientnum < 998, "<dev string:x4b>" );
        var_6eafd5b000f8a5db += ( clientnum + 1 ) * 100 * 10;
    }
    
    if ( isdefined( extradata ) )
    {
        if ( isnumber( extradata ) )
        {
            assert( extradata < 4293, "<dev string:x6d>" );
            var_6eafd5b000f8a5db += ( extradata + 1 ) * 100 * 10 * 1000;
        }
        else
        {
            utility::error( "codcaster notification extra data supports numbers only. Invalid extra data: " + extradata );
        }
    }
    
    return var_6eafd5b000f8a5db;
}

// Namespace codcaster_utils
// Params 0
// Checksum 0xb05c8204, Offset: 0x54c
// Size: 0x45
function function_b068a61a9ecf1f47()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe();
        gamelengthseconds = int( floor( game_utility_mp::getgamelength() / 1000 ) );
        setomnvar( o"ui_total_game_time", gamelengthseconds );
    }
}

// Namespace codcaster_utils
// Params 2
// Checksum 0x3618db6a, Offset: 0x599
// Size: 0x96
function function_df0a55c77c9df04f( shouldpausetimer, discardtime )
{
    if ( getdvarint( @"bg_esports_should_timeout" ) == 1 && level.gametype != "koth" )
    {
        if ( getdvarint( @"bg_esports_is_in_timeout" ) == 0 )
        {
            setdvar( @"bg_esports_is_in_timeout", 1 );
        }
        
        if ( shouldpausetimer )
        {
            esportspausetimer( discardtime );
        }
        
        while ( getdvarint( @"bg_esports_should_timeout" ) == 1 )
        {
            waitframe();
        }
        
        setdvar( @"bg_esports_is_in_timeout", 0 );
        return 5;
    }
    
    return -1;
}

// Namespace codcaster_utils
// Params 1
// Checksum 0xf9487c3a, Offset: 0x638
// Size: 0x36
function esportspausetimer( discardtime )
{
    if ( !level.var_17ebe57584c369c9 )
    {
        level.var_17ebe57584c369c9 = 1;
        level.var_1f29a5f42a3ac296 = discardtime;
        gamelogic_mp::pausetimer();
    }
}

// Namespace codcaster_utils
// Params 0
// Checksum 0x8ca25a48, Offset: 0x676
// Size: 0x1f
function esportsresumetimer()
{
    if ( level.var_17ebe57584c369c9 )
    {
        level.var_17ebe57584c369c9 = 0;
        gamelogic_mp::resumetimer();
    }
}

// Namespace codcaster_utils
// Params 1
// Checksum 0x3d0f32b0, Offset: 0x69d
// Size: 0x2c
function waitframes( var_86f1bc0a3dee1a54 )
{
    leftframes = var_86f1bc0a3dee1a54;
    
    while ( leftframes > 0 )
    {
        leftframes -= 1;
        waitframe();
    }
}

// Namespace codcaster_utils
// Params 4
// Checksum 0x8b37e01c, Offset: 0x6d1
// Size: 0x66
function function_3038b6eafc46c037( announcementid, team, clientnum, extradata )
{
    announcementid += 100;
    
    if ( isdefined( team ) )
    {
        if ( team == "axis" )
        {
            announcementid += 100;
        }
        else if ( team == "allies" )
        {
            announcementid += 200;
        }
    }
    
    function_daf7fb7edb6acdbd( announcementid, clientnum, extradata );
}

// Namespace codcaster_utils
// Params 0
// Checksum 0xa75d6e52, Offset: 0x73f
// Size: 0x2d
function peeknext()
{
    val = self.data[ self.index ];
    self.index++;
    return val;
}

// Namespace codcaster_utils
// Params 0
// Checksum 0x5769e445, Offset: 0x775
// Size: 0x2b6
function function_dc73e47345f148f3()
{
    refereeinfo = spawnstruct();
    
    if ( game[ "gameStateRestoreAlreadyUsed" ] )
    {
        refereeinfo.enabled = 0;
        return;
    }
    
    var_327cd28e3cfe38ac = function_a20da59114cb2ec6();
    var_15533916f8e37c9e = spawnstruct();
    var_15533916f8e37c9e.data = var_327cd28e3cfe38ac;
    var_15533916f8e37c9e.index = 0;
    refereeinfo.enabled = var_15533916f8e37c9e peeknext();
    
    if ( refereeinfo.enabled )
    {
        refereeinfo.gametime = var_15533916f8e37c9e peeknext();
        refereeinfo.team1score = var_15533916f8e37c9e peeknext();
        refereeinfo.var_3fb15af86e0419a5 = var_15533916f8e37c9e peeknext();
        refereeinfo.team1kills = var_15533916f8e37c9e peeknext();
        refereeinfo.team2score = var_15533916f8e37c9e peeknext();
        refereeinfo.var_83efbf121a15d016 = var_15533916f8e37c9e peeknext();
        refereeinfo.team2kills = var_15533916f8e37c9e peeknext();
        players = [];
        
        for ( playerid = 0; playerid < 8 ; playerid++ )
        {
            if ( var_15533916f8e37c9e peeknext() == 0 )
            {
                break;
            }
            
            players[ playerid ] = spawnstruct();
            players[ playerid ].identifier = var_15533916f8e37c9e peeknext();
            players[ playerid ].kills = var_15533916f8e37c9e peeknext();
            players[ playerid ].deaths = var_15533916f8e37c9e peeknext();
            players[ playerid ].killstreaksprogress = var_15533916f8e37c9e peeknext();
            players[ playerid ].scorestreaksprogress = var_15533916f8e37c9e peeknext();
            killstreaks = [];
            
            for ( killstreakid = 0; killstreakid < 4 ; killstreakid++ )
            {
                if ( var_15533916f8e37c9e peeknext() == 0 )
                {
                    break;
                }
                
                killstreaks[ killstreakid ] = spawnstruct();
                killstreaks[ killstreakid ].reference = var_15533916f8e37c9e peeknext();
                killstreaks[ killstreakid ].earned = var_15533916f8e37c9e peeknext();
                killstreaks[ killstreakid ].used = var_15533916f8e37c9e peeknext();
            }
            
            players[ playerid ].killstreaks = killstreaks;
            players[ playerid ].fieldupgrade = spawnstruct();
            players[ playerid ].fieldupgrade.reference = var_15533916f8e37c9e peeknext();
            players[ playerid ].fieldupgrade.progress = var_15533916f8e37c9e peeknext();
        }
        
        refereeinfo.players = players;
    }
    
    return refereeinfo;
}

// Namespace codcaster_utils
// Params 3
// Checksum 0x2f4bd48f, Offset: 0xa34
// Size: 0x56
function function_c2c643e0ac6e6a6( timeToBeatTeam, timetobeat, timeToBeatOld )
{
    setomnvar( "ui_codcaster_left_time_to_beat", "allies" == timeToBeatTeam ? timetobeat : timeToBeatOld );
    setomnvar( "ui_codcaster_right_time_to_beat", "axis" == timeToBeatTeam ? timetobeat : timeToBeatOld );
}

// Namespace codcaster_utils
// Params 2
// Checksum 0x7e173f94, Offset: 0xa92
// Size: 0x185
function function_eddb7bc4ce563395( statvalue, team )
{
    assert( statvalue <= 1023 );
    clamp( statvalue, 0, 1023 );
    
    if ( isdefined( team ) )
    {
        return;
    }
    
    if ( team == "allies" )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || player.team != "codcaster" )
            {
                continue;
            }
            
            player setclientomnvar( "ui_round_end_friendly_score", statvalue, 1 );
        }
        
        return;
    }
    
    if ( team == "axis" )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || player.team != "codcaster" )
            {
                continue;
            }
            
            player setclientomnvar( "ui_round_end_enemy_score", statvalue, 1 );
        }
    }
}

// Namespace codcaster_utils
// Params 0
// Checksum 0xd6e566a9, Offset: 0xc1f
// Size: 0x175
function function_64859d45e0270ca8()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        waitframe();
        currentclientnum = self getspectatedplayerclientnum();
        codcasterclientnum = self getentitynumber();
        
        if ( codcasterclientnum == currentclientnum )
        {
            self setclientomnvar( "ui_br_bink_overlay_state", 0 );
            continue;
        }
        
        if ( self.lastclientnum != currentclientnum )
        {
            self.spectatedplayer = undefined;
            
            foreach ( player in level.players )
            {
                playerclientnum = player getentitynumber();
                
                if ( playerclientnum == currentclientnum )
                {
                    self.spectatedplayer = player;
                    self.lastclientnum = currentclientnum;
                    break;
                }
            }
        }
        
        if ( isdefined( self.spectatedplayer ) )
        {
            var_704aa467e9f3760c = self.spectatedplayer getclientomnvar( "ui_br_bink_overlay_state" );
            
            if ( var_704aa467e9f3760c == 6 || var_704aa467e9f3760c == 7 )
            {
                self setclientomnvar( "ui_br_bink_overlay_state", var_704aa467e9f3760c );
            }
            else
            {
                self setclientomnvar( "ui_br_bink_overlay_state", 0 );
            }
            
            continue;
        }
        
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
    }
}

