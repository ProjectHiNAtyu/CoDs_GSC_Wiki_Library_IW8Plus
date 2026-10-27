// scripts\mp\matchrecording.gsc  (hash_59a28aa393c6bb32.gscc) (size: 13147 Bytes / 0x335b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x557fb152 (1434431826)
// size ...... 13147 (0x335b)
// includes .. 6   (offset: 0x2ce7)
// strings ... 104 (offset: 0x2d17)
// dev strs .. 19  (offset: 0x3273)
// exports ... 27  (offset: 0x2153)
// cseg ...... 0xac6 + 0x168d (0x2153)
// imports ... 59  (offset: 0x258b)
// animtree1 . 0   (offset: 0x335b)
// animtree2 . 0   (offset: 0x335b)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\matchdata;

#namespace matchrecording;

// Namespace matchrecording
// Params 0
// Checksum 0x591372e3, Offset: 0xae4
// Size: 0x140
function init()
{
    assert( !isdefined( level.matchrecording_type ), "<dev string:x24>" );
    recordingtype = matchrecording_getrecordingtype();
    
    if ( !matchrecording_validaterecordingtype( recordingtype ) )
    {
        return;
    }
    else
    {
        level.matchrecording_type = recordingtype;
    }
    
    level.matchreceventcountline = 0;
    level.matchrecevents = [];
    level.matchrecording_logevent = &matchrecording_logevent;
    level.matchrecording_logeventmsg = &matchrecording_logeventmsg;
    level.matchrecording_logeventplayername = &matchrecording_logeventplayername;
    level.matchrecording_dump = &matchrecording_dump;
    level.matchrecording_generateid = &matchrecording_generateid;
    level.matchrecording_usereventthink = &matchrecording_usereventthink;
    
    if ( level.matchrecording_type == 1 )
    {
        matchrecording_glog_addheader();
    }
    else if ( level.matchrecording_type == 3 )
    {
        matchrecording_scriptdata_openfileaddheader( 1 );
    }
    
    level thread matchrecording_logallplayerposthink();
    level thread matchrecording_onplayerconnect();
    level thread matchrecording_loggameendstats();
    level thread matchrecording_vehiclewatcher( "matchrecording_ground_vehicle", "GROUND_VEHICLE" );
    level thread matchrecording_vehiclewatcher( "matchrecording_small_ground_vehicle", "SMALL_GROUND_VEHICLE" );
    level thread matchrecording_vehiclewatcher( "matchrecording_plane", "PLANE_VEHICLE" );
    level thread matchrecording_vehiclewatcher( "matchrecording_chopper", "CHOPPER_VEHICLE" );
}

// Namespace matchrecording
// Params 0
// Checksum 0x9dc6185b, Offset: 0xc2c
// Size: 0x77
function matchrecording_getrecordingtype()
{
    if ( game_utility_mp::lpcfeaturegated() && game_utility::getgametype() != "arm" && game_utility::getgametype() != "conflict" )
    {
        return 0;
    }
    
    type = getdvarint( @"scr_match_recording", 0 );
    
    if ( type == 0 && getdvarint( @"hash_b328f87e7c1ded21", 0 ) == 1 )
    {
        type = 1;
    }
    else if ( analyticsstreamerislogfilestreamingenabled() )
    {
        type = 1;
    }
    
    return type;
}

// Namespace matchrecording
// Params 1
// Checksum 0x7eb30995, Offset: 0xcac
// Size: 0xe7
function matchrecording_validaterecordingtype( typeval )
{
    result = 1;
    
    if ( typeval == 0 )
    {
        result = 0;
    }
    else if ( typeval < 0 || typeval > 4 )
    {
        assertmsg( "<dev string:x49>" + typeval );
        result = 0;
    }
    else if ( typeval == 3 || typeval == 4 )
    {
        var_790b4dc82af7750f = 0;
        
        /#
            var_790b4dc82af7750f = 1;
        #/
        
        if ( !var_790b4dc82af7750f )
        {
            assertmsg( "<dev string:xbc>" + typeval );
            result = 0;
        }
    }
    else if ( typeval == 1 || typeval == 2 )
    {
        var_bb6a0b7a3c0b57ad = getdvarint( @"hash_b328f87e7c1ded21", 0 );
        var_37d8d95a3c4cb36 = analyticsstreamerislogfilestreamingenabled();
        result = var_bb6a0b7a3c0b57ad == 1 || var_37d8d95a3c4cb36 == 1;
        assert( result == 1, "<dev string:x12b>" );
    }
    
    return result;
}

