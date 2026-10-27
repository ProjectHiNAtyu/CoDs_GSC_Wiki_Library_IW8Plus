// scripts\mp\gametypes\skirmish_util.gsc  (hash_56b9d85267fc33cd.gscc) (size: 8398 Bytes / 0x20ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x42a7f7a7 (1118304167)
// size ...... 8398 (0x20ce)
// includes .. 13  (offset: 0x1eda)
// strings ... 22  (offset: 0x1f42)
// dev strs .. 1   (offset: 0x20ba)
// exports ... 23  (offset: 0x1496)
// cseg ...... 0x213 + 0x1283 (0x1496)
// imports ... 57  (offset: 0x182e)
// animtree1 . 0   (offset: 0x20ce)
// animtree2 . 0   (offset: 0x20ce)
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\grappling_hook;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\skirmish_bounty;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace skirmish_util;

// Namespace skirmish_util
// Params 3
// Checksum 0x31ae8928, Offset: 0x231
// Size: 0x74
function function_27e85aa699653fa1( friendlywaypoint, enemywaypoint, objid )
{
    var_a5e839d615113421 = isdefined( enemywaypoint );
    
    if ( function_afc407a06438534e( self ) )
    {
        friendlywaypoint += "_hot";
        
        if ( var_a5e839d615113421 )
        {
            enemywaypoint += "_hot";
        }
    }
    
    gameobjects::setobjectivestatusicons( friendlywaypoint, enemywaypoint, objid );
    objidpoolmanager::update_objective_size( self.objidnum, level.var_1552790994371de7 );
}

// Namespace skirmish_util
// Params 1
// Checksum 0x4936c21f, Offset: 0x2ad
// Size: 0x41
function function_afc407a06438534e( gameobject )
{
    return level.var_85b177faa9935b2a.running[ gameobject.activitytype ][ gameobject.activityname ].var_51f5a92414c2f4f8;
}

// Namespace skirmish_util
// Params 3
// Checksum 0x7120114d, Offset: 0x2f7
// Size: 0x163
function function_9bc92b9d0f473f97( teamscore, scoreeventname, scoreeventplayer )
{
    if ( scoreeventname )
    {
        if ( scoreeventplayer.team && level.var_45f6a6e0fdf53f22 )
        {
            foreach ( player in teams::getteamdata( scoreeventplayer.team, "players" ) )
            {
                player thread points::doscoreevent( getxhash( scoreeventname ) );
            }
        }
        else if ( isplayer( scoreeventplayer ) )
        {
            scoreeventplayer points::doscoreevent( getxhash( scoreeventname ) );
        }
        
        if ( scoreeventplayer.team && teamscore )
        {
            function_2c1f06acea1703d6( scoreeventplayer.team, teamscore, scoreeventname );
        }
    }
    
    if ( !scoreeventplayer.team )
    {
        return;
    }
    
    level gamescore::giveteamscoreforobjective( scoreeventplayer.team, teamscore );
    function_832b8e2dbca95a6b();
    
    if ( level.var_bd070f6dcd0b310e )
    {
        skirmish_bounty::function_98bac91f9c3ec633( scoreeventplayer.team, scoreeventplayer.sessionsquadid );
    }
}

// Namespace skirmish_util
// Params 1
// Checksum 0xab0536e6, Offset: 0x462
// Size: 0x106
function function_55c12155a11106a0( player )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "objectives_completed" ] ) )
        {
            player.leaderboarddata[ "objectives_completed" ] = player.leaderboarddata[ "objectives_completed" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "objectives_completed" ] ) )
        {
            [[ level.leaderboardfunc[ "objectives_completed" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "objectives_completed" ] ) )
        {
            player.pers[ "objectives_completed" ] = player.pers[ "objectives_completed" ] + 1;
        }
    }
    
    player stats::setextrascore0( player.pers[ "objectives_completed" ] );
}

// Namespace skirmish_util
// Params 1
// Checksum 0xc2e67162, Offset: 0x570
// Size: 0x106
function function_512ad9c4c66229de( player )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "top_squad_kills" ] ) )
        {
            player.leaderboarddata[ "top_squad_kills" ] = player.leaderboarddata[ "top_squad_kills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "top_squad_kills" ] ) )
        {
            [[ level.leaderboardfunc[ "top_squad_kills" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "top_squad_kills" ] ) )
        {
            player.pers[ "top_squad_kills" ] = player.pers[ "top_squad_kills" ] + 1;
        }
    }
    
    player stats::setextrascore1( player.pers[ "top_squad_kills" ] );
}

// Namespace skirmish_util
// Params 1
// Checksum 0x978e82c5, Offset: 0x67e
// Size: 0x106
function function_d3edf86605109102( player )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "supplies_retrieved" ] ) )
        {
            player.leaderboarddata[ "supplies_retrieved" ] = player.leaderboarddata[ "supplies_retrieved" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "supplies_retrieved" ] ) )
        {
            [[ level.leaderboardfunc[ "supplies_retrieved" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "supplies_retrieved" ] ) )
        {
            player.pers[ "supplies_retrieved" ] = player.pers[ "supplies_retrieved" ] + 1;
        }
    }
    
    player stats::setextrascore2( player.pers[ "supplies_retrieved" ] );
}

