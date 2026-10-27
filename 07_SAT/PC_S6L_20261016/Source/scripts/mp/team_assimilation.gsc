// scripts\mp\team_assimilation.gsc  (hash_3ff084f114b7f6c9.gscc) (size: 18562 Bytes / 0x4882 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6108391b (1627928859)
// size ...... 18562 (0x4882)
// includes .. 18  (offset: 0x459e)
// strings ... 35  (offset: 0x462e)
// dev strs .. 8   (offset: 0x4822)
// exports ... 42  (offset: 0x2ef6)
// cseg ...... 0x407 + 0x2aef (0x2ef6)
// imports ... 126 (offset: 0x3586)
// animtree1 . 0   (offset: 0x4882)
// animtree2 . 0   (offset: 0x4882)
#using script_16ea1b94f0f381b3;
#using script_2b062cc62170d7a8;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\armor;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\cash;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\gamescore;
#using scripts\mp\health_chunks;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\squads;

#namespace team_assimilation;

// Namespace team_assimilation
// Params 0
// Checksum 0x5d76527f, Offset: 0x425
// Size: 0x20c
function init()
{
    utility::registersharedfunc( #"teamassim", #"requestleaveteam", &requestleaveteam, 1 );
    utility::registersharedfunc( #"teamassim", #"requestnearbyteamchange", &requestnearbyteamchange );
    utility::registersharedfunc( #"teamassim", #"resolveassimrequest", &resolveassimrequest );
    utility::registersharedfunc( #"teamassim", #"iswaitingforassimresponse", &iswaitingforassimresponse );
    utility::registersharedfunc( #"teamassim", #"isenabled", &function_8fe74e094005f15d );
    utility::registersharedfunc( #"teamassim", #"disableplayer", &function_aa6d43748d8cc8f4 );
    utility::registersharedfunc( #"teamassim", #"enableplayer", &function_5e1bb01356d21d7 );
    utility::registersharedfunc( #"teamassim", #"isplayersassimdisabled", &isplayersassimdisabled );
    utility::registersharedfunc( #"teamassim", #"permanentlydisableassim", &permanentlydisableassim );
    utility::registersharedfunc( #"teamassim", #"canassimilate", &canassimilate );
    utility::registersharedfunc( #"teamassim", #"canteamassimilate", &canteamassimilate );
    utility::registersharedfunc( #"teamassim", #"assimilateplayer", &assimilateplayer );
    utility::registersharedfunc( #"teamassim", #"shouldautoacceptteamswitch", &shouldautoacceptteamswitch );
    utility::registersharedfunc( #"teamassim", #"getmaxassimilationteamsize", &getmaxassimilationteamsize );
    utility::registersharedfunc( #"teamassim", #"senddirectassimrequest", &senddirectassimrequest );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_5a8569c195739438", &function_d9c0fea1eee68563 );
    
    while ( !level.gametypestarted )
    {
        waitframe();
    }
    
    if ( squad_utility::issquadmode() )
    {
        namespace_9fd3ecf626067599::function_ced28cc2c2efdabf( &function_3efb30390246d5d1 );
    }
    
    /#
        level thread function_9653adf30d8b9fb4();
    #/
}

// Namespace team_assimilation
// Params 5
// Checksum 0x1e27e470, Offset: 0x639
// Size: 0x88
function function_ffce0af7bde78497( player, oldteam, newteam, oldsquadindex, newsquadindex )
{
    params = { #player:player, #newteam:newteam, #oldteam:oldteam, #newsquadindex:newsquadindex, #oldsquadindex:oldsquadindex };
    player callback::callback( #"player_assimilated", params );
}

// Namespace team_assimilation
// Params 0
// Checksum 0xd0d67846, Offset: 0x6c9
// Size: 0x79
function function_8fe74e094005f15d()
{
    if ( !isdefined( level.var_116ed2db66e6e2ff ) )
    {
        if ( isdefined( level.gametypebundle.var_331a46dc69a8ec13 ) )
        {
            level.var_116ed2db66e6e2ff = level.gametypebundle.var_331a46dc69a8ec13 && getdvarint( @"scr_team_assimilation_enabled", 1 );
        }
        else
        {
            level.var_116ed2db66e6e2ff = getdvarint( @"scr_team_assimilation_enabled", 0 );
        }
    }
    
    return level.var_116ed2db66e6e2ff;
}

// Namespace team_assimilation
// Params 0
// Checksum 0x722ed9ca, Offset: 0x74b
// Size: 0x2e
function function_34e5f44e1553415d()
{
    if ( !isdefined( level.var_f7fbbc13550dbf3c ) )
    {
        level.var_f7fbbc13550dbf3c = getdvarint( @"hash_1d0d8806c4170519", 0 );
    }
    
    return level.var_f7fbbc13550dbf3c;
}

// Namespace team_assimilation
// Params 0
// Checksum 0xaa18e13f, Offset: 0x782
// Size: 0x88
function getmaxassimilationteamsize()
{
    if ( !isdefined( level.var_b781dca6a607a0d ) )
    {
        if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_45640ada8de83c49 ) )
        {
            level.var_b781dca6a607a0d = getdvarint( @"hash_cf23e6b4c2ae4e63", level.gametypebundle.var_45640ada8de83c49 );
        }
        else
        {
            level.var_b781dca6a607a0d = getdvarint( @"hash_cf23e6b4c2ae4e63", level.maxteamsize );
        }
    }
    
    return level.var_b781dca6a607a0d;
}

// Namespace team_assimilation
// Params 0
// Checksum 0x4fba80c8, Offset: 0x813
// Size: 0x2f
function function_cdcf2d8307759747()
{
    if ( !isdefined( level.var_775f474921948cd7 ) )
    {
        level.var_775f474921948cd7 = getdvarint( @"hash_a530e29a7e6e465f", 10 );
    }
    
    return level.var_775f474921948cd7;
}

// Namespace team_assimilation
// Params 0
// Checksum 0xcd723f79, Offset: 0x84b
// Size: 0x2f
function function_bfb6049bf456d1d0()
{
    if ( !isdefined( level.assimtimeout ) )
    {
        level.assimtimeout = getdvarint( @"scr_assimilation_timeout", 20 );
    }
    
    return level.assimtimeout;
}

// Namespace team_assimilation
// Params 0
// Checksum 0xcaeaf0a2, Offset: 0x883
// Size: 0x2f
function function_73344c25bedf76c4()
{
    if ( !isdefined( level.var_711fc9c3772fa85b ) )
    {
        level.var_711fc9c3772fa85b = getdvarint( @"hash_b030f536fdd71efb", 1 );
    }
    
    return level.var_711fc9c3772fa85b;
}

// Namespace team_assimilation
// Params 0
// Checksum 0x16f12b81, Offset: 0x8bb
// Size: 0x2f
function function_a90a44a5d92756f9()
{
    if ( !isdefined( level.var_67d01881f323f30 ) )
    {
        level.var_67d01881f323f30 = getdvarint( @"hash_f1801dd0c0e36ab6", 5 );
    }
    
    return level.var_67d01881f323f30;
}

// Namespace team_assimilation
// Params 0
// Checksum 0x268cb075, Offset: 0x8f3
// Size: 0x30
function function_7ffd3e5a7ff12115()
{
    if ( !isdefined( level.var_ac69b7bacbde6638 ) )
    {
        level.var_ac69b7bacbde6638 = getdvarint( @"hash_bb74d762ec936b6d", 1000 );
    }
    
    return level.var_ac69b7bacbde6638;
}

// Namespace team_assimilation
// Params 1
// Checksum 0x6d3cefcb, Offset: 0x92c
// Size: 0x47, Type: bool
function canteamassimilate( team )
{
    if ( !function_8fe74e094005f15d() )
    {
        return false;
    }
    
    players = teams::getteamdata( team, "players" );
    teamsize = players.size;
    return teamsize < getmaxassimilationteamsize();
}

// Namespace team_assimilation
// Params 2
// Checksum 0xa7b1c63, Offset: 0x97c
// Size: 0x56, Type: bool
function function_98ab13413d7fc534( team, squadid )
{
    if ( !function_8fe74e094005f15d() )
    {
        return false;
    }
    
    if ( !isdefined( level.squaddata[ team ][ squadid ] ) )
    {
        return false;
    }
    
    return level.squaddata[ team ][ squadid ].players.size < getmaxassimilationteamsize();
}

// Namespace team_assimilation
// Params 4
// Checksum 0x14c18884, Offset: 0x9db
// Size: 0xfe, Type: bool
function canassimilate( playerswitching, var_59b5ae61b767c98e, var_906dfe37dde97a89, hidemessage )
{
    if ( !( isdefined( playerswitching ) && isdefined( var_59b5ae61b767c98e ) ) )
    {
        return false;
    }
    
    if ( isplayersassimdisabled( var_906dfe37dde97a89 ) )
    {
        var_906dfe37dde97a89 hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_disabled" );
        return false;
    }
    
    if ( isplayersassimdisabled( playerswitching ) || isplayersassimdisabled( var_59b5ae61b767c98e ) )
    {
        var_906dfe37dde97a89 hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_disabled_enemy" );
        return false;
    }
    
    usingsquads = isdefined( level.squaddata );
    var_ab4909d0c40efe7e = var_59b5ae61b767c98e.team;
    
    if ( usingsquads && playerswitching.sessionsquadid == var_59b5ae61b767c98e.sessionsquadid )
    {
        return false;
    }
    else if ( !usingsquads && var_ab4909d0c40efe7e == playerswitching.team )
    {
        return false;
    }
    
    if ( !function_aab2d30d0c40fc72( var_59b5ae61b767c98e, playerswitching, var_906dfe37dde97a89, hidemessage ) )
    {
        return false;
    }
    
    return true;
}

// Namespace team_assimilation
// Params 1
// Checksum 0xde46aff0, Offset: 0xae2
// Size: 0x18, Type: bool
function iswaitingforassimresponse( player )
{
    return isdefined( player.var_a7d52e1692c58713 );
}

// Namespace team_assimilation
// Params 0, eflags: 0x4
// Checksum 0xa527df0, Offset: 0xb03
// Size: 0x2e
function private shouldautoacceptteamswitch()
{
    if ( !isdefined( level.var_4e7b2d44940cabf4 ) )
    {
        level.var_4e7b2d44940cabf4 = getdvarint( @"hash_a267ff0e64f57760", 0 );
    }
    
    return level.var_4e7b2d44940cabf4;
}

// Namespace team_assimilation
// Params 4, eflags: 0x4
// Checksum 0x75d348bd, Offset: 0xb3a
// Size: 0x1c1, Type: bool
function private function_aab2d30d0c40fc72( var_59b5ae61b767c98e, playerswitching, var_906dfe37dde97a89, var_8423127252ea94dc )
{
    if ( function_34e5f44e1553415d() && !playerswitching.inlaststand )
    {
        if ( !var_8423127252ea94dc )
        {
            var_906dfe37dde97a89 hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_player_not_downed" );
        }
        
        return false;
    }
    else if ( isdefined( level.squaddata ) && !function_98ab13413d7fc534( var_59b5ae61b767c98e.team, var_59b5ae61b767c98e.sessionsquadid ) )
    {
        if ( !var_8423127252ea94dc )
        {
            var_906dfe37dde97a89 hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_team_size" );
        }
        
        return false;
    }
    else if ( !isdefined( level.squaddata ) && !canteamassimilate( var_59b5ae61b767c98e.team ) )
    {
        if ( !var_8423127252ea94dc )
        {
            var_906dfe37dde97a89 hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_team_size" );
        }
        
        return false;
    }
    else if ( playerswitching vehicle::is_in_vehicle( 1 ) )
    {
        if ( !var_8423127252ea94dc )
        {
            var_906dfe37dde97a89 hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_player_in_vehicle" );
        }
        
        return false;
    }
    else if ( playerswitching.var_58d953483aea5402 && level.gametypebundle.var_41dc059ad91e4591 > 0 && !utility::time_has_passed( playerswitching.var_58d953483aea5402, level.gametypebundle.var_41dc059ad91e4591 ) )
    {
        if ( !var_8423127252ea94dc )
        {
            var_93045b31668a2b5f = playerswitching.var_58d953483aea5402 + level.gametypebundle.var_41dc059ad91e4591 * 1000 - gettime();
            var_906dfe37dde97a89 hud_message::showerrormessage( %"hash_6475a1fd43d28ac", int( ceil( var_93045b31668a2b5f / 1000 ) ) );
        }
        
        return false;
    }
    
    return true;
}

// Namespace team_assimilation
// Params 2
// Checksum 0x6446a701, Offset: 0xd04
// Size: 0x81
function function_aa6d43748d8cc8f4( player, request )
{
    if ( !isdefined( player.var_13627b2aeafdd5eb ) )
    {
        player.var_13627b2aeafdd5eb = [];
    }
    
    initiallydisabled = isplayersassimdisabled( player );
    player.var_13627b2aeafdd5eb[ request ] = 1;
    nowdisabled = isplayersassimdisabled( player );
    
    if ( nowdisabled && !initiallydisabled )
    {
        player setclientomnvar( "ui_assimilation_disabled", 1 );
    }
}

// Namespace team_assimilation
// Params 2
// Checksum 0xff19d087, Offset: 0xd8d
// Size: 0x7d
function function_5e1bb01356d21d7( player, request )
{
    if ( !isdefined( player.var_13627b2aeafdd5eb ) )
    {
        player.var_13627b2aeafdd5eb = [];
    }
    
    initiallydisabled = isplayersassimdisabled( player );
    player.var_13627b2aeafdd5eb[ request ] = undefined;
    nowdisabled = isplayersassimdisabled( player );
    
    if ( !nowdisabled && initiallydisabled )
    {
        player setclientomnvar( "ui_assimilation_disabled", 0 );
    }
}

// Namespace team_assimilation
// Params 1
// Checksum 0xa5ccb7cb, Offset: 0xe12
// Size: 0x35, Type: bool
function isplayersassimdisabled( player )
{
    return level.var_d15d8e645776c167 || isdefined( player.var_13627b2aeafdd5eb ) && player.var_13627b2aeafdd5eb.size;
}

// Namespace team_assimilation
// Params 0
// Checksum 0x430e962, Offset: 0xe50
// Size: 0x98
function permanentlydisableassim()
{
    if ( level.var_d15d8e645776c167 )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        function_aa6d43748d8cc8f4( player, "permanent" );
    }
    
    level.var_d15d8e645776c167 = 1;
}

// Namespace team_assimilation
// Params 1
// Checksum 0x35ff1b7f, Offset: 0xef0
// Size: 0x3b
function clearassimilation( targetplayer )
{
    targetplayer.var_a7d52e1692c58713 = undefined;
    targetplayer.var_305ec55cacc30285 = undefined;
    targetplayer.var_214a1ea77b961bd3 = undefined;
    targetplayer setclientomnvar( "ui_assimilation_clientnum", -1 );
}

// Namespace team_assimilation
// Params 2
// Checksum 0x5681ada4, Offset: 0xf33
// Size: 0x144, Type: bool
function function_a4692dd3ac8068d0( player, var_534dd45248c58e32 )
{
    if ( isplayersassimdisabled( player ) )
    {
        if ( utility::callsharedfunc( #"interrogate", #"hash_10454370acde68af", player ) )
        {
            player hud_message::showerrormessage( %"mp_ping_ingame/blocked_by_interrogate" );
        }
        else if ( isdefined( level.var_e668ce984a5cb273 ) )
        {
            [[ level.var_e668ce984a5cb273 ]]( player );
        }
        
        return false;
    }
    else if ( player vehicle::is_in_vehicle( 1 ) )
    {
        player hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_player_in_vehicle" );
        return false;
    }
    else if ( var_534dd45248c58e32 && player.var_58d953483aea5402 && level.gametypebundle.var_41dc059ad91e4591 > 0 && !utility::time_has_passed( player.var_58d953483aea5402, level.gametypebundle.var_41dc059ad91e4591 ) )
    {
        var_93045b31668a2b5f = player.var_58d953483aea5402 + level.gametypebundle.var_41dc059ad91e4591 * 1000 - gettime();
        player hud_message::showerrormessage( %"hash_6475a1fd43d28ac", int( ceil( var_93045b31668a2b5f / 1000 ) ) );
        return false;
    }
    
    return true;
}

// Namespace team_assimilation
// Params 1
// Checksum 0xfa129c3f, Offset: 0x1080
// Size: 0x5d
function assimilationtimeout( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"assimilation_resolved" );
    timeout = function_bfb6049bf456d1d0();
    wait timeout;
    clearassimilation( player );
    player notify( #"assimilation_resolved" );
}

// Namespace team_assimilation
// Params 2, eflags: 0x4
// Checksum 0x4383eefb, Offset: 0x10e5
// Size: 0x10c
function private assimilationrefresh( var_cbca90bdc6dd5e31, var_59b5ae61b767c98e )
{
    level endon( #"game_ended" );
    
    while ( var_cbca90bdc6dd5e31.size > 0 )
    {
        utility::waittill_any_ents_array( var_cbca90bdc6dd5e31, "assimilation_resolved", "disconnect" );
        var_cbca90bdc6dd5e31 = function_5713d46873b29625( var_cbca90bdc6dd5e31 );
        var_b75afc558fc88973 = [];
        
        foreach ( player in var_cbca90bdc6dd5e31 )
        {
            if ( player.var_a7d52e1692c58713 && !canassimilate( player, var_59b5ae61b767c98e, player, 1 ) )
            {
                clearassimilation( player );
                player notify( #"assimilation_resolved" );
                continue;
            }
            
            if ( player.var_a7d52e1692c58713 )
            {
                var_b75afc558fc88973[ var_b75afc558fc88973.size ] = player;
            }
        }
        
        var_cbca90bdc6dd5e31 = var_b75afc558fc88973;
    }
}

// Namespace team_assimilation
// Params 2
// Checksum 0x45f69e27, Offset: 0x11f9
// Size: 0x5c
function function_4dbb500242890c26( player, blockedteam )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    period = function_a90a44a5d92756f9();
    player.damageblockedteam = blockedteam;
    wait period;
    player.damageblockedteam = undefined;
}

// Namespace team_assimilation
// Params 1
// Checksum 0xd6b9dab4, Offset: 0x125d
// Size: 0x2d8
function requestleaveteam( player )
{
    if ( !getdvarint( @"assimilation_leave_squad", 0 ) )
    {
        return 0;
    }
    
    if ( !function_a4692dd3ac8068d0( player ) )
    {
        return 0;
    }
    
    usingsquads = isdefined( level.squaddata );
    
    if ( !usingsquads )
    {
        return 0;
    }
    
    if ( level.squaddata[ player.team ][ player.sessionsquadid ].players.size <= 1 )
    {
        player hud_message::showerrormessage( "MP_PING_INGAME/ASSIM_FAILED_SOLO" );
        return 0;
    }
    
    oldteam = player.team;
    oldsquadindex = player.sessionsquadid;
    player callback::callback( "player_request_leave_team" );
    squads::leavesquad( oldteam, oldsquadindex );
    squads::requestnewsquad( player.team, undefined, 0 );
    leavingteammembers = [];
    oldteammembers = [];
    
    if ( isdefined( level.squaddata[ oldteam ][ oldsquadindex ] ) )
    {
        oldteammembers = level.squaddata[ oldteam ][ oldsquadindex ].players;
    }
    
    calloutmarkerping::function_ea6c1cfc8cd997d0( player, oldteammembers );
    player calloutmarkerping::function_5a33bcee47519dd6();
    
    foreach ( teammember in oldteammembers )
    {
        if ( isdefined( teammember ) && player != teammember )
        {
            calloutmarkerping::function_ea6c1cfc8cd997d0( teammember, [ player ] );
            leavingteammembers[ leavingteammembers.size ] = teammember;
        }
    }
    
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"assim_request_response_leaving_team", leavingteammembers );
    
    if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
    {
        [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "player_left_alone", [ player ], undefined, undefined, undefined, level.splashlistoverride );
        players = oldteammembers;
        
        if ( isdefined( players ) )
        {
            players = arrayremove( players, player );
            [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "player_left_team", players, undefined, player getentitynumber(), undefined, level.splashlistoverride );
        }
    }
    
    function_8f8f6a9fcaa018ef( player.team, player.sessionsquadid, player );
    function_b1fd429e75da487f( player.team );
    function_ffce0af7bde78497( player, oldteam, player.team, oldsquadindex, player.sessionsquadid );
}

// Namespace team_assimilation
// Params 1, eflags: 0x4
// Checksum 0x5a0760bb, Offset: 0x153d
// Size: 0xbc
function private function_d9c0fea1eee68563( params )
{
    playername = params[ 0 ];
    
    if ( !( isdefined( playername ) && isdefined( level.players ) ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.name == playername )
        {
            player requestleaveteam( player );
            break;
        }
    }
}

// Namespace team_assimilation
// Params 2
// Checksum 0x7bbf1f85, Offset: 0x1601
// Size: 0x2e6
function requestnearbyteamchange( player, var_534dd45248c58e32 )
{
    if ( !function_a4692dd3ac8068d0( player, var_534dd45248c58e32 ) )
    {
        return 0;
    }
    
    usingsquads = isdefined( level.squaddata );
    
    if ( !var_534dd45248c58e32 && ( !usingsquads && !canteamassimilate( player.team ) || usingsquads && !function_98ab13413d7fc534( player.team, player.sessionsquadid ) ) )
    {
        player hud_message::showerrormessage( %"mp_ping_ingame/assim_failed_team_size" );
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
    {
        if ( var_534dd45248c58e32 )
        {
            [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_used_join_on_target", [ player ], undefined, undefined, undefined, level.splashlistoverride );
        }
        else
        {
            [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_used", [ player ], undefined, undefined, undefined, level.splashlistoverride );
        }
    }
    
    requestradius = function_7ffd3e5a7ff12115();
    playersinradius = player_utility::script_getplayersinradius( player.origin, requestradius );
    var_cbca90bdc6dd5e31 = [];
    var_174c9cc6434e56b4 = function_73344c25bedf76c4();
    
    foreach ( targetplayer in playersinradius )
    {
        if ( targetplayer == player || !isplayer( targetplayer ) || isplayersassimdisabled( targetplayer ) )
        {
            continue;
        }
        
        if ( usingsquads && player.sessionsquadid == targetplayer.sessionsquadid )
        {
            continue;
        }
        else if ( !usingsquads && targetplayer.team == player.team )
        {
            continue;
        }
        
        success = senddirectassimrequest( player, targetplayer, var_534dd45248c58e32, var_174c9cc6434e56b4 );
        
        if ( success )
        {
            var_cbca90bdc6dd5e31[ var_cbca90bdc6dd5e31.size ] = targetplayer;
        }
    }
    
    if ( !var_534dd45248c58e32 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"assim_request_you_join_me", [ player ] );
    }
    
    if ( var_cbca90bdc6dd5e31.size > 0 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"assim_request_nearby", var_cbca90bdc6dd5e31 );
        callback::callback( "requests_team_assim", { #validplayers:var_cbca90bdc6dd5e31, #player:player } );
        level thread assimilationrefresh( var_cbca90bdc6dd5e31, player );
    }
}

// Namespace team_assimilation
// Params 2, eflags: 0x4
// Checksum 0x43d15904, Offset: 0x18ef
// Size: 0x2d
function private function_c31f181b64b61529( player, requestaccepted )
{
    if ( player.var_a7d52e1692c58713 )
    {
        resolveassimrequest( player, requestaccepted );
    }
}

// Namespace team_assimilation
// Params 2
// Checksum 0xa8900625, Offset: 0x1924
// Size: 0x1f0
function resolveassimrequest( player, requestaccepted )
{
    assert( isdefined( player.var_a7d52e1692c58713 ) );
    playerswitching = player.var_305ec55cacc30285 ? player.var_a7d52e1692c58713 : player;
    var_59b5ae61b767c98e = player.var_305ec55cacc30285 ? player : player.var_a7d52e1692c58713;
    
    if ( !canassimilate( playerswitching, var_59b5ae61b767c98e, player, 0 ) )
    {
        player setclientomnvar( "ui_assimilation_clientnum", -1 );
        return;
    }
    
    if ( requestaccepted )
    {
        assimilateplayer( playerswitching, var_59b5ae61b767c98e, 0 );
        
        if ( isbrgamemode() )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"br" ][ #"updatePlayerAndTeamCountUI" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]();
            }
        }
    }
    else if ( player.var_305ec55cacc30285 )
    {
        [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_request_denied_join_on_target", [ player.var_a7d52e1692c58713 ], undefined, undefined, undefined, level.splashlistoverride );
        [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_request_you_denied_join_on_target", [ player ], undefined, undefined, undefined, level.splashlistoverride );
    }
    else
    {
        [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_request_denied", [ player.var_a7d52e1692c58713 ], undefined, player getentitynumber(), undefined, level.splashlistoverride );
        [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_request_you_denied", [ player ], undefined, undefined, undefined, level.splashlistoverride );
    }
    
    clearassimilation( player );
    player notify( #"assimilation_resolved" );
}

// Namespace team_assimilation
// Params 1
// Checksum 0x8b866ca4, Offset: 0x1b1c
// Size: 0x1d1
function function_b1fd429e75da487f( team )
{
    if ( isdefined( level.br_plunder ) )
    {
        var_3b28f88ecddd14b3 = level.sharedfuncs[ #"player" ][ #"hash_24c82acf395ec516" ];
        var_9c55d045940887ee = level.sharedfuncs[ #"player" ][ #"hash_85f21e75cc06a9e9" ];
        var_30d10c7fd53c0f53 = isdefined( var_3b28f88ecddd14b3 ) && isdefined( var_9c55d045940887ee );
    }
    
    teammembers = teams::getteamdata( team, "players" );
    
    foreach ( teammember in teammembers )
    {
        if ( isdefined( teammember ) )
        {
            teammember notify( #"refresh_revives" );
            
            if ( isdefined( level.br_plunder ) && var_30d10c7fd53c0f53 )
            {
                plundercount = teammember currency::get_currency_amount( "cash" );
                data = [[ var_3b28f88ecddd14b3 ]]();
                data.setplunderifunchanged = 1;
                teammember [[ var_9c55d045940887ee ]]( plundercount, data );
            }
            else
            {
                essencecount = gamescore::getplayerscore( teammember );
                teammember cash::function_eb5a5549b0c6ecde( essencecount, 1 );
            }
        }
        
        teammember thread armor::setarmoromnvars();
    }
    
    if ( teammembers.size > 0 && isbrgamemode() )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"hash_4313d24db38c7be2" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            teammembers[ 0 ] [[ var_32dbca3143d9c4a5 ]]( "assimilation" );
        }
    }
}

// Namespace team_assimilation
// Params 3
// Checksum 0x15da8296, Offset: 0x1cf5
// Size: 0x622
function assimilateplayer( playerswitching, var_59b5ae61b767c98e, torespawn )
{
    oldteam = playerswitching.team;
    newteam = var_59b5ae61b767c98e.team;
    oldsquadindex = playerswitching.sessionsquadid;
    newsquadindex = var_59b5ae61b767c98e.sessionsquadid;
    var_581cd0d7fa68b640 = !torespawn;
    usingsquad = isdefined( level.squaddata );
    leavingteammembers = [];
    oldteammembers = usingsquad ? level.squaddata[ oldteam ][ oldsquadindex ].players : teams::getteamdata( oldteam, "players" );
    
    foreach ( teammember in oldteammembers )
    {
        if ( isdefined( teammember ) && playerswitching != teammember )
        {
            leavingteammembers[ leavingteammembers.size ] = teammember;
        }
    }
    
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"assim_request_response_leaving_team", leavingteammembers );
    
    if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
    {
        if ( var_581cd0d7fa68b640 )
        {
            [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "player_team_switched", [ playerswitching ], undefined, undefined, undefined, level.splashlistoverride );
        }
        
        players = usingsquad ? level.squaddata[ newteam ][ newsquadindex ].players : teams::getteamdata( newteam, "players" );
        [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "player_joined_team", players, undefined, playerswitching getentitynumber(), undefined, level.splashlistoverride );
        players = usingsquad ? level.squaddata[ oldteam ][ oldsquadindex ].players : teams::getteamdata( oldteam, "players" );
        
        if ( isdefined( players ) )
        {
            players = arrayremove( players, playerswitching );
            [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "player_left_team", players, undefined, playerswitching getentitynumber(), undefined, level.splashlistoverride );
        }
    }
    
    if ( newteam != oldteam )
    {
        playerswitching thread menus::addtoteam( newteam, undefined, var_581cd0d7fa68b640, 1 );
    }
    
    if ( squad_utility::issquadmode() )
    {
        squadmates = playerswitching squad_utility::getsquadmembers();
        calloutmarkerping::function_ea6c1cfc8cd997d0( playerswitching, squadmates );
        function_8f8f6a9fcaa018ef( newteam, newsquadindex, playerswitching );
        playerswitching thread squads::changesquad( newteam, oldteam, newsquadindex );
    }
    else
    {
        function_afbf966a44586efa( newteam, playerswitching );
        playerswitching thread squads::setsquad( newteam, newsquadindex );
    }
    
    playerswitching.var_58d953483aea5402 = gettime();
    playerswitching thread function_4dbb500242890c26( playerswitching, oldteam );
    playerswitching calloutmarkerping::function_5a33bcee47519dd6();
    function_b1fd429e75da487f( newteam );
    function_b1fd429e75da487f( oldteam );
    
    if ( isdefined( level.br_plunder ) )
    {
        var_3b28f88ecddd14b3 = level.sharedfuncs[ #"player" ][ #"hash_24c82acf395ec516" ];
        var_9c55d045940887ee = level.sharedfuncs[ #"player" ][ #"hash_85f21e75cc06a9e9" ];
        var_30d10c7fd53c0f53 = isdefined( var_3b28f88ecddd14b3 ) && isdefined( var_9c55d045940887ee );
    }
    
    newteammembers = usingsquad ? level.squaddata[ newteam ][ newsquadindex ].players : teams::getteamdata( newteam, "players" );
    
    foreach ( teammember in newteammembers )
    {
        if ( isdefined( teammember ) )
        {
            teammember notify( #"refresh_revives" );
            
            if ( isdefined( level.br_plunder ) && var_30d10c7fd53c0f53 )
            {
                plundercount = teammember currency::get_currency_amount( "cash" );
                data = [[ var_3b28f88ecddd14b3 ]]();
                data.setplunderifunchanged = 1;
                teammember [[ var_9c55d045940887ee ]]( plundercount, data );
            }
            else
            {
                essencecount = gamescore::getplayerscore( teammember );
                teammember cash::function_eb5a5549b0c6ecde( essencecount, 1 );
            }
        }
        
        teammember thread armor::setarmoromnvars();
        health_chunks::function_4a767a18ab106419( teammember );
    }
    
    if ( usingsquad && !isdefined( level.squaddata[ oldteam ][ oldsquadindex ] ) )
    {
        function_ffce0af7bde78497( playerswitching, oldteam, newteam, oldsquadindex, newsquadindex );
        return;
    }
    
    oldteammembers = usingsquad ? level.squaddata[ oldteam ][ oldsquadindex ].players : teams::getteamdata( oldteam, "players" );
    
    foreach ( teammember in oldteammembers )
    {
        if ( isdefined( teammember ) )
        {
            teammember notify( #"refresh_revives" );
            
            if ( isdefined( level.br_plunder ) && var_30d10c7fd53c0f53 )
            {
                plundercount = teammember currency::get_currency_amount( "cash" );
                data = [[ var_3b28f88ecddd14b3 ]]();
                data.setplunderifunchanged = 1;
                teammember [[ var_9c55d045940887ee ]]( plundercount, data );
                continue;
            }
            
            essencecount = gamescore::getplayerscore( teammember );
            teammember cash::function_eb5a5549b0c6ecde( essencecount, 1 );
        }
    }
    
    function_ffce0af7bde78497( playerswitching, oldteam, newteam, oldsquadindex, newsquadindex );
    playerswitching function_9e0860c4774dcdc2( oldteam, newteam );
    playerswitching function_dfb52ef523a1ac12( var_59b5ae61b767c98e );
}

// Namespace team_assimilation
// Params 4
// Checksum 0x31a373c0, Offset: 0x231f
// Size: 0x25c, Type: bool
function senddirectassimrequest( var_11744cf6c5eeb540, targetplayer, var_534dd45248c58e32, var_174c9cc6434e56b4 )
{
    if ( targetplayer == var_11744cf6c5eeb540 || targetplayer.team == var_11744cf6c5eeb540.team && !( squad_utility::issquadmode() && !squad_utility::function_6a77a8d0f8eb25b5( var_11744cf6c5eeb540, targetplayer ) ) || !isplayer( targetplayer ) || isplayersassimdisabled( targetplayer ) )
    {
        return false;
    }
    
    playerswitching = var_534dd45248c58e32 ? var_11744cf6c5eeb540 : targetplayer;
    var_59b5ae61b767c98e = var_534dd45248c58e32 ? targetplayer : var_11744cf6c5eeb540;
    
    if ( !function_aab2d30d0c40fc72( var_59b5ae61b767c98e, playerswitching, var_59b5ae61b767c98e, 1 ) )
    {
        return false;
    }
    
    if ( var_174c9cc6434e56b4 )
    {
        toenemy = vectornormalize( targetplayer.origin - var_11744cf6c5eeb540.origin );
        dotproduct = vectordot( anglestoforward( var_11744cf6c5eeb540.angles ), toenemy );
        
        if ( dotproduct < 0 )
        {
            return false;
        }
    }
    
    targetplayer setclientomnvar( "ui_assimilation_clientnum", var_11744cf6c5eeb540 getentitynumber() );
    targetplayer setclientomnvar( "ui_assimilation_join_on_target", var_534dd45248c58e32 );
    targetplayer.var_a7d52e1692c58713 = var_11744cf6c5eeb540;
    targetplayer thread assimilationtimeout( targetplayer );
    
    if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
    {
        splashcooldown = function_cdcf2d8307759747();
        
        if ( !isdefined( targetplayer.var_214a1ea77b961bd3 ) || targetplayer.var_214a1ea77b961bd3 + splashcooldown > gettime() || targetplayer.var_305ec55cacc30285 != var_534dd45248c58e32 )
        {
            if ( var_534dd45248c58e32 )
            {
                [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_requested_join_on_target", [ targetplayer ], undefined, var_11744cf6c5eeb540 getentitynumber(), undefined, level.splashlistoverride );
            }
            else
            {
                [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_team_assimilation_requested", [ targetplayer ], undefined, var_11744cf6c5eeb540 getentitynumber(), undefined, level.splashlistoverride );
            }
            
            targetplayer.var_214a1ea77b961bd3 = gettime();
        }
    }
    
    targetplayer.var_305ec55cacc30285 = var_534dd45248c58e32;
    
    if ( shouldautoacceptteamswitch() )
    {
        utility::delaythread( 5, &function_c31f181b64b61529, targetplayer, 1 );
    }
    
    return true;
}

// Namespace team_assimilation
// Params 2
// Checksum 0x3ef4f2fd, Offset: 0x2584
// Size: 0x172
function function_9e0860c4774dcdc2( oldteam, newteam )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "player_xuid";
    eventparams[ eventparams.size ] = player getxuid();
    eventparams[ eventparams.size ] = "player_entity_num";
    eventparams[ eventparams.size ] = player getentitynumber();
    eventparams[ eventparams.size ] = "old_team";
    eventparams[ eventparams.size ] = oldteam;
    eventparams[ eventparams.size ] = "old_team_alive_teammates";
    
    if ( isdefined( level.teamdata[ oldteam ][ "alivePlayers" ] ) )
    {
        eventparams[ eventparams.size ] = level.teamdata[ oldteam ][ "alivePlayers" ].size;
    }
    else
    {
        eventparams[ eventparams.size ] = -1;
    }
    
    eventparams[ eventparams.size ] = "new_team";
    eventparams[ eventparams.size ] = newteam;
    eventparams[ eventparams.size ] = "new_team_alive_teammates";
    
    if ( isdefined( level.teamdata[ newteam ][ "alivePlayers" ] ) )
    {
        eventparams[ eventparams.size ] = level.teamdata[ newteam ][ "alivePlayers" ].size;
    }
    else
    {
        eventparams[ eventparams.size ] = -1;
    }
    
    eventparams[ eventparams.size ] = "last_assimilation_request_time";
    
    if ( isdefined( player.var_214a1ea77b961bd3 ) )
    {
        eventparams[ eventparams.size ] = player.var_214a1ea77b961bd3;
    }
    else
    {
        eventparams[ eventparams.size ] = -1;
    }
    
    eventparams[ eventparams.size ] = "game_time";
    eventparams[ eventparams.size ] = int( gettime() / 1000 );
    player dlog_recordplayerevent( "dlog_event_team_assimilation", eventparams );
}

// Namespace team_assimilation
// Params 3
// Checksum 0x702ef485, Offset: 0x26fe
// Size: 0x83
function function_8f8f6a9fcaa018ef( team, squadindex, player )
{
    if ( !isdefined( level.squaddata ) )
    {
        return;
    }
    
    if ( !isdefined( level.squaddata[ team ][ squadindex ].properties[ "lastAssimedPlayer" ] ) )
    {
        level.squaddata[ team ][ squadindex ].properties[ "lastAssimedPlayer" ] = player;
        return;
    }
    
    squads::function_9f63a83550fcfd48( team, squadindex, "lastAssimedPlayer", player );
}

// Namespace team_assimilation
// Params 2
// Checksum 0x2e5f21f4, Offset: 0x2789
// Size: 0x5e
function function_afbf966a44586efa( team, player )
{
    if ( !isdefined( level.teamdata ) )
    {
        return;
    }
    
    if ( !isdefined( level.teamdata[ team ][ "lastAssimedPlayer" ] ) )
    {
        level.teamdata[ team ][ "lastAssimedPlayer" ] = undefined;
        return;
    }
    
    teams::setteamdata( team, "lastAssimedPlayer", player );
}

// Namespace team_assimilation
// Params 1
// Checksum 0x93b66e02, Offset: 0x27ef
// Size: 0x15
function function_3efb30390246d5d1( player )
{
    thread function_a5eef13bf3ca1a05( player );
}

// Namespace team_assimilation
// Params 1, eflags: 0x4
// Checksum 0x10127868, Offset: 0x280c
// Size: 0x44
function private function_a5eef13bf3ca1a05( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    waitframe();
    squadmates = player squad_utility::getsquadmembers();
    calloutmarkerping::function_c9bd983008573e40( player, squadmates );
}

/#

    // Namespace team_assimilation
    // Params 0
    // Checksum 0xee6baa3e, Offset: 0x2858
    // Size: 0x74, Type: dev
    function function_9653adf30d8b9fb4()
    {
        thread function_495e65bd42c1b712();
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x3a>", @"hash_f7804c5dfa9407ca" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x4a>", @"hash_b954d42a85390b5b" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x63>", @"hash_5eedf824f533d2e6" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x7e>", @"hash_8b77db100df49d5e" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace team_assimilation
    // Params 0, eflags: 0x4
    // Checksum 0xec2e408d, Offset: 0x28d4
    // Size: 0x4a4, Type: dev
    function private function_495e65bd42c1b712()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_f7804c5dfa9407ca", 0 ) )
            {
                setdvar( @"hash_f7804c5dfa9407ca", 0 );
                newsquadindex = 0;
                
                foreach ( player in level.players )
                {
                    player thread squads::changesquad( player.team, player.team, newsquadindex );
                    newsquadindex++;
                }
            }
            
            if ( getdvarint( @"hash_b954d42a85390b5b", 0 ) )
            {
                setdvar( @"hash_b954d42a85390b5b", 0 );
                playersquad = 0;
                humanplayer = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isplayer( player ) )
                    {
                        playersquad = player.sessionsquadid;
                        humanplayer = player;
                        break;
                    }
                }
                
                foreach ( bot in level.players )
                {
                    if ( bot != humanplayer && bot.sessionsquadid != playersquad )
                    {
                        if ( !function_aab2d30d0c40fc72( humanplayer, bot, humanplayer, 1 ) )
                        {
                            continue;
                        }
                        
                        assimilateplayer( bot, humanplayer, 0 );
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"hash_5eedf824f533d2e6", 0 ) )
            {
                setdvar( @"hash_5eedf824f533d2e6", 0 );
                playersquad = 0;
                humanplayer = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isplayer( player ) )
                    {
                        playersquad = player.sessionsquadid;
                        humanplayer = player;
                        break;
                    }
                }
                
                foreach ( bot in level.players )
                {
                    if ( bot != humanplayer && bot.sessionsquadid != playersquad )
                    {
                        function_77b42b9a95a5f183( bot, humanplayer );
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"hash_8b77db100df49d5e", 0 ) )
            {
                setdvar( @"hash_8b77db100df49d5e", 0 );
                playersquad = 0;
                humanplayer = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isplayer( player ) )
                    {
                        playersquad = player.sessionsquadid;
                        humanplayer = player;
                        break;
                    }
                }
                
                foreach ( bot in level.players )
                {
                    if ( bot != humanplayer && bot.sessionsquadid == playersquad )
                    {
                        bot requestleaveteam( bot );
                        break;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace team_assimilation
    // Params 2, eflags: 0x4
    // Checksum 0x10a94a6c, Offset: 0x2d80
    // Size: 0x176, Type: dev
    function private function_77b42b9a95a5f183( bot, player )
    {
        if ( !function_aab2d30d0c40fc72( bot, player, player, 1 ) )
        {
            return;
        }
        
        player setclientomnvar( "<dev string:x91>", bot getentitynumber() );
        player setclientomnvar( "<dev string:xab>", 0 );
        player.var_a7d52e1692c58713 = bot;
        player thread assimilationtimeout( player );
        
        if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
        {
            splashcooldown = function_cdcf2d8307759747();
            
            if ( !isdefined( player.var_214a1ea77b961bd3 ) || player.var_214a1ea77b961bd3 + splashcooldown > gettime() || player.var_305ec55cacc30285 != 0 )
            {
                [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "<dev string:xca>", [ player ], undefined, bot getentitynumber() );
                player.var_214a1ea77b961bd3 = gettime();
            }
        }
        
        player.var_305ec55cacc30285 = 0;
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"assim_request_you_join_me", [ bot ] );
        var_cbca90bdc6dd5e31 = [ player ];
        
        if ( var_cbca90bdc6dd5e31.size > 0 )
        {
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"assim_request_nearby", var_cbca90bdc6dd5e31 );
        }
    }

#/