// Namespace matchrecording
// Params 0
// Checksum 0xdb10b4a, Offset: 0xd9c
// Size: 0xd, Type: bool
function matchrecording_isenabled()
{
    return level.matchrecording_type > 0;
}

// Namespace matchrecording
// Params 1
// Checksum 0x75e2fa93, Offset: 0xdb2
// Size: 0x58
function matchrecording_teammap( teamname )
{
    if ( isdefined( level.teambased ) && !level.teambased )
    {
        result = 2;
    }
    else if ( !isdefined( teamname ) || teamname == "allies" )
    {
        result = 2;
    }
    else
    {
        result = 3;
    }
    
    return result;
}

// Namespace matchrecording
// Params 1
// Checksum 0x2619f5cc, Offset: 0xe13
// Size: 0x304
function matchrecording_eventcharmap( event )
{
    eventchar = undefined;
    
    switch ( event )
    {
        case #"hash_ec91d04aafaffe56":
            eventchar = "p";
            break;
        case #"hash_945fc291982ded18":
            eventchar = "s";
            break;
        case #"hash_f8c2554e05678a8d":
            eventchar = "d";
            break;
        case #"hash_8f7fd70c5987ea59":
            eventchar = "b";
            break;
        case #"hash_36c6169aaf0125a0":
            eventchar = "e";
            break;
        case #"hash_3819040083fb6294":
            eventchar = "t";
            break;
        case #"hash_8d9e20b710f779a7":
            eventchar = "l";
            break;
        case #"hash_3dd92e59bd6a825e":
            eventchar = "[";
            break;
        case #"hash_bfab0a97caa56709":
            eventchar = "]";
            break;
        case #"hash_15aa75e5faef833b":
            eventchar = "A";
            break;
        case #"hash_15aa76e5faef84ce":
            eventchar = "B";
            break;
        case #"hash_15aa77e5faef8661":
            eventchar = "C";
            break;
        case #"hash_15aa78e5faef87f4":
            eventchar = "D";
            break;
        case #"hash_15aa79e5faef8987":
            eventchar = "E";
            break;
        case #"hash_15aa84e5faef9ad8":
            eventchar = "0";
            break;
        case #"hash_15aa85e5faef9c6b":
            eventchar = "1";
            break;
        case #"hash_15aa86e5faef9dfe":
            eventchar = "2";
            break;
        case #"hash_15aa87e5faef9f91":
            eventchar = "3";
            break;
        case #"hash_15aa88e5faefa124":
            eventchar = "4";
            break;
        case #"hash_af78f78a213f2e9a":
            eventchar = "S";
            break;
        case #"hash_99264a563d62312b":
            eventchar = "O";
            break;
        case #"hash_77fea0649b41a0d5":
            eventchar = "!";
            break;
        case #"hash_30765763b6eae663":
            eventchar = "m";
            break;
        case #"hash_27bd18e3a64148c2":
            eventchar = "u";
            break;
        case #"hash_ebe8ddb545ee11c0":
            eventchar = "?";
            break;
        case #"hash_84e2df1e1e7795ee":
            eventchar = "n";
            break;
        case #"hash_5dad097e1ee588e":
            eventchar = "+";
            break;
        case #"hash_8eb45d501d18b819":
            eventchar = "^";
            break;
        case #"hash_faf31591468c0301":
            eventchar = "G";
            break;
        case #"hash_539e90ea786e44c5":
            eventchar = "g";
            break;
        case #"hash_bd9d4e183a058042":
            eventchar = "V";
            break;
        case #"hash_933571b34f210f5f":
            eventchar = "H";
            break;
        default:
            assertmsg( "<dev string:x16c>" + event );
            break;
    }
    
    return eventchar;
}