// Namespace skirmish_util
// Params 0
// Checksum 0x127ebd99, Offset: 0x78c
// Size: 0x10d
function function_832b8e2dbca95a6b()
{
    gamescore::updateteamscoreplacements();
    
    foreach ( teamname in level.teamnamelist )
    {
        setteamplacement( teamname, gamescore::getteamscoreplacements()[ teamname ] );
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_skrTeamPlacementUpdateTimeStamp", gettime() % 2097151 );
    }
}

// Namespace skirmish_util
// Params 3
// Checksum 0x66dfed6e, Offset: 0x8a1
// Size: 0xd6
function function_3059ce0968f29709( objectivestring, owner, winningteam )
{
    foreach ( player in level.players )
    {
        if ( player.team == winningteam )
        {
            player thread hud_message::showsplash( "splash_skirmish_" + objectivestring + "complete_callout", undefined, owner );
            continue;
        }
        
        player thread hud_message::showsplash( "splash_skirmish_" + objectivestring + "enemy_complete_callout", undefined, owner );
    }
}

// Namespace skirmish_util
// Params 2
// Checksum 0x29c3648f, Offset: 0x97f
// Size: 0x75
function getcustomstartandtargetposition( var_cbaab2ed6edf8fc7, forwardvector )
{
    missileoffset = self.origin + ( 0, 0, 10000 );
    startpos = missileoffset - forwardvector * var_cbaab2ed6edf8fc7;
    targetpos = self.origin + ( 0, 0, int( 5000 ) );
    return [ startpos, targetpos ];
}

// Namespace skirmish_util
// Params 1
// Checksum 0x7545506d, Offset: 0x9fd
// Size: 0x86
function function_113800972c457040( dialogref )
{
    foreach ( team in level.teamnamelist )
    {
        dialog::statusdialog( dialogref, team );
    }
}

// Namespace skirmish_util
// Params 4
// Checksum 0x22457068, Offset: 0xa8b
// Size: 0xe2
function function_f0219df3de59b8fc( dialogalias, location, radius, team = undefined )
{
    if ( !location )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( team ) && player.team != team )
        {
            continue;
        }
        
        if ( distance2d( player.origin, location ) <= radius )
        {
            player dialog::leaderdialogonplayer( dialogalias );
        }
    }
}

