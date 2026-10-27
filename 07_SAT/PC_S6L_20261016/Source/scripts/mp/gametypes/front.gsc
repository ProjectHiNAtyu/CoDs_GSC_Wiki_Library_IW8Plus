// scripts\mp\gametypes\front.gsc  (hash_17428198488c338f.gscc) (size: 13625 Bytes / 0x3539 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c838e32 (1015254578)
// size ...... 13625 (0x3539)
// includes .. 13  (offset: 0x3151)
// strings ... 50  (offset: 0x31b9)
// dev strs .. 2   (offset: 0x3521)
// exports ... 34  (offset: 0x1fad)
// cseg ...... 0x3e6 + 0x1bc7 (0x1fad)
// imports ... 99  (offset: 0x24fd)
// animtree1 . 0   (offset: 0x3539)
// animtree2 . 0   (offset: 0x3539)
#using scripts\mp\challenges;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace front;

// Namespace front
// Params 0
// Checksum 0x1a974f11, Offset: 0x404
// Size: 0x152
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    game[ "dialog" ][ "gametype" ] = "frontline";
    
    if ( getdvarint( @"scr_diehard" ) )
    {
        game[ "dialog" ][ "gametype" ] = "dh_" + game[ "dialog" ][ "gametype" ];
    }
    else if ( dvars::function_13909a5327c395b9( "promode" ) )
    {
        game[ "dialog" ][ "gametype" ] = game[ "dialog" ][ "gametype" ] + "_pro";
    }
    
    game[ "strings" ][ "overtime_hint" ] = &"mp/first_blood";
    thread spawnzonefx();
}

// Namespace front
// Params 0
// Checksum 0xcc2d9752, Offset: 0x55e
// Size: 0x88
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_3e97c6567fefc5bd", getmatchrulesdata( "frontData", "enemyBaseKillReveal" ) );
    setdynamicdvar( @"hash_49f985623f33a0c9", getmatchrulesdata( "frontData", "friendlyBaseScore" ) );
    setdynamicdvar( @"hash_d6b034d5a365754d", getmatchrulesdata( "frontData", "midfieldScore" ) );
    setdynamicdvar( @"hash_95adf40e176fdeca", getmatchrulesdata( "frontData", "enemyBaseScore" ) );
    setdynamicdvar( @"scr_front_promode", 0 );
}

// Namespace front
// Params 0
// Checksum 0xa5d20b5a, Offset: 0x5ee
// Size: 0x16c
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/front" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/front" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/front_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/front_hint" );
    }
    
    level.iconkill3d = "waypoint_capture_kill";
    level.iconkill2d = "waypoint_capture_kill";
    initspawns();
    base_setupvfx();
    thread setupbaseareabrushes();
    level.disablebuddyspawn = 1;
    
    /#
        thread function_c3aa60069c286a46();
    #/
}

// Namespace front
// Params 0
// Checksum 0xaf596909, Offset: 0x762
// Size: 0x6d
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.enemybasekillreveal = dvars::dvarfloatvalue( "enemyBaseKillReveal", 5, 0, 60 );
    level.friendlybasescore = dvars::dvarintvalue( "friendlyBaseScore", 1, 0, 25 );
    level.midfieldscore = dvars::dvarintvalue( "midfieldScore", 2, 0, 25 );
    level.enemybasescore = dvars::dvarintvalue( "enemyBaseScore", 1, 0, 25 );
}