// Namespace matchrecording
// Params 0
// Checksum 0x8f3a0b77, Offset: 0x1120
// Size: 0x162
function matchrecording_getfileheaderarray()
{
    array = [];
    array[ array.size ] = "<mrec_start> \n";
    array[ array.size ] = "<mrec_map> " + level.script + "\n";
    array[ array.size ] = "<mrec_game_type> " + game_utility::getgametype() + "\n";
    array[ array.size ] = "<mrec_event_def> PATH p\n";
    array[ array.size ] = "<mrec_event_def> PATH_SPAWN s\n";
    array[ array.size ] = "<mrec_event_def> PATH_DEATH d\n";
    array[ array.size ] = "<mrec_event_def> PATH_BULLET b\n";
    array[ array.size ] = "<mrec_event_def> PATH_EXPLOSION e\n";
    array[ array.size ] = "<mrec_event_def> ANCHOR t\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_LINE l 255,0,0,0\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_LINE [ 255,255,127,0\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_LINE ] 255,0,255,255\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE A flagA.tga flagAallies.tga flagAaxis.tga\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE B flagB.tga flagBallies.tga flagBaxis.tga\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE C flagC.tga flagCallies.tga flagCaxis.tga\n";
    array[ array.size ] = "<mrec_event_def> SPAWN_ENTITY S\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE O flagAallies.tga flagAaxis.tga\n";
    array[ array.size ] = "<mrec_event_def> LOG_MESSAGE ! \"No good spawns found. Using bad spawn.\" \n";
    array[ array.size ] = "<mrec_event_def> LOG_MESSAGE m \"MSG: \" \n";
    array[ array.size ] = "<mrec_event_def> LOG_MESSAGE u \"User Event From \" \n";
    array[ array.size ] = "<mrec_event_def> LOG_MESSAGE ? \"STAT: \" \n";
    array[ array.size ] = "<mrec_event_def> PLAYER_NAME n\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE + bestSpawnAllies.tga\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE ^ bestSpawnAxis.tga\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE G blank.tga groundVehicleAllies.tga groundVehicleAxis.tga\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE g blank.tga smallGroundVehicleAllies.tga smallGroundVehicleAxis.tga\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE H blank.tga chopperAllies.tga chopperAxis.tga\n";
    array[ array.size ] = "<mrec_event_def> GENERIC_IMAGE V blank.tga planeAllies.tga planeAxis.tga\n";
    return array;
}

// Namespace matchrecording
// Params 9
// Checksum 0x32fe04ed, Offset: 0x128b
// Size: 0x1d8
function matchrecording_logevent( var_1774e12b264ce3c4, teamname, event, x, y, timemsec, opstateindex, var_7b38db2b12faf100, var_ad9c1d166d517645 )
{
    if ( !matchrecording_isenabled() )
    {
        return;
    }
    
    matchrecording_inceventlinecount();
    teamidx = matchrecording_teammap( teamname );
    xy = int( x ) + "," + int( y );
    eventchar = matchrecording_eventcharmap( event );
    
    if ( event == "BULLET" || event == "FRONT_LINE" || event == "FRONT_LINE_ALLIES" || event == "FRONT_LINE_AXIS" )
    {
        assert( isdefined( var_7b38db2b12faf100 ) && isdefined( var_ad9c1d166d517645 ), "<dev string:x1a6>" + event + "<dev string:x1c8>" );
    }
    
    strstate = "";
    
    if ( isdefined( opstateindex ) )
    {
        assert( opstateindex == int( opstateindex ) && opstateindex >= 0, "<dev string:x1f6>" );
        strstate = " s:" + opstateindex;
    }
    
    xyend = "";
    
    if ( isdefined( var_7b38db2b12faf100 ) && isdefined( var_ad9c1d166d517645 ) )
    {
        xyend = " " + int( var_7b38db2b12faf100 ) + "," + int( var_ad9c1d166d517645 );
    }
    
    eventpack = "|" + var_1774e12b264ce3c4 + " " + teamidx + " " + eventchar + " " + xy + " " + timemsec + xyend + strstate;
    level.matchrecevents[ level.matchrecevents.size - 1 ] += eventpack;
}