// Namespace skirmish_util
// Params 0
// Checksum 0x697bd984, Offset: 0xb75
// Size: 0x1b9
function function_812f0dfc302a4016()
{
    level endon( #"game_ended" );
    level.var_20a88e26990ef70a = [ #"bomb_planting", #"bomb_planted", #"enemy_bomb_planted" ];
    var_3c432707732d0c3e = [ #"hash_9cc676667dc7937c", #"losing_", #"contested_", #"hash_937cb130d9449c99", #"hash_eecd3c83eb700792", #"hash_e1cfc37edd9ac809" ];
    objectives = strtok( level.var_85b177faa9935b2a.mapsettings.var_b245829613dc71b4, "," );
    
    foreach ( prefix in var_3c432707732d0c3e )
    {
        foreach ( letter in objectives )
        {
            level.var_20a88e26990ef70a[ level.var_20a88e26990ef70a.size ] = hashcat( prefix, tolower( letter ) );
        }
    }
}

// Namespace skirmish_util
// Params 5
// Checksum 0xc08ebe9d, Offset: 0xd36
// Size: 0xca
function function_7691fe63b803b07e( teamplayers, team, scoreeventmsg, mainplayer, var_51f847aef825ec26 )
{
    foreach ( player in teamplayers )
    {
        if ( player.team == team && player != mainplayer )
        {
            player points::doscoreevent( scoreeventmsg );
        }
        
        if ( var_51f847aef825ec26 )
        {
            player function_362ad591e19a35be();
        }
    }
}

// Namespace skirmish_util
// Params 0
// Checksum 0x8109cf84, Offset: 0xe08
// Size: 0x145
function function_362ad591e19a35be()
{
    self endon( #"death_or_disconnect" );
    
    if ( !level.var_85b177faa9935b2a.var_d49149722a9853be )
    {
        return;
    }
    
    grenade = makeweapon( "sat_grappling_hook_mp_skr" );
    
    if ( self hasweapon( grenade ) )
    {
        grappling_hook::function_51f847aef825ec26( self );
        return;
    }
    
    item = self dropitem( grenade );
    
    if ( !item )
    {
        return;
    }
    
    item showonlytoplayer( self );
    var_f97d42f076ad0ffe = 4000;
    var_21060ccead987aae = 1000;
    launchvelocity = ( 0, 0, 0 );
    launchvelocity += anglestoforward( self.angles ) * var_f97d42f076ad0ffe;
    launchvelocity += anglestoup( self.angles ) * var_21060ccead987aae;
    item physicslaunchserveritem( self.origin + ( 0, 0, 50 ), launchvelocity );
    item_id = calloutmarkerping::createcallout( 7, undefined, item getentitynumber(), undefined, undefined, undefined );
    item thread calloutmarkerping::function_3c501da3379eca0a( self, item_id, [ "remove_grappling_hook" ], undefined, 10 );
    item thread function_29f1622fba0109b2();
    item thread function_229f1e57d74ed59d( self );
    outline::outlineenableforplayer( item, self, "shimmer_default", "level_script" );
}

// Namespace skirmish_util
// Params 0, eflags: 0x4
// Checksum 0xe86eba6a, Offset: 0xf55
// Size: 0x41
function private function_29f1622fba0109b2()
{
    self endon( #"remove_grappling_hook" );
    self waittill( #"trigger", player, ent );
    grappling_hook::function_51f847aef825ec26( player );
    thread function_a0a3886b0ccbb6bf();
}

// Namespace skirmish_util
// Params 0, eflags: 0x4
// Checksum 0x40350278, Offset: 0xf9e
// Size: 0xc
function private function_34c4f255b1c044eb()
{
    wait 10;
    thread function_a0a3886b0ccbb6bf();
}

// Namespace skirmish_util
// Params 1, eflags: 0x4
// Checksum 0x2a3cc86, Offset: 0xfb2
// Size: 0x3e
function private function_229f1e57d74ed59d( player )
{
    self endon( #"remove_grappling_hook" );
    childthread function_34c4f255b1c044eb();
    
    while ( true )
    {
        if ( !player player::isreallyalive() )
        {
            break;
        }
        
        waitframe();
    }
    
    thread function_a0a3886b0ccbb6bf();
}

// Namespace skirmish_util
// Params 0, eflags: 0x4
// Checksum 0x32d683b, Offset: 0xff8
// Size: 0x1a
function private function_a0a3886b0ccbb6bf()
{
    self notify( #"remove_grappling_hook" );
    
    if ( !self )
    {
        return;
    }
    
    self delete();
}

// Namespace skirmish_util
// Params 0
// Checksum 0x657e828e, Offset: 0x101a
// Size: 0xe2
function function_8809d0eb94bca9ac()
{
    if ( !level.var_207d4b16a82a6682 )
    {
        level.var_207d4b16a82a6682 = [];
        
        foreach ( teamname in level.teamnamelist )
        {
            level.var_207d4b16a82a6682[ teamname ] = spawnstruct();
            level.var_207d4b16a82a6682[ teamname ].objectivepoints = 0;
            level.var_207d4b16a82a6682[ teamname ].eliminationpoints = 0;
            level.var_207d4b16a82a6682[ teamname ].var_498019d2749991af = 0;
        }
    }
}

// Namespace skirmish_util
// Params 3
// Checksum 0x2b0fba75, Offset: 0x1104
// Size: 0x108
function function_2c1f06acea1703d6( team, points, scoreeventname )
{
    if ( !team || !points || !scoreeventname )
    {
        return;
    }
    
    if ( !level.var_207d4b16a82a6682[ team ] )
    {
        return;
    }
    
    scoreeventstr = string( scoreeventname );
    
    if ( issubstr( scoreeventstr, "kill" ) )
    {
        level.var_207d4b16a82a6682[ team ].eliminationpoints += points;
        return;
    }
    
    if ( issubstr( scoreeventstr, "hvs" ) )
    {
        level.var_207d4b16a82a6682[ team ].var_498019d2749991af += points;
        return;
    }
    
    level.var_207d4b16a82a6682[ team ].objectivepoints += points;
}

// Namespace skirmish_util
// Params 0
// Checksum 0x8c313d14, Offset: 0x1214
// Size: 0x104
function function_e415d518bd1916f()
{
    foreach ( teamname in level.teamnamelist )
    {
        if ( level.var_207d4b16a82a6682[ teamname ] )
        {
            dlog_recordevent( "dlog_event_mp_skr_team_match_points", [ "skr_team", teamname, "skr_points_objective", level.var_207d4b16a82a6682[ teamname ].objectivepoints, "skr_points_elimination", level.var_207d4b16a82a6682[ teamname ].eliminationpoints, "skr_points_hvs_objective", level.var_207d4b16a82a6682[ teamname ].var_498019d2749991af ] );
        }
    }
}

// Namespace skirmish_util
// Params 1
// Checksum 0xc2631ee5, Offset: 0x1320
// Size: 0x175, Type: bool
function function_3b79123608a6ac3e( teammate )
{
    if ( !teammate || !teammate.origin || !player::isreallyalive( teammate ) || !level.var_85b177faa9935b2a.running )
    {
        return false;
    }
    
    foreach ( activitytype in level.var_85b177faa9935b2a.running )
    {
        foreach ( objective in activitytype )
        {
            if ( !objective.activitytrigger.origin )
            {
                continue;
            }
            
            if ( distance2d( teammate.origin, objective.activitytrigger.origin ) <= 787 )
            {
                return true;
            }
        }
    }
    
    return false;
}