// Namespace front
// Params 0
// Checksum 0xedb65ecb, Offset: 0x7d7
// Size: 0x22a
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ] );
        spawnlogic::function_3a25709674572ad6( #"primary", #"primary_attackers", spawnkey, "attacker", game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"primary", #"primary_defenders", spawnkey, "defender", game[ "defenders" ] );
    }
    else if ( spawnlogic::function_5cf82e30c52a895d( "tdm" ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", "tdm", spawnlogic::function_61ba521db28762a7(), game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", "tdm", spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ] );
        spawnlogic::function_3a25709674572ad6( #"primary", #"primary_attackers", "tdm", spawnlogic::function_61ba521db28762a7(), game[ "attackers" ] );
        spawnlogic::function_3a25709674572ad6( #"primary", #"primary_defenders", "tdm", spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ] );
    }
    else
    {
        spawnlogic::function_6dbabb72223a4bca();
        spawnlogic::addspawnpointslegacy( "allies", "mp_front_spawn_allies" );
        spawnlogic::addspawnpointslegacy( "axis", "mp_front_spawn_axis" );
        spawnlogic::setactivespawnlogic( #"default" );
        spawnlogic::registerspawnset( "allies", "mp_front_spawn_allies" );
        spawnlogic::registerspawnset( "axis", "mp_front_spawn_axis" );
        level.frontlinespawnsets = [];
        level.frontlinespawnsets[ "allies" ] = "allies";
        level.frontlinespawnsets[ "axis" ] = "axis";
    }
    
    spawnlogic::finalizemap();
}

// Namespace front
// Params 1
// Checksum 0xb554a1a9, Offset: 0xa09
// Size: 0xec
function onspawnplayer( revivespawn )
{
    if ( isplayer( self ) )
    {
        self.inenemybase = 0;
        self.infriendlybase = 0;
        self.outlinetime = 0;
        
        if ( isdefined( self.outlineid ) )
        {
            outline::outlinedisable( self.outlineid, self );
        }
        
        self.useoutline = 0;
        self.outlineid = undefined;
        thread friendlybasewatcher();
        thread enemybasewatcher();
        
        foreach ( zone in level.zones )
        {
            zone showbaseeffecttoplayer( self );
        }
    }
}

// Namespace front
// Params 0
// Checksum 0x79d83152, Offset: 0xafd
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace front
// Params 6
// Checksum 0x4fc86d5b, Offset: 0xb0f
// Size: 0x1a1
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    givescore = 0;
    
    if ( victim.infriendlybase || attacker.inenemybase )
    {
        attacker thread points::function_aa3f27bc29d005fc( #"hash_32c83db6a9b8dd6", objweapon );
        givescore = level.enemybasescore;
    }
    else if ( attacker.infriendlybase || victim.inenemybase )
    {
        attacker thread points::function_aa3f27bc29d005fc( #"hash_537f763990ad6bf3", objweapon );
        givescore = level.friendlybasescore;
    }
    else
    {
        attacker thread points::function_aa3f27bc29d005fc( #"hash_4c4afed94af7fd08", objweapon );
        givescore = level.midfieldscore;
    }
    
    targetscore = game[ "teamScores" ][ attacker.pers[ "team" ] ] + givescore;
    hitscorelimit = targetscore >= level.roundscorelimit;
    
    if ( hitscorelimit && level.roundscorelimit != 0 )
    {
        givescore = level.roundscorelimit - game[ "teamScores" ][ attacker.pers[ "team" ] ];
    }
    
    if ( givescore > 0 )
    {
        gamescore::giveteamscoreforobjective( attacker.pers[ "team" ], givescore, 0 );
        attacker thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", givescore ) );
    }
}

// Namespace front
// Params 2
// Checksum 0x682345f8, Offset: 0xcb8
// Size: 0xd2
function killstreakmultikill( killcount, var_bda53394c108f2e )
{
    assert( killcount > 1 );
    
    if ( !isdefined( self.var_eebd3151e89e5baa ) )
    {
        self.var_eebd3151e89e5baa = [];
    }
    
    if ( !isdefined( self.var_eebd3151e89e5baa[ var_bda53394c108f2e ] ) )
    {
        self.var_eebd3151e89e5baa[ var_bda53394c108f2e ] = killcount;
    }
    
    if ( killcount < self.var_eebd3151e89e5baa[ var_bda53394c108f2e ] )
    {
        return;
    }
    
    attackername = self.name;
    self notify( #"killstreakmultikill" );
    self endon( #"killstreakmultikill" );
    self endon( #"disconnect" );
    waitframe();
    self.var_eebd3151e89e5baa[ var_bda53394c108f2e ] = killcount;
    logstring( "Front_ReportKillstreakMultiKill " + attackername );
    challenges::front_reportkillstreakmultikill( self );
    self.var_eebd3151e89e5baa[ var_bda53394c108f2e ] = 0;
}

// Namespace front
// Params 0
// Checksum 0x1f1fb16, Offset: 0xd92
// Size: 0xc9
function enemybasekillreveal()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"enemybasekillreveal" );
    self endon( #"enemybasekillreveal" );
    
    if ( isdefined( self.basekilloutlineid ) )
    {
        outline::outlinedisable( self.basekilloutlineid, self );
    }
    
    self.basekilloutlineid = outline::outlineenableforteam( self, team_utility::getotherteam( self.team ), "outline_nodepth_orange", "perk" );
    
    if ( !isbot( self ) )
    {
        outline::_hudoutlineviewmodelenable( "outline_nodepth_orange", 0 );
    }
    
    self sethudtutorialmessage( &"mp/front_revealed", 1 );
    wait level.enemybasekillreveal;
    outline::outlinedisable( self.basekilloutlineid, self );
    outline::_hudoutlineviewmodeldisable();
    self clearhudtutorialmessage( 0 );
}

// Namespace front
// Params 0
// Checksum 0xdd0d2825, Offset: 0xe63
// Size: 0x437
function setupbases()
{
    level.zones = [];
    
    if ( game[ "switchedsides" ] )
    {
        level.allieszone = getentarray( "frontline_zone_allies", #targetname );
        
        foreach ( zone in level.allieszone )
        {
            zone.team = "axis";
            zone thread friendlybasewatcher();
            zone thread enemybasewatcher();
            zone thread enemybasekillstreakwatcher();
        }
        
        thread setupvisuals( level.allieszone[ 0 ] );
        level.zones[ level.zones.size ] = level.allieszone[ 0 ];
        level.axiszone = getentarray( "frontline_zone_axis", #targetname );
        
        if ( level.mapname == "mp_junk" )
        {
            var_3a8ea90b4de7eff5 = spawn( "trigger_radius", ( -1410, -2080, 240 ), 0, 1000, 600 );
            level.axiszone[ level.axiszone.size ] = var_3a8ea90b4de7eff5;
        }
        
        foreach ( zone in level.axiszone )
        {
            zone.team = "allies";
            zone thread friendlybasewatcher();
            zone thread enemybasewatcher();
            zone thread enemybasekillstreakwatcher();
        }
        
        thread setupvisuals( level.axiszone[ 0 ] );
        level.zones[ level.zones.size ] = level.axiszone[ 0 ];
        return;
    }
    
    level.allieszone = getentarray( "frontline_zone_allies", #targetname );
    
    foreach ( zone in level.allieszone )
    {
        zone.team = "allies";
        zone thread friendlybasewatcher();
        zone thread enemybasewatcher();
        zone thread enemybasekillstreakwatcher();
    }
    
    thread setupvisuals( level.allieszone[ 0 ] );
    level.zones[ level.zones.size ] = level.allieszone[ 0 ];
    level.axiszone = getentarray( "frontline_zone_axis", #targetname );
    
    if ( level.mapname == "mp_junk" )
    {
        var_3a8ea90b4de7eff5 = spawn( "trigger_radius", ( -1410, -2080, 240 ), 0, 1000, 600 );
        level.axiszone[ level.axiszone.size ] = var_3a8ea90b4de7eff5;
    }
    
    foreach ( zone in level.axiszone )
    {
        zone.team = "axis";
        zone thread friendlybasewatcher();
        zone thread enemybasewatcher();
        zone thread enemybasekillstreakwatcher();
    }
    
    thread setupvisuals( level.axiszone[ 0 ] );
    level.zones[ level.zones.size ] = level.axiszone[ 0 ];
}

// Namespace front
// Params 1
// Checksum 0x6533b0c2, Offset: 0x12a2
// Size: 0xa1
function setupvisuals( zone )
{
    assert( isdefined( zone ) );
    visuals = [];
    visuals[ 0 ] = zone;
    
    if ( isdefined( zone.target ) )
    {
        othervisuals = getentarray( zone.target, #targetname );
        
        for ( j = 0; j < othervisuals.size ; j++ )
        {
            visuals[ visuals.size ] = othervisuals[ j ];
        }
    }
    
    visuals = mappatchborders( visuals, zone.target );
    zone.visuals = visuals;
}

// Namespace front
// Params 2
// Checksum 0x6b5c8cc1, Offset: 0x134b
// Size: 0xd3
function mappatchborders( visuals, targetname )
{
    if ( level.mapname == "mp_parkour" && targetname == "front_vis_axis" )
    {
        ent1 = spawn( "script_origin", ( -1088, -1504, 136 ) );
        ent1.angles = ( 0, 180, 0 );
        ent1.targetname = targetname;
        visuals[ visuals.size ] = ent1;
        ent2 = spawn( "script_origin", ( -1088, -1440, 136 ) );
        ent2.angles = ( 0, 180, 0 );
        ent1.targetname = targetname;
        visuals[ visuals.size ] = ent2;
    }
    
    return visuals;
}

// Namespace front
// Params 0
// Checksum 0x22410323, Offset: 0x1427
// Size: 0x7e
function friendlybasewatcher()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player.team != self.team )
        {
            continue;
        }
        
        if ( player.infriendlybase )
        {
            continue;
        }
        
        player thread friendlybasetriggerwatcher( self );
    }
}

// Namespace front
// Params 1
// Checksum 0xb01d8fb5, Offset: 0x14ad
// Size: 0x156
function friendlybasetriggerwatcher( trigger )
{
    self notify( #"hash_79d59bf504382ff6" );
    self endon( #"hash_79d59bf504382ff6" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( game[ "switchedsides" ] )
    {
        if ( self.team == "allies" )
        {
            triggers = level.axiszone;
        }
        else
        {
            triggers = level.allieszone;
        }
    }
    else if ( self.team == "allies" )
    {
        triggers = level.allieszone;
    }
    else
    {
        triggers = level.axiszone;
    }
    
    while ( true )
    {
        self.infriendlybase = 0;
        
        foreach ( trigger in triggers )
        {
            if ( self istouching( trigger ) )
            {
                self.infriendlybase = 1;
                break;
            }
        }
        
        if ( !self.infriendlybase )
        {
            if ( self.spawnprotection )
            {
                common::function_6b65663570bf5d41();
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace front
// Params 0
// Checksum 0x4ff57137, Offset: 0x160b
// Size: 0x9c
function enemybasewatcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player.team == self.team )
        {
            continue;
        }
        
        if ( isalive( player ) && isdefined( player.sessionstate ) && player.sessionstate != "spectator" || playercontrolledstreak( player ) )
        {
            player.inenemybase = 1;
            player thread enemybasetriggerwatcher( self );
        }
    }
}

// Namespace front
// Params 1
// Checksum 0x2928dd68, Offset: 0x16af
// Size: 0x7f
function enemybasetriggerwatcher( trigger )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.useoutline )
    {
        return;
    }
    
    while ( true )
    {
        if ( isdefined( self ) && self istouching( trigger ) )
        {
            if ( !self.useoutline )
            {
                thread enableenemybaseoutline();
            }
        }
        else
        {
            self.useoutline = 0;
            self.inenemybase = 0;
            thread disableenemybaseoutline();
            break;
        }
        
        waitframe();
    }
}

// Namespace front
// Params 0
// Checksum 0x3038bf30, Offset: 0x1736
// Size: 0x61
function enableenemybaseoutline()
{
    self.useoutline = 1;
    self.outlinetime = gettime();
    self.outlineid = outline::outlineenableforteam( self, team_utility::getotherteam( self.team ), "outline_nodepth_orange", "perk" );
    
    if ( !isbot( self ) )
    {
        if ( isplayer( self ) )
        {
            outline::_hudoutlineviewmodelenable( "outline_nodepth_orange", 0 );
        }
    }
}

// Namespace front
// Params 0
// Checksum 0xa43a802e, Offset: 0x179f
// Size: 0x40
function disableenemybaseoutline()
{
    self.useoutline = 0;
    outline::outlinedisable( self.outlineid, self );
    self.outlineid = undefined;
    
    if ( !isbot( self ) && isplayer( self ) )
    {
        outline::_hudoutlineviewmodeldisable();
    }
}

// Namespace front
// Params 0
// Checksum 0xb1778696, Offset: 0x17e7
// Size: 0xa4
function enemybasekillstreakwatcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.turrets.size > 0 )
        {
            foreach ( turret in level.turrets )
            {
                handleoutlinesforstreaks( turret );
            }
        }
        
        wait 0.1;
    }
}

// Namespace front
// Params 1
// Checksum 0x57e70403, Offset: 0x1893
// Size: 0xa1
function handleoutlinesforstreaks( streak )
{
    if ( streak.owner.team == self.team )
    {
        return;
    }
    
    if ( streak istouching( self ) )
    {
        if ( !isdefined( streak.outlineid ) )
        {
            streak.outlineid = outline::outlineenableforteam( streak, self.team, "outline_nodepth_orange", "lowest" );
        }
        
        return;
    }
    
    if ( isdefined( streak.outlineid ) )
    {
        outline::outlinedisable( streak.outlineid, streak );
        streak.outlineid = undefined;
    }
}

// Namespace front
// Params 1
// Checksum 0x17c44610, Offset: 0x193c
// Size: 0x1e, Type: bool
function playercontrolledstreak( player )
{
    if ( isdefined( player.streakname ) )
    {
        return false;
    }
    
    return false;
}

// Namespace front
// Params 1
// Checksum 0x6dc2896d, Offset: 0x1963
// Size: 0x103
function showbaseeffecttoplayer( player )
{
    zoneteam = self.team;
    effect = undefined;
    viewerteam = player.team;
    
    if ( !isdefined( viewerteam ) )
    {
        viewerteam = "allies";
    }
    
    iscodcaster = player iscodcaster();
    
    if ( iscodcaster )
    {
        viewerteam = player getcodcasterteam();
    }
    else if ( viewerteam == "spectator" )
    {
        viewerteam = "allies";
    }
    
    friendlyfx = level.basefxid[ "friendly" ];
    enemyfx = level.basefxid[ "enemy" ];
    
    if ( viewerteam == zoneteam )
    {
        showfxarray( self._baseeffectfriendly, player );
        hidefxarray( self._baseeffectenemy, player );
        return;
    }
    
    showfxarray( self._baseeffectenemy, player );
    hidefxarray( self._baseeffectfriendly, player );
}

// Namespace front
// Params 2
// Checksum 0xaf92f005, Offset: 0x1a6e
// Size: 0x3a
function showfxarray( array, player )
{
    for ( i = 0; i < array.size ; i++ )
    {
        array[ i ] showtoplayer( player );
    }
}

// Namespace front
// Params 2
// Checksum 0x5e18959b, Offset: 0x1ab0
// Size: 0x3a
function hidefxarray( array, player )
{
    for ( i = 0; i < array.size ; i++ )
    {
        array[ i ] hidefromplayer( player );
    }
}

// Namespace front
// Params 0
// Checksum 0xc3a9955, Offset: 0x1af2
// Size: 0x182
function spawnfxarray()
{
    self._baseeffectfriendly = [];
    self._baseeffectenemy = [];
    
    for ( i = 1; i < self.visuals.size ; i++ )
    {
        fxfwd = anglestoforward( self.visuals[ i ].angles );
        self._baseeffectfriendly[ self._baseeffectfriendly.size ] = spawnfx( level.basefxid[ "friendly" ], self.visuals[ i ].origin, fxfwd );
        self._baseeffectfriendly[ self._baseeffectfriendly.size - 1 ] setfxkilldefondelete();
        triggerfx( self._baseeffectfriendly[ self._baseeffectfriendly.size - 1 ] );
    }
    
    for ( i = 1; i < self.visuals.size ; i++ )
    {
        fxfwd = anglestoforward( self.visuals[ i ].angles );
        self._baseeffectenemy[ self._baseeffectenemy.size ] = spawnfx( level.basefxid[ "enemy" ], self.visuals[ i ].origin, fxfwd );
        self._baseeffectenemy[ self._baseeffectenemy.size - 1 ] setfxkilldefondelete();
        triggerfx( self._baseeffectenemy[ self._baseeffectenemy.size - 1 ] );
    }
}

// Namespace front
// Params 0
// Checksum 0x2de726c0, Offset: 0x1c7c
// Size: 0x34
function base_setupvfx()
{
    level.basefxid[ "friendly" ] = loadfxasset( "vfx_core_mp_front_border_cyan" );
    level.basefxid[ "enemy" ] = loadfxasset( "vfx_core_mp_front_border_orng" );
}

// Namespace front
// Params 0
// Checksum 0xf23decac, Offset: 0x1cb8
// Size: 0x7c
function spawnzonefx()
{
    waitframe();
    
    foreach ( zone in level.zones )
    {
        zone spawnfxarray();
    }
}

// Namespace front
// Params 1
// Checksum 0x8f6ab0e8, Offset: 0x1d3c
// Size: 0x86
function onplayerconnect( player )
{
    foreach ( zone in level.zones )
    {
        zone showbaseeffecttoplayer( player );
    }
}

// Namespace front
// Params 0
// Checksum 0x854867cf, Offset: 0x1dca
// Size: 0xb8
function setupbaseareabrushes()
{
    var_2a97396288057297 = getbasearray( "front_zone_visual_allies_contest" );
    var_d97a9dfee765e986 = getbasearray( "front_zone_visual_axis_contest" );
    var_7e1f588704776b59 = getbasearray( "front_zone_visual_allies_friend" );
    var_74a08a79ed524148 = getbasearray( "front_zone_visual_axis_friend" );
    var_6d7782697dcaf0cc = getbasearray( "front_zone_visual_allies_enemy" );
    var_8a837e89a3f1179d = getbasearray( "front_zone_visual_axis_enemy" );
    hidebasebrushes( var_2a97396288057297 );
    hidebasebrushes( var_d97a9dfee765e986 );
    hidebasebrushes( var_7e1f588704776b59 );
    hidebasebrushes( var_74a08a79ed524148 );
    hidebasebrushes( var_6d7782697dcaf0cc );
    hidebasebrushes( var_8a837e89a3f1179d );
}

// Namespace front
// Params 1
// Checksum 0x80891281, Offset: 0x1e8a
// Size: 0x36
function hidebasebrushes( brush )
{
    if ( isdefined( brush ) )
    {
        for ( index = 0; index < brush.size ; index++ )
        {
            brush[ index ] hide();
        }
    }
}

// Namespace front
// Params 1
// Checksum 0x175bf609, Offset: 0x1ec8
// Size: 0x3a
function getbasearray( targetname )
{
    zones = getentarray( targetname, #targetname );
    
    if ( !isdefined( zones ) || zones.size == 0 )
    {
        return;
    }
    
    return zones;
}

/#

    // Namespace front
    // Params 0
    // Checksum 0x2a7a75dc, Offset: 0x1f0b
    // Size: 0xa2, Type: dev
    function function_c3aa60069c286a46()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x24>", getdvarint( @"scr_give_score_allies" ), 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x2b>", getdvarint( @"scr_give_score_axis" ), 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_c3aa60069c286a46();
    }

#/