// Namespace matchrecording
// Params 3
// Checksum 0xc0caa56c, Offset: 0x146b
// Size: 0xc0
function matchrecording_logeventmsg( event, timemsec, var_c9d87722a2d951ea )
{
    if ( !matchrecording_isenabled() )
    {
        return;
    }
    
    matchrecording_inceventlinecount();
    eventchar = matchrecording_eventcharmap( event );
    
    if ( var_c9d87722a2d951ea != "" )
    {
        if ( !isdefined( var_c9d87722a2d951ea ) )
        {
            var_c9d87722a2d951ea = "";
        }
        else
        {
            var_c9d87722a2d951ea = " \"" + var_c9d87722a2d951ea + "\"";
        }
    }
    
    eventpack = "|0 0 " + eventchar + " " + timemsec + var_c9d87722a2d951ea;
    level.matchrecevents[ level.matchrecevents.size - 1 ] += eventpack;
}

// Namespace matchrecording
// Params 3
// Checksum 0x451a06ca, Offset: 0x1533
// Size: 0xc4
function matchrecording_logeventplayername( ownerid, teamname, ownername )
{
    if ( !matchrecording_isenabled() )
    {
        return;
    }
    
    matchrecording_inceventlinecount();
    teamidx = matchrecording_teammap( teamname );
    eventchar = matchrecording_eventcharmap( "PLAYER_NAME" );
    eventpack = "|" + ownerid + " " + teamidx + " " + eventchar + " " + "\"" + ownername + "\"";
    level.matchrecevents[ level.matchrecevents.size - 1 ] += eventpack;
}

// Namespace matchrecording
// Params 0
// Checksum 0xb6ae6e73, Offset: 0x15ff
// Size: 0xbb
function matchrecording_inceventlinecount()
{
    level.matchreceventcountline++;
    
    if ( level.matchrecevents.size == 0 )
    {
        level.matchrecevents[ level.matchrecevents.size ] = "<mrec_events> ";
        level.matchreceventcountline = 0;
        return;
    }
    
    if ( level.matchreceventcountline > 30 || level.matchrecevents[ level.matchrecevents.size - 1 ].size > 800 )
    {
        if ( level.matchrecording_type == 1 || level.matchrecording_type == 3 )
        {
            matchrecording_dump();
        }
        
        level.matchrecevents[ level.matchrecevents.size ] = "<mrec_events> ";
        level.matchreceventcountline = 0;
    }
}

// Namespace matchrecording
// Params 0
// Checksum 0x4f450d8f, Offset: 0x16c2
// Size: 0xa7
function matchrecording_dump()
{
    if ( !matchrecording_isenabled() )
    {
        return;
    }
    
    if ( !isdefined( level.matchrecevents ) || level.matchrecevents.size == 0 )
    {
        return;
    }
    
    switch ( level.matchrecording_type )
    {
        case 1:
        case 2:
            matchrecording_glog_dump();
            break;
        case 3:
        case 4:
            matchrecording_scriptdata_dump();
            break;
        default:
            assertmsg( "<dev string:x249>" + level.matchrecording_type );
            break;
    }
}

// Namespace matchrecording
// Params 0
// Checksum 0x43e9c76b, Offset: 0x1771
// Size: 0xb3
function matchrecording_glog_dump()
{
    if ( level.matchrecording_type == 2 )
    {
        matchrecording_glog_addheader();
    }
    
    foreach ( eventstr in level.matchrecevents )
    {
        logprint( eventstr + "\n" );
        
        if ( analyticsstreamerislogfilestreamingenabled() )
        {
            analyticsstreamerlogfilewritetobuffer( eventstr + "\n" );
        }
    }
    
    level.matchrecevents = [];
}

// Namespace matchrecording
// Params 0
// Checksum 0xf0d96465, Offset: 0x182c
// Size: 0x90
function matchrecording_glog_addheader()
{
    headerstrings = matchrecording_getfileheaderarray();
    
    foreach ( h in headerstrings )
    {
        logprint( h );
        
        if ( analyticsstreamerislogfilestreamingenabled() )
        {
            analyticsstreamerlogfilewritetobuffer( h );
        }
    }
}

/#

    // Namespace matchrecording
    // Params 0
    // Checksum 0x2194f7de, Offset: 0x18c4
    // Size: 0x95, Type: dev
    function matchrecording_scriptdata_openfilewrite()
    {
        assert( !isdefined( level.var_518f1200b12659ce ), "<dev string:x28b>" );
        level.var_518f1200b12659ce = "<dev string:x2de>" + level.script + "<dev string:x2f8>" + game_utility::getgametype() + "<dev string:x2f8>" + matchdata::getmatchstarttimeutc() + "<dev string:x2fa>";
        fileid = openfile( level.var_518f1200b12659ce, "<dev string:x2ff>" );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x305>" + level.var_518f1200b12659ce );
        }
        
        return fileid;
    }

    // Namespace matchrecording
    // Params 0
    // Checksum 0xb8555ee3, Offset: 0x1961
    // Size: 0x63, Type: dev
    function matchrecording_scriptdata_openfileappend()
    {
        if ( !isdefined( level.var_518f1200b12659ce ) )
        {
            assertmsg( "<dev string:x347>" );
            return -1;
        }
        
        fileid = openfile( level.var_518f1200b12659ce, "<dev string:x3a2>" );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x3a9>" + level.var_518f1200b12659ce );
        }
        
        return fileid;
    }

#/

// Namespace matchrecording
// Params 1
// Checksum 0x658b3b19, Offset: 0x19cc
// Size: 0xb0
function matchrecording_scriptdata_openfileaddheader( closeafter )
{
    /#
        fileid = matchrecording_scriptdata_openfilewrite();
        headerstrings = matchrecording_getfileheaderarray();
        
        foreach ( h in headerstrings )
        {
            fprintln( fileid, h );
        }
        
        if ( closeafter )
        {
            fileid = closefile( fileid );
        }
        
        return fileid;
    #/
}

// Namespace matchrecording
// Params 0
// Checksum 0x9d720fc5, Offset: 0x1a84
// Size: 0xf5
function matchrecording_scriptdata_dump()
{
    /#
        fileid = -1;
        
        if ( level.matchrecording_type == 4 )
        {
            fileid = matchrecording_scriptdata_openfileaddheader( 0 );
        }
        else if ( level.matchrecording_type == 3 )
        {
            fileid = matchrecording_scriptdata_openfileappend();
        }
        
        if ( fileid == -1 )
        {
            return;
        }
        
        foreach ( eventstr in level.matchrecevents )
        {
            fprintln( fileid, eventstr );
        }
        
        fileid = closefile( fileid );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x3d7>" + level.var_518f1200b12659ce );
        }
        
        level.matchrecevents = [];
    #/
}

// Namespace matchrecording
// Params 0
// Checksum 0xcef7a6d0, Offset: 0x1b81
// Size: 0x12f
function matchrecording_logallplayerposthink()
{
    if ( !matchrecording_isenabled() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        timestart = gettime();
        players = level.players;
        
        foreach ( player in players )
        {
            time = gettime();
            
            if ( player::isreallyalive( player ) )
            {
                matchrecording_logevent( player.clientid, player.team, "PATH", player.origin[ 0 ], player.origin[ 1 ], time );
                waitframe();
            }
        }
        
        wait max( level.framedurationseconds, 1.5 - ( gettime() - timestart ) / 1000 );
    }
}

// Namespace matchrecording
// Params 0
// Checksum 0x82c853e5, Offset: 0x1cb8
// Size: 0x2c
function matchrecording_onplayerconnect()
{
    while ( true )
    {
        level waittill( #"connected", player );
        player thread matchrecording_usereventthink();
    }
}

// Namespace matchrecording
// Params 0
// Checksum 0x5da61d53, Offset: 0x1cec
// Size: 0x1fa
function matchrecording_loggameendstats()
{
    level waittill( #"game_ended" );
    sidekillcount = 0;
    engagementcount = 0;
    engagementtotal = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.sidekillcount ) )
        {
            sidekillcount = player.sidekillcount;
        }
        
        if ( isdefined( player.engagementcount ) )
        {
            engagementcount = player.engagementcount;
        }
        
        if ( isdefined( player.engagementtime ) )
        {
            engagementtotal = player.engagementtime;
        }
    }
    
    if ( engagementcount > 0 )
    {
        matchrecording_logeventmsg( "LOG_STAT", gettime(), "Shot in the back percent: " + sidekillcount / engagementcount * 100 + "%" );
        matchrecording_logeventmsg( "LOG_STAT", gettime(), "Avg. Engagement Length: " + engagementtotal / engagementcount / 1000 + "s" );
    }
    
    if ( isdefined( level.frontlineinfo ) && isdefined( level.frontlineinfo.uptime ) && isdefined( level.frontlineinfo.downtime ) )
    {
        totaltime = level.frontlineinfo.uptime + level.frontlineinfo.downtime;
        
        if ( totaltime > 0 )
        {
            matchrecording_logeventmsg( "LOG_STAT", gettime(), "Frontline Uptime: " + level.frontlineinfo.uptime / totaltime * 100 + "%" );
        }
    }
}

// Namespace matchrecording
// Params 0
// Checksum 0xe138f782, Offset: 0x1eee
// Size: 0xb3
function matchrecording_usereventthink()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isai( self ) )
    {
        return;
    }
    
    self notifyonplayercommand( "log_user_event_start", "+actionslot 3" );
    self notifyonplayercommand( "log_user_event_end", "-actionslot 3" );
    self notifyonplayercommand( "log_user_event_generic_event", "+gostand" );
    
    while ( true )
    {
        self waittill( #"log_user_event_start" );
        notification = utility::waittill_any_return_no_endon_death( "log_user_event_end", "log_user_event_generic_event" );
        
        if ( notification == "log_user_event_generic_event" )
        {
            self iprintlnbold( "Event Logged" );
            matchrecording_logeventmsg( "LOG_USER_EVENT", gettime(), self.name );
        }
    }
}

// Namespace matchrecording
// Params 0
// Checksum 0x2aa9e7ca, Offset: 0x1fa9
// Size: 0x33
function matchrecording_generateid()
{
    if ( !isdefined( game[ "matchRecording_nextID" ] ) )
    {
        game[ "matchRecording_nextID" ] = 100;
    }
    
    returnvalue = game[ "matchRecording_nextID" ];
    game[ "matchRecording_nextID" ]++;
    return returnvalue;
}

// Namespace matchrecording
// Params 2
// Checksum 0xc10d8ff2, Offset: 0x1fe5
// Size: 0x45
function matchrecording_vehiclewatcher( notifymsg, logtype )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( notifymsg, vehicle );
        vehicle matchrecording_vehicletrackingthink( logtype );
    }
}

// Namespace matchrecording
// Params 1
// Checksum 0xbfb0ee83, Offset: 0x2032
// Size: 0xd4
function matchrecording_vehicletrackingthink( logtype )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicleid = matchrecording_generateid();
    
    if ( !isdefined( self.team ) )
    {
        iprintln( "MatchRecording - Can't log vehicle, because it has no team" );
        return;
    }
    
    if ( !isdefined( self.origin ) )
    {
        iprintln( "MatchRecording - Can't log vehicle, because it has no origin" );
        return;
    }
    
    thread matchrecording_vehiclecleanupthink( vehicleid, logtype );
    
    while ( true )
    {
        state = self.team == "allies" ? 1 : 2;
        matchrecording_logevent( vehicleid, self.team, logtype, self.origin[ 0 ], self.origin[ 1 ], gettime(), state );
        wait 0.25;
    }
}

// Namespace matchrecording
// Params 2
// Checksum 0x1f9eb552, Offset: 0x210e
// Size: 0x45
function matchrecording_vehiclecleanupthink( logid, logtype )
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    matchrecording_logevent( logid, "allies", logtype, 0, 0, gettime(), 0 );
}

